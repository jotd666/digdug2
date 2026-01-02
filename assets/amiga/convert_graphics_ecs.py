from PIL import Image,ImageOps
import os,sys,bitplanelib

from shared import *


sprite_names = get_sprite_names()

mirror_sprites = get_mirror_sprites()

magenta = (254,0,254)

NB_SPRITES = 0x100
NB_TILES = 0x100

dsy_sprites = get_double_size_y_sprites()
dsx_sprites = get_double_size_x_sprites()
dsxy_sprites = get_double_size_xy_sprites()


dump_it = True

if dump_it:
    if not os.path.exists(dump_dir):
        os.mkdir(dump_dir)
        with open(os.path.join(dump_dir,".gitignore"),"w") as f:
            f.write("*")



def load_tileset(image_name,palette_index,width,height,tileset_name,dumpdir,
dump=False,name_dict=None,cluts=None,tile_number=0,is_bob=False):

##    if isinstance(image_name,str):
##        full_image_path = os.path.join(this_dir,os.path.pardir,"sheets",
##                            tile_type,image_name)
##        tiles_1 = Image.open(full_image_path)
##    else:
    tiles_1 = image_name
    nb_rows = tiles_1.size[1] // height
    nb_cols = tiles_1.size[0] // width


    tileset_1 = []
    tileset_xsize = []
    if dump:
        dump_subdir = os.path.join(dumpdir,tileset_name)
        if palette_index == 0 and tile_number == 0:
            ensure_empty(dump_subdir)

    palette = set()

    # first read ALL data
    for j in range(nb_rows):
        for i in range(nb_cols):
            img = Image.new("RGB",(width,height))
            img.paste(tiles_1,(-i*width,-j*height))
            tileset_1.append(img)
            tileset_xsize.append(None)

    other_tile_failure = False
    # now we can rework it
    if not is_bob:
        for tile_number,img in enumerate(tileset_1):
            if cluts is not None and (tile_number not in cluts or palette_index not in cluts[tile_number]):
                # no clut declared for that tile
                tileset_1[tile_number] = None
            else:

                # only consider colors of used tiles
                palette.update(set(bitplanelib.palette_extract(img)))

                # dump tiles not bobs (must group by size first)
                if dump:
                    img = ImageOps.scale(img,5,resample=Image.Resampling.NEAREST)
                    if name_dict:
                        name = name_dict.get(tile_number,"unknown")
                    else:
                        name = "unknown"

                    img.save(os.path.join(dump_subdir,f"{name}_{tile_number:02x}_{palette_index:02x}.png"))

    else:
        # rework & dump grouped / non grouped sprites
        # rework tiles which are grouped
        #
        # special case for horiz grouped tiles
        # do not display grouped unless

        for tile_number,wtile in enumerate(tileset_1):

            # special case for X-grouped:
            # 1) some tiles can be displayed X-grouped or not
            # (not the case with Y-grouped or XY-grouped) so we have to
            # create another tileset array for those
            if wtile and tile_number in dsx_sprites:
                new_tile = Image.new("RGB",(wtile.size[0]*2,wtile.size[1]))
                from_game = dsx_sprites[tile_number]
                if from_game:
                    # change wtile, fetch code +2
                    other_tile_index = tile_number+2
                else:
                    # extra grouping, helps faster display too
                    other_tile_index = tile_number+1

                other_tile = tileset_1[other_tile_index]

                if from_game:
                    new_tile.paste(wtile,(wtile.size[1],0))
                    new_tile.paste(other_tile)

                    tileset_xsize[tile_number] = new_tile
                else:
                    # normal grouping with next tile (artificial, not coded by graphic driver)
                    new_tile.paste(wtile)
                    new_tile.paste(other_tile,(wtile.size[1],0))

                    tileset_1[tile_number] = new_tile
                    tileset_1[other_tile_index] = None  # discard
                wtile = new_tile

            if wtile and tile_number in dsy_sprites:
                # change wtile, fetch code +1
                other_tile_index = tile_number+1
                other_tile = tileset_1[other_tile_index]
                if not other_tile:
                    print(f"warn: other tile index 0x{other_tile_index:02x} not found (palette ${palette_index:x})")
                    other_tile_failure = True
                new_tile = Image.new("RGB",(wtile.size[0],wtile.size[1]*2))

                new_tile.paste(wtile)
                if other_tile:
                    new_tile.paste(other_tile,(0,wtile.size[1]))
                tileset_1[tile_number] = new_tile
                tileset_1[other_tile_index] = None  # discard
                wtile = new_tile
            if wtile and tile_number in dsxy_sprites:
                # change wtile, fetch code +1
                new_tile = Image.new("RGB",(wtile.size[0]*2,wtile.size[1]*2))

                new_tile.paste(wtile,(wtile.size[0],0))
                new_tile.paste(tileset_1[tile_number+1],(wtile.size[0],wtile.size[1]))
                new_tile.paste(tileset_1[tile_number+2],(0,0))
                new_tile.paste(tileset_1[tile_number+3],(0,wtile.size[1]))

                tileset_1[tile_number] = new_tile
                tileset_1[tile_number+1] = None  # discard
                tileset_1[tile_number+2] = None  # discard
                tileset_1[tile_number+3] = None  # discard
                wtile = new_tile

            if wtile:
                palette.update(set(bitplanelib.palette_extract(wtile)))

            if cluts is not None and (tile_number not in cluts or palette_index not in cluts[tile_number]):
                # no clut declared for that tile: cancel it
                tileset_1[tile_number] = None
                wtile = None

            if dump_it and wtile:
                img = ImageOps.scale(wtile,5,resample=Image.Resampling.NEAREST)
                if sprite_names:
                    name = sprite_names.get(tile_number,"unknown")
                else:
                    name = "unknown"

                img.save(os.path.join(dump_subdir,f"{name}_{tile_number:02x}_{palette_index:02x}.png"))


    return sorted(set(palette)),tileset_1,tileset_xsize



all_tile_cluts = False


nb_planes = 4

nb_colors = 16

NB_SPRITE_CLUTS = 16
NB_TILE_CLUTS = 64



sprite_cluts = {}
tile_cluts = {}


try:
    with open(used_graphics_dir / "used_sprites","rb") as f:
        for index in range(NB_SPRITES):
            d = f.read(NB_SPRITE_CLUTS)
            cluts = [i for i,c in enumerate(d) if c]
            if cluts:
                add_tile(sprite_cluts,index,cluts=cluts)

except OSError:
    print("Cannot find used_sprites")

# force points
for i in range(0xF5,0x100):
    add_tile(sprite_cluts,i,[0xC,0xD])
# remove some 0 clut
for i in range(0,0x100):
    if i in sprite_cluts:
        name = sprite_names.get(i,"")
        if "player" in name or "dragon" in name or "flame" in name:
            for j in [0,6,7]:
                try:
                    sprite_cluts[i].remove(j)
                except ValueError:
                    pass

if all_tile_cluts:
    tile_cluts = None
else:
    try:
        with open(used_graphics_dir / "used_tiles","rb") as f:
            for index in range(NB_TILES):
                d = f.read(NB_TILE_CLUTS)
                cluts = [i for i,c in enumerate(d) if c]
                if cluts:
                    add_tile(tile_cluts,index,cluts=cluts)
    except OSError:
        pass

# add full letters & digits for 3 cluts
for i in list(range(0x41,0x5C))+list(range(0x30,0x3A)):
    add_tile(tile_cluts,i,[0,0xA,0xB,0xD,0xE])






if dump_it:
    if not all_tile_cluts:
        with open(dump_dir / "used_sprites.json","w") as f:
            sprite_cluts_dict = {hex(k):[hex(x) for x in v] for k,v in sprite_cluts.items() if v}
            json.dump(sprite_cluts_dict,f,indent=2)
        with open(dump_dir / "used_tiles.json","w") as f:
            tile_cluts_dict = {hex(k):[hex(x) for x in v] for k,v in tile_cluts.items() if v}
            json.dump(tile_cluts_dict,f,indent=2)

def replace_colors(set_list,rep_dict):
    for ts in set_list:
        for i,t in enumerate(ts):
            if t:
                bitplanelib.replace_color_from_dict(ts[i],rep_dict)

def add_hw_sprite(index,name,cluts=[0]):
    if isinstance(index,range):
        pass
    elif not isinstance(index,(list,tuple)):
        index = [index]
    for idx in index:
        sprite_names[idx] = name
        hw_sprite_cluts[idx] = cluts

title_pic = Image.open(sheets_path / "title.png")

sprite_sheet_dict = {i:Image.open(sheets_path / "sprites" / f"pal_{i:02x}.png") for i in range(NB_SPRITE_CLUTS)}
tile_sheet_dict = {i:Image.open(sheets_path / "tiles" / f"pal_{i:02x}.png") for i in range(NB_TILE_CLUTS)}

tile_palette = set()
tile_set_list = []

for i,tsd in tile_sheet_dict.items():
    tp,tile_set,_ = load_tileset(tsd,i,8,8,"tiles",dump_dir,dump=dump_it,
    cluts=tile_cluts,
    name_dict=None)
    tile_set_list.append(tile_set)
    tile_palette.update(tp)

# 4 tile colors aren't found in sprite colors, but there are very close
# colors, so we can replace them without anyone noticing and it means that the
# game can be 16 colors not 32!
tile_color_rep_dict = {(0,0,255):(33,71,255),
(16,32,48):(0,0,0),
(222,0,0):(255,0,0)}

replace_colors(tile_set_list,tile_color_rep_dict)
# pad

sprite_palette = set()
sprite_set_list = [[] for _ in range(NB_SPRITE_CLUTS)]
sprite_set_list_x_size = [[] for _ in range(NB_SPRITE_CLUTS)]
hw_sprite_set_list = [[] for _ in range(NB_SPRITE_CLUTS)]

sprite_dump_dir = dump_dir / "sprites"

for p in sprite_dump_dir.glob("*"):
    p.unlink()
sprite_dump_dir.mkdir(exist_ok=True)

cluts = sprite_cluts

for clut_index,tsd in sprite_sheet_dict.items():
    # BOBs

    sp,sprite_set,sprite_set_x_size = load_tileset(tsd,clut_index,16,16,"sprites",dump_dir,dump=dump_it,
    name_dict=sprite_names,cluts=sprite_cluts,is_bob=True)
    sprite_set_list[clut_index] = sprite_set
    sprite_set_list_x_size[clut_index] = sprite_set_x_size
    sprite_palette.update(sp)

# replace dark purple by darker purple. This color is only used by the grape bonus & few
# pixels of the turnip.
# whereas the darker purple is used by the drill holes, and changing to match sprite colors
# makes it funny (not in a good way). So it's better to change the sprite purple, the grape
# doesn't appear very often anyway, and the turnip not often either (plus it's barely noticeable)
sprite_color_rep_dict = {
(151,33,174):(104,0,81)}
replace_colors(sprite_set_list,sprite_color_rep_dict)
replace_colors(sprite_set_list_x_size,sprite_color_rep_dict)

# destroy title tiles we don't need them (clut=1)
for i in range(0xE0,0xF5):
    sprite_set_list[1][i] = None

sprite_palette = sorted([sprite_color_rep_dict.get(c,c) for c in sprite_palette])
magi = sprite_palette.index(magenta)
sprite_palette.pop(magi)
# temporary: put magenta as first color to be able to decode the frames properly
sprite_palette.insert(0,magenta)

print(f"Used sprite colors: {len(sprite_palette)}")
sprite_palette += (16-len(sprite_palette)) * [(0x10,0x20,0x30)]

# sprite_set_list is now a 16x512 matrix of sprite tiles

    # Hardware sprites
##    cluts = hw_sprite_cluts
##    _,hw_sprite_set = load_tileset(tsd,i,16,"hw_sprites",dump_dir,dump=dump_it,name_dict=sprite_names,cluts=cluts)
##    hw_sprite_set_list.append(hw_sprite_set)


full_palette = sprite_palette

nb_total = len(set(full_palette))

print(f"Number of unique total colors (tiles+sprites) {nb_total}")

# pad just in case we don't have 16 colors
full_palette += (nb_colors-len(full_palette)) * [(0x10,0x20,0x30)]

# most sprites are eligible to hw sprites except X-sized (>16)
# we have to include them all for priority reasons. Hoses can be an exception as they're mostly behind
possible_hw_sprites = get_possible_hw_sprites()
#{i for i in range(0,0x100) if i not in dsx_sprites and i not in dsxy_sprites and not i in range(0x70,0x7C)}

plane_orientations = [("standard",lambda x:x),
("flip",ImageOps.flip),
("mirror",ImageOps.mirror),
("flip_mirror",lambda x:ImageOps.flip(ImageOps.mirror(x)))]


def read_tileset(img_set_list,palette,plane_orientation_flags,cache,is_bob,next_cache_id=1):
    tile_table = []
    for n,img_set in enumerate(img_set_list):
        tile_entry = []
        for i,tile in enumerate(img_set):
            entry = dict()
            if tile:

                for b,(plane_name,plane_func) in zip(plane_orientation_flags,plane_orientations):
                    if b:

                        bitplane_sprite_data = None
                        actual_nb_planes = nb_planes


                        wtile = plane_func(tile)

                        if is_bob:
                            actual_nb_planes += 1


                            # only 4 planes + mask => 5 planes
                            orig_wtile = wtile
                            y_start,wtile = bitplanelib.autocrop_y(wtile,mask_color=magenta)
                            height = wtile.size[1]
                            width = wtile.size[0]//8 + 2
                            bitplane_data = bitplanelib.palette_image2raw(wtile,None,palette,generate_mask=True,mask_color=magenta)

                            if i in possible_hw_sprites:
                                # using original, uncropped bitplane data to create 16x16 or 16x32 hw sprite
                                bitplane_sprite_data = bitplanelib.palette_image2attached_sprites(orig_wtile,None,palette,with_control_words=True)

                        else:
                            # 4 planes, no mask
                            height = 8
                            width = 1
                            y_start = 0
                            bitplane_data = bitplanelib.palette_image2raw(wtile,None,palette)

                        e,next_cache_id = split_bitplane_data(bitplane_data,actual_nb_planes,cache,width,height,y_start,next_cache_id)

                        entry[plane_name] = e
                        if bitplane_sprite_data:
                            entry[plane_name]["sprdat"] = bitplane_sprite_data

            tile_entry.append(entry)

        tile_table.append(tile_entry)

    # transpose
    new_tile_table = [[[] for _ in range(NB_SPRITE_CLUTS if is_bob else NB_TILE_CLUTS)] for _ in range(len(tile_table[0]))]

    # reorder/transpose. We have 16 * 256 we need 256 * 16
    for i,u in enumerate(tile_table):
        for j,v in enumerate(u):
            new_tile_table[j][i] = v

    return new_tile_table,next_cache_id

tile_plane_cache = {}
tile_table,_ = read_tileset(tile_set_list,sprite_palette,[True,False,False,False],cache=tile_plane_cache, is_bob=False)

bob_plane_cache = {}

sprite_table,next_cache_id = read_tileset(sprite_set_list,sprite_palette,[True,False,True,False],cache=bob_plane_cache, is_bob=True)
sprite_table_x_size,next_cache_id = read_tileset(sprite_set_list_x_size,sprite_palette,[True,False,True,False],cache=bob_plane_cache, is_bob=True,next_cache_id=next_cache_id)


title_bitplane_data = bitplanelib.palette_image2raw(title_pic,None,sprite_palette,generate_mask=True,mask_color=magenta)

full_title,next_cache_id = split_bitplane_data(title_bitplane_data,nb_planes+1,bob_plane_cache,title_pic.size[0]//8 + 2,title_pic.size[1],0,next_cache_id)




bitplanelib.palette_dump(tile_palette,dump_dir / "tile_palette.png",pformat=bitplanelib.PALETTE_FORMAT_PNG)
bitplanelib.palette_dump(sprite_palette,dump_dir / "sprite_palette.png",pformat=bitplanelib.PALETTE_FORMAT_PNG)

mixed_palette = sorted(set(tile_palette) | set(sprite_palette))
bitplanelib.palette_dump(sprite_palette,dump_dir / "mixed_palette.png",pformat=bitplanelib.PALETTE_FORMAT_PNG)

specific_tile_colors = sorted(set(tile_palette) - set(sprite_palette))
bitplanelib.palette_dump(specific_tile_colors,dump_dir / "tiles_only_palette.png",pformat=bitplanelib.PALETTE_FORMAT_PNG)

with open(os.path.join(ocs_src_dir,"palette.68k"),"w") as f:
    full_palette_black = [(0,0,0)]+full_palette[1:]
    bitplanelib.palette_dump(full_palette_black,f,bitplanelib.PALETTE_FORMAT_ASMGNU)



with open(os.path.join(ocs_src_dir,"graphics.68k"),"w") as f:
    f.write("\t.global\tcharacter_table\n")
    f.write("\t.global\ttitle_pic\n")
    f.write("\t.global\thws_table\n")
    f.write("\t.global\tbob_table\n")
    f.write("\t.global\tbob_table_x_size\n")

    f.write("character_table:\n")

    for i,tile_entry in enumerate(tile_table):
        f.write("\t.long\t")
        if tile_entry and any(tile_entry):
            f.write(f"tile_{i:02x}")
        else:
            f.write("0")
        f.write("\n")

    for i,tile_entry in enumerate(tile_table):
        if tile_entry and any(tile_entry):
            f.write(f"tile_{i:02x}:\n")
            for j,t in enumerate(tile_entry):
                f.write("\t.long\t")
                if t:
                    f.write(f"tile_{i:02x}_{j:02x}")
                else:
                    f.write("0")
                f.write("\n")


    for i,tile_entry in enumerate(tile_table):
        if tile_entry and any(tile_entry):
            for j,t in enumerate(tile_entry):
                if t:
                    name = f"tile_{i:02x}_{j:02x}"

                    f.write(f"{name}:\n")
                    for orientation,_ in plane_orientations:
                        f.write("* orientation={}\n".format(orientation))
                        if orientation in t:
                            data = t[orientation]
                            for bitplane_id in data["bitplanes"]:
                                f.write("\t.long\t")
                                if bitplane_id:
                                    f.write(f"tile_plane_{bitplane_id:02d}")
                                else:
                                    f.write("0")
                                f.write("\n")
                            if len(t)==1:
                                # optim: only standard
                                break
                        else:
                            for _ in range(nb_planes):
                                f.write("\t.long\t0\n")



    for k,v in tile_plane_cache.items():
        f.write(f"tile_plane_{v:02d}:")
        dump_asm_bytes(k,f)

    sprite_table_no_size = sprite_table
    for sprite_table,suffix in [(sprite_table_no_size,""),(sprite_table_x_size,"_x_size")]:
        f.write(f"bob_table{suffix}:\n")
        for i,tile_entry in enumerate(sprite_table):
            f.write("\t.long\t")
            if any(tile_entry):
                prefix = sprite_names.get(i,"bob")
                f.write(f"{prefix}_{i:02x}{suffix}")
            else:
                f.write("0")
            f.write("\n")


        for i,tile_entry in enumerate(sprite_table):
            if any(tile_entry):
                prefix = sprite_names.get(i,"bob")
                f.write(f"{prefix}_{i:02x}{suffix}:\n")
                for j,t in enumerate(tile_entry):
                    f.write("\t.long\t")
                    if t:
                        f.write(f"{prefix}_{i:02x}_{j:02x}{suffix}")
                    else:
                        f.write("0")
                    f.write("\n")


        for i,tile_entry in enumerate(sprite_table):
            if tile_entry:
                prefix = sprite_names.get(i,"bob")
                for j,t in enumerate(tile_entry):
                    if t:
                        name = f"{prefix}_{i:02x}_{j:02x}{suffix}"

                        f.write(f"{name}:\n")
                        height = 0

                        offset = 0
                        for orientation,_ in plane_orientations:
                            if orientation in t:
                                width = t[orientation]["width"]
                                height = t[orientation]["height"]
                                offset = t[orientation]["y_start"]
                                break
                        else:
                            raise Exception(f"height not found for {name}!!")
                        for orientation,_ in plane_orientations:
                            if orientation in t:
                                f.write("* orientation={}\n".format(orientation))
                                active_planes = 0
                                bitplanes = t[orientation]["bitplanes"]

                                for j,bitplane_id in enumerate(bitplanes):
                                    if bitplane_id:
                                        active_planes |= 1<<j

                                f.write(f"\t.word\t{height},{width},{offset},0x{active_planes:x}\n")
                                for bitplane_id in bitplanes:
                                    f.write("\t.long\t")
                                    if bitplane_id:
                                        f.write(f"bob_plane_{bitplane_id:02d}")
                                    else:
                                        f.write("0")
                                    f.write("\n")
                            elif orientation == "mirror":
                                f.write(f"\t.word\t-1  | no mirror declared\n")

    if possible_hw_sprites:
        f.write("hws_table:\n")
        for i,tile_entry in enumerate(sprite_table_no_size):
            for orientation in ['standard','mirror']:
                f.write("\t.long\t")
                if any(t and "sprdat" in t[orientation] for t in tile_entry):
                    prefix = sprite_names.get(i,"bob")
                    prefix = f"hws_{prefix}_{i:02x}_{orientation}"
                    f.write(prefix)
                else:
                    f.write("0")
                f.write("\n")

        # HW sprites clut declaration
        for i,tile_entry in enumerate(sprite_table_no_size):
            for orientation in ['standard','mirror']:
                if any(t and "sprdat" in t[orientation] for t in tile_entry):
                    prefix = sprite_names.get(i,"bob")
                    f.write(f"hws_{prefix}_{i:02x}_{orientation}:\n")
                    for j,t in enumerate(tile_entry):
                        f.write("\t.long\t")
                        if t:
                            z = f"hws_{prefix}_{i:02x}_{j:02x}_{orientation}"
                            f.write(f"{z}_0,{z}_1")
                        else:
                            f.write("0,0")
                        f.write("\n")

    # special case title pic
    f.write("\n* special case:\ntitle_pic:\n")
    offset = full_title["y_start"]
    height = full_title["height"]
    width = full_title["width"]
    active_planes = 0x1F
    f.write(f"\t.word\t{height},{width},{offset},0x{active_planes:x}\n")
    for bitplane_id in full_title["bitplanes"]:
        f.write("\t.long\t")
        if bitplane_id:
            f.write(f"bob_plane_{bitplane_id:02d}")
        else:
            f.write("0")
        f.write("\n")

    f.write("\n\t.section\t.datachip\n")

    for k,v in bob_plane_cache.items():
        f.write(f"bob_plane_{v:02d}:")
        dump_asm_bytes(k,f)

    if possible_hw_sprites:
        for i,tile_entry in enumerate(sprite_table_no_size):
            for orientation in ['standard','mirror']:
                if any(t and "sprdat" in t[orientation] for t in tile_entry):
                    prefix = sprite_names.get(i,"bob")
                    for j,t in enumerate(tile_entry):

                        if t:
                            data = t[orientation]["sprdat"]
                            for k,d in enumerate(data):
                                f.write(f"hws_{prefix}_{i:02x}_{j:02x}_{orientation}_{k}:")
                                bitplanelib.dump_asm_bytes(d,f,mit_format=True)
                            f.write("\n")
