    @ Import Macros
    .include "./macros.inc"

    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

    @ PIO A

    @ Macro for switching to peripheral function A
    .global Macro_PIOA_SwitchToA
    .macro  Macro_PIOA_SwitchToA, Label:req, Pin:req
\Label:
    .global     \Label
    .type       \Label, %function
    push        { lr }
    RegisterClearValueRW    PIOA_PIO_ABCDSR1, \Pin
    RegisterClearValueRW    PIOA_PIO_ABCDSR2, \Pin
    RegisterSetValueWO      PIOA_PIO_PDR, \Pin
    pop         { pc }
    .endm

    @ Macro for switching to peripheral function B
    .global Macro_PIOA_SwitchToB
    .macro  Macro_PIOA_SwitchToB, Label:req, Pin:req
\Label:
    .global     \Label
    .type       \Label, %function
    push        { lr }
    RegisterSetValueRW      PIOA_PIO_ABCDSR1, \Pin
    RegisterClearValueRW    PIOA_PIO_ABCDSR2, \Pin
    RegisterSetValueWO      PIOA_PIO_PDR, \Pin
    pop         { pc }
    .endm

    @ Macro for switching to peripheral function C
    .global Macro_PIOA_SwitchToC
    .macro  Macro_PIOA_SwitchToC, Label:req, Pin:req
\Label:
    .global     \Label
    .type       \Label, %function
    push        { lr }
    RegisterClearValueRW    PIOA_PIO_ABCDSR1, \Pin
    RegisterSetValueRW      PIOA_PIO_ABCDSR2, \Pin
    RegisterSetValueWO      PIOA_PIO_PDR, \Pin
    pop         { pc }
    .endm

    @ PIO B

    @ Macro for switching to peripheral function A
    .global Macro_PIOB_SwitchToA
    .macro  Macro_PIOB_SwitchToA, Label:req, Pin:req
\Label:
    .global     \Label
    .type       \Label, %function
    push        { lr }
    RegisterClearValueRW    PIOB_PIO_ABCDSR1, \Pin
    RegisterClearValueRW    PIOB_PIO_ABCDSR2, \Pin
    RegisterSetValueWO      PIOB_PIO_PDR, \Pin
    pop         { pc }
    .endm

    @ Macro for switching to peripheral function B
    .global Macro_PIOB_SwitchToB
    .macro  Macro_PIOB_SwitchToB, Label:req, Pin:req
\Label:
    .global     \Label
    .type       \Label, %function
    push        { lr }
    RegisterSetValueRW      PIOB_PIO_ABCDSR1, \Pin
    RegisterClearValueRW    PIOB_PIO_ABCDSR2, \Pin
    RegisterSetValueWO      PIOB_PIO_PDR, \Pin
    pop         { pc }
    .endm

    @ Macro for switching to peripheral function C
    .global Macro_PIOB_SwitchToC
    .macro  Macro_PIOB_SwitchToC, Label:req, Pin:req
\Label:
    .global     \Label
    .type       \Label, %function
    push        { lr }
    RegisterClearValueRW    PIOB_PIO_ABCDSR1, \Pin
    RegisterSetValueRW      PIOB_PIO_ABCDSR2, \Pin
    RegisterSetValueWO      PIOB_PIO_PDR, \Pin
    pop         { pc }
    .endm

@    .section .text, "ax"
    
    @ Register addresses of PIOA
    .equ        PIOA_BASE, 0x400E0E00                                           @ Base register address
    .equ        PIOA_PIO_PER, (PIOA_BASE + 0x0000)                              @ Address to register PIO Enable Register
    .equ        PIOA_PIO_PDR, (PIOA_BASE + 0x0004)                              @ Address to register PIO Disable Register
    .equ        PIOA_PIO_PSR, (PIOA_BASE + 0x0008)                              @ Address to register PIO Status Register 
    .equ        PIOA_PIO_OER, (PIOA_BASE + 0x0010)                              @ Address to register Output Enable Register
    .equ        PIOA_PIO_ODR, (PIOA_BASE + 0x0014)                              @ Address to register Output Disable Register
    .equ        PIOA_PIO_OSR, (PIOA_BASE + 0x0018)                              @ Address to register Output Status Register
    .equ        PIOA_PIO_IFER, (PIOA_BASE + 0x0020)                             @ Address to register Glitch Input Filter Enable Register
    .equ        PIOA_PIO_IFDR, (PIOA_BASE + 0x0024)                             @ Address to register Glitch Input Filter Disable Register
    .equ        PIOA_PIO_IFSR, (PIOA_BASE + 0x0028)                             @ Address to register Glitch Input Filter Status Register
    .equ        PIOA_PIO_SODR, (PIOA_BASE + 0x0030)                             @ Address to register Set Output Data Register
    .equ        PIOA_PIO_CODR, (PIOA_BASE + 0x0034)                             @ Address to register Clear Output Data Register
    .equ        PIOA_PIO_ODSR, (PIOA_BASE + 0x0038)                             @ Address to register Output Data Status Register
    .equ        PIOA_PIO_PDSR, (PIOA_BASE + 0x003C)                             @ Address to register Pin Data Status Register
    .equ        PIOA_PIO_IER, (PIOA_BASE + 0x0040)                              @ Address to register Interrupt Enable Register
    .equ        PIOA_PIO_IDR, (PIOA_BASE + 0x0044)                              @ Address to register Interrupt Disable Register
    .equ        PIOA_PIO_IMR, (PIOA_BASE + 0x0048)                              @ Address to register Interrupt Mask Register
    .equ        PIOA_PIO_ISR, (PIOA_BASE + 0x004C)                              @ Address to register Interrupt Status Register
    .equ        PIOA_PIO_MDER, (PIOA_BASE + 0x0050)                             @ Address to register Multi-driver Enable Register
    .equ        PIOA_PIO_MDDR, (PIOA_BASE + 0x0054)                             @ Address to register Multi-driver Disable Register
    .equ        PIOA_PIO_MDSR, (PIOA_BASE + 0x0058)                             @ Address to register Multi-driver Status Register
    .equ        PIOA_PIO_PUDR, (PIOA_BASE + 0x0060)                             @ Address to register Pull-up Disable Register
    .equ        PIOA_PIO_PUER, (PIOA_BASE + 0x0064)                             @ Address to register Pull-up Enable Register
    .equ        PIOA_PIO_PUSR, (PIOA_BASE + 0x0068)                             @ Address to register Pad Pull-up Status Register
    .equ        PIOA_PIO_ABCDSR1, (PIOA_BASE + 0x0070)                          @ Address to register Peripheral Select Register 1
    .equ        PIOA_PIO_ABCDSR2, (PIOA_BASE + 0x0074)                          @ Address to register Peripheral Select Register 2
    .equ        PIOA_PIO_IFSCDR, (PIOA_BASE + 0x0080)                           @ Address to register Input Filter Slow Clock Disable Register
    .equ        PIOA_PIO_IFSCER, (PIOA_BASE + 0x0084)                           @ Address to register Input Filter Slow Clock Enable Register
    .equ        PIOA_PIO_IFSCSR, (PIOA_BASE + 0x0088)                           @ Address to register Input Filter Slow Clock Status Register
    .equ        PIOA_PIO_SCDR, (PIOA_BASE + 0x008C)                             @ Address to register Slow clock Divider Debouncing Register
    .equ        PIOA_PIO_PPDDR, (PIOA_BASE + 0x0090)                            @ Address to register Pad Pull-down Disable Register
    .equ        PIOA_PIO_PPDER, (PIOA_BASE + 0x0094)                            @ Address to register Pad Pull-down Enable Register
    .equ        PIOA_PIO_PPDSR, (PIOA_BASE + 0x0098)                            @ Address to register Pad Pull-down Status Register
    .equ        PIOA_PIO_OWER, (PIOA_BASE + 0x00A0)                             @ Address to register Output Write Enable Register
    .equ        PIOA_PIO_OWDR, (PIOA_BASE + 0x00A4)                             @ Address to register Output Write Disable Register
    .equ        PIOA_PIO_OWSR, (PIOA_BASE + 0x00A8)                             @ Address to register Output Write Status Register
    .equ        PIOA_PIO_AIMER, (PIOA_BASE + 0x00B0)                            @ Address to register Additional Interrupt Modes Enable Register
    .equ        PIOA_PIO_AIMDR, (PIOA_BASE + 0x00B4)                            @ Address to register Additional Interrupt Modes Disable Register
    .equ        PIOA_PIO_AIMMR, (PIOA_BASE + 0x00B8)                            @ Address to register Additional Interrupt Modes Mask Register
    .equ        PIOA_PIO_ESR, (PIOA_BASE + 0x00C0)                              @ Address to register Edge Select Register
    .equ        PIOA_PIO_LSR, (PIOA_BASE + 0x00C4)                              @ Address to register Level Select Register
    .equ        PIOA_PIO_ELSR, (PIOA_BASE + 0x00C8)                             @ Address to register Edge/Level Status Register
    .equ        PIOA_PIO_FELLSR, (PIOA_BASE + 0x00D0)                           @ Address to register Falling Edge/Low Level Select Register
    .equ        PIOA_PIO_REHLSR, (PIOA_BASE + 0x00D4)                           @ Address to register Rising Edge/High Level Select Register
    .equ        PIOA_PIO_FRLHSR, (PIOA_BASE + 0x00D8)                           @ Address to register Fall/Rise - Low/High Status Register
    .equ        PIOA_PIO_LOCKSR, (PIOA_BASE + 0x00E0)                           @ Address to register Lock Status Register
    .equ        PIOA_PIO_WPMR, (PIOA_BASE + 0x00E4)                             @ Address to register Write Protect Mode Register
    .equ        PIOA_PIO_WPSR, (PIOA_BASE + 0x00E8)                             @ Address to register Write Protect Status Register
    .equ        PIOA_PIO_SCHMITT, (PIOA_BASE + 0x0100)                          @ Address to register Schmitt Trigger Register
    .equ        PIOA_PIO_PCMR, (PIOA_BASE + 0x0150)                             @ Address to register Parallel Capture Mode Register
    .equ        PIOA_PIO_PCIER, (PIOA_BASE + 0x0154)                            @ Address to register Parallel Capture Interrupt Enable Register
    .equ        PIOA_PIO_PCIDR, (PIOA_BASE + 0x0158)                            @ Address to register Parallel Capture Interrupt Disable Register
    .equ        PIOA_PIO_PCIMR, (PIOA_BASE + 0x015C)                            @ Address to register Parallel Capture Interrupt Mask Register
    .equ        PIOA_PIO_PCISR, (PIOA_BASE + 0x0160)                            @ Address to register Parallel Capture Interrupt Status Register
    .equ        PIOA_PIO_PCRHR, (PIOA_BASE + 0x0164)                            @ Address to register Parallel Capture Reception Holding Register

    @ Register addresses of PIOB
    .equ        PIOB_BASE, 0x400E1000                                           @ Base register address
    .equ        PIOB_PIO_PER, (PIOB_BASE + 0x0000)                              @ Address to register PIO Enable Register
    .equ        PIOB_PIO_PDR, (PIOB_BASE + 0x0004)                              @ Address to register PIO Disable Register
    .equ        PIOB_PIO_PSR, (PIOB_BASE + 0x0008)                              @ Address to register PIO Status Register 
    .equ        PIOB_PIO_OER, (PIOB_BASE + 0x0010)                              @ Address to register Output Enable Register
    .equ        PIOB_PIO_ODR, (PIOB_BASE + 0x0014)                              @ Address to register Output Disable Register
    .equ        PIOB_PIO_OSR, (PIOB_BASE + 0x0018)                              @ Address to register Output Status Register
    .equ        PIOB_PIO_IFER, (PIOB_BASE + 0x0020)                             @ Address to register Glitch Input Filter Enable Register
    .equ        PIOB_PIO_IFDR, (PIOB_BASE + 0x0024)                             @ Address to register Glitch Input Filter Disable Register
    .equ        PIOB_PIO_IFSR, (PIOB_BASE + 0x0028)                             @ Address to register Glitch Input Filter Status Register
    .equ        PIOB_PIO_SODR, (PIOB_BASE + 0x0030)                             @ Address to register Set Output Data Register
    .equ        PIOB_PIO_CODR, (PIOB_BASE + 0x0034)                             @ Address to register Clear Output Data Register
    .equ        PIOB_PIO_ODSR, (PIOB_BASE + 0x0038)                             @ Address to register Output Data Status Register
    .equ        PIOB_PIO_PDSR, (PIOB_BASE + 0x003C)                             @ Address to register Pin Data Status Register
    .equ        PIOB_PIO_IER, (PIOB_BASE + 0x0040)                              @ Address to register Interrupt Enable Register
    .equ        PIOB_PIO_IDR, (PIOB_BASE + 0x0044)                              @ Address to register Interrupt Disable Register
    .equ        PIOB_PIO_IMR, (PIOB_BASE + 0x0048)                              @ Address to register Interrupt Mask Register
    .equ        PIOB_PIO_ISR, (PIOB_BASE + 0x004C)                              @ Address to register Interrupt Status Register
    .equ        PIOB_PIO_MDER, (PIOB_BASE + 0x0050)                             @ Address to register Multi-driver Enable Register
    .equ        PIOB_PIO_MDDR, (PIOB_BASE + 0x0054)                             @ Address to register Multi-driver Disable Register
    .equ        PIOB_PIO_MDSR, (PIOB_BASE + 0x0058)                             @ Address to register Multi-driver Status Register
    .equ        PIOB_PIO_PUDR, (PIOB_BASE + 0x0060)                             @ Address to register Pull-up Disable Register
    .equ        PIOB_PIO_PUER, (PIOB_BASE + 0x0064)                             @ Address to register Pull-up Enable Register
    .equ        PIOB_PIO_PUSR, (PIOB_BASE + 0x0068)                             @ Address to register Pad Pull-up Status Register
    .equ        PIOB_PIO_ABCDSR1, (PIOB_BASE + 0x0070)                          @ Address to register Peripheral Select Register 1
    .equ        PIOB_PIO_ABCDSR2, (PIOB_BASE + 0x0074)                          @ Address to register Peripheral Select Register 2
    .equ        PIOB_PIO_IFSCDR, (PIOB_BASE + 0x0080)                           @ Address to register Input Filter Slow Clock Disable Register
    .equ        PIOB_PIO_IFSCER, (PIOB_BASE + 0x0084)                           @ Address to register Input Filter Slow Clock Enable Register
    .equ        PIOB_PIO_IFSCSR, (PIOB_BASE + 0x0088)                           @ Address to register Input Filter Slow Clock Status Register
    .equ        PIOB_PIO_SCDR, (PIOB_BASE + 0x008C)                             @ Address to register Slow clock Divider Debouncing Register
    .equ        PIOB_PIO_PPDDR, (PIOB_BASE + 0x0090)                            @ Address to register Pad Pull-down Disable Register
    .equ        PIOB_PIO_PPDER, (PIOB_BASE + 0x0094)                            @ Address to register Pad Pull-down Enable Register
    .equ        PIOB_PIO_PPDSR, (PIOB_BASE + 0x0098)                            @ Address to register Pad Pull-down Status Register
    .equ        PIOB_PIO_OWER, (PIOB_BASE + 0x00A0)                             @ Address to register Output Write Enable Register
    .equ        PIOB_PIO_OWDR, (PIOB_BASE + 0x00A4)                             @ Address to register Output Write Disable Register
    .equ        PIOB_PIO_OWSR, (PIOB_BASE + 0x00A8)                             @ Address to register Output Write Status Register
    .equ        PIOB_PIO_AIMER, (PIOB_BASE + 0x00B0)                            @ Address to register Additional Interrupt Modes Enable Register
    .equ        PIOB_PIO_AIMDR, (PIOB_BASE + 0x00B4)                            @ Address to register Additional Interrupt Modes Disable Register
    .equ        PIOB_PIO_AIMMR, (PIOB_BASE + 0x00B8)                            @ Address to register Additional Interrupt Modes Mask Register
    .equ        PIOB_PIO_ESR, (PIOB_BASE + 0x00C0)                              @ Address to register Edge Select Register
    .equ        PIOB_PIO_LSR, (PIOB_BASE + 0x00C4)                              @ Address to register Level Select Register
    .equ        PIOB_PIO_ELSR, (PIOB_BASE + 0x00C8)                             @ Address to register Edge/Level Status Register
    .equ        PIOB_PIO_FELLSR, (PIOB_BASE + 0x00D0)                           @ Address to register Falling Edge/Low Level Select Register
    .equ        PIOB_PIO_REHLSR, (PIOB_BASE + 0x00D4)                           @ Address to register Rising Edge/High Level Select Register
    .equ        PIOB_PIO_FRLHSR, (PIOB_BASE + 0x00D8)                           @ Address to register Fall/Rise - Low/High Status Register
    .equ        PIOB_PIO_LOCKSR, (PIOB_BASE + 0x00E0)                           @ Address to register Lock Status Register
    .equ        PIOB_PIO_WPMR, (PIOB_BASE + 0x00E4)                             @ Address to register Write Protect Mode Register
    .equ        PIOB_PIO_WPSR, (PIOB_BASE + 0x00E8)                             @ Address to register Write Protect Status Register
    .equ        PIOB_PIO_SCHMITT, (PIOB_BASE + 0x0100)                          @ Address to register Schmitt Trigger Register
    .equ        PIOB_PIO_PCMR, (PIOB_BASE + 0x0150)                             @ Address to register Parallel Capture Mode Register
    .equ        PIOB_PIO_PCIER, (PIOB_BASE + 0x0154)                            @ Address to register Parallel Capture Interrupt Enable Register
    .equ        PIOB_PIO_PCIDR, (PIOB_BASE + 0x0158)                            @ Address to register Parallel Capture Interrupt Disable Register
    .equ        PIOB_PIO_PCIMR, (PIOB_BASE + 0x015C)                            @ Address to register Parallel Capture Interrupt Mask Register
    .equ        PIOB_PIO_PCISR, (PIOB_BASE + 0x0160)                            @ Address to register Parallel Capture Interrupt Status Register
    .equ        PIOB_PIO_PCRHR, (PIOB_BASE + 0x0164)                            @ Address to register Parallel Capture Reception Holding Register

    @ Pins
    .equ        PIOx_P00, 0x00000001
    .equ        PIOx_P01, 0x00000002
    .equ        PIOx_P02, 0x00000004
    .equ        PIOx_P03, 0x00000008
    .equ        PIOx_P04, 0x00000010
    .equ        PIOx_P05, 0x00000020
    .equ        PIOx_P06, 0x00000040
    .equ        PIOx_P07, 0x00000080
    .equ        PIOx_P08, 0x00000100
    .equ        PIOx_P09, 0x00000200
    .equ        PIOx_P10, 0x00000400
    .equ        PIOx_P11, 0x00000800
    .equ        PIOx_P12, 0x00001000
    .equ        PIOx_P13, 0x00002000
    .equ        PIOx_P14, 0x00004000
    .equ        PIOx_P15, 0x00008000
    .equ        PIOx_P16, 0x00010000
    .equ        PIOx_P17, 0x00020000
    .equ        PIOx_P18, 0x00040000
    .equ        PIOx_P19, 0x00080000
    .equ        PIOx_P20, 0x00100000
    .equ        PIOx_P21, 0x00200000
    .equ        PIOx_P22, 0x00400000
    .equ        PIOx_P23, 0x00800000
    .equ        PIOx_P24, 0x01000000
    .equ        PIOx_P25, 0x02000000
    .equ        PIOx_P26, 0x04000000
    .equ        PIOx_P27, 0x08000000
    .equ        PIOx_P28, 0x10000000
    .equ        PIOx_P29, 0x20000000
    .equ        PIOx_P30, 0x40000000
    .equ        PIOx_P31, 0x80000000


    @ Register PIOx_PER, write-only 
    @ Register PIOx_PDR, write-only
    @ Register PIOx_PSR, read-only
    @ 31  | 30  | 29  | 28  | 27  | 26  | 25  | 24  | 23  | 22  | 21  | 20  | 19  | 18  | 17  | 16  | 15  | 14  | 13  | 12  | 11  | 10  | 09  | 08  | 07  | 06  | 05  | 04  | 03  | 02  | 01  | 00
    @ P31 | P30 | P29 | P28 | P27 | P26 | P25 | P24 | P23 | P22 | P21 | P20 | P19 | P18 | P17 | P16 | P15 | P14 | P13 | P12 | P11 | P10 | P09 | P08 | P07 | P06 | P06 | P04 | P03 | P02 | P01 | P00
    @
    @ PIOx_PER
    @ Pn : 0 = no effect
    @    : 1 = Enables the PIO to control the corresponding pin (disables peripheral control of the pin)
    @ PIOx_PDR
    @ Pn : 0 = no effect 
    @    : 1 = Disables the PIO from controlling the corresponding pin (enables peripheral control of the pin)
    @ PIOx_PSR
    @ Pn : 0 = PIO is inactive on the corresponding I/O line (peripheral is active)
    @    : 1 = PIO is active on the corresponding I/O line (peripheral is inactive)

    @ Register PIO_OER, write-only
    @ Register PIO_ODR, write-only
    @ Register PIO_OSR, read-only
    @ 31  | 30  | 29  | 28  | 27  | 26  | 25  | 24  | 23  | 22  | 21  | 20  | 19  | 18  | 17  | 16  | 15  | 14  | 13  | 12  | 11  | 10  | 09  | 08  | 07  | 06  | 05  | 04  | 03  | 02  | 01  | 00
    @ P31 | P30 | P29 | P28 | P27 | P26 | P25 | P24 | P23 | P22 | P21 | P20 | P19 | P18 | P17 | P16 | P15 | P14 | P13 | P12 | P11 | P10 | P09 | P08 | P07 | P06 | P06 | P04 | P03 | P02 | P01 | P00
    @
    @ PIOx_OER
    @ Pn : 0 = no effect
    @    : 1 = Enables the output on the I/O line
    @ PIOx_ODR
    @ Pn : 0 = no effect
    @    : 1 = Disables the output on the I/O line
    @ PIOx_OSR
    @ Pn : 0 = The I/O line is a pure input
    @    : 1 = The I/O line is enabled in output

    @ Register PIO_SODR, write-only
    @ Register PIO_ODSR, write-only
    @ Register PIO_CODR, read-only or read-write
    @ 31  | 30  | 29  | 28  | 27  | 26  | 25  | 24  | 23  | 22  | 21  | 20  | 19  | 18  | 17  | 16  | 15  | 14  | 13  | 12  | 11  | 10  | 09  | 08  | 07  | 06  | 05  | 04  | 03  | 02  | 01  | 00
    @ P31 | P30 | P29 | P28 | P27 | P26 | P25 | P24 | P23 | P22 | P21 | P20 | P19 | P18 | P17 | P16 | P15 | P14 | P13 | P12 | P11 | P10 | P09 | P08 | P07 | P06 | P06 | P04 | P03 | P02 | P01 | P00
    @
    @ PIOx_SODR
    @ Pn : 0 = no effect
    @    : 1 = Sets the data to be driven on the I/O line
    @ PIOx_ODSR
    @ Pn : 0 = no effect
    @    : 1 = Clears the data to be driven on the I/O line
    @ PIOx_CODR
    @ Pn : 0 = The data to be driven on the I/O line is 0
    @    : 1 = The data to be driven on the I/O line is 1

    @ Register PIO_MDER, write-only
    @ Register PIO_MDSR, write-only
    @ Register PIO_MDDR, read-only
    @ 31  | 30  | 29  | 28  | 27  | 26  | 25  | 24  | 23  | 22  | 21  | 20  | 19  | 18  | 17  | 16  | 15  | 14  | 13  | 12  | 11  | 10  | 09  | 08  | 07  | 06  | 05  | 04  | 03  | 02  | 01  | 00
    @ P31 | P30 | P29 | P28 | P27 | P26 | P25 | P24 | P23 | P22 | P21 | P20 | P19 | P18 | P17 | P16 | P15 | P14 | P13 | P12 | P11 | P10 | P09 | P08 | P07 | P06 | P06 | P04 | P03 | P02 | P01 | P00
    @ PIOx_MDER
    @ Pn : 0 = no effect
    @    : 1 = Enables Multi Drive on the I/O line
    @ PIOx_MDDR
    @ Pn : 0 = no effect
    @    : 1 = Disables Multi Drive on the I/O line
    @ PIOx_MDSR
    @ Pn : 0 = The Multi Drive is disabled on the I/O line. The pin is driven at high and low level
    @    : 1 = The Multi Drive is enabled on the I/O line. The pin is driven at low level only

    @ Register PIO_PUER, write-only
    @ Register PIO_PUDR, write-only
    @ Register PIO_PUSR, read-only
    @ 31  | 30  | 29  | 28  | 27  | 26  | 25  | 24  | 23  | 22  | 21  | 20  | 19  | 18  | 17  | 16  | 15  | 14  | 13  | 12  | 11  | 10  | 09  | 08  | 07  | 06  | 05  | 04  | 03  | 02  | 01  | 00
    @ P31 | P30 | P29 | P28 | P27 | P26 | P25 | P24 | P23 | P22 | P21 | P20 | P19 | P18 | P17 | P16 | P15 | P14 | P13 | P12 | P11 | P10 | P09 | P08 | P07 | P06 | P06 | P04 | P03 | P02 | P01 | P00
    @ PIOx_PUER
    @ Pn : 0 = no effect
    @    : 1 = Enables the pull up resistor on the I/O line
    @ PIOx_PUDR
    @ Pn : 0 = no effect
    @    : 1 = Disables the pull up resistor on the I/O line
    @ PIOx_PUSR
    @ Pn : 0 = Pull Up resistor is enabled on the I/O line
    @    : 1 = Pull Up resistor is disabled on the I/O line

    @ Register PIOx_ABCDSR1, read-write
    @ Register PIOx_ABCDSR2, read-write
    @ 31  | 30  | 29  | 28  | 27  | 26  | 25  | 24  | 23  | 22  | 21  | 20  | 19  | 18  | 17  | 16  | 15  | 14  | 13  | 12  | 11  | 10  | 09  | 08  | 07  | 06  | 05  | 04  | 03  | 02  | 01  | 00
    @ P31 | P30 | P29 | P28 | P27 | P26 | P25 | P24 | P23 | P22 | P21 | P20 | P19 | P18 | P17 | P16 | P15 | P14 | P13 | P12 | P11 | P10 | P09 | P08 | P07 | P06 | P06 | P04 | P03 | P02 | P01 | P00
    @
    @       PIOx_ABCDSR1 | PIOx_ABCDSR2
    @ Pnm   0            | 0           : Peripheral A function
    @       1            | 0           : Peripheral B function
    @       0            | 1           : Peripheral C function
    @       1            | 1           : Peripheral D function
    @

    @ PIOA Peripheral Options
    Macro_PIOA_SwitchToA    PIOA_SwitchToPWMH0, PIOx_P00
    Macro_PIOA_SwitchToB    PIOA_SwitchToTIOA, PIOx_P00
    Macro_PIOA_SwitchToC    PIOA_SwitchToA17, PIOx_P00
    
    Macro_PIOA_SwitchToA    PIOA_SwitchToPWMH1, PIOx_P01
    Macro_PIOA_SwitchToB    PIOA_SwitchToTIOB0, PIOx_P01
    Macro_PIOA_SwitchToC    PIOA_SwitchToA18, PIOx_P01

    Macro_PIOA_SwitchToA    PIOA_SwitchToPWMH2, PIOx_P02
    Macro_PIOA_SwitchToB    PIOA_SwitchToSCK0, PIOx_P02
    Macro_PIOA_SwitchToC    PIOA_SwitchToDATRG, PIOx_P02

    Macro_PIOA_SwitchToA    PIOA_SwitchToTWD0, PIOx_P03
    Macro_PIOA_SwitchToB    PIOA_SwitchToNPCS3, PIOx_P03

    Macro_PIOA_SwitchToA    PIOA_SwitchToTWCK0, PIOx_P04
    Macro_PIOA_SwitchToB    PIOA_SwitchToTCLK0, PIOx_P04

    Macro_PIOA_SwitchToA    PIOA_SwitchToRXD0, PIOx_P05
    Macro_PIOA_SwitchToB    PIOA_SwitchToNPCS3_1, PIOx_P05

    Macro_PIOA_SwitchToA    PIOA_SwitchToTXD0, PIOx_P06
    Macro_PIOA_SwitchToB    PIOA_SwitchToPCK0, PIOx_P06

    Macro_PIOA_SwitchToA    PIOA_SwitchToRTS0, PIOx_P07
    Macro_PIOA_SwitchToB    PIOA_SwitchToPWMH3, PIOx_P07

    Macro_PIOA_SwitchToA    PIOA_SwitchToCTS0, PIOx_P08
    Macro_PIOA_SwitchToB    PIOA_SwitchToADTRG, PIOx_P08

    Macro_PIOA_SwitchToA    PIOA_SwitchToURXD0, PIOx_P09
    Macro_PIOA_SwitchToB    PIOA_SwitchToNPCS1, PIOx_P09
    Macro_PIOA_SwitchToC    PIOA_SwitchToPWMFI0, PIOx_P09

    Macro_PIOA_SwitchToA    PIOA_SwitchToUTXD0, PIOx_P10
    Macro_PIOA_SwitchToB    PIOA_SwitchToNPCS2, PIOx_P10

    Macro_PIOA_SwitchToA    PIOA_SwitchToNPCS0, PIOx_P11
    Macro_PIOA_SwitchToB    PIOA_SwitchToPWMH0_1, PIOx_P11

    Macro_PIOA_SwitchToA    PIOA_SwitchToMISO, PIOx_P12
    Macro_PIOA_SwitchToB    PIOA_SwitchToPWMH1_1, PIOx_P12

    Macro_PIOA_SwitchToA    PIOA_SwitchToMOSI, PIOx_P13
    Macro_PIOA_SwitchToB    PIOA_SwitchToPWMH2_1, PIOx_P13

    Macro_PIOA_SwitchToA    PIOA_SwitchToSPCK, PIOx_P14
    Macro_PIOA_SwitchToB    PIOA_SwitchToPWMH3_1, PIOx_P14

    Macro_PIOA_SwitchToA    PIOA_SwitchToTF, PIOx_P15
    Macro_PIOA_SwitchToB    PIOA_SwitchToTIOA1, PIOx_P15
    Macro_PIOA_SwitchToC    PIOA_SwitchToPWML3, PIOx_P15

    Macro_PIOA_SwitchToA    PIOA_SwitchToTK, PIOx_P16
    Macro_PIOA_SwitchToB    PIOA_SwitchToTIOB1, PIOx_P16
    Macro_PIOA_SwitchToC    PIOA_SwitchToPWML2, PIOx_P16

    Macro_PIOA_SwitchToA    PIOA_SwitchToTD, PIOx_P17
    Macro_PIOA_SwitchToB    PIOA_SwitchToPCK1, PIOx_P17
    Macro_PIOA_SwitchToC    PIOA_SwitchToPWMH3_2, PIOx_P17

    Macro_PIOA_SwitchToA    PIOA_SwitchToRD, PIOx_P18
    Macro_PIOA_SwitchToB    PIOA_SwitchToPCK2, PIOx_P18
    Macro_PIOA_SwitchToC    PIOA_SwitchToA14, PIOx_P18

    Macro_PIOA_SwitchToA    PIOA_SwitchToRK, PIOx_P19
    Macro_PIOA_SwitchToB    PIOA_SwitchToPWML0, PIOx_P19
    Macro_PIOA_SwitchToC    PIOA_SwitchToA15, PIOx_P19

    Macro_PIOA_SwitchToA    PIOA_SwitchToRF, PIOx_P20
    Macro_PIOA_SwitchToB    PIOA_SwitchToPWML1, PIOx_P20
    Macro_PIOA_SwitchToC    PIOA_SwitchToA16, PIOx_P20

    Macro_PIOA_SwitchToA    PIOA_SwitchToRXD1, PIOx_P21
    Macro_PIOA_SwitchToB    PIOA_SwitchToPCK1_1, PIOx_P21

@    Macro_PIOA_SwitchToA    PIOA_SwitchToTXD1, PIOx_P22
@    Macro_PIOA_SwitchToB    PIOA_SwitchToNPCS3_2, PIOx_P22
@    Macro_PIOA_SwitchToC    PIOA_SwitchToNCS2, PIOx_P22

@    Macro_PIOA_SwitchToA    PIOA_SwitchToSCK1, PIOx_P23
@    Macro_PIOA_SwitchToB    PIOA_SwitchToPWMH0_2, PIOx_P23
@    Macro_PIOA_SwitchToC    PIOA_SwitchToA19, PIOx_P23

@    Macro_PIOA_SwitchToA    PIOA_SwitchToRTS1, PIOx_P24
@    Macro_PIOA_SwitchToB    PIOA_SwitchToPWMH1_2, PIOx_P24
@    Macro_PIOA_SwitchToC    PIOA_SwitchToA20, PIOx_P24

@    Macro_PIOA_SwitchToA    PIOA_SwitchToCTS1, PIOx_P25
@    Macro_PIOA_SwitchToB    PIOA_SwitchToPWMH2_2, PIOx_P25
@    Macro_PIOA_SwitchToC    PIOA_SwitchTo23, PIOx_P25

@    Macro_PIOA_SwitchToA    PIOA_SwitchToDCD1, PIOx_P26
@    Macro_PIOA_SwitchToB    PIOA_SwitchToTIOA2, PIOx_P26
@    Macro_PIOA_SwitchToC    PIOA_SwitchToMCDA2, PIOx_P26

@    Macro_PIOA_SwitchToA    PIOA_SwitchToDTR1, PIOx_P27
@    Macro_PIOA_SwitchToB    PIOA_SwitchToTIOB2, PIOx_P27
@    Macro_PIOA_SwitchToC    PIOA_SwitchToMCDA3, PIOx_P27

@    Macro_PIOA_SwitchToA    PIOA_SwitchToDSR1, PIOx_P28
@    Macro_PIOA_SwitchToB    PIOA_SwitchToTCLK1, PIOx_P28
@    Macro_PIOA_SwitchToC    PIOA_SwitchToMCCDA, PIOx_P28

@    Macro_PIOA_SwitchToA    PIOA_SwitchToRI1, PIOx_P29
@    Macro_PIOA_SwitchToB    PIOA_SwitchToTCLK2, PIOx_P29
@    Macro_PIOA_SwitchToC    PIOA_SwitchToMCCK, PIOx_P29

@    Macro_PIOA_SwitchToA    PIOA_SwitchToPWML2_1, PIOx_P30
@    Macro_PIOA_SwitchToB    PIOA_SwitchToNPCS2_1, PIOx_P30
@    Macro_PIOA_SwitchToC    PIOA_SwitchToMCDA0, PIOx_P30

@    Macro_PIOA_SwitchToA    PIOA_SwitchToNPCS1_1, PIOx_P31
    Macro_PIOA_SwitchToB    PIOA_SwitchToPCK2_1, PIOx_P31
@    Macro_PIOA_SwitchToC    PIOA_SwitchToMCDA1, PIOx_P31

    @ PIOB Peripheral Options

    Macro_PIOB_SwitchToA    PIOB_SwitchToPWMH0, PIOx_P00

    Macro_PIOB_SwitchToA    PIOB_SwitchToPWMH1, PIOx_P01

    Macro_PIOB_SwitchToA    PIOB_SwitchToURXD1, PIOx_P02
    Macro_PIOB_SwitchToB    PIOB_SwitchToNPCS2, PIOx_P02

    Macro_PIOB_SwitchToA    PIOB_SwitchToUTXD1, PIOx_P03
    Macro_PIOB_SwitchToB    PIOB_SwitchToPCK2, PIOx_P03

    Macro_PIOB_SwitchToA    PIOB_SwitchToTWD1, PIOx_P04
    Macro_PIOB_SwitchToB    PIOB_SwitchToPWMH2, PIOx_P04

    Macro_PIOB_SwitchToA    PIOB_SwitchToTWCK1, PIOx_P05
    Macro_PIOB_SwitchToB    PIOB_SwitchToPWML0, PIOx_P05

    Macro_PIOB_SwitchToA    PIOB_SwitchToPWML1, PIOx_P12

    Macro_PIOB_SwitchToA    PIOB_SwitchToPWML2, PIOx_P13
    Macro_PIOB_SwitchToB    PIOB_SwitchToPCK0, PIOx_P13

    Macro_PIOB_SwitchToA    PIOB_SwitchToNPCS1, PIOx_P14
    Macro_PIOB_SwitchToB    PIOB_SwitchToPWMH3, PIOx_P14

    .align

    .end
