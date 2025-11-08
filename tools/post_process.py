from shared import *

# post-conversion automatic patches, allowing not to change the asm file by hand



input_dict = {"system_3300":"read_system_inputs",
"in0_3301":"read_inputs_1",
"in1_3302":"read_inputs_2",
"speech_4000":"set_speech_status",
"speech_6000":"get_speech_status",
"scroll_dir_2042":"set_scroll_direction",
"audio_register_w_1500":"sound_start",
"watchdog_8000":"",
"namco_io_4800":"",  # sound?
"unknown_4802":"read_4802",
"video_stuff_5009" : "",
"video_stuff_5008" : "",
"video_stuff_5002" : "",
"video_stuff_5003" : "",
"video_stuff_5004" : "",
"video_stuff_500b" : "",
"video_stuff_500a" : "",
"io_register_4818" : ""


}

nb_cases_dict = {0x9538:14,
0xa0cc:4,
0xa281:8,
0xabe2:22

}

def get_line_address(line):
    try:
        toks = line.split("|")
        address = toks[1].strip(" [$").split(":")[0]
        return int(address,16)
    except (ValueError,IndexError):
        return None


# various dirty but at least automatic patches applying on the specific track and field code
with open(source_dir / "conv.s") as f:
    lines = list(f)
    i = 0

    while i < len(lines):
        line = lines[i]
        if " = " in line:
            equates.append(line)
            line = ""

##        # remove code for rom checks, watchdog, ...
##        for p in ("[rom_check_code]","coin_","watchdog_3300"):
##            line = remove_code(p,lines,i)

        # pre-add video_address tag if we find a store instruction to an explicit 3000-3FFF address
        if store_to_video.search(line):
            line = line.rstrip() + " [video_address]\n"


        if "[unchecked_address" in line:
            line = line.replace("_ADDRESS","_UNCHECKED_ADDRESS")
        if "[video_address" in line:
            # give me the original instruction
            line = line.replace("_ADDRESS","_UNCHECKED_ADDRESS")
            # if it's a write, insert a "VIDEO_DIRTY" macro after the write
            for j in range(i+1,len(lines)):
                next_line = lines[j]
                if "[...]" not in next_line:
                    break
                if ",(a0)" in next_line or "clr" in next_line or "MOVE_W_FROM_REG" in next_line:
                    if any(x in next_line for x in ["address_word","MOVE_W_FROM_REG"]):
                        lines[j] = next_line+"\tVIDEO_WORD_DIRTY | [...]\n"
                    else:
                        lines[j] = next_line+"\tVIDEO_BYTE_DIRTY | [...]\n"
                    break


        line = re.sub(tablere,subt,line)

        line = line.replace(".long\tl_2098",".long\t-1")  # remove bogus address

        address = get_line_address(line)

        if address in [0xe5c0,0xe951]:
            line = remove_error(line)
        elif address == 0xE7B4:
            line = remove_instruction(lines,i)  # remove sync loop
        elif address == 0x8153:
            # we have to patch natively: the game saves return address in a 16-bit buffer
            # (kind of task switch)
            # we emulate that but for that we need a 32 bit buffer
            # save_reset_stack_and_jump_8150:
            # 8150: BE 10 02       LDX    task_stack_array_1002
            # 8153: 10 EF 84       STS    ,X
            # 8156: 10 CE 18 FE    LDS    #$18FE        ; pop all addresses except the first one
            # 815A: 39             RTS
            # that would be hell to implement
            # so it's better to encode the real address in 16 bits

            line = "\tmove.l\t(a7),d0\n\tENCODE_NATIVE_ADDRESS\td0\n\tGET_REG_ADDRESS\t0,d2\n"+change_instruction("MOVE_W_FROM_REG\td0,a0",lines,i)
        elif address == 0x8156:
            # set stack to the top, read the value there
            line += "\tGET_REG_ADDRESS\t0,d5\n\tMOVE_W_TO_REG\ta0,d6\n\tDECODE_NATIVE_ADDRESS\td6\n"
            # then really set the actual stack to the top and push address there to simulate unwind
            line += "\tlea\tstack_top-4,a7\n\tmove.l\td6,-(a7)\n"
        elif address in {0x8191,0x816e}:
            if ">>" in line:
                line = remove_instruction(lines,i)  # useless/irrelevant
            else:
                # the value is an actual real address => read as long, then encode
                line = line.replace("move.w","move.l") + "\tENCODE_NATIVE_ADDRESS\td1\n"
        elif address == 0x8199:
            line = change_instruction("jra\tunwind_stack_8156",lines,i)  # same (modified) code

        elif address == 0xE7BB:
            line = line.replace("eq","ra")  # force test
        elif address == 0x818D:
            line += "\tjra\tset_native_stack\n"
        elif address in {0x8072,0xE666}:
            line = change_instruction("lea\tstack_top,a7",lines,i)

        elif address in {0x8012,0x800f}:
            line = remove_instruction(lines,i)
        elif address == 0X80C9:
            line = change_instruction("jra\tend_of_io_stuff_80e6",lines,i)

        elif address == 0xE703:
            line = change_instruction("jra\tend_io_regs_clear_e710",lines,i)
        elif address == 0xE76B:
            line = change_instruction("jra\tend_write_4810_zone_e77a",lines,i)
        elif address == 0xEA17:
            line = change_instruction("rts",lines,i)
        elif address == 0xE5CE:
            # skip ram/rom test
            line = change_instruction("jra\tend_of_memory_clear_e666   | skip ROM/RAM test & memory clear",lines,i)
        elif address == 0xE67A:
            # skip ram/rom test & custom io clear
            line = "\tmoveq\t#0,d0\n"+change_instruction("jra\tcontinue_boot_e6c9   | skip ROM checksum",lines,i)

        if "GET_ADDRESS" in line:
            val = line.split()[1]
            osd_call = input_dict.get(val)
            if osd_call is not None:
                if osd_call:
                    line = change_instruction(f"jbsr\tosd_{osd_call}",lines,i)
                else:
                    line = remove_instruction(lines,i)
                lines[i+1] = remove_instruction(lines,i+1)


        elif "unsupported instruction rti" in line:
            line = change_instruction("rts",lines,i)

        elif "[indirect_jump]" in line:
            m = jmpre.search(line)
            if m:
                ireg = m.group(2).upper()  # A or B
                inst = m.group(1).upper()
                reg = {"x":"A2","y":"A3","u":"A4"}[m.group(3)]
                rest = re.sub(".*\"","",line)
                nb_cases = nb_cases_dict[address]
                line = f"\t{inst}_{ireg}_INDEXED\t{reg},{nb_cases}{rest}"
        if "ERROR" in line:
            print(line,end="")
        lines[i] = line
        i+=1




with open(source_dir / "data.inc","w") as fw:
    fw.writelines(equates)

with open(source_dir / "digdug2.68k","w") as fw:
    fw.write("""\t.include "data.inc"
\t.global\tirq_8000
\t.global\treset_e5ba
""")
    fw.writelines(lines)