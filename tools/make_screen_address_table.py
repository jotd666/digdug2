##* layout is as follows:
##*** top status *** unrotated X,Y, X decreasing, Y increasing by $20
##* $7DD: 0,0 => $7C2: 27,0
##* $7FD: 0,1 => $7F2: 27,1
##*** main playfield: rotated X,Y, X decreasing by $20, Y increasing by 1
##* $760: 0,2  => $000: 59,2 right screen
##* ...
##* $77F: 0,33 => $01F: 59,33
##
##*** bottom status *** unrotated X,Y, X decreasing, Y increasing by $20
##* with more wierdness
##* $781: 34,34 $780: 13,34
##* $78F: 36,34 => $782: 59,34
##* $79D: 32,34 => $792: 43,34
##* row 35: same with $20 added to all addresses

# this is a portrait game with 288 pixel vertical resolution, which is a little too much
# for amiga

import shared
import bitplanelib
import collections

# it is so crazy that I decided to generate it instead of pre-computing it in the asm code
# as it would take maybe 1 or 2 hours to code properly in assembly for zero benefit

INVALID_XY = (-1,-1)

address_table = [INVALID_XY] * 0x800

def set_value(offset,value):
    if value != INVALID_XY and address_table[offset] != INVALID_XY and offset not in [0x780,0x781,0x791,0x7B1]:
        print(f"Already defined: {offset:04x} old={address_table[offset]} new={value}")
        return
    address_table[offset] = value

# top status
for y,line_offset in enumerate(range(0,0x40,0x20)):
    start = 0x7DD+line_offset
    x = 32
    for i in range(start,start-32,-1):
        set_value(i,(x,y))
        x += 1
# main playfield

for y,line_offset in enumerate(range(0,32),2):
    start = 0x760+line_offset
    x = 0
    for x,i in enumerate(range(start,start-60*32,-0x20)):
        set_value(i,(x,y))



##* $781: 44,34 $780: 45,34
##* $78F: 46,34 => $782: 59,34
##* $79D: 32,34 => $792: 43,34
##* row 35: same with $20 added to all addresses

x_offset = 32
# bottom status
for y,line_offset in enumerate([0,0x20],2):
    y += 32
    # kludge on bottom right so ROUND and CREDIT are displayed higher so amiga
    # can display it (else it's cut at Y=285)
    # non-amiga version could retain the 0x78F+line_offset formula for this part
    start = 0x78F+(0x20-line_offset)
    x = 14+x_offset
    for i in range(start,start-14,-1):
        set_value(i,(x,y))
        x += 1
    start = 0x79D+line_offset
    x = x_offset
    for i in range(start,start-14,-1):
        set_value(i,(x,y))
        x += 1
    set_value(line_offset+0x780,(13+x_offset,y))
    set_value(line_offset+0x781,(12+x_offset,y))
    set_value(line_offset+0x790,(INVALID_XY))  # seems not visible
    set_value(line_offset+0x791,(INVALID_XY))

# not shown H/20 in top status bar (too far to the left to show)
set_value(0x7C1,(INVALID_XY))  # seems not visible
set_value(0x7E0,(INVALID_XY))
set_value(0x7E1,(INVALID_XY))

# check for overlapping entries
d = collections.defaultdict(set)
for address,value in enumerate(address_table):
    d[value].add(address)

for k,v in d.items():
    if k != INVALID_XY and len(v)>1:
        result = ",".join(hex(t) for t in v)
        print("coord {} defined for {}".format(k,result))

invalid_count = sum(a == INVALID_XY for a in address_table)
print(f'Invalid addresses: {invalid_count}')
# transform coordinates
dumpable_table = []
for a in address_table:
    dumpable_table.append(a[0])
    dumpable_table.append(a[1]*8)  # pre-multiply Y by 8

with open(shared.amiga_source_dir / "tiles_layout.68k","w") as f:
    bitplanelib.dump_asm_bytes(dumpable_table,f,mit_format=True,size=2)
