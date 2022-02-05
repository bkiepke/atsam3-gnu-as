    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

    @ TODO make macros globally available

    @ Macro to set a value of register (32-bit)
    .global SetValue
    .macro SetValue, Register, Value
    ldr         r0, =\Register                                                  @ Prepare access of register
    ldr         r1, =\Value                                                     @ Prepare value to write
    str         r1, [r0]                                                        @ Write value to register
    .endm

    @ Macro to verify a flag is set
    .global VerifyFlagSet
    .macro VerifyFlagSet, Register, Flag
    ldr         r0, =\Register                                                  @ Prepare access of register
    ldr         r1, [r0]                                                        @ Read value of register
    tst         r1, #\Flag                                                      @ Verify flag is set
    beq         . - 8                                                           @ Wait while flag is cleared
    .endm

    .end
