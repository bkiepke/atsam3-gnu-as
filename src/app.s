@ import macros and definitions    
    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/macros.inc"
    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/peripheral.inc"
    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/interrupts.inc"

    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

    .section .text, "ax"

@ Initialize system
SystemInit:
    .global     SystemInit
    .type       SystemInit, %function    
    push        { lr }                                                          @ Store return address

    @ Disable Watchdog
    CallSub     WDT_WDT_MR_Disable                                              @ Disable watchdog during development

    @ Read chip ID
    CallSub      CHIPID_CIDR_Get                                                @ Get chip identification

    @ Setup flash memory controller -> wait states

    @ Setup reset controller -> enable user reset trigger

    @ Setup supply controller -> SLCK source

    @ Setup MAIN clock
    CallSub     PMC_CKGR_MOR_MainCrystalEnable

    @ Setup PLL clocks
    CallSub    PMC_CKGR_PLLAR_Enable
@    CallSub    PMC_CKGR_PLLBR_Enable

    @ Setup master clock
    CallSub     PMC_PMC_MCKR_Enable

    @ Setup PCK output
    CallSub     PMC_PMC_SCER_PCK0_Enable
    CallSub     PIOA_SwitchToPCK0
    CallSub     PMC_PMC_PCK0_OutputClock

    @ Setup USB clock
@    CallSub     PMC_PMC_USB_PLLA_Enable                                            @@@ gives error
@    CallSub     PMC_PMC_SCER_UDP_Enable                                            @@@ gives error
@    CallSub     PMC_PMC_SCDR_UDP_Disable                                           @@@ gives error
@    CallSub     PMC_PMC_USB_ClockEnable

    CallSub     PMC_PMC_WPMR_WriteProtectEnable                                 @ Enable write protect PMC

    @ Setup DACC
    CallSub     PMC_PMC_PCER0_Enable_DACC                                       @ Enable clock for subsystem
    CallSub     DACC_DACC_CR_Reset                                              @ Configure subsystem
    CallSub     DACC_DACC_MR_Setup
    CallSub     DACC_DACC_CHER_Enable
    CallSub     DACC_DACC_WPMR_WriteProtectEnable                               @ Enable write protect DACC

    @ Enable interrupts
    NVIC_SetupInterrupts
    pop         { pc }                                                          @ Restore return address and return to caller

@ Start main application
main:
    .global     main
    .type       main, %function    

main_init:

main_loop:

@    UpdateVariable  DACC_CH0_DATA, 0x0FFF
@    UpdateVariable  DACC_CH1_DATA, 0x0000
@    CallSub     DACC_DACC_CDR_Convert
@    CallSub     DelayBlocking, 1000

@    UpdateVariable  DACC_CH0_DATA, 0x0000
@    UpdateVariable  DACC_CH1_DATA, 0x0FFF
@    CallSub     DACC_DACC_CDR_Convert
@    CallSub     DelayBlocking, 1000
    b           main_loop                                                       @ Final state

    .align
    .end
