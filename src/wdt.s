    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/macros.inc"
@    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/peripheral.inc"

    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

    .section .text, "ax"

    @ Register addresses of WDT
    .equ        WDT_BASE, 0x400E1450                                            @ Base register address
    .equ        WDT_WDT_CR, (WDT_BASE + 0x0000)                                 @ Address to register Control Register
    .equ        WDT_WDT_MR, (WDT_BASE + 0x0004)                                 @ Address to register Mode Register
    .equ        WDT_WDT_SR, (WDT_BASE + 0x0008)                                 @ Address to register Status Register 

    @ Register WDT_CR, write-only
    @ 31 30 29 28 27 26 25 24 | 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 | 00
    @ KEY                     | -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | WDRSTT
    @
    @ WDRSTT : 0 = No effect.
    @        : 1 = Restarts the watchdog.
    @ KEY : Should be written at value 0xA5. Writing any other value in this field aborts the write operation.
    .equ        WDT_WDT_CR_WDRSTT_KEY, 0xA5000001

WDT_WDT_CR_Restart:
    .global     WDT_WDT_CR_Restart
    .type       WDT_WDT_CR_Restart, %function
    push        { r0-r1, lr }
    RegisterSetValueWO  WDT_WDT_CR, WDT_WDT_CR_WDRSTT_KEY
    pop         { r0-r1, pc }

    @ Register WDT_MR, read-write once
    @ 31 30 | 29        | 28       | 27 26 25 24 23 22 21 20 19 18 17 16 | 15    | 14      | 13      | 12     | 11 10 09 08 07 06 05 04 03 02 01 00
    @ -  -  | WDIDLEHLT | WDDGBHLT | WDD                                 | WDDIS | WDRPROC | WDRSTEN | WDFIEN | WDV
    @
    @ WDV : Defines the value loaded in the 12-bit Watchdog Counter.
    @ WDFIEN : 0 = A Watchdog fault (underflow or error) has no effect on interrupt.
    @        : 1 = A Watchdog fault (underflow or error) asserts interrupt.
    @ WDRSTEN : 0 = A Watchdog fault (underflow or error) has no effect on the resets.
    @         : 1 = A Watchdog fault (underflow or error) triggers a Watchdog reset.
    @ WDRPROC : 0 = If WDRSTEN is 1, a Watchdog fault (underflow or error) activates all resets.
    @         : 1 = If WDRSTEN is 1, a Watchdog fault (underflow or error) activates the processor reset.
    @ WDDIS : 0 = Enables the Watchdog Timer.
    @       : 1 = Disables the Watchdog Timer.
    @ WDD : Defines the permitted range for reloading the Watchdog Timer.
    @       If the Watchdog Timer value is less than or equal to WDD, writing WDT_CR with WDRSTT = 1 restarts the timer.
    @       If the Watchdog Timer value is greater than WDD, using WDT_CR with WDRSTT = 1 causes a Watchdog error.
    @ WDDBGHLT : 0 = The Watchdog runs when the processor is in debug state.
    @          : 1 = The Watchdog stops when the processor is in debug state.
    @ WDIDLEHLT : 0 = The Watchdog runs when the system is in idle mode.
    @           : 1 = The Watchdog stops when the system is in idle mode.
    @
    .equ        WDT_WDT_MR_WDV, 0
    .equ        WDT_WDT_MR_WDFIEN, 12
    .equ        WDT_WDT_MR_WDRSTEN, 13
    .equ        WDT_WDT_MR_WDRPROC, 14
    .equ        WDT_WDT_MR_WDDIS, 15
    .equ        WDT_WDT_MR_WDD, 16
    .equ        WDT_WDT_MR_WDDBGHLT, 28
    .equ        WDT_WDT_MR_WDIDLEHLT, 29

WDT_WDT_MR_Disable:
    .global     WDT_WDT_MR_Disable
    .type       WDT_WDT_MR_Disable, %function
    push        { r0-r1, lr }
    RegisterSetValueWO  WDT_WDT_MR, (1 << WDT_WDT_MR_WDDIS)
    pop         { r0-r1, pc }

    @ Register WDT_SR, read-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 | 01    | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | WDERR | WDUNF
    @
    @ WDUNF : 0 = No Watchdog underflow occurred since the last read of WDT_SR.
    @       : 1 = At least one Watchdog underlow occurred since the last read of WDT_SR.
    @ WDERR : 0 = No Watchdog error occurred since the last read of WDT_SR.
    @       : 1 = At least one Watchdog error occurred since the last read of WDT_SR.
    @
    .equ        WDT_WDT_SR_WDUNF, 0
    .equ        WDT_WDT_SR_WDERR, 1

    .end