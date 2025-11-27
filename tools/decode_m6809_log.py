import os,struct,re

# log has the registers, then "DEAD" in hex then ram and rom base addresses

# do not compare those, they're fake diffs
excluded_pcs = {0X8120,0x8122,0x8125,0x811E,0x9F06,0xAB88,0xACE0,0xACC8,0x80C1,0x80C4,0x80C6,0x9CB9}
excluded_pcs.update(range(0x8000,0x8072)) # remove irq
excluded_pcs.update(range(0x9438,0x94BE)) # remove waves random
excluded_pcs.remove(0x805D)

with open(r"..\cpu_log","rb") as f:
    contents = f.read()
    contents = contents[:-8]
    dead_marker, = struct.unpack(">H",contents[-2:])

    if dead_marker != 0xDEAD:
        raise Exception("Corrupt CPU log, should end by 0xDEAD at offset -8")

pcs = set()
# generated using LOG_REGS
macro = """
    .macro    LOG_REGS    m6809pc
    move.w    sr,-(a7)
    move.l    a6,-(a7)
    move.l    sub_log_ptr,a6
    move.w    #0x\m6809pc,(a6)+
    move.w    d0,(a6)+
    move.w    d1,(a6)+
    move.w    d2,(a6)+
    move.w    d3,(a6)+
    move.w    d4,(a6)+
    cmp.w    #0xCAFE,(a6)  | hitting the protection buffer
    jne        444f
    BREAKPOINT    "sub cpu log buffer full!"
444:
    move.w    #0xDEAD,(a6)+
    move.l    a6,sub_log_ptr
    move.l    (a7)+,a6
    move.w    (a7)+,sr
    .endm

"""
len_block = 0

size = {"b":1,"w":2,"l":4}

for line in macro.splitlines():
    m = re.search ("move.([bwl]).*,\(a6\)",line)
    if m:
        s = m.group(1)
        len_block += size[s]

print("Block size = ",hex(len_block))

sorted_cmp = False
avoid_regs = []
regslist = list("abdxyu")


def rework(name):
    regs[name] = decode_address(regs[name])

lst = []
for i in range(0,len(contents),len_block):
    chunk = contents[i:i+len_block]
    if len(chunk)<len_block:
        break
    regs=dict()
    regs["pc"],regs["a"],regs["d"],regs["x"],regs["y"],regs["u"],end = struct.unpack_from(">HHHHHHH",chunk)
    if end==0xCCCC:
        break
    if regs["pc"] not in excluded_pcs:

        pcs.add(regs["pc"])

        regs['b'] = regs['d'] & 0xFF

        regsize = {"a":2,"b":2,"d":4,"x":4,"y":4,"u":4}


        regstr = ["{}={:0{}X}".format(reg.upper(),regs[reg],regsize[reg]) for reg in regslist if reg not in avoid_regs]
        rest = ", ".join(regstr)

        out = f"{regs['pc']:04X}: {rest}\n"

        lst.append(out)

if sorted_cmp:
    lst.sort()

with open("amiga.tr","w") as f:
    prev = None
    for line in lst:
        if prev != line:
            f.write(line)
        prev = line

# generated using log:     trace mame.tr,,noloop,{tracelog "A=%02X, B=%02X, D=%04X, X=%04X, Y=%04X, U=%04X ",a,b,d,x,y,u}
lst = []
print("reading MAME trace file...")
with open(r"K:\Emulation\MAME\mame.tr","r") as f:
    l = len("A=01, B=00, D=9300, X=8100, Y=9300, U=XXXX ")
    for line in f:
        m = re.match("A=(..), B=(..), D=(....), X=(....), Y=(....), U=(....)",line)
        if m:
            pc = line[l:l+4]
            regs = dict()
            pcval = int(pc,16)
            if pcval in pcs and pcval not in excluded_pcs:
                regs["a"],regs["b"],regs["d"],regs["x"],regs["y"],regs["u"] = m.groups()
                regstr = ["{}={}".format(reg.upper(),regs[reg]) for reg in regslist if reg not in avoid_regs]
                rest = ", ".join(regstr)
                lst.append(f"{pc}: {rest}\n")

if sorted_cmp:
    lst.sort()
print("writing filtered MAME trace file...")
with open("mame.tr","w") as fw:
    fw.writelines(lst)
