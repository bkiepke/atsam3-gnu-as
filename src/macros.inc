    @ Macros for easy call of common subroutines,
    @ Be aware that this file should not have an .end directive as it uses .include directive

    @ Macro to set a value of write-only register (32-bit)
    @ r0 : Address of register
    @ r1 : Value to store in register
    .global SetValueWO
    .macro SetValueWO, Register, Value
    ldr         r0, =\Register                                                  @ Prepare access to register
    ldr         r1, =\Value                                                     @ Prepare value to write
    .global     RegisterSetValueWO
    bl          RegisterSetValueWO
    .endm

    @ Macro to set a value of read-write register (32-bit)
    .global SetValueRW
    .macro SetValueRW, Register, Value
    ldr         r0, =\Register                                                  @ Prepare access to register
    ldr         r1, =\Value                                                     @ Set value
    .global     RegisterSetValueRW
    bl          RegisterSetValueRW
    .endm

    @ Macro to clear a value of read-write register (32-bit)
    .global ClearValueRW
    .macro ClearValueRW, Register, Value
    ldr         r0, =\Register                                                  @ Prepare access to register
    ldr         r1, =(~\Value)                                                  @ Set value
    .global     RegisterClearValueRW
    bl          RegisterClearValueRW
    .endm
    
    @ Macro to verify a flag is set
    .global VerifyFlagSet
    .macro VerifyFlagSet, Register, Flag
    ldr         r0, =\Register                                                  @ Prepare access of register
    ldr         r1, [r0]                                                        @ Read value of register
    tst         r1, #\Flag                                                      @ Verify flag is set
    beq         . - 8                                                           @ Wait while flag is cleared
    .endm
