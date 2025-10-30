from shared import *

# post-conversion automatic patches, allowing not to change the asm file by hand



input_dict = {"system_3300":"read_system_inputs",
"in0_3301":"read_inputs_1",
"in1_3302":"read_inputs_2",
"speech_4000":"set_speech_status",
"speech_6000":"get_speech_status",
"scroll_dir_2042":"set_scroll_direction",
"audio_register_w_1500":"sound_start",

}

nb_cases_dict = {0x9538:15,
0xa0cc:4,
0xa281:8,
0xabe2:23,

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

        address = get_line_address(line)

        if address in [0xe5c0,0xe951]:
            line = remove_error(line)


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