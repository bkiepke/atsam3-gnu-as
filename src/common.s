    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

    @
    @ Function to write a value to a write-only register
    @ r0 : Address of register
    @ r1 : Value to store in register
    @
RegisterSetValueWO:
    .global     RegisterSetValueWO
    .type       RegisterSetValueWO, %function
    push        { lr }
    str         r1, [r0]
    pop         { pc }

    @
    @ Function to set a value in a read-write register
    @ r0 : Address of register
    @ r1 : Value to set in register
    @
RegisterSetValueRW:
    .global     RegisterSetValueRW
    .type       RegisterSetValueRW, %function
    push        { lr }
    push        { r2 }
    ldr         r2, [r0]                                                        @ Get current value of register
    orr         r2, r1                                                          @ Set value
    str         r2, [r0]                                                        @ Set new value of register
    pop         { r2 }
    pop         { pc }

    @
    @ Function to clear a value in a read-write register
    @ r0 : Address of register
    @ r1 : Value to clear in register
    @
RegisterClearValueRW:
    .global     RegisterClearValueRW
    .type       RegisterClearValueRW, %function
    push        { lr }
    push        { r2 }
    ldr         r2, [r0]                                                        @ Get current value of register
    and         r2, r1                                                          @ Clear value
    str         r2, [r0]                                                        @ Set new value of register
    pop         { r2 }
    pop         { pc }

    .end
