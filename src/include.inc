* Converted with 6809to68k v1.1 by JOTD
*
* make sure you call "cpu_init" first so all bits of data registers
* are zeroed out so we can use add.l dy,ax with dy > 0x7FFF
* without systematic masking
*
* WARNING: you also have to call "cpu_init"
* at start of any interrupt you could hook
*
* the GET_ADDRESS macro can just call get_address or it can also use
* conditional compilation to select the proper memory banks at compile time
* (see my burger time 6502 conversion which does that in RELEASE mode)



	.global	m6809_direct_page_pointer

	.macro	ERROR	arg
	.error	"\arg"     | comment out to disable errors
	.endm

	.include	"options.inc"
	
NATIVE_STACK_SIZE = 0x3000

* if change here change also in "ram.68k"
TASK_STACK_BITSHIFT = 8
TASK_STACK_SIZE = (1<<TASK_STACK_BITSHIFT)


	
	.macro	CHECK_MAX	reg,arg
	.ifndef	RELEASE
	cmp.b	#\arg*2,\reg
	jcs		okay\@
	BREAKPOINT	"\reg exceeds \arg*2"
okay\@:
	.endif
	.endm
	.macro	VIDEO_BYTE_DIRTY
	jbsr	osd_video_byte_dirty
	.endm

	.macro	VIDEO_WORD_DIRTY
	jbsr	osd_video_word_dirty
	.endm

	.ifdef	RELEASE
	.macro	GET_ADDRESS_FUNC
	lea		(a6,a0.l),a0
	.endm
	.macro	GET_UNCHECKED_ADDRESS_FUNC
	GET_ADDRESS_FUNC
	.endm
	
	.else
	
	.macro	GET_ADDRESS_FUNC
	jbsr	get_address
	.endm

	.macro	GET_UNCHECKED_ADDRESS_FUNC
	lea		(a6,a0.l),a0
	.endm
	.endif

	.macro	ABX
	moveq	#0,d6
	move.b	d1,d6
	add.w	d6,d2
	.endm

	.macro	COM	reg
	not.b	\reg
	SET_XC_FLAGS
	.endm

	.macro	SEX
	move.b	d1,d0
	ext.w	d0
	.endm

	.macro	MAKE_D
* add value of A in B MSB so D&0xFF == B
	rol.w	#8,d1
	move.b	d0,d1
	rol.w	#8,d1
	.endm

	.macro	MAKE_A
	rol.w	#8,d1
	move.b	d1,d0
	rol.w	#8,d1
	.endm

	.macro	BIT	reg,arg
	move.b	\reg,d6
	and.b	\arg,d6
	.endm


	.macro	LOAD_D
	move.b	(a0),d0
	move.b	(1,a0),d1
	MAKE_D
	.endm

	.macro CLR_XC_FLAGS
	and.b	#0xEE,ccr	| bit 4 = X, bit 0 = C
	.endm

	.macro SET_XC_FLAGS
	or.b	#0x11,ccr	| bit 4 = X, bit 0 = C
	.endm



	.macro INVERT_XC_FLAGS
	eor.b	#0x11,ccr
	.endm

* useful to recall C from X (add then move then bcx)
	.macro	SET_C_FROM_X
	PUSH_SR
	move.w	(sp),d6
	bset	#0,d6   | set C
	btst	#4,d6
	jne	0f
	bclr	#0,d6   | X is clear: clear C
0:
	move.w	d6,(sp)
	POP_SR
	.endm

* useful to store X from C (store cmp result)
	.macro	SET_X_FROM_C
	PUSH_SR
	move.w	(sp),d6
	bset	#4,d6   | set X
	btst	#0,d6
	bne.b	0f
	bclr	#4,d6   | C is clear: clear X
0:
	move.w	d6,(sp)
	POP_SR
	.endm

	.macro	SET_X_FROM_CLEARED_C
	PUSH_SR
	move.w	(sp),d6
	bset	#4,d6   | set X
	btst	#0,d6
	jeq	0f
	bclr	#4,d6   | C is set: clear X
0:
	move.w	d6,(sp)
	POP_SR
	.endm


	.macro SET_I_FLAG
	jbsr	osd_disable_interrupts
	.endm
	.macro CLR_I_FLAG
	jbsr	osd_enable_interrupts
	.endm

	.ifdef	MC68020


* 68020 compliant & optimized

    .macro    JXX_X_INDEXED    inst,reg,dreg,nb_cases
    and.w    #0xFF,\dreg  | mask 8 bits
	CHECK_MAX	\dreg,\nb_cases
    \inst    ([\reg,\dreg\().w*2])
    .endm


	.macro DO_EXTB	reg
	extb.l	\reg
	.endm

	.macro PUSH_SR
	move.w	ccr,-(sp)
	.endm


	.macro	MOVE_W_TO_REG	src,dest
	move.w	(\src),\dest
	.endm

	.macro    CMP_W_TO_REG    src,dest
	cmp.w    (\src),\dest
	.endm

    .macro    ADD_W_TO_REG    src,dest
    add.w    (\src),\dest
    .endm

    .macro    SUB_W_TO_REG    src,dest
    sub.w    (\src),\dest
    .endm


	.macro	MOVE_W_FROM_REG    src,dest
	move.w	\src,(\dest)
	.endm



	.macro READ_BE_WORD	srcreg
	moveq	#0,d6
	move.w	(\srcreg),d6
	move.l	d6,\srcreg
	.endm

	.else

* 68000 compliant

 
    .macro    JXX_X_INDEXED    inst,reg,dreg,nb_cases
    and.w    #0xFF,\dreg  | mask 8 bits
	CHECK_MAX	\dreg,\nb_cases
    add.w    \dreg,\dreg    | *2 (16 -> 32 bits)
    move.l    (\reg,\dreg\().w),A3
    \inst    (A3)    | we use another register, as table is not reloaded!
    .endm


	.macro DO_EXTB	reg
	ext	\reg
	ext.l	\reg
	.endm

	.macro PUSH_SR
	move.w	sr,-(sp)
	.endm

	.macro	MOVE_W_TO_REG    src,dest
	ror.w	#8,\dest
	move.b	(\src),\dest
	ror.w	#8,\dest
	move.b	(1,\src),\dest
	.endm

	.macro	MOVE_W_FROM_REG    src,dest
	ror.w	#8,\src
	move.b	\src,(\dest)
	ror.w	#8,\src
	move.b	\src,(1,\dest)
	.endm

    .macro    INST_W_TO_REG    inst,src,dest
    move.b    (\src),d6
    ror.w    #8,d6
    move.b    (1,\src),d6
    \inst\().w    d6,\dest
    .endm

    .macro    SUB_W_TO_REG    src,dest
    INST_W_TO_REG   sub,\src,\dest
    .endm

    .macro    ADD_W_TO_REG    src,dest
    INST_W_TO_REG   add,\src,\dest
    .endm

    .macro    CMP_W_TO_REG    src,dest
    INST_W_TO_REG   cmp,\src,\dest
    .endm


	.macro READ_BE_WORD	srcreg
	moveq	#0,d6
	move.b	(\srcreg),d6
	lsl.w	#8,d6
	move.b	(1,\srcreg),d6
	move.l	d6,\srcreg
	.endm

	.endif

	* compatible with all 68xxx cpus
 	.macro POP_SR
	move.w	(sp)+,ccr
	.endm

    .macro    JXX_A_INDEXED    inst,reg,nb_cases
	JXX_X_INDEXED	\inst,\reg,d0,\nb_cases
    .endm
    .macro    JXX_B_INDEXED    inst,reg,nb_cases
	JXX_X_INDEXED	\inst,\reg,d1,\nb_cases
    .endm

    .macro    JSR_A_INDEXED    reg,nb_cases
    JXX_A_INDEXED	jsr,\reg,\nb_cases
    .endm
    .macro    JMP_A_INDEXED    reg,nb_cases
    JXX_A_INDEXED	jmp,\reg,\nb_cases
    .endm
    .macro    JSR_B_INDEXED    reg,nb_cases
    JXX_B_INDEXED	jsr,\reg,\nb_cases
    .endm
    .macro    JMP_B_INDEXED    reg,nb_cases
    JXX_B_INDEXED	jmp,\reg,\nb_cases
    .endm


* registers must be masked out to proper size before use
	.macro	GET_INDIRECT_ADDRESS_REGS	reg1,reg2,destreg
	move.l	\reg1,a0
	lea	(a0,\reg2\().l),a0
	GET_ADDRESS_FUNC
	MOVE_W_TO_REG	a0,\destreg
	.endm


	.macro GET_DP_ADDRESS	offset
	lea	(a5,\offset\().W),a0
	.endm

* optimized DP operations
	.macro OP_1_ON_DP_ADDRESS    inst,offset
	\inst\().b    (a5,\offset\().W)
	.endm

	.macro OP_R_ON_DP_ADDRESS    inst,offset,reg
	\inst\().b	(a5,\offset\().W),\reg
	.endm

	.macro OP_W_ON_DP_ADDRESS    inst,offset,reg
	\inst\().b    \reg,(a5,\offset\().W)
	.endm


	.macro SET_DP_FROM_A
	lsl.w    #8,d0
	move.w    d0,a0    | DP < 0x80 so it's ok
	GET_UNCHECKED_ADDRESS_FUNC
	move.l	a0,a5
	move.l	a5,m6809_direct_page_pointer
	lsr.w    #8,d0
	.endm



	.macro SET_DP_FROM    reg
	exg	d0,\reg
	SET_DP_FROM_A

	exg	d0,\reg
	.endm

	.macro GET_REG_ADDRESS	offset,reg
	.ifeq	\offset
	move.l	\reg,a0
	.else
	lea	\offset,a0
	lea	(a0,\reg\().l),a0
	.endif
	GET_ADDRESS_FUNC
	.endm


	.macro GET_REG_INDIRECT_ADDRESS	offset,reg
	GET_REG_ADDRESS	\offset,\reg
	READ_BE_WORD	a0
	GET_ADDRESS_FUNC
	.endm

	.macro    GET_REG_REG_INDIRECT_ADDRESS reg1,reg2
	GET_INDIRECT_ADDRESS_REGS	\reg1,\reg2,d6
	and.l	#0xFFFF,d6
	move.l	d6,a0
	GET_ADDRESS_FUNC
	.endm

	.macro GET_REG_ADDRESS_FROM_REG	reg,reg2
	move.l	\reg,a0
	lea	(a0,\reg2\().l),a0
	GET_ADDRESS_FUNC
	.endm

	.macro GET_ADDRESS	offset
	lea	\offset,a0
	GET_ADDRESS_FUNC
	.endm

	.macro GET_INDIRECT_ADDRESS	offset
	GET_ADDRESS	\offset
	READ_BE_WORD	a0
	GET_ADDRESS_FUNC
	.endm
	.macro GET_REG_UNCHECKED_ADDRESS	offset,reg
	.ifeq	\offset
	move.l	\reg,a0
	.else
	lea	\offset,a0
	lea	(a0,\reg\().l),a0
	.endif
	GET_UNCHECKED_ADDRESS_FUNC
	.endm


	.macro GET_REG_INDIRECT_UNCHECKED_ADDRESS	offset,reg
	GET_REG_ADDRESS	\offset,\reg
	READ_BE_WORD	a0
	GET_UNCHECKED_ADDRESS_FUNC
	.endm

	.macro    GET_REG_REG_UNCHECKED_INDIRECT_ADDRESS reg1,reg2
	GET_INDIRECT_ADDRESS_REGS	\reg1,\reg2,d6
	and.l	#0xFFFF,d6
	move.l	d6,a0
	GET_UNCHECKED_ADDRESS_FUNC
	.endm

	.macro GET_REG_UNCHECKED_ADDRESS_FROM_REG	reg,reg2
	move.l	\reg,a0
	lea	(a0,\reg2\().l),a0
	GET_UNCHECKED_ADDRESS_FUNC
	.endm

	.macro GET_UNCHECKED_ADDRESS	offset
	lea	\offset,a0
	GET_UNCHECKED_ADDRESS_FUNC
	.endm

	.macro GET_INDIRECT_UNCHECKED_ADDRESS	offset
	GET_ADDRESS	\offset
	READ_BE_WORD	a0
	GET_UNCHECKED_ADDRESS_FUNC
	.endm

	.ifndef	RELEASE
* dev mode, more checks about the address
get_address:

0:
	cmp.w	#0x1000,a0
	jcc		0f
	.ifne	OPT_ENABLE_LOGGING
	jbsr	osd_get_last_known_pc
	.endif
	BREAKPOINT	"video address range 0x0000-0x0FFF, PC in D6"
	jra		10f
0:
	
	* 0X2000 <= range < 0x4400, ram, shared ram & special ram/scroll
	cmp.w	#0x4400,a0
	jcs		10f
	cmp.w	#0x4800,a0
	jcs		9f
	cmp.w	#0x4820,a0
	jcs		10f
	
	cmp.l	#0x8000,a0
	jcc		10f				| ROM: OK
	.ifne	OPT_ENABLE_LOGGING
	jbsr	osd_get_last_known_pc
	.endif
9:
	BREAKPOINT	"illegal range 0x4400-0x8000, PC in D6"
10:
	GET_UNCHECKED_ADDRESS_FUNC
	rts

	.endif



multiply_ab:
	and.w	#0xFF,d0
	and.w	#0xFF,d1
	mulu	d0,d1
	ror.w	#8,d1
	move.b	d1,d0
	ror.w	#8,d1
	rts
	.ifndef	RELEASE
	* to trace at some virtual PCs, insert this macro
	.macro	LOG_REGS	the_pc
	move.w	sr,-(a7)
	move.w	#0x\the_pc,-(a7)
	move.w	#0,-(a7)
	jbsr	osd_log_cpu
	addq.w	#4,a7
	move.w	(a7)+,sr
	.endm
	.macro	LOG_REGS_QUICK	the_pc
	move.w	sr,-(a7)

	move.w	#0x\the_pc,0x100

	move.w	(a7)+,sr
	.endm
	
	.macro	ENABLE_LOG_REGS
	moveq	#1,d6		| enable
	jbsr	osd_cpu_logging_control	
	.endm
	.macro	DISABLE_REGS_LOG
	moveq	#0,d6		| disable
	jbsr	osd_cpu_logging_control	
	.endm	
	.endif


	