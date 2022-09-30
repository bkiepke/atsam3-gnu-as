@ Be aware that this file should not have an .end directive as it is used by .include directive

@ Macro to update variable in RAM
    .global UpdateVariable
    .macro  UpdateVariable, variable:req, value:req
    push    { r0-r1 }
    ldr r0, =\variable
    ldr r1, =\value
    str r1, [r0]
    pop     { r0-r1 }
    .endm

@ Macro to call subroutine, may include up to three parameters
@ SubRoutine is the label of the routine - required
@ r0 : Param1 - optional
@ r1 : Param2 - optional
@ r2 : Param3 - optional
    .global CallSub
    .macro CallSub, SubRoutine:req, Param1, Param2, Param3:vararg
    .global \SubRoutine
    .ifb    \Param1                                                             @ No parameter given
    bl      \SubRoutine
    .else
    .ifb    \Param2                                                             @ One parameter given
    push    { r0 }
    ldr     r0, =\Param1
    bl      \SubRoutine
    pop     { r0 }
    .else
    .ifb    \Param3                                                             @ Two parameters given
    push    { r0-r1 }
    ldr     r0, =\Param1
    ldr     r1, =\Param2
    bl      \SubRoutine
    pop     { r0-r1 }
    .else                                                                       @ Three parameters given
    push    { r0-r2 }
    ldr     r0, =\Param1
    ldr     r1, =\Param2
    ldr     r2, =\Param3
    bl      \SubRoutine
    pop     { r0-r2 }
    .endif
    .endif
    .endif
    .endm

@
@ Standard operations on registers
@
    @
    @ Macro to set a value of write-only register (32-bit)
    @ r0 : Address of register
    @ r1 : Value to store in register
    @
    .global RegisterSetValueWO
    .macro RegisterSetValueWO, Register:req, Value:req
    push        { r0-r1 }
    ldr         r0, =\Register                                                  @ Prepare access to register
    ldr         r1, =\Value                                                     @ Prepare value to write
    str         r1, [r0]                                                        @ Write value to register
    pop         { r0-r1 }
    .endm

    @
    @ Macro to set a value of read-write register (32-bit)
    @ r0 : Address of register
    @ r1 : Content of register
    @ r2 : Bitmask to set in register
    @
    .global RegisterSetValueRW
    .macro RegisterSetValueRW, Register:req, Mask:req
    push        { r0-r2 }
    ldr         r0, =\Register                                                  @ Prepare access to register
    ldr         r1, [r0]                                                        @ Get current value of register
    ldr         r2, =\Mask                                                      @ Get bit-mask
    orr         r1, r2                                                          @ Set bits 
    str         r1, [r0]                                                        @ Set new value of register
    pop         { r0-r2 }
    .endm

    @
    @ Macro to clear a value of read-write register (32-bit)
    @ r0 : Address of register
    @ r1 : Content of register
    @ r2 : Bitmask to clear in register
    @
    .global RegisterClearValueRW
    .macro RegisterClearValueRW, Register:req, Mask:req
    push        { r0-r2 }
    ldr         r0, =\Register                                                  @ Prepare access to register
    ldr         r1, [r0]                                                        @ Get current value of register
    ldr         r2, =(~\Mask)                                                   @ Get bit-mask
    and         r1, r2                                                          @ Clear bits
    str         r1, [r0]                                                        @ Set new value of register
    pop         { r0-r2 }
    .endm
    
    @
    @ Macro to verify a flag is set
    @ r0 : Address of register, local
    @ r1 : Content of register, local
    @ r2 : Content to compare with, local
    @
    .global RegisterVerifyFlagIsSet
    .macro RegisterVerifyFlagIsSet, Register:req, Flag:req
    push        { r0-r2 }
    ldr         r0, =\Register                                                  @ Prepare access of register
    ldr         r1, [r0]                                                        @ Read value of register
    ldr         r2, =\Flag
    tst         r1, r2                                                          @ Verify flag is set
    beq         . - 8                                                           @ Wait while flag is cleared
    pop         { r0-r2 }
    .endm

    @
    @ Macro to verify a flag is cleared
    @ r0 : Address of register, local
    @ r1 : Content of register, local
    @ r2 : Content to compare with, local
    @
    .global RegisterVerifyFlagIsCleared
    .macro RegisterVerifyFlagIsCleared, Register:req, Flag:req
    push        { r0-r2 }
    ldr         r0, =\Register                                                  @ Prepare access of register
    ldr         r1, [r0]                                                        @ Read value of register
@    ldr         r2, #\Flag
    tst         r1, #\Flag                                                          @ Verify flag is cleared
    beq         . - 8                                                           @ Wait while flag is set
    pop         { r0-r2 }
    .endm

    @
    @ Macro to get a value of a register (32-bit)
    @ r0 : Address of register
    @ r4 : Value to read from register
    @
    .global RegisterGetValue
    .macro RegisterGetValue, Register:req
    push        { r0 }
    ldr         r0, =\Register                                                  @ Prepare access to register
    ldr         r4, [r0]                                                        @ Read value from register
    pop         { r0 }
    .endm
