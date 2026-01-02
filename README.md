# digdug2
Amiga port of Dig Dug 2 arcade

Requires a 2-button joystick, or the keyboard

Features:

- arcade perfect gameplay
- 50 fps vanilla A1200
- 25 fps on A500
- whdload mode available for AGA/ECS
- floppy mode available for ECS/OCS (AGA+ECS+OCS versions don't fit on a 880kb disk)

Note:

AGA version runs on vanilla A1200: arcade exact colors
ECS version runs on any ECS amiga: slightly less colors (not
really noticeable) and not very fast either
OCS version is the same as ECS but without the in-game music to save chipmem

Credits:

- jotd: reverse-engineering, 68000 transcode, graphics conversion
  sound conversion for the Amiga.
- no9: music
- PascalDe73: icon

Instructions:

5: insert coin
1/2: start game
arrows/joystick: move
red/ctrl: pump
blue/alt: drill

Bugs:

- sometimes game can kind of lock up (ex: level 11). Very rare.
  If that occurs, just wait a few seconds, monsters commit suicide,
  and game gets to next level.