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
    @ Read chip ID
    .global     CHIPID_CIDR_Get
    bl          CHIPID_CIDR_Get                                                 @ Get chip identification

    @ Setup main clock
    .global     PMC_CKGR_MOR_MainCrystalEnable
    bl          PMC_CKGR_MOR_MainCrystalEnable

    @ Setup PLL clocks
    .global     PMC_CKGR_PLLAR_Enable
    bl          PMC_CKGR_PLLAR_Enable
    @.global     PMC_CKGR_PLLBR_Enable
    @bl          PMC_CKGR_PLLBR_Enable

    @ Setup PCK output
    .global     PMC_PMC_SCER_PCK0_Enable
    bl          PMC_PMC_SCER_PCK0_Enable
    .global     PIOA_SwitchToPCK0
    bl          PIOA_SwitchToPCK0
    .global     PMC_PMC_PCK0_OutputClock
    bl          PMC_PMC_PCK0_OutputClock

    @ Setup USB clock
    @.global     PMC_PMC_USB_PLLA_Enable
    @bl          PMC_PMC_USB_PLLA_Enable
    @.global     PMC_PMC_SCER_UDP_Enable
    @bl          PMC_PMC_SCER_UDP_Enable
    @.global     PMC_PMC_SCDR_UDP_Disable
    @bl          PMC_PMC_SCDR_UDP_Disable
    .global     PMC_PMC_USB_ClockEnable
    bl          PMC_PMC_USB_ClockEnable



    @ Setup watchdog

    @ Enable write protect PMC
    .global     PMC_PMC_WPMR_WriteProtectEnable
    bl          PMC_PMC_WPMR_WriteProtectEnable

    @ Setup DACC
    

    @ Enable write protect DAC
    .global     DACC_DACC_WPMR_WriteProtectEnable
    bl          DACC_DACC_WPMR_WriteProtectEnable

    pop         { pc }                                                          @ Restore return address and return to caller


@ Start main application
main:
    .global     main
    .type       main, %function    

    .equ        op1, 0x00001234
    .equ        op2, 0x56780000

    movs        r0, #1
    ldr         r1, =op1
    ldr         r2, =op2
    adds        r1, r2
    b           main                                                            @ Final state

    .end
    