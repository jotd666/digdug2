from shared import *
import re

# post-conversion automatic patches, allowing not to change the asm file by hand

sound_mem_regex = re.compile("\w+_(40[45]\w)")

input_dict = {"system_3300":"read_system_inputs",
"watchdog_8000":"",
"video_stuff_5009" : "",
"video_stuff_5008" : "",
"video_stuff_5002" : "",
"video_stuff_5003" : "",
"video_stuff_5004" : "",
"video_stuff_500b" : "",
"video_stuff_500a" : ""


}

nb_cases_dict = {0x9538:14,
0xa0cc:7,
0xa281:7,
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
equates_re = re.compile("(\w+)\s*=\s*(\S+)")
with open(source_dir / "conv.s") as f:
    lines = list(f)
    i = 0

    while i < len(lines):
        line = lines[i]
        m = equates_re.match(line)
        if m:
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
        line = line.replace(".long\tl_0000",".long\t-1")  # remove bogus address

        address = get_line_address(line)

        if address in [0xe5c0,0xe951]:
            line = remove_error(line)
        elif address == 0xE7B4:
            line = remove_instruction(lines,i)  # remove sync loop

        elif address in {0x8132,0x8141}:
            line = remove_instruction(lines,i)  # remove useless task switch that does nothing
        elif address == 0x8153:
            line = """\tmove.l\ta7,d0     | get current stack
\tsub.l\t#stack_top,d0          | convert to offset
\tGET_REG_ADDRESS\t0,d2         | get stack pointers buffer real address
\tmove.w\td0,(a0)               | store to stack pointers buffer ($18xx)
\tmoveq\t#0,d0                  | so D0 MSB is 0
* continue to unwind_stack, return to main task scheduler
"""
        elif address == 0x8f67:
            line = change_instruction("lea\tstack_top+2*TASK_STACK_SIZE-4,a2   | second stack buffer almost top",lines,i)
        elif address == 0x8f73:
            line = """\tmove.l\t(a3)+,d0                     | [$8f73: ldd    ,y++] get address from table
\tmove.l\td0,(a2)                       | [$8f75: std    ,x] put start address on top of task stack
\tadd.w\t#TASK_STACK_SIZE,a2                      | [$8f77: leax   $10,x] next stack buffer
"""
            j = i+1
            # remove existing code until loop counter check
            while ("0x1009" not in lines[j]):
                lines[j] = ""
                j+=1
        elif address == 0x8156:
            # set stack to the top, read the value there
            line = change_instruction("lea\tstack_top-4,a7",lines,i)
        elif address in {0x816e,0x80B6}:
            if ">>" in line:
                line = remove_instruction(lines,i)  # useless/irrelevant
            else:
                # the value is an actual real address => read as long, then encode
                line = line.replace("move.w","move.l")
                if "MAKE_D" in lines[i+1]:
                    lines[i+1] = ""
        elif address == 0x80b9:
            # set startup task in stack
            line = """\tlea\tstack_top,a0
\tmove.l\td1,(TASK_STACK_SIZE-4,a0)
"""
            lines[i+1] = ""
        elif address == 0x8173:
            # instead of storing indirect in 18xx (so in stack areas 19xx), read in 18xx, convert to
            # real stack address then store d1 (inactive task routine) in the real stack buffer
            lines[i+1] = """\tmove.w\td4,d6
\tsub.w\t#0x191E,d6 | remove stack buffer base (plus 0x10) to get values 0,0x10,0x20...
\tlsl.w\t#TASK_STACK_BITSHIFT-4,d6      | 256 bytes per task instead of 16 (so we can call osd_xxx functions safely)
\tadd.w\t#TASK_STACK_SIZE-4,d6   | native stack offset in stack buffer (based on stack_top)
\tmove.w\td6,(a0)   | store offset instead of address
\tmove.w\td6,a0
\tadd.l\t#stack_top,a0  | real stack address
\tmove.l\td1,(a0)       | store inactive task in stack
\trts\n            | skip rest of code
"""
        elif address == 0x8191:
            # replace part of "inactive_task_8191"
            line = """* complete rewrite to avoid stack overwrite issues
* as when using the macros and possibly debug/osd/trace calls, the stack is used
* which isn't the case in the original implementation
\tlea    stack_top-4,a7  | change stack now to task scheduler stack so routine doesn't corrupt itself
\tmove.l\t#reset_stack_and_jump_8199,d1
\tGET_ADDRESS\ttask_stack_pointer_1002
\tmoveq\t#0,d6
\tmove.w\t(a0),d6
\tGET_REG_ADDRESS\t0,d6
\tmove.w\t(a0),d6
\tadd.l\t#stack_top,d6
\tmove.l\td6,a0
\tmove.l\td1,(a0)    | set reset routine in task stack
\trts   | and return to task scheduler loop

"""
            j = i+1
            while (not lines[j].startswith("reset_stack_and_jump_8199")):
                lines[j] = ""
                j+=1

        elif address == 0x81DF:
            # skip zero of namco io buffers
            line = change_instruction("jra\tend_zero_io_81f6",lines,i)
        elif address == 0x9AD6:
            # insert highscore read
            line = "\tjbsr\tosd_read_high_scores\n"+line
        elif address == 0x9AB8:
            # insert highscore read
            line = "\tjbsr\tosd_write_high_scores\n"+line

        elif address == 0x8169:
            # end of zero_and_init_stack_zone_815b. Setting return address in the buffer is not useful
            # and would waste a lot of native stack so skip it. Just add 0x10 to U and that's it
            line += "\tadd.w    #0x10,d4  | move buffer pointer by $10 bytes\n\trts  | no need to init stack stuff\n"
        elif address == 0x8199:
            line = change_instruction("jra\tunwind_stack_8156",lines,i)  # same (modified) code

        elif address == 0xE7BB:
            line = line.replace("eq","ra")  # force test
        elif address == 0x818D:
            line += """* (a0) contains the encoded stack pointer
\tmoveq\t#0,d6
\tmove.w\t(a0),d6
\tadd.l\t#stack_top,d6   | convert to real pointer
\tmove.l\td6,a7
"""
            lines[i+1] = ""
        elif address in {0x8072,0xE666}:
            line = change_instruction("lea\tstack_top,a7",lines,i)

        elif address in {0x8012,0x800f}:
            line = remove_instruction(lines,i)

        elif address == 0xabfd:
            line = f"""\ttst.b\tinvincible_flag
\tjne\tl_ac39
{line}"""
        elif address == 0xb2fb:
            line = f"""\ttst.b\tinvincible_flag
\tjne\tl_b32a
{line}"""

        elif address == 0x844a:
            line = f"""\ttst.b\tinfinite_lives_flag
\tjne\t0f
{line}{lines[i+1]}{lines[i+2]}0:
"""
            lines[i+1]=""
            lines[i+2]=""

        elif address == 0xE703:
            line = change_instruction("jra\tend_io_regs_clear_e710",lines,i)
        elif address == 0xE76B:
            line = change_instruction("jra\tend_write_4810_zone_e77a",lines,i)
        elif address == 0xEA17:
            line = change_instruction("rts",lines,i)
        elif address == 0xE5CE:
            # skip ram/rom test
            line = change_instruction("jra\tend_of_memory_clear_e666   | skip ROM/RAM test & memory clear",lines,i)
        elif address == 0xaaf5:
            line = f"""\t.ifdef\tOPT_FIX_RANDOM
\tmoveq\t#0,d0
\t.else
{line}\t.endif
"""
        elif address == 0x8aa0:
            line = f"""\t.ifdef\tOPT_FIX_RANDOM
\tmoveq\t#0,d0
\trts
\t.else
{line}\t.endif
"""

        elif address == 0xE67A:
            # skip ram/rom test & custom io clear
            line = "\tmoveq\t#0,d0\n"+change_instruction("jra\tcontinue_boot_e6c9   | skip ROM checksum",lines,i)

        # block interrupts so they only are allowed in the sync loop. Reduces "character jump" bugs
        elif address == 0x80be:
            line = change_instruction("CLR_I_FLAG",lines,i)
        elif address == 0x80C9:
            line = "\tSET_I_FLAG   | block interrupts to avoid conflicts with irq & sprite position update\n"+line
            # but it's not enough to eliminate the bugs completely so we perform the character position copy op in
            # the loop instead of in the interrupt, and it works! at least!
            lines[i+1] = """    GET_ADDRESS    characters_can_move_2500       | [$8058: lda    characters_can_move_2500]
    move.b    (a0),d0
    jeq    0f                                 | [beq    $8060]
    jbsr    copy_character_positions_8e81         | doing the copy outside the interrupt!
0:
    jra end_of_io_stuff_80e6
"""+lines[i+1]
        elif address == 0x8058:
            # remove the copy character from interrupt
            line = remove_instruction(lines,i)
            lines[i+2] = remove_instruction(lines,i+2)
            lines[i+3] = remove_instruction(lines,i+3)
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

        m = sound_mem_regex.search(line)
        if m:
            toks = line.split()
            if "inc" in toks:
                # INC sound_44xx: enabling sfx
                lines[i+1] += "\tjbsr\tplay_sound\n"
            elif "sta" in toks or "stb" in toks:
                # STA sound_44xx: enabling or disabling sfx
                lines[i+1] += "\tjbsr\tsound_control\n"
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

play_sound:
    move.l  d0,-(a7)
    move.l  a0,d0
    sub.l   a6,d0
    sub.w   #0x403F,d0
    jbsr    osd_sound_start
    move.l  (a7)+,d0
    rts

sound_control:
    tst.b   d0
    jeq     0f
    jbsr    play_sound
0:
    rts

""")
    fw.writelines(lines)