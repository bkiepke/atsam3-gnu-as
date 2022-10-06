    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/macros.inc"
    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/peripheral.inc"
    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/interrupts.inc"

    .section .text, "ax"

 


    @ Register NVIC_ISERx, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
    @ SETENA
    @
    @ SETENA : 0 = write, No effect.
    @        : 1 = write, enable interrupt.
    @        : 0 = read, interrupt disabled.
    @        : 1 = read, interrupt enabled.

    @ Register NVIC_ICERx, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
    @ CLRENA
    @
    @ CLRENA : 0 = write, No effect.
    @        : 1 = write, disable interrupt.
    @        : 0 = read, interrupt disabled.
    @        : 1 = read, interrupt enabled.

    @ Register NVIC_ISPRx, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
    @ SETPEND
    @
    @ SETPEND : 0 = write, No effect.
    @         : 1 = write, changes interrupt state to pending.
    @         : 0 = read, interrupt is not pending.
    @         : 1 = read, interrupt is pending.

    @ Register NVIC_ICPRx, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
    @ CLRPEND
    @
    @ CLRPEND : 0 = write, No effect.
    @         : 1 = write, removes pending state of an interrupt.
    @         : 0 = read, interrupt is not pending.
    @         : 1 = read, interrupt is pending.

    @ Register NVIC_IABRx, read-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
    @ ACTIVE
    @
    @ ACTIVE : 0 = interrupt not active.
    @        : 1 = interrupt active.

    @ Register NVIC_IPRx, read-write
    @ 31 30 29 28 27 26 25 24 | 23 22 21 20 19 18 17 16 | 15 14 13 12 11 10 09 08 | 07 06 05 04 03 02 01 00
    @ IP[m + 3]      0  0  0  | IP[m + 2]      0  0  0  | IP[m + 1]      0  0  0  | IP[m + 0]      0  0  0
    @
    @ IP[n] : 0..15 = priority level of interrupt, 0 = highest, 15 = lowest.
    @

@
@ Setup interrupt
@
    @
    @ Subroutine to enable interrupt
    @ r0 : Mask of interrupt
    @ r1 : Priority of interrupt  
    @ r2 : Address of interrupt set register
    @ r3 : Address of interrupt clear register
    @ r4 : Address of interrupt clear pending register
    @ r5 : Address of interrupt priority register
    @ r6 : Address of peripheral interrupt enable callback
    @
    @ Sequence to enable interrupt
    @ 1. Disable interrupt of NVIC in case it was enabled
    @ 2. Clear pending interrupts of NVIC
    @ 3. Set priority
    @ 4. Enable interrupt of subsystem
    @ 5. Enable corresponding interrupt of NVIC
    @
NVIC_InterruptEnable:
    .global     NVIC_InterruptEnable
    .type       NVIC_InterruptEnable, %function
    push        { lr }
    str         r1, [r3]                                                        @ Disable interrupt of NVIC in case it was enabled
    str         r1, [r4]                                                        @ Clear pending interrupt of NVIC
    str         r2, [r5]                                                        @ Set priority of interrupt
    blx         r6                                                              @ Enable interrupts of subsystem
    str         r1, [r2]                                                        @ Enable interrupt of subsystem of NVIC
    pop         { pc }

    .align
    .end
