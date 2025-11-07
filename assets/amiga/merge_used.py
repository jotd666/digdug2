import os,pathlib,shutil,json

from shared import *




def merge(used_name,nb_items,forced_cluts=None):
    merged_path_file = used_graphics_dir


    # merge sprites with existing file + moves from level 1
    used_dump = data_dir / used_name

    with open(used_dump,"rb") as f:
        new_contents = f.read()


    old_used = merged_path_file / used_name
    if old_used.exists():
        with open(old_used,"rb") as f:
            old_contents = f.read()
    else:
        old_contents = bytes(16*nb_items)

    contents = bytearray([a|b for a,b in zip(new_contents,old_contents)])

    if forced_cluts:
        for k,v in forced_cluts.items():
            base_idx = (k*16)
            for i in v:
                contents[i+base_idx] = 1

    if old_contents == contents:
        print(f"Nothing new for {used_name}")
    else:
        for i,(a,b) in enumerate(zip(old_contents,contents)):
            if a!=b:
                code,clut = divmod(i,16)
                print(f"{used_name}: New: code={code:02x}, clut={clut:02x}")
        with open(merged_path_file / used_name,"wb") as f:
            f.write(contents)

merge("used_sprites",512,{0X31:[0xa],0X61:[0xa],0X17D:[0],0x47:[0],0xA5:[0x6],0xA7:[0x6],0xB1:[0x6],0xB5:[6],0x127:[6],0x4D:[5],0x187:list(range(0,16)),0x1F1:list(range(0,16)),0x76:[7,8,9,10,11,12,13,14,15],0x1D1:[15],0x1D3:[15],0x157:[7,8,9]})
merge("used_tiles",0x400)
