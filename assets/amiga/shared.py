from PIL import Image,ImageOps
import os,sys,bitplanelib,subprocess,json,pathlib

this_dir = pathlib.Path(__file__).absolute().parent

data_dir = this_dir / ".." / ".."
src_dir = this_dir / ".." / ".." / "src" / "amiga"
aga_src_dir = src_dir / "aga"
ocs_src_dir = src_dir / "ocs"

sheets_path = this_dir / ".." / "sheets"
dump_dir = this_dir / "dumps"

used_sprite_cluts_file = this_dir / "used_sprite_cluts.json"
used_tile_cluts_file = this_dir / "used_tile_cluts.json"
used_graphics_dir = this_dir / "used_graphics"


def dump_asm_bytes(*args,**kwargs):
    bitplanelib.dump_asm_bytes(*args,**kwargs,mit_format=True)


def ensure_empty(d):
    if os.path.exists(d):
        for f in os.listdir(d):
            os.remove(os.path.join(d,f))
    else:
        os.makedirs(d)

def palette_pad(palette,pad_nb):
    palette += (pad_nb-len(palette)) * [(0x10,0x20,0x30)]

def ensure_empty(d):
    if os.path.exists(d):
        for f in os.listdir(d):
            x = os.path.join(d,f)
            if os.path.isfile(x):
                os.remove(x)
    else:
        os.makedirs(d)

def ensure_exists(d):
    if os.path.exists(d):
        pass
    else:
        os.makedirs(d)

sr2 = lambda a,b : set(range(a,b,2))

player_sprite_pairs = ()
player_single_sprites = {}

group_sprite_pairs = ()

def set_names(rval,start,end,name):
    rval.update({i:name for i in range(start,end)})

def get_sprite_names():

    rval = dict()

##    rval[0x155] = "blank"
    set_names(rval,0x5C,0x5E,"flame")
    set_names(rval,0x58,0x5A,"flame")
    set_names(rval,0x6C,0x6D,"flame")
    set_names(rval,0x60,0x6a,"flame")
    set_names(rval,0xF5,0x100,"points")
    set_names(rval,0x18,0x20,"dragon")
    set_names(rval,0x5a,0x5C,"dragon")
    set_names(rval,0x5e,0x60,"dragon")
    set_names(rval,0x3C,0x3E,"game_over")
    set_names(rval,0x6C,0x70,"ghost")

    rval[0x6a] = "red_enemy_inflating"
    rval[0x6b] = "dragon_inflating"
    rval[0x62] = "dragon_firing"
    rval[0x7C] = "banana"
    rval[0x7D] = "corn"
    rval[0x7E] = "pineapple"
    rval[0x7F] = "cocktail"
    rval[0x50] = "eggplant"
    rval[0x51] = "tomato"
    rval[0x52] = "watermelon"
    rval[0x53] = "grapes"
    rval[0x46] = "turnip"
    rval[0x47] = "mushroom"
    rval[0x69] = "dragon"
    set_names(rval,0x80,0xC8,"earth_crumbling")
    set_names(rval,0x38,0x3C,"splash")
    set_names(rval,0x10,0x18,"red_enemy")
    set_names(rval,0xC8,0xD4,"red_enemy")  # double height
    set_names(rval,0xD4,0xE0,"dragon")  # double height
    set_names(rval,0xE0,0xF5,"title_letter")
    set_names(rval,0x20,0x38,"player_digging")  # double height
    set_names(rval,0x0,0x10,"player")
    set_names(rval,0x70,0x7c,"hose")

    set_names(rval,0x48,0x50,"player_pumping")
    set_names(rval,0x40,0x46,"player_falling")
    set_names(rval,0x54,0x58,"player_dying")




    return rval

def get_double_size_y_sprites():
    return set(range(0x20,0x38,2))   # drilling hero
def get_double_size_x_sprites():
    game_grouped = {0X59,0x5D,0x64,0x5c,0x61,0x65,0x60,0x75}  # fire spitting dragon, flame, hose
    extra_grouped = {0x3C,0xE0,0xE2,0xE6,0xE8,0xEA}  # will speed up display
    rval = {x:True for x in game_grouped}
    rval.update({x:False for x in extra_grouped})
    return rval

def get_double_size_xy_sprites():
    return set(range(0xC8,0xE0,4))   # inflating monsters

def get_mirror_sprites():
    """ return the index of the sprites that need mirroring
"""
    rval = set(range(0,0x200))
    return rval


def add_tile(table,index,cluts=[0]):
    if isinstance(index,range):
        pass
    elif not isinstance(index,(list,tuple)):
        index = [index]
    for idx in index:
        table[idx] = cluts

def get_possible_hw_sprites():
    dsy_sprites = get_double_size_y_sprites()
    dsx_sprites = get_double_size_x_sprites()
    dsxy_sprites = get_double_size_xy_sprites()
    possible_hw_sprites = set()
    sprite_names = get_sprite_names()
    for i in range(0,0x100):
        if i not in dsx_sprites and i not in dsxy_sprites:
            name = sprite_names.get(i,"unknown")
            if any(x in name for x in ("points","ghost","dragon","red_enemy","player")):
                possible_hw_sprites.add(i)
    return possible_hw_sprites

def split_bitplane_data(bitplane_data,actual_nb_planes,cache,width,height,y_start,next_cache_id):
    plane_size = len(bitplane_data) // actual_nb_planes
    bitplane_plane_ids = []
    for j in range(actual_nb_planes):
        offset = j*plane_size
        bitplane = bitplane_data[offset:offset+plane_size]

        cache_id = cache.get(bitplane)
        if cache_id is not None:
            bitplane_plane_ids.append(cache_id)
        else:
            if any(bitplane):
                cache[bitplane] = next_cache_id
                bitplane_plane_ids.append(next_cache_id)
                next_cache_id += 1
            else:
                bitplane_plane_ids.append(0)  # blank
    return {"width":width,"height":height,"y_start":y_start,"bitplanes":bitplane_plane_ids},next_cache_id


if __name__ == "__main__":
    raise Exception("no main!")