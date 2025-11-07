from PIL import Image,ImageOps
import os,sys,bitplanelib,subprocess,json,pathlib

this_dir = pathlib.Path(__file__).absolute().parent

data_dir = this_dir / ".." / ".."
src_dir = this_dir / ".." / ".." / "src" / "amiga"

sheets_path = this_dir / ".." / "sheets"
dump_dir = this_dir / "dumps"

used_sprite_cluts_file = this_dir / "used_sprite_cluts.json"
used_tile_cluts_file = this_dir / "used_tile_cluts.json"
used_graphics_dir = this_dir / "used_graphics"

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

group_sprite_pairs = (
sr2(0x1F0,0x200) | sr2(0x1A0,0x1B0) | sr2(0x1BA,0x1C0) | sr2(0x170,0x17A) |
{0xCE,0x18D,0x19A,0x26,0x1EC,0x19C,0x1C0,0x11D,0X1C4,0x1EA,0x1B8,0xE8,0xE2,0x1E4,0x1D5,0x1E0,0x1E2,0x164,0x1DD,0x19E,0X41,0x44,0x34,0x30,0X17C,0x75,0x77,
0x46,0x60,0x62,0X4A,0x4C,0X1D8,0x54,0x56,0x1C8,0x1CA,0X1D0,0x1D2,0xD8,0x126,0X183,0x156,0x17A,0x17E,0x122,0x124,0x193} |
sr2(0x1B0,0x1B8)
)

def set_names(rval,start,end,name):
    rval.update({i:name for i in range(start,end)})

def get_sprite_names():

    rval = dict()
    set_names(rval,0x1D0,0x1D4,"police_van")
    set_names(rval,0x1C3,0x1C4,"police_van")
    set_names(rval,0x182,0X185,"police_van")
    set_names(rval,0x18A,0X18D,"police_van")
    set_names(rval,0x1F0,0x200,"police_car")
    set_names(rval,0x140,0x145,"woman_and_baby")
    set_names(rval,0x148,0x14A,"woman_and_baby")
    set_names(rval,0xF4,0xF6,"killed_worker")
    rval[0x4E] = "rpg"
    rval[0x32] = "policeman"
    rval[0x3F] = "blank"
    rval[0x155] = "blank"
    set_names(rval,0x100,0x103,"bullet")

    rval[0x10B] = "shell"
    rval[0x10C] = "shell"
    rval[0x126] = "dead_convict"
    rval[0x12A] = "dead_convict"
    rval[0x12C] = "dead_convict"
    rval[0x46] = "bike"
    rval[0x1C6] = "barrel"
    rval[0x138] = "bullet"
    rval[0x139] = "bullet"
    rval[0x131] = "score"
    rval[0x12E] = "score"
    rval[0x12F] = "score"
    rval[0x4A] = "policeman_rpg"
    rval[0x4C] = "policeman_rpg"
    rval[0x51] = "policeman_rpg"
    rval[0x75] = "policeman_rpg"
    rval[0x77] = "policeman_rpg"
    rval[0x54] = "policeman_rpg"
    rval[0x56] = "policeman_rpg"

    rval[0x181] = "police_car"
    rval[0x1C8] = "garbage_truck"
    rval[0x1CA] = "garbage_truck"
    set_names(rval,0,0x20,"policeman")
    set_names(rval,0x15A,0x15F,"policeman")
    set_names(rval,0x23,0x2A,"policeman")
    set_names(rval,0x1A0,0x1B8,"manhole_cover")
    set_names(rval,0x1B8,0x1C0,"convict_in_manhole")
    set_names(rval,0X122,0x125,"policeman")
    set_names(rval,0x80,0xEF,"convict")
    set_names(rval,0x1A8,0x1B0,"convict")
    set_names(rval,0x16E,0x170,"child")
    set_names(rval,0x160,0x162,"worker")
    set_names(rval,0x150,0x153,"worker")


    return rval

def get_mirror_sprites():
    """ return the index of the sprites that need mirroring
"""
    rval = set(range(0,0x200))
    return rval

alphanum_tile_codes = set(range(0,10)) | set(range(65-48,65+27-48))   # wrong

if __name__ == "__main__":
    raise Exception("no main!")