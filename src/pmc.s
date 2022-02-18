    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/macros.inc"
    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/peripheral.inc"

    @ Macros
    .macro Macro_ , label, value, flag
\label:
    .global     \label
    .type       \label, %function
    push        { lr }
    SetValueWO      PMC_CKGR_MOR, \value
    VerifyFlagSet   PMC_PMC_SR, \flag
    pop         { pc }
    .endm


@    .section .text, "ax"
    
    @ Register addresses of PMC
    .equ        PMC_BASE, 0x400E0400                                            @ Base register address
    .equ        PMC_PMC_SCER, (PMC_BASE + 0x0000)                               @ Address to register System Clock Enable Register
    .equ        PMC_PMC_SCDR, (PMC_BASE + 0x0004)                               @ Address to register System Clock Disable Register
    .equ        PMC_PMC_SCSR, (PMC_BASE + 0x0008)                               @ Address to register System Clock Status Register 
    .equ        PMC_PMC_PCER0, (PMC_BASE + 0x0010)                              @ Address to register Peripheral Clock Enable Register 0
    .equ        PMC_PMC_PCDR0, (PMC_BASE + 0x0014)                              @ Address to register Peripheral Clock Disable Register 0
    .equ        PMC_PMC_PCSR0, (PMC_BASE + 0x0018)                              @ Address to register Peripheral Clock Status Register 0
    .equ        PMC_CKGR_MOR, (PMC_BASE + 0x0020)                               @ Address to register Main Oscillator Register
    .equ        PMC_CKGR_MCFR, (PMC_BASE + 0x0024)                              @ Address to register Main Clock Frequency Register
    .equ        PMC_CKGR_PLLAR, (PMC_BASE + 0x0028)                             @ Address to register PLLA Register
    .equ        PMC_CKGR_PLLBR, (PMC_BASE + 0x002C)                             @ Address to register PLLB Register
    .equ        PMC_PMC_MCKR, (PMC_BASE + 0x0030)                               @ Address to register Master Clock Register
    .equ        PMC_PMC_USB, (PMC_BASE + 0x0038)                                @ Address to register USB Clock Register
    .equ        PMC_PMC_PCK0, (PMC_BASE + 0x0040)                               @ Address to register Programmable Clock 0 Register
    .equ        PMC_PMC_PCK1, (PMC_BASE + 0x0044)                               @ Address to register Programmable Clock 1 Register
    .equ        PMC_PMC_PCK2, (PMC_BASE + 0x0048)                               @ Address to register Programmable Clock 2 Register
    .equ        PMC_PMC_IER, (PMC_BASE + 0x0060)                                @ Address to register Interrupt Enable Register
    .equ        PMC_PMC_IDR, (PMC_BASE + 0x0064)                                @ Address to register Interrupt Disable Register
    .equ        PMC_PMC_SR, (PMC_BASE + 0x0068)                                 @ Address to register Status Register
    .equ        PMC_PMC_IMR, (PMC_BASE + 0x006C)                                @ Address to register Interrupt Mask Register
    .equ        PMC_PMC_FSMR, (PMC_BASE + 0x0070)                               @ Address to register Fast Startup Mode Register
    .equ        PMC_PMC_FSPR, (PMC_BASE + 0x0074)                               @ Address to register Fast Startup Polarity Register
    .equ        PMC_PMC_FOCR, (PMC_BASE + 0x0078)                               @ Address to register Fault Output Clear Register
    .equ        PMC_PMC_WPMR, (PMC_BASE + 0x00E4)                               @ Address to register Write Protect Mode Register
    .equ        PMC_PMC_WPSR, (PMC_BASE + 0x00E8)                               @ Address to register Write Protect Status Register
    .equ        PMC_PMC_PCER1, (PMC_BASE + 0x0100)                              @ Address to register Peripheral Clock Enable Register 1
    .equ        PMC_PMC_PCDR1, (PMC_BASE + 0x0104)                              @ Address to register Peripheral Clock Disable Register 1
    .equ        PMC_PMC_PCSR1, (PMC_BASE + 0x0108)                              @ Address to register Peripheral Clock Status Register 1
    .equ        PMC_PMC_OCR, (PMC_BASE + 0x0110)                                @ Address to register Oscillator Calibration Register

    @ Register PMC_SR, read-only
    @ 31 30 29 28 27 26 25 24 23 22 21 | 20  | 19   | 18    | 17      | 16       | 15 14 13 12 11 | 10      | 09      | 08      | 07      | 06 05 04 | 03     | 02    | 01    | 00
    @ -  -  -  -  -  -  -  -  -  -  -  | FOS | CFDS | CFDEV | MOSCRCS | MOSCSELS | -  -  -  -  -  | PCKRDY2 | PCKRDY1 | PCKRDY0 | OSCSELS | -  -  -  | MCKRDY | LOCKB | LOCKA | MOSCXTS
    @
    @ MOSCXTS : 0 = Main XTAL oscillator is not stabilized
    @         : 1 = Main XTAL oscillator is stabilized
    @ LOCKA : 0 = PLLA is not locked
    @       : 1 = PLLA is locked
    @ LOCKB : 0 = PLLB is not locked
    @       : 1 = PLLB is locked
    @ MCKRDY : 0 = Master Clock is not ready
    @        : 1 = Master Clock is ready
    @ OSCSELS : 0 = Internal slow clock RC oscillator is selected
    @         : 1 = External slow clock 32 kHz oscillator is selected
    @ PCKRDYx : 0 = Programmable Clock x is not ready
    @         : 1 = Programmable Clock x is ready
    @ MOSCSELS : 0 = Selection is in progress
    @          : 1 = Selection is done
    @ MOSCRCS : 0 = Main on-chip RC oscillator is not stabilized
    @         : 1 = Main on-chip RC oscillator is stablized
    @ CFDEV : 0 = No clock failure detection of the main on-chip RC oscillator clock has occurred since the last read of PMC_SR.
    @       : 1 = At least one clock failure detection of the main on-chip RC oscillator clock has occurred since the last read of PMC_SR
    @ CFDS : 0 = A clock failure of the main on-chip RC oscillator clock is not detected
    @      : 1 = A clock failure of the main on-chip RC oscillator clock is detected
    @ FOS : 0 = The fault output of the clock failure detector is inactive
    @     : 1 = The fault output of the clock failure detector is active
    .equ        PMC_PMC_SR_MOSCXTS, 0x00000001
    .equ        PMC_PMC_SR_LOCKA, 0x00000002
    .equ        PMC_PMC_SR_LOCKB, 0x00000004
    .equ        PMC_PMC_SR_MCKRDY, 0x00000008
    .equ        PMC_PMC_SR_OSCSELS, 0x00000080
    .equ        PMC_PMC_SR_PCKRDY0, 0x00000100
    .equ        PMC_PMC_SR_PCKRDY1, 0x00000200
    .equ        PMC_PMC_SR_PCKRDY2, 0x00000400
    .equ        PMC_PMC_SR_MOSCSELS, 0x00010000
    .equ        PMC_PMC_SR_MOSCRCS, 0x00020000
    .equ        PMC_PMC_SR_CFDEV, 0x00040000
    .equ        PMC_PMC_SR_CFDS, 0x00080000
    .equ        PMC_PMC_SR_FOS, 0x00100000

    @ Register CKGR_MOR, read-write
    @ 31 30 29 28 27 26 | 25    | 24      | 23 22 21 20 19 18 17 16 | 15 14 13 12 11 10 09 08 | 07 | 06 05 04 | 03       | 02 | 01       | 00
    @ -  -  -  -  -  -  | CFDEN | MOSCSEL | KEY                     | MOSCXTST                | -  | MOSCRCF  | MOSCRCEN | -  | MOSCXTBY | MOSCXTEN
    @
    @ MOSCXTEN : 0 = Main crystal oscillator is disabled.
    @          : 1 = Main crystal oscillator is enabled. MOSCXTBY must be set to 0.
    @ MOSCXTBY : 0 = No effect
    @          : 1 = The Main crystal oscillator is bypassed.
    @ MOSCRCEN : 0 = The Main On-Chip RC Oscillator is disabled.
    @          : 1 = The Main On-Chip RC Oscillator is enabled.
    @ MOSCRCF : 0x0 = 4 MHZ
    @         : 0x1 = 8 MHZ
    @         : 0x2 = 12 MHZ
    @ MOSCXTST : Specifies the number ob Slow Clock Cycles multiplied by 8 for the Main Crystal Oscillator start-up time.
    @ KEY : 0x37
    @ MOSCSEL : 0 = The Main On-Chip RC Oscillator is selected.
    @         : 1 = The Main Crystal Oscillator is selected.
    @ CFDEN : 0 = The Clock Failure Detector is disabled
    @       : 1 = The Clock Failure Detector is enabled
    .equ        PMC_CKGR_MOR_MOSCXTEN, 0
    .equ        PMC_CKGR_MOR_MOSCXTBY, 1
    .equ        PMC_CKGR_MOR_MOSCRCEN, 3
    .equ        PMC_CKGR_MOR_MOSCRCF, 4
    .equ        PMC_CKGR_MOR_MOSCXTST, 8
    .equ        PMC_CKGR_MOR_KEY, 16
    .equ        PMC_CKGR_MOR_MOSCSEL, 24
    .equ        PMC_CKGR_MOR_CFDEN, 25

    .equ        PMC_CKGR_MOR_MOSCXTST_VALUE, 0xFF
    .equ        PMC_CKGR_MOR_KEY_VALUE, 0x37

PMC_CKGR_MOR_MainCrystalEnable:
    .global     PMC_CKGR_MOR_MainCrystalEnable
    .type       PMC_CKGR_MOR_MainCrystalEnable, %function
    push        { lr }
    SetValueWO      PMC_CKGR_MOR, ((1 << PMC_CKGR_MOR_MOSCSEL) | (PMC_CKGR_MOR_KEY_VALUE << PMC_CKGR_MOR_KEY) | (PMC_CKGR_MOR_MOSCXTST_VALUE << PMC_CKGR_MOR_MOSCXTST) | (1 << PMC_CKGR_MOR_MOSCXTEN))    
    VerifyFlagSet   PMC_PMC_SR, PMC_PMC_SR_MOSCXTS
    pop         { pc }

    @ Register CKGR_PLLxR, read-write
    @ 31 30 | 29  | 28 27 | 26 25 24 23 22 21 20 19 18 17 16 | 15 14 | 13 12 11 10 09 08 | 07 06 05 04 03 02 01 00
    @ -  -  | ONE | -  -  | MULA                             | -  -  | PLLACOUNT         | DIVA
    @ -  -    -     -  -  | MULB                             | -  -  | PLLBCOUNT         | DIVB
    @ 
    @ DIVx : 0 = Divider output is 0
    @      : 1 = Divider is bypassed
    @      : 2 .. 255 = Divider output is DIVx
    @ PLLxCOUNT : Specifies the number of Slow Clock cycles x8 before the LOCKx bit is set in PMC_SR after CKGR_PLLxR is written
    @ MULx : 0 = The PLLx is deactivated
    @      : 1 .. 36 = The PLLx Clock frequency is the PLLx input frequency multiplied by MULx + 1
    @ ONE : always 1 (Warning!)
    .equ        PMC_CKGR_PLLxR_DIVx, 0
    .equ        PMC_CKGR_PLLxR_PLLxCOUNT, 8
    .equ        PMC_CKGR_PLLxR_MULx, 16
    .equ        PMC_CKGR_PLLAR_ONE, 29

    .equ        PMC_CKGR_PLLAR_DIVA_VALUE, 1
    .equ        PMC_CKGR_PLLAR_PLLACOUNT_VALUE, 0x3F
    .equ        PMC_CKGR_PLLAR_MULA_VALUE, 7

    .equ        PMC_CKGR_PLLBR_DIVB_VALUE, 2
    .equ        PMC_CKGR_PLLBR_PLLBCOUNT_VALUE, 0x3F
    .equ        PMC_CKGR_PLLBR_MULB_VALUE, 7

PMC_CKGR_PLLAR_Enable:
    .global     PMC_CKGR_PLLAR_Enable
    .type       PMC_CKGR_PLLAR_Enable, %function
    push        { lr }
    SetValueRW      PMC_CKGR_PLLAR, ((1 << PMC_CKGR_PLLAR_ONE) | (PMC_CKGR_PLLAR_MULA_VALUE << PMC_CKGR_PLLxR_MULx) | (PMC_CKGR_PLLAR_PLLACOUNT_VALUE << PMC_CKGR_PLLxR_PLLxCOUNT) | (PMC_CKGR_PLLAR_DIVA_VALUE << PMC_CKGR_PLLxR_DIVx))
    VerifyFlagSet   PMC_PMC_SR, PMC_PMC_SR_LOCKA
    pop         { pc }

PMC_CKGR_PLLBR_Enable:
    .global     PMC_CKGR_PLLBR_Enable
    .type       PMC_CKGR_PLLBR_Enable, %function
    push        { lr }
    SetValueRW      PMC_CKGR_PLLBR, ((PMC_CKGR_PLLBR_MULB_VALUE << PMC_CKGR_PLLxR_MULx) | (PMC_CKGR_PLLBR_PLLBCOUNT_VALUE << PMC_CKGR_PLLxR_PLLxCOUNT) | (PMC_CKGR_PLLBR_DIVB_VALUE << PMC_CKGR_PLLxR_DIVx))
    VerifyFlagSet   PMC_PMC_SR, PMC_PMC_SR_LOCKB
    pop         { pc }

    @ Register PMC_PCKx
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 | 06 05 04 | 03 | 02 01 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | PRES     | -  | CSS
    @
    @ CSS : 0 = SLCK is selected
    @     : 1 = MAINCK is selected
    @     : 2 = PLLA clock is selected
    @     : 3 = PLLB clock is selected
    @     : 4 = MCK is selected
    @ PRES : 0 = No divider
    @      : 1..6 = Divide by 2^n
    .equ        PMC_PMC_PCKx_CSS, 0
    .equ        PMC_PMC_PCKx_PRES, 4    

    @.equ        PMC_PMC_PCKx_CSS_VALUE, 0                                       @ SLCK, 32kHz
    @.equ        PMC_PMC_PCKx_CSS_VALUE, 1                                       @ MAINCK, 12MHz
    .equ        PMC_PMC_PCKx_CSS_VALUE, 2                                       @ PLL A clock, 96MHz
    @.equ        PMC_PMC_PCKx_CSS_VALUE, 3                                       @ PLL B clock, 96MHz
    @.equ        PMC_PMC_PCKx_CSS_VALUE, 4                                       @ MCK clock
    
    @
    .equ        PMC_PMC_PCKx_PRES_VALUE, 0

PMC_PMC_PCK0_OutputClock:
    .global     PMC_PMC_PCK0_OutputClock
    .type       PMC_PMC_PCK0_OutputClock, %function
    push        { lr }
    SetValueWO  PMC_PMC_PCK0, ((PMC_PMC_PCKx_PRES_VALUE << PMC_PMC_PCKx_PRES) | (PMC_PMC_PCKx_CSS_VALUE << PMC_PMC_PCKx_CSS))
    pop         { pc }

    @ Register PMC_SCER, write-only
    @ Register PMC_SCDR, write-only
    @ Register PMC_SCSR, read-only, note bit 00 is always 1!
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 | 10   | 09   | 08   | 07  | 06 05 04 03 02 01 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | PCK2 | PCK1 | PCK0 | UDP | -  -  -  -  -  -  -
    @
    @ UDP : 0 = No effect
    @     : 1 = Enables the 48 MHz clock (UDPCK) of the USB Device Port
    @
    @ PCKx : 0 = No effect
    @      : 1 = Enables the corresponding Programmable Clock Output
    @
    .equ        PMC_PMC_SCxR_UDP, 0x00000080
    .equ        PMC_PMC_SCxR_PCK0, 0x00000100
    .equ        PMC_PMC_SCxR_PCK1, 0x00000200
    .equ        PMC_PMC_SCxR_PCK2, 0x00000400

@PMC_PMC_SCER_UDP_Enable:
@    .global     PMC_PMC_SCER_UDP_Enable
@    .type       PMC_PMC_SCER_UDP_Enable, %function
@    push        { lr }
@    SetValueWO  PMC_PMC_SCER, PMC_PMC_SCxR_UDP
@    pop         { pc }

@PMC_PMC_SCDR_UDP_Disable:
@    .global     PMC_PMC_SCDR_UDP_Disable
@    .type       PMC_PMC_SCDR_UDP_Disable, %function 
@    push        { lr }
@    SetValueWO  PMC_PMC_SCDR, PMC_PMC_SCxR_UDP
@    pop         { pc }

PMC_PMC_SCER_PCK0_Enable:
    .global     PMC_PMC_SCER_PCK0_Enable
    .type       PMC_PMC_SCER_PCK0_Enable, %function
    push        { lr }
    SetValueWO  PMC_PMC_SCER, PMC_PMC_SCxR_PCK0
    pop         { pc }

PMC_PMC_SCDR_PCK0_Disable:
    .global     PMC_PMC_SCDR_PCK0_Disable
    .type       PMC_PMC_SCDR_PCK0_Disable, %function
    push        { lr }
    SetValueWO  PMC_PMC_SCDR, PMC_PMC_SCxR_PCK0
    pop         { pc }

    @ Register PMC_USB, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 | 11 10 09 08 | 07 06 05 04 03 02 01 | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | USBDIV      | -  -  -  -  -  -  -  | USBS
    @
    @ USBS : 0 = USB Clock Input is PLLA
    @      : 1 = USB Clock Input is PLLB
    @ USBDIV : USB Clock is Input clock divided by USBDIV+1
    @
    .equ        PMC_PMC_USB_USBS, 0x00000001
    .equ        PMC_PMC_USB_USBDIV, 8

@PMC_PMC_USB_PLLA_Enable:
@    .global     PMC_PMC_USB_PLLA_Enable
@    .type       PMC_PMC_USB_PLLA_Enable, %function
@    push        { lr }
@    SetValueWO  PMC_PMC_USB, (1 << PMC_PMC_USB_USBDIV) @ Select PLLA with 96MHz, will provide 48MHZ
@    pop         { pc }


PMC_PMC_USB_Clock_Enable:
    .global     PMC_PMC_USB_Clock_Enable
    .type       PMC_PMC_USB_Clock_Enable, %function
    push        { lr }
    SetValueWO  PMC_PMC_USB, (1 << PMC_PMC_USB_USBDIV)                          @ Select PLLA with 96MHz, will provide 48MHZ
    SetValueWO  PMC_PMC_SCER, PMC_PMC_SCxR_UDP                                  @ Enable USBCK
    SetValueWO  PMC_PMC_PCER1, (1 << (PERIPHERAL_UDP - 32))                     @ Enable Clock for peripheral
    pop         { pc }



@ /* USB Clock uses PLLB */
@ PMC->PMC_USB = PMC_USB_USBDIV(1)    /* /2   */
@              | PMC_USB_USBS@        /* PLLB */



    @ Register PMC_WPMR, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 | 07 06 05 04 03 02 01 | 00
    @ WPKEY                                                                   | -  -  -  -  -  -  -  | WPEN
    @ 
    @ WPEN : 0 = Disables the Write Protect if WPKEY corresponds to "PMC" (0x504D43)
    @      : 1 = Enables the Write Protect if WPKEY corresponds to "PMC" (0x504D43)
    @ WPKEY : Key to permit operation
    .equ        PMC_WPMR_ENABLE, 0x504D4301
    .equ        PMC_WPMR_DISABLE, 0x504D4300

PMC_Write_Protect_Enable:
    .global     PMC_Write_Protect_Enable
    .type       PMC_Write_Protect_Enable, %function
    push        { lr }
    SetValueWO  PMC_PMC_WPMR, PMC_WPMR_ENABLE
    pop         { pc }
    

PMC_Write_Protect_Disable:
    .global     PMC_Write_Protect_Disable
    .type       PMC_Write_Protect_Disable, %function
    push        { lr }
    SetValueWO  PMC_PMC_WPMR, PMC_WPMR_DISABLE
    pop         { pc }

    .end






@ USB
@ PMC->PMC_PCER0 = 1 << dwId @ // Enable peripheral clock
@ REG_PMC_SCER = PMC_SCER_UDP@ // Enable USB clock
