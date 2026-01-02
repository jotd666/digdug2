import re,os
from shared import change_instruction

src = "../src/digdug2.68k"
# this is a "generic" 68000 code optimizer that removes unnecessary address loads
# generated naively by the 6809 converter
dest = os.path.basename(src)
nb = 0
prev_loaded = None
with open(src) as f:
    lines = list(f)

new_lines = []
push_labels = []
for i,line in enumerate(lines):
    if line.strip().startswith(("PUSH_SR","SET_C_FROM_X","SET_X_FROM_C","SET_X_FROM_CLEARED_C")):
        # all those macros contain "move.w  sr,-(a7)" in 68000
        label = f"push_sr_{i:03}"
        line = f"{label}:\n{line}"
        push_labels.append(label)
    new_lines.append(line)

with open(dest,"w") as f:
    f.write("\t.global\tpush_sr_table\n")
    f.write("push_sr_table:\n")
    for t in push_labels:
        f.write(f"\t.long\t{t}\n")
    f.write("\t.long\t0\n\n")

    f.writelines(new_lines)