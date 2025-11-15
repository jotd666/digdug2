##* layout is as follows:
##*** top status *** unrotated X,Y, X decreasing, Y increasing by $20
##* $7DD: 0,0 => $7C2: 27,0
##* $7FD: 0,1 => $7F2: 27,1
##*** main playfield: rotated X,Y, X decreasing by $20, Y increasing by 1
##* $360: 28,2  => $000: 55,2 right screen
##* $361: 28,3  => $001: 55,3
##* ...
##* $37F: 18,31 => $01F: 55,31
##*
##* $760: 0,2  => $400: 27,2 left screen
##* ...
##* $77F: 0,31 => $41F: 27,31 left screen
##
##*** bottom status *** unrotated X,Y, X decreasing, Y increasing by $20
##* with more wierdness
##* $781: 12,32 $780: 13,32
##* $78F: 14,32 => $782: 27,32
##* $79E: 0,32 => $792: 11,32
##* row 33: same with $20 added to all addresses

import shared
import bitplanelib

# it is so crazy that I decided to generate it instead of pre-computing it in the asm code
# as it would take maybe 1 or 2 hours to code properly for zero benefit

address_table = [(0,0)] * 0x800

# top status
for y,line_offset in enumerate(range(0,0x40,0x20)):
    start = 0x7DD+line_offset
    x = 0
    for i in range(start,start-28,-1):
        address_table[i] = (x,y)
        x += 1
# main playfield

for screen_part in [0,1]:
    screen_offset = 0 if screen_part == 1 else 0x400
    x_offset = 0 if screen_part == 0 else 28

    x_offset = 0
    for line_offset,y in enumerate(range(0,32),2):
        start = 0x360+line_offset+screen_offset
        x = x_offset
        for i in range(start,start-28*32,-0x20):
            address_table[i] = (x,y)
            x += 1

# bottom status
for y,line_offset in enumerate(range(0,0x40,0x20)):
    y += 32
    start = 0x78F+line_offset
    x = 14
    for i in range(start,start-14,-1):
        address_table[i] = (x,y)
        x += 1
    start = 0x79E+line_offset
    x = 0
    for i in range(start,start-14,-1):
        address_table[i] = (x,y)
        x += 1
    address_table[line_offset+0x780] = (13,y)
    address_table[line_offset+0x781] = (12,y)
    address_table[line_offset+0x790] = (60,0)  # seems not visible
    address_table[line_offset+0x791] = (60,0)

# transform coordinates
dumpable_table = []
for a in address_table:
    dumpable_table.append(a[0])
    dumpable_table.append(a[1]*8)  # pre-multiply Y by 8

with open(shared.amiga_source_dir / "tiles_layout.68k","w") as f:
    bitplanelib.dump_asm_bytes(dumpable_table,f,mit_format=True,size=2)
