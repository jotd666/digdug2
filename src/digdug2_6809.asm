;	PORT_START("P1")    /* 56XX #0 pins 22-29 */
;	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_JOYSTICK_UP ) PORT_4WAY
;	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_JOYSTICK_RIGHT ) PORT_4WAY
;	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_JOYSTICK_DOWN ) PORT_4WAY
;	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_JOYSTICK_LEFT ) PORT_4WAY
;	PORT_START("P2")    /* 56XX #0 pins 22-29 */
;	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_JOYSTICK_UP ) PORT_4WAY PORT_COCKTAIL
;	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_JOYSTICK_RIGHT ) PORT_4WAY PORT_COCKTAIL
;	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_JOYSTICK_DOWN ) PORT_4WAY PORT_COCKTAIL
;	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_JOYSTICK_LEFT ) PORT_4WAY PORT_COCKTAIL
;	PORT_START("BUTTONS")   /* 56XX #0 pins 30-33 and 38-41 */
;	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_BUTTON1 )
;	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_BUTTON1 ) PORT_COCKTAIL
;	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_START1 )
;	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_START2 )
;	PORT_START("COINS") /* 56XX #0 pins 30-33 and 38-41 */
;	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_COIN1 )
;	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_COIN2 )
;	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_UNUSED )
;	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_SERVICE1 )
;	PORT_START("DSW0")  // 56XX #1 pins 30-33
;	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_BUTTON2 )
;	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_BUTTON2 ) PORT_COCKTAIL
;	PORT_DIPNAME( 0x04, 0x04, DEF_STR( Cabinet ) )
;	PORT_DIPSETTING(    0x04, DEF_STR( Upright ) )
;	PORT_DIPSETTING(    0x00, DEF_STR( Cocktail ) )
;	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_SERVICE )    // service mode again
;
;	PORT_START("DSW1")  // 56XX #1 pins 22-29
;	PORT_SERVICE_DIPLOC(  0x01, IP_ACTIVE_LOW, "SW1:1" )
;	PORT_DIPNAME( 0x02, 0x02, DEF_STR( Lives ) )        PORT_DIPLOCATION("SW1:2")
;	PORT_DIPSETTING(    0x02, "3" )
;	PORT_DIPSETTING(    0x00, "5" )
;	PORT_DIPNAME( 0x0c, 0x0c, DEF_STR( Coinage ) )      PORT_DIPLOCATION("SW1:3,4")
;	PORT_DIPSETTING(    0x0c, DEF_STR( 1C_1C ) )
;	PORT_DIPSETTING(    0x08, DEF_STR( 2C_1C ) )
;	PORT_DIPSETTING(    0x04, DEF_STR( 1C_2C ) )
;	PORT_DIPSETTING(    0x00, DEF_STR( 3C_1C ) )
;	PORT_DIPNAME( 0x30, 0x30, DEF_STR( Bonus_Life ) )   PORT_DIPLOCATION("SW1:5,6")
;	PORT_DIPSETTING(    0x30, "30k 80k and ..." )
;	PORT_DIPSETTING(    0x20, "30k 100k and ..." )
;	PORT_DIPSETTING(    0x10, "30k 120k and ..." )
;	PORT_DIPSETTING(    0x00, "30k 150k and..." )
;	PORT_DIPNAME( 0x40, 0x40, DEF_STR( Level_Select ) ) PORT_DIPLOCATION("SW1:7")
;	PORT_DIPSETTING(    0x40, DEF_STR( Off ) )
;	PORT_DIPSETTING(    0x00, DEF_STR( On ) )
;	PORT_DIPNAME( 0x80, 0x80, "Freeze" )                PORT_DIPLOCATION("SW1:8")
;	PORT_DIPSETTING(    0x80, DEF_STR( Off ) )
;	PORT_DIPSETTING(    0x00, DEF_STR( On ) )
;
;	PORT_START("DSW2")  // 56XX #1 pins 38-41 multiplexed
;	PORT_DIPUNUSED_DIPLOC( 0x01, 0x01, "SW2:1" )
;	PORT_DIPUNUSED_DIPLOC( 0x02, 0x02, "SW2:2" )
;	PORT_DIPUNUSED_DIPLOC( 0x04, 0x04, "SW2:3" )
;	PORT_DIPUNUSED_DIPLOC( 0x08, 0x08, "SW2:4" )
;	PORT_DIPUNUSED_DIPLOC( 0x10, 0x10, "SW2:5" )
;	PORT_DIPUNUSED_DIPLOC( 0x20, 0x20, "SW2:6" )
;	PORT_DIPUNUSED_DIPLOC( 0x40, 0x40, "SW2:7" )
;	PORT_DIPUNUSED_DIPLOC( 0x80, 0x80, "SW2:8" )

;	map(0x0000, 0x0fff).ram().w(FUNC(mappy_state::mappy_videoram_w)).share("videoram");
;	map(0x1000, 0x27ff).ram().share("spriteram");   // work RAM with embedded sprite RAM
;   sprites start at $1780 with 3 buffers of $800 bytes that hold attributes, code and coords
;   64 sprites can be displayed total
;	map(0x3800, 0x3fff).w(FUNC(mappy_state::mappy_scroll_w));   // scroll
;	map(0x4000, 0x43ff).rw(m_namco_15xx, FUNC(namco_15xx_device::sharedram_r), FUNC(namco_15xx_device::sharedram_w));   // shared RAM with the sound CPU
;	map(0x4800, 0x480f).rw("namcoio_1", FUNC(namcoio_device::read), FUNC(namcoio_device::write));   // custom I/O chips interface
;	map(0x4810, 0x481f).rw("namcoio_2", FUNC(namcoio_device::read), FUNC(namcoio_device::write));   // custom I/O chips interface
;	map(0x5000, 0x500f).w("mainlatch", FUNC(ls259_device::write_a0));   // various control bits
;	map(0x8000, 0x8000).w("watchdog", FUNC(watchdog_timer_device::reset_w));
;	map(0x8000, 0xffff).rom();  // only a000-ffff in Mappy

checksum_failed_flag_0306 = $306
sync_1000 = $1000
task_stack_pointer_1002 = $1002
nb_lives_1703 = $1703
stack_top_1900 = $1900
watchdog_8000 = $8000
video_stuff_5009 = $5009
video_stuff_5008 = $5008
video_stuff_5002 = $5002
video_stuff_5003 = $5003
video_stuff_5004 = $5004
video_stuff_500b = $500B
video_stuff_500a = $500A
namco_io_4800 = $4800
unknown_4802 = $4802
io_register_4818 = $4818
; there are 3 pointer array zones for tasks
stack_location_pointer_array_1800 = $1800
stack_location_pointer_array_1f10 = $1F10
stack_location_pointer_array_2010 = $2010
start_of_tasks_stack_190e = $190E
stack_pointer_191e = $191E
sprite_shadow_ram_1f16 = $1f16

irq_8000:
8000: B7 50 02       STA    video_stuff_5002
8003: B6 80 00       LDA    watchdog_8000
8006: B6 10 06       LDA    $1006
8009: B4 10 05       ANDA   $1005
800C: B7 10 07       STA    $1007
800F: 8E 50 04       LDX    #video_stuff_5004
8012: A7 86          STA    A,X
8014: B6 10 08       LDA    $1008
8017: C6 08          LDB    #$08
8019: 3D             MUL
801A: 8E 38 00       LDX    #$3800
801D: A7 8B          STA    D,X
; update sprites from sprite shadow ram to sprite ram
801F: 8E 1F 16       LDX    #sprite_shadow_ram_1f16
8022: CE 1F 80       LDU    #$1F80	; end of sprite ram (buffer 1)
8025: EC 04          LDD    $4,X
8027: ED C9 F8 00    STD    -$0800,U
802B: EC 02          LDD    $2,X
802D: ED C9 08 00    STD    $0800,U
8031: EC 84          LDD    ,X
8033: ED C1          STD    ,U++
8035: 30 88 20       LEAX   $20,X
8038: 8C 1F 96       CMPX   #sprite_shadow_ram_1f16+$80
803B: 26 E8          BNE    $8025
803D: 8E 20 16       LDX    #$2016
8040: EC 04          LDD    $4,X
8042: ED C9 F8 00    STD    -$0800,U
8046: EC 02          LDD    $2,X
8048: ED C9 08 00    STD    $0800,U
804C: EC 84          LDD    ,X
804E: ED C1          STD    ,U++
8050: 30 88 20       LEAX   $20,X
8053: 8C 27 96       CMPX   #$2796
8056: 26 E8          BNE    $8040
8058: B6 25 00       LDA    $2500
805B: 27 03          BEQ    $8060
805D: BD 8E 81       JSR    $8E81
8060: 7C 10 01       INC    $1001
8063: 7C 10 00       INC    sync_1000
8066: B6 10 50       LDA    $1050
8069: 26 02          BNE    $806D
806B: 86 3C          LDA    #$3C
806D: 4A             DECA
806E: B7 10 50       STA    $1050
8071: 3B             RTI

init_8072:
8072: 10 CE 19 00    LDS    #stack_top_1900		; stack top
8076: 86 10          LDA    #$10
8078: 1F 8B          TFR    A,DP
; clear RAM
807A: CE 00 00       LDU    #$0000
807D: 8E 10 00       LDX    #sync_1000
8080: B6 80 00       LDA    watchdog_8000
8083: EF 81          STU    ,X++
8085: 8C 28 00       CMPX   #$2800
8088: 26 F6          BNE    $8080
; init the $20 task stack pointers (contiguous), init stack zones
808A: CE 19 0E       LDU    #start_of_tasks_stack_190E
808D: 8E 18 00       LDX    #stack_location_pointer_array_1800
8090: BD 81 6B       JSR    init_stack_zone_816b
8093: 30 02          LEAX   $2,X		; step = 2
8095: 8C 18 40       CMPX   #$1840
8098: 26 F6          BNE    $8090
; 4 zones of $20 bytes: caution: zeroed from $1F00
; with extra data in between
809A: 8E 1F 10       LDX    #stack_location_pointer_array_1F10
809D: BD 81 5B       JSR    zero_and_init_stack_zone_815b
80A0: 30 88 20       LEAX   $20,X		; step = $20 (to store stuff?)
80A3: 8C 1F 90       CMPX   #$1F90
80A6: 26 F5          BNE    $809D
; 64 zones of $20 bytes: caution: zeroed from $2000
; with extra data in between
80A8: 8E 20 10       LDX    #stack_location_pointer_array_2010
80AB: BD 81 5B       JSR    zero_and_init_stack_zone_815b
80AE: 30 88 20       LEAX   $20,X		; step = $20 (to store stuff?)
80B1: 8C 27 90       CMPX   #$2790
80B4: 26 F5          BNE    $80AB
; init first stack return address, task will start when task scheduling loop runs
80B6: CC 81 D9       LDD    #startup_task_81d9
80B9: FD 19 0E       STD    start_of_tasks_stack_190E
80BC: 1C EF          ANDCC  #$EF	; enable interrupts
main_loop_80be:
80BE: B7 50 03       STA    video_stuff_5003
sync_loop_80c1:
80C1: B6 10 00       LDA    sync_1000
80C4: 27 FB          BEQ    sync_loop_80c1
80C6: 7F 10 00       CLR    sync_1000
; update I/O (sound?)
80C9: B6 48 14       LDA    $4814
80CC: 84 01          ANDA   #$01
80CE: 10 26 64 E8    LBNE   $E5BA
80D2: B6 48 17       LDA    $4817
80D5: 84 08          ANDA   #$08
80D7: 10 26 64 DF    LBNE   $E5BA
80DB: B6 48 00       LDA    namco_io_4800
80DE: 84 0F          ANDA   #$0F
80E0: BB 40 54       ADDA   $4054
80E3: B7 40 54       STA    $4054
80E6: 7F 48 00       CLR    namco_io_4800
end_of_io_stuff_80e6:
80E9: B6 10 E7       LDA    $10E7
80EC: 26 03          BNE    $80F1
80EE: BD 86 35       JSR    $8635
80F1: B6 10 EF       LDA    $10EF
80F4: 27 25          BEQ    $811B
80F6: B6 10 1B       LDA    $101B
80F9: 27 20          BEQ    $811B
80FB: B6 48 05       LDA    $4805
80FE: F6 10 5B       LDB    $105B
8101: 58             ASLB
8102: 85 08          BITA   #$08
8104: 27 01          BEQ    $8107
8106: 5C             INCB
8107: C4 03          ANDB   #$03
8109: F7 10 5B       STB    $105B
810C: B6 10 DE       LDA    $10DE
810F: C1 01          CMPB   #$01
8111: 26 03          BNE    $8116
8113: 4C             INCA
8114: 84 01          ANDA   #$01
8116: B7 10 DE       STA    $10DE
8119: 26 0C          BNE    $8127
; now loop on all tasks. When calling "task_switch_818a"
; it actually switches to other contexts. Either they're empty
; contexts or they do something, then yield after a while
; (most tasks loop on themselves, but yield in the loop)
;
; the 22 tasks are created in create_base_tasks_8f67, within the startup task
;
811B: 8E 18 00       LDX    #stack_location_pointer_array_1800
task_loop_811e:
811E: 8D 6A          BSR    task_switch_818a
8120: 30 02          LEAX   $2,X
8122: 8C 18 30       CMPX   #stack_location_pointer_array_1800+$30
8125: 26 F7          BNE    task_loop_811E
8127: B6 25 00       LDA    $2500
812A: 27 03          BEQ    $812F
812C: BD 8E AD       JSR    $8EAD
; more tasks, but they're never activated. The variable area is used, though
; in update_sprite_logic_819e
812F: 8E 1F 10       LDX    #stack_location_pointer_array_1F10
8132: 8D 56          BSR    task_switch_818a		; this does nothing
8134: 8D 68          BSR    update_sprite_logic_819e	; this is useful!
8136: 30 88 20       LEAX   $20,X
8139: 8C 1F 90       CMPX   #stack_location_pointer_array_1F10+$80
813C: 26 F4          BNE    $8132
; more tasks, but they're never activated. The variable area is used, though
; in update_sprite_logic_819e
813E: 8E 20 10       LDX    #stack_location_pointer_array_2010
8141: 8D 47          BSR    task_switch_818a		; this does nothing
8143: 8D 59          BSR    update_sprite_logic_819e	; this is useful!
8145: 30 88 20       LEAX   $20,X
8148: 8C 27 90       CMPX   #stack_location_pointer_array_2010+$780
814B: 26 F4          BNE    $8141
814D: 7E 80 BE       JMP    main_loop_80be


suspend_task_8150:
8150: BE 10 02       LDX    task_stack_pointer_1002	; points on pointer of stack pointer ($18xx)
; now X is the task stack pointer pointer
8153: 10 EF 84       STS    ,X						; store current stack value in task stack pointer
unwind_stack_8156:
8156: 10 CE 18 FE    LDS    #stack_top_1900-2		; abandon execution, return to scheduler
815A: 39             RTS

; < X pointer on stack buffer array ($18xx)
; < U stack buffer pointer (starts at $190E)
zero_and_init_stack_zone_815b:
; clear $10 bytes before X $10 bytes after
815B: CC 10 10       LDD    #$1010
815E: 6F 80          CLR    ,X+
8160: 5A             DECB
8161: 26 FB          BNE    $815E		; put $10 times 0 in X
8163: 30 88 E0       LEAX   -$20,X
8166: E7 80          STB    ,X+			; put $10 times 0 in original X-$10
8168: 4A             DECA
8169: 26 FB          BNE    $8166
; X is the same as it was when starting
; in the end put pointer on inactive task
; < X pointer on stack buffer array ($18xx)
; < U stack buffer pointer (starts at $190E)
init_stack_zone_816b:
816B: B6 80 00       LDA    watchdog_8000
816E: CC 81 91       LDD    #inactive_task_8191	; this will give control to task loop
8171: EF 84          STU    ,X
8173: 33 C8 10       LEAU   $10,U		; move stack buffer pointer by $10 bytes
8176: ED 94          STD    [,X]
8178: 39             RTS

; not reached commenting out
;8179: CC 81 91       LDD    #$8191
;817C: EE 84          LDU    ,X
;817E: ED C3          STD    ,--U
;8180: EF 84          STU    ,X
;8182: 39             RTS
;
;; not reached
;8183: EE 84          LDU    ,X
;8185: EC C1          LDD    ,U++
;8187: EF 84          STU    ,X
;8189: 39             RTS

; switch to task
; only call in task loop (for all 3 task lists)
; X contains $1800... or $2010...
task_switch_818a:
818A: BF 10 02       STX    task_stack_pointer_1002	; store pointer on stack pointer
; here we set the stack for the other task
; values are 190E => 1EFE (xxxe)
; get what it points to and sets it as stack pointer
; efficiently retrieving context that was saved earlier on suspend_task_8150
818D: 10 EE 84       LDS    ,X
; and jump to previous suspended task
8190: 39             RTS

inactive_task_8191:
8191: CC 81 99       LDD    #reset_stack_and_jump_8199
8194: BE 10 02       LDX    task_stack_pointer_1002
8197: ED 94          STD    [,X]		; change return value of the current active task to return to task loop

reset_stack_and_jump_8199:
8199: 10 CE 18 FE    LDS    #stack_top_1900-2		; set main init task stack
819D: 39             RTS							; and jump to task scheduler loop

; not sure of what it does, but if skipped, sprites
; are just not shown
update_sprite_logic_819e:
819E: A6 0C          LDA    $C,X
81A0: 26 36          BNE    $81D8
81A2: 6C 0C          INC    $C,X
81A4: EC 0E          LDD    $E,X
81A6: 7D 10 07       TST    $1007
81A9: 27 05          BEQ    $81B0
81AB: 53             COMB
81AC: 43             COMA
81AD: C3 01 01       ADDD   #$0101
81B0: C3 00 28       ADDD   #$0028
81B3: 34 02          PSHS   A
81B5: A6 08          LDA    $8,X
81B7: 85 04          BITA   #$04
81B9: 35 02          PULS   A
81BB: 26 03          BNE    $81C0
81BD: C3 00 08       ADDD   #$0008
81C0: E7 07          STB    $7,X
81C2: A7 09          STA    $9,X
81C4: E6 0D          LDB    $D,X
81C6: B6 10 07       LDA    $1007
81C9: 26 01          BNE    $81CC
81CB: 50             NEGB
81CC: CB F1          ADDB   #$F1
81CE: A6 08          LDA    $8,X
81D0: 85 08          BITA   #$08
81D2: 26 02          BNE    $81D6
81D4: CB 08          ADDB   #$08
81D6: E7 06          STB    $6,X
81D8: 39             RTS

startup_task_81d9:
81D9: BD 81 50       JSR    suspend_task_8150
81DC: BD 87 01       JSR    $8701
81DF: 8E 48 00       LDX    #namco_io_4800
81E2: CC 00 00       LDD    #$0000
81E5: A7 80          STA    ,X+
81E7: 8C 48 09       CMPX   #$4809
81EA: 26 F9          BNE    $81E5
81EC: 8E 48 10       LDX    #$4810
81EF: ED 81          STD    ,X++
81F1: 8C 48 20       CMPX   #$4820
81F4: 26 F9          BNE    $81EF
81F6: BD 81 50       JSR    suspend_task_8150
81F9: BD 81 50       JSR    suspend_task_8150
81FC: B7 50 0B       STA    video_stuff_500B
81FF: B7 50 09       STA    video_stuff_5009
8202: BD 81 50       JSR    suspend_task_8150
8205: BD 81 50       JSR    suspend_task_8150
8208: 86 04          LDA    #$04
820A: B7 48 18       STA    io_register_4818
820D: BD 81 50       JSR    suspend_task_8150
8210: BD 81 50       JSR    suspend_task_8150
8213: BD 85 6A       JSR    $856A
8216: BD 8C 05       JSR    $8C05
8219: BD 9A C4       JSR    $9AC4
821C: BD 81 50       JSR    suspend_task_8150
821F: BD 81 50       JSR    suspend_task_8150
8222: CC 01 03       LDD    #$0103
8225: B7 48 0A       STA    $480A
8228: B7 48 0C       STA    $480C
822B: F7 48 08       STB    $4808
822E: F6 48 15       LDB    $4815
8231: C4 08          ANDB   #$08
8233: 26 01          BNE    $8236
8235: 4F             CLRA
8236: B7 10 06       STA    $1006
8239: B6 48 14       LDA    $4814
823C: 84 02          ANDA   #$02
823E: 8B 03          ADDA   #$03
8240: B7 10 CC       STA    $10CC
8243: B6 48 16       LDA    $4816
8246: 84 03          ANDA   #$03
8248: 48             ASLA
8249: B7 10 70       STA    $1070
824C: B6 48 16       LDA    $4816
824F: 84 08          ANDA   #$08
8251: B7 10 EF       STA    $10EF
8254: B6 48 16       LDA    $4816
8257: 84 04          ANDA   #$04
8259: B7 10 F0       STA    $10F0
825C: BD 8F 67       JSR    create_base_tasks_8f67
825F: BD 81 50       JSR    suspend_task_8150
8262: BD 8A B2       JSR    $8AB2
8265: 4F             CLRA
8266: B7 10 05       STA    $1005
8269: B7 10 07       STA    $1007
826C: B7 10 0A       STA    $100A
826F: B7 10 1B       STA    $101B
8272: B7 10 E7       STA    $10E7
8275: B7 48 01       STA    $4801
8278: B7 48 09       STA    $4809
827B: BD 87 06       JSR    clear_screen_8706
827E: BD 8B 3D       JSR    $8B3D
8281: BD 8B DF       JSR    $8BDF
8284: FC 48 02       LDD    unknown_4802
8287: 84 0F          ANDA   #$0F
8289: 26 6A          BNE    $82F5
828B: C4 0F          ANDB   #$0F
828D: 26 66          BNE    $82F5
828F: BD 87 06       JSR    clear_screen_8706
8292: BD 86 9E       JSR    $869E
8295: BD 85 CA       JSR    $85CA
8298: CC 01 08       LDD    #$0108
829B: B7 10 E2       STA    $10E2
829E: F7 10 4F       STB    $104F
82A1: BD 81 50       JSR    suspend_task_8150
82A4: FC 48 02       LDD    unknown_4802
82A7: 84 0F          ANDA   #$0F
82A9: 26 4A          BNE    $82F5
82AB: C4 0F          ANDB   #$0F
82AD: 26 46          BNE    $82F5
82AF: B6 10 50       LDA    $1050
82B2: 26 ED          BNE    $82A1
82B4: 7A 10 4F       DEC    $104F
82B7: 26 E8          BNE    $82A1
82B9: BD 9A D7       JSR    $9AD7
82BC: CC 00 05       LDD    #$0005
82BF: B7 10 E2       STA    $10E2
82C2: F7 10 4F       STB    $104F
82C5: BD 81 50       JSR    suspend_task_8150
82C8: FC 48 02       LDD    unknown_4802
82CB: 84 0F          ANDA   #$0F
82CD: 26 26          BNE    $82F5
82CF: C4 0F          ANDB   #$0F
82D1: 26 22          BNE    $82F5
82D3: B6 10 50       LDA    $1050
82D6: 26 ED          BNE    $82C5
82D8: 7A 10 4F       DEC    $104F
82DB: 26 E8          BNE    $82C5
82DD: 7C 10 10       INC    $1010
82E0: BD 81 50       JSR    suspend_task_8150
82E3: FC 48 02       LDD    unknown_4802
82E6: 84 0F          ANDA   #$0F
82E8: 26 0B          BNE    $82F5
82EA: C4 0F          ANDB   #$0F
82EC: 26 07          BNE    $82F5
82EE: B6 10 10       LDA    $1010
82F1: 26 ED          BNE    $82E0
82F3: 20 9A          BRA    $828F
82F5: 7F 10 10       CLR    $1010
82F8: 7F 10 E2       CLR    $10E2
82FB: 7C 10 E3       INC    $10E3
82FE: BD 87 06       JSR    clear_screen_8706
8301: BD 8B 3D       JSR    $8B3D
8304: BD 8B DF       JSR    $8BDF
8307: BD 8C B6       JSR    $8CB6
830A: BD 85 CA       JSR    $85CA
830D: BD 86 5B       JSR    $865B
8310: BD 8A A0       JSR    $8AA0
8313: BD 81 50       JSR    suspend_task_8150
8316: B6 48 01       LDA    $4801
8319: 84 0F          ANDA   #$0F
831B: 27 F0          BEQ    $830D
831D: 7F 10 E3       CLR    $10E3
8320: 7C 10 E7       INC    $10E7
8323: BD 84 D5       JSR    $84D5
8326: B6 10 EF       LDA    $10EF
8329: 27 25          BEQ    $8350
832B: 7C 10 E1       INC    $10E1
832E: 7F 48 00       CLR    namco_io_4800
8331: B6 48 01       LDA    $4801
8334: 84 0F          ANDA   #$0F
8336: 4A             DECA
8337: B7 10 04       STA    $1004
833A: 43             COMA
833B: 84 01          ANDA   #$01
833D: B7 10 DE       STA    $10DE
8340: 7F 48 01       CLR    $4801
8343: 7C 48 09       INC    $4809
8346: BD 81 50       JSR    suspend_task_8150
8349: B6 10 E1       LDA    $10E1
834C: 26 F8          BNE    $8346
834E: 20 2F          BRA    $837F
8350: B6 17 25       LDA    $1725
8353: 26 30          BNE    $8385
8355: 7C 10 E9       INC    $10E9
8358: B6 10 05       LDA    $1005
835B: 26 15          BNE    $8372
835D: 7F 48 00       CLR    namco_io_4800
8360: B6 48 01       LDA    $4801
8363: 84 0F          ANDA   #$0F
8365: 4A             DECA
8366: B7 10 04       STA    $1004
8369: BD 8B 3D       JSR    $8B3D
836C: 7F 48 01       CLR    $4801
836F: 7C 48 09       INC    $4809
8372: BD 81 50       JSR    suspend_task_8150
8375: B6 10 E9       LDA    $10E9
8378: 26 F8          BNE    $8372
837A: B6 10 05       LDA    $1005
837D: 26 03          BNE    $8382
837F: BD 84 BC       JSR    $84BC
8382: BD C4 A8       JSR    $C4A8
8385: BD 87 06       JSR    clear_screen_8706
8388: BD 87 67       JSR    $8767
838B: BD 87 B3       JSR    $87B3
838E: BD 88 24       JSR    $8824
8391: 86 3C          LDA    #$3C
8393: B7 10 4F       STA    $104F
8396: 7C 40 40       INC    $4040
8399: BD 81 50       JSR    suspend_task_8150
839C: 7A 10 4F       DEC    $104F
839F: 26 F8          BNE    $8399
83A1: BD 85 38       JSR    $8538
83A4: BD C1 2A       JSR    $C12A
83A7: BD 81 50       JSR    suspend_task_8150
83AA: BD 88 24       JSR    $8824
83AD: BD 81 50       JSR    suspend_task_8150
83B0: B6 10 D0       LDA    $10D0
83B3: 26 4A          BNE    $83FF
83B5: B6 10 D1       LDA    $10D1
83B8: 26 0B          BNE    $83C5
83BA: FC 10 DC       LDD    $10DC
83BD: B7 40 41       STA    $4041
83C0: F7 40 42       STB    $4042
83C3: 20 E8          BRA    $83AD
83C5: CC 00 00       LDD    #$0000
83C8: B7 40 41       STA    $4041
83CB: B7 40 42       STA    $4042
83CE: FD 10 DC       STD    $10DC
83D1: 7C 40 52       INC    $4052
83D4: BD 81 50       JSR    suspend_task_8150
83D7: B6 40 52       LDA    $4052
83DA: BA 10 D7       ORA    $10D7
83DD: BA 10 D9       ORA    $10D9
83E0: BA 10 DF       ORA    $10DF
83E3: BA 10 E6       ORA    $10E6
83E6: BA 10 5E       ORA    $105E
83E9: 26 E9          BNE    $83D4
83EB: BD C4 A8       JSR    $C4A8
83EE: BD C0 E9       JSR    $C0E9
83F1: B6 10 D0       LDA    $10D0
83F4: 26 45          BNE    $843B
83F6: BD C4 9B       JSR    $C49B
83F9: BD 85 4D       JSR    $854D
83FC: 7E 83 50       JMP    $8350
83FF: CC 00 00       LDD    #$0000
8402: B7 40 41       STA    $4041
8405: B7 40 42       STA    $4042
8408: FD 10 DC       STD    $10DC
840B: 7F 10 E8       CLR    $10E8
840E: BD 81 50       JSR    suspend_task_8150
8411: B6 40 51       LDA    $4051
8414: BA 40 4D       ORA    $404D
8417: BA 10 4F       ORA    $104F
841A: BA 10 D7       ORA    $10D7
841D: BA 10 D9       ORA    $10D9
8420: BA 10 DF       ORA    $10DF
8423: BA 10 E6       ORA    $10E6
8426: BA 10 5E       ORA    $105E
8429: 26 E3          BNE    $840E
842B: B6 10 D1       LDA    $10D1
842E: 27 08          BEQ    $8438
8430: BD C4 A8       JSR    $C4A8
8433: BD C0 E9       JSR    $C0E9
8436: 20 03          BRA    $843B
8438: BD 84 E3       JSR    $84E3
843B: B6 10 D0       LDA    $10D0
843E: B4 10 D1       ANDA   $10D1
8441: B7 10 E0       STA    $10E0
8444: BD C4 9B       JSR    $C49B
8447: BD 85 4D       JSR    $854D
844A: 7A 17 03       DEC    nb_lives_1703
844D: 27 14          BEQ    $8463
844F: B6 10 04       LDA    $1004
8452: 10 27 FE FA    LBEQ   $8350
8456: B6 17 43       LDA    $1743
8459: 10 27 FE F3    LBEQ   $8350
845D: BD 84 F2       JSR    $84F2
8460: 7E 83 50       JMP    $8350
8463: BD 87 06       JSR    clear_screen_8706
8466: BD 87 50       JSR    $8750
8469: CC 00 00       LDD    #$0000
846C: B7 40 41       STA    $4041
846F: B7 40 42       STA    $4042
8472: FD 10 DC       STD    $10DC
8475: 7C 40 44       INC    $4044
8478: 7C 10 E3       INC    $10E3
847B: BD 81 50       JSR    suspend_task_8150
847E: B6 40 44       LDA    $4044
8481: 26 F8          BNE    $847B
8483: 7F 10 E3       CLR    $10E3
8486: BD 81 50       JSR    suspend_task_8150
8489: BD 9B 69       JSR    $9B69
848C: B6 10 E5       LDA    $10E5
848F: 27 05          BEQ    $8496
8491: BD 81 50       JSR    suspend_task_8150
8494: 20 F6          BRA    $848C
8496: B6 17 43       LDA    $1743
8499: 26 C2          BNE    $845D
849B: B6 10 05       LDA    $1005
849E: 10 27 FD C3    LBEQ   $8265
84A2: 8E 17 00       LDX    #$1700
84A5: EC 84          LDD    ,X
84A7: EE 88 40       LDU    $40,X
84AA: ED 88 40       STD    $40,X
84AD: EF 81          STU    ,X++
84AF: A6 84          LDA    ,X
84B1: E6 88 40       LDB    $40,X
84B4: A7 88 40       STA    $40,X
84B7: E7 84          STB    ,X
84B9: 7E 82 65       JMP    $8265
84BC: 7C 10 0A       INC    $100A
84BF: CC 00 00       LDD    #$0000
84C2: FD 10 D0       STD    $10D0
84C5: FD 10 DC       STD    $10DC
84C8: BD 8C 81       JSR    $8C81
84CB: BD 88 15       JSR    $8815
84CE: BD 8B 3D       JSR    $8B3D
84D1: BD 8B DF       JSR    $8BDF
84D4: 39             RTS
84D5: CC 00 00       LDD    #$0000
84D8: 8E 17 00       LDX    #$1700
84DB: ED 81          STD    ,X++
84DD: 8C 17 80       CMPX   #$1780
84E0: 26 F9          BNE    $84DB
84E2: 39             RTS
84E3: 8E 15 00       LDX    #$1500
84E6: EC 81          LDD    ,X++
84E8: ED 89 FD FE    STD    -$0202,X
84EC: 8C 15 78       CMPX   #$1578
84EF: 26 F5          BNE    $84E6
84F1: 39             RTS
84F2: 8E 17 00       LDX    #$1700
84F5: EC 84          LDD    ,X
84F7: EE 88 40       LDU    $40,X
84FA: EF 81          STU    ,X++
84FC: ED 88 3E       STD    $3E,X
84FF: 8C 17 40       CMPX   #$1740
8502: 26 F1          BNE    $84F5
8504: 7F 10 E8       CLR    $10E8
8507: 8E 15 80       LDX    #$1580
850A: EC 84          LDD    ,X
850C: EE 89 00 C0    LDU    $00C0,X
8510: EF 81          STU    ,X++
8512: ED 89 00 BE    STD    $00BE,X
8516: 8C 16 40       CMPX   #$1640
8519: 26 EF          BNE    $850A
851B: 8E 13 00       LDX    #$1300
851E: EC 84          LDD    ,X
8520: EE 89 00 80    LDU    $0080,X
8524: EF 81          STU    ,X++
8526: ED 88 7E       STD    $7E,X
8529: 8C 13 78       CMPX   #$1378
852C: 26 F0          BNE    $851E
852E: B6 10 05       LDA    $1005
8531: 4C             INCA
8532: 84 01          ANDA   #$01
8534: B7 10 05       STA    $1005
8537: 39             RTS
8538: 86 01          LDA    #$01
853A: B7 10 1B       STA    $101B
853D: B7 25 00       STA    $2500
8540: B7 10 D6       STA    $10D6
8543: B7 10 D2       STA    $10D2
8546: B7 10 D4       STA    $10D4
8549: B7 10 E8       STA    $10E8
854C: 39             RTS
854D: 4F             CLRA
854E: B7 10 D1       STA    $10D1
8551: B7 10 D0       STA    $10D0
8554: B7 10 1B       STA    $101B
8557: B7 10 E4       STA    $10E4
855A: B7 10 D6       STA    $10D6
855D: B7 25 00       STA    $2500
8560: B7 1F 60       STA    $1F60
8563: B7 10 D2       STA    $10D2
8566: B7 10 D4       STA    $10D4
8569: 39             RTS
856A: 8E 48 00       LDX    #namco_io_4800
856D: CE 85 88       LDU    #$8588
8570: A6 88 14       LDA    $14,X
8573: 84 0C          ANDA   #$0C
8575: 44             LSRA
8576: EC C6          LDD    A,U
8578: ED 09          STD    $9,X
857A: ED 0B          STD    $B,X
857C: CC 01 00       LDD    #$0100
857F: ED 0D          STD    $D,X
8581: E7 0F          STB    $F,X
8583: 86 02          LDA    #$02
8585: A7 08          STA    $8,X
8587: 39             RTS

; < X: destination video address
; < U: points on ASCII string
; < A: length

write_text_8590:
8590: B7 10 09       STA    $1009
8593: A6 C0          LDA    ,U+
8595: A7 84          STA    ,X			; [video_address]
8597: 30 88 E0       LEAX   -$20,X
859A: 7A 10 09       DEC    $1009
859D: 26 F4          BNE    $8593
859F: 39             RTS

clear_text_85a0:
85A0: F7 10 09       STB    $1009
85A3: A7 84          STA    ,X			; [video_address]
85A5: 30 88 E0       LEAX   -$20,X
85A8: 7A 10 09       DEC    $1009
85AB: 26 F6          BNE    $85A3
85AD: 39             RTS

85AE: B7 10 09       STA    $1009
85B1: 30 01          LEAX   $1,X
85B3: A6 C0          LDA    ,U+
85B5: A7 82          STA    ,-X			; [video_address]
85B7: 7A 10 09       DEC    $1009
85BA: 26 F7          BNE    $85B3
85BC: 39             RTS

85BD: F7 10 09       STB    $1009
85C0: 30 01          LEAX   $1,X
85C2: A7 82          STA    ,-X			; [video_address]
85C4: 7A 10 09       DEC    $1009
85C7: 26 F9          BNE    $85C2
85C9: 39             RTS

85CA: 8E 0B 17       LDX    #$0B17
85CD: 86 00          LDA    #$00
85CF: C6 16          LDB    #$16
85D1: BD 85 A0       JSR    clear_text_85a0
85D4: 8E 0A F9       LDX    #$0AF9
85D7: 86 00          LDA    #$00
85D9: C6 13          LDB    #$13
85DB: BD 85 A0       JSR    clear_text_85a0
85DE: 8E 0A 3C       LDX    #$0A3C
85E1: 86 0D          LDA    #$0D
85E3: C6 07          LDB    #$07
85E5: BD 85 A0       JSR    clear_text_85a0
85E8: 8E 02 D7       LDX    #$02D7
85EB: CE 86 0A       LDU    #$860A
85EE: 86 11          LDA    #$11
85F0: BD 85 90       JSR    write_text_8590
85F3: 8E 02 F9       LDX    #$02F9
85F6: CE 86 1B       LDU    #$861B
85F9: 86 13          LDA    #$13
85FB: BD 85 90       JSR    write_text_8590
85FE: 8E 02 3C       LDX    #$023C
8601: CE 86 2E       LDU    #$862E
8604: 86 07          LDA    #$07
8606: BD 85 90       JSR    write_text_8590
8609: 39             RTS
860A: 70 20 31       NEG    $2031
860D: 39             RTS

8635: 8E 07 AB       LDX    #$07AB                                       
8638: CE 86 B4       LDU    #$86B4                                       
863B: 86 08          LDA    #$08
863D: BD 85 AE       JSR    $85AE
8640: 8E 0F AB       LDX    #$0FAB
8643: 86 0E          LDA    #$0E
8645: C6 06          LDB    #$06
8647: BD 85 BD       JSR    $85BD
864A: FC 48 02       LDD    unknown_4802
864D: C4 0F          ANDB   #$0F
864F: F7 07 A3       STB    $07A3
8652: 84 0F          ANDA   #$0F
8654: 26 01          BNE    $8657
8656: 39             RTS
8657: B7 07 A4       STA    $07A4
865A: 39             RTS
865B: B6 10 01       LDA    $1001
865E: 85 08          BITA   #$08
8660: 26 0C          BNE    $866E
8662: 8E 02 89       LDX    #$0289
8665: 86 20          LDA    #$20
8667: C6 0D          LDB    #$0D
8669: BD 85 A0       JSR    clear_text_85a0
866C: 20 0B          BRA    $8679
866E: 8E 02 89       LDX    #$0289
8671: CE 86 BD       LDU    #$86BD
8674: 86 0D          LDA    #$0D
8676: BD 85 90       JSR    write_text_8590
8679: FC 48 02       LDD    unknown_4802
867C: 84 0F          ANDA   #$0F
867E: 26 06          BNE    $8686
8680: C4 0F          ANDB   #$0F
8682: C1 01          CMPB   #$01
8684: 27 0C          BEQ    $8692
8686: 8E 03 0B       LDX    #$030B
8689: CE 86 E0       LDU    #$86E0
868C: 86 16          LDA    #$16
868E: BD 85 90       JSR    write_text_8590
8691: 39             RTS
8692: 8E 03 0B       LDX    #$030B
8695: CE 86 CA       LDU    #$86CA
8698: 86 16          LDA    #$16
869A: BD 85 90       JSR    write_text_8590
869D: 39             RTS
869E: 8E 02 73       LDX    #$0273
86A1: CE 86 F6       LDU    #$86F6
86A4: 86 0B          LDA    #$0B
86A6: BD 85 90       JSR    write_text_8590
86A9: 8E 0A 73       LDX    #$0A73
86AC: 86 0E          LDA    #$0E
86AE: C6 0B          LDB    #$0B
86B0: BD 85 A0       JSR    clear_text_85a0
86B3: 39             RTS
86B4:
;	.ascii	"CREDIT   TO START PUSHONLY 1 PLAYER]S BUTTON1 OR 2 PLAYERS] BUTTONINSERT COIN"
8701: 8D 03          BSR    clear_screen_8706
8703: 8D 17          BSR    fill_screen_871c
8705: 39             RTS
clear_screen_8706:
8706: CC 20 20       LDD    #$2020
8709: 8E 00 00       LDX    #$0000
870C: 6F 89 08 00    CLR    $0800,X		; [video_address]
8710: 6F 89 08 01    CLR    $0801,X		; [video_address]
8714: ED 81          STD    ,X++		; [video_address_word]
8716: 8C 07 80       CMPX   #$0780
8719: 26 F1          BNE    $870C
871B: 39             RTS
fill_screen_871c:
871C: CC 20 20       LDD    #$2020
871F: 8E 07 80       LDX    #$0780
8722: 6F 89 08 00    CLR    $0800,X  		; [video_address]
8726: 6F 89 08 01    CLR    $0801,X  		; [video_address]
872A: ED 81          STD    ,X++     	; [video_address_word]
872C: 8C 08 00       CMPX   #$0800
872F: 26 F1          BNE    $8722
8731: 39             RTS

8732: EC 84          LDD    ,X
8734: FD 10 30       STD    $1030
8737: EC 06          LDD    $6,X
8739: FD 10 32       STD    $1032
873C: 86 F0          LDA    #$F0
873E: 6F 86          CLR    A,X
8740: 4C             INCA
8741: 81 10          CMPA   #$10
8743: 26 F9          BNE    $873E
8745: FC 10 30       LDD    $1030
8748: ED 84          STD    ,X
874A: FC 10 32       LDD    $1032
874D: ED 06          STD    $6,X
874F: 39             RTS
8750: 8E 02 70       LDX    #$0270
8753: CE 87 A9       LDU    #$87A9
8756: 86 0A          LDA    #$0A
8758: BD 85 90       JSR    write_text_8590
875B: 8E 0A 4E       LDX    #$0A4E
875E: 86 0A          LDA    #$0A
8760: C6 0D          LDB    #$0D
8762: BD 85 A0       JSR    clear_text_85a0
8765: 20 1F          BRA    $8786
8767: 8E 02 4C       LDX    #$024C
876A: CE 87 9E       LDU    #$879E
876D: 86 05          LDA    #$05
876F: BD 85 90       JSR    write_text_8590
8772: 8E 0A 4C       LDX    #$0A4C
8775: 86 0A          LDA    #$0A
8777: C6 05          LDB    #$05
8779: BD 85 A0       JSR    clear_text_85a0
877C: 8E 0A 4E       LDX    #$0A4E
877F: 86 0A          LDA    #$0A
8781: C6 0A          LDB    #$0A
8783: BD 85 A0       JSR    clear_text_85a0
8786: 8E 02 4E       LDX    #$024E
8789: CE 87 A3       LDU    #$87A3
878C: 86 06          LDA    #$06
878E: BD 85 90       JSR    write_text_8590
8791: B6 10 05       LDA    $1005
8794: 4C             INCA
8795: B7 01 6E       STA    $016E
8798: 86 0B          LDA    #$0B
879A: B7 09 6E       STA    $096E
879D: 39             RTS
; READYPLAYERGAME OVER
87B3: 8E 0A 50       LDX    #$0A50
87B6: 86 0A          LDA    #$0A
87B8: C6 05          LDB    #$05
87BA: BD 85 A0       JSR    clear_text_85a0
87BD: 86 0B          LDA    #$0B
87BF: B7 09 90       STA    $0990
87C2: B7 09 70       STA    $0970
87C5: 8E 02 50       LDX    #$0250
87C8: CE 88 0D       LDU    #$880D
87CB: 86 05          LDA    #$05
87CD: BD 85 90       JSR    write_text_8590
87D0: B6 10 E7       LDA    $10E7
87D3: 27 0B          BEQ    $87E0
87D5: 8E 07 AB       LDX    #$07AB
87D8: CE 88 0D       LDU    #$880D
87DB: 86 08          LDA    #$08
87DD: BD 85 AE       JSR    $85AE
87E0: B6 17 05       LDA    $1705
87E3: 84 0F          ANDA   #$0F
87E5: B7 01 70       STA    $0170
87E8: B7 10 34       STA    $1034
87EB: B6 17 05       LDA    $1705
87EE: 84 F0          ANDA   #$F0
87F0: 27 06          BEQ    $87F8
87F2: 44             LSRA
87F3: 44             LSRA
87F4: 44             LSRA
87F5: 44             LSRA
87F6: 20 02          BRA    $87FA
87F8: 86 20          LDA    #$20
87FA: B7 01 90       STA    $0190
87FD: B7 10 35       STA    $1035
8800: B6 10 E7       LDA    $10E7
8803: 26 01          BNE    $8806
8805: 39             RTS
8806: FC 10 34       LDD    $1034
8809: FD 07 A3       STD    $07A3
880C: 39             RTS

8815: F6 10 CC       LDB    $10CC           
8818: F7 17 03       STB    nb_lives_1703           
881B: B6 10 04       LDA    $1004           
881E: 27 03          BEQ    $8823           
8820: F7 17 43       STB    $1743           
8823: 39             RTS                    

8824: 8E 07 BC       LDX    #$07BC
8827: 86 20          LDA    #$20
8829: C6 0A          LDB    #$0A
882B: BD 85 BD       JSR    $85BD
882E: 8E 07 9C       LDX    #$079C
8831: 86 20          LDA    #$20
8833: C6 0A          LDB    #$0A
8835: BD 85 BD       JSR    $85BD
8838: 8E 0F BC       LDX    #$0FBC
883B: 86 00          LDA    #$00
883D: C6 0A          LDB    #$0A
883F: BD 85 BD       JSR    $85BD
8842: 8E 0F 9C       LDX    #$0F9C
8845: 86 00          LDA    #$00
8847: C6 0A          LDB    #$0A
8849: BD 85 BD       JSR    $85BD
884C: B6 17 03       LDA    nb_lives_1703
884F: B0 10 E8       SUBA   $10E8
8852: 26 01          BNE    $8855
8854: 39             RTS
8855: 81 05          CMPA   #$05
8857: 23 02          BLS    $885B
8859: 86 05          LDA    #$05
885B: B7 10 CE       STA    $10CE
885E: 8E 88 80       LDX    #$8880
8861: CE 07 BC       LDU    #$07BC
8864: EC 81          LDD    ,X++
8866: 33 CB          LEAU   D,U
8868: B6 10 CE       LDA    $10CE
886B: B7 10 09       STA    $1009
886E: EC 81          LDD    ,X++
8870: 8D 06          BSR    $8878
8872: 8C 88 90       CMPX   #$8890
8875: 26 EA          BNE    $8861
8877: 39             RTS
8878: ED C3          STD    ,--U
887A: 7A 10 09       DEC    $1009
887D: 26 F9          BNE    $8878
887F: 39             RTS

8890: BD 81 50       JSR    suspend_task_8150                                       
8893: B6 10 E2       LDA    $10E2
8896: 27 F8          BEQ    $8890
8898: 8E 20 10       LDX    #$2010
889B: CE 8A 05       LDU    #$8A05
889E: BD 8A A0       JSR    $8AA0
88A1: 84 1F          ANDA   #$1F
88A3: 4C             INCA
88A4: A7 04          STA    $4,X
88A6: A6 C0          LDA    ,U+
88A8: A7 0A          STA    $A,X
88AA: 6C 0B          INC    $B,X
88AC: EC C1          LDD    ,U++
88AE: A7 0F          STA    $F,X
88B0: E7 0D          STB    $D,X
88B2: 6F 0C          CLR    $C,X
88B4: 30 88 20       LEAX   $20,X
88B7: 8C 24 30       CMPX   #$2430
88BA: 26 E2          BNE    $889E
88BC: 8E 0B 09       LDX    #$0B09
88BF: 86 40          LDA    #$40
88C1: C6 15          LDB    #$15
88C3: BD 85 A0       JSR    clear_text_85a0
88C6: 8E 0B 0A       LDX    #$0B0A
88C9: 86 40          LDA    #$40
88CB: C6 15          LDB    #$15
88CD: BD 85 A0       JSR    clear_text_85a0
88D0: 8E 0B 0B       LDX    #$0B0B
88D3: 86 40          LDA    #$40
88D5: C6 15          LDB    #$15
88D7: BD 85 A0       JSR    clear_text_85a0
88DA: 8E 0B 0C       LDX    #$0B0C
88DD: 86 40          LDA    #$40
88DF: C6 15          LDB    #$15
88E1: BD 85 A0       JSR    clear_text_85a0
88E4: 8E 0B 0D       LDX    #$0B0D
88E7: 86 40          LDA    #$40
88E9: C6 15          LDB    #$15
88EB: BD 85 A0       JSR    clear_text_85a0
88EE: 8E 0B 0E       LDX    #$0B0E
88F1: 86 40          LDA    #$40
88F3: C6 15          LDB    #$15
88F5: BD 85 A0       JSR    clear_text_85a0
88F8: 8E 0B 0F       LDX    #$0B0F
88FB: 86 40          LDA    #$40
88FD: C6 15          LDB    #$15
88FF: BD 85 A0       JSR    clear_text_85a0
8902: 86 30          LDA    #$30
8904: B7 20 14       STA    $2014
8907: BD 81 50       JSR    suspend_task_8150
890A: B6 10 E2       LDA    $10E2
890D: 10 27 00 E3    LBEQ   $89F4
8911: B6 10 01       LDA    $1001
8914: 85 01          BITA   #$01
8916: 26 EF          BNE    $8907
8918: 8E 24 10       LDX    #$2410
891B: 6A 0F          DEC    $F,X
891D: 6F 0C          CLR    $C,X
891F: 30 88 E0       LEAX   -$20,X
8922: 8C 1F F0       CMPX   #$1FF0
8925: 26 F4          BNE    $891B
8927: 6A 88 24       DEC    $24,X
892A: 26 DB          BNE    $8907
892C: 86 3C          LDA    #$3C
892E: A7 88 24       STA    $24,X
8931: BD 81 50       JSR    suspend_task_8150
8934: B6 10 E2       LDA    $10E2
8937: 10 27 00 B9    LBEQ   $89F4
893B: 7A 20 14       DEC    $2014
893E: 26 F1          BNE    $8931
8940: 8E 01 EA       LDX    #$01EA
8943: CE 8A 68       LDU    #$8A68
8946: 86 05          LDA    #$05
8948: BD 85 90       JSR    write_text_8590
894B: 8E 02 0B       LDX    #$020B
894E: CE 8A 6D       LDU    #$8A6D
8951: 86 06          LDA    #$06
8953: BD 85 90       JSR    write_text_8590
8956: 8E 02 0C       LDX    #$020C
8959: CE 8A 73       LDU    #$8A73
895C: 86 06          LDA    #$06
895E: BD 85 90       JSR    write_text_8590
8961: 8E 02 0D       LDX    #$020D
8964: CE 8A 79       LDU    #$8A79
8967: 86 05          LDA    #$05
8969: BD 85 90       JSR    write_text_8590
896C: 8E 02 0E       LDX    #$020E
896F: CE 8A 7E       LDU    #$8A7E
8972: 86 06          LDA    #$06
8974: BD 85 90       JSR    write_text_8590
8977: 8E 02 0F       LDX    #$020F
897A: CE 8A 84       LDU    #$8A84
897D: 86 05          LDA    #$05
897F: BD 85 90       JSR    write_text_8590
8982: 8E 09 EA       LDX    #$09EA
8985: 86 10          LDA    #$10
8987: C6 05          LDB    #$05
8989: BD 85 A0       JSR    clear_text_85a0
898C: 8E 0A 0B       LDX    #$0A0B
898F: CE 8A 89       LDU    #$8A89
8992: 86 06          LDA    #$06
8994: BD 85 90       JSR    write_text_8590
8997: 8E 0A 0C       LDX    #$0A0C
899A: CE 8A 8F       LDU    #$8A8F
899D: 86 06          LDA    #$06
899F: BD 85 90       JSR    write_text_8590
89A2: 8E 0A 0D       LDX    #$0A0D
89A5: CE 8A 95       LDU    #$8A95
89A8: 86 05          LDA    #$05
89AA: BD 85 90       JSR    write_text_8590
89AD: 8E 0A 0E       LDX    #$0A0E
89B0: CE 8A 9A       LDU    #$8A9A
89B3: 86 06          LDA    #$06
89B5: BD 85 90       JSR    write_text_8590
89B8: 8E 0A 0F       LDX    #$0A0F
89BB: 86 0A          LDA    #$0A
89BD: C6 05          LDB    #$05
89BF: BD 85 A0       JSR    clear_text_85a0
89C2: 86 1F          LDA    #$1F
89C4: B7 20 14       STA    $2014
89C7: BD 81 50       JSR    suspend_task_8150
89CA: B6 10 E2       LDA    $10E2
89CD: 27 25          BEQ    $89F4
89CF: 7A 20 14       DEC    $2014
89D2: 26 F3          BNE    $89C7
89D4: BD 81 50       JSR    suspend_task_8150
89D7: B6 10 E2       LDA    $10E2
89DA: 27 18          BEQ    $89F4
89DC: B6 10 01       LDA    $1001
89DF: 85 08          BITA   #$08
89E1: 26 05          BNE    $89E8
89E3: BD 86 A9       JSR    $86A9
89E6: 20 EC          BRA    $89D4
89E8: 8E 0A 73       LDX    #$0A73
89EB: 86 00          LDA    #$00
89ED: C6 0B          LDB    #$0B
89EF: BD 85 A0       JSR    clear_text_85a0
89F2: 20 E0          BRA    $89D4
89F4: 8E 20 10       LDX    #$2010
89F7: BD 87 32       JSR    $8732
89FA: 30 88 20       LEAX   $20,X
89FD: 8C 24 30       CMPX   #$2430
8A00: 26 F5          BNE    $89F7
8A02: 7E 88 90       JMP    $8890

8AA0: B6 10 11       LDA    $1011                                      
8AA2: 11 48          ASLA
8AA4: 48             ASLA
8AA5: 48             ASLA
8AA6: B8 10 11       EORA   $1011
8AA9: 43             COMA
8AAA: 48             ASLA
8AAB: 79 10 11       ROL    $1011
8AAE: B6 10 11       LDA    $1011
8AB1: 39             RTS

8AB2: 8E 0F FD       LDX    #$0FFD
8AB5: 86 00          LDA    #$00
8AB7: C6 07          LDB    #$07
8AB9: BD 85 BD       JSR    $85BD
8ABC: 8E 0F F4       LDX    #$0FF4
8ABF: 86 00          LDA    #$00
8AC1: C6 0A          LDB    #$0A
8AC3: BD 85 BD       JSR    $85BD
8AC6: 8E 0F E1       LDX    #$0FE1
8AC9: 86 00          LDA    #$00
8ACB: C6 02          LDB    #$02
8ACD: BD 85 BD       JSR    $85BD
8AD0: 8E 0F EA       LDX    #$0FEA
8AD3: 86 00          LDA    #$00
8AD5: C6 07          LDB    #$07
8AD7: BD 85 BD       JSR    $85BD
8ADA: 39             RTS
8ADB: 7D 10 10       TST    $1010
8ADE: 27 01          BEQ    $8AE1
8AE0: 39             RTS
8AE1: 7D 17 26       TST    $1726
8AE4: 27 01          BEQ    $8AE7
8AE6: 39             RTS
8AE7: 1E 89          EXG    A,B
8AE9: BB 17 02       ADDA   $1702
8AEC: 19             DAA
8AED: B7 17 02       STA    $1702
8AF0: 1F 98          TFR    B,A
8AF2: B9 17 01       ADCA   $1701
8AF5: 19             DAA
8AF6: B7 17 01       STA    $1701
8AF9: B6 17 00       LDA    $1700
8AFC: 89 00          ADCA   #$00
8AFE: 19             DAA
8AFF: B7 17 00       STA    $1700
8B02: 84 F0          ANDA   #$F0
8B04: 27 22          BEQ    $8B28
8B06: B7 17 26       STA    $1726
8B09: 7F 17 01       CLR    $1701
8B0C: 7F 17 02       CLR    $1702
8B0F: 8E 0F F4       LDX    #$0FF4
8B12: 86 0B          LDA    #$0B
8B14: C6 0A          LDB    #$0A
8B16: BD 85 BD       JSR    $85BD
8B19: 8E 0F E1       LDX    #$0FE1
8B1C: 86 0B          LDA    #$0B
8B1E: C6 02          LDB    #$02
8B20: BD 85 BD       JSR    $85BD
8B23: 7C 40 55       INC    $4055
8B26: 20 15          BRA    $8B3D
8B28: BD 8C 17       JSR    $8C17
8B2B: 8E 17 00       LDX    #$1700
8B2E: A6 06          LDA    $6,X
8B30: 2B 0B          BMI    $8B3D
8B32: A6 88 27       LDA    $27,X
8B35: A1 88 22       CMPA   $22,X
8B38: 25 03          BCS    $8B3D
8B3A: BD 8C 31       JSR    $8C31
8B3D: 34 10          PSHS   X
8B3F: BD 8B BE       JSR    $8BBE
8B42: 8E 10 0B       LDX    #$100B
8B45: CE 07 F3       LDU    #$07F3
8B48: 8D 29          BSR    $8B73
8B4A: 8D 09          BSR    $8B55
8B4C: FC 07 F0       LDD    $07F0
8B4F: FD 07 E0       STD    $07E0
8B52: 35 10          PULS   X
8B54: 39             RTS
8B55: 8E 17 00       LDX    #$1700
8B58: CE 17 40       LDU    #$1740
8B5B: 7D 10 05       TST    $1005
8B5E: 27 02          BEQ    $8B62
8B60: 1E 13          EXG    X,U
8B62: 34 40          PSHS   U
8B64: CE 07 FD       LDU    #$07FD
8B67: 8D 0A          BSR    $8B73
8B69: 35 10          PULS   X
8B6B: CE 07 EA       LDU    #$07EA
8B6E: 7D 10 04       TST    $1004
8B71: 27 0B          BEQ    $8B7E
8B73: 10 8E 05 03    LDY    #$0503
8B77: 8D 10          BSR    $8B89
8B79: 86 30          LDA    #$30
8B7B: A7 C4          STA    ,U
8B7D: 39             RTS
8B7E: CC 20 07       LDD    #$2007
8B81: A7 C4          STA    ,U
8B83: 33 5F          LEAU   -$1,U
8B85: 5A             DECB
8B86: 26 F9          BNE    $8B81
8B88: 39             RTS
8B89: C6 FF          LDB    #$FF
8B8B: 20 02          BRA    $8B8F
8B8D: C6 E0          LDB    #$E0
8B8F: 10 BF 10 0E    STY    $100E
8B93: A6 84          LDA    ,X
8B95: 44             LSRA
8B96: 44             LSRA
8B97: 44             LSRA
8B98: 44             LSRA
8B99: 84 0F          ANDA   #$0F
8B9B: 8D 0C          BSR    $8BA9
8B9D: A6 80          LDA    ,X+
8B9F: 84 0F          ANDA   #$0F
8BA1: 8D 06          BSR    $8BA9
8BA3: 7A 10 0F       DEC    $100F
8BA6: 26 EB          BNE    $8B93
8BA8: 39             RTS
8BA9: 81 00          CMPA   #$00
8BAB: 26 09          BNE    $8BB6
8BAD: 7A 10 0E       DEC    $100E
8BB0: 2B 04          BMI    $8BB6
8BB2: 86 20          LDA    #$20
8BB4: 20 03          BRA    $8BB9
8BB6: 7F 10 0E       CLR    $100E
8BB9: A7 C4          STA    ,U
8BBB: 33 C5          LEAU   B,U
8BBD: 39             RTS
8BBE: 8E 17 00       LDX    #$1700
8BC1: CE 10 0B       LDU    #$100B
8BC4: C6 03          LDB    #$03
8BC6: A6 84          LDA    ,X
8BC8: A1 C4          CMPA   ,U
8BCA: 24 01          BCC    $8BCD
8BCC: 39             RTS
8BCD: 26 08          BNE    $8BD7
8BCF: 30 01          LEAX   $1,X
8BD1: 33 41          LEAU   $1,U
8BD3: 5A             DECB
8BD4: 26 F0          BNE    $8BC6
8BD6: 39             RTS
8BD7: A6 80          LDA    ,X+
8BD9: A7 C0          STA    ,U+
8BDB: 5A             DECB
8BDC: 26 F9          BNE    $8BD7
8BDE: 39             RTS
8BDF: 8E 0F D4       LDX    #$0FD4
8BE2: 86 0D          LDA    #$0D
8BE4: C6 0A          LDB    #$0A
8BE6: BD 85 BD       JSR    $85BD
8BE9: 8E 0F C1       LDX    #$0FC1
8BEC: 86 0D          LDA    #$0D
8BEE: C6 02          LDB    #$02
8BF0: BD 85 BD       JSR    $85BD
8BF3: 8E 07 D4       LDX    #$07D4
8BF6: CE 8C 0C       LDU    #$8C0C
8BF9: 86 0A          LDA    #$0A
8BFB: BD 85 AE       JSR    $85AE
8BFE: FC 07 D0       LDD    $07D0
8C01: FD 07 C0       STD    $07C0
8C04: 39             RTS
8C05: B6 8C 16       LDA    $8C16
8C08: B7 10 0C       STA    $100C
8C0B: 39             RTS

8C17: B6 17 06       LDA  $1706            
8C1A: 2B 64          BMI    $8C80            
8C1C: 8E 17 00       LDX    #$1700           
8C1F: EC 84          LDD    ,X               
8C21: 44             LSRA                                             
8C22: 56             RORB
8C23: 44             LSRA
8C24: 56             RORB
8C25: 44             LSRA
8C26: 56             RORB
8C27: 44             LSRA
8C28: 56             RORB
8C29: E1 88 22       CMPB   $22,X
8C2C: 25 52          BCS    $8C80
8C2E: E7 88 27       STB    $27,X
8C31: A6 03          LDA    $3,X
8C33: 81 FF          CMPA   #$FF
8C35: 27 05          BEQ    $8C3C
8C37: 6C 03          INC    $3,X
8C39: 7C 40 53       INC    $4053
8C3C: A6 06          LDA    $6,X
8C3E: 85 01          BITA   #$01
8C40: 26 1B          BNE    $8C5D
8C42: 6A 88 24       DEC    $24,X
8C45: 27 32          BEQ    $8C79
8C47: E6 88 23       LDB    $23,X
8C4A: E7 88 22       STB    $22,X
8C4D: CE 8D 20       LDU    #$8D20
8C50: 48             ASLA
8C51: AB 88 24       ADDA   $24,X
8C54: E6 C6          LDB    A,U
8C56: E7 88 23       STB    $23,X
8C59: BD 88 24       JSR    $8824
8C5C: 39             RTS
8C5D: E6 88 23       LDB    $23,X
8C60: E7 88 22       STB    $22,X
8C63: CE 8D 21       LDU    #$8D21
8C66: 84 02          ANDA   #$02
8C68: 48             ASLA
8C69: AB 88 24       ADDA   $24,X
8C6C: A6 C6          LDA    A,U
8C6E: AB 88 23       ADDA   $23,X
8C71: 19             DAA
8C72: A7 88 23       STA    $23,X
8C75: BD 88 24       JSR    $8824
8C78: 39             RTS
8C79: 86 FF          LDA    #$FF
8C7B: A7 06          STA    $6,X
8C7D: BD 88 24       JSR    $8824
8C80: 39             RTS
8C81: 8E 17 00       LDX    #$1700
8C84: CE 8D 19       LDU    #$8D19
8C87: B6 10 70       LDA    $1070
8C8A: 44             LSRA
8C8B: A7 06          STA    $6,X
8C8D: F6 10 04       LDB    $1004
8C90: 27 03          BEQ    $8C95
8C92: A7 88 46       STA    $46,X
8C95: C6 05          LDB    #$05
8C97: 85 01          BITA   #$01
8C99: 26 0B          BNE    $8CA6
8C9B: E7 88 24       STB    $24,X
8C9E: 7D 10 04       TST    $1004
8CA1: 27 03          BEQ    $8CA6
8CA3: E7 88 64       STB    $64,X
8CA6: 48             ASLA
8CA7: EC C6          LDD    A,U
8CA9: ED 88 22       STD    $22,X
8CAC: 7D 10 04       TST    $1004
8CAF: 26 01          BNE    $8CB2
8CB1: 39             RTS
8CB2: ED 88 62       STD    $62,X
8CB5: 39             RTS
8CB6: 8E 0A 89       LDX    #$0A89
8CB9: 86 0D          LDA    #$0D
8CBB: C6 0D          LDB    #$0D
8CBD: BD 85 A0       JSR    clear_text_85a0
8CC0: 8E 0B 0B       LDX    #$0B0B
8CC3: 86 0B          LDA    #$0B
8CC5: C6 16          LDB    #$16
8CC7: BD 85 A0       JSR    clear_text_85a0
8CCA: 8E 03 2D       LDX    #$032D
8CCD: CE 8D 29       LDU    #$8D29
8CD0: 86 18          LDA    #$18
8CD2: BD 85 90       JSR    write_text_8590
8CD5: 8E 02 AF       LDX    #$02AF
8CD8: CE 8D 2D       LDU    #$8D2D
8CDB: 86 14          LDA    #$14
8CDD: BD 85 90       JSR    write_text_8590
8CE0: 8E 03 31       LDX    #$0331
8CE3: CE 8D 41       LDU    #$8D41
8CE6: 86 07          LDA    #$07
8CE8: BD 85 90       JSR    write_text_8590
8CEB: 86 02          LDA    #$02
8CED: B7 03 2F       STA    $032F
8CF0: CC 4E 44       LDD    #$4E44
8CF3: B7 03 0F       STA    $030F
8CF6: F7 02 EF       STB    $02EF
8CF9: CE 8D 19       LDU    #$8D19
8CFC: B6 10 70       LDA    $1070
8CFF: EC C6          LDD    A,U
8D01: 84 0F          ANDA   #$0F
8D03: B7 01 4D       STA    $014D
8D06: 1F 98          TFR    B,A
8D08: 84 F0          ANDA   #$F0
8D0A: 27 07          BEQ    $8D13
8D0C: 44             LSRA
8D0D: 44             LSRA
8D0E: 44             LSRA
8D0F: 44             LSRA
8D10: B7 01 6F       STA    $016F
8D13: C4 0F          ANDB   #$0F
8D15: F7 01 4F       STB    $014F
8D18: 39             RTS

; pP01ST BONUS FOR   0000 PTSAND


8D48: BD 81 50       JSR    suspend_task_8150
8D4B: B6 10 E6       LDA    $10E6
8D4E: 27 F8          BEQ    $8D48
8D50: 8E 12 F7       LDX    #$12F7
8D53: 86 04          LDA    #$04
8D55: E6 86          LDB    A,X
8D57: 2B 11          BMI    $8D6A
8D59: 4A             DECA
8D5A: 26 F9          BNE    $8D55
8D5C: F6 10 CB       LDB    $10CB
8D5F: 27 04          BEQ    $8D65
8D61: C1 0B          CMPB   #$0B
8D63: 25 19          BCS    $8D7E
8D65: 7A 10 E6       DEC    $10E6
8D68: 20 DE          BRA    $8D48
8D6A: B7 10 34       STA    $1034
8D6D: 6F 86          CLR    A,X
8D6F: 8B 04          ADDA   #$04
8D71: E6 86          LDB    A,X
8D73: 6F 86          CLR    A,X
8D75: 5D             TSTB
8D76: 27 2D          BEQ    $8DA5
8D78: C1 0B          CMPB   #$0B
8D7A: 24 29          BCC    $8DA5
8D7C: 20 05          BRA    $8D83
8D7E: 86 FF          LDA    #$FF
8D80: B7 10 CB       STA    $10CB
8D83: 8E 14 77       LDX    #$1477
8D86: 7C 10 5E       INC    $105E
8D89: B6 10 5E       LDA    $105E
8D8C: E7 86          STB    A,X
8D8E: 58             ASLB
8D8F: 8E 8D E4       LDX    #$8DE4
8D92: EC 85          LDD    B,X
8D94: BD 8A DB       JSR    $8ADB
8D97: 5F             CLRB
8D98: B6 10 CB       LDA    $10CB
8D9B: 2A 08          BPL    $8DA5
8D9D: F7 10 CB       STB    $10CB
8DA0: 7A 10 E6       DEC    $10E6
8DA3: 20 A3          BRA    $8D48
8DA5: 8E 12 88       LDX    #$1288
8DA8: B6 10 34       LDA    $1034
8DAB: A1 80          CMPA   ,X+
8DAD: 26 02          BNE    $8DB1
8DAF: E7 1F          STB    -$1,X
8DB1: 8C 12 F0       CMPX   #$12F0
8DB4: 26 F5          BNE    $8DAB
8DB6: 7A 10 E6       DEC    $10E6
8DB9: 20 8D          BRA    $8D48
8DBB: 8E 12 88       LDX    #$1288
8DBE: CC 00 00       LDD    #$0000
8DC1: ED 81          STD    ,X++
8DC3: 8C 12 F0       CMPX   #$12F0
8DC6: 26 F9          BNE    $8DC1
8DC8: FD 14 78       STD    $1478
8DCB: FD 14 7A       STD    $147A
8DCE: B7 10 5E       STA    $105E
8DD1: B7 10 CB       STA    $10CB
8DD4: FD 12 F8       STD    $12F8
8DD7: FD 12 FA       STD    $12FA
8DDA: FD 12 FC       STD    $12FC
8DDD: FD 12 FE       STD    $12FE
8DE0: 86 04          LDA    #$04
8DE2: B7 10 5D       STA    $105D
8DE5: 39             RTS

8DFA: BD 81 50       JSR    suspend_task_8150                                       
8DFD: B6 10 5E       LDA    $105E
8E00: 27 F8          BEQ    $8DFA
8E02: 8E 1F 10       LDX    #$1F10
8E05: 7A 10 5F       DEC    $105F
8E08: B6 10 5F       LDA    $105F
8E0B: CE 8E 7D       LDU    #$8E7D
8E0E: 84 01          ANDA   #$01
8E10: 48             ASLA
8E11: EC C6          LDD    A,U
8E13: A7 12          STA    -$E,X
8E15: E7 0D          STB    $D,X
8E17: CB F0          ADDB   #$F0
8E19: E7 88 2D       STB    $2D,X
8E1C: CC F5 0D       LDD    #$F50D
8E1F: ED 88 2A       STD    $2A,X
8E22: BB 14 78       ADDA   $1478
8E25: 7F 14 78       CLR    $1478
8E28: ED 0A          STD    $A,X
8E2A: CC 00 C8       LDD    #$00C8
8E2D: E7 0F          STB    $F,X
8E2F: E7 88 2F       STB    $2F,X
8E32: A7 0C          STA    $C,X
8E34: A7 88 2C       STA    $2C,X
8E37: BD 81 50       JSR    suspend_task_8150
8E3A: 8E 1F 10       LDX    #$1F10
8E3D: A6 12          LDA    -$E,X
8E3F: AB 0D          ADDA   $D,X
8E41: 27 1A          BEQ    $8E5D
8E43: A7 0D          STA    $D,X
8E45: 8B F0          ADDA   #$F0
8E47: 27 14          BEQ    $8E5D
8E49: A7 88 2D       STA    $2D,X
8E4C: B6 10 01       LDA    $1001
8E4F: 84 08          ANDA   #$08
8E51: 27 02          BEQ    $8E55
8E53: 86 0D          LDA    #$0D
8E55: A7 0B          STA    $B,X
8E57: A7 88 2B       STA    $2B,X
8E5A: 4F             CLRA
8E5B: 20 D5          BRA    $8E32
8E5D: BD 87 32       JSR    $8732
8E60: 8E 1F 30       LDX    #$1F30
8E63: BD 87 32       JSR    $8732
8E66: 7A 10 5E       DEC    $105E
8E69: 27 8F          BEQ    $8DFA
8E6B: B6 10 5E       LDA    $105E
8E6E: 8E 14 78       LDX    #$1478
8E71: E6 01          LDB    $1,X
8E73: E7 80          STB    ,X+
8E75: 4A             DECA
8E76: 26 F9          BNE    $8E71
8E78: A7 84          STA    ,X
8E7A: 7E 8D FA       JMP    $8DFA

8E81: 8E 25 10       LDX    #$2510
8E84: CE 11 00       LDU    #$1100
8E87: A6 10          LDA    -$10,X
8E89: 27 17          BEQ    $8EA2
8E8B: A6 41          LDA    $1,U
8E8D: A7 08          STA    $8,X
8E8F: EC 42          LDD    $2,U
8E91: ED 0A          STD    $A,X
8E93: EC 44          LDD    $4,U
8E95: 5D             TSTB
8E96: 26 02          BNE    $8E9A
8E98: 1E 89          EXG    A,B
8E9A: A7 0D          STA    $D,X
8E9C: E7 0F          STB    $F,X
8E9E: 6F C4          CLR    ,U
8EA0: 6F 45          CLR    $5,U
8EA2: 33 46          LEAU   $6,U
8EA4: 30 88 20       LEAX   $20,X
8EA7: 8C 27 90       CMPX   #$2790
8EAA: 26 DB          BNE    $8E87
8EAC: 39             RTS
8EAD: 8E 25 10       LDX    #$2510
8EB0: CC 00 00       LDD    #$0000
8EB3: FD 10 34       STD    $1034
8EB6: 7C 10 34       INC    $1034
8EB9: A6 10          LDA    -$10,X
8EBB: 26 05          BNE    $8EC2
8EBD: 7C 10 35       INC    $1035
8EC0: 20 4C          BRA    $8F0E
8EC2: CE 11 00       LDU    #$1100
8EC5: E6 0D          LDB    $D,X
8EC7: 27 1B          BEQ    $8EE4
8EC9: 5F             CLRB
8ECA: B6 10 34       LDA    $1034
8ECD: B7 10 09       STA    $1009
8ED0: A6 0F          LDA    $F,X
8ED2: A1 45          CMPA   $5,U
8ED4: 24 04          BCC    $8EDA
8ED6: 6C C4          INC    ,U
8ED8: 20 01          BRA    $8EDB
8EDA: 5C             INCB
8EDB: 7A 10 09       DEC    $1009
8EDE: 27 1B          BEQ    $8EFB
8EE0: 33 46          LEAU   $6,U
8EE2: 20 EE          BRA    $8ED2
8EE4: B6 10 34       LDA    $1034
8EE7: 4A             DECA
8EE8: B7 10 CE       STA    $10CE
8EEB: 48             ASLA
8EEC: BB 10 CE       ADDA   $10CE
8EEF: 48             ASLA
8EF0: 33 C6          LEAU   A,U
8EF2: A6 0F          LDA    $F,X
8EF4: 1E 89          EXG    A,B
8EF6: 7C 10 35       INC    $1035
8EF9: 20 07          BRA    $8F02
8EFB: F0 10 35       SUBB   $1035
8EFE: E7 C4          STB    ,U
8F00: E6 0D          LDB    $D,X
8F02: E7 44          STB    $4,U
8F04: A7 45          STA    $5,U
8F06: A6 08          LDA    $8,X
8F08: A7 41          STA    $1,U
8F0A: EC 0A          LDD    $A,X
8F0C: ED 42          STD    $2,U
8F0E: 30 88 20       LEAX   $20,X
8F11: 8C 27 90       CMPX   #$2790
8F14: 26 A0          BNE    $8EB6
8F16: 8E 25 10       LDX    #$2510
8F19: CE 11 78       LDU    #$1178
8F1C: 4F             CLRA
8F1D: E6 10          LDB    -$10,X
8F1F: 27 08          BEQ    $8F29
8F21: E6 0D          LDB    $D,X
8F23: 27 02          BEQ    $8F27
8F25: A7 C0          STA    ,U+
8F27: 6F 0C          CLR    $C,X
8F29: 4C             INCA
8F2A: 30 88 20       LEAX   $20,X
8F2D: 8C 27 90       CMPX   #$2790
8F30: 26 EB          BNE    $8F1D
8F32: CE 11 00       LDU    #$1100
8F35: A6 C4          LDA    ,U
8F37: 27 25          BEQ    $8F5E
8F39: 8E 11 77       LDX    #$1177
8F3C: E6 86          LDB    A,X
8F3E: 6F 86          CLR    A,X
8F40: 86 20          LDA    #$20
8F42: 3D             MUL
8F43: 8E 25 10       LDX    #$2510
8F46: 30 8B          LEAX   D,X
8F48: EC 42          LDD    $2,U
8F4A: ED 0A          STD    $A,X
8F4C: EC 44          LDD    $4,U
8F4E: A7 0D          STA    $D,X
8F50: CB F5          ADDB   #$F5
8F52: A6 41          LDA    $1,U
8F54: 85 04          BITA   #$04
8F56: 27 02          BEQ    $8F5A
8F58: CB FB          ADDB   #$FB
8F5A: A7 08          STA    $8,X
8F5C: E7 0F          STB    $F,X
8F5E: 33 46          LEAU   $6,U
8F60: 11 83 11 78    CMPU   #$1178
8F64: 26 CF          BNE    $8F35
8F66: 39             RTS

create_base_tasks_8f67:
8F67: 8E 19 1E       LDX    #stack_pointer_191e
8F6A: 10 8E 8F 80    LDY    #table_8f80
8F6E: 86 16          LDA    #$16
8F70: B7 10 09       STA    $1009
8F73: EC A1          LDD    ,Y++
8F75: ED 84          STD    ,X
8F77: 30 88 10       LEAX   $10,X
8F7A: 7A 10 09       DEC    $1009
8F7D: 26 F4          BNE    $8F73
8F7F: 39             RTS

table_8f80:
	.word	$902b,$8ff3,$8fac,$909c,$a08b,$9f03,$a232,$a55b
	.word	$a697,$aa6f,$aabd,$ab85,$a859,$8d48,$8dfa,$b6e2
	.word	$8890,$9955,$94e4,$9438,$9cb6,$9d20 
	 
8FAC: BD 81 50       JSR    suspend_task_8150
8FAF: B6 10 1B       LDA    $101B
8FB2: 27 F8          BEQ    $8FAC
8FB4: B6 10 04       LDA    $1004
8FB7: B4 10 05       ANDA   $1005
8FBA: B4 10 06       ANDA   $1006
8FBD: C6 02          LDB    #$02
8FBF: 3D             MUL
8FC0: 8E 48 05       LDX    #$4805
8FC3: 3A             ABX
8FC4: F6 10 15       LDB    $1015
8FC7: 58             ASLB
8FC8: A6 84          LDA    ,X
8FCA: 84 02          ANDA   #$02
8FCC: 27 01          BEQ    $8FCF
8FCE: 5C             INCB
8FCF: C4 03          ANDB   #$03
8FD1: F7 10 15       STB    $1015
8FD4: A6 88 10       LDA    $10,X
8FD7: F6 40 4A       LDB    $404A
8FDA: 27 10          BEQ    $8FEC
8FDC: F6 10 14       LDB    $1014
8FDF: 58             ASLB
8FE0: 84 02          ANDA   #$02
8FE2: 27 01          BEQ    $8FE5
8FE4: 5C             INCB
8FE5: C4 03          ANDB   #$03
8FE7: F7 10 14       STB    $1014
8FEA: 20 C0          BRA    $8FAC
8FEC: 84 02          ANDA   #$02
8FEE: B7 10 14       STA    $1014
8FF1: 20 B9          BRA    $8FAC
8FF3: BD 81 50       JSR    suspend_task_8150
8FF6: B6 10 1B       LDA    $101B
8FF9: 27 F8          BEQ    $8FF3
8FFB: B6 10 04       LDA    $1004
8FFE: B4 10 05       ANDA   $1005
9001: B4 10 06       ANDA   $1006
9004: C6 02          LDB    #$02
9006: 3D             MUL
9007: 8E 48 04       LDX    #$4804
900A: A6 85          LDA    B,X
900C: 84 0F          ANDA   #$0F
900E: B7 10 12       STA    $1012
9011: 8E 90 1B       LDX    #$901B
9014: E6 86          LDB    A,X
9016: F7 10 13       STB    $1013
9019: 20 D8          BRA    $8FF3

902B: BD 81 50       JSR    $8150
902E: 8E 0F C7       LDX    #$0FC7
9031: 86 0D          LDA    #$0D
9033: C6 03          LDB    #$03
9035: BD 85 BD       JSR    $85BD
9038: 8E 0F DA       LDX    #$0FDA
903B: 86 0D          LDA    #$0D
903D: C6 03          LDB    #$03
903F: BD 85 BD       JSR    $85BD
9042: 8D 02          BSR    $9046
9044: 20 E5          BRA    $902B
9046: B6 10 0A       LDA    $100A
9049: 2A 01          BPL    $904C
904B: 39             RTS
904C: B6 10 01       LDA    $1001
904F: 84 0F          ANDA   #$0F
9051: 27 01          BEQ    $9054
9053: 39             RTS
9054: CE 07 DB       LDU    #$07DB
9057: 8E 07 C8       LDX    #$07C8
905A: F6 10 05       LDB    $1005
905D: 27 02          BEQ    $9061
905F: 1E 13          EXG    X,U
9061: 34 54          PSHS   U,X,B
9063: 8D 0F          BSR    $9074
9065: 35 54          PULS   B,X,U
9067: 1E 13          EXG    X,U
9069: C8 01          EORB   #$01
906B: 7D 10 04       TST    $1004
906E: 26 12          BNE    $9082
9070: C6 02          LDB    #$02
9072: 20 0E          BRA    $9082
9074: B6 10 01       LDA    $1001
9077: 44             LSRA
9078: 44             LSRA
9079: 44             LSRA
907A: 44             LSRA
907B: B4 10 0A       ANDA   $100A
907E: 27 02          BEQ    $9082
9080: C6 02          LDB    #$02
9082: 86 03          LDA    #$03
9084: 3D             MUL
9085: 8E 90 93       LDX    #$9093
9088: 3A             ABX
9089: C6 03          LDB    #$03
908B: A6 80          LDA    ,X+
908D: A7 C2          STA    ,-U
908F: 5A             DECB
9090: 26 F9          BNE    $908B
9092: 39             RTS
9093: 31 55          LEAY   -$B,U
9095: 50             NEGB
9096: 32 55          LEAS   -$B,U
9098: 50             NEGB
9099: 20 20          BRA    $90BB

909C: BD 81 50       JSR    suspend_task_8150
909F: B6 10 10       LDA    $1010
90A2: 27 F8          BEQ    $909C
90A4: 8E 15 80       LDX    #$1580
90A7: CE 92 12       LDU    #$9212
90AA: 86 3C          LDA    #$3C
90AC: B7 10 09       STA    $1009
90AF: BD C1 08       JSR    $C108
90B2: 8E 16 3C       LDX    #$163C
90B5: CC 00 3C       LDD    #$003C
90B8: A7 82          STA    ,-X
90BA: 5A             DECB
90BB: 26 FB          BNE    $90B8
90BD: CE 92 4E       LDU    #$924E
90C0: BD C1 BD       JSR    $C1BD
90C3: 8E 13 78       LDX    #$1378
90C6: CC 00 00       LDD    #$0000
90C9: ED 83          STD    ,--X
90CB: 8C 13 00       CMPX   #$1300
90CE: 26 F9          BNE    $90C9
90D0: BF 10 36       STX    $1036
90D3: CE 92 5B       LDU    #$925B
90D6: A6 5F          LDA    -$1,U
90D8: B7 10 09       STA    $1009
90DB: BD C8 03       JSR    $C803
90DE: BD C1 2A       JSR    $C12A
90E1: 8E 17 07       LDX    #$1707
90E4: CE 92 99       LDU    #$9299
90E7: BD C4 DB       JSR    $C4DB
90EA: 86 01          LDA    #$01
90EC: B7 25 00       STA    $2500
90EF: B7 10 D2       STA    $10D2
90F2: B7 10 D6       STA    $10D6
90F5: B7 10 D4       STA    $10D4
90F8: B7 40 B1       STA    $40B1
90FB: 8E 92 B2       LDX    #$92B2
90FE: EC 81          LDD    ,X++
9100: B7 10 13       STA    $1013
9103: F7 10 60       STB    $1060
9106: BF 10 63       STX    $1063
9109: 8E 93 34       LDX    #$9334
910C: EC 81          LDD    ,X++
910E: B7 10 14       STA    $1014
9111: F7 10 61       STB    $1061
9114: BF 10 65       STX    $1065
9117: 8E 93 84       LDX    #$9384
911A: EC 81          LDD    ,X++
911C: B7 10 15       STA    $1015
911F: F7 10 62       STB    $1062
9122: BF 10 67       STX    $1067
9125: 8E 27 50       LDX    #$2750
9128: CC 88 78       LDD    #$8878
912B: A7 0F          STA    $F,X
912D: A7 88 2F       STA    $2F,X
9130: A7 0D          STA    $D,X
9132: E7 88 2D       STB    $2D,X
9135: 6F 0C          CLR    $C,X
9137: 6F 88 2C       CLR    $2C,X
913A: CC 3C 01       LDD    #$3C01
913D: ED 0A          STD    $A,X
913F: 86 3D          LDA    #$3D
9141: ED 88 2A       STD    $2A,X
9144: BD 81 50       JSR    suspend_task_8150
9147: B6 10 10       LDA    $1010
914A: 27 52          BEQ    $919E
914C: FC 10 D0       LDD    $10D0
914F: 26 3B          BNE    $918C
9151: 7A 10 60       DEC    $1060
9154: 26 0E          BNE    $9164
9156: BE 10 63       LDX    $1063
9159: EC 81          LDD    ,X++
915B: BF 10 63       STX    $1063
915E: B7 10 13       STA    $1013
9161: F7 10 60       STB    $1060
9164: 7A 10 61       DEC    $1061
9167: 26 0E          BNE    $9177
9169: BE 10 65       LDX    $1065
916C: EC 81          LDD    ,X++
916E: BF 10 65       STX    $1065
9171: B7 10 14       STA    $1014
9174: F7 10 61       STB    $1061
9177: 7A 10 62       DEC    $1062
917A: 26 C8          BNE    $9144
917C: BE 10 67       LDX    $1067
917F: EC 81          LDD    ,X++
9181: BF 10 67       STX    $1067
9184: B7 10 15       STA    $1015
9187: F7 10 62       STB    $1062
918A: 20 B8          BRA    $9144
918C: 86 4F          LDA    #$4F
918E: B7 10 4F       STA    $104F
9191: BD 81 50       JSR    suspend_task_8150
9194: B6 10 10       LDA    $1010
9197: 27 05          BEQ    $919E
9199: 7A 10 4F       DEC    $104F
919C: 26 F3          BNE    $9191
919E: B6 40 54       LDA    $4054
91A1: B7 10 34       STA    $1034
91A4: CC 00 00       LDD    #$0000
91A7: 8E 14 00       LDX    #$1400
91AA: ED 81          STD    ,X++
91AC: 8C 14 78       CMPX   #$1478
91AF: 26 F9          BNE    $91AA
91B1: B7 10 10       STA    $1010
91B4: B7 10 50       STA    $1050
91B7: B7 25 00       STA    $2500
91BA: B7 10 D2       STA    $10D2
91BD: FD 10 D0       STD    $10D0
91C0: B7 10 08       STA    $1008
91C3: FD 10 DC       STD    $10DC
91C6: B7 10 D6       STA    $10D6
91C9: B7 10 D9       STA    $10D9
91CC: B7 10 D4       STA    $10D4
91CF: B7 1F 60       STA    $1F60
91D2: B7 10 DA       STA    $10DA
91D5: B7 40 B1       STA    $40B1
91D8: B7 1F 02       STA    $1F02
91DB: B7 1F 1D       STA    $1F1D
91DE: 8E 40 40       LDX    #$4040
91E1: ED 81          STD    ,X++
91E3: 8C 40 60       CMPX   #$4060
91E6: 26 F9          BNE    $91E1
91E8: B6 10 34       LDA    $1034
91EB: B7 40 54       STA    $4054
91EE: 8E 20 10       LDX    #$2010
91F1: A6 10          LDA    -$10,X
91F3: 27 03          BEQ    $91F8
91F5: BD 87 32       JSR    $8732
91F8: 30 88 20       LEAX   $20,X
91FB: 8C 24 D0       CMPX   #$24D0
91FE: 26 F1          BNE    $91F1
9200: BD A5 4F       JSR    $A54F
9203: 8E 27 50       LDX    #$2750
9206: BD 87 32       JSR    $8732
9209: 8E 27 70       LDX    #$2770
920C: BD 87 32       JSR    $8732
920F: 7E 90 9C       JMP    $909C

9438: BD 81 50       JSR    suspend_task_8150
943B: B6 10 D4       LDA    $10D4
943E: 27 F8          BEQ    $9438
9440: 8E 00 00       LDX    #$0000
9443: F6 10 08       LDB    $1008
9446: C4 F8          ANDB   #$F8
9448: 4F             CLRA
9449: 58             ASLB
944A: 49             ROLA
944B: 58             ASLB
944C: 49             ROLA
944D: 30 8B          LEAX   D,X
944F: BF 10 36       STX    $1036
9452: F6 10 01       LDB    $1001
9455: C4 1F          ANDB   #$1F
9457: 3A             ABX
9458: C6 1F          LDB    #$1F
945A: F7 10 09       STB    $1009
945D: A6 89 08 00    LDA    $0800,X
9461: 2A 06          BPL    $9469
9463: 84 3F          ANDA   #$3F
9465: A7 89 08 00    STA    $0800,X
9469: 30 88 20       LEAX   $20,X
946C: 5A             DECB
946D: 26 EE          BNE    $945D
946F: B6 10 6C       LDA    $106C
9472: BB 10 6D       ADDA   $106D
9475: 24 2E          BCC    $94A5
9477: B7 10 6D       STA    $106D
947A: BE 10 36       LDX    $1036
947D: B6 10 11       LDA    $1011
9480: 48             ASLA
9481: 48             ASLA
9482: 48             ASLA
9483: B8 10 11       EORA   $1011
9486: 43             COMA
9487: 48             ASLA
9488: 79 10 11       ROL    $1011
948B: B6 10 11       LDA    $1011
948E: 84 1F          ANDA   #$1F
9490: E6 86          LDB    A,X
9492: C1 FC          CMPB   #$FC
9494: 25 05          BCS    $949B
9496: 5C             INCB
9497: CA FC          ORB    #$FC
9499: E7 86          STB    A,X
949B: 7A 10 09       DEC    $1009
949E: 27 08          BEQ    $94A8
94A0: 30 88 20       LEAX   $20,X
94A3: 20 D8          BRA    $947D
94A5: B7 10 6D       STA    $106D
94A8: B6 10 50       LDA    $1050
94AB: BA 10 D9       ORA    $10D9
94AE: BA 10 D7       ORA    $10D7
94B1: BA 10 E6       ORA    $10E6
94B4: BA 10 D0       ORA    $10D0
94B7: BA 10 D1       ORA    $10D1
94BA: BA 10 DA       ORA    $10DA
94BD: 10 26 FF 77    LBNE   $9438
94C1: 7C 10 EC       INC    $10EC
94C4: 7C 10 EB       INC    $10EB
94C7: BD CC 7F       JSR    $CC7F
94CA: 7F 10 EC       CLR    $10EC
94CD: B6 10 CB       LDA    $10CB
94D0: 10 27 FF 64    LBEQ   $9438
94D4: 7C 10 E6       INC    $10E6
94D7: 7E 94 38       JMP    $9438
94DA: 80 80          SUBA   #$80
94DC: 80 80          SUBA   #$80
94DE: 80 40          SUBA   #$40
94E0: 20 10          BRA    $94F2
94E2: 05 05          LSR    $05
94E4: BD 81 50       JSR    suspend_task_8150
94E7: B6 10 E3       LDA    $10E3
94EA: 27 F8          BEQ    $94E4
94EC: 8E 20 10       LDX    #$2010
94EF: B6 40 44       LDA    $4044
94F2: 26 64          BNE    $9558
94F4: CE 99 3B       LDU    #$993B
94F7: EC C1          LDD    ,U++
94F9: A7 0F          STA    $F,X
94FB: E7 0D          STB    $D,X
94FD: A6 C0          LDA    ,U+
94FF: A7 0A          STA    $A,X
9501: 6C 0B          INC    $B,X
9503: 6F 0C          CLR    $C,X
9505: 30 88 20       LEAX   $20,X
9508: 8C 20 90       CMPX   #$2090
950B: 26 EA          BNE    $94F7
950D: 8E 20 10       LDX    #$2010
9510: CE 99 47       LDU    #$9947
9513: EF 15          STU    -$B,X
9515: CC 04 08       LDD    #$0408
9518: A7 88 1A       STA    $1A,X
951B: E7 88 3A       STB    $3A,X
951E: CC 02 B4       LDD    #$02B4
9521: A7 88 48       STA    $48,X
9524: E7 88 44       STB    $44,X
9527: BD 81 50       JSR    suspend_task_8150
952A: B6 10 E3       LDA    $10E3
952D: 27 15          BEQ    $9544
952F: 8E 20 10       LDX    #$2010
9532: CE 96 1D       LDU    #table_961D		; [jump_table]
9535: A6 1A          LDA    -$6,X
9537: 48             ASLA
9538: AD D6          JSR    [A,U]   ; [indirect_jump]
953A: 30 88 20       LEAX   $20,X
953D: 8C 20 70       CMPX   #$2070
9540: 26 F3          BNE    $9535
9542: 20 E3          BRA    $9527
9544: 8E 20 10       LDX    #$2010
9547: A6 0D          LDA    $D,X
9549: 27 03          BEQ    $954E
954B: BD 87 32       JSR    $8732
954E: 30 88 20       LEAX   $20,X
9551: 8C 21 B0       CMPX   #$21B0
9554: 26 F1          BNE    $9547
9556: 20 8C          BRA    $94E4
9558: 10 8E 99 33    LDY    #$9933
955C: BD 8A A0       JSR    $8AA0
955F: 84 7E          ANDA   #$7E
9561: 8B 30          ADDA   #$30
9563: A7 0F          STA    $F,X
9565: BD 8A A0       JSR    $8AA0
9568: 84 7E          ANDA   #$7E
956A: 8B 30          ADDA   #$30
956C: A7 0D          STA    $D,X
956E: BD 8A A0       JSR    $8AA0
9571: 84 07          ANDA   #$07
9573: A7 05          STA    $5,X
9575: E6 05          LDB    $5,X
9577: BD 8A A0       JSR    $8AA0
957A: 84 08          ANDA   #$08
957C: AB A5          ADDA   B,Y
957E: A7 0A          STA    $A,X
9580: CE 99 13       LDU    #$9913
9583: 58             ASLB
9584: 58             ASLB
9585: 33 C5          LEAU   B,U
9587: EC C1          LDD    ,U++
9589: ED 11          STD    -$F,X
958B: EC C4          LDD    ,U
958D: ED 13          STD    -$D,X
958F: CC 00 01       LDD    #$0001
9592: A7 08          STA    $8,X
9594: A7 0C          STA    $C,X
9596: E7 0B          STB    $B,X
9598: 30 88 20       LEAX   $20,X
959B: 8C 20 B0       CMPX   #$20B0
959E: 26 BC          BNE    $955C
95A0: BD 81 50       JSR    suspend_task_8150
95A3: B6 10 E3       LDA    $10E3
95A6: 27 64          BEQ    $960C
95A8: B6 10 01       LDA    $1001
95AB: 84 04          ANDA   #$04
95AD: 44             LSRA
95AE: 44             LSRA
95AF: B7 10 34       STA    $1034
95B2: 8E 20 10       LDX    #$2010
95B5: EC 11          LDD    -$F,X
95B7: AB 0F          ADDA   $F,X
95B9: A1 13          CMPA   -$D,X
95BB: 27 17          BEQ    $95D4
95BD: A7 0F          STA    $F,X
95BF: EB 0D          ADDB   $D,X
95C1: E1 14          CMPB   -$C,X
95C3: 27 0F          BEQ    $95D4
95C5: E7 0D          STB    $D,X
95C7: A6 0A          LDA    $A,X
95C9: 81 6A          CMPA   #$6A
95CB: 24 33          BCC    $9600
95CD: 84 1E          ANDA   #$1E
95CF: BA 10 34       ORA    $1034
95D2: 20 2A          BRA    $95FE
95D4: A6 05          LDA    $5,X
95D6: CE 99 13       LDU    #$9913
95D9: 85 01          BITA   #$01
95DB: 26 02          BNE    $95DF
95DD: 8B 02          ADDA   #$02
95DF: 8B 02          ADDA   #$02
95E1: 84 07          ANDA   #$07
95E3: A7 05          STA    $5,X
95E5: 48             ASLA
95E6: 48             ASLA
95E7: 33 C6          LEAU   A,U
95E9: EC C1          LDD    ,U++
95EB: ED 11          STD    -$F,X
95ED: EC C4          LDD    ,U
95EF: ED 13          STD    -$D,X
95F1: A6 0A          LDA    $A,X
95F3: 81 6A          CMPA   #$6A
95F5: 24 09          BCC    $9600
95F7: 84 08          ANDA   #$08
95F9: 44             LSRA
95FA: 44             LSRA
95FB: 44             LSRA
95FC: 8B 6A          ADDA   #$6A
95FE: A7 0A          STA    $A,X
9600: 6F 0C          CLR    $C,X
9602: 30 88 20       LEAX   $20,X
9605: 8C 20 B0       CMPX   #$20B0
9608: 26 AB          BNE    $95B5
960A: 20 94          BRA    $95A0
960C: 8E 20 10       LDX    #$2010
960F: BD 87 32       JSR    $8732
9612: 30 88 20       LEAX   $20,X
9615: 8C 20 B0       CMPX   #$20B0
9618: 26 F5          BNE    $960F
961A: 7E 94 E4       JMP    $94E4
961D: 96 39          LDA    $39
961F: 96 7F          LDA    $7F
9621: 96 8C          LDA    $8C
9623: 99 11          ADCA   $11
9625: 96 E3          LDA    $E3
9627: 97 29          STA    $29
9629: 97 41          STA    $41
962B: 97 6C          STA    $6C
962D: 97 81          STA    $81
962F: 97 93          STA    $93
9631: 97 DC          STA    $DC
9633: 98 2C          EORA   $2C
9635: 98 84          EORA   $84
9637: 98 E9          EORA   $E9
9639: A6 0D          LDA    $D,X
963B: 4A             DECA
963C: A7 0D          STA    $D,X
963E: 81 B0          CMPA   #$B0
9640: 27 0E          BEQ    $9650
9642: B6 10 01       LDA    $1001
9645: 84 0C          ANDA   #$0C
9647: 44             LSRA
9648: 44             LSRA
9649: 8B 04          ADDA   #$04
964B: A7 0A          STA    $A,X
964D: 6F 0C          CLR    $C,X
964F: 39             RTS
9650: 6C 1A          INC    -$6,X
9652: CC 79 05       LDD    #$7905
9655: ED 0A          STD    $A,X
9657: A6 04          LDA    $4,X
9659: C6 20          LDB    #$20
965B: 3D             MUL
965C: CE 21 50       LDU    #$2150
965F: 33 CB          LEAU   D,U
9661: 10 AE 15       LDY    -$B,X
9664: EC A1          LDD    ,Y++
9666: 10 AF 15       STY    -$B,X
9669: ED 4A          STD    $A,U
966B: A6 0F          LDA    $F,X
966D: A7 4F          STA    $F,U
966F: A6 0D          LDA    $D,X
9671: A7 4D          STA    $D,U
9673: CC 00 08       LDD    #$0008
9676: A7 4C          STA    $C,U
9678: E7 1B          STB    -$5,X
967A: 6C 04          INC    $4,X
967C: CE 96 1D       LDU    #$961D
967F: 86 FE          LDA    #$FE
9681: AB 0D          ADDA   $D,X
9683: A7 0D          STA    $D,X
9685: 6F 0C          CLR    $C,X
9687: 6A 1B          DEC    -$5,X
9689: 27 20          BEQ    $96AB
968B: 39             RTS
968C: CC 04 02       LDD    #$0402
968F: B4 10 01       ANDA   $1001
9692: 44             LSRA
9693: 44             LSRA
9694: 8B 4A          ADDA   #$4A
9696: A7 89 01 4A    STA    $014A,X
969A: F4 10 01       ANDB   $1001
969D: 54             LSRB
969E: CB 06          ADDB   #$06
96A0: E7 0B          STB    $B,X
96A2: E7 89 01 6B    STB    $016B,X
96A6: E7 89 01 8B    STB    $018B,X
96AA: 39             RTS
96AB: A6 04          LDA    $4,X
96AD: 81 03          CMPA   #$03
96AF: 26 A8          BNE    $9659
96B1: CC 01 08       LDD    #$0108
96B4: A7 04          STA    $4,X
96B6: A7 1A          STA    -$6,X
96B8: E7 1B          STB    -$5,X
96BA: CC 00 B0       LDD    #$00B0
96BD: A7 0C          STA    $C,X
96BF: E7 0D          STB    $D,X
96C1: CC 79 05       LDD    #$7905
96C4: ED 0A          STD    $A,X
96C6: 86 4A          LDA    #$4A
96C8: A7 89 01 4A    STA    $014A,X
96CC: 10 8E 99 49    LDY    #$9949
96D0: 10 AF 15       STY    -$B,X
96D3: 8E 21 70       LDX    #$2170
96D6: BD 87 32       JSR    $8732
96D9: 8E 21 90       LDX    #$2190
96DC: BD 87 32       JSR    $8732
96DF: 8E 20 10       LDX    #$2010
96E2: 39             RTS
96E3: 6C 0D          INC    $D,X
96E5: A6 88 ED       LDA    -$13,X
96E8: A0 0D          SUBA   $D,X
96EA: 81 08          CMPA   #$08
96EC: 23 16          BLS    $9704
96EE: B6 10 01       LDA    $1001
96F1: 84 04          ANDA   #$04
96F3: 44             LSRA
96F4: 44             LSRA
96F5: B7 10 34       STA    $1034
96F8: A6 0A          LDA    $A,X
96FA: 84 1E          ANDA   #$1E
96FC: BB 10 34       ADDA   $1034
96FF: A7 0A          STA    $A,X
9701: 6F 0C          CLR    $C,X
9703: 39             RTS
9704: 86 02          LDA    #$02
9706: A7 88 DA       STA    -$26,X
9709: 6C 1A          INC    -$6,X
970B: CC 03 24       LDD    #$0324
970E: A7 04          STA    $4,X
9710: E7 1B          STB    -$5,X
9712: 10 8E 99 4D    LDY    #$994D
9716: A6 0A          LDA    $A,X
9718: 84 08          ANDA   #$08
971A: 44             LSRA
971B: 31 A6          LEAY   A,Y
971D: 10 AF 15       STY    -$B,X
9720: 44             LSRA
9721: 44             LSRA
9722: 8B 6A          ADDA   #$6A
9724: A7 0A          STA    $A,X
9726: 6F 0C          CLR    $C,X
9728: 39             RTS
9729: 6A 1B          DEC    -$5,X
972B: 27 01          BEQ    $972E
972D: 39             RTS
972E: CC 24 0C       LDD    #$240C
9731: A7 1B          STA    -$5,X
9733: E7 08          STB    $8,X
9735: A6 0F          LDA    $F,X
9737: 8B F8          ADDA   #$F8
9739: A7 0F          STA    $F,X
973B: 6F 0C          CLR    $C,X
973D: 6C 1A          INC    -$6,X
973F: 20 0D          BRA    $974E
9741: 6A 1B          DEC    -$5,X
9743: 27 01          BEQ    $9746
9745: 39             RTS
9746: 6A 04          DEC    $4,X
9748: 27 0F          BEQ    $9759
974A: 86 0F          LDA    #$0F
974C: A7 1B          STA    -$5,X
974E: 10 AE 15       LDY    -$B,X
9751: A6 A0          LDA    ,Y+
9753: 10 AF 15       STY    -$B,X
9756: A7 0A          STA    $A,X
9758: 39             RTS
9759: CC 00 07       LDD    #$0007
975C: A7 0D          STA    $D,X
975E: A7 0C          STA    $C,X
9760: E7 1A          STB    -$6,X
9762: 8E 20 10       LDX    #$2010
9765: BD 96 B1       JSR    $96B1
9768: 8E 20 30       LDX    #$2030
976B: 39             RTS
976C: CC 04 00       LDD    #$0400
976F: A7 1A          STA    -$6,X
9771: A6 98 F5       LDA    [-$0B,X]
9774: A7 0A          STA    $A,X
9776: E7 0C          STB    $C,X
9778: E7 08          STB    $8,X
977A: 86 08          LDA    #$08
977C: AB 0F          ADDA   $F,X
977E: A7 0F          STA    $F,X
9780: 39             RTS
9781: 6A 04          DEC    $4,X
9783: 27 01          BEQ    $9786
9785: 39             RTS
9786: 6C 1A          INC    -$6,X
9788: CC 3F 69       LDD    #$3F69
978B: A7 04          STA    $4,X
978D: E7 0A          STB    $A,X
978F: E7 88 2A       STB    $2A,X
9792: 39             RTS
9793: 6A 04          DEC    $4,X
9795: 27 12          BEQ    $97A9
9797: A6 04          LDA    $4,X
9799: 85 04          BITA   #$04
979B: 26 04          BNE    $97A1
979D: 86 1A          LDA    #$1A
979F: 20 02          BRA    $97A3
97A1: 86 69          LDA    #$69
97A3: A7 0A          STA    $A,X
97A5: A7 88 2A       STA    $2A,X
97A8: 39             RTS
97A9: 6C 1A          INC    -$6,X
97AB: CC 40 C0       LDD    #$40C0
97AE: A7 88 4D       STA    $4D,X
97B1: E7 88 6D       STB    $6D,X
97B4: 86 5A          LDA    #$5A
97B6: A7 0A          STA    $A,X
97B8: A7 88 2A       STA    $2A,X
97BB: CC 58 01       LDD    #$5801
97BE: ED 88 4A       STD    $4A,X
97C1: ED 88 6A       STD    $6A,X
97C4: CC 02 A8       LDD    #$02A8
97C7: A7 88 48       STA    $48,X
97CA: E7 88 4F       STB    $4F,X
97CD: E7 88 6F       STB    $6F,X
97D0: CC 00 05       LDD    #$0005
97D3: A7 88 4C       STA    $4C,X
97D6: A7 88 6C       STA    $6C,X
97D9: E7 04          STB    $4,X
97DB: 39             RTS
97DC: 6A 04          DEC    $4,X
97DE: 27 01          BEQ    $97E1
97E0: 39             RTS
97E1: 6C 1A          INC    -$6,X
97E3: CC 5B 59       LDD    #$5B59
97E6: A7 0A          STA    $A,X
97E8: A7 88 2A       STA    $2A,X
97EB: E7 88 4A       STB    $4A,X
97EE: E7 88 6A       STB    $6A,X
97F1: CC 50 B0       LDD    #$50B0
97F4: A7 89 00 8D    STA    $008D,X
97F8: E7 89 00 AD    STB    $00AD,X
97FC: CC 02 A8       LDD    #$02A8
97FF: A7 89 00 88    STA    $0088,X
9803: E7 89 00 8F    STB    $008F,X
9807: E7 89 00 AF    STB    $00AF,X
980B: CC 00 68       LDD    #$0068
980E: A7 89 00 8C    STA    $008C,X
9812: A7 89 00 AC    STA    $00AC,X
9816: E7 89 00 8A    STB    $008A,X
981A: E7 89 00 AA    STB    $00AA,X
981E: CC 01 07       LDD    #$0107
9821: A7 89 00 8B    STA    $008B,X
9825: A7 89 00 AB    STA    $00AB,X
9829: E7 04          STB    $4,X
982B: 39             RTS
982C: 6A 04          DEC    $4,X
982E: 27 01          BEQ    $9831
9830: 39             RTS
9831: 6C 1A          INC    -$6,X
9833: CC 60 A0       LDD    #$60A0
9836: A7 89 00 CD    STA    $00CD,X
983A: E7 89 00 ED    STB    $00ED,X
983E: CC 02 A8       LDD    #$02A8
9841: A7 89 00 C8    STA    $00C8,X
9845: E7 89 00 CF    STB    $00CF,X
9849: E7 89 00 EF    STB    $00EF,X
984D: CC 00 3F       LDD    #$003F
9850: A7 89 00 CC    STA    $00CC,X
9854: A7 89 00 EC    STA    $00EC,X
9858: E7 04          STB    $4,X
985A: CC 5E 5C       LDD    #$5E5C
985D: A7 0A          STA    $A,X
985F: A7 88 2A       STA    $2A,X
9862: E7 88 4A       STB    $4A,X
9865: E7 88 6A       STB    $6A,X
9868: CC 63 61       LDD    #$6361
986B: A7 89 00 8A    STA    $008A,X
986F: A7 89 00 AA    STA    $00AA,X
9873: E7 89 00 CA    STB    $00CA,X
9877: E7 89 00 EA    STB    $00EA,X
987B: 6C 89 00 CB    INC    $00CB,X
987F: 6C 89 00 EB    INC    $00EB,X
9883: 39             RTS
9884: 6A 04          DEC    $4,X
9886: 27 39          BEQ    $98C1
9888: A6 04          LDA    $4,X
988A: 84 04          ANDA   #$04
988C: 44             LSRA
988D: 44             LSRA
988E: B7 10 34       STA    $1034
9891: A6 0A          LDA    $A,X
9893: 84 5E          ANDA   #$5E
9895: BA 10 34       ORA    $1034
9898: A7 0A          STA    $A,X
989A: A7 88 2A       STA    $2A,X
989D: 80 02          SUBA   #$02
989F: A7 88 4A       STA    $4A,X
98A2: A7 88 6A       STA    $6A,X
98A5: 86 03          LDA    #$03
98A7: BB 10 34       ADDA   $1034
98AA: 84 05          ANDA   #$05
98AC: 8A 60          ORA    #$60
98AE: A7 89 00 CA    STA    $00CA,X
98B2: A7 89 00 EA    STA    $00EA,X
98B6: 8B 02          ADDA   #$02
98B8: A7 89 00 8A    STA    $008A,X
98BC: A7 89 00 AA    STA    $00AA,X
98C0: 39             RTS
98C1: 6C 1A          INC    -$6,X
98C3: CC 62 60       LDD    #$6260
98C6: A7 0A          STA    $A,X
98C8: A7 88 2A       STA    $2A,X
98CB: E7 88 4A       STB    $4A,X
98CE: E7 88 6A       STB    $6A,X
98D1: CC 67 65       LDD    #$6765
98D4: A7 89 00 8A    STA    $008A,X
98D8: A7 89 00 AA    STA    $00AA,X
98DC: E7 89 00 CA    STB    $00CA,X
98E0: E7 89 00 EA    STB    $00EA,X
98E4: 86 07          LDA    #$07
98E6: A7 04          STA    $4,X
98E8: 39             RTS
98E9: 6A 04          DEC    $4,X
98EB: 27 01          BEQ    $98EE
98ED: 39             RTS
98EE: BF 10 36       STX    $1036
98F1: 8E 20 90       LDX    #$2090
98F4: BD 87 32       JSR    $8732
98F7: 30 88 20       LEAX   $20,X
98FA: 8C 21 50       CMPX   #$2150
98FD: 26 F5          BNE    $98F4
98FF: BE 10 36       LDX    $1036
9902: 86 1A          LDA    #$1A
9904: A7 0A          STA    $A,X
9906: A7 88 2A       STA    $2A,X
9909: CC 08 B4       LDD    #$08B4
990C: A7 1A          STA    -$6,X
990E: E7 04          STB    $4,X
9910: 39             RTS
9911: 12             NOP
9912: 39             RTS

9945: D0 1A          SUBB   $1A
9947: 4A             DECA
9948: 01 74          NEG    $74
994A: 05 76          LSR    $76
994C: 05 C8          LSR    $C8
994E: CC D0 1E       LDD    #$D01E
9951: D4 D8          ANDB   $D8
9953: DC 16          LDD    $16
9955: BD 81 50       JSR    suspend_task_8150
9958: B6 10 E5       LDA    $10E5
995B: 27 F8          BEQ    $9955
995D: BD 9A D7       JSR    $9AD7
9960: CC 01 2E       LDD    #$012E
9963: B7 40 4A       STA    $404A
9966: F7 10 4F       STB    $104F
9969: CC 06 08       LDD    #$0608
996C: B7 10 59       STA    $1059
996F: F7 10 5A       STB    $105A
9972: 8E 9C 87       LDX    #$9C87
9975: BF 10 57       STX    $1057
9978: 7C 10 1B       INC    $101B
997B: 86 41          LDA    #$41
997D: BE 10 C7       LDX    $10C7
9980: A7 84          STA    ,X
9982: 30 89 09 60    LEAX   $0960,X
9986: BF 10 C9       STX    $10C9
9989: CC 0A 16       LDD    #$0A16
998C: BD 85 A0       JSR    clear_text_85a0
998F: B6 10 ED       LDA    $10ED
9992: 27 15          BEQ    $99A9
9994: 8E 02 FB       LDX    #$02FB
9997: CE 9C A2       LDU    #$9CA2
999A: 86 14          LDA    #$14
999C: BD 85 90       JSR    write_text_8590
999F: 8E 0A FB       LDX    #$0AFB
99A2: 86 0B          LDA    #$0B
99A4: C6 14          LDB    #$14
99A6: BD 85 A0       JSR    clear_text_85a0
99A9: BD 81 50       JSR    suspend_task_8150
99AC: B6 48 05       LDA    $4805
99AF: 84 08          ANDA   #$08
99B1: 10 26 01 03    LBNE   $9AB8
99B5: B6 48 07       LDA    $4807
99B8: 84 08          ANDA   #$08
99BA: 10 26 00 FA    LBNE   $9AB8
99BE: B6 10 50       LDA    $1050
99C1: 26 07          BNE    $99CA
99C3: 7A 10 4F       DEC    $104F
99C6: 10 27 00 92    LBEQ   $9A5C
99CA: B6 10 ED       LDA    $10ED
99CD: 27 1E          BEQ    $99ED
99CF: B6 10 01       LDA    $1001
99D2: 84 08          ANDA   #$08
99D4: 26 0D          BNE    $99E3
99D6: 8E 02 FB       LDX    #$02FB
99D9: CE 9C A2       LDU    #$9CA2
99DC: 86 14          LDA    #$14
99DE: BD 85 90       JSR    write_text_8590
99E1: 20 0A          BRA    $99ED
99E3: 8E 02 FB       LDX    #$02FB
99E6: 86 20          LDA    #$20
99E8: C6 14          LDB    #$14
99EA: BD 85 A0       JSR    clear_text_85a0
99ED: 86 01          LDA    #$01
99EF: B7 40 4A       STA    $404A
99F2: B1 10 15       CMPA   $1015
99F5: 27 3B          BEQ    $9A32
99F7: B1 10 14       CMPA   $1014
99FA: 27 36          BEQ    $9A32
99FC: 7A 10 5A       DEC    $105A
99FF: 26 A8          BNE    $99A9
9A01: BE 10 57       LDX    $1057
9A04: B6 10 13       LDA    $1013
9A07: 2B 4B          BMI    $9A54
9A09: 81 02          CMPA   #$02
9A0B: 23 0C          BLS    $9A19
9A0D: 30 1F          LEAX   -$1,X
9A0F: 8C 9C 85       CMPX   #$9C85
9A12: 26 0F          BNE    $9A23
9A14: 8E 9C A1       LDX    #$9CA1
9A17: 20 0A          BRA    $9A23
9A19: 30 01          LEAX   $1,X
9A1B: 8C 9C A2       CMPX   #$9CA2
9A1E: 26 03          BNE    $9A23
9A20: 8E 9C 86       LDX    #$9C86
9A23: A6 84          LDA    ,X
9A25: A7 9F 10 C5    STA    [$10C5]
9A29: A7 9F 10 C7    STA    [$10C7]
9A2D: BF 10 57       STX    $1057
9A30: 20 22          BRA    $9A54
9A32: A6 9F 10 57    LDA    [$1057]
9A36: A7 9F 10 C5    STA    [$10C5]
9A3A: 7A 10 59       DEC    $1059
9A3D: 27 1D          BEQ    $9A5C
9A3F: BE 10 C5       LDX    $10C5
9A42: 30 01          LEAX   $1,X
9A44: BF 10 C5       STX    $10C5
9A47: A7 84          STA    ,X
9A49: BE 10 C7       LDX    $10C7
9A4C: 30 88 E0       LEAX   -$20,X
9A4F: BF 10 C7       STX    $10C7
9A52: A7 84          STA    ,X
9A54: 86 08          LDA    #$08
9A56: B7 10 5A       STA    $105A
9A59: 7E 99 A9       JMP    $99A9
9A5C: BE 10 C7       LDX    $10C7
9A5F: CC 00 01       LDD    #$0001
9A62: F7 40 4A       STB    $404A
9A65: A7 89 08 00    STA    $0800,X
9A69: B7 10 1B       STA    $101B
9A6C: BD 81 50       JSR    suspend_task_8150
9A6F: B6 48 05       LDA    $4805
9A72: 84 08          ANDA   #$08
9A74: 26 42          BNE    $9AB8
9A76: B6 48 07       LDA    $4807
9A79: 84 08          ANDA   #$08
9A7B: 26 3B          BNE    $9AB8
9A7D: B6 10 ED       LDA    $10ED
9A80: 27 1E          BEQ    $9AA0
9A82: B6 10 01       LDA    $1001
9A85: 84 08          ANDA   #$08
9A87: 26 0D          BNE    $9A96
9A89: 8E 02 FB       LDX    #$02FB
9A8C: CE 9C A2       LDU    #$9CA2
9A8F: 86 14          LDA    #$14
9A91: BD 85 90       JSR    write_text_8590
9A94: 20 0A          BRA    $9AA0
9A96: 8E 02 FB       LDX    #$02FB
9A99: 86 20          LDA    #$20
9A9B: C6 14          LDB    #$14
9A9D: BD 85 A0       JSR    clear_text_85a0
9AA0: B6 40 4A       LDA    $404A
9AA3: 27 13          BEQ    $9AB8
9AA5: C6 16          LDB    #$16
9AA7: B6 10 01       LDA    $1001
9AAA: 84 08          ANDA   #$08
9AAC: 27 02          BEQ    $9AB0
9AAE: 8B 02          ADDA   #$02
9AB0: BE 10 C9       LDX    $10C9
9AB3: BD 85 A0       JSR    clear_text_85a0
9AB6: 20 B4          BRA    $9A6C
9AB8: 7F 40 4A       CLR    $404A
9ABB: 7F 10 E5       CLR    $10E5
9ABE: 7F 10 ED       CLR    $10ED
9AC1: 7E 99 55       JMP    $9955
9AC4: 8E 11 B0       LDX    #$11B0
9AC7: CE 9C 17       LDU    #$9C17
9ACA: B6 80 00       LDA    watchdog_8000
9ACD: EC C1          LDD    ,U++
9ACF: ED 81          STD    ,X++
9AD1: 8C 12 00       CMPX   #$1200
9AD4: 26 F4          BNE    $9ACA
9AD6: 39             RTS
9AD7: BD 87 06       JSR    clear_screen_8706
9ADA: 8E 02 28       LDX    #$0228
9ADD: CE 9C 67       LDU    #$9C67
9AE0: 86 06          LDA    #$06
9AE2: BD 85 90       JSR    write_text_8590
9AE5: 8E 03 4B       LDX    #$034B
9AE8: CE 9C 6D       LDU    #$9C6D
9AEB: 86 19          LDA    #$19
9AED: BD 85 90       JSR    write_text_8590
9AF0: 8E 0A 28       LDX    #$0A28
9AF3: 86 0D          LDA    #$0D
9AF5: C6 06          LDB    #$06
9AF7: BD 85 A0       JSR    clear_text_85a0
9AFA: 8E 0B 4B       LDX    #$0B4B
9AFD: 86 0E          LDA    #$0E
9AFF: C6 19          LDB    #$19
9B01: BD 85 A0       JSR    clear_text_85a0
9B04: 86 05          LDA    #$05
9B06: 8E 03 18       LDX    #$0318
9B09: A7 83          STA    ,--X
9B0B: 6F 89 FF 00    CLR    -$0100,X
9B0F: 4A             DECA
9B10: 26 F7          BNE    $9B09
9B12: 8E 02 CE       LDX    #$02CE
9B15: CE 11 B0       LDU    #$11B0
9B18: 86 05          LDA    #$05
9B1A: B7 10 CE       STA    $10CE
9B1D: CC 20 06       LDD    #$2006
9B20: B7 10 CF       STA    $10CF
9B23: A6 C0          LDA    ,U+
9B25: 26 07          BNE    $9B2E
9B27: B6 10 CF       LDA    $10CF
9B2A: A7 84          STA    ,X
9B2C: 20 05          BRA    $9B33
9B2E: A7 84          STA    ,X
9B30: 7F 10 CF       CLR    $10CF
9B33: 30 88 E0       LEAX   -$20,X
9B36: 5A             DECB
9B37: 26 EA          BNE    $9B23
9B39: C6 06          LDB    #$06
9B3B: 30 88 C0       LEAX   -$40,X
9B3E: 30 88 E0       LEAX   -$20,X
9B41: A6 C0          LDA    ,U+
9B43: A7 84          STA    ,X
9B45: 5A             DECB
9B46: 26 F6          BNE    $9B3E
9B48: A6 43          LDA    $3,U
9B4A: 33 44          LEAU   $4,U
9B4C: 1F 89          TFR    A,B
9B4E: 84 F0          ANDA   #$F0
9B50: 27 07          BEQ    $9B59
9B52: 44             LSRA
9B53: 44             LSRA
9B54: 44             LSRA
9B55: 44             LSRA
9B56: A7 88 80       STA    -$80,X
9B59: C4 0F          ANDB   #$0F
9B5B: E7 89 FF 60    STB    -$00A0,X
9B5F: 30 89 01 C2    LEAX   $01C2,X
9B63: 7A 10 CE       DEC    $10CE
9B66: 26 B5          BNE    $9B1D
9B68: 39             RTS
9B69: 86 03          LDA    #$03
9B6B: B7 10 09       STA    $1009
9B6E: 8E 10 51       LDX    #$1051
9B71: CE 17 00       LDU    #$1700
9B74: A6 C0          LDA    ,U+
9B76: 1F 89          TFR    A,B
9B78: 84 F0          ANDA   #$F0
9B7A: 44             LSRA
9B7B: 44             LSRA
9B7C: 44             LSRA
9B7D: 44             LSRA
9B7E: A7 80          STA    ,X+
9B80: C4 0F          ANDB   #$0F
9B82: E7 80          STB    ,X+
9B84: 7A 10 09       DEC    $1009
9B87: 26 EB          BNE    $9B74
9B89: CE 10 51       LDU    #$1051
9B8C: 8E 11 F0       LDX    #$11F0
9B8F: EC C4          LDD    ,U
9B91: 10 A3 84       CMPD   ,X
9B94: 22 12          BHI    $9BA8
9B96: 25 1A          BCS    $9BB2
9B98: EC 42          LDD    $2,U
9B9A: 10 A3 02       CMPD   $2,X
9B9D: 22 09          BHI    $9BA8
9B9F: 25 11          BCS    $9BB2
9BA1: EC 44          LDD    $4,U
9BA3: 10 A3 04       CMPD   $4,X
9BA6: 25 0A          BCS    $9BB2
9BA8: 7C 10 09       INC    $1009
9BAB: 30 10          LEAX   -$10,X
9BAD: 8C 11 A0       CMPX   #$11A0
9BB0: 26 DD          BNE    $9B8F
9BB2: B6 10 09       LDA    $1009
9BB5: 26 01          BNE    $9BB8
9BB7: 39             RTS
9BB8: 81 05          CMPA   #$05
9BBA: 26 03          BNE    $9BBF
9BBC: 7C 10 ED       INC    $10ED
9BBF: 1F 89          TFR    A,B
9BC1: 53             COMB
9BC2: C4 07          ANDB   #$07
9BC4: C0 02          SUBB   #$02
9BC6: 58             ASLB
9BC7: 8E 01 AE       LDX    #$01AE
9BCA: 3A             ABX
9BCB: BF 10 C7       STX    $10C7
9BCE: 8E 11 F0       LDX    #$11F0
9BD1: 4A             DECA
9BD2: 27 0F          BEQ    $9BE3
9BD4: C6 08          LDB    #$08
9BD6: EE 10          LDU    -$10,X
9BD8: EF 81          STU    ,X++
9BDA: 5A             DECB
9BDB: 26 F9          BNE    $9BD6
9BDD: 30 88 E0       LEAX   -$20,X
9BE0: 4A             DECA
9BE1: 26 F1          BNE    $9BD4
9BE3: FC 10 51       LDD    $1051
9BE6: ED 81          STD    ,X++
9BE8: FC 10 53       LDD    $1053
9BEB: ED 81          STD    ,X++
9BED: FC 10 55       LDD    $1055
9BF0: ED 81          STD    ,X++
9BF2: 86 41          LDA    #$41
9BF4: BF 10 C5       STX    $10C5
9BF7: A7 80          STA    ,X+
9BF9: CC 20 08       LDD    #$2008
9BFC: A7 80          STA    ,X+
9BFE: 5A             DECB
9BFF: 26 FB          BNE    $9BFC
9C01: B6 17 05       LDA    $1705
9C04: F6 10 E0       LDB    $10E0
9C07: 27 03          BEQ    $9C0C
9C09: 8B 99          ADDA   #$99
9C0B: 19             DAA
9C0C: A7 84          STA    ,X
9C0E: 86 01          LDA    #$01
9C10: B7 10 E5       STA    $10E5
9C13: B7 40 4A       STA    $404A
9C16: 39             RTS

9CB6: BD 81 50       JSR    suspend_task_8150
9CB9: B6 10 E1       LDA    $10E1
9CBC: 27 F8          BEQ    $9CB6
9CBE: BD 87 06       JSR    clear_screen_8706
9CC1: BD 8B 3D       JSR    $8B3D
9CC4: CC 01 01       LDD    #$0101
9CC7: FD 17 04       STD    $1704
9CCA: B7 10 1B       STA    $101B
9CCD: BD 87 C5       JSR    $87C5
9CD0: BD 81 50       JSR    suspend_task_8150
9CD3: B6 10 14       LDA    $1014
9CD6: 26 31          BNE    $9D09
9CD8: B6 10 01       LDA    $1001
9CDB: 84 07          ANDA   #$07
9CDD: 26 F1          BNE    $9CD0
9CDF: F6 10 13       LDB    $1013
9CE2: 2B EC          BMI    $9CD0
9CE4: C5 02          BITB   #$02
9CE6: 26 E8          BNE    $9CD0
9CE8: 8E 17 00       LDX    #$1700
9CEB: A6 05          LDA    $5,X
9CED: C5 04          BITB   #$04
9CEF: 26 0B          BNE    $9CFC
9CF1: 81 32          CMPA   #$32
9CF3: 27 DB          BEQ    $9CD0
9CF5: 6C 04          INC    $4,X
9CF7: 8B 01          ADDA   #$01
9CF9: 19             DAA
9CFA: 20 09          BRA    $9D05
9CFC: 81 01          CMPA   #$01
9CFE: 27 D0          BEQ    $9CD0
9D00: 6A 04          DEC    $4,X
9D02: 8B 99          ADDA   #$99
9D04: 19             DAA
9D05: A7 05          STA    $5,X
9D07: 20 C4          BRA    $9CCD
9D09: 7F 10 E1       CLR    $10E1
9D0C: 7F 10 1B       CLR    $101B
9D0F: 7A 17 04       DEC    $1704
9D12: B6 17 05       LDA    $1705
9D15: 8B 99          ADDA   #$99
9D17: 19             DAA
9D18: B7 17 05       STA    $1705
9D1B: 7C 17 25       INC    $1725
9D1E: 20 96          BRA    $9CB6
9D20: BD 81 50       JSR    suspend_task_8150
9D23: B6 10 E9       LDA    $10E9
9D26: 27 F8          BEQ    $9D20
9D28: B6 10 F0       LDA    $10F0
9D2B: 10 27 01 99    LBEQ   $9EC8
9D2F: BD 87 06       JSR    clear_screen_8706
9D32: B6 10 05       LDA    $1005
9D35: 27 28          BEQ    $9D5F
9D37: 8E 07 BC       LDX    #$07BC
9D3A: 86 20          LDA    #$20
9D3C: C6 0A          LDB    #$0A
9D3E: BD 85 BD       JSR    $85BD
9D41: 8E 07 9C       LDX    #$079C
9D44: 86 20          LDA    #$20
9D46: C6 0A          LDB    #$0A
9D48: BD 85 BD       JSR    $85BD
9D4B: 8E 0F BC       LDX    #$0FBC
9D4E: 86 00          LDA    #$00
9D50: C6 0A          LDB    #$0A
9D52: BD 85 BD       JSR    $85BD
9D55: 8E 0F 9C       LDX    #$0F9C
9D58: 86 00          LDA    #$00
9D5A: C6 0A          LDB    #$0A
9D5C: BD 85 BD       JSR    $85BD
9D5F: 8E 03 2A       LDX    #$032A
9D62: CE 9E D7       LDU    #$9ED7
9D65: 86 18          LDA    #$18
9D67: BD 85 90       JSR    write_text_8590
9D6A: 8E 02 16       LDX    #$0216
9D6D: CE 9E F7       LDU    #$9EF7
9D70: 86 04          LDA    #$04
9D72: BD 85 90       JSR    write_text_8590
9D75: 8E 07 AB       LDX    #$07AB
9D78: CE 88 0D       LDU    #$880D
9D7B: 86 08          LDA    #$08
9D7D: BD 85 AE       JSR    $85AE
9D80: 8E 0B 2A       LDX    #$0B2A
9D83: 86 0D          LDA    #$0D
9D85: C6 18          LDB    #$18
9D87: BD 85 A0       JSR    clear_text_85a0
9D8A: 8E 0A 16       LDX    #$0A16
9D8D: 86 0A          LDA    #$0A
9D8F: C6 04          LDB    #$04
9D91: BD 85 A0       JSR    clear_text_85a0
9D94: CC 3C 06       LDD    #$3C06
9D97: B7 10 50       STA    $1050
9D9A: F7 01 76       STB    $0176
9D9D: 8E 0A AF       LDX    #$0AAF
9DA0: BF 10 C9       STX    $10C9
9DA3: 8E 02 AF       LDX    #$02AF
9DA6: CE 9E EF       LDU    #$9EEF
9DA9: CC 04 0B       LDD    #$040B
9DAC: B7 10 09       STA    $1009
9DAF: F7 09 76       STB    $0976
9DB2: EC C1          LDD    ,U++
9DB4: A7 84          STA    ,X
9DB6: E7 88 E0       STB    -$20,X
9DB9: 30 88 80       LEAX   -$80,X
9DBC: 7A 10 09       DEC    $1009
9DBF: 26 F1          BNE    $9DB2
9DC1: 8E 25 10       LDX    #$2510
9DC4: 6C 0B          INC    $B,X
9DC6: CC 98 B2       LDD    #$98B2
9DC9: A7 0F          STA    $F,X
9DCB: E7 0D          STB    $D,X
9DCD: CC 00 00       LDD    #$0000
9DD0: FD 10 14       STD    $1014
9DD3: 7C 10 1B       INC    $101B
9DD6: CC 08 0B       LDD    #$080B
9DD9: A7 0A          STA    $A,X
9DDB: 6F 0C          CLR    $C,X
9DDD: BE 10 C9       LDX    $10C9
9DE0: E7 84          STB    ,X
9DE2: E7 88 E0       STB    -$20,X
9DE5: A6 89 F7 E0    LDA    -$0820,X
9DE9: E6 89 F8 00    LDB    -$0800,X
9DED: FD 07 A3       STD    $07A3
9DF0: BD 81 50       JSR    suspend_task_8150
9DF3: 8E 25 10       LDX    #$2510
9DF6: B6 10 50       LDA    $1050
9DF9: 26 07          BNE    $9E02
9DFB: 7A 01 76       DEC    $0176
9DFE: 10 27 00 83    LBEQ   $9E85
9E02: FC 10 14       LDD    $1014
9E05: 26 7E          BNE    $9E85
9E07: B6 01 76       LDA    $0176
9E0A: 27 79          BEQ    $9E85
9E0C: B6 10 13       LDA    $1013
9E0F: 2B C5          BMI    $9DD6
9E11: 85 02          BITA   #$02
9E13: 27 C1          BEQ    $9DD6
9E15: 85 04          BITA   #$04
9E17: 26 18          BNE    $9E31
9E19: A6 04          LDA    $4,X
9E1B: 81 03          CMPA   #$03
9E1D: 27 B7          BEQ    $9DD6
9E1F: CC FE 04       LDD    #$FE04
9E22: 6C 04          INC    $4,X
9E24: FE 10 C9       LDU    $10C9
9E27: 6F C4          CLR    ,U
9E29: 6F C8 E0       CLR    -$20,U
9E2C: 33 C8 80       LEAU   -$80,U
9E2F: 20 15          BRA    $9E46
9E31: A6 04          LDA    $4,X
9E33: 27 A1          BEQ    $9DD6
9E35: CC 02 0C       LDD    #$020C
9E38: 6A 04          DEC    $4,X
9E3A: FE 10 C9       LDU    $10C9
9E3D: 6F C4          CLR    ,U
9E3F: 6F C8 E0       CLR    -$20,U
9E42: 33 C9 00 80    LEAU   $0080,U
9E46: FF 10 C9       STU    $10C9
9E49: A7 05          STA    $5,X
9E4B: E7 0A          STB    $A,X
9E4D: 86 0F          LDA    #$0F
9E4F: A7 1B          STA    -$5,X
9E51: A6 1B          LDA    -$5,X
9E53: 27 B2          BEQ    $9E07
9E55: A6 05          LDA    $5,X
9E57: AB 0D          ADDA   $D,X
9E59: A7 0D          STA    $D,X
9E5B: 6A 1B          DEC    -$5,X
9E5D: A6 0A          LDA    $A,X
9E5F: 84 0C          ANDA   #$0C
9E61: B7 10 34       STA    $1034
9E64: A6 1B          LDA    -$5,X
9E66: 84 06          ANDA   #$06
9E68: 44             LSRA
9E69: BB 10 34       ADDA   $1034
9E6C: A7 0A          STA    $A,X
9E6E: 6F 0C          CLR    $C,X
9E70: BD 81 50       JSR    suspend_task_8150
9E73: 8E 25 10       LDX    #$2510
9E76: B6 10 50       LDA    $1050
9E79: 26 D6          BNE    $9E51
9E7B: B6 01 76       LDA    $0176
9E7E: 27 D1          BEQ    $9E51
9E80: 7A 01 76       DEC    $0176
9E83: 20 CC          BRA    $9E51
9E85: CC 3F 08       LDD    #$3F08
9E88: B7 10 4F       STA    $104F
9E8B: F7 25 1A       STB    $251A
9E8E: BE 10 C9       LDX    $10C9
9E91: A6 89 F7 E0    LDA    -$0820,X
9E95: E6 89 F8 00    LDB    -$0800,X
9E99: FD 07 A3       STD    $07A3
9E9C: BD 81 50       JSR    suspend_task_8150
9E9F: 7A 10 4F       DEC    $104F
9EA2: 27 13          BEQ    $9EB7
9EA4: B6 10 01       LDA    $1001
9EA7: 84 08          ANDA   #$08
9EA9: 27 02          BEQ    $9EAD
9EAB: 86 0B          LDA    #$0B
9EAD: BE 10 C9       LDX    $10C9
9EB0: A7 84          STA    ,X
9EB2: A7 88 E0       STA    -$20,X
9EB5: 20 E5          BRA    $9E9C
9EB7: 8E 25 10       LDX    #$2510
9EBA: A6 04          LDA    $4,X
9EBC: CE 9E FB       LDU    #$9EFB
9EBF: 48             ASLA
9EC0: EC C6          LDD    A,U
9EC2: FD 17 04       STD    $1704
9EC5: BD 87 32       JSR    $8732
9EC8: CC 00 01       LDD    #$0001
9ECB: B7 10 1B       STA    $101B
9ECE: B7 10 E9       STA    $10E9
9ED1: F7 17 25       STB    $1725
9ED4: 7E 9D 20       JMP    $9D20


9F03: BD 81 50       JSR    suspend_task_8150
9F06: B6 10 DA       LDA    $10DA
9F09: 27 F8          BEQ    $9F03
9F0B: B7 40 48       STA    $4048
9F0E: BD 81 50       JSR    suspend_task_8150
9F11: B6 10 DA       LDA    $10DA
9F14: 27 ED          BEQ    $9F03
9F16: 7A 25 14       DEC    $2514
9F19: B6 25 14       LDA    $2514
9F1C: 81 50          CMPA   #$50
9F1E: 23 14          BLS    $9F34
9F20: 84 04          ANDA   #$04
9F22: 44             LSRA
9F23: 44             LSRA
9F24: B7 10 34       STA    $1034
9F27: B6 25 1A       LDA    $251A
9F2A: 84 46          ANDA   #$46
9F2C: BA 10 34       ORA    $1034
9F2F: B7 25 1A       STA    $251A
9F32: 20 DA          BRA    $9F0E
9F34: BD 81 50       JSR    suspend_task_8150
9F37: B6 10 DA       LDA    $10DA
9F3A: 27 C7          BEQ    $9F03
9F3C: 8E 25 10       LDX    #$2510
9F3F: 6A 04          DEC    $4,X
9F41: 27 7D          BEQ    $9FC0
9F43: A6 04          LDA    $4,X
9F45: 84 04          ANDA   #$04
9F47: 44             LSRA
9F48: 44             LSRA
9F49: B7 10 34       STA    $1034
9F4C: A6 0A          LDA    $A,X
9F4E: 84 46          ANDA   #$46
9F50: BA 10 34       ORA    $1034
9F53: A7 0A          STA    $A,X
9F55: B6 10 13       LDA    $1013
9F58: 2B DA          BMI    $9F34
9F5A: B7 10 34       STA    $1034
9F5D: BD C9 B8       JSR    $C9B8
9F60: B6 10 D8       LDA    $10D8
9F63: 26 CF          BNE    $9F34
9F65: B6 10 34       LDA    $1034
9F68: A7 05          STA    $5,X
9F6A: 48             ASLA
9F6B: A7 0A          STA    $A,X
9F6D: B6 17 07       LDA    $1707
9F70: A7 03          STA    $3,X
9F72: 6F 1D          CLR    -$3,X
9F74: CC 00 08       LDD    #$0008
9F77: A7 08          STA    $8,X
9F79: EB 0F          ADDB   $F,X
9F7B: C4 F0          ANDB   #$F0
9F7D: E7 0F          STB    $F,X
9F7F: EC 1E          LDD    -$2,X
9F81: C3 00 08       ADDD   #$0008
9F84: C4 F0          ANDB   #$F0
9F86: ED 1E          STD    -$2,X
9F88: 86 10          LDA    #$10
9F8A: A7 1B          STA    -$5,X
9F8C: BD C0 00       JSR    $C000
9F8F: BD C0 9F       JSR    $C09F
9F92: BD C4 80       JSR    $C480
9F95: BD 81 50       JSR    suspend_task_8150
9F98: B6 10 DA       LDA    $10DA
9F9B: 10 27 FF 64    LBEQ   $9F03
9F9F: 8E 25 10       LDX    #$2510
9FA2: A6 05          LDA    $5,X
9FA4: 85 02          BITA   #$02
9FA6: 26 08          BNE    $9FB0
9FA8: A6 0F          LDA    $F,X
9FAA: 84 0F          ANDA   #$0F
9FAC: 26 DE          BNE    $9F8C
9FAE: 20 06          BRA    $9FB6
9FB0: A6 1F          LDA    -$1,X
9FB2: 84 0F          ANDA   #$0F
9FB4: 26 D6          BNE    $9F8C
9FB6: CC 00 01       LDD    #$0001
9FB9: A7 1B          STA    -$5,X
9FBB: E7 1A          STB    -$6,X
9FBD: 7E A0 76       JMP    $A076
9FC0: FC 10 D0       LDD    $10D0
9FC3: 10 26 00 AF    LBNE   $A076
9FC7: CC 01 05       LDD    #$0105
9FCA: B7 40 51       STA    $4051
9FCD: B7 10 D0       STA    $10D0
9FD0: E7 1A          STB    -$6,X
9FD2: CC 00 3F       LDD    #$003F
9FD5: B7 10 4F       STA    $104F
9FD8: E7 04          STB    $4,X
9FDA: C6 08          LDB    #$08
9FDC: A6 0A          LDA    $A,X
9FDE: 84 07          ANDA   #$07
9FE0: 85 04          BITA   #$04
9FE2: 26 5B          BNE    $A03F
9FE4: 81 01          CMPA   #$01
9FE6: 23 4F          BLS    $A037
9FE8: 86 10          LDA    #$10
9FEA: E6 08          LDB    $8,X
9FEC: 26 02          BNE    $9FF0
9FEE: 86 F0          LDA    #$F0
9FF0: EE 1E          LDU    -$2,X
9FF2: 33 C6          LEAU   A,U
9FF4: EF 1E          STU    -$2,X
9FF6: AB 0D          ADDA   $D,X
9FF8: A7 0D          STA    $D,X
9FFA: 86 06          LDA    #$06
9FFC: AB 0F          ADDA   $F,X
9FFE: A7 0F          STA    $F,X
A000: BD CD 83       JSR    $CD83
A003: CE 15 7F       LDU    #$157F
A006: A6 C5          LDA    B,U
A008: 81 0A          CMPA   #$0A
A00A: 24 68          BCC    $A074
A00C: 5C             INCB
A00D: A6 C5          LDA    B,U
A00F: C1 0A          CMPB   #$0A
A011: 25 61          BCS    $A074
A013: E6 0F          LDB    $F,X
A015: CB 18          ADDB   #$18
A017: C4 F0          ANDB   #$F0
A019: CA 1E          ORB    #$1E
A01B: C1 F0          CMPB   #$F0
A01D: 25 02          BCS    $A021
A01F: C6 06          LDB    #$06
A021: E7 0F          STB    $F,X
A023: 86 01          LDA    #$01
A025: B7 10 C0       STA    $10C0
A028: BD C5 34       JSR    $C534
A02B: 81 FC          CMPA   #$FC
A02D: 24 45          BCC    $A074
A02F: 86 E0          LDA    #$E0
A031: AB 0F          ADDA   $F,X
A033: A7 0F          STA    $F,X
A035: 20 3D          BRA    $A074
A037: A6 0F          LDA    $F,X
A039: 8B F8          ADDA   #$F8
A03B: A7 0F          STA    $F,X
A03D: 20 04          BRA    $A043
A03F: A6 0F          LDA    $F,X
A041: 8B 1E          ADDA   #$1E
A043: A7 0F          STA    $F,X
A045: 86 01          LDA    #$01
A047: B7 10 C0       STA    $10C0
A04A: BD C5 34       JSR    $C534
A04D: CC 00 70       LDD    #$0070
A050: E1 C8 40       CMPB   $40,U
A053: 22 02          BHI    $A057
A055: 8A 01          ORA    #$01
A057: E1 C8 20       CMPB   $20,U
A05A: 22 02          BHI    $A05E
A05C: 8A 02          ORA    #$02
A05E: E1 C4          CMPB   ,U
A060: 22 02          BHI    $A064
A062: 8A 04          ORA    #$04
A064: A1 C8 E0       CMPA   -$20,U
A067: 22 02          BHI    $A06B
A069: 8A 08          ORA    #$08
A06B: CE A0 7B       LDU    #$A07B
A06E: E6 C6          LDB    A,U
A070: EB 0D          ADDB   $D,X
A072: E7 0D          STB    $D,X
A074: 6F 08          CLR    $8,X
A076: 7F 10 DA       CLR    $10DA
A079: 7E 9F 03       JMP    $9F03

A08B: BD 81 50       JSR    suspend_task_8150
A08E: B6 25 00       LDA    $2500
A091: 27 F8          BEQ    $A08B
A093: BD A0 FF       JSR    $A0FF
A096: BD 8D BB       JSR    $8DBB
A099: BD 81 50       JSR    suspend_task_8150
A09C: B6 40 40       LDA    $4040
A09F: 26 F8          BNE    $A099
A0A1: 7C 10 DC       INC    $10DC
A0A4: BD 81 50       JSR    suspend_task_8150
A0A7: B6 25 00       LDA    $2500
A0AA: 27 3F          BEQ    $A0EB
A0AC: B6 10 D1       LDA    $10D1
A0AF: 26 1F          BNE    $A0D0
A0B1: B6 10 DA       LDA    $10DA
A0B4: 26 EE          BNE    $A0A4
A0B6: B6 25 02       LDA    $2502
A0B9: 26 E9          BNE    $A0A4
A0BB: B6 25 01       LDA    $2501
A0BE: 26 E4          BNE    $A0A4
A0C0: B6 25 0A       LDA    $250A
A0C3: 27 DF          BEQ    $A0A4
A0C5: 8E 25 10       LDX    #$2510
A0C8: CE A0 F1       LDU    #table_a0f1		; [jump_table]
A0CB: 48             ASLA
A0CC: AD D6          JSR    [A,U]	; [indirect_jump]
A0CE: 20 D4          BRA    $A0A4
A0D0: B6 25 02       LDA    $2502
A0D3: 27 06          BEQ    $A0DB
A0D5: BD A5 4F       JSR    $A54F
A0D8: 7F 25 02       CLR    $2502
A0DB: B6 25 01       LDA    $2501
A0DE: 27 03          BEQ    $A0E3
A0E0: 7F 25 01       CLR    $2501
A0E3: BD 81 50       JSR    suspend_task_8150
A0E6: B6 25 00       LDA    $2500
A0E9: 26 F8          BNE    $A0E3
A0EB: 8E 25 10       LDX    #$2510
A0EE: BD 87 32       JSR    $8732
A0F1: 20 98          BRA    $A08B

A0FF: 8E 25 10       LDX    #$2510
A102: CC 08 01       LDD    #$0801
A105: ED 0A          STD    $A,X
A107: 44             LSRA
A108: A7 05          STA    $5,X
A10A: E7 1A          STB    -$6,X
A10C: B6 17 07       LDA    $1707
A10F: A7 03          STA    $3,X
A111: BD C8 EA       JSR    $C8EA
A114: 7E C4 80       JMP    $C480
A117: B6 10 14       LDA    $1014
A11A: 27 04          BEQ    $A120
A11C: 7C 25 01       INC    $2501
A11F: 39             RTS
A120: B6 10 13       LDA    $1013
A123: 2A 01          BPL    $A126
A125: 39             RTS
A126: A1 05          CMPA   $5,X
A128: 27 7A          BEQ    $A1A4
A12A: F6 10 13       LDB    $1013
A12D: CB 04          ADDB   #$04
A12F: C4 06          ANDB   #$06
A131: E1 05          CMPB   $5,X
A133: 27 63          BEQ    $A198
A135: E6 1B          LDB    -$5,X
A137: 10 27 00 83    LBEQ   $A1BE
A13B: C1 10          CMPB   #$10
A13D: 27 7F          BEQ    $A1BE
A13F: B7 10 C3       STA    $10C3
A142: 7F 10 C4       CLR    $10C4
A145: C1 04          CMPB   #$04
A147: 23 07          BLS    $A150
A149: C1 0C          CMPB   #$0C
A14B: 25 68          BCS    $A1B5
A14D: 7C 10 C4       INC    $10C4
A150: BD C9 78       JSR    $C978
A153: B6 10 D8       LDA    $10D8
A156: 26 5D          BNE    $A1B5
A158: E6 1B          LDB    -$5,X
A15A: B6 10 C4       LDA    $10C4
A15D: 27 14          BEQ    $A173
A15F: 53             COMB
A160: C4 0F          ANDB   #$0F
A162: 5C             INCB
A163: E7 1B          STB    -$5,X
A165: F7 10 C2       STB    $10C2
A168: E6 05          LDB    $5,X
A16A: CB 04          ADDB   #$04
A16C: 5C             INCB
A16D: C4 06          ANDB   #$06
A16F: E7 05          STB    $5,X
A171: 20 03          BRA    $A176
A173: F7 10 C2       STB    $10C2
A176: B6 10 C3       LDA    $10C3
A179: 48             ASLA
A17A: A7 0A          STA    $A,X
A17C: CE A1 90       LDU    #$A190
A17F: 84 08          ANDA   #$08
A181: 44             LSRA
A182: 44             LSRA
A183: 44             LSRA
A184: AB 05          ADDA   $5,X
A186: E6 C6          LDB    A,U
A188: E7 05          STB    $5,X
A18A: 86 03          LDA    #$03
A18C: A7 1A          STA    -$6,X
A18E: 20 42          BRA    $A1D2
A190: 01 07          NEG    $07
A192: 01 03          NEG    $03
A194: 03 05          COM    $05
A196: 07 05          ASR    $05
A198: E6 1B          LDB    -$5,X
A19A: 27 22          BEQ    $A1BE
A19C: 53             COMB
A19D: C4 0F          ANDB   #$0F
A19F: 5C             INCB
A1A0: E7 1B          STB    -$5,X
A1A2: 20 1A          BRA    $A1BE
A1A4: E6 1B          LDB    -$5,X
A1A6: 26 0D          BNE    $A1B5
A1A8: BD C9 4C       JSR    $C94C
A1AB: B6 10 D8       LDA    $10D8
A1AE: 27 01          BEQ    $A1B1
A1B0: 39             RTS
A1B1: 86 10          LDA    #$10
A1B3: A7 1B          STA    -$5,X
A1B5: BD C0 00       JSR    $C000
A1B8: BD C0 9F       JSR    $C09F
A1BB: 7E C4 80       JMP    $C480
A1BE: A7 05          STA    $5,X
A1C0: 48             ASLA
A1C1: A7 0A          STA    $A,X
A1C3: CC 02 08       LDD    #$0208
A1C6: A7 1A          STA    -$6,X
A1C8: E7 04          STB    $4,X
A1CA: 39             RTS
A1CB: 6A 04          DEC    $4,X
A1CD: 26 02          BNE    $A1D1
A1CF: 6A 1A          DEC    -$6,X
A1D1: 39             RTS
A1D2: A6 1B          LDA    -$5,X
A1D4: 27 09          BEQ    $A1DF
A1D6: BD C0 00       JSR    $C000
A1D9: BD C0 9F       JSR    $C09F
A1DC: 7E C4 80       JMP    $C480
A1DF: CC 01 10       LDD    #$0110
A1E2: A7 1A          STA    -$6,X
A1E4: F0 10 C2       SUBB   $10C2
A1E7: E7 1B          STB    -$5,X
A1E9: B6 10 C3       LDA    $10C3
A1EC: A7 05          STA    $5,X
A1EE: 48             ASLA
A1EF: A7 0A          STA    $A,X
A1F1: 39             RTS
A1F2: A6 04          LDA    $4,X
A1F4: 26 03          BNE    $A1F9
A1F6: A7 0B          STA    $B,X
A1F8: 39             RTS
A1F9: 4A             DECA
A1FA: A7 04          STA    $4,X
A1FC: 84 30          ANDA   #$30
A1FE: 44             LSRA
A1FF: 44             LSRA
A200: 44             LSRA
A201: 44             LSRA
A202: 43             COMA
A203: 84 03          ANDA   #$03
A205: 8B 38          ADDA   #$38
A207: A7 0A          STA    $A,X
A209: 39             RTS
A20A: B6 10 10       LDA    $1010
A20D: 26 0E          BNE    $A21D
A20F: B6 10 4F       LDA    $104F
A212: 27 09          BEQ    $A21D
A214: 7A 10 4F       DEC    $104F
A217: 27 01          BEQ    $A21A
A219: 39             RTS
A21A: 7C 40 51       INC    $4051
A21D: A6 04          LDA    $4,X
A21F: 26 03          BNE    $A224
A221: A7 0B          STA    $B,X
A223: 39             RTS
A224: 4A             DECA
A225: A7 04          STA    $4,X
A227: 84 30          ANDA   #$30
A229: 44             LSRA
A22A: 44             LSRA
A22B: 44             LSRA
A22C: 44             LSRA
A22D: 8A 54          ORA    #$54
A22F: A7 0A          STA    $A,X
A231: 39             RTS
A232: BD 81 50       JSR    suspend_task_8150
A235: B6 40 40       LDA    $4040
A238: 26 F8          BNE    $A232
A23A: FC 10 D0       LDD    $10D0
A23D: 26 F3          BNE    $A232
A23F: B6 25 00       LDA    $2500
A242: 27 EE          BEQ    $A232
A244: B6 10 DA       LDA    $10DA
A247: 26 E9          BNE    $A232
A249: B6 25 0A       LDA    $250A
A24C: 81 03          CMPA   #$03
A24E: 27 E2          BEQ    $A232
A250: B6 10 15       LDA    $1015
A253: 81 01          CMPA   #$01
A255: 26 DB          BNE    $A232
A257: 8E 25 10       LDX    #$2510
A25A: A7 12          STA    -$E,X
A25C: F6 25 01       LDB    $2501
A25F: 27 0B          BEQ    $A26C
A261: 6F 11          CLR    -$F,X
A263: F6 17 07       LDB    $1707
A266: E7 03          STB    $3,X
A268: 6F 1D          CLR    -$3,X
A26A: 6F 08          CLR    $8,X
A26C: B7 40 45       STA    $4045
A26F: A6 05          LDA    $5,X
A271: 8B 48          ADDA   #$48
A273: A7 0A          STA    $A,X
A275: 6F 88 BA       CLR    -$46,X
A278: 8E 24 D0       LDX    #$24D0
A27B: CE A2 E9       LDU    #table_a2e9			; [jump_table]
A27E: A6 1A          LDA    -$6,X
A280: 48             ASLA
A281: AD D6          JSR    [A,U]	; [indirect_jump]
A283: A6 1A          LDA    -$6,X
A285: 2B 0F          BMI    $A296
A287: BD 81 50       JSR    suspend_task_8150
A28A: B6 25 02       LDA    $2502
A28D: 27 A3          BEQ    $A232
A28F: FC 10 D0       LDD    $10D0
A292: 26 9E          BNE    $A232
A294: 20 E2          BRA    $A278
A296: BD A5 4F       JSR    $A54F
A299: B6 25 15       LDA    $2515
A29C: 48             ASLA
A29D: B7 25 1A       STA    $251A
A2A0: BD 81 50       JSR    suspend_task_8150
A2A3: FC 10 D0       LDD    $10D0
A2A6: 26 8A          BNE    $A232
A2A8: B6 25 02       LDA    $2502
A2AB: 27 85          BEQ    $A232
A2AD: 8E 25 10       LDX    #$2510
A2B0: B6 10 15       LDA    $1015
A2B3: 81 01          CMPA   #$01
A2B5: 27 B5          BEQ    $A26C
A2B7: B6 10 14       LDA    $1014
A2BA: 26 1A          BNE    $A2D6
A2BC: B6 10 13       LDA    $1013
A2BF: 2B DF          BMI    $A2A0
A2C1: CE A2 E1       LDU    #$A2E1
A2C4: E6 C6          LDB    A,U
A2C6: E1 05          CMPB   $5,X
A2C8: 26 0C          BNE    $A2D6
A2CA: A7 05          STA    $5,X
A2CC: A6 1B          LDA    -$5,X
A2CE: 27 06          BEQ    $A2D6
A2D0: 43             COMA
A2D1: 4C             INCA
A2D2: 84 0F          ANDA   #$0F
A2D4: A7 1B          STA    -$5,X
A2D6: 7F 25 02       CLR    $2502
A2D9: A6 05          LDA    $5,X
A2DB: 48             ASLA
A2DC: A7 0A          STA    $A,X
A2DE: 7E A2 32       JMP    $A232

A2F5: A4 C1          ANDA   ,U++
A2F7: A6 88 45       LDA    $45,X
A2FA: 84 04          ANDA   #$04
A2FC: 48             ASLA
A2FD: 8B FC          ADDA   #$FC
A2FF: E6 88 45       LDB    $45,X
A302: C5 02          BITB   #$02
A304: 26 04          BNE    $A30A
A306: A7 11          STA    -$F,X
A308: 20 02          BRA    $A30C
A30A: A7 12          STA    -$E,X
A30C: A6 88 4F       LDA    $4F,X
A30F: 8B F5          ADDA   #$F5
A311: A7 0F          STA    $F,X
A313: EE 88 3E       LDU    $3E,X
A316: EF 1E          STU    -$2,X
A318: A6 88 4D       LDA    $4D,X
A31B: A7 0D          STA    $D,X
A31D: A6 88 45       LDA    $45,X
A320: 44             LSRA
A321: 8B 78          ADDA   #$78
A323: A7 0A          STA    $A,X
A325: 86 05          LDA    #$05
A327: A7 0B          STA    $B,X
A329: A6 88 45       LDA    $45,X
A32C: 84 02          ANDA   #$02
A32E: 8B 02          ADDA   #$02
A330: A7 14          STA    -$C,X
A332: CC 00 C0       LDD    #$00C0
A335: A7 1D          STA    -$3,X
A337: E7 03          STB    $3,X
A339: 20 49          BRA    $A384
A33B: A6 0F          LDA    $F,X
A33D: A7 88 2F       STA    $2F,X
A340: A6 0D          LDA    $D,X
A342: A7 88 2D       STA    $2D,X
A345: CE A2 E2       LDU    #$A2E2
A348: A6 88 45       LDA    $45,X
A34B: E6 C6          LDB    A,U
A34D: E7 88 2A       STB    $2A,X
A350: 86 05          LDA    #$05
A352: A7 88 2B       STA    $2B,X
A355: 20 2A          BRA    $A381
A357: A6 88 45       LDA    $45,X
A35A: 85 02          BITA   #$02
A35C: 26 13          BNE    $A371
A35E: C6 04          LDB    #$04
A360: E7 88 28       STB    $28,X
A363: 58             ASLB
A364: 85 04          BITA   #$04
A366: 26 01          BNE    $A369
A368: 50             NEGB
A369: EB 88 2F       ADDB   $2F,X
A36C: E7 88 2F       STB    $2F,X
A36F: 20 10          BRA    $A381
A371: C6 08          LDB    #$08
A373: E7 88 28       STB    $28,X
A376: 85 04          BITA   #$04
A378: 26 01          BNE    $A37B
A37A: 50             NEGB
A37B: EB 88 2D       ADDB   $2D,X
A37E: E7 88 2D       STB    $2D,X
A381: 6F 88 2C       CLR    $2C,X
A384: 86 04          LDA    #$04
A386: A7 1B          STA    -$5,X
A388: 6C 1A          INC    -$6,X
A38A: B6 10 13       LDA    $1013
A38D: 2B 0A          BMI    $A399
A38F: A1 88 45       CMPA   $45,X
A392: 27 05          BEQ    $A399
A394: 86 FF          LDA    #$FF
A396: A7 1A          STA    -$6,X
A398: 39             RTS
A399: A6 1D          LDA    -$3,X
A39B: AB 03          ADDA   $3,X
A39D: 25 04          BCS    $A3A3
A39F: A7 1D          STA    -$3,X
A3A1: 20 1C          BRA    $A3BF
A3A3: A7 1D          STA    -$3,X
A3A5: 6A 1B          DEC    -$5,X
A3A7: A6 11          LDA    -$F,X
A3A9: AB 0F          ADDA   $F,X
A3AB: 81 01          CMPA   #$01
A3AD: 27 E5          BEQ    $A394
A3AF: A7 0F          STA    $F,X
A3B1: A6 12          LDA    -$E,X
A3B3: EE 1E          LDU    -$2,X
A3B5: 33 C6          LEAU   A,U
A3B7: EF 1E          STU    -$2,X
A3B9: AB 0D          ADDA   $D,X
A3BB: A7 0D          STA    $D,X
A3BD: 6F 0C          CLR    $C,X
A3BF: EE 1E          LDU    -$2,X
A3C1: FF 10 3A       STU    $103A
A3C4: CE 25 30       LDU    #$2530
A3C7: 86 0B          LDA    #$0B
A3C9: AB 0F          ADDA   $F,X
A3CB: A7 0F          STA    $F,X
A3CD: A6 50          LDA    -$10,U
A3CF: 27 36          BEQ    $A407
A3D1: A6 4D          LDA    $D,U
A3D3: 27 32          BEQ    $A407
A3D5: A6 5A          LDA    -$6,U
A3D7: 81 12          CMPA   #$12
A3D9: 27 1D          BEQ    $A3F8
A3DB: 81 0D          CMPA   #$0D
A3DD: 24 28          BCC    $A407
A3DF: 81 06          CMPA   #$06
A3E1: 23 15          BLS    $A3F8
A3E3: 81 0B          CMPA   #$0B
A3E5: 24 11          BCC    $A3F8
A3E7: A6 45          LDA    $5,U
A3E9: 84 04          ANDA   #$04
A3EB: 48             ASLA
A3EC: 48             ASLA
A3ED: 8B F8          ADDA   #$F8
A3EF: 10 BE 10 3A    LDY    $103A
A3F3: 31 A6          LEAY   A,Y
A3F5: 10 AF 1E       STY    -$2,X
A3F8: BD C4 F4       JSR    $C4F4
A3FB: B6 10 D3       LDA    $10D3
A3FE: 26 26          BNE    $A426
A400: 10 BE 10 3A    LDY    $103A
A404: 10 AF 1E       STY    -$2,X
A407: 33 C8 20       LEAU   $20,U
A40A: 11 83 26 70    CMPU   #$2670
A40E: 26 BD          BNE    $A3CD
A410: 86 F5          LDA    #$F5
A412: AB 0F          ADDA   $F,X
A414: A7 0F          STA    $F,X
A416: A6 1B          LDA    -$5,X
A418: 27 01          BEQ    $A41B
A41A: 39             RTS
A41B: A6 1A          LDA    -$6,X
A41D: 4C             INCA
A41E: 81 06          CMPA   #$06
A420: 25 01          BCS    $A423
A422: 40             NEGA
A423: A7 1A          STA    -$6,X
A425: 39             RTS
A426: 10 BE 10 3A    LDY    $103A
A42A: 10 AF 1E       STY    -$2,X
A42D: EF 15          STU    -$B,X
A42F: A6 5A          LDA    -$6,U
A431: 81 02          CMPA   #$02
A433: 26 1F          BNE    $A454
A435: 68 43          ASL    $3,U
A437: 68 43          ASL    $3,U
A439: 6F 54          CLR    -$C,U
A43B: A6 5B          LDA    -$5,U
A43D: 27 15          BEQ    $A454
A43F: 84 0F          ANDA   #$0F
A441: A7 5B          STA    -$5,U
A443: 81 09          CMPA   #$09
A445: 25 0D          BCS    $A454
A447: 40             NEGA
A448: 84 0F          ANDA   #$0F
A44A: A7 5B          STA    -$5,U
A44C: A6 45          LDA    $5,U
A44E: 8B 04          ADDA   #$04
A450: 84 07          ANDA   #$07
A452: A7 45          STA    $5,U
A454: CC 06 F5       LDD    #$06F5
A457: A7 1A          STA    -$6,X
A459: 7F 40 45       CLR    $4045
A45C: EB 0F          ADDB   $F,X
A45E: E7 0F          STB    $F,X
A460: 86 6A          LDA    #$6A
A462: E6 59          LDB    -$7,U
A464: 2A 01          BPL    $A467
A466: 4C             INCA
A467: A7 4A          STA    $A,U
A469: 6C 52          INC    -$E,U
A46B: A6 52          LDA    -$E,U
A46D: 81 04          CMPA   #$04
A46F: 10 27 00 B5    LBEQ   $A528
A473: 86 5A          LDA    #$5A
A475: A7 44          STA    $4,U
A477: A6 5A          LDA    -$6,U
A479: 81 0C          CMPA   #$0C
A47B: 27 3C          BEQ    $A4B9
A47D: E6 59          LDB    -$7,U
A47F: 2A 32          BPL    $A4B3
A481: 81 06          CMPA   #$06
A483: 25 2E          BCS    $A4B3
A485: 27 2A          BEQ    $A4B1
A487: 81 0B          CMPA   #$0B
A489: 24 28          BCC    $A4B3
A48B: A6 45          LDA    $5,U
A48D: 84 04          ANDA   #$04
A48F: 48             ASLA
A490: 48             ASLA
A491: 8B F8          ADDA   #$F8
A493: 40             NEGA
A494: 10 AE 5E       LDY    -$2,U
A497: 31 A6          LEAY   A,Y
A499: 10 AF 5E       STY    -$2,U
A49C: AB 4D          ADDA   $D,U
A49E: A7 4D          STA    $D,U
A4A0: A6 53          LDA    -$D,U
A4A2: 27 0D          BEQ    $A4B1
A4A4: BF 10 36       STX    $1036
A4A7: AE 55          LDX    -$B,U
A4A9: BD 87 32       JSR    $8732
A4AC: BE 10 36       LDX    $1036
A4AF: 6F 53          CLR    -$D,U
A4B1: 6F 5B          CLR    -$5,U
A4B3: 86 0C          LDA    #$0C
A4B5: A7 5A          STA    -$6,U
A4B7: 6F 54          CLR    -$C,U
A4B9: 86 24          LDA    #$24
A4BB: A7 04          STA    $4,X
A4BD: A6 1C          LDA    -$4,X
A4BF: 26 3F          BNE    $A500
A4C1: 6F 1C          CLR    -$4,X
A4C3: B6 10 13       LDA    $1013
A4C6: 2B 05          BMI    $A4CD
A4C8: 86 FF          LDA    #$FF
A4CA: A7 1A          STA    -$6,X
A4CC: 39             RTS
A4CD: EE 15          LDU    -$B,X
A4CF: A6 5A          LDA    -$6,U
A4D1: 81 0C          CMPA   #$0C
A4D3: 26 F3          BNE    $A4C8
A4D5: A6 52          LDA    -$E,U
A4D7: 27 EF          BEQ    $A4C8
A4D9: 6A 04          DEC    $4,X
A4DB: 27 15          BEQ    $A4F2
A4DD: B6 10 15       LDA    $1015
A4E0: 26 01          BNE    $A4E3
A4E2: 39             RTS
A4E3: 81 01          CMPA   #$01
A4E5: 26 19          BNE    $A500
A4E7: 64 04          LSR    $4,X
A4E9: 26 15          BNE    $A500
A4EB: A7 1C          STA    -$4,X
A4ED: 6F 04          CLR    $4,X
A4EF: 7E A4 69       JMP    $A469
A4F2: B6 10 15       LDA    $1015
A4F5: 10 26 FF 70    LBNE   $A469
A4F9: 86 0E          LDA    #$0E
A4FB: A7 04          STA    $4,X
A4FD: 39             RTS
A4FE: A7 04          STA    $4,X
A500: B6 10 01       LDA    $1001
A503: 84 04          ANDA   #$04
A505: 44             LSRA
A506: 44             LSRA
A507: B7 10 34       STA    $1034
A50A: 86 01          LDA    #$01
A50C: B7 40 46       STA    $4046
A50F: A6 88 4A       LDA    $4A,X
A512: 84 4E          ANDA   #$4E
A514: BA 10 34       ORA    $1034
A517: A7 88 4A       STA    $4A,X
A51A: B6 10 01       LDA    $1001
A51D: 84 02          ANDA   #$02
A51F: 44             LSRA
A520: 8B 06          ADDA   #$06
A522: A7 88 2B       STA    $2B,X
A525: A7 0B          STA    $B,X
A527: 39             RTS
A528: 7C 40 50       INC    $4050
A52B: CC 1E 0D       LDD    #$1E0D
A52E: A7 44          STA    $4,U
A530: E7 5A          STB    -$6,U
A532: A6 88 45       LDA    $45,X
A535: 84 02          ANDA   #$02
A537: A7 54          STA    -$C,U
A539: 86 D0          LDA    #$D0
A53B: E6 59          LDB    -$7,U
A53D: 2A 02          BPL    $A541
A53F: 8B 0C          ADDA   #$0C
A541: A7 4A          STA    $A,U
A543: CC 00 FF       LDD    #$00FF
A546: B7 40 45       STA    $4045
A549: B7 40 46       STA    $4046
A54C: E7 1A          STB    -$6,X
A54E: 39             RTS
A54F: 8E 24 D0       LDX    #$24D0
A552: BD 87 32       JSR    $8732
A555: 8E 24 F0       LDX    #$24F0
A558: 7E 87 32       JMP    $8732
A55B: BD 81 50       JSR    suspend_task_8150
A55E: B6 25 01       LDA    $2501
A561: 27 F8          BEQ    $A55B
A563: B7 40 47       STA    $4047
A566: 8E 25 10       LDX    #$2510
A569: BD A6 78       JSR    $A678
A56C: 64 03          LSR    $3,X
A56E: A6 1B          LDA    -$5,X
A570: 27 4A          BEQ    $A5BC
A572: E6 05          LDB    $5,X
A574: CE A6 8C       LDU    #$A68C
A577: A1 C5          CMPA   B,U
A579: 23 05          BLS    $A580
A57B: 5C             INCB
A57C: A1 C5          CMPA   B,U
A57E: 25 2A          BCS    $A5AA
A580: 86 04          LDA    #$04
A582: AB 0F          ADDA   $F,X
A584: 84 F0          ANDA   #$F0
A586: A7 0F          STA    $F,X
A588: CC 00 04       LDD    #$0004
A58B: E3 1E          ADDD   -$2,X
A58D: C4 F0          ANDB   #$F0
A58F: ED 1E          STD    -$2,X
A591: 6F 1B          CLR    -$5,X
A593: BD C4 80       JSR    $C480
A596: 20 24          BRA    $A5BC
A598: BD 81 50       JSR    suspend_task_8150
A59B: B6 25 01       LDA    $2501
A59E: 27 BB          BEQ    $A55B
A5A0: B7 40 47       STA    $4047
A5A3: B6 10 14       LDA    $1014
A5A6: 10 27 00 B7    LBEQ   $A661
A5AA: 8E 25 10       LDX    #$2510
A5AD: A6 1B          LDA    -$5,X
A5AF: 27 0B          BEQ    $A5BC
A5B1: BD C0 00       JSR    $C000
A5B4: BD C4 80       JSR    $C480
A5B7: BD C0 78       JSR    $C078
A5BA: 20 DC          BRA    $A598
A5BC: 86 01          LDA    #$01
A5BE: B7 10 C0       STA    $10C0
A5C1: BD C5 34       JSR    $C534
A5C4: C1 30          CMPB   #$30
A5C6: 26 7B          BNE    $A643
A5C8: FF 10 3E       STU    $103E
A5CB: E6 05          LDB    $5,X
A5CD: 20 13          BRA    $A5E2
A5CF: F6 10 13       LDB    $1013
A5D2: 2B 2D          BMI    $A601
A5D4: E1 05          CMPB   $5,X
A5D6: 27 0A          BEQ    $A5E2
A5D8: E7 05          STB    $5,X
A5DA: BD A6 78       JSR    $A678
A5DD: E6 05          LDB    $5,X
A5DF: FE 10 3E       LDU    $103E
A5E2: C5 04          BITB   #$04
A5E4: 26 04          BNE    $A5EA
A5E6: A6 C4          LDA    ,U
A5E8: 20 03          BRA    $A5ED
A5EA: A6 C8 21       LDA    $21,U
A5ED: C5 02          BITB   #$02
A5EF: 26 06          BNE    $A5F7
A5F1: 85 01          BITA   #$01
A5F3: 26 0C          BNE    $A601
A5F5: 20 04          BRA    $A5FB
A5F7: 85 02          BITA   #$02
A5F9: 26 06          BNE    $A601
A5FB: F7 10 40       STB    $1040
A5FE: 7C 10 D5       INC    $10D5
A601: BD C0 78       JSR    $C078
A604: BD 81 50       JSR    suspend_task_8150
A607: B6 25 01       LDA    $2501
A60A: 10 27 FF 4D    LBEQ   $A55B
A60E: B6 10 14       LDA    $1014
A611: 27 4E          BEQ    $A661
A613: B7 40 47       STA    $4047
A616: 8E 25 10       LDX    #$2510
A619: B6 10 D5       LDA    $10D5
A61C: 26 E3          BNE    $A601
A61E: FE 10 3E       LDU    $103E
A621: E6 C9 08 00    LDB    $0800,U
A625: C1 30          CMPB   #$30
A627: 27 A6          BEQ    $A5CF
A629: 20 D6          BRA    $A601
A62B: BD C0 78       JSR    $C078
A62E: BD 81 50       JSR    suspend_task_8150
A631: B6 25 01       LDA    $2501
A634: 10 27 FF 23    LBEQ   $A55B
A638: B6 10 14       LDA    $1014
A63B: 27 24          BEQ    $A661
A63D: B7 40 47       STA    $4047
A640: 8E 25 10       LDX    #$2510
A643: B6 10 13       LDA    $1013
A646: 2B E3          BMI    $A62B
A648: A1 05          CMPA   $5,X
A64A: 27 06          BEQ    $A652
A64C: A7 05          STA    $5,X
A64E: 8D 28          BSR    $A678
A650: A6 05          LDA    $5,X
A652: BD C9 4C       JSR    $C94C
A655: B6 10 D8       LDA    $10D8
A658: 26 D1          BNE    $A62B
A65A: 86 10          LDA    #$10
A65C: A7 1B          STA    -$5,X
A65E: 7E A5 B1       JMP    $A5B1
A661: 8E 25 10       LDX    #$2510
A664: A6 05          LDA    $5,X
A666: 48             ASLA
A667: A7 0A          STA    $A,X
A669: B6 17 07       LDA    $1707
A66C: A7 03          STA    $3,X
A66E: 6F 08          CLR    $8,X
A670: 6F 1D          CLR    -$3,X
A672: 7F 25 01       CLR    $2501
A675: 7E A5 5B       JMP    $A55B
A678: CE A6 84       LDU    #$A684
A67B: E6 05          LDB    $5,X
A67D: EC C5          LDD    B,U
A67F: A7 0A          STA    $A,X
A681: E7 08          STB    $8,X
A683: 39             RTS
A684: 30 04          LEAX   $4,X
A686: 20 04          BRA    $A68C
A688: 28 04          BVC    $A68E
A68A: 20 06          BRA    $A692
A68C: 04 0C          LSR    $0C
A68E: 04 0C          LSR    $0C
A690: 04 09          LSR    $09
A692: 04 0C          LSR    $0C
A694: 7F 10 D5       CLR    $10D5
A697: BD 81 50       JSR    suspend_task_8150
A69A: B6 10 D5       LDA    $10D5
A69D: 27 F8          BEQ    $A697
A69F: B6 10 3F       LDA    $103F
A6A2: 84 1C          ANDA   #$1C
A6A4: 44             LSRA
A6A5: 44             LSRA
A6A6: B7 10 CE       STA    $10CE
A6A9: FC 10 3E       LDD    $103E
A6AC: 58             ASLB
A6AD: 49             ROLA
A6AE: 48             ASLA
A6AF: 48             ASLA
A6B0: 48             ASLA
A6B1: BB 10 CE       ADDA   $10CE
A6B4: B7 10 C1       STA    $10C1
A6B7: CE 15 00       LDU    #$1500
A6BA: 8E A8 3C       LDX    #$A83C
A6BD: F6 10 40       LDB    $1040
A6C0: 3A             ABX
A6C1: 33 C6          LEAU   A,U
A6C3: E6 80          LDB    ,X+
A6C5: A6 C5          LDA    B,U
A6C7: 2B CB          BMI    $A694
A6C9: E6 84          LDB    ,X
A6CB: A6 C5          LDA    B,U
A6CD: 2B C5          BMI    $A694
A6CF: CE A8 2C       LDU    #$A82C
A6D2: B6 10 40       LDA    $1040
A6D5: 48             ASLA
A6D6: 33 C6          LEAU   A,U
A6D8: EC C1          LDD    ,U++
A6DA: BE 10 3E       LDX    $103E
A6DD: 3A             ABX
A6DE: BF 10 41       STX    $1041
A6E1: 1F 89          TFR    A,B
A6E3: 84 0C          ANDA   #$0C
A6E5: B7 10 46       STA    $1046
A6E8: C4 03          ANDB   #$03
A6EA: F7 10 3C       STB    $103C
A6ED: EC C4          LDD    ,U
A6EF: FD 10 43       STD    $1043
A6F2: 86 04          LDA    #$04
A6F4: B7 10 45       STA    $1045
A6F7: 20 06          BRA    $A6FF
A6F9: BD 81 50       JSR    suspend_task_8150
A6FC: BE 10 41       LDX    $1041
A6FF: 86 02          LDA    #$02
A701: B7 10 09       STA    $1009
A704: B6 10 46       LDA    $1046
A707: B7 10 CE       STA    $10CE
A70A: A6 84          LDA    ,X
A70C: 2B 35          BMI    $A743
A70E: E6 89 08 00    LDB    $0800,X
A712: C1 30          CMPB   #$30
A714: 27 41          BEQ    $A757
A716: C1 1F          CMPB   #$1F
A718: 23 1B          BLS    $A735
A71A: C5 04          BITB   #$04
A71C: 27 04          BEQ    $A722
A71E: C4 0F          ANDB   #$0F
A720: 20 13          BRA    $A735
A722: 81 66          CMPA   #$66
A724: 26 04          BNE    $A72A
A726: 8B 1F          ADDA   #$1F
A728: 20 07          BRA    $A731
A72A: 81 65          CMPA   #$65
A72C: 26 01          BNE    $A72F
A72E: 4C             INCA
A72F: 8B 20          ADDA   #$20
A731: C4 0F          ANDB   #$0F
A733: 20 03          BRA    $A738
A735: BB 10 3C       ADDA   $103C
A738: A7 84          STA    ,X
A73A: FA 10 CE       ORB    $10CE
A73D: E7 89 08 00    STB    $0800,X
A741: 20 19          BRA    $A75C
A743: CE C4 21       LDU    #$C421
A746: A1 C0          CMPA   ,U+
A748: 27 08          BEQ    $A752
A74A: 11 83 C4 40    CMPU   #$C440
A74E: 26 F6          BNE    $A746
A750: 33 41          LEAU   $1,U
A752: E6 C8 3E       LDB    $3E,U
A755: 20 E6          BRA    $A73D
A757: BB 10 3C       ADDA   $103C
A75A: A7 84          STA    ,X
A75C: 7A 10 09       DEC    $1009
A75F: 27 0C          BEQ    $A76D
A761: 74 10 CE       LSR    $10CE
A764: 74 10 CE       LSR    $10CE
A767: F6 10 44       LDB    $1044
A76A: 3A             ABX
A76B: 20 9D          BRA    $A70A
A76D: 7A 10 45       DEC    $1045
A770: 27 0E          BEQ    $A780
A772: BE 10 41       LDX    $1041
A775: B6 10 43       LDA    $1043
A778: 30 86          LEAX   A,X
A77A: BF 10 41       STX    $1041
A77D: 7E A6 F9       JMP    $A6F9
A780: B6 10 C1       LDA    $10C1
A783: 8E 15 00       LDX    #$1500
A786: 30 86          LEAX   A,X
A788: F6 10 40       LDB    $1040
A78B: CE A8 3C       LDU    #$A83C
A78E: 33 C5          LEAU   B,U
A790: E6 C0          LDB    ,U+
A792: 3A             ABX
A793: E6 84          LDB    ,X
A795: FA 10 46       ORB    $1046
A798: C1 0F          CMPB   #$0F
A79A: 26 02          BNE    $A79E
A79C: CA 80          ORB    #$80
A79E: E7 84          STB    ,X
A7A0: E6 C4          LDB    ,U
A7A2: 3A             ABX
A7A3: E6 84          LDB    ,X
A7A5: FA 10 CE       ORB    $10CE
A7A8: C1 0F          CMPB   #$0F
A7AA: 26 02          BNE    $A7AE
A7AC: CA 80          ORB    #$80
A7AE: E7 84          STB    ,X
A7B0: 8E 15 00       LDX    #$1500
A7B3: F6 10 C1       LDB    $10C1
A7B6: 3A             ABX
A7B7: A6 84          LDA    ,X
A7B9: 84 0C          ANDA   #$0C
A7BB: B7 10 34       STA    $1034
A7BE: A6 09          LDA    $9,X
A7C0: 84 03          ANDA   #$03
A7C2: BA 10 34       ORA    $1034
A7C5: 8E A8 44       LDX    #$A844
A7C8: E6 86          LDB    A,X
A7CA: 27 06          BEQ    $A7D2
A7CC: BD C5 74       JSR    $C574
A7CF: 7E A6 94       JMP    $A694
A7D2: B6 10 40       LDA    $1040
A7D5: 81 04          CMPA   #$04
A7D7: 10 26 FE B9    LBNE   $A694
A7DB: 8E 15 80       LDX    #$1580
A7DE: F6 10 C1       LDB    $10C1
A7E1: 3A             ABX
A7E2: E6 02          LDB    $2,X
A7E4: C1 0B          CMPB   #$0B
A7E6: 10 25 FE AA    LBCS   $A694
A7EA: E6 0A          LDB    $A,X
A7EC: C1 0B          CMPB   #$0B
A7EE: 10 25 FE A2    LBCS   $A694
A7F2: CE C3 A1       LDU    #$C3A1
A7F5: 58             ASLB
A7F6: 58             ASLB
A7F7: A6 C5          LDA    B,U
A7F9: 48             ASLA
A7FA: 48             ASLA
A7FB: E6 02          LDB    $2,X
A7FD: 58             ASLB
A7FE: 58             ASLB
A7FF: CB 02          ADDB   #$02
A801: AA C5          ORA    B,U
A803: 10 8E A8 54    LDY    #$A854
A807: BE 10 41       LDX    $1041
A80A: E6 A0          LDB    ,Y+
A80C: 10 27 FE 84    LBEQ   $A694
A810: 3A             ABX
A811: 44             LSRA
A812: 24 F6          BCC    $A80A
A814: E6 84          LDB    ,X
A816: CE C4 21       LDU    #$C421
A819: E1 C0          CMPB   ,U+
A81B: 27 06          BEQ    $A823
A81D: 11 83 C4 40    CMPU   #$C440
A821: 26 F6          BNE    $A819
A823: E6 C8 3E       LDB    $3E,U
A826: E7 89 08 00    STB    $0800,X
A82A: 20 DE          BRA    $A80A

A859: BD 81 50       JSR    suspend_task_8150
A85C: B6 40 40       LDA    $4040
A85F: 26 F8          BNE    $A859
A861: B6 10 D6       LDA    $10D6
A864: 27 F3          BEQ    $A859
A866: 86 3C          LDA    #$3C
A868: B7 10 50       STA    $1050
A86B: BD 81 50       JSR    suspend_task_8150
A86E: B6 10 D6       LDA    $10D6
A871: 27 E6          BEQ    $A859
A873: B6 10 50       LDA    $1050
A876: 10 26 00 AA    LBNE   $A924
A87A: FC 10 D0       LDD    $10D0
A87D: 10 26 00 A3    LBNE   $A924
A881: B6 17 17       LDA    $1717
A884: 10 27 00 9C    LBEQ   $A924
A888: B6 10 E4       LDA    $10E4
A88B: 10 27 00 95    LBEQ   $A924
A88F: B6 10 5C       LDA    $105C
A892: 27 05          BEQ    $A899
A894: 7A 10 5C       DEC    $105C
A897: 26 1F          BNE    $A8B8
A899: 8E 25 30       LDX    #$2530
A89C: A6 10          LDA    -$10,X
A89E: 27 10          BEQ    $A8B0
A8A0: A6 1A          LDA    -$6,X
A8A2: 81 01          CMPA   #$01
A8A4: 26 0A          BNE    $A8B0
A8A6: CC 00 03       LDD    #$0003
A8A9: E7 1A          STB    -$6,X
A8AB: B7 10 E4       STA    $10E4
A8AE: 20 08          BRA    $A8B8
A8B0: 30 88 20       LEAX   $20,X
A8B3: 8C 26 70       CMPX   #$2670
A8B6: 26 E4          BNE    $A89C
A8B8: B6 10 DB       LDA    $10DB
A8BB: 26 1A          BNE    $A8D7
A8BD: F6 17 17       LDB    $1717
A8C0: 8E 25 30       LDX    #$2530
A8C3: A6 10          LDA    -$10,X
A8C5: 27 0A          BEQ    $A8D1
A8C7: A6 19          LDA    -$7,X
A8C9: 2A 06          BPL    $A8D1
A8CB: A6 11          LDA    -$F,X
A8CD: 27 02          BEQ    $A8D1
A8CF: 6A 11          DEC    -$F,X
A8D1: 30 88 20       LEAX   $20,X
A8D4: 5A             DECB
A8D5: 26 EC          BNE    $A8C3
A8D7: B6 10 49       LDA    $1049
A8DA: 27 48          BEQ    $A924
A8DC: 7A 10 49       DEC    $1049
A8DF: 26 05          BNE    $A8E6
A8E1: FC 17 1D       LDD    $171D
A8E4: 20 0B          BRA    $A8F1
A8E6: B6 17 17       LDA    $1717
A8E9: B1 17 1C       CMPA   $171C
A8EC: 22 36          BHI    $A924
A8EE: FC 17 0A       LDD    $170A
A8F1: 7D 10 DB       TST    $10DB
A8F4: 27 03          BEQ    $A8F9
A8F6: 7F 10 DB       CLR    $10DB
A8F9: B7 10 34       STA    $1034
A8FC: 8E 25 30       LDX    #$2530
A8FF: A6 10          LDA    -$10,X
A901: 27 13          BEQ    $A916
A903: A6 1A          LDA    -$6,X
A905: 81 02          CMPA   #$02
A907: 27 0D          BEQ    $A916
A909: A6 19          LDA    -$7,X
A90B: 2A 07          BPL    $A914
A90D: B6 10 34       LDA    $1034
A910: A7 03          STA    $3,X
A912: 20 02          BRA    $A916
A914: E7 03          STB    $3,X
A916: 30 88 20       LEAX   $20,X
A919: 8C 26 70       CMPX   #$2670
A91C: 26 E1          BNE    $A8FF
A91E: CC 00 01       LDD    #$0001
A921: FD 10 DC       STD    $10DC
A924: B6 10 D7       LDA    $10D7
A927: 10 27 FF 40    LBEQ   $A86B
A92B: CC 00 09       LDD    #$0009
A92E: B7 10 CD       STA    $10CD
A931: B7 10 34       STA    $1034
A934: 8E 14 00       LDX    #$1400
A937: A6 85          LDA    B,X
A939: 2F 4E          BLE    $A989
A93B: 6A 85          DEC    B,X
A93D: 26 47          BNE    $A986
A93F: 6A 85          DEC    B,X
A941: F7 10 35       STB    $1035
A944: 7C 10 34       INC    $1034
A947: 3A             ABX
A948: A6 89 01 80    LDA    $0180,X
A94C: 8D 7A          BSR    $A9C8
A94E: 86 0A          LDA    #$0A
A950: A1 89 01 7F    CMPA   $017F,X
A954: 23 05          BLS    $A95B
A956: 4C             INCA
A957: AB 89 01 7F    ADDA   $017F,X
A95B: CE 12 F7       LDU    #$12F7
A95E: E6 89 FE 80    LDB    -$0180,X
A962: 6A C5          DEC    B,U
A964: 26 05          BNE    $A96B
A966: 7C 10 E6       INC    $10E6
A969: 6A C5          DEC    B,U
A96B: 8D 35          BSR    $A9A2
A96D: 30 01          LEAX   $1,X
A96F: 7C 10 35       INC    $1035
A972: A6 89 01 80    LDA    $0180,X
A976: 81 0A          CMPA   #$0A
A978: 23 06          BLS    $A980
A97A: 8D 4C          BSR    $A9C8
A97C: 86 0A          LDA    #$0A
A97E: 8D 22          BSR    $A9A2
A980: F6 10 35       LDB    $1035
A983: 8E 14 00       LDX    #$1400
A986: 7C 10 CD       INC    $10CD
A989: 5C             INCB
A98A: C1 6F          CMPB   #$6F
A98C: 25 A9          BCS    $A937
A98E: B6 10 34       LDA    $1034
A991: 27 03          BEQ    $A996
A993: BD C9 DA       JSR    $C9DA
A996: BD CC 6A       JSR    $CC6A
A999: B6 10 CD       LDA    $10CD
A99C: B7 10 D7       STA    $10D7
A99F: 7E A8 6B       JMP    $A86B
A9A2: BF 10 36       STX    $1036
A9A5: 10 8E D0 E8    LDY    #$D0E8
A9A9: A7 89 01 80    STA    $0180,X
A9AD: 8E D3 88       LDX    #$D388
A9B0: F6 10 35       LDB    $1035
A9B3: 58             ASLB
A9B4: 3A             ABX
A9B5: BF 10 3A       STX    $103A
A9B8: AE 9F 10 3A    LDX    [$103A]
A9BC: C6 20          LDB    #$20
A9BE: 3D             MUL
A9BF: 31 AB          LEAY   D,Y
A9C1: BD C1 67       JSR    $C167
A9C4: BE 10 36       LDX    $1036
A9C7: 39             RTS
A9C8: 81 0D          CMPA   #$0D
A9CA: 26 01          BNE    $A9CD
A9CC: 39             RTS
A9CD: 81 10          CMPA   #$10
A9CF: 26 01          BNE    $A9D2
A9D1: 39             RTS
A9D2: CE 24 B0       LDU    #$24B0
A9D5: E6 50          LDB    -$10,U
A9D7: 27 13          BEQ    $A9EC
A9D9: 33 C8 E0       LEAU   -$20,U
A9DC: 11 83 1F F0    CMPU   #$1FF0
A9E0: 26 F3          BNE    $A9D5
A9E2: 86 42          LDA    #$42
A9E4: B7 07 AF       STA    $07AF
A9E7: B6 80 00       LDA    watchdog_8000
A9EA: 20 FB          BRA    $A9E7
A9EC: BF 10 36       STX    $1036
A9EF: 8E AA 45       LDX    #$AA45
A9F2: C6 04          LDB    #$04
A9F4: E7 4B          STB    $B,U
A9F6: 58             ASLB
A9F7: 81 0B          CMPA   #$0B
A9F9: 24 01          BCC    $A9FC
A9FB: 58             ASLB
A9FC: F7 10 CF       STB    $10CF
A9FF: 48             ASLA
AA00: 30 86          LEAX   A,X
AA02: EC 84          LDD    ,X
AA04: A7 4A          STA    $A,U
AA06: E7 48          STB    $8,U
AA08: 6C 50          INC    -$10,U
AA0A: F6 10 35       LDB    $1035
AA0D: C4 07          ANDB   #$07
AA0F: 86 20          LDA    #$20
AA11: 3D             MUL
AA12: FB 10 CF       ADDB   $10CF
AA15: E7 4F          STB    $F,U
AA17: F6 10 35       LDB    $1035
AA1A: C4 78          ANDB   #$78
AA1C: 86 04          LDA    #$04
AA1E: 3D             MUL
AA1F: C3 00 20       ADDD   #$0020
AA22: ED 5E          STD    -$2,U
AA24: 7C 10 D9       INC    $10D9
AA27: CC 03 10       LDD    #$0310
AA2A: F4 10 CF       ANDB   $10CF
AA2D: 26 01          BNE    $AA30
AA2F: 4A             DECA
AA30: A7 5B          STA    -$5,U
AA32: CC 08 01       LDD    #$0801
AA35: A7 44          STA    $4,U
AA37: F7 40 43       STB    $4043
AA3A: 1E 31          EXG    U,X
AA3C: BD C0 BB       JSR    $C0BB
AA3F: 6F 0C          CLR    $C,X
AA41: BE 10 36       LDX    $1036
AA44: 39             RTS

AA6F: BD 81 50       JSR    suspend_task_8150
AA72: B6 10 D9       LDA    $10D9
AA75: 27 F8          BEQ    $AA6F
AA77: 8E 20 10       LDX    #$2010
AA7A: 7F 10 09       CLR    $1009
AA7D: A6 10          LDA    -$10,X
AA7F: 27 2C          BEQ    $AAAD
AA81: 6A 04          DEC    $4,X
AA83: 26 15          BNE    $AA9A
AA85: 6A 1B          DEC    -$5,X
AA87: 27 21          BEQ    $AAAA
AA89: CC 04 08       LDD    #$0408
AA8C: E7 04          STB    $4,X
AA8E: E6 0A          LDB    $A,X
AA90: C1 BE          CMPB   #$BE
AA92: 25 02          BCS    $AA96
AA94: 44             LSRA
AA95: 44             LSRA
AA96: AB 0A          ADDA   $A,X
AA98: A7 0A          STA    $A,X
AA9A: BD C0 BB       JSR    $C0BB
AA9D: CC 00 01       LDD    #$0001
AAA0: A7 0C          STA    $C,X
AAA2: F7 40 43       STB    $4043
AAA5: 7C 10 09       INC    $1009
AAA8: 20 03          BRA    $AAAD
AAAA: BD 87 32       JSR    $8732
AAAD: 30 88 20       LEAX   $20,X
AAB0: 8C 24 D0       CMPX   #$24D0
AAB3: 26 C8          BNE    $AA7D
AAB5: B6 10 09       LDA    $1009
AAB8: B7 10 D9       STA    $10D9
AABB: 20 B2          BRA    $AA6F
AABD: BD 81 50       JSR    suspend_task_8150
AAC0: B6 10 D2       LDA    $10D2
AAC3: 27 F8          BEQ    $AABD
AAC5: BD 81 50       JSR    suspend_task_8150
AAC8: B6 10 D2       LDA    $10D2
AACB: 27 F0          BEQ    $AABD
AACD: FC 10 D0       LDD    $10D0
AAD0: 10 26 00 A6    LBNE   $AB7A
AAD4: B6 10 50       LDA    $1050
AAD7: 26 EC          BNE    $AAC5
AAD9: 7A 10 4A       DEC    $104A
AADC: 26 E7          BNE    $AAC5
AADE: 7C 10 DB       INC    $10DB
AAE1: 8E 15 80       LDX    #$1580
AAE4: B6 10 11       LDA    $1011
AAE7: 48             ASLA
AAE8: 48             ASLA
AAE9: 48             ASLA
AAEA: B8 10 11       EORA   $1011
AAED: 43             COMA
AAEE: 48             ASLA
AAEF: 79 10 11       ROL    $1011
AAF2: B6 10 11       LDA    $1011
AAF5: 84 7F          ANDA   #$7F
AAF7: 81 78          CMPA   #$78
AAF9: 24 E9          BCC    $AAE4
AAFB: E6 86          LDB    A,X
AAFD: C1 0A          CMPB   #$0A
AAFF: 24 E3          BCC    $AAE4
AB01: 1F 89          TFR    A,B
AB03: 84 07          ANDA   #$07
AB05: 48             ASLA
AB06: 48             ASLA
AB07: 48             ASLA
AB08: 48             ASLA
AB09: 48             ASLA
AB0A: 8B 10          ADDA   #$10
AB0C: B7 10 4C       STA    $104C
AB0F: C4 78          ANDB   #$78
AB11: 86 04          LDA    #$04
AB13: 3D             MUL
AB14: C3 00 20       ADDD   #$0020
AB17: FD 10 4D       STD    $104D
AB1A: 20 12          BRA    $AB2E
AB1C: BD 81 50       JSR    suspend_task_8150
AB1F: B6 10 D2       LDA    $10D2
AB22: 27 99          BEQ    $AABD
AB24: FC 10 D0       LDD    $10D0
AB27: 26 51          BNE    $AB7A
AB29: B6 10 DB       LDA    $10DB
AB2C: 27 2C          BEQ    $AB5A
AB2E: 8E 25 30       LDX    #$2530
AB31: C6 0B          LDB    #$0B
AB33: A6 10          LDA    -$10,X
AB35: 27 08          BEQ    $AB3F
AB37: A6 1A          LDA    -$6,X
AB39: 81 01          CMPA   #$01
AB3B: 26 02          BNE    $AB3F
AB3D: E7 1A          STB    -$6,X
AB3F: 30 88 20       LEAX   $20,X
AB42: 8C 26 70       CMPX   #$2670
AB45: 26 EC          BNE    $AB33
AB47: B6 10 50       LDA    $1050
AB4A: 26 D0          BNE    $AB1C
AB4C: 7A 10 4B       DEC    $104B
AB4F: 26 CB          BNE    $AB1C
AB51: 7F 10 DB       CLR    $10DB
AB54: FC 17 18       LDD    $1718
AB57: FD 10 4A       STD    $104A
AB5A: 8E 25 30       LDX    #$2530
AB5D: C6 01          LDB    #$01
AB5F: A6 10          LDA    -$10,X
AB61: 27 08          BEQ    $AB6B
AB63: A6 1A          LDA    -$6,X
AB65: 81 0B          CMPA   #$0B
AB67: 26 02          BNE    $AB6B
AB69: E7 1A          STB    -$6,X
AB6B: 30 88 20       LEAX   $20,X
AB6E: 8C 26 70       CMPX   #$2670
AB71: 26 EC          BNE    $AB5F
AB73: B6 10 49       LDA    $1049
AB76: 10 26 FF 4B    LBNE   $AAC5
AB7A: BD 81 50       JSR    suspend_task_8150
AB7D: B6 10 D2       LDA    $10D2
AB80: 26 F8          BNE    $AB7A
AB82: 7E AA BD       JMP    $AABD
AB85: BD 81 50       JSR    suspend_task_8150
AB88: B6 10 D2       LDA    $10D2
AB8B: 27 F8          BEQ    $AB85
AB8D: BD AC 90       JSR    $AC90
AB90: BD 81 50       JSR    suspend_task_8150
AB93: B6 40 40       LDA    $4040
AB96: 26 F8          BNE    $AB90
AB98: BD 81 50       JSR    suspend_task_8150
AB9B: B6 10 D2       LDA    $10D2
AB9E: 10 27 00 AD    LBEQ   $AC4F
ABA2: B6 10 D0       LDA    $10D0
ABA5: 26 09          BNE    $ABB0
ABA7: B6 10 D1       LDA    $10D1
ABAA: 10 26 00 96    LBNE   $AC44
ABAE: 20 23          BRA    $ABD3
ABB0: 7F 10 DF       CLR    $10DF
ABB3: C6 05          LDB    #$05
ABB5: 8E 25 30       LDX    #$2530
ABB8: A6 10          LDA    -$10,X
ABBA: 27 0F          BEQ    $ABCB
ABBC: A6 1A          LDA    -$6,X
ABBE: 27 0B          BEQ    $ABCB
ABC0: 81 0C          CMPA   #$0C
ABC2: 24 04          BCC    $ABC8
ABC4: E7 1A          STB    -$6,X
ABC6: 20 03          BRA    $ABCB
ABC8: 7C 10 DF       INC    $10DF
ABCB: 30 88 20       LEAX   $20,X
ABCE: 8C 26 70       CMPX   #$2670
ABD1: 26 E5          BNE    $ABB8
ABD3: 8E 25 30       LDX    #$2530
ABD6: CE AC 66       LDU    #table_ac66				; [jump_table]
ABD9: A6 10          LDA    -$10,X
ABDB: 27 5C          BEQ    $AC39
ABDD: A6 1A          LDA    -$6,X
ABDF: 27 58          BEQ    $AC39
ABE1: 48             ASLA
ABE2: AD D6          JSR    [A,U]	; [indirect_jump]
ABE4: B6 10 D0       LDA    $10D0
ABE7: 26 50          BNE    $AC39
ABE9: A6 1A          LDA    -$6,X
ABEB: 81 14          CMPA   #$14
ABED: 27 04          BEQ    $ABF3
ABEF: 81 0C          CMPA   #$0C
ABF1: 24 46          BCC    $AC39
ABF3: A6 0D          LDA    $D,X
ABF5: 27 42          BEQ    $AC39
ABF7: CE 25 10       LDU    #$2510
ABFA: BD C4 F4       JSR    $C4F4
ABFD: B6 10 D3       LDA    $10D3
AC00: 27 37          BEQ    $AC39	; bra => invincible
AC02: CC 01 06       LDD    #$0106
AC05: B7 10 D0       STA    $10D0
AC08: 6C 4F          INC    $F,U
AC0A: E7 5A          STB    -$6,U
AC0C: CC 3C 57       LDD    #$3C57
AC0F: A7 44          STA    $4,U
AC11: E7 4A          STB    $A,U
AC13: 6F 48          CLR    $8,U
AC15: B6 10 10       LDA    $1010
AC18: 26 08          BNE    $AC22
AC1A: 86 3C          LDA    #$3C
AC1C: B7 10 4F       STA    $104F
AC1F: 7C 40 4D       INC    $404D
AC22: B6 25 02       LDA    $2502
AC25: 27 0C          BEQ    $AC33
AC27: 7F 25 02       CLR    $2502
AC2A: BF 10 36       STX    $1036
AC2D: BD A5 4F       JSR    $A54F
AC30: BE 10 36       LDX    $1036
AC33: 7F 25 01       CLR    $2501
AC36: 7F 10 DA       CLR    $10DA
AC39: 30 88 20       LEAX   $20,X
AC3C: 8C 26 70       CMPX   #$2670
AC3F: 26 95          BNE    $ABD6
AC41: 7E AB 98       JMP    $AB98
AC44: 7F 10 DF       CLR    $10DF
AC47: BD 81 50       JSR    suspend_task_8150
AC4A: B6 10 D2       LDA    $10D2
AC4D: 26 F8          BNE    $AC47
AC4F: 8E 25 30       LDX    #$2530
AC52: A6 10          LDA    -$10,X
AC54: 26 04          BNE    $AC5A
AC56: A6 16          LDA    -$A,X
AC58: 27 03          BEQ    $AC5D
AC5A: BD 87 32       JSR    $8732
AC5D: 30 88 20       LEAX   $20,X
AC60: 8C 27 90       CMPX   #$2790
AC63: 26 ED          BNE    $AC52
AC65: 7E AB 85       JMP    $AB85

AC90: 8E 15 88       LDX    #$1588
AC93: CC 00 0A       LDD    #$000A
AC96: B7 10 69       STA    $1069
AC99: E1 80          CMPB   ,X+
AC9B: 23 01          BLS    $AC9E
AC9D: 4C             INCA
AC9E: 8C 15 F0       CMPX   #$15F0
ACA1: 26 F6          BNE    $AC99
ACA3: 81 01          CMPA   #$01
ACA5: 22 05          BHI    $ACAC
ACA7: 86 10          LDA    #$10
ACA9: B7 10 69       STA    $1069
ACAC: 8E 25 30       LDX    #$2530
ACAF: 7F 10 3C       CLR    $103C
ACB2: CE 17 0D       LDU    #$170D
ACB5: A6 4A          LDA    $A,U
ACB7: B7 10 09       STA    $1009
ACBA: 7C 10 3C       INC    $103C
ACBD: A6 C0          LDA    ,U+
ACBF: 27 F9          BEQ    $ACBA
ACC1: 2B 0A          BMI    $ACCD
ACC3: B6 17 09       LDA    $1709
ACC6: A7 03          STA    $3,X
ACC8: CC 14 01       LDD    #$1401
ACCB: 20 0F          BRA    $ACDC
ACCD: B6 17 08       LDA    $1708
ACD0: A7 03          STA    $3,X
ACD2: CC 80 05       LDD    #$8005
ACD5: A7 19          STA    -$7,X
ACD7: E7 11          STB    -$F,X
ACD9: CC 1C 01       LDD    #$1C01
ACDC: ED 0A          STD    $A,X
ACDE: E7 10          STB    -$10,X
ACE0: CC 04 12       LDD    #$0412
ACE3: A7 05          STA    $5,X
ACE5: E7 1A          STB    -$6,X
ACE7: BD 8A A0       JSR    $8AA0
ACEA: 84 0F          ANDA   #$0F
ACEC: 4C             INCA
ACED: A7 04          STA    $4,X
ACEF: A6 19          LDA    -$7,X
ACF1: BA 10 3C       ORA    $103C
ACF4: A7 19          STA    -$7,X
ACF6: FF 10 38       STU    $1038
ACF9: BD C8 EF       JSR    $C8EF
ACFC: BD C0 BB       JSR    $C0BB
ACFF: FE 10 38       LDU    $1038
AD02: 30 88 20       LEAX   $20,X
AD05: 7A 10 09       DEC    $1009
AD08: 26 B0          BNE    $ACBA
AD0A: CE 94 D9       LDU    #$94D9
AD0D: B6 17 17       LDA    $1717
AD10: E6 C6          LDB    A,U
AD12: F7 10 6C       STB    $106C
AD15: 81 01          CMPA   #$01
AD17: 26 04          BNE    $AD1D
AD19: 86 05          LDA    #$05
AD1B: 20 03          BRA    $AD20
AD1D: B6 17 1F       LDA    $171F
AD20: B7 10 5C       STA    $105C
AD23: B6 17 1B       LDA    $171B
AD26: B7 10 49       STA    $1049
AD29: FC 17 18       LDD    $1718
AD2C: FD 10 4A       STD    $104A
AD2F: CC 00 01       LDD    #$0001
AD32: B7 10 69       STA    $1069
AD35: F7 10 E4       STB    $10E4
AD38: B7 10 6D       STA    $106D
AD3B: 39             RTS
AD3C: 6A 04          DEC    $4,X
AD3E: 10 26 13 79    LBNE   $C0BB
AD42: 86 01          LDA    #$01
AD44: A7 1A          STA    -$6,X
AD46: 7E C0 BB       JMP    $C0BB
AD49: A6 1B          LDA    -$5,X
AD4B: 27 09          BEQ    $AD56
AD4D: BD C0 00       JSR    $C000
AD50: BD C0 9A       JSR    $C09A
AD53: 7E C0 BB       JMP    $C0BB
AD56: A6 19          LDA    -$7,X
AD58: 2A 67          BPL    $ADC1
AD5A: A6 0D          LDA    $D,X
AD5C: 27 63          BEQ    $ADC1
AD5E: E6 05          LDB    $5,X
AD60: C5 02          BITB   #$02
AD62: 27 5D          BEQ    $ADC1
AD64: C5 04          BITB   #$04
AD66: 26 06          BNE    $AD6E
AD68: 81 18          CMPA   #$18
AD6A: 23 55          BLS    $ADC1
AD6C: 20 04          BRA    $AD72
AD6E: 81 E8          CMPA   #$E8
AD70: 24 4F          BCC    $ADC1
AD72: BD 8A A0       JSR    $8AA0
AD75: B1 17 1A       CMPA   $171A
AD78: 23 1A          BLS    $AD94
AD7A: A6 11          LDA    -$F,X
AD7C: 26 43          BNE    $ADC1
AD7E: C5 04          BITB   #$04
AD80: 26 07          BNE    $AD89
AD82: EC 1E          LDD    -$2,X
AD84: B3 25 0E       SUBD   $250E
AD87: 20 05          BRA    $AD8E
AD89: FC 25 0E       LDD    $250E
AD8C: A3 1E          SUBD   -$2,X
AD8E: 10 83 00 40    CMPD   #$0040
AD92: 22 2D          BHI    $ADC1
AD94: CE 25 30       LDU    #$2530
AD97: A6 50          LDA    -$10,U
AD99: 26 1D          BNE    $ADB8
AD9B: A6 56          LDA    -$A,U
AD9D: 26 19          BNE    $ADB8
AD9F: 6C 56          INC    -$A,U
ADA1: EF 15          STU    -$B,X
ADA3: CC 06 3F       LDD    #$063F
ADA6: A7 1A          STA    -$6,X
ADA8: E7 1B          STB    -$5,X
ADAA: 86 6C          LDA    #$6C
ADAC: A7 0A          STA    $A,X
ADAE: A6 05          LDA    $5,X
ADB0: 84 04          ANDA   #$04
ADB2: 44             LSRA
ADB3: A7 08          STA    $8,X
ADB5: 7E C0 BB       JMP    $C0BB
ADB8: 33 C8 20       LEAU   $20,U
ADBB: 11 83 27 70    CMPU   #$2770
ADBF: 26 D6          BNE    $AD97
ADC1: BD B3 BD       JSR    $B3BD
ADC4: A6 1A          LDA    -$6,X
ADC6: 81 01          CMPA   #$01
ADC8: 27 03          BEQ    $ADCD
ADCA: 7E C0 BB       JMP    $C0BB
ADCD: B6 10 34       LDA    $1034
ADD0: A1 05          CMPA   $5,X
ADD2: 27 0B          BEQ    $ADDF
ADD4: E6 0A          LDB    $A,X
ADD6: C4 18          ANDB   #$18
ADD8: FB 10 34       ADDB   $1034
ADDB: E7 0A          STB    $A,X
ADDD: A7 05          STA    $5,X
ADDF: 86 10          LDA    #$10
ADE1: A7 1B          STA    -$5,X
ADE3: BD C0 00       JSR    $C000
ADE6: BD C0 9A       JSR    $C09A
ADE9: 7E C0 BB       JMP    $C0BB
ADEC: A6 1B          LDA    -$5,X
ADEE: 27 09          BEQ    $ADF9
ADF0: BD C0 00       JSR    $C000
ADF3: BD C0 9A       JSR    $C09A
ADF6: 7E C0 BB       JMP    $C0BB
ADF9: A6 1F          LDA    -$1,X
ADFB: 84 10          ANDA   #$10
ADFD: 27 0A          BEQ    $AE09
ADFF: 86 01          LDA    #$01
AE01: A7 1A          STA    -$6,X
AE03: B7 10 E4       STA    $10E4
AE06: 7E AD 56       JMP    $AD56
AE09: BD CD 83       JSR    $CD83
AE0C: A6 0F          LDA    $F,X
AE0E: 85 10          BITA   #$10
AE10: 26 01          BNE    $AE13
AE12: 5A             DECB
AE13: CE 15 80       LDU    #$1580
AE16: 33 C5          LEAU   B,U
AE18: 86 50          LDA    #$50
AE1A: E6 58          LDB    -$8,U
AE1C: C1 09          CMPB   #$09
AE1E: 23 02          BLS    $AE22
AE20: 8A 20          ORA    #$20
AE22: E6 48          LDB    $8,U
AE24: C1 09          CMPB   #$09
AE26: 23 02          BLS    $AE2A
AE28: 8A 80          ORA    #$80
AE2A: B7 10 6A       STA    $106A
AE2D: BD B3 BD       JSR    $B3BD
AE30: A6 17          LDA    -$9,X
AE32: 84 F0          ANDA   #$F0
AE34: B4 10 6A       ANDA   $106A
AE37: 26 09          BNE    $AE42
AE39: A6 1A          LDA    -$6,X
AE3B: 81 02          CMPA   #$02
AE3D: 26 C0          BNE    $ADFF
AE3F: 7E C0 BB       JMP    $C0BB
AE42: C6 04          LDB    #$04
AE44: 49             ROLA
AE45: 25 03          BCS    $AE4A
AE47: 5A             DECB
AE48: 20 FA          BRA    $AE44
AE4A: CE AE 81       LDU    #$AE81
AE4D: 58             ASLB
AE4E: A6 0F          LDA    $F,X
AE50: 84 10          ANDA   #$10
AE52: 44             LSRA
AE53: 33 C6          LEAU   A,U
AE55: 10 AE C5       LDY    B,U
AE58: CE 11 8A       LDU    #$118A
AE5B: A6 19          LDA    -$7,X
AE5D: 84 0F          ANDA   #$0F
AE5F: 48             ASLA
AE60: 10 AF C6       STY    A,U
AE63: CB 0E          ADDB   #$0E
AE65: A6 19          LDA    -$7,X
AE67: 2A 02          BPL    $AE6B
AE69: CB 08          ADDB   #$08
AE6B: E7 0A          STB    $A,X
AE6D: A6 1A          LDA    -$6,X
AE6F: 81 02          CMPA   #$02
AE71: 26 06          BNE    $AE79
AE73: 6F 1B          CLR    -$5,X
AE75: 68 03          ASL    $3,X
AE77: 68 03          ASL    $3,X
AE79: CC 04 3F       LDD    #$043F
AE7C: A7 1A          STA    -$6,X
AE7E: E7 04          STB    $4,X
AE80: 7E C0 BB       JMP    $C0BB

AED3: 6A 04          DEC    $4,X
AED5: 27 15          BEQ    $AEEC
AED7: A6 04          LDA    $4,X
AED9: 84 04          ANDA   #$04
AEDB: 44             LSRA
AEDC: 44             LSRA
AEDD: B7 10 34       STA    $1034
AEE0: A6 0A          LDA    $A,X
AEE2: 84 1E          ANDA   #$1E
AEE4: BB 10 34       ADDA   $1034
AEE7: A7 0A          STA    $A,X
AEE9: 7E C0 BB       JMP    $C0BB
AEEC: 10 8E 11 8A    LDY    #$118A
AEF0: A6 19          LDA    -$7,X
AEF2: 84 0F          ANDA   #$0F
AEF4: 48             ASLA
AEF5: 31 A6          LEAY   A,Y
AEF7: EE A4          LDU    ,Y
AEF9: EC C1          LDD    ,U++
AEFB: EF A4          STU    ,Y
AEFD: A7 05          STA    $5,X
AEFF: E7 1B          STB    -$5,X
AF01: CC 14 C0       LDD    #$14C0
AF04: A7 1A          STA    -$6,X
AF06: E7 03          STB    $3,X
AF08: 7E C0 BB       JMP    $C0BB
AF0B: A6 1B          LDA    -$5,X
AF0D: 27 06          BEQ    $AF15
AF0F: BD C0 00       JSR    $C000
AF12: 7E C0 BB       JMP    $C0BB
AF15: 10 8E 11 8A    LDY    #$118A
AF19: A6 19          LDA    -$7,X
AF1B: 84 0F          ANDA   #$0F
AF1D: 48             ASLA
AF1E: 31 A6          LEAY   A,Y
AF20: EE A4          LDU    ,Y
AF22: EC C1          LDD    ,U++
AF24: 2B 09          BMI    $AF2F
AF26: EF A4          STU    ,Y
AF28: A7 05          STA    $5,X
AF2A: E7 1B          STB    -$5,X
AF2C: 7E C0 BB       JMP    $C0BB
AF2F: CC 10 3F       LDD    #$103F
AF32: A7 1A          STA    -$6,X
AF34: E7 04          STB    $4,X
AF36: A6 0F          LDA    $F,X
AF38: 81 F0          CMPA   #$F0
AF3A: 10 25 11 7D    LBCS   $C0BB
AF3E: 86 06          LDA    #$06
AF40: A7 0F          STA    $F,X
AF42: 7E C0 BB       JMP    $C0BB
AF45: A6 12          LDA    -$E,X
AF47: 81 01          CMPA   #$01
AF49: 26 0B          BNE    $AF56
AF4B: 6F 08          CLR    $8,X
AF4D: 86 6A          LDA    #$6A
AF4F: E6 19          LDB    -$7,X
AF51: 2A 11          BPL    $AF64
AF53: 4C             INCA
AF54: 20 0E          BRA    $AF64
AF56: C6 0C          LDB    #$0C
AF58: E7 08          STB    $8,X
AF5A: 48             ASLA
AF5B: 48             ASLA
AF5C: 8B C0          ADDA   #$C0
AF5E: E6 19          LDB    -$7,X
AF60: 2A 02          BPL    $AF64
AF62: 8B 0C          ADDA   #$0C
AF64: A7 0A          STA    $A,X
AF66: 6A 04          DEC    $4,X
AF68: 26 08          BNE    $AF72
AF6A: 6A 12          DEC    -$E,X
AF6C: 27 07          BEQ    $AF75
AF6E: 86 5A          LDA    #$5A
AF70: A7 04          STA    $4,X
AF72: 7E C0 BB       JMP    $C0BB
AF75: CC 00 01       LDD    #$0001
AF78: A7 08          STA    $8,X
AF7A: E7 1A          STB    -$6,X
AF7C: F1 17 17       CMPB   $1717
AF7F: 26 09          BNE    $AF8A
AF81: CC 01 02       LDD    #$0102
AF84: F7 10 5C       STB    $105C
AF87: B7 10 E4       STA    $10E4
AF8A: A6 05          LDA    $5,X
AF8C: 84 06          ANDA   #$06
AF8E: E6 19          LDB    -$7,X
AF90: 2A 02          BPL    $AF94
AF92: 8B 08          ADDA   #$08
AF94: 8A 10          ORA    #$10
AF96: A7 0A          STA    $A,X
AF98: 7E C0 BB       JMP    $C0BB
AF9B: 6A 04          DEC    $4,X
AF9D: 10 27 00 8F    LBEQ   $B030
AFA1: 7E C0 BB       JMP    $C0BB
AFA4: A6 04          LDA    $4,X
AFA6: 4A             DECA
AFA7: 27 14          BEQ    $AFBD
AFA9: A7 04          STA    $4,X
AFAB: 84 02          ANDA   #$02
AFAD: 44             LSRA
AFAE: B7 10 34       STA    $1034
AFB1: A6 0A          LDA    $A,X
AFB3: 84 1E          ANDA   #$1E
AFB5: BB 10 34       ADDA   $1034
AFB8: A7 0A          STA    $A,X
AFBA: 7E C0 BB       JMP    $C0BB
AFBD: CE 15 80       LDU    #$1580
AFC0: BD CD 83       JSR    $CD83
AFC3: A6 C5          LDA    B,U
AFC5: 81 0A          CMPA   #$0A
AFC7: 25 0E          BCS    $AFD7
AFC9: A6 0F          LDA    $F,X
AFCB: 84 F0          ANDA   #$F0
AFCD: 8A 1E          ORA    #$1E
AFCF: 81 F0          CMPA   #$F0
AFD1: 25 02          BCS    $AFD5
AFD3: 86 06          LDA    #$06
AFD5: A7 0F          STA    $F,X
AFD7: CC 01 3F       LDD    #$013F
AFDA: B7 40 4F       STA    $404F
AFDD: E7 04          STB    $4,X
AFDF: CC 10 89       LDD    #$1089
AFE2: A7 1A          STA    -$6,X
AFE4: E7 0A          STB    $A,X
AFE6: 86 06          LDA    #$06
AFE8: B7 10 C0       STA    $10C0
AFEB: BD C5 34       JSR    $C534
AFEE: 5F             CLRB
AFEF: 81 FC          CMPA   #$FC
AFF1: 25 02          BCS    $AFF5
AFF3: CA 01          ORB    #$01
AFF5: A6 C8 A0       LDA    -$60,U
AFF8: 81 FC          CMPA   #$FC
AFFA: 25 02          BCS    $AFFE
AFFC: CA 02          ORB    #$02
AFFE: C1 03          CMPB   #$03
B000: 10 27 10 B7    LBEQ   $C0BB
B004: 86 04          LDA    #$04
B006: C5 02          BITB   #$02
B008: 27 02          BEQ    $B00C
B00A: 86 FC          LDA    #$FC
B00C: EE 1E          LDU    -$2,X
B00E: 33 C6          LEAU   A,U
B010: EF 1E          STU    -$2,X
B012: 7E C0 BB       JMP    $C0BB
B015: 6A 04          DEC    $4,X
B017: 27 12          BEQ    $B02B
B019: A6 04          LDA    $4,X
B01B: 84 30          ANDA   #$30
B01D: 44             LSRA
B01E: 44             LSRA
B01F: 44             LSRA
B020: 44             LSRA
B021: 43             COMA
B022: 84 03          ANDA   #$03
B024: 8B 38          ADDA   #$38
B026: A7 0A          STA    $A,X
B028: 7E C0 BB       JMP    $C0BB
B02B: 6C 1A          INC    -$6,X
B02D: 7E C0 BB       JMP    $C0BB
B030: CC F5 20       LDD    #$F520
B033: B7 10 34       STA    $1034
B036: A6 19          LDA    -$7,X
B038: 2A 08          BPL    $B042
B03A: A6 14          LDA    -$C,X
B03C: 27 04          BEQ    $B042
B03E: 7C 10 34       INC    $1034
B041: 58             ASLB
B042: 4F             CLRA
B043: BF 10 36       STX    $1036
B046: BD 8A DB       JSR    $8ADB
B049: BE 10 36       LDX    $1036
B04C: CC 13 1F       LDD    #$131F
B04F: A7 1A          STA    -$6,X
B051: E7 04          STB    $4,X
B053: CC 00 0C       LDD    #$000C
B056: A7 08          STA    $8,X
B058: E7 0B          STB    $B,X
B05A: B6 10 34       LDA    $1034
B05D: A7 0A          STA    $A,X
B05F: 7E C0 BB       JMP    $C0BB
B062: 6A 04          DEC    $4,X
B064: 27 03          BEQ    $B069
B066: 7E C0 BB       JMP    $C0BB
B069: CE 17 0C       LDU    #$170C
B06C: A6 19          LDA    -$7,X
B06E: 84 0F          ANDA   #$0F
B070: 6F C6          CLR    A,U
B072: 6A 4B          DEC    $B,U
B074: 27 30          BEQ    $B0A6
B076: A6 4B          LDA    $B,U
B078: 81 01          CMPA   #$01
B07A: 27 13          BEQ    $B08F
B07C: B6 10 E4       LDA    $10E4
B07F: 10 26 D6 AF    LBNE   $8732
B083: CC 01 02       LDD    #$0102
B086: B7 10 E4       STA    $10E4
B089: F7 10 5C       STB    $105C
B08C: 7E 87 32       JMP    $8732
B08F: F6 10 E4       LDB    $10E4
B092: 26 03          BNE    $B097
B094: B7 10 E4       STA    $10E4
B097: 86 05          LDA    #$05
B099: B1 10 5C       CMPA   $105C
B09C: 10 22 D6 92    LBHI   $8732
B0A0: B7 10 5C       STA    $105C
B0A3: 7E 87 32       JMP    $8732
B0A6: 7C 10 D1       INC    $10D1
B0A9: 7E 87 32       JMP    $8732
B0AC: A6 1B          LDA    -$5,X
B0AE: 27 09          BEQ    $B0B9
B0B0: BD C0 00       JSR    $C000
B0B3: BD C0 9A       JSR    $C09A
B0B6: 7E C0 BB       JMP    $C0BB
B0B9: 86 05          LDA    #$05
B0BB: B7 10 C0       STA    $10C0
B0BE: BD C5 34       JSR    $C534
B0C1: BF 10 36       STX    $1036
B0C4: 8E B1 5E       LDX    #$B15E
B0C7: 4F             CLRA
B0C8: E6 81          LDB    ,X++
B0CA: 27 24          BEQ    $B0F0
B0CC: 33 C5          LEAU   B,U
B0CE: E6 C4          LDB    ,U
B0D0: C1 70          CMPB   #$70
B0D2: 24 18          BCC    $B0EC
B0D4: E6 C9 08 00    LDB    $0800,U
B0D8: C1 30          CMPB   #$30
B0DA: 26 08          BNE    $B0E4
B0DC: E6 C4          LDB    ,U
B0DE: C4 03          ANDB   #$03
B0E0: 26 0A          BNE    $B0EC
B0E2: 20 E4          BRA    $B0C8
B0E4: C1 20          CMPB   #$20
B0E6: 24 04          BCC    $B0EC
B0E8: C4 0F          ANDB   #$0F
B0EA: 27 DC          BEQ    $B0C8
B0EC: AA 1F          ORA    -$1,X
B0EE: 20 D8          BRA    $B0C8
B0F0: BE 10 36       LDX    $1036
B0F3: A7 17          STA    -$9,X
B0F5: A6 0F          LDA    $F,X
B0F7: B1 10 4C       CMPA   $104C
B0FA: 27 0E          BEQ    $B10A
B0FC: 25 05          BCS    $B103
B0FE: CC 01 00       LDD    #$0100
B101: 20 03          BRA    $B106
B103: CC 04 04       LDD    #$0404
B106: A4 17          ANDA   -$9,X
B108: 27 3B          BEQ    $B145
B10A: EC 1E          LDD    -$2,X
B10C: 10 B3 10 4D    CMPD   $104D
B110: 27 0E          BEQ    $B120
B112: 25 05          BCS    $B119
B114: CC 02 02       LDD    #$0202
B117: 20 03          BRA    $B11C
B119: CC 08 06       LDD    #$0806
B11C: A4 17          ANDA   -$9,X
B11E: 27 25          BEQ    $B145
B120: CE B1 61       LDU    #$B161
B123: E6 05          LDB    $5,X
B125: 58             ASLB
B126: A6 C5          LDA    B,U
B128: A4 17          ANDA   -$9,X
B12A: 27 18          BEQ    $B144
B12C: CB 0C          ADDB   #$0C
B12E: C4 0C          ANDB   #$0C
B130: A6 C5          LDA    B,U
B132: A4 17          ANDA   -$9,X
B134: 27 0E          BEQ    $B144
B136: CB 08          ADDB   #$08
B138: C4 0C          ANDB   #$0C
B13A: A6 C5          LDA    B,U
B13C: A4 17          ANDA   -$9,X
B13E: 27 04          BEQ    $B144
B140: CB 04          ADDB   #$04
B142: C4 0C          ANDB   #$0C
B144: 54             LSRB
B145: E7 05          STB    $5,X
B147: A6 19          LDA    -$7,X
B149: 2A 02          BPL    $B14D
B14B: CB 08          ADDB   #$08
B14D: CB 10          ADDB   #$10
B14F: E7 0A          STB    $A,X
B151: 86 10          LDA    #$10
B153: A7 1B          STA    -$5,X
B155: BD C0 00       JSR    $C000
B158: BD C0 9A       JSR    $C09A
B15B: 7E C0 BB       JMP    $C0BB

B16F: 12             NOP
B170: E6 05          LDB    $5,X
B172: A6 0F          LDA    $F,X
B174: B1 25 1F       CMPA   $251F
B177: 27 1A          BEQ    $B193
B179: 25 09          BCS    $B184
B17B: C1 04          CMPB   #$04
B17D: 27 14          BEQ    $B193
B17F: CC 11 00       LDD    #$1100
B182: 20 06          BRA    $B18A
B184: 5D             TSTB
B185: 27 0C          BEQ    $B193
B187: CC 44 04       LDD    #$4404
B18A: A4 17          ANDA   -$9,X
B18C: 10 27 00 AB    LBEQ   $B23B
B190: F7 10 CF       STB    $10CF
B193: A6 05          LDA    $5,X
B195: EE 1E          LDU    -$2,X
B197: 11 B3 25 0E    CMPU   $250E
B19B: 27 1B          BEQ    $B1B8
B19D: 25 09          BCS    $B1A8
B19F: 81 06          CMPA   #$06
B1A1: 27 15          BEQ    $B1B8
B1A3: CC 22 02       LDD    #$2202
B1A6: 20 07          BRA    $B1AF
B1A8: 81 02          CMPA   #$02
B1AA: 27 0C          BEQ    $B1B8
B1AC: CC 88 06       LDD    #$8806
B1AF: A4 17          ANDA   -$9,X
B1B1: 10 27 00 86    LBEQ   $B23B
B1B5: F7 10 CF       STB    $10CF
B1B8: CE B6 CF       LDU    #$B6CF
B1BB: B6 25 1F       LDA    $251F
B1BE: A0 0F          SUBA   $F,X
B1C0: 2A 03          BPL    $B1C5
B1C2: 40             NEGA
B1C3: 33 44          LEAU   $4,U
B1C5: 81 18          CMPA   #$18
B1C7: 22 27          BHI    $B1F0
B1C9: FC 25 0E       LDD    $250E
B1CC: A3 1E          SUBD   -$2,X
B1CE: 2A 07          BPL    $B1D7
B1D0: 43             COMA
B1D1: 53             COMB
B1D2: C3 00 01       ADDD   #$0001
B1D5: 33 42          LEAU   $2,U
B1D7: 10 83 00 18    CMPD   #$0018
B1DB: 22 13          BHI    $B1F0
B1DD: E6 17          LDB    -$9,X
B1DF: E4 C4          ANDB   ,U
B1E1: 27 0D          BEQ    $B1F0
B1E3: E1 C4          CMPB   ,U
B1E5: 26 05          BNE    $B1EC
B1E7: A6 41          LDA    $1,U
B1E9: 7E B5 C7       JMP    $B5C7
B1EC: 86 0C          LDA    #$0C
B1EE: A7 18          STA    -$8,X
B1F0: CE B6 AF       LDU    #$B6AF
B1F3: A6 18          LDA    -$8,X
B1F5: 81 0C          CMPA   #$0C
B1F7: 25 20          BCS    $B219
B1F9: A6 0D          LDA    $D,X
B1FB: 27 1E          BEQ    $B21B
B1FD: B6 10 CF       LDA    $10CF
B200: E6 C6          LDB    A,U
B202: C4 0F          ANDB   #$0F
B204: E4 17          ANDB   -$9,X
B206: 10 26 03 BD    LBNE   $B5C7
B20A: B6 10 CE       LDA    $10CE
B20D: E6 C6          LDB    A,U
B20F: C4 0F          ANDB   #$0F
B211: E4 17          ANDB   -$9,X
B213: 10 26 03 B0    LBNE   $B5C7
B217: 20 02          BRA    $B21B
B219: 6C 18          INC    -$8,X
B21B: E6 05          LDB    $5,X
B21D: A6 C5          LDA    B,U
B21F: A4 17          ANDA   -$9,X
B221: 27 18          BEQ    $B23B
B223: CB 06          ADDB   #$06
B225: C4 06          ANDB   #$06
B227: A6 C5          LDA    B,U
B229: A4 17          ANDA   -$9,X
B22B: 27 0E          BEQ    $B23B
B22D: CB 04          ADDB   #$04
B22F: C4 06          ANDB   #$06
B231: A6 C5          LDA    B,U
B233: A4 17          ANDA   -$9,X
B235: 27 04          BEQ    $B23B
B237: CB 02          ADDB   #$02
B239: C4 06          ANDB   #$06
B23B: F7 10 34       STB    $1034
B23E: 39             RTS
B23F: 6A 1B          DEC    -$5,X
B241: 27 11          BEQ    $B254
B243: A6 1B          LDA    -$5,X
B245: 85 04          BITA   #$04
B247: 26 04          BNE    $B24D
B249: 86 1A          LDA    #$1A
B24B: 20 02          BRA    $B24F
B24D: 86 69          LDA    #$69
B24F: A7 0A          STA    $A,X
B251: 7E C0 BB       JMP    $C0BB
B254: CC 58 03       LDD    #$5803
B257: A7 0A          STA    $A,X
B259: E7 1B          STB    -$5,X
B25B: 86 08          LDA    #$08
B25D: AA 08          ORA    $8,X
B25F: A7 08          STA    $8,X
B261: 6C 1A          INC    -$6,X
B263: A6 05          LDA    $5,X
B265: 85 04          BITA   #$04
B267: 26 05          BNE    $B26E
B269: CC FF F8       LDD    #$FFF8
B26C: 20 03          BRA    $B271
B26E: CC 00 08       LDD    #$0008
B271: E3 1E          ADDD   -$2,X
B273: ED 1E          STD    -$2,X
B275: 6C 14          INC    -$C,X
B277: 7E C0 BB       JMP    $C0BB
B27A: 6A 1B          DEC    -$5,X
B27C: 27 0F          BEQ    $B28D
B27E: 86 01          LDA    #$01
B280: B7 40 4E       STA    $404E
B283: BD C0 BB       JSR    $C0BB
B286: A6 0D          LDA    $D,X
B288: 10 27 00 FD    LBEQ   $B389
B28C: 39             RTS
B28D: 6C 1A          INC    -$6,X
B28F: CC 03 59       LDD    #$0359
B292: A7 1B          STA    -$5,X
B294: E7 0A          STB    $A,X
B296: 6C 13          INC    -$D,X
B298: EE 15          LDU    -$B,X
B29A: A6 08          LDA    $8,X
B29C: 84 02          ANDA   #$02
B29E: A7 48          STA    $8,U
B2A0: A6 0F          LDA    $F,X
B2A2: 80 08          SUBA   #$08
B2A4: A7 4F          STA    $F,U
B2A6: CC 68 01       LDD    #$6801
B2A9: ED 4A          STD    $A,U
B2AB: A6 05          LDA    $5,X
B2AD: 85 04          BITA   #$04
B2AF: 26 04          BNE    $B2B5
B2B1: 86 E8          LDA    #$E8
B2B3: 20 02          BRA    $B2B7
B2B5: 86 18          LDA    #$18
B2B7: A7 57          STA    -$9,U
B2B9: 10 AE 1E       LDY    -$2,X
B2BC: 31 A6          LEAY   A,Y
B2BE: 10 AF 5E       STY    -$2,U
B2C1: BD C0 BB       JSR    $C0BB
B2C4: A6 0D          LDA    $D,X
B2C6: 10 27 00 BF    LBEQ   $B389
B2CA: E6 05          LDB    $5,X
B2CC: C5 04          BITB   #$04
B2CE: 26 08          BNE    $B2D8
B2D0: 81 20          CMPA   #$20
B2D2: 10 23 00 B3    LBLS   $B389
B2D6: 20 06          BRA    $B2DE
B2D8: 81 E0          CMPA   #$E0
B2DA: 10 24 00 AB    LBCC   $B389
B2DE: AB 57          ADDA   -$9,U
B2E0: A7 4D          STA    $D,U
B2E2: 6F 4C          CLR    $C,U
B2E4: BF 10 36       STX    $1036
B2E7: 1F 31          TFR    U,X
B2E9: CE 25 10       LDU    #$2510
B2EC: A6 0F          LDA    $F,X
B2EE: 8B 0C          ADDA   #$0C
B2F0: A7 0F          STA    $F,X
B2F2: BD C4 F4       JSR    $C4F4
B2F5: A6 0F          LDA    $F,X
B2F7: 80 0C          SUBA   #$0C
B2F9: A7 0F          STA    $F,X
B2FB: B6 10 D3       LDA    $10D3
B2FE: 27 2A          BEQ    $B32A	; bra => invincible
B300: CC 01 06       LDD    #$0106
B303: B7 10 D0       STA    $10D0
B306: E7 5A          STB    -$6,U
B308: 6A 4F          DEC    $F,U
B30A: CC 00 3C       LDD    #$003C
B30D: A7 48          STA    $8,U
B30F: E7 44          STB    $4,U
B311: F7 10 4F       STB    $104F
B314: 7C 40 4D       INC    $404D
B317: 6C 4F          INC    $F,U
B319: B6 25 02       LDA    $2502
B31C: 27 06          BEQ    $B324
B31E: BD A5 4F       JSR    $A54F
B321: 7F 25 02       CLR    $2502
B324: 7F 25 01       CLR    $2501
B327: 7F 10 DA       CLR    $10DA
B32A: BE 10 36       LDX    $1036
B32D: 86 01          LDA    #$01
B32F: B7 40 4E       STA    $404E
B332: 39             RTS
B333: EE 15          LDU    -$B,X
B335: 6A 1B          DEC    -$5,X
B337: 26 88          BNE    $B2C1
B339: 6C 1A          INC    -$6,X
B33B: CC 28 5C       LDD    #$285C
B33E: A7 1B          STA    -$5,X
B340: E7 0A          STB    $A,X
B342: CC 01 61       LDD    #$0161
B345: A7 54          STA    -$C,U
B347: E7 4A          STB    $A,U
B349: A6 48          LDA    $8,U
B34B: 8A 08          ORA    #$08
B34D: A7 48          STA    $8,U
B34F: A6 57          LDA    -$9,U
B351: 8B 10          ADDA   #$10
B353: 84 E0          ANDA   #$E0
B355: 7E B2 B7       JMP    $B2B7
B358: EE 15          LDU    -$B,X
B35A: 6A 1B          DEC    -$5,X
B35C: 27 13          BEQ    $B371
B35E: A6 1B          LDA    -$5,X
B360: 84 04          ANDA   #$04
B362: 44             LSRA
B363: 44             LSRA
B364: 8A 5C          ORA    #$5C
B366: A7 0A          STA    $A,X
B368: 8B 07          ADDA   #$07
B36A: 84 65          ANDA   #$65
B36C: A7 4A          STA    $A,U
B36E: 7E B2 C1       JMP    $B2C1
B371: 6C 1A          INC    -$6,X
B373: CC 07 60       LDD    #$0760
B376: A7 1B          STA    -$5,X
B378: E7 0A          STB    $A,X
B37A: C6 65          LDB    #$65
B37C: E7 4A          STB    $A,U
B37E: 7E B2 C1       JMP    $B2C1
B381: EE 15          LDU    -$B,X
B383: 6A 1B          DEC    -$5,X
B385: 10 26 FF 38    LBNE   $B2C1
B389: CC 01 05       LDD    #$0105
B38C: A7 1A          STA    -$6,X
B38E: E7 11          STB    -$F,X
B390: 6F 08          CLR    $8,X
B392: 10 AE 1E       LDY    -$2,X
B395: A6 05          LDA    $5,X
B397: 85 04          BITA   #$04
B399: 26 04          BNE    $B39F
B39B: C6 08          LDB    #$08
B39D: 20 02          BRA    $B3A1
B39F: C6 F8          LDB    #$F8
B3A1: 31 A5          LEAY   B,Y
B3A3: 10 AF 1E       STY    -$2,X
B3A6: 8A 18          ORA    #$18
B3A8: A7 0A          STA    $A,X
B3AA: 6F 14          CLR    -$C,X
B3AC: 6F 1B          CLR    -$5,X
B3AE: 6F 13          CLR    -$D,X
B3B0: 7F 40 4E       CLR    $404E
B3B3: 1E 31          EXG    U,X
B3B5: BD 87 32       JSR    $8732
B3B8: 1E 31          EXG    U,X
B3BA: 7E C0 BB       JMP    $C0BB
B3BD: A6 05          LDA    $5,X
B3BF: 84 06          ANDA   #$06
B3C1: A7 05          STA    $5,X
B3C3: 86 01          LDA    #$01
B3C5: B7 10 C0       STA    $10C0
B3C8: BD C5 34       JSR    $C534
B3CB: BF 10 36       STX    $1036
B3CE: FF 10 38       STU    $1038
B3D1: 8E B6 93       LDX    #$B693
B3D4: CC 04 70       LDD    #$0470
B3D7: B7 10 09       STA    $1009
B3DA: 7F 10 CE       CLR    $10CE
B3DD: A6 81          LDA    ,X++
B3DF: E1 C6          CMPB   A,U
B3E1: 23 1F          BLS    $B402
B3E3: 8B E0          ADDA   #$E0
B3E5: E1 C6          CMPB   A,U
B3E7: 23 19          BLS    $B402
B3E9: B7 10 34       STA    $1034
B3EC: B6 10 09       LDA    $1009
B3EF: 85 01          BITA   #$01
B3F1: 26 17          BNE    $B40A
B3F3: B6 10 34       LDA    $1034
B3F6: 8B 21          ADDA   #$21
B3F8: E1 C6          CMPB   A,U
B3FA: 23 06          BLS    $B402
B3FC: 8B E0          ADDA   #$E0
B3FE: E1 C6          CMPB   A,U
B400: 22 08          BHI    $B40A
B402: A6 1F          LDA    -$1,X
B404: BA 10 CE       ORA    $10CE
B407: B7 10 CE       STA    $10CE
B40A: 7A 10 09       DEC    $1009
B40D: 26 CE          BNE    $B3DD
B40F: F6 10 CE       LDB    $10CE
B412: 58             ASLB
B413: 25 52          BCS    $B467
B415: A6 84          LDA    ,X
B417: B7 10 09       STA    $1009
B41A: A6 01          LDA    $1,X
B41C: 33 C6          LEAU   A,U
B41E: A6 C9 08 00    LDA    $0800,U
B422: 81 10          CMPA   #$10
B424: 27 37          BEQ    $B45D
B426: 25 10          BCS    $B438
B428: 81 20          CMPA   #$20
B42A: 25 19          BCS    $B445
B42C: 81 30          CMPA   #$30
B42E: 26 2D          BNE    $B45D
B430: A6 C4          LDA    ,U
B432: A5 04          BITA   $4,X
B434: 26 1F          BNE    $B455
B436: 20 25          BRA    $B45D
B438: A6 C4          LDA    ,U
B43A: 81 70          CMPA   #$70
B43C: 25 17          BCS    $B455
B43E: B6 10 CE       LDA    $10CE
B441: AA 03          ORA    $3,X
B443: 20 15          BRA    $B45A
B445: A6 84          LDA    ,X
B447: 85 01          BITA   #$01
B449: 27 0A          BEQ    $B455
B44B: A6 C4          LDA    ,U
B44D: 81 60          CMPA   #$60
B44F: 25 04          BCS    $B455
B451: A5 84          BITA   ,X
B453: 27 08          BEQ    $B45D
B455: B6 10 CE       LDA    $10CE
B458: AA 02          ORA    $2,X
B45A: B7 10 CE       STA    $10CE
B45D: 7A 10 09       DEC    $1009
B460: 27 05          BEQ    $B467
B462: 33 C8 E0       LEAU   -$20,U
B465: 20 B7          BRA    $B41E
B467: FE 10 38       LDU    $1038
B46A: 30 05          LEAX   $5,X
B46C: 8C B6 AF       CMPX   #$B6AF
B46F: 26 A1          BNE    $B412
B471: B6 10 CE       LDA    $10CE
B474: 85 40          BITA   #$40
B476: 26 41          BNE    $B4B9
B478: BE 10 36       LDX    $1036
B47B: E6 0F          LDB    $F,X
B47D: C5 10          BITB   #$10
B47F: 27 07          BEQ    $B488
B481: 84 FB          ANDA   #$FB
B483: B7 10 CE       STA    $10CE
B486: 20 37          BRA    $B4BF
B488: C6 02          LDB    #$02
B48A: F7 10 09       STB    $1009
B48D: FE 10 38       LDU    $1038
B490: E6 C9 08 00    LDB    $0800,U
B494: C1 30          CMPB   #$30
B496: 26 08          BNE    $B4A0
B498: E6 C4          LDB    ,U
B49A: C4 03          ANDB   #$03
B49C: 26 0A          BNE    $B4A8
B49E: 20 0F          BRA    $B4AF
B4A0: C1 10          CMPB   #$10
B4A2: 23 0B          BLS    $B4AF
B4A4: C1 20          CMPB   #$20
B4A6: 24 07          BCC    $B4AF
B4A8: 8A 04          ORA    #$04
B4AA: B7 10 CE       STA    $10CE
B4AD: 20 10          BRA    $B4BF
B4AF: 7A 10 09       DEC    $1009
B4B2: 27 0B          BEQ    $B4BF
B4B4: 33 C8 20       LEAU   $20,U
B4B7: 20 D7          BRA    $B490
B4B9: BE 10 36       LDX    $1036
B4BC: B6 10 CE       LDA    $10CE
B4BF: A7 17          STA    -$9,X
B4C1: A6 05          LDA    $5,X
B4C3: B7 10 CE       STA    $10CE
B4C6: B7 10 CF       STA    $10CF
B4C9: BD 8A A0       JSR    $8AA0
B4CC: E6 19          LDB    -$7,X
B4CE: 2A 08          BPL    $B4D8
B4D0: 81 D0          CMPA   #$D0
B4D2: 10 25 FC 99    LBCS   $B16F
B4D6: 20 06          BRA    $B4DE
B4D8: 81 D0          CMPA   #$D0
B4DA: 10 24 FC 91    LBCC   $B16F
B4DE: A6 05          LDA    $5,X
B4E0: EE 1E          LDU    -$2,X
B4E2: 11 B3 25 0E    CMPU   $250E
B4E6: 27 1B          BEQ    $B503
B4E8: 25 09          BCS    $B4F3
B4EA: 81 06          CMPA   #$06
B4EC: 27 15          BEQ    $B503
B4EE: CC 22 02       LDD    #$2202
B4F1: 20 07          BRA    $B4FA
B4F3: 81 02          CMPA   #$02
B4F5: 27 0C          BEQ    $B503
B4F7: CC 88 06       LDD    #$8806
B4FA: A4 17          ANDA   -$9,X
B4FC: 10 27 00 C3    LBEQ   $B5C3
B500: F7 10 CE       STB    $10CE
B503: E6 05          LDB    $5,X
B505: A6 0F          LDA    $F,X
B507: B1 25 1F       CMPA   $251F
B50A: 27 1A          BEQ    $B526
B50C: 25 09          BCS    $B517
B50E: C1 04          CMPB   #$04
B510: 27 14          BEQ    $B526
B512: CC 11 00       LDD    #$1100
B515: 20 06          BRA    $B51D
B517: 5D             TSTB
B518: 27 0C          BEQ    $B526
B51A: CC 44 04       LDD    #$4404
B51D: A4 17          ANDA   -$9,X
B51F: 10 27 00 A0    LBEQ   $B5C3
B523: F7 10 CF       STB    $10CF
B526: CE B6 CF       LDU    #$B6CF
B529: B6 25 1F       LDA    $251F
B52C: A0 0F          SUBA   $F,X
B52E: 2A 03          BPL    $B533
B530: 40             NEGA
B531: 33 44          LEAU   $4,U
B533: 81 18          CMPA   #$18
B535: 22 43          BHI    $B57A
B537: FC 25 0E       LDD    $250E
B53A: A3 1E          SUBD   -$2,X
B53C: 2A 07          BPL    $B545
B53E: 43             COMA
B53F: 53             COMB
B540: C3 00 01       ADDD   #$0001
B543: 33 42          LEAU   $2,U
B545: 10 83 00 18    CMPD   #$0018
B549: 22 2F          BHI    $B57A
B54B: E6 17          LDB    -$9,X
B54D: E4 C4          ANDB   ,U
B54F: 27 29          BEQ    $B57A
B551: E1 C4          CMPB   ,U
B553: 26 04          BNE    $B559
B555: A6 41          LDA    $1,U
B557: 20 6E          BRA    $B5C7
B559: 86 0C          LDA    #$0C
B55B: A7 18          STA    -$8,X
B55D: B6 10 DD       LDA    $10DD
B560: 27 18          BEQ    $B57A
B562: 6C 1C          INC    -$4,X
B564: A6 1C          LDA    -$4,X
B566: 81 0A          CMPA   #$0A
B568: 25 10          BCS    $B57A
B56A: A6 0F          LDA    $F,X
B56C: 81 50          CMPA   #$50
B56E: 25 0A          BCS    $B57A
B570: 81 D0          CMPA   #$D0
B572: 22 06          BHI    $B57A
B574: 6F 1C          CLR    -$4,X
B576: A6 41          LDA    $1,U
B578: 20 4D          BRA    $B5C7
B57A: CE B6 AF       LDU    #$B6AF
B57D: A6 18          LDA    -$8,X
B57F: 81 0C          CMPA   #$0C
B581: 25 1E          BCS    $B5A1
B583: A6 0D          LDA    $D,X
B585: B6 10 CE       LDA    $10CE
B588: E6 C6          LDB    A,U
B58A: C4 0F          ANDB   #$0F
B58C: E4 17          ANDB   -$9,X
B58E: 10 26 00 35    LBNE   $B5C7
B592: B6 10 CF       LDA    $10CF
B595: E6 C6          LDB    A,U
B597: C4 0F          ANDB   #$0F
B599: E4 17          ANDB   -$9,X
B59B: 10 26 00 28    LBNE   $B5C7
B59F: 20 02          BRA    $B5A3
B5A1: 6C 18          INC    -$8,X
B5A3: E6 05          LDB    $5,X
B5A5: A6 C5          LDA    B,U
B5A7: A4 17          ANDA   -$9,X
B5A9: 27 18          BEQ    $B5C3
B5AB: CB 02          ADDB   #$02
B5AD: C4 06          ANDB   #$06
B5AF: A6 C5          LDA    B,U
B5B1: A4 17          ANDA   -$9,X
B5B3: 27 0E          BEQ    $B5C3
B5B5: CB 04          ADDB   #$04
B5B7: C4 06          ANDB   #$06
B5B9: A6 C5          LDA    B,U
B5BB: A4 17          ANDA   -$9,X
B5BD: 27 04          BEQ    $B5C3
B5BF: CB 06          ADDB   #$06
B5C1: C4 06          ANDB   #$06
B5C3: F7 10 34       STB    $1034
B5C6: 39             RTS
B5C7: A7 05          STA    $5,X
B5C9: CC 00 6C       LDD    #$006C
B5CC: A7 18          STA    -$8,X
B5CE: A6 19          LDA    -$7,X
B5D0: 2A 02          BPL    $B5D4
B5D2: CB 02          ADDB   #$02
B5D4: E7 0A          STB    $A,X
B5D6: CC 02 20       LDD    #$0220
B5D9: A7 1A          STA    -$6,X
B5DB: A6 05          LDA    $5,X
B5DD: 84 03          ANDA   #$03
B5DF: 26 02          BNE    $B5E3
B5E1: C6 10          LDB    #$10
B5E3: E7 1B          STB    -$5,X
B5E5: 64 03          LSR    $3,X
B5E7: 64 03          LSR    $3,X
B5E9: 86 03          LDA    #$03
B5EB: A7 14          STA    -$C,X
B5ED: A6 1B          LDA    -$5,X
B5EF: 27 42          BEQ    $B633
B5F1: 81 10          CMPA   #$10
B5F3: 10 26 00 86    LBNE   $B67D
B5F7: EC 1E          LDD    -$2,X
B5F9: 83 00 18       SUBD   #$0018
B5FC: C4 F8          ANDB   #$F8
B5FE: 58             ASLB
B5FF: 49             ROLA
B600: 58             ASLB
B601: 49             ROLA
B602: FD 10 CE       STD    $10CE
B605: E6 0F          LDB    $F,X
B607: 54             LSRB
B608: 54             LSRB
B609: 54             LSRB
B60A: 4F             CLRA
B60B: F3 10 CE       ADDD   $10CE
B60E: FD 10 34       STD    $1034
B611: CE B6 D7       LDU    #$B6D7
B614: A6 05          LDA    $5,X
B616: E6 C6          LDB    A,U
B618: FE 10 34       LDU    $1034
B61B: 33 C5          LEAU   B,U
B61D: CC 10 70       LDD    #$1070
B620: E1 C4          CMPB   ,U
B622: 23 05          BLS    $B629
B624: E1 C8 E0       CMPB   -$20,U
B627: 22 52          BHI    $B67B
B629: E6 05          LDB    $5,X
B62B: CB 04          ADDB   #$04
B62D: C4 07          ANDB   #$07
B62F: E7 05          STB    $5,X
B631: 20 48          BRA    $B67B
B633: 6A 1A          DEC    -$6,X
B635: B6 10 E4       LDA    $10E4
B638: 26 08          BNE    $B642
B63A: 86 01          LDA    #$01
B63C: B7 10 5C       STA    $105C
B63F: B7 10 E4       STA    $10E4
B642: B6 10 49       LDA    $1049
B645: 26 05          BNE    $B64C
B647: FC 17 1D       LDD    $171D
B64A: 20 10          BRA    $B65C
B64C: B6 17 17       LDA    $1717
B64F: B1 17 1C       CMPA   $171C
B652: 22 05          BHI    $B659
B654: FC 17 0A       LDD    $170A
B657: 20 03          BRA    $B65C
B659: FC 17 08       LDD    $1708
B65C: 6D 19          TST    -$7,X
B65E: 2A 04          BPL    $B664
B660: A7 03          STA    $3,X
B662: 20 02          BRA    $B666
B664: E7 03          STB    $3,X
B666: A6 05          LDA    $5,X
B668: 84 06          ANDA   #$06
B66A: A7 05          STA    $5,X
B66C: 8B 10          ADDA   #$10
B66E: E6 19          LDB    -$7,X
B670: 2A 02          BPL    $B674
B672: 8B 08          ADDA   #$08
B674: A7 0A          STA    $A,X
B676: 6F 14          CLR    -$C,X
B678: 7E C0 BB       JMP    $C0BB
B67B: A6 1B          LDA    -$5,X
B67D: 84 04          ANDA   #$04
B67F: 44             LSRA
B680: 44             LSRA
B681: B7 10 34       STA    $1034
B684: A6 0A          LDA    $A,X
B686: 84 6E          ANDA   #$6E
B688: BA 10 34       ORA    $1034
B68B: A7 0A          STA    $A,X
B68D: BD C0 00       JSR    $C000
B690: 7E C0 BB       JMP    $C0BB


B6DF: 7F 1F 60       CLR    $1F60
B6E2: BD 81 50       JSR    suspend_task_8150
B6E5: B6 1F 60       LDA    $1F60
B6E8: 27 F8          BEQ    $B6E2
B6EA: BD 81 50       JSR    suspend_task_8150
B6ED: FC 10 D0       LDD    $10D0
B6F0: 26 ED          BNE    $B6DF
B6F2: B6 1F 60       LDA    $1F60
B6F5: 27 EB          BEQ    $B6E2
B6F7: 7A 1F 74       DEC    $1F74
B6FA: 26 EE          BNE    $B6EA
B6FC: 8E 1F 70       LDX    #$1F70
B6FF: CC 08 03       LDD    #$0803
B702: A7 04          STA    $4,X
B704: E7 14          STB    -$C,X
B706: CE 15 80       LDU    #$1580
B709: 10 8E 15 00    LDY    #$1500
B70D: B6 10 08       LDA    $1008
B710: 84 E0          ANDA   #$E0
B712: 44             LSRA
B713: 44             LSRA
B714: 8B 08          ADDA   #$08
B716: B7 10 34       STA    $1034
B719: 8B 2F          ADDA   #$2F
B71B: B7 10 35       STA    $1035
B71E: BD 8A A0       JSR    $8AA0
B721: 84 7F          ANDA   #$7F
B723: B1 10 34       CMPA   $1034
B726: 23 F6          BLS    $B71E
B728: B1 10 35       CMPA   $1035
B72B: 24 F1          BCC    $B71E
B72D: E6 C6          LDB    A,U
B72F: C1 0A          CMPB   #$0A
B731: 24 EB          BCC    $B71E
B733: C1 05          CMPB   #$05
B735: 23 E7          BLS    $B71E
B737: 6D A6          TST    A,Y
B739: 2B E3          BMI    $B71E
B73B: 1F 89          TFR    A,B
B73D: 84 07          ANDA   #$07
B73F: 48             ASLA
B740: 48             ASLA
B741: 48             ASLA
B742: 48             ASLA
B743: 48             ASLA
B744: 8B 14          ADDA   #$14
B746: A7 0F          STA    $F,X
B748: C4 78          ANDB   #$78
B74A: 86 04          LDA    #$04
B74C: 3D             MUL
B74D: C3 00 20       ADDD   #$0020
B750: ED 1E          STD    -$2,X
B752: F6 17 04       LDB    $1704
B755: C1 10          CMPB   #$10
B757: 23 0C          BLS    $B765
B759: BD 8A A0       JSR    $8AA0
B75C: 84 0F          ANDA   #$0F
B75E: CE B8 15       LDU    #$B815
B761: E6 C6          LDB    A,U
B763: 20 03          BRA    $B768
B765: 5A             DECB
B766: C4 0F          ANDB   #$0F
B768: E7 13          STB    -$D,X
B76A: CE B8 05       LDU    #$B805
B76D: A6 C5          LDA    B,U
B76F: A7 0A          STA    $A,X
B771: 6C 0B          INC    $B,X
B773: 6F 0C          CLR    $C,X
B775: BD C0 BB       JSR    $C0BB
B778: BD 81 50       JSR    suspend_task_8150
B77B: B6 1F 60       LDA    $1F60
B77E: 27 7C          BEQ    $B7FC
B780: FC 10 D0       LDD    $10D0
B783: 26 65          BNE    $B7EA
B785: 8E 1F 70       LDX    #$1F70
B788: CE 25 10       LDU    #$2510
B78B: 86 0B          LDA    #$0B
B78D: AB 0F          ADDA   $F,X
B78F: A7 0F          STA    $F,X
B791: BD C4 F4       JSR    $C4F4
B794: 86 F5          LDA    #$F5
B796: AB 0F          ADDA   $F,X
B798: A7 0F          STA    $F,X
B79A: B6 10 D3       LDA    $10D3
B79D: 26 0B          BNE    $B7AA
B79F: B6 10 50       LDA    $1050
B7A2: 26 CF          BNE    $B773
B7A4: 6A 04          DEC    $4,X
B7A6: 26 CB          BNE    $B773
B7A8: 20 52          BRA    $B7FC
B7AA: CE B8 35       LDU    #$B835
B7AD: A6 13          LDA    -$D,X
B7AF: 48             ASLA
B7B0: EC C6          LDD    A,U
B7B2: BD 8A DB       JSR    $8ADB
B7B5: 8E 1F 70       LDX    #$1F70
B7B8: CE B8 25       LDU    #$B825
B7BB: A6 13          LDA    -$D,X
B7BD: E6 C6          LDB    A,U
B7BF: E7 0A          STB    $A,X
B7C1: CC 0C 3F       LDD    #$0C3F
B7C4: A7 0B          STA    $B,X
B7C6: E7 04          STB    $4,X
B7C8: F7 40 4C       STB    $404C
B7CB: BD C0 BB       JSR    $C0BB
B7CE: 6F 0C          CLR    $C,X
B7D0: BD 81 50       JSR    suspend_task_8150
B7D3: B6 1F 60       LDA    $1F60
B7D6: 27 24          BEQ    $B7FC
B7D8: FC 10 D0       LDD    $10D0
B7DB: 26 0D          BNE    $B7EA
B7DD: 8E 1F 70       LDX    #$1F70
B7E0: 6A 04          DEC    $4,X
B7E2: 26 E7          BNE    $B7CB
B7E4: BD 87 32       JSR    $8732
B7E7: 7E B6 E2       JMP    $B6E2
B7EA: BD 81 50       JSR    suspend_task_8150
B7ED: 8E 1F 70       LDX    #$1F70
B7F0: B6 1F 60       LDA    $1F60
B7F3: 27 0A          BEQ    $B7FF
B7F5: BD C0 BB       JSR    $C0BB
B7F8: 6F 0C          CLR    $C,X
B7FA: 20 EE          BRA    $B7EA
B7FC: 8E 1F 70       LDX    #$1F70
B7FF: BD 87 32       JSR    $8732
B802: 7E B6 E2       JMP    $B6E2

C000: E6 03          LDB    $3,X                                        
C002: 2A 06          BPL    $C00A                                       
C004: 8D 1C          BSR    $C022                                       
C006: E6 03          LDB    $3,X                                        
C008: C4 7F          ANDB   #$7F                                        
C00A: 4F             CLRA                                               
C00B: FD 10 6E       STD    $106E                                       
C00E: E6 1D          LDB    -$3,X                                       
C010: F3 10 6E       ADDD   $106E
C013: 85 01          BITA   #$01
C015: 26 09          BNE    $C020
C017: C5 80          BITB   #$80
C019: 26 03          BNE    $C01E
C01B: E7 1D          STB    -$3,X
C01D: 39             RTS
C01E: C4 7F          ANDB   #$7F
C020: E7 1D          STB    -$3,X
C022: E6 1B          LDB    -$5,X
C024: 26 01          BNE    $C027
C026: 39             RTS
C027: 6A 1B          DEC    -$5,X
C029: CE C0 70       LDU    #$C070
C02C: E6 05          LDB    $5,X
C02E: A6 C5          LDA    B,U
C030: EE 1E          LDU    -$2,X
C032: 85 01          BITA   #$01
C034: 27 0A          BEQ    $C040
C036: 11 83 00 20    CMPU   #$0020
C03A: 23 12          BLS    $C04E
C03C: 33 5F          LEAU   -$1,U
C03E: 20 0C          BRA    $C04C
C040: 85 02          BITA   #$02
C042: 27 0A          BEQ    $C04E
C044: 11 83 01 E0    CMPU   #$01E0
C048: 24 04          BCC    $C04E
C04A: 33 41          LEAU   $1,U
C04C: EF 1E          STU    -$2,X
C04E: EE 0E          LDU    $E,X
C050: 85 04          BITA   #$04
C052: 27 0B          BEQ    $C05F
C054: E6 0F          LDB    $F,X
C056: C1 10          CMPB   #$10
C058: 26 01          BNE    $C05B
C05A: 39             RTS
C05B: 33 5F          LEAU   -$1,U
C05D: 20 0E          BRA    $C06D
C05F: 85 08          BITA   #$08
C061: 26 01          BNE    $C064
C063: 39             RTS
C064: 11 83 00 FE    CMPU   #$00FE
C068: 25 01          BCS    $C06B
C06A: 39             RTS
C06B: 33 41          LEAU   $1,U
C06D: EF 0E          STU    $E,X
C06F: 39             RTS

C078: B6 10 01       LDA    $1001
C07B: 84 03          ANDA   #$03
C07D: 26 1A          BNE    $C099
C07F: CE A6 84       LDU    #$A684
C082: E6 05          LDB    $5,X
C084: A6 0A          LDA    $A,X
C086: 8B 02          ADDA   #$02
C088: 84 02          ANDA   #$02
C08A: AA C5          ORA    B,U
C08C: A7 0A          STA    $A,X
C08E: B6 10 01       LDA    $1001
C091: 84 10          ANDA   #$10
C093: 44             LSRA
C094: 44             LSRA
C095: AA 0A          ORA    $A,X
C097: A7 0A          STA    $A,X
C099: 39             RTS
C09A: CC 04 1E       LDD    #$041E
C09D: 20 03          BRA    $C0A2
C09F: CC 0C 0C       LDD    #$0C0C
C0A2: FD 10 34       STD    $1034
C0A5: A6 1B          LDA    -$5,X
C0A7: 43             COMA
C0A8: B4 10 34       ANDA   $1034
C0AB: 44             LSRA
C0AC: 44             LSRA
C0AD: B7 10 34       STA    $1034
C0B0: A6 0A          LDA    $A,X
C0B2: B4 10 35       ANDA   $1035
C0B5: BA 10 34       ORA    $1034
C0B8: A7 0A          STA    $A,X
C0BA: 39             RTS
C0BB: 7F 10 CE       CLR    $10CE
C0BE: F6 10 08       LDB    $1008
C0C1: F7 10 CF       STB    $10CF
C0C4: EC 1E          LDD    -$2,X
C0C6: B3 10 CE       SUBD   $10CE
C0C9: 2B 0C          BMI    $C0D7
C0CB: 10 83 00 07    CMPD   #$0007
C0CF: 25 06          BCS    $C0D7
C0D1: 10 83 00 FF    CMPD   #$00FF
C0D5: 25 01          BCS    $C0D8
C0D7: 5F             CLRB
C0D8: E7 0D          STB    $D,X
C0DA: 39             RTS
C0DB: BD C7 DD       JSR    $C7DD
C0DE: BD C1 9A       JSR    $C19A
C0E1: 8E 16 40       LDX    #$1640
C0E4: B6 17 44       LDA    $1744
C0E7: 20 0C          BRA    $C0F5
C0E9: BD C7 D8       JSR    $C7D8
C0EC: BD C1 A2       JSR    $C1A2
C0EF: 8E 15 80       LDX    #$1580
C0F2: B6 17 04       LDA    $1704
C0F5: 4A             DECA
C0F6: 84 0F          ANDA   #$0F
C0F8: BB 17 21       ADDA   $1721
C0FB: CE D4 F0       LDU    #$D4F0
C0FE: C6 3C          LDB    #$3C
C100: F7 10 09       STB    $1009
C103: C0 04          SUBB   #$04
C105: 3D             MUL
C106: 33 CB          LEAU   D,U
C108: A6 C0          LDA    ,U+
C10A: 1F 89          TFR    A,B
C10C: 84 F0          ANDA   #$F0
C10E: 44             LSRA
C10F: 44             LSRA
C110: 44             LSRA
C111: 44             LSRA
C112: 81 0B          CMPA   #$0B
C114: 26 02          BNE    $C118
C116: AB 1F          ADDA   -$1,X
C118: A7 80          STA    ,X+
C11A: C4 0F          ANDB   #$0F
C11C: C1 0B          CMPB   #$0B
C11E: 26 02          BNE    $C122
C120: EB 1F          ADDB   -$1,X
C122: E7 80          STB    ,X+
C124: 7A 10 09       DEC    $1009
C127: 26 DF          BNE    $C108
C129: 39             RTS
C12A: BD 87 06       JSR    clear_screen_8706
C12D: 8E 15 80       LDX    #$1580
C130: CE D3 88       LDU    #$D388
C133: 10 8E CE 48    LDY    #$CE48
C137: B6 80 00       LDA    watchdog_8000
C13A: A6 80          LDA    ,X+
C13C: C6 20          LDB    #$20
C13E: 3D             MUL
C13F: 31 AB          LEAY   D,Y
C141: BF 10 36       STX    $1036
C144: AE C4          LDX    ,U
C146: FF 10 3A       STU    $103A
C149: 8D 1C          BSR    $C167
C14B: BE 10 36       LDX    $1036
C14E: 8C 15 F8       CMPX   #$15F8
C151: 27 07          BEQ    $C15A
C153: FE 10 3A       LDU    $103A
C156: 33 42          LEAU   $2,U
C158: 20 D9          BRA    $C133
C15A: BD C1 D2       JSR    $C1D2
C15D: BD C2 04       JSR    $C204
C160: BD C2 66       JSR    $C266
C163: BD C8 11       JSR    $C811
C166: 39             RTS
C167: CE C1 92       LDU    #$C192
C16A: FF 10 38       STU    $1038
C16D: 8D 0F          BSR    $C17E
C16F: FE 10 38       LDU    $1038
C172: A6 C0          LDA    ,U+
C174: 27 1B          BEQ    $C191
C176: AE 9F 10 3A    LDX    [$103A]
C17A: 30 86          LEAX   A,X
C17C: 20 EC          BRA    $C16A
C17E: CE C1 96       LDU    #$C196
C181: EC A1          LDD    ,Y++
C183: A7 84          STA    ,X
C185: E7 89 08 00    STB    $0800,X
C189: A6 C0          LDA    ,U+
C18B: 27 04          BEQ    $C191
C18D: 30 86          LEAX   A,X
C18F: 20 F0          BRA    $C181
C191: 39             RTS

C19A: 8E 16 FC       LDX    #$16FC
C19D: B6 17 44       LDA    $1744
C1A0: 20 06          BRA    $C1A8
C1A2: 8E 16 3C       LDX    #$163C
C1A5: B6 17 04       LDA    $1704
C1A8: C6 3C          LDB    #$3C
C1AA: 6F 82          CLR    ,-X
C1AC: 5A             DECB
C1AD: 26 FB          BNE    $C1AA
C1AF: 4A             DECA
C1B0: 84 0F          ANDA   #$0F
C1B2: BB 17 21       ADDA   $1721
C1B5: CE DB F4       LDU    #$DBF4
C1B8: C6 0C          LDB    #$0C
C1BA: 3D             MUL
C1BB: 33 CB          LEAU   D,U
C1BD: C6 0C          LDB    #$0C
C1BF: F7 10 09       STB    $1009
C1C2: 86 05          LDA    #$05
C1C4: E6 C0          LDB    ,U+
C1C6: 59             ROLB
C1C7: 69 80          ROL    ,X+
C1C9: 4A             DECA
C1CA: 26 FA          BNE    $C1C6
C1CC: 7A 10 09       DEC    $1009
C1CF: 26 F1          BNE    $C1C2
C1D1: 39             RTS
C1D2: 8E 16 00       LDX    #$1600
C1D5: CE D4 78       LDU    #$D478
C1D8: B6 80 00       LDA    watchdog_8000
C1DB: A6 80          LDA    ,X+
C1DD: 27 15          BEQ    $C1F4
C1DF: BF 10 36       STX    $1036
C1E2: AE C4          LDX    ,U
C1E4: FF 10 38       STU    $1038
C1E7: 10 8E C1 FC    LDY    #$C1FC
C1EB: BD C1 7E       JSR    $C17E
C1EE: BE 10 36       LDX    $1036
C1F1: FE 10 38       LDU    $1038
C1F4: 33 42          LEAU   $2,U
C1F6: 8C 16 3C       CMPX   #$163C
C1F9: 26 DD          BNE    $C1D8
C1FB: 39             RTS

C204: 8E 15 80       LDX    #$1580
C206: 80 CE          SUBA   #$CE
C208: C2 50          SBCB   #$50
C20A: B6 80 00       LDA    watchdog_8000
C20D: A6 80          LDA    ,X+
C20F: 81 09          CMPA   #$09
C211: 23 04          BLS    $C217
C213: C6 FF          LDB    #$FF
C215: 20 02          BRA    $C219
C217: E6 C6          LDB    A,U
C219: E7 89 FF 7F    STB    -$0081,X
C21D: 8C 15 F8       CMPX   #$15F8
C220: 26 E8          BNE    $C20A
C222: 8E 15 08       LDX    #$1508
C225: A6 80          LDA    ,X+
C227: 2B 21          BMI    $C24A
C229: CE C2 5A       LDU    #$C25A
C22C: A5 42          BITA   $2,U
C22E: 26 10          BNE    $C240
C230: B7 10 34       STA    $1034
C233: A6 C4          LDA    ,U
C235: E6 86          LDB    A,X
C237: B6 10 34       LDA    $1034
C23A: E5 41          BITB   $1,U
C23C: 27 02          BEQ    $C240
C23E: AA 42          ORA    $2,U
C240: 33 43          LEAU   $3,U
C242: 11 83 C2 66    CMPU   #$C266
C246: 26 E4          BNE    $C22C
C248: A7 1F          STA    -$1,X
C24A: 8C 15 70       CMPX   #$1570
C24D: 26 D6          BNE    $C225
C24F: 39             RTS

C266: 8E 15 89       LDX    #$1589
C269: CE D3 9A       LDU    #$D39A
C26C: A6 80          LDA    ,X+
C26E: 81 0A          CMPA   #$0A
C270: 10 27 01 0D    LBEQ   $C381
C274: 25 06          BCS    $C27C
C276: E6 89 FF 7E    LDB    -$0082,X
C27A: 20 04          BRA    $C280
C27C: E6 89 FF 7F    LDB    -$0081,X
C280: 10 8E C3 8B    LDY    #$C38B
C284: E4 A6          ANDB   A,Y
C286: 10 27 00 F7    LBEQ   $C381
C28A: F7 10 CF       STB    $10CF
C28D: C4 01          ANDB   #$01
C28F: F7 10 EA       STB    $10EA
C292: C6 04          LDB    #$04
C294: F7 10 09       STB    $1009
C297: BF 10 36       STX    $1036
C29A: FF 10 38       STU    $1038
C29D: CE C3 F4       LDU    #$C3F4
C2A0: 10 8E C3 A0    LDY    #$C3A0
C2A4: B7 10 35       STA    $1035
C2A7: 48             ASLA
C2A8: 48             ASLA
C2A9: 31 A6          LEAY   A,Y
C2AB: 76 10 CF       ROR    $10CF
C2AE: 10 24 00 BE    LBCC   $C370
C2B2: 86 04          LDA    #$04
C2B4: B7 10 CE       STA    $10CE
C2B7: AE 9F 10 38    LDX    [$1038]
C2BB: EC C1          LDD    ,U++
C2BD: FD 10 3C       STD    $103C
C2C0: A6 A0          LDA    ,Y+
C2C2: E6 C0          LDB    ,U+
C2C4: 30 85          LEAX   B,X
C2C6: 46             RORA
C2C7: 10 24 00 9C    LBCC   $C367
C2CB: B7 10 34       STA    $1034
C2CE: A6 84          LDA    ,X
C2D0: 2B 20          BMI    $C2F2
C2D2: E6 89 08 00    LDB    $0800,X
C2D6: C4 0F          ANDB   #$0F
C2D8: FA 10 3D       ORB    $103D
C2DB: C5 04          BITB   #$04
C2DD: 27 0C          BEQ    $C2EB
C2DF: C5 0A          BITB   #$0A
C2E1: 27 08          BEQ    $C2EB
C2E3: 8B 1F          ADDA   #$1F
C2E5: A7 84          STA    ,X
C2E7: C4 0F          ANDB   #$0F
C2E9: 20 75          BRA    $C360
C2EB: BB 10 3C       ADDA   $103C
C2EE: A7 84          STA    ,X
C2F0: 20 4E          BRA    $C340
C2F2: FF 10 3A       STU    $103A
C2F5: CE C4 0C       LDU    #$C40C
C2F8: F6 10 35       LDB    $1035
C2FB: 33 C5          LEAU   B,U
C2FD: E6 C4          LDB    ,U
C2FF: CE C4 21       LDU    #$C421
C302: 33 C5          LEAU   B,U
C304: A1 C0          CMPA   ,U+
C306: 27 08          BEQ    $C310
C308: 11 83 C4 40    CMPU   #$C440
C30C: 26 F6          BNE    $C304
C30E: 33 41          LEAU   $1,U
C310: F6 10 09       LDB    $1009
C313: C5 01          BITB   #$01
C315: 27 21          BEQ    $C338
C317: C5 02          BITB   #$02
C319: 27 0B          BEQ    $C326
C31B: E6 88 E0       LDB    -$20,X
C31E: 81 A7          CMPA   #$A7
C320: 26 0F          BNE    $C331
C322: C6 25          LDB    #$25
C324: 20 15          BRA    $C33B
C326: E6 88 20       LDB    $20,X
C329: 81 A4          CMPA   #$A4
C32B: 26 04          BNE    $C331
C32D: C6 25          LDB    #$25
C32F: 20 0A          BRA    $C33B
C331: C1 FC          CMPB   #$FC
C333: 24 03          BCC    $C338
C335: 33 C8 20       LEAU   $20,U
C338: E6 C8 1E       LDB    $1E,U
C33B: FE 10 3A       LDU    $103A
C33E: 20 20          BRA    $C360
C340: B6 10 EA       LDA    $10EA
C343: 26 1B          BNE    $C360
C345: B6 10 09       LDA    $1009
C348: 85 01          BITA   #$01
C34A: 27 14          BEQ    $C360
C34C: 85 02          BITA   #$02
C34E: 27 05          BEQ    $C355
C350: A6 88 E0       LDA    -$20,X
C353: 20 03          BRA    $C358
C355: A6 88 20       LDA    $20,X
C358: 81 FC          CMPA   #$FC
C35A: 24 04          BCC    $C360
C35C: C4 0F          ANDB   #$0F
C35E: CA 10          ORB    #$10
C360: E7 89 08 00    STB    $0800,X
C364: B6 10 34       LDA    $1034
C367: 7A 10 CE       DEC    $10CE
C36A: 10 26 FF 54    LBNE   $C2C2
C36E: 20 04          BRA    $C374
C370: 33 46          LEAU   $6,U
C372: 31 21          LEAY   $1,Y
C374: 7A 10 09       DEC    $1009
C377: 10 26 FF 30    LBNE   $C2AB
C37B: BE 10 36       LDX    $1036
C37E: FE 10 38       LDU    $1038
C381: 33 42          LEAU   $2,U
C383: 8C 15 F0       CMPX   #$15F0
C386: 10 26 FE E2    LBNE   $C26C
C38A: 39             RTS

C480: EC 1E          LDD    -$2,X
C482: 10 83 00 80    CMPD   #$0080
C486: 2F 11          BLE    $C499
C488: 10 83 01 7F    CMPD   #$017F
C48C: 2C 11          BGE    $C49F
C48E: 83 00 80       SUBD   #$0080
C491: F7 10 08       STB    $1008
C494: 86 80          LDA    #$80
C496: A7 0D          STA    $D,X
C498: 39             RTS
C499: E7 0D          STB    $D,X
C49B: 7F 10 08       CLR    $1008
C49E: 39             RTS
C49F: 5C             INCB
C4A0: E7 0D          STB    $D,X
C4A2: 86 FF          LDA    #$FF
C4A4: B7 10 08       STA    $1008
C4A7: 39             RTS
C4A8: 8E 17 00       LDX    #$1700
C4AB: 6F 88 21       CLR    $21,X
C4AE: A6 05          LDA    $5,X
C4B0: 81 15          CMPA   #$15
C4B2: 23 0E          BLS    $C4C2
C4B4: 81 99          CMPA   #$99
C4B6: 27 07          BEQ    $C4BF
C4B8: C6 10          LDB    #$10
C4BA: E7 88 21       STB    $21,X
C4BD: 20 03          BRA    $C4C2
C4BF: 4F             CLRA
C4C0: A7 04          STA    $4,X
C4C2: 8B 01          ADDA   #$01
C4C4: 19             DAA
C4C5: A7 05          STA    $5,X
C4C7: A6 04          LDA    $4,X
C4C9: 84 0F          ANDA   #$0F
C4CB: 4C             INCA
C4CC: 6C 04          INC    $4,X
C4CE: AB 88 21       ADDA   $21,X
C4D1: CE DD 5B       LDU    #$DD5B
C4D4: C6 19          LDB    #$19
C4D6: 3D             MUL
C4D7: 33 CB          LEAU   D,U
C4D9: 30 07          LEAX   $7,X
C4DB: 86 18          LDA    #$18
C4DD: E6 C0          LDB    ,U+
C4DF: E7 80          STB    ,X+
C4E1: 4A             DECA
C4E2: 26 F9          BNE    $C4DD
C4E4: A6 C4          LDA    ,U
C4E6: A7 80          STA    ,X+
C4E8: 86 03          LDA    #$03
C4EA: A7 84          STA    ,X
C4EC: B6 10 10       LDA    $1010
C4EF: 10 27 FB F6    LBEQ   $C0E9
C4F3: 39             RTS
C4F4: 7F 10 D3       CLR    $10D3
C4F7: A6 14          LDA    -$C,X
C4F9: 48             ASLA
C4FA: 10 8E C5 2A    LDY    #$C52A
C4FE: 31 A6          LEAY   A,Y
C500: A6 4F          LDA    $F,U
C502: A0 0F          SUBA   $F,X
C504: 2A 02          BPL    $C508
C506: 43             COMA
C507: 4C             INCA
C508: A1 A4          CMPA   ,Y
C50A: 22 1D          BHI    $C529
C50C: EC 5E          LDD    -$2,U
C50E: A3 1E          SUBD   -$2,X
C510: 2A 05          BPL    $C517
C512: 43             COMA
C513: 53             COMB
C514: C3 00 01       ADDD   #$0001
C517: E1 21          CMPB   $1,Y
C519: 22 0E          BHI    $C529
C51B: 8C 24 D0       CMPX   #$24D0
C51E: 26 04          BNE    $C524
C520: 7C 10 D3       INC    $10D3
C523: 39             RTS
C524: 86 01          LDA    #$01
C526: B7 10 D3       STA    $10D3
C529: 39             RTS
C52A: 04 04          LSR    $04
C52C: 0A 12          DEC    $12
C52E: 08 04          ASL    $04
C530: 06 06          ROR    $06
C532: 04 08          LSR    $08
C534: EC 1E          LDD    -$2,X
C536: 83 00 18       SUBD   #$0018
C539: C4 F8          ANDB   #$F8
C53B: 58             ASLB
C53C: 49             ROLA
C53D: 58             ASLB
C53E: 49             ROLA
C53F: FD 10 CE       STD    $10CE
C542: E6 0F          LDB    $F,X
C544: 54             LSRB
C545: 54             LSRB
C546: 54             LSRB
C547: 4F             CLRA
C548: F3 10 CE       ADDD   $10CE
C54B: 27 1A          BEQ    $C567
C54D: 10 83 07 80    CMPD   #$0780
C551: 24 14          BCC    $C567
C553: 10 8E C5 6B    LDY    #$C56B
C557: 1F 03          TFR    D,U
C559: F6 10 C0       LDB    $10C0
C55C: A6 A5          LDA    B,Y
C55E: 33 C6          LEAU   A,U
C560: A6 C4          LDA    ,U
C562: E6 C9 08 00    LDB    $0800,U
C566: 39             RTS
C567: CC FF FF       LDD    #$FFFF
C56A: 39             RTS

C574: 8E 14 80       LDX    #$1480
C576: 80 4F          SUBA   #$4F
C578: E6 89 00 80    LDB    $0080,X
C57C: 2A 07          BPL    $C585
C57E: C5 10          BITB   #$10
C580: 26 04          BNE    $C586
C582: 4C             INCA
C583: 20 01          BRA    $C586
C585: 5F             CLRB
C586: E7 80          STB    ,X+
C588: 8C 14 F8       CMPX   #$14F8
C58B: 26 EB          BNE    $C578
C58D: 4D             TSTA
C58E: 10 26 01 36    LBNE   $C6C8
C592: 8E C7 50       LDX    #$C750
C595: CE 14 80       LDU    #$1480
C598: F6 10 40       LDB    $1040
C59B: 3A             ABX
C59C: 86 FE          LDA    #$FE
C59E: E6 80          LDB    ,X+
C5A0: FB 10 C1       ADDB   $10C1
C5A3: F7 10 47       STB    $1047
C5A6: 6C C5          INC    B,U
C5A8: EB 84          ADDB   ,X
C5AA: A7 C5          STA    B,U
C5AC: 8E 15 00       LDX    #$1500
C5AF: F6 10 47       LDB    $1047
C5B2: A6 85          LDA    B,X
C5B4: 8E C7 58       LDX    #$C758
C5B7: F6 10 40       LDB    $1040
C5BA: 58             ASLB
C5BB: 58             ASLB
C5BC: 58             ASLB
C5BD: 3A             ABX
C5BE: E6 86          LDB    A,X
C5C0: F7 10 48       STB    $1048
C5C3: AB 0F          ADDA   $F,X
C5C5: E6 86          LDB    A,X
C5C7: F7 10 40       STB    $1040
C5CA: 10 8E 15 00    LDY    #$1500
C5CE: B6 10 47       LDA    $1047
C5D1: 8E C7 98       LDX    #$C798
C5D4: F6 10 40       LDB    $1040
C5D7: 58             ASLB
C5D8: 58             ASLB
C5D9: 58             ASLB
C5DA: 3A             ABX
C5DB: C6 04          LDB    #$04
C5DD: F7 10 09       STB    $1009
C5E0: AB 84          ADDA   ,X
C5E2: E6 A6          LDB    A,Y
C5E4: E4 01          ANDB   $1,X
C5E6: 26 09          BNE    $C5F1
C5E8: 30 03          LEAX   $3,X
C5EA: 7A 10 09       DEC    $1009
C5ED: 26 F1          BNE    $C5E0
C5EF: 20 22          BRA    $C613
C5F1: E6 02          LDB    $2,X
C5F3: F7 10 40       STB    $1040
C5F6: E6 C6          LDB    A,U
C5F8: 2B 15          BMI    $C60F
C5FA: 27 0F          BEQ    $C60B
C5FC: B1 10 47       CMPA   $1047
C5FF: 26 D0          BNE    $C5D1
C601: F6 10 40       LDB    $1040
C604: F1 10 48       CMPB   $1048
C607: 26 C8          BNE    $C5D1
C609: 20 09          BRA    $C614
C60B: 6C C6          INC    A,U
C60D: 20 C2          BRA    $C5D1
C60F: C5 01          BITB   #$01
C611: 27 00          BEQ    $C613
C613: 39             RTS
C614: 7F 10 09       CLR    $1009
C617: 8E 14 88       LDX    #$1488
C61A: A6 84          LDA    ,X
C61C: 26 14          BNE    $C632
C61E: CE C7 A4       LDU    #$C7A4
C621: E6 C0          LDB    ,U+
C623: 27 0D          BEQ    $C632
C625: A6 85          LDA    B,X
C627: 2C F8          BGE    $C621
C629: 85 01          BITA   #$01
C62B: 26 F4          BNE    $C621
C62D: A7 84          STA    ,X
C62F: 7C 10 09       INC    $1009
C632: 30 01          LEAX   $1,X
C634: 8C 14 F0       CMPX   #$14F0
C637: 26 E1          BNE    $C61A
C639: A6 82          LDA    ,-X
C63B: 26 14          BNE    $C651
C63D: CE C7 A4       LDU    #$C7A4
C640: E6 C0          LDB    ,U+
C642: 27 0D          BEQ    $C651
C644: A6 85          LDA    B,X
C646: 2C F8          BGE    $C640
C648: 85 01          BITA   #$01
C64A: 26 F4          BNE    $C640
C64C: A7 84          STA    ,X
C64E: 7C 10 09       INC    $1009
C651: 8C 14 88       CMPX   #$1488
C654: 26 E3          BNE    $C639
C656: B6 10 09       LDA    $1009
C659: 26 B9          BNE    $C614
C65B: 7F 10 09       CLR    $1009
C65E: A6 84          LDA    ,X
C660: 26 10          BNE    $C672
C662: CE C7 A4       LDU    #$C7A4
C665: E6 C0          LDB    ,U+
C667: 27 09          BEQ    $C672
C669: A6 85          LDA    B,X
C66B: 2F F8          BLE    $C665
C66D: A7 84          STA    ,X
C66F: 7C 10 09       INC    $1009
C672: 30 01          LEAX   $1,X
C674: 8C 14 F0       CMPX   #$14F0
C677: 26 E5          BNE    $C65E
C679: A6 82          LDA    ,-X
C67B: 26 10          BNE    $C68D
C67D: CE C7 A4       LDU    #$C7A4
C680: E6 C0          LDB    ,U+
C682: 27 09          BEQ    $C68D
C684: A6 85          LDA    B,X
C686: 2F F8          BLE    $C680
C688: A7 84          STA    ,X
C68A: 7C 10 09       INC    $1009
C68D: 8C 14 88       CMPX   #$1488
C690: 26 E7          BNE    $C679
C692: B6 10 09       LDA    $1009
C695: 26 C4          BNE    $C65B
C697: 4F             CLRA
C698: E6 80          LDB    ,X+
C69A: 2B 01          BMI    $C69D
C69C: 4C             INCA
C69D: 8C 14 F0       CMPX   #$14F0
C6A0: 26 F6          BNE    $C698
C6A2: B7 10 34       STA    $1034
C6A5: 4F             CLRA
C6A6: E6 82          LDB    ,-X
C6A8: C5 01          BITB   #$01
C6AA: 26 01          BNE    $C6AD
C6AC: 4C             INCA
C6AD: 8C 14 88       CMPX   #$1488
C6B0: 26 F4          BNE    $C6A6
C6B2: 8E 14 F8       LDX    #$14F8
C6B5: B1 10 34       CMPA   $1034
C6B8: 25 0E          BCS    $C6C8
C6BA: A6 82          LDA    ,-X
C6BC: 43             COMA
C6BD: 84 80          ANDA   #$80
C6BF: A7 84          STA    ,X
C6C1: 8C 14 80       CMPX   #$1480
C6C4: 26 F4          BNE    $C6BA
C6C6: 20 0C          BRA    $C6D4
C6C8: A6 82          LDA    ,-X
C6CA: 4C             INCA
C6CB: 84 80          ANDA   #$80
C6CD: A7 84          STA    ,X
C6CF: 8C 14 80       CMPX   #$1480
C6D2: 26 F4          BNE    $C6C8
C6D4: 7F 10 09       CLR    $1009
C6D7: B6 10 5D       LDA    $105D
C6DA: 26 05          BNE    $C6E1
C6DC: 86 04          LDA    #$04
C6DE: B7 10 5D       STA    $105D
C6E1: 8E 14 89       LDX    #$1489
C6E4: 86 06          LDA    #$06
C6E6: E6 80          LDB    ,X+
C6E8: 27 35          BEQ    $C71F
C6EA: B7 10 34       STA    $1034
C6ED: CC 00 FF       LDD    #$00FF
C6F0: E7 88 7F       STB    $7F,X
C6F3: E6 86          LDB    A,X
C6F5: 27 06          BEQ    $C6FD
C6F7: 4C             INCA
C6F8: B1 10 34       CMPA   $1034
C6FB: 26 F6          BNE    $C6F3
C6FD: 48             ASLA
C6FE: 4C             INCA
C6FF: 48             ASLA
C700: 48             ASLA
C701: 48             ASLA
C702: A7 89 FF 7F    STA    -$0081,X
C706: B6 10 5D       LDA    $105D
C709: A7 89 FD FF    STA    -$0201,X
C70D: 7C 10 09       INC    $1009
C710: E6 89 01 00    LDB    $0100,X
C714: C1 0A          CMPB   #$0A
C716: 23 04          BLS    $C71C
C718: A7 89 FE 00    STA    -$0200,X
C71C: B6 10 34       LDA    $1034
C71F: 4A             DECA
C720: 26 C4          BNE    $C6E6
C722: 30 02          LEAX   $2,X
C724: 8C 14 F1       CMPX   #$14F1
C727: 26 BB          BNE    $C6E4
C729: CE 12 F7       LDU    #$12F7
C72C: B6 10 09       LDA    $1009
C72F: F6 10 5D       LDB    $105D
C732: A7 C5          STA    B,U
C734: 7A 10 5D       DEC    $105D
C737: CC 00 10       LDD    #$0010
C73A: BD 8A DB       JSR    $8ADB
C73D: CC 01 08       LDD    #$0108
C740: B7 10 D7       STA    $10D7
C743: 7A 17 20       DEC    $1720
C746: 27 01          BEQ    $C749
C748: 39             RTS
C749: B7 1F 60       STA    $1F60
C74C: F7 1F 74       STB    $1F74
C74F: 39             RTS

C7D8: 8E 13 00       LDX    #$1300
C7DB: 20 03          BRA    $C7E0
C7DD: 8E 13 80       LDX    #$1380                                      
C7E0: BF 10 36       STX    $1036                                       
C7E3: CC 00 78       LDD    #$0078                                     
C7E6: A7 80          STA    ,X+
C7E8: 5A             DECB
C7E9: 26 FB          BNE    $C7E6
C7EB: 8E E0 94       LDX    #$E094
C7EE: F6 17 04       LDB    $1704
C7F1: 5A             DECB
C7F2: C4 0F          ANDB   #$0F
C7F4: FB 17 21       ADDB   $1721
C7F7: 58             ASLB
C7F8: 3A             ABX
C7F9: EE 84          LDU    ,X
C7FB: A6 C0          LDA    ,U+
C7FD: 26 01          BNE    $C800
C7FF: 39             RTS
C800: B7 10 09       STA    $1009
C803: BE 10 36       LDX    $1036
C806: EC C1          LDD    ,U++
C808: 3A             ABX
C809: A7 84          STA    ,X
C80B: 7A 10 09       DEC    $1009
C80E: 26 F3          BNE    $C803
C810: 39             RTS
C811: 8E 15 00       LDX    #$1500
C814: 10 8E D3 88    LDY    #$D388
C818: A6 80          LDA    ,X+
C81A: AA 89 FD FF    ORA    -$0201,X
C81E: A0 1F          SUBA   -$1,X
C820: A7 89 FD FF    STA    -$0201,X
C824: 26 09          BNE    $C82F
C826: 31 22          LEAY   $2,Y
C828: 10 8C D4 78    CMPY   #$D478
C82C: 26 EA          BNE    $C818
C82E: 39             RTS
C82F: B7 10 CE       STA    $10CE
C832: AA 1F          ORA    -$1,X
C834: A7 1F          STA    -$1,X
C836: C6 04          LDB    #$04
C838: F7 10 CF       STB    $10CF
C83B: BF 10 36       STX    $1036
C83E: CE C8 D2       LDU    #$C8D2
C841: 76 10 CE       ROR    $10CE
C844: 24 75          BCC    $C8BB
C846: EC 44          LDD    $4,U
C848: B7 10 3C       STA    $103C
C84B: F7 10 40       STB    $1040
C84E: 86 04          LDA    #$04
C850: B7 10 09       STA    $1009
C853: AE A4          LDX    ,Y
C855: E6 C0          LDB    ,U+
C857: 3A             ABX
C858: A6 84          LDA    ,X
C85A: 2B 3C          BMI    $C898
C85C: E6 89 08 00    LDB    $0800,X
C860: C1 30          CMPB   #$30
C862: 26 07          BNE    $C86B
C864: BB 10 3C       ADDA   $103C
C867: A7 84          STA    ,X
C869: 20 49          BRA    $C8B4
C86B: C1 1F          CMPB   #$1F
C86D: 23 1B          BLS    $C88A
C86F: C5 04          BITB   #$04
C871: 27 04          BEQ    $C877
C873: C4 0F          ANDB   #$0F
C875: 20 13          BRA    $C88A
C877: 81 65          CMPA   #$65
C879: 26 04          BNE    $C87F
C87B: 8B 21          ADDA   #$21
C87D: 20 07          BRA    $C886
C87F: 81 66          CMPA   #$66
C881: 26 01          BNE    $C884
C883: 4A             DECA
C884: 8B 20          ADDA   #$20
C886: C4 0F          ANDB   #$0F
C888: 20 03          BRA    $C88D
C88A: BB 10 3C       ADDA   $103C
C88D: A7 84          STA    ,X
C88F: FA 10 40       ORB    $1040
C892: E7 89 08 00    STB    $0800,X
C896: 20 1C          BRA    $C8B4
C898: FF 10 38       STU    $1038
C89B: CE C4 21       LDU    #$C421
C89E: A1 C0          CMPA   ,U+
C8A0: 27 08          BEQ    $C8AA
C8A2: 11 83 C4 40    CMPU   #$C440
C8A6: 26 F6          BNE    $C89E
C8A8: 33 41          LEAU   $1,U
C8AA: E6 C8 3E       LDB    $3E,U
C8AD: E7 89 08 00    STB    $0800,X
C8B1: FE 10 38       LDU    $1038
C8B4: 7A 10 09       DEC    $1009
C8B7: 26 9C          BNE    $C855
C8B9: 33 5C          LEAU   -$4,U
C8BB: 33 46          LEAU   $6,U
C8BD: 7A 10 CF       DEC    $10CF
C8C0: 10 26 FF 7D    LBNE   $C841
C8C4: BE 10 36       LDX    $1036
C8C7: 31 22          LEAY   $2,Y
C8C9: 10 8C D4 78    CMPY   #$D478
C8CD: 10 26 FF 47    LBNE   $C818
C8D1: 39             RTS
C8D2: 00 20          NEG    $20
C8D4: 20 20          BRA    $C8F6

C8EA: B6 17 0C       LDA    $170C
C8ED: 20 04          BRA    $C8F3
C8EF: A6 5F          LDA    -$1,U
C8F1: 84 7F          ANDA   #$7F
C8F3: CE 15 80       LDU    #$1580
C8F6: E6 C6          LDB    A,U
C8F8: C1 09          CMPB   #$09
C8FA: 23 0B          BLS    $C907
C8FC: BD 8A A0       JSR    $8AA0
C8FF: 84 7F          ANDA   #$7F
C901: 81 78          CMPA   #$78
C903: 25 F1          BCS    $C8F6
C905: 20 F5          BRA    $C8FC
C907: E6 19          LDB    -$7,X
C909: 26 05          BNE    $C910
C90B: B7 17 0C       STA    $170C
C90E: 20 1E          BRA    $C92E
C910: B1 17 0C       CMPA   $170C
C913: 26 05          BNE    $C91A
C915: 7D 10 69       TST    $1069
C918: 27 E2          BEQ    $C8FC
C91A: CE 17 0C       LDU    #$170C
C91D: B7 10 34       STA    $1034
C920: A6 19          LDA    -$7,X
C922: 84 80          ANDA   #$80
C924: BA 10 34       ORA    $1034
C927: C4 0F          ANDB   #$0F
C929: A7 C5          STA    B,U
C92B: B6 10 34       LDA    $1034
C92E: 1F 89          TFR    A,B
C930: 84 07          ANDA   #$07
C932: 48             ASLA
C933: 48             ASLA
C934: 48             ASLA
C935: 48             ASLA
C936: 48             ASLA
C937: 8B 10          ADDA   #$10
C939: BB 10 69       ADDA   $1069
C93C: A7 0F          STA    $F,X
C93E: C4 78          ANDB   #$78
C940: 86 04          LDA    #$04
C942: 3D             MUL
C943: C3 00 20       ADDD   #$0020
C946: ED 1E          STD    -$2,X
C948: B6 80 00       LDA    watchdog_8000
C94B: 39             RTS
C94C: B7 10 C0       STA    $10C0
C94F: 84 02          ANDA   #$02
C951: B7 10 09       STA    $1009
C954: BD C5 34       JSR    $C534
C957: 81 70          CMPA   #$70
C959: 24 19          BCC    $C974
C95B: 86 70          LDA    #$70
C95D: A1 C8 E0       CMPA   -$20,U
C960: 23 12          BLS    $C974
C962: F6 10 09       LDB    $1009
C965: 26 09          BNE    $C970
C967: A1 41          CMPA   $1,U
C969: 23 09          BLS    $C974
C96B: A1 C8 E1       CMPA   -$1F,U
C96E: 23 04          BLS    $C974
C970: 7F 10 D8       CLR    $10D8
C973: 39             RTS
C974: B7 10 D8       STA    $10D8
C977: 39             RTS
C978: E6 05          LDB    $5,X
C97A: B6 10 C4       LDA    $10C4
C97D: 27 01          BEQ    $C980
C97F: 53             COMB
C980: C4 04          ANDB   #$04
C982: 58             ASLB
C983: 58             ASLB
C984: CE 1F 50       LDU    #$1F50
C987: 1E 31          EXG    U,X
C989: A6 45          LDA    $5,U
C98B: 10 AE 5E       LDY    -$2,U
C98E: 85 02          BITA   #$02
C990: 26 0B          BNE    $C99D
C992: EB 4F          ADDB   $F,U
C994: C4 F0          ANDB   #$F0
C996: E7 0F          STB    $F,X
C998: 10 AF 1E       STY    -$2,X
C99B: 20 0F          BRA    $C9AC
C99D: 31 A5          LEAY   B,Y
C99F: 10 AF 1E       STY    -$2,X
C9A2: E6 1F          LDB    -$1,X
C9A4: C4 F0          ANDB   #$F0
C9A6: E7 1F          STB    -$1,X
C9A8: E6 4F          LDB    $F,U
C9AA: E7 0F          STB    $F,X
C9AC: B6 10 13       LDA    $1013
C9AF: FF 10 36       STU    $1036
C9B2: 8D 98          BSR    $C94C
C9B4: BE 10 36       LDX    $1036
C9B7: 39             RTS
C9B8: 81 04          CMPA   #$04
C9BA: 26 01          BNE    $C9BD
C9BC: 48             ASLA
C9BD: B7 10 C0       STA    $10C0
C9C0: BD C5 34       JSR    $C534
C9C3: C1 28          CMPB   #$28
C9C5: 27 0F          BEQ    $C9D6
C9C7: 81 70          CMPA   #$70
C9C9: 24 0B          BCC    $C9D6
C9CB: 86 70          LDA    #$70
C9CD: A1 C8 E0       CMPA   -$20,U
C9D0: 23 04          BLS    $C9D6
C9D2: 7F 10 D8       CLR    $10D8
C9D5: 39             RTS
C9D6: B7 10 D8       STA    $10D8
C9D9: 39             RTS
C9DA: 8E 15 FF       LDX    #$15FF
C9DD: 10 8E D4 76    LDY    #$D476
C9E1: C6 3C          LDB    #$3C
C9E3: A6 85          LDA    B,X
C9E5: 27 5D          BEQ    $CA44
C9E7: F7 10 35       STB    $1035
C9EA: BF 10 36       STX    $1036
C9ED: 58             ASLB
C9EE: AE A5          LDX    B,Y
C9F0: 30 89 08 00    LEAX   $0800,X
C9F4: CE CC 20       LDU    #$CC20
C9F7: 5F             CLRB
C9F8: F7 10 CE       STB    $10CE
C9FB: A6 85          LDA    B,X
C9FD: 81 30          CMPA   #$30
C9FF: 27 08          BEQ    $CA09
CA01: B6 10 CE       LDA    $10CE
CA04: AA 44          ORA    $4,U
CA06: B7 10 CE       STA    $10CE
CA09: E6 C0          LDB    ,U+
CA0B: 26 EE          BNE    $C9FB
CA0D: B6 10 CE       LDA    $10CE
CA10: 27 23          BEQ    $CA35
CA12: CE C1 96       LDU    #$C196
CA15: 10 BF 10 3A    STY    $103A
CA19: 10 8E CB FA    LDY    #$CBFA
CA1D: 44             LSRA
CA1E: 25 0E          BCS    $CA2E
CA20: E6 89 F8 00    LDB    -$0800,X
CA24: CB 50          ADDB   #$50
CA26: E7 89 F8 00    STB    -$0800,X
CA2A: E6 A5          LDB    B,Y
CA2C: E7 84          STB    ,X
CA2E: E6 C0          LDB    ,U+
CA30: 27 06          BEQ    $CA38
CA32: 3A             ABX
CA33: 20 E8          BRA    $CA1D
CA35: 4C             INCA
CA36: 20 04          BRA    $CA3C
CA38: 10 BE 10 3A    LDY    $103A
CA3C: F6 10 35       LDB    $1035
CA3F: BE 10 36       LDX    $1036
CA42: A7 85          STA    B,X
CA44: 5A             DECB
CA45: 26 9C          BNE    $C9E3
CA47: 8E 15 88       LDX    #$1588
CA4A: 86 08          LDA    #$08
CA4C: B7 10 09       STA    $1009
CA4F: 10 8E CC 31    LDY    #$CC31
CA53: A6 89 FE 80    LDA    -$0180,X
CA57: 10 2C 01 B8    LBGE   $CC13
CA5B: 7F 10 CF       CLR    $10CF
CA5E: 6F 89 FE 80    CLR    -$0180,X
CA62: A6 84          LDA    ,X
CA64: E6 A6          LDB    A,Y
CA66: 53             COMB
CA67: C4 0F          ANDB   #$0F
CA69: F7 10 35       STB    $1035
CA6C: CE CC 28       LDU    #$CC28
CA6F: E6 C1          LDB    ,U++
CA71: 27 12          BEQ    $CA85
CA73: A6 85          LDA    B,X
CA75: 81 0A          CMPA   #$0A
CA77: 27 F6          BEQ    $CA6F
CA79: E6 A6          LDB    A,Y
CA7B: E4 5F          ANDB   -$1,U
CA7D: FA 10 CF       ORB    $10CF
CA80: F7 10 CF       STB    $10CF
CA83: 20 EA          BRA    $CA6F
CA85: F6 10 CF       LDB    $10CF
CA88: F4 10 35       ANDB   $1035
CA8B: F7 10 CF       STB    $10CF
CA8E: BF 10 36       STX    $1036
CA91: 8E D3 88       LDX    #$D388
CA94: F6 10 09       LDB    $1009
CA97: 58             ASLB
CA98: 3A             ABX
CA99: CC 00 04       LDD    #$0004
CA9C: B7 10 3A       STA    $103A
CA9F: F7 10 CE       STB    $10CE
CAA2: EE 84          LDU    ,X
CAA4: 33 C8 20       LEAU   $20,U
CAA7: FF 10 38       STU    $1038
CAAA: 8E CC 46       LDX    #$CC46
CAAD: 76 10 CF       ROR    $10CF
CAB0: 10 24 01 50    LBCC   $CC04
CAB4: A6 80          LDA    ,X+
CAB6: 10 27 01 4C    LBEQ   $CC06
CABA: 7A 10 3A       DEC    $103A
CABD: 33 C6          LEAU   A,U
CABF: E6 C9 08 00    LDB    $0800,U
CAC3: C4 3F          ANDB   #$3F
CAC5: A6 C4          LDA    ,U
CAC7: 2A 32          BPL    $CAFB
CAC9: C1 0F          CMPB   #$0F
CACB: 27 E7          BEQ    $CAB4
CACD: C1 10          CMPB   #$10
CACF: 10 25 00 A0    LBCS   $CB73
CAD3: 81 D0          CMPA   #$D0
CAD5: 27 DD          BEQ    $CAB4
CAD7: 81 EA          CMPA   #$EA
CAD9: 27 10          BEQ    $CAEB
CADB: 81 A3          CMPA   #$A3
CADD: 27 04          BEQ    $CAE3
CADF: 81 84          CMPA   #$84
CAE1: 26 10          BNE    $CAF3
CAE3: C6 25          LDB    #$25
CAE5: E7 C9 08 00    STB    $0800,U
CAE9: 20 C9          BRA    $CAB4
CAEB: C6 36          LDB    #$36
CAED: E7 C9 08 00    STB    $0800,U
CAF1: 20 C1          BRA    $CAB4
CAF3: C6 09          LDB    #$09
CAF5: E7 C9 08 00    STB    $0800,U
CAF9: 20 B9          BRA    $CAB4
CAFB: C4 0F          ANDB   #$0F
CAFD: 84 03          ANDA   #$03
CAFF: 81 03          CMPA   #$03
CB01: 10 26 00 84    LBNE   $CB89
CB05: B6 10 CE       LDA    $10CE
CB08: 81 04          CMPA   #$04
CB0A: 27 A8          BEQ    $CAB4
CB0C: 81 02          CMPA   #$02
CB0E: 27 09          BEQ    $CB19
CB10: B6 10 3A       LDA    $103A
CB13: 85 02          BITA   #$02
CB15: 27 43          BEQ    $CB5A
CB17: 20 70          BRA    $CB89
CB19: B7 10 34       STA    $1034
CB1C: A6 C4          LDA    ,U
CB1E: 81 67          CMPA   #$67
CB20: 27 13          BEQ    $CB35
CB22: 81 6B          CMPA   #$6B
CB24: 26 31          BNE    $CB57
CB26: A6 C8 E0       LDA    -$20,U
CB29: 2A 2C          BPL    $CB57
CB2B: 81 B8          CMPA   #$B8
CB2D: 27 28          BEQ    $CB57
CB2F: 81 85          CMPA   #$85
CB31: 27 24          BEQ    $CB57
CB33: 20 0D          BRA    $CB42
CB35: A6 C8 20       LDA    $20,U
CB38: 2A 1D          BPL    $CB57
CB3A: 81 B0          CMPA   #$B0
CB3C: 27 19          BEQ    $CB57
CB3E: 81 8A          CMPA   #$8A
CB40: 27 15          BEQ    $CB57
CB42: CA 20          ORB    #$20
CB44: E7 C9 08 00    STB    $0800,U
CB48: E6 C9 08 01    LDB    $0801,U
CB4C: C4 0F          ANDB   #$0F
CB4E: CA 20          ORB    #$20
CB50: E7 C9 08 01    STB    $0801,U
CB54: 7E CA B4       JMP    $CAB4
CB57: B6 10 34       LDA    $1034
CB5A: 84 01          ANDA   #$01
CB5C: 43             COMA
CB5D: 84 1F          ANDA   #$1F
CB5F: AB C4          ADDA   ,U
CB61: 81 86          CMPA   #$86
CB63: 27 04          BEQ    $CB69
CB65: 81 82          CMPA   #$82
CB67: 26 01          BNE    $CB6A
CB69: 4A             DECA
CB6A: A7 C4          STA    ,U
CB6C: E7 C9 08 00    STB    $0800,U
CB70: 7E CA B4       JMP    $CAB4
CB73: B6 10 CE       LDA    $10CE
CB76: 81 04          CMPA   #$04
CB78: 10 27 FF 38    LBEQ   $CAB4
CB7C: A6 C4          LDA    ,U
CB7E: 81 85          CMPA   #$85
CB80: 26 01          BNE    $CB83
CB82: 4C             INCA
CB83: 80 1F          SUBA   #$1F
CB85: A7 C4          STA    ,U
CB87: C4 0F          ANDB   #$0F
CB89: B6 10 CE       LDA    $10CE
CB8C: 85 01          BITA   #$01
CB8E: 27 6B          BEQ    $CBFB
CB90: 85 02          BITA   #$02
CB92: 27 05          BEQ    $CB99
CB94: A6 C8 20       LDA    $20,U
CB97: 20 03          BRA    $CB9C
CB99: A6 C8 E0       LDA    -$20,U
CB9C: 81 FC          CMPA   #$FC
CB9E: 25 36          BCS    $CBD6
CBA0: A6 5F          LDA    -$1,U
CBA2: 81 FC          CMPA   #$FC
CBA4: 24 55          BCC    $CBFB
CBA6: 81 81          CMPA   #$81
CBA8: 27 20          BEQ    $CBCA
CBAA: 81 8E          CMPA   #$8E
CBAC: 27 2C          BEQ    $CBDA
CBAE: 81 BC          CMPA   #$BC
CBB0: 26 0C          BNE    $CBBE
CBB2: A6 C9 07 FF    LDA    $07FF,U
CBB6: 81 28          CMPA   #$28
CBB8: 26 1C          BNE    $CBD6
CBBA: 86 01          LDA    #$01
CBBC: 20 9C          BRA    $CB5A
CBBE: 81 B5          CMPA   #$B5
CBC0: 26 14          BNE    $CBD6
CBC2: A6 C9 07 FF    LDA    $07FF,U
CBC6: 81 28          CMPA   #$28
CBC8: 26 0C          BNE    $CBD6
CBCA: CC 86 09       LDD    #$8609
CBCD: A7 C4          STA    ,U
CBCF: E7 C9 08 00    STB    $0800,U
CBD3: 7E CA B4       JMP    $CAB4
CBD6: 81 8D          CMPA   #$8D
CBD8: 26 05          BNE    $CBDF
CBDA: CC 89 03       LDD    #$8903
CBDD: 20 8B          BRA    $CB6A
CBDF: B6 10 3A       LDA    $103A
CBE2: 85 02          BITA   #$02
CBE4: 27 15          BEQ    $CBFB
CBE6: A6 C9 07 FF    LDA    $07FF,U
CBEA: 81 10          CMPA   #$10
CBEC: 25 0D          BCS    $CBFB
CBEE: 81 20          CMPA   #$20
CBF0: 24 09          BCC    $CBFB
CBF2: CA 10          ORB    #$10
CBF4: E7 C9 08 00    STB    $0800,U
CBF8: 7E CA B4       JMP    $CAB4
CBFB: CA 20          ORB    #$20
CBFD: E7 C9 08 00    STB    $0800,U
CC01: 7E CA B4       JMP    $CAB4
CC04: 30 05          LEAX   $5,X
CC06: FE 10 38       LDU    $1038
CC09: 7A 10 CE       DEC    $10CE
CC0C: 10 26 FE 9D    LBNE   $CAAD
CC10: BE 10 36       LDX    $1036
CC13: 7C 10 09       INC    $1009
CC16: 30 01          LEAX   $1,X
CC18: 8C 15 F0       CMPX   #$15F0
CC1B: 10 26 FE 34    LBNE   $CA53
CC1F: 39             RTS

CC6A: 8E 1F 70       LDX    #$1F70
CC6C: 70 A6 10       NEG    $A610
CC6F: 27 0E          BEQ    $CC7F
CC71: CE 15 80       LDU    #$1580
CC74: BD CD 83       JSR    $CD83
CC77: A6 C5          LDA    B,U
CC79: 81 0A          CMPA   #$0A
CC7B: 25 02          BCS    $CC7F
CC7D: 6F 10          CLR    -$10,X
CC7F: 8E 25 30       LDX    #$2530
CC82: A6 10          LDA    -$10,X
CC84: 27 39          BEQ    $CCBF
CC86: A6 1A          LDA    -$6,X
CC88: 81 0D          CMPA   #$0D
CC8A: 24 33          BCC    $CCBF
CC8C: BD CD 9B       JSR    $CD9B
CC8F: 4D             TSTA
CC90: 27 2D          BEQ    $CCBF
CC92: E6 05          LDB    $5,X
CC94: C4 06          ANDB   #$06
CC96: CB 10          ADDB   #$10
CC98: E7 0A          STB    $A,X
CC9A: A6 19          LDA    -$7,X
CC9C: 2A 13          BPL    $CCB1
CC9E: CB 08          ADDB   #$08
CCA0: E7 0A          STB    $A,X
CCA2: A6 13          LDA    -$D,X
CCA4: 27 0B          BEQ    $CCB1
CCA6: BF 10 36       STX    $1036
CCA9: AE 15          LDX    -$B,X
CCAB: BD 87 32       JSR    $8732
CCAE: BE 10 36       LDX    $1036
CCB1: CC 3F 0F       LDD    #$3F0F
CCB4: A7 04          STA    $4,X
CCB6: E7 1A          STB    -$6,X
CCB8: CC 00 01       LDD    #$0001
CCBB: A7 08          STA    $8,X
CCBD: E7 0B          STB    $B,X
CCBF: 30 88 20       LEAX   $20,X
CCC2: 8C 26 70       CMPX   #$2670
CCC5: 26 BB          BNE    $CC82
CCC7: B6 10 DA       LDA    $10DA
CCCA: BA 10 D0       ORA    $10D0
CCCD: 27 01          BEQ    $CCD0
CCCF: 39             RTS
CCD0: 8E 25 10       LDX    #$2510
CCD3: 86 01          LDA    #$01
CCD5: B7 10 C0       STA    $10C0
CCD8: BD C5 34       JSR    $C534
CCDB: 7D 10 EC       TST    $10EC
CCDE: 27 23          BEQ    $CD03
CCE0: 81 70          CMPA   #$70
CCE2: 10 25 00 84    LBCS   $CD6A
CCE6: A6 C8 20       LDA    $20,U
CCE9: 81 70          CMPA   #$70
CCEB: 10 25 00 7B    LBCS   $CD6A
CCEF: A6 41          LDA    $1,U
CCF1: 81 70          CMPA   #$70
CCF3: 10 25 00 73    LBCS   $CD6A
CCF7: A6 C8 21       LDA    $21,U
CCFA: 81 70          CMPA   #$70
CCFC: 25 6C          BCS    $CD6A
CCFE: CC 44 06       LDD    #$4406
CD01: 20 33          BRA    $CD36
CD03: EA C9 08 01    ORB    $0801,U
CD07: EA C9 08 21    ORB    $0821,U
CD0B: EA C9 08 20    ORB    $0820,U
CD0F: C4 80          ANDB   #$80
CD11: F7 10 EB       STB    $10EB
CD14: 5F             CLRB
CD15: 8E CD 6B       LDX    #$CD6B
CD18: A6 81          LDA    ,X++
CD1A: A6 C6          LDA    A,U
CD1C: 81 90          CMPA   #$90
CD1E: 25 02          BCS    $CD22
CD20: EA 1F          ORB    -$1,X
CD22: 8C CD 73       CMPX   #$CD73
CD25: 26 F1          BNE    $CD18
CD27: A6 85          LDA    B,X
CD29: 27 3F          BEQ    $CD6A
CD2B: 2A 03          BPL    $CD30
CD2D: CC 44 06       LDD    #$4406
CD30: 7D 10 EB       TST    $10EB
CD33: 26 01          BNE    $CD36
CD35: 39             RTS
CD36: 8E 25 10       LDX    #$2510
CD39: 6F 08          CLR    $8,X
CD3B: A7 0A          STA    $A,X
CD3D: 81 40          CMPA   #$40
CD3F: 26 06          BNE    $CD47
CD41: 86 06          LDA    #$06
CD43: AB 0F          ADDA   $F,X
CD45: A7 0F          STA    $F,X
CD47: C1 08          CMPB   #$08
CD49: 25 08          BCS    $CD53
CD4B: C1 09          CMPB   #$09
CD4D: 27 04          BEQ    $CD53
CD4F: 86 02          LDA    #$02
CD51: A7 08          STA    $8,X
CD53: CC 01 5F       LDD    #$015F
CD56: B7 10 DA       STA    $10DA
CD59: E7 04          STB    $4,X
CD5B: 7F 25 01       CLR    $2501
CD5E: B6 25 02       LDA    $2502
CD61: 26 01          BNE    $CD64
CD63: 39             RTS
CD64: BD A5 4F       JSR    $A54F
CD67: 7F 25 02       CLR    $2502
CD6A: 39             RTS

CD83: E6 0F          LDB    $F,X
CD85: 54             LSRB
CD86: 54             LSRB
CD87: 54             LSRB
CD88: 54             LSRB
CD89: 54             LSRB
CD8A: F7 10 35       STB    $1035
CD8D: EC 1E          LDD    -$2,X
CD8F: 83 00 10       SUBD   #$0010
CD92: C4 E0          ANDB   #$E0
CD94: 46             RORA
CD95: 56             RORB
CD96: 54             LSRB
CD97: FB 10 35       ADDB   $1035
CD9A: 39             RTS
CD9B: 86 01          LDA    #$01
CD9D: B7 10 C0       STA    $10C0
CDA0: BD C5 34       JSR    $C534
CDA3: 86 70          LDA    #$70
CDA5: F6 10 EC       LDB    $10EC
CDA8: 27 0F          BEQ    $CDB9
CDAA: A1 41          CMPA   $1,U
CDAC: 10 22 00 96    LBHI   $CE46
CDB0: A1 C8 21       CMPA   $21,U
CDB3: 10 22 00 8F    LBHI   $CE46
CDB7: 20 06          BRA    $CDBF
CDB9: E6 1A          LDB    -$6,X
CDBB: C1 0C          CMPB   #$0C
CDBD: 27 27          BEQ    $CDE6
CDBF: A1 C4          CMPA   ,U
CDC1: 10 22 00 81    LBHI   $CE46
CDC5: A1 C8 20       CMPA   $20,U
CDC8: 22 7C          BHI    $CE46
CDCA: 5F             CLRB
CDCB: A1 C8 E0       CMPA   -$20,U
CDCE: 22 02          BHI    $CDD2
CDD0: CA 01          ORB    #$01
CDD2: A1 C8 40       CMPA   $40,U
CDD5: 22 02          BHI    $CDD9
CDD7: CA 02          ORB    #$02
CDD9: C1 03          CMPB   #$03
CDDB: 27 42          BEQ    $CE1F
CDDD: 86 04          LDA    #$04
CDDF: C5 02          BITB   #$02
CDE1: 26 36          BNE    $CE19
CDE3: 40             NEGA
CDE4: 20 33          BRA    $CE19
CDE6: 5F             CLRB
CDE7: A6 C4          LDA    ,U
CDE9: 81 70          CMPA   #$70
CDEB: 25 07          BCS    $CDF4
CDED: 84 F0          ANDA   #$F0
CDEF: 81 80          CMPA   #$80
CDF1: 27 01          BEQ    $CDF4
CDF3: 5C             INCB
CDF4: A6 C8 20       LDA    $20,U
CDF7: 81 70          CMPA   #$70
CDF9: 25 08          BCS    $CE03
CDFB: 84 F0          ANDA   #$F0
CDFD: 81 80          CMPA   #$80
CDFF: 27 02          BEQ    $CE03
CE01: 5C             INCB
CE02: 5C             INCB
CE03: F7 10 CF       STB    $10CF
CE06: 27 3E          BEQ    $CE46
CE08: C1 03          CMPB   #$03
CE0A: 27 13          BEQ    $CE1F
CE0C: 86 08          LDA    #$08
CE0E: C5 02          BITB   #$02
CE10: 26 01          BNE    $CE13
CE12: 40             NEGA
CE13: E6 1F          LDB    -$1,X
CE15: C4 F0          ANDB   #$F0
CE17: E7 1F          STB    -$1,X
CE19: EE 1E          LDU    -$2,X
CE1B: 33 C6          LEAU   A,U
CE1D: EF 1E          STU    -$2,X
CE1F: B6 10 EC       LDA    $10EC
CE22: 26 19          BNE    $CE3D
CE24: CE 12 80       LDU    #$1280
CE27: 10 8E 12 FB    LDY    #$12FB
CE2B: BD CD 83       JSR    $CD83
CE2E: A6 C5          LDA    B,U
CE30: 26 11          BNE    $CE43
CE32: 5A             DECB
CE33: A6 C5          LDA    B,U
CE35: 26 0C          BNE    $CE43
CE37: CB 02          ADDB   #$02
CE39: A6 C5          LDA    B,U
CE3B: 26 06          BNE    $CE43
CE3D: 7C 10 CB       INC    $10CB
CE40: 86 01          LDA    #$01
CE42: 39             RTS
CE43: 6C A6          INC    A,Y
CE45: 39             RTS
CE46: 4F             CLRA
CE47: 39             RTS



reset_e5ba:
E5BA: 7F 38 00       CLR    $3800
E5BD: B6 80 00       LDA    watchdog_8000
E5C0: 1C FF          ANDCC  #$FF
E5C2: B6 80 00       LDA    watchdog_8000
E5C5: 7F 50 02       CLR    video_stuff_5002
E5C8: 7F 50 0A       CLR    video_stuff_500A
E5CB: 7F 50 08       CLR    video_stuff_5008
E5CE: 86 08          LDA    #$08		; branch to E649 to skip ROM/RAM test
E5D0: 8E 00 00       LDX    #$0000
E5D3: A7 84          STA    ,X
E5D5: 7F 80 00       CLR    watchdog_8000
E5D8: A1 80          CMPA   ,X+
E5DA: 26 3D          BNE    $E619
E5DC: 8C 28 00       CMPX   #$2800
E5DF: 26 F2          BNE    $E5D3
E5E1: 8E 40 40       LDX    #$4040
E5E4: A7 84          STA    ,X
E5E6: 7F 80 00       CLR    watchdog_8000
E5E9: A1 80          CMPA   ,X+
E5EB: 26 38          BNE    $E625
E5ED: 8C 44 00       CMPX   #$4400
E5F0: 26 F2          BNE    $E5E4
E5F2: 8E 00 00       LDX    #$0000
E5F5: E6 84          LDB    ,X
E5F7: 7F 80 00       CLR    watchdog_8000
E5FA: E1 80          CMPB   ,X+
E5FC: 26 1B          BNE    $E619
E5FE: 8C 28 00       CMPX   #$2800
E601: 26 F2          BNE    $E5F5
E603: 8E 40 40       LDX    #$4040
E606: E6 84          LDB    ,X
E608: 7F 80 00       CLR    watchdog_8000
E60B: E1 80          CMPB   ,X+
E60D: 26 16          BNE    $E625
E60F: 8C 44 00       CMPX   #$4400
E612: 26 F2          BNE    $E606
E614: 4A             DECA
E615: 26 B9          BNE    $E5D0
E617: 20 30          BRA    $E649
E619: 30 1F          LEAX   -$1,X
E61B: 1F 10          TFR    X,D
E61D: 84 3F          ANDA   #$3F
E61F: 44             LSRA
E620: 44             LSRA
E621: 44             LSRA
E622: 4C             INCA
E623: 20 0A          BRA    $E62F
E625: 84 F0          ANDA   #$F0
E627: 27 04          BEQ    $E62D
E629: 86 06          LDA    #$06
E62B: 20 02          BRA    $E62F
E62D: 86 07          LDA    #$07
E62F: 7F 10 08       CLR    $1008
E632: CE 00 00       LDU    #$0000
E635: C6 20          LDB    #$20
E637: E7 C0          STB    ,U+
E639: 6F C9 07 FF    CLR    $07FF,U
E63D: 7F 80 00       CLR    watchdog_8000
E640: 11 83 07 FF    CMPU   #$07FF
E644: 26 F1          BNE    $E637
E646: B7 02 C6       STA    $02C6
end_of_rom_ram_test_e649:
; clear RAM
E649: 8E 10 00       LDX    #sync_1000
E64C: CE 00 00       LDU    #$0000
E64F: EF 81          STU    ,X++
E651: 7F 80 00       CLR    watchdog_8000
E654: 8C 28 00       CMPX   #$2800
E657: 26 F6          BNE    $E64F
; clear ... all memory doing a X wrap. Bug? whatever
E659: 8E 40 40       LDX    #$4040
E65C: EF 81          STU    ,X++
E65E: 7F 80 00       CLR    watchdog_8000
E661: 8C 44 00       CMPX   #$4400
E664: 26 F6          BNE    $E65C
end_of_memory_clear_e666:
E666: 10 CE 19 00    LDS    #stack_top_1900
E66A: C6 00          LDB    #$00
E66C: 1F 9B          TFR    B,DP
E66E: 7F 10 08       CLR    $1008
E671: 4D             TSTA
E672: 26 06          BNE    $E67A
E674: BD 87 01       JSR    $8701
E677: 7F 02 C6       CLR    $02C6

; lower part rom checksum
E67A: 8E 80 00       LDX    #watchdog_8000
E67D: 4F             CLRA
E67E: AB 80          ADDA   ,X+
E680: 7F 80 00       CLR    watchdog_8000
E683: 8C C0 00       CMPX   #$C000
E686: 26 F6          BNE    $E67E
E688: 81 73          CMPA   #$73
E68A: 26 16          BNE    checksum_failed_e6a2
; upper part rom checksum
E68C: 8E C0 00       LDX    #$C000
E68F: 4F             CLRA
E690: AB 80          ADDA   ,X+
E692: 7F 80 00       CLR    watchdog_8000
E695: 8C FF FF       CMPX   #$FFFF
E698: 26 F6          BNE    $E690
E69A: AB 84          ADDA   ,X
E69C: 81 77          CMPA   #$77
E69E: 26 06          BNE    checksum_failed_e6a6
E6A0: 20 09          BRA    continue_boot_e6ab
checksum_failed_e6a2:
E6A2: C6 01          LDB    #$01		; lower part failure
E6A4: 20 02          BRA    $E6A8
checksum_failed_e6a6:
E6A6: C6 02          LDB    #$02
E6A8: F7 03 06       STB    checksum_failed_flag_0306
continue_boot_e6ab:
; clear io registers
E6AB: 86 08          LDA    #$08
E6AD: B7 10 34       STA    $1034
E6B0: 8E 48 00       LDX    #namco_io_4800
E6B3: A7 84          STA    ,X
E6B5: 7F 80 00       CLR    watchdog_8000
E6B8: E6 80          LDB    ,X+
E6BA: C4 0F          ANDB   #$0F
E6BC: F1 10 34       CMPB   $1034
E6BF: 26 0D          BNE    $E6CE
E6C1: 8C 4C 00       CMPX   #$4C00
E6C4: 26 ED          BNE    $E6B3
E6C6: 4A             DECA
E6C7: 26 E4          BNE    $E6AD
continue_boot_e6c9:
E6C9: B7 02 86       STA    $0286
E6CC: 20 05          BRA    $E6D3
E6CE: 86 01          LDA    #$01
E6D0: B7 02 86       STA    $0286
E6D3: 1C EF          ANDCC  #$EF
E6D5: 7F 50 03       CLR    video_stuff_5003
E6D8: 7F 10 00       CLR    sync_1000
E6DB: B6 10 00       LDA    sync_1000
E6DE: 27 FB          BEQ    $E6DB
E6E0: B6 80 00       LDA    watchdog_8000
E6E3: 7F 50 03       CLR    video_stuff_5003
E6E6: 7F 10 00       CLR    sync_1000
E6E9: BD EA 17       JSR    io_stuff_ea17
E6EC: BD EB B9       JSR    $EBB9
E6EF: B6 10 00       LDA    sync_1000
E6F2: 27 FB          BEQ    $E6EF
E6F4: B6 80 00       LDA    watchdog_8000
E6F7: 7F 50 03       CLR    video_stuff_5003
E6FA: 7F 10 00       CLR    sync_1000
E6FD: BD EA 17       JSR    io_stuff_ea17
E700: BD EB B9       JSR    $EBB9
; clear IO regs again...
E703: 8E 48 00       LDX    #namco_io_4800
E706: CC 00 00       LDD    #$0000
E709: ED 81          STD    ,X++
E70B: 8C 48 20       CMPX   #$4820
E70E: 26 F9          BNE    $E709
end_io_regs_clear_e710:
E710: B7 50 09       STA    video_stuff_5009
E713: B7 50 0B       STA    video_stuff_500B
E716: B6 10 00       LDA    sync_1000
E719: 27 FB          BEQ    $E716
E71B: B6 80 00       LDA    watchdog_8000
E71E: 7F 50 03       CLR    video_stuff_5003
E721: 7F 10 00       CLR    sync_1000
E724: BD EA 17       JSR    io_stuff_ea17
E727: BD EB B9       JSR    $EBB9
E72A: B6 10 00       LDA    sync_1000
E72D: 27 FB          BEQ    $E72A
E72F: B6 80 00       LDA    watchdog_8000
E732: 7F 50 03       CLR    video_stuff_5003
E735: 7F 10 00       CLR    sync_1000
E738: BD EA 17       JSR    io_stuff_ea17
E73B: BD EB B9       JSR    $EBB9
E73E: 86 04          LDA    #$04
E740: B7 48 18       STA    io_register_4818
E743: B6 10 00       LDA    sync_1000
E746: 27 FB          BEQ    $E743
E748: B6 80 00       LDA    watchdog_8000
E74B: 7F 50 03       CLR    video_stuff_5003
E74E: 7F 10 00       CLR    sync_1000
E751: BD EA 17       JSR    io_stuff_ea17
E754: BD EB B9       JSR    $EBB9
E757: B6 10 00       LDA    sync_1000
E75A: 27 FB          BEQ    $E757
E75C: B6 80 00       LDA    watchdog_8000
E75F: 7F 50 03       CLR    video_stuff_5003
E762: 7F 10 00       CLR    sync_1000
E765: BD EA 17       JSR    io_stuff_ea17
E768: BD EB B9       JSR    $EBB9
E76B: 8E 48 10       LDX    #$4810
E76E: CE EB 3A       LDU    #$EB3A
E771: 86 08          LDA    #$08
E773: E6 C0          LDB    ,U+
E775: E7 82          STB    ,-X
E777: 4A             DECA
E778: 26 F9          BNE    $E773
end_write_4810_zone_e77a:
E77A: B6 10 00       LDA    sync_1000
E77D: 27 FB          BEQ    $E77A
E77F: B6 80 00       LDA    watchdog_8000
E782: 7F 50 03       CLR    video_stuff_5003
E785: 7F 10 00       CLR    sync_1000
E788: BD EA 17       JSR    io_stuff_ea17
E78B: BD EB B9       JSR    $EBB9
E78E: B6 10 00       LDA    sync_1000
E791: 27 FB          BEQ    $E78E
E793: B6 80 00       LDA    watchdog_8000
E796: 7F 50 03       CLR    video_stuff_5003
E799: 7F 10 00       CLR    sync_1000
E79C: BD EA 17       JSR    io_stuff_ea17
E79F: BD EB B9       JSR    $EBB9
E7A2: B6 03 06       LDA    checksum_failed_flag_0306		; [unchecked_address]
E7A5: 85 03          BITA   #$03
E7A7: 26 37          BNE    $E7E0
E7A9: C6 01          LDB    #$01
E7AB: F7 40 B0       STB    $40B0
E7AE: B6 80 00       LDA    watchdog_8000
E7B1: F1 40 B0       CMPB   $40B0
E7B4: 27 F8          BEQ    $E7AE
E7B6: B6 40 B0       LDA    $40B0
E7B9: 81 E4          CMPA   #$E4
E7BB: 27 0B          BEQ    $E7C8
; failed protection?? sync with sound cpu?
E7BD: CC 00 03       LDD    #$0003
E7C0: B7 40 B0       STA    $40B0
E7C3: F7 03 06       STB    checksum_failed_flag_0306	; [video_address]
E7C6: 20 18          BRA    $E7E0
E7C8: 7F 03 06       CLR    checksum_failed_flag_0306	; [video_address]
E7CB: 7F 40 B0       CLR    $40B0
E7CE: 86 FF          LDA    #$FF
E7D0: B7 10 CE       STA    $10CE
E7D3: B6 80 00       LDA    watchdog_8000
E7D6: 7A 10 CF       DEC    $10CF
E7D9: 26 F8          BNE    $E7D3
E7DB: 7A 10 CE       DEC    $10CE
E7DE: 26 F3          BNE    $E7D3
E7E0: B6 03 06       LDA    checksum_failed_flag_0306	; [unchecked_address]
E7E3: BB 02 C6       ADDA   $02C6
E7E6: BB 02 86       ADDA   $0286
E7E9: 26 21          BNE    $E80C
; write text
E7EB: 8E 03 06       LDX    #checksum_failed_flag_0306	; now this is a video address!
E7EE: CE EB 4E       LDU    #$EB4E			; "RAM OK"
E7F1: 86 06          LDA    #$06			; length
E7F3: BD 85 90       JSR    write_text_8590
E7F6: 8E 03 04       LDX    #$0304
E7F9: CE EB 54       LDU    #$EB54
E7FC: 86 06          LDA    #$06
E7FE: BD 85 90       JSR    write_text_8590
E801: 8E 03 08       LDX    #$0308
E804: CE EB 5A       LDU    #$EB5A
E807: 86 06          LDA    #$06
E809: BD 85 90       JSR    write_text_8590
E80C: 7F 10 16       CLR    $1016
E80F: 7F 02 14       CLR    $0214
E812: 7F 01 F4       CLR    $01F4
E815: 86 4F          LDA    #$4F
E817: B7 02 10       STA    $0210
E81A: B7 02 16       STA    $0216
E81D: 8E 02 CD       LDX    #$02CD
E820: CE EB 60       LDU    #$EB60
E823: 86 0E          LDA    #$0E
E825: BD 85 90       JSR    write_text_8590
E828: 8E 03 10       LDX    #$0310
E82B: CE EB 87       LDU    #$EB87
E82E: 86 06          LDA    #$06
E830: BD 85 90       JSR    write_text_8590
E833: 8E 03 12       LDX    #$0312
E836: CE EB 73       LDU    #$EB73
E839: 86 06          LDA    #$06
E83B: BD 85 90       JSR    write_text_8590
E83E: 8E 03 14       LDX    #$0314
E841: CE EB 6E       LDU    #$EB6E
E844: 86 05          LDA    #$05
E846: BD 85 90       JSR    write_text_8590
E849: 8E 03 16       LDX    #$0316
E84C: CE EB 8D       LDU    #$EB8D
E84F: 86 06          LDA    #$06
E851: BD 85 90       JSR    write_text_8590
E854: 8E 03 18       LDX    #$0318
E857: CE EB 93       LDU    #$EB93
E85A: 86 0C          LDA    #$0C
E85C: BD 85 90       JSR    write_text_8590
E85F: B6 10 00       LDA    sync_1000
E862: 27 FB          BEQ    $E85F
E864: B6 80 00       LDA    watchdog_8000
E867: 7F 50 03       CLR    video_stuff_5003
E86A: 7F 10 00       CLR    sync_1000
E86D: BD EA 17       JSR    io_stuff_ea17
E870: BD EB B9       JSR    $EBB9
E873: B6 10 1E       LDA    $101E
E876: 10 27 00 D7    LBEQ   $E951
E87A: B6 10 1A       LDA    $101A
E87D: 81 01          CMPA   #$01
E87F: 27 4B          BEQ    $E8CC
E881: BD EA 80       JSR    $EA80
E884: 8E 40 40       LDX    #$4040
E887: B6 10 17       LDA    $1017
E88A: 81 01          CMPA   #$01
E88C: 27 15          BEQ    $E8A3
E88E: B6 10 18       LDA    $1018
E891: 81 01          CMPA   #$01
E893: 27 07          BEQ    $E89C
E895: B6 10 19       LDA    $1019
E898: 81 01          CMPA   #$01
E89A: 26 14          BNE    $E8B0
E89C: F6 10 16       LDB    $1016
E89F: A7 85          STA    B,X
E8A1: 20 0D          BRA    $E8B0
E8A3: F6 10 16       LDB    $1016
E8A6: 6F 85          CLR    B,X
E8A8: 5C             INCB
E8A9: C4 1F          ANDB   #$1F
E8AB: A7 85          STA    B,X
E8AD: F7 10 16       STB    $1016
E8B0: B6 10 16       LDA    $1016
E8B3: 1F 89          TFR    A,B
E8B5: 84 F0          ANDA   #$F0
E8B7: 44             LSRA
E8B8: 44             LSRA
E8B9: 44             LSRA
E8BA: 44             LSRA
E8BB: B7 02 14       STA    $0214
E8BE: C4 0F          ANDB   #$0F
E8C0: C1 0A          CMPB   #$0A
E8C2: 25 02          BCS    $E8C6
E8C4: CB 37          ADDB   #$37
E8C6: F7 01 F4       STB    $01F4
E8C9: 7E E8 5F       JMP    $E85F
E8CC: BD EB 02       JSR    $EB02
E8CF: B6 10 00       LDA    sync_1000
E8D2: 27 FB          BEQ    $E8CF
E8D4: B6 80 00       LDA    watchdog_8000
E8D7: 7F 50 03       CLR    video_stuff_5003
E8DA: 7F 10 00       CLR    sync_1000
E8DD: BD EA 17       JSR    io_stuff_ea17
E8E0: BD EB B9       JSR    $EBB9
E8E3: B6 10 1E       LDA    $101E
E8E6: 27 69          BEQ    $E951
E8E8: B6 10 1A       LDA    $101A
E8EB: 81 01          CMPA   #$01
E8ED: 27 44          BEQ    $E933
E8EF: BD EA 80       JSR    $EA80
E8F2: B6 10 08       LDA    $1008
E8F5: 81 F8          CMPA   #$F8
E8F7: 24 12          BCC    $E90B
E8F9: 7C 10 08       INC    $1008
E8FC: 7C 10 08       INC    $1008
E8FF: 8E 07 FF       LDX    #$07FF
E902: 86 20          LDA    #$20
E904: C6 80          LDB    #$80
E906: BD 85 BD       JSR    $85BD
E909: 20 C4          BRA    $E8CF
E90B: BD EB 20       JSR    $EB20
E90E: 20 BF          BRA    $E8CF
E910: B6 10 00       LDA    sync_1000
E913: 27 FB          BEQ    $E910
E915: B6 80 00       LDA    watchdog_8000
E918: 7F 50 03       CLR    video_stuff_5003
E91B: 7F 10 00       CLR    sync_1000
E91E: BD EA 17       JSR    io_stuff_ea17
E921: BD EB B9       JSR    $EBB9
E924: B6 10 1E       LDA    $101E
E927: 27 28          BEQ    $E951
E929: B6 10 1A       LDA    $101A
E92C: 81 01          CMPA   #$01
E92E: 27 C2          BEQ    $E8F2
E930: BD EA 80       JSR    $EA80
E933: B6 10 6B       LDA    $106B
E936: 2B 27          BMI    $E95F
E938: B6 10 08       LDA    $1008
E93B: 10 27 FF 20    LBEQ   $E85F
E93F: 7A 10 08       DEC    $1008
E942: 7A 10 08       DEC    $1008
E945: 8E 07 FF       LDX    #$07FF
E948: 86 20          LDA    #$20
E94A: C6 80          LDB    #$80
E94C: BD 85 BD       JSR    $85BD
E94F: 20 BF          BRA    $E910
E951: 1C FF          ANDCC  #$FF
E953: 7F 50 02       CLR    video_stuff_5002
E956: 7F 50 0A       CLR    video_stuff_500A
E959: 7F 50 08       CLR    video_stuff_5008
E95C: 7E 80 72       JMP    init_8072

E95F: 7C 40 55       INC    $4055
E962: 8E 07 FF       LDX    #$07FF
E965: 86 20          LDA    #$20
E967: C6 80          LDB    #$80
E969: BD 85 BD       JSR    $85BD
E96C: 8E 00 00       LDX    #$0000
E96F: CC 4F 4F       LDD    #$4F4F
E972: ED 81          STD    ,X++
E974: 8C 03 80       CMPX   #$0380
E977: 26 F6          BNE    $E96F
E979: B6 10 00       LDA    sync_1000
E97C: 27 FB          BEQ    $E979
E97E: B6 80 00       LDA    watchdog_8000
E981: 7F 50 03       CLR    video_stuff_5003
E984: 7F 10 00       CLR    sync_1000
E987: BD EA 17       JSR    io_stuff_ea17
E98A: BD EB B9       JSR    $EBB9
E98D: B6 10 08       LDA    $1008
E990: 27 05          BEQ    $E997
E992: 7A 10 08       DEC    $1008
E995: 20 E2          BRA    $E979
E997: CC 01 08       LDD    #$0108
E99A: B7 40 4A       STA    $404A
E99D: F7 10 72       STB    $1072
E9A0: 8E EC 23       LDX    #$EC23
E9A3: A6 80          LDA    ,X+
E9A5: B7 10 73       STA    $1073
E9A8: BF 10 76       STX    $1076
E9AB: 8E 03 80       LDX    #$0380
E9AE: BF 10 74       STX    $1074
E9B1: B6 10 00       LDA    sync_1000
E9B4: 27 FB          BEQ    $E9B1
E9B6: B6 80 00       LDA    watchdog_8000
E9B9: 7F 50 03       CLR    video_stuff_5003
E9BC: 7F 10 00       CLR    sync_1000
E9BF: BD EA 17       JSR    io_stuff_ea17
E9C2: BD EB B9       JSR    $EBB9
E9C5: CC 01 20       LDD    #$0120
E9C8: B7 40 4A       STA    $404A
E9CB: FE 10 74       LDU    $1074
E9CE: B6 10 73       LDA    $1073
E9D1: 48             ASLA
E9D2: 25 02          BCS    $E9D6
E9D4: E7 5F          STB    -$1,U
E9D6: B7 10 73       STA    $1073
E9D9: 7A 10 72       DEC    $1072
E9DC: 26 10          BNE    $E9EE
E9DE: 86 08          LDA    #$08
E9E0: B7 10 72       STA    $1072
E9E3: BE 10 76       LDX    $1076
E9E6: A6 80          LDA    ,X+
E9E8: B7 10 73       STA    $1073
E9EB: BF 10 76       STX    $1076
E9EE: 33 5F          LEAU   -$1,U
E9F0: FF 10 74       STU    $1074
E9F3: 11 83 00 00    CMPU   #$0000
E9F7: 26 B8          BNE    $E9B1
E9F9: B6 10 00       LDA    sync_1000
E9FC: 27 FB          BEQ    $E9F9
E9FE: B6 80 00       LDA    watchdog_8000
EA01: 7F 50 03       CLR    video_stuff_5003
EA04: 7F 10 00       CLR    sync_1000
EA07: BD EA 17       JSR    io_stuff_ea17
EA0A: BD EB B9       JSR    $EBB9
EA0D: B6 40 4A       LDA    $404A
EA10: 26 E7          BNE    $E9F9
EA12: B6 80 00       LDA    watchdog_8000
EA15: 20 FB          BRA    $EA12

io_stuff_ea17:
EA17: 8E 48 00       LDX    #namco_io_4800
EA1A: F6 10 17       LDB    $1017
EA1D: 58             ASLB
EA1E: A6 05          LDA    $5,X
EA20: 84 0F          ANDA   #$0F
EA22: 26 06          BNE    $EA2A
EA24: A6 06          LDA    $6,X
EA26: 84 0F          ANDA   #$0F
EA28: 27 01          BEQ    $EA2B
EA2A: 5C             INCB
EA2B: C4 03          ANDB   #$03
EA2D: F7 10 17       STB    $1017
EA30: F6 10 18       LDB    $1018
EA33: 58             ASLB
EA34: A6 07          LDA    $7,X
EA36: 84 03          ANDA   #$03
EA38: 26 0E          BNE    $EA48
EA3A: A6 88 15       LDA    $15,X
EA3D: 84 02          ANDA   #$02
EA3F: 26 07          BNE    $EA48
EA41: A6 88 17       LDA    $17,X
EA44: 84 02          ANDA   #$02
EA46: 27 01          BEQ    $EA49
EA48: 5C             INCB
EA49: C4 03          ANDB   #$03
EA4B: F7 10 18       STB    $1018
EA4E: F6 10 19       LDB    $1019
EA51: 58             ASLB
EA52: A6 07          LDA    $7,X
EA54: 84 0C          ANDA   #$0C
EA56: 26 06          BNE    $EA5E
EA58: A6 04          LDA    $4,X
EA5A: 84 03          ANDA   #$03
EA5C: 27 01          BEQ    $EA5F
EA5E: 5C             INCB
EA5F: C4 03          ANDB   #$03
EA61: F7 10 19       STB    $1019
EA64: F6 10 1A       LDB    $101A
EA67: 58             ASLB
EA68: A6 04          LDA    $4,X
EA6A: 84 08          ANDA   #$08
EA6C: 27 01          BEQ    $EA6F
EA6E: 5C             INCB
EA6F: F7 10 1A       STB    $101A
EA72: A6 88 14       LDA    $14,X
EA75: 84 01          ANDA   #$01
EA77: AA 88 17       ORA    $17,X
EA7A: 84 09          ANDA   #$09
EA7C: B7 10 1E       STA    $101E
EA7F: 39             RTS

EA80: 8E 85 88       LDX    #$8588
EA83: CE EB 42       LDU    #$EB42
EA86: B6 48 14       LDA    $4814
EA89: 84 0C          ANDA   #$0C
EA8B: 44             LSRA
EA8C: B7 10 34       STA    $1034
EA8F: EC 86          LDD    A,X
EA91: B7 03 0D       STA    $030D
EA94: F7 02 0D       STB    $020D
EA97: B6 10 34       LDA    $1034
EA9A: EC C6          LDD    A,U
EA9C: B7 02 4D       STA    $024D
EA9F: F7 01 0D       STB    $010D
EAA2: B6 48 14       LDA    $4814
EAA5: 84 02          ANDA   #$02
EAA7: 8B 03          ADDA   #$03
EAA9: B7 02 12       STA    $0212
EAAC: B6 48 16       LDA    $4816
EAAF: 85 04          BITA   #$04
EAB1: 26 05          BNE    $EAB8
EAB3: CC 46 46       LDD    #$4646
EAB6: 20 03          BRA    $EABB
EAB8: CC 4E 20       LDD    #$4E20
EABB: B7 01 F0       STA    $01F0
EABE: F7 01 D0       STB    $01D0
EAC1: 8E EB 4A       LDX    #$EB4A
EAC4: B6 48 16       LDA    $4816
EAC7: 84 03          ANDA   #$03
EAC9: E6 86          LDB    A,X
EACB: F7 01 78       STB    $0178
EACE: B6 48 16       LDA    $4816
EAD1: 85 08          BITA   #$08
EAD3: 26 05          BNE    $EADA
EAD5: CC 46 46       LDD    #$4646
EAD8: 20 03          BRA    $EADD
EADA: CC 4E 20       LDD    #$4E20
EADD: B7 01 F6       STA    $01F6
EAE0: F7 01 D6       STB    $01D6
EAE3: B6 48 15       LDA    $4815
EAE6: 84 08          ANDA   #$08
EAE8: 26 0C          BNE    $EAF6
EAEA: 8E 03 0A       LDX    #$030A
EAED: CE EB 80       LDU    #$EB80
EAF0: 86 07          LDA    #$07
EAF2: BD 85 90       JSR    write_text_8590
EAF5: 39             RTS
EAF6: 8E 03 0A       LDX    #$030A
EAF9: CE EB 79       LDU    #$EB79
EAFC: 86 07          LDA    #$07
EAFE: BD 85 90       JSR    write_text_8590
EB01: 39             RTS
EB02: 8E 03 E0       LDX    #$03E0
EB05: CE F8 F9       LDU    #$F8F9
EB08: 10 8E FA FB    LDY    #$FAFB
EB0C: 86 10          LDA    #$10
EB0E: EF 81          STU    ,X++
EB10: 10 AF 88 1E    STY    $1E,X
EB14: 4A             DECA
EB15: 26 F7          BNE    $EB0E
EB17: 30 88 20       LEAX   $20,X
EB1A: 8C 07 60       CMPX   #$0760
EB1D: 25 ED          BCS    $EB0C
EB1F: 39             RTS
EB20: 8E 07 80       LDX    #$0780
EB23: CC F8 FA       LDD    #$F8FA
EB26: CE F9 FB       LDU    #$F9FB
EB29: ED 81          STD    ,X++
EB2B: ED 88 3E       STD    $3E,X
EB2E: EF 88 1E       STU    $1E,X
EB31: EF 88 5E       STU    $5E,X
EB34: 8C 07 A0       CMPX   #$07A0
EB37: 26 F0          BNE    $EB29
EB39: 39             RTS

EBB9: B6 10 08       LDA    $1008
EBBC: 81 F8          CMPA   #$F8
EBBE: 26 1C          BNE    $EBDC
EBC0: B6 10 16       LDA    $1016
EBC3: 81 1B          CMPA   #$1B
EBC5: 26 15          BNE    $EBDC
EBC7: B6 10 6B       LDA    $106B
EBCA: 2A 14          BPL    $EBE0
EBCC: B6 10 17       LDA    $1017
EBCF: 81 01          CMPA   #$01
EBD1: 27 09          BEQ    $EBDC
EBD3: B6 10 18       LDA    $1018
EBD6: BA 10 19       ORA    $1019
EBD9: 26 01          BNE    $EBDC
EBDB: 39             RTS
EBDC: 7F 10 6B       CLR    $106B
EBDF: 39             RTS
EBE0: B6 10 18       LDA    $1018
EBE3: BA 10 19       ORA    $1019
EBE6: BA 10 1A       ORA    $101A
EBE9: 26 F1          BNE    $EBDC
EBEB: B6 10 17       LDA    $1017
EBEE: 81 01          CMPA   #$01
EBF0: 27 01          BEQ    $EBF3
EBF2: 39             RTS
EBF3: B6 48 06       LDA    $4806
EBF6: 84 0F          ANDA   #$0F
EBF8: 26 E2          BNE    $EBDC
EBFA: B6 48 05       LDA    $4805
EBFD: 84 0F          ANDA   #$0F
EBFF: F6 10 6B       LDB    $106B
EC02: 8E EC 16       LDX    #$EC16
EC05: A1 85          CMPA   B,X
EC07: 26 D3          BNE    $EBDC
EC09: 7C 10 6B       INC    $106B
EC0C: 5C             INCB
EC0D: A6 85          LDA    B,X
EC0F: 2B 01          BMI    $EC12
EC11: 39             RTS
EC12: B7 10 6B       STA    $106B
EC15: 39             RTS

table_961d:
	dc.w	$9639	; $961d
	dc.w	$967f	; $961f
	dc.w	$968c	; $9621
	dc.w	$9911	; $9623
	dc.w	$96e3	; $9625
	dc.w	$9729	; $9627
	dc.w	$9741	; $9629
	dc.w	$976c	; $962b
	dc.w	$9781	; $962d
	dc.w	$9793	; $962f
	dc.w	$97dc	; $9631
	dc.w	$982c	; $9633
	dc.w	$9884	; $9635
	dc.w	$98e9	; $9637

table_a0f1:
	dc.w	$2098	; $a0f1 bogus
	dc.w	$a117	; $a0f3
	dc.w	$a1cb	; $a0f5
	dc.w	$a1d2	; $a0f7
table_a2e9:
	dc.w	$a2f7	; $a2e9
	dc.w	$a38a	; $a2eb
	dc.w	$a33b	; $a2ed
	dc.w	$a38a	; $a2ef
	dc.w	$a357	; $a2f1
	dc.w	$a38a	; $a2f3
	dc.w	$a4c1	; $a2f5
	dc.w	$a688	; $a2f7
table_ac66:
	dc.w	$ab85	; $ac66
	dc.w	$ad49	; $ac68
	dc.w	$b5ed	; $ac6a
	dc.w	$adec	; $ac6c
	dc.w	$aed3	; $ac6e
	dc.w	$c0bb	; $ac70
	dc.w	$b23f	; $ac72
	dc.w	$b27a	; $ac74
	dc.w	$b333	; $ac76
	dc.w	$b358	; $ac78
	dc.w	$b381	; $ac7a
	dc.w	$b0ac	; $ac7c
	dc.w	$af45	; $ac7e
	dc.w	$af9b	; $ac80
	dc.w	$c0bb	; $ac82
	dc.w	$afa4	; $ac84
	dc.w	$b015	; $ac86
	dc.w	$b069	; $ac88
	dc.w	$ad3c	; $ac8a
	dc.w	$b062	; $ac8c
	dc.w	$af0b	; $ac8e
	dc.w	$8e15	; $ac90


        
