from PIL import Image,ImageOps
import os,pathlib,struct

from shared import *

# dump sprite area on MAME/ save sprites_title,$1780,$1080

sprite_names = get_sprite_names()



def raw_to_code(raw):
    lsb = raw & 0xFF
    msb = raw >> 8


    base = ((lsb & 0x20) << 2) + (msb >> 1)
    if msb & 1:
        base += 0x100
    return base


def load_tileset(image_name,width,height,dump_prefix=""):
    full_image_path = sheets_path / "sprites" / image_name
    tiles_1 = Image.open(full_image_path)
    nb_rows = tiles_1.size[1] // height
    nb_cols = tiles_1.size[0] // width

    if dump_prefix:
        dumpdir = pathlib.Path("dumps")
        dumpdir.mkdir(exist_ok=True)

    tileset_1 = []
    k=0
    for j in range(nb_rows):
        for i in range(nb_cols):
            img = Image.new("RGB",(width,height))
            img.paste(tiles_1,(-i*width,-j*height))
            tileset_1.append(img)
            if dump_prefix:
                img = ImageOps.scale(img,5,resample=Image.Resampling.NEAREST)
                img.save(os.path.join(dumpdir,f"{dump_prefix}_{k:02x}.png"))
            k += 1

    return tileset_1

def loadtiles(i):
    return load_tileset(f"pal_{i:02x}.png",16,16)

tile_set = [loadtiles(i) for i in range(16)]


def process(the_dump,name_filter=None,hide_named_sprite=None):
    the_dump = pathlib.Path(the_dump)
    # in input, we use a MAME memory dump: save sprites,$A000,$400
    # (0x200 are read, but there's a kind of double buffering
    with open(the_dump,"rb") as f:
        mem_1780 = bytearray(f.read())

    spriteram = mem_1780
    spriteram_2 = spriteram[0x800:]
    spriteram_3 = spriteram[0x1000:]

    result = Image.new("RGB",(256,256))

    print("*"*50)
    nb_active = 0



    for offs in range(0,0x80,2):
        if ((spriteram_3[offs+1] & 2) == 0):
            sprite = spriteram[offs]
            color = spriteram[offs+1]
            sx = spriteram_2[offs+1] + 0x100 * (spriteram_3[offs+1] & 1) - 40
            sy = spriteram_2[offs] - 1
            flipx = (spriteram_3[offs] & 0x01)
            flipy = (spriteram_3[offs] & 0x02) >> 1
            sizex = (spriteram_3[offs] & 0x04) >> 2
            sizey = (spriteram_3[offs] & 0x08) >> 3

            sprite &= ~sizex;
            sprite &= ~(sizey << 1);

            sy -= 16 * sizey;
            sy = (sy & 0xff) - 32


            im = tile_set[color][sprite]

            flipx,flipy = flipy,flipx
            sx,sy = sy,sx

            if color != 0:
                if flipy:
                    im = ImageOps.flip(im)
                if flipx:
                    im = ImageOps.mirror(im)

                name = sprite_names.get(sprite,"unknown")
                print(f"offs:{offs:02x}, name: {name}, code:{sprite:02x}, sizex: {sizex}, sizey: {sizey}, flipx: {flipx}, flipy: {flipy}, color:{color:02x}, X:{sx}, Y:{sy}")
                result.paste(im,(sx,sy))
                nb_active += 1

    result.save(f"{the_dump.stem}.png")
    print(f"nb active: {nb_active}")


process(r"sprite_ram_1780")

