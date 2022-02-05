    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

    @ TODO Import Macros instead of redefinition

    @ Macro to set a value of write-only register (32-bit)
    .global SetValueWO
    .macro SetValueWO, Register, Value
    ldr         r0, =\Register                                                  @ Prepare access to register
    ldr         r1, =\Value                                                     @ Prepare value to write
    str         r1, [r0]                                                        @ Write value to register
    .endm

    @ Macro to set a value of read-write register (32-bit)
    .global SetValueWR
    .macro SetValueWR, Register, Value
    ldr         r0, =\Register                                                  @ Prepare access to register
    ldr         r1, [r0]                                                        @ Get current value
    ldr         r2, =\Value                                                     @ Set value
    orr         r1, r2   
    str         r1, [r0]                                                        @ Write value to register
    .endm

    @ Macro to clear a value of read-write register (32-bit)
    .global ClearValueWR
    .macro ClearValueWR, Register, Value
    ldr         r0, =\Register                                                  @ Prepare access to register
    ldr         r1, [r0]                                                        @ Get current value
    ldr         r2, =(~\Value)                                                  @ Set value
    and         r1, r2
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

PIOA_SwitchTo_PWMH0:
    .global     PIOA_SwitchTo_PWMH0
    .type       PIOA_SwitchTo_PWMH0, %function
    push        { lr }
    ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P00
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P00
    SetValueWO      PIOA_PIO_PDR, PIOx_P00
    pop         { pc }

PIOA_SwitchTo_TIOA:
    .global     PIOA_SwitchTo_TIOA
    .type       PIOA_SwitchTo_TIOA, %function
    push        { lr }
    SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P00
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P00
    SetValueWO      PIOA_PIO_PDR, PIOx_P00
    pop         { pc }

PIOA_SwitchTo_A17:
    .global     PIOA_SwitchTo_A17
    .type       PIOA_SwitchTo_A17, %function
    push        { lr }
    ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P00
    SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P00
    SetValueWO      PIOA_PIO_PDR, PIOx_P00
    pop         { pc }

PIOA_SwitchTo_PWMH1:
    .global     PIOA_SwitchTo_PWMH1
    .type       PIOA_SwitchTo_PWMH1, %function
    push        { lr }
    ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P01
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P01
    SetValueWO      PIOA_PIO_PDR, PIOx_P01
    pop         { pc }

PIOA_SwitchTo_TIOB0:
    .global     PIOA_SwitchTo_TIOB0
    .type       PIOA_SwitchTo_TIOB0, %function
    push        { lr }
    SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P01
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P01
    SetValueWO      PIOA_PIO_PDR, PIOx_P01
    pop         { pc }

PIOA_SwitchTo_A18:    
    .global     PIOA_SwitchTo_A17
    .type       PIOA_SwitchTo_A17, %function
    push        { lr }
    ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P01
    SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P01
    SetValueWO      PIOA_PIO_PDR, PIOx_P01    
    pop         { pc }

PIOA_SwitchTo_PWMH2:
    .global     PIOA_SwitchTo_PWMH2
    .type       PIOA_SwitchTo_PWMH2, %function
    push        { lr }
    ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P02
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P02
    SetValueWO      PIOA_PIO_PDR, PIOx_P02
    pop         { pc }

PIOA_SwitchTo_SCK0:
    .global     PIOA_SwitchTo_SCK0
    .type       PIOA_SwitchTo_SCK0, %function
    push        { lr }
    SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P02
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P02
    SetValueWO      PIOA_PIO_PDR, PIOx_P02
    pop         { pc }

PIOA_SwitchTo_DATRG:
    .global     PIOA_SwitchTo_DATRG
    .type       PIOA_SwitchTo_DATRG, %function
    push        { lr }
    ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P02
    SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P02
    SetValueWO      PIOA_PIO_PDR, PIOx_P02
    pop         { pc }    

PIOA_SwitchTo_TWD0:
    .global     PIOA_SwitchTo_TWD0
    .type       PIOA_SwitchTo_TWD0, %function
    push        { lr }
    ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P03
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P03
    SetValueWO      PIOA_PIO_PDR, PIOx_P03
    pop         { pc }

PIOA_SwitchTo_NPCS3:    
    .global     PIOA_SwitchTo_NPCS3
    .type       PIOA_SwitchTo_NPCS3, %function
    push        { lr }
    SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P03
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P03
    SetValueWO      PIOA_PIO_PDR, PIOx_P03
    pop         { pc }

PIOA_SwitchTo_TWCK0:
    .global     PIOA_SwitchTo_TWCK0
    .type       PIOA_SwitchTo_TWCK0, %function
    push        { lr }
    ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P04
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P04
    SetValueWO      PIOA_PIO_PDR, PIOx_P04
    pop         { pc }

PIOA_SwitchTo_TCLK0:    
    .global     PIOA_SwitchTo_TCLK0
    .type       PIOA_SwitchTo_TCLK0, %function
    push        { lr }
    SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P04
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P04
    SetValueWO      PIOA_PIO_PDR, PIOx_P04
    pop         { pc }

PIOA_SwitchTo_RXD0:
    .global     PIOA_SwitchTo_RXD0
    .type       PIOA_SwitchTo_RXD0, %function
    push        { lr }
    ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P05
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P05
    SetValueWO      PIOA_PIO_PDR, PIOx_P05
    pop         { pc }

PIOA_SwitchTo_NPCS3_1:    
    .global     PIOA_SwitchTo_NPCS3_1
    .type       PIOA_SwitchTo_NPCS3_1, %function
    push        { lr }
    SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P05
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P05
    SetValueWO      PIOA_PIO_PDR, PIOx_P05
    pop         { pc }

PIOA_SwitchTo_TXD0:
    .global     PIOA_SwitchTo_TXD0
    .type       PIOA_SwitchTo_TXD0, %function
    push        { lr }
    ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P06
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P06
    SetValueWO      PIOA_PIO_PDR, PIOx_P06
    pop         { pc }

PIOA_SwitchTo_PCK0:
    .global     PIOA_SwitchTo_PCK0
    .type       PIOA_SwitchTo_PCK0, %function
    push        { lr }
    SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P06
    ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P06
    SetValueWO      PIOA_PIO_PDR, PIOx_P06
    pop         { pc }

@ PIOA_SwitchTo_RTS0:
@     .global     PIOA_SwitchTo_RTS0
@     .type       PIOA_SwitchTo_RTS0, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P07
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P07
@     SetValueWO      PIOA_PIO_PDR, PIOx_P07
@     pop         { pc }

@ PIOA_SwitchTo_PWMH3:
@     .global     PIOA_SwitchTo_PWMH3
@     .type       PIOA_SwitchTo_PWMH3, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P07
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P07
@     SetValueWO      PIOA_PIO_PDR, PIOx_P07
@     pop         { pc }    

@ PIOA_SwitchTo_CTS0:
@     .global     PIOA_SwitchTo_CTS0
@     .type       PIOA_SwitchTo_CTS0, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P08
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P08
@     SetValueWO      PIOA_PIO_PDR, PIOx_P08
@     pop         { pc }

@ PIOA_SwitchTo_ADTRG:
@     .global     PIOA_SwitchTo_ADTRG
@     .type       PIOA_SwitchTo_ADTRG, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P08
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P08
@     SetValueWO      PIOA_PIO_PDR, PIOx_P08
@     pop         { pc }    

@ PIOA_SwitchTo_URXD0:
@     .global     PIOA_SwitchTo_URXD0
@     .type       PIOA_SwitchTo_URXD0, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P09
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P09
@     SetValueWO      PIOA_PIO_PDR, PIOx_P09
@     pop         { pc }

@ PIOA_SwitchTo_NPCS1:
@     .global     PIOA_SwitchTo_NPCS1
@     .type       PIOA_SwitchTo_NPCS1, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P09
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P09
@     SetValueWO      PIOA_PIO_PDR, PIOx_P09
@     pop         { pc }    

@ PIOA_SwitchTo_PWMFI0: 
@     .global     PIOA_SwitchTo_PWMFI0
@     .type       PIOA_SwitchTo_PWMFI0, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P09
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P09
@     SetValueWO      PIOA_PIO_PDR, PIOx_P09
@     pop         { pc }   

@ PIOA_SwitchTo_UTXD0:
@     .global     PIOA_SwitchTo_UTXD0
@     .type       PIOA_SwitchTo_UTXD0, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P10
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P10
@     SetValueWO      PIOA_PIO_PDR, PIOx_P10
@     pop         { pc }

@ PIOA_SwitchTo_NPCS2:
@     .global     PIOA_SwitchTo_NPCS2
@     .type       PIOA_SwitchTo_NPCS2, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P10
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P10
@     SetValueWO      PIOA_PIO_PDR, PIOx_P10
@     pop         { pc }    

@ PIOA_SwitchTo_NPCS0:
@     .global     PIOA_SwitchTo_NPCS0
@     .type       PIOA_SwitchTo_NPCS0, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P11
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P11
@     SetValueWO      PIOA_PIO_PDR, PIOx_P11
@     pop         { pc }

@ PIOA_SwitchTo_PWMH0_1: 
@     .global     PIOA_SwitchTo_PWMH0_1
@     .type       PIOA_SwitchTo_PWMH0_1, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P11
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P11
@     SetValueWO      PIOA_PIO_PDR, PIOx_P11
@     pop         { pc }   

@ PIOA_SwitchTo_MISO:
@     .global     PIOA_SwitchTo_MISO
@     .type       PIOA_SwitchTo_MISO, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P12
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P12
@     SetValueWO      PIOA_PIO_PDR, PIOx_P12
@     pop         { pc }

@ PIOA_SwitchTo_PWMH1_1:
@     .global     PIOA_SwitchTo_PWMH1_1
@     .type       PIOA_SwitchTo_PWMH1_1, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P12
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P12
@     SetValueWO      PIOA_PIO_PDR, PIOx_P12
@     pop         { pc }

@ PIOA_SwitchTo_MOSI:
@     .global     PIOA_SwitchTo_MOSI
@     .type       PIOA_SwitchTo_MOSI, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P13
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P13
@     SetValueWO      PIOA_PIO_PDR, PIOx_P13
@     pop         { pc }

@ PIOA_SwitchTo_PWMH2_1:
@     .global     PIOA_SwitchTo_PWMH2_1
@     .type       PIOA_SwitchTo_PWMH2_1, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P13
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P13
@     SetValueWO      PIOA_PIO_PDR, PIOx_P13
@     pop         { pc }

@ PIOA_SwitchTo_SPCK:
@     .global     PIOA_SwitchTo_SPCK
@     .type       PIOA_SwitchTo_SPCK, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P14
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P14
@     SetValueWO      PIOA_PIO_PDR, PIOx_P14
@     pop         { pc }

@ PIOA_SwitchTo_PWMH3_1:  
@     .global     PIOA_SwitchTo_PWMH3_1
@     .type       PIOA_SwitchTo_PWMH3_1, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P14
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P14
@     SetValueWO      PIOA_PIO_PDR, PIOx_P14
@     pop         { pc }  

@ PIOA_SwitchTo_TF:
@     .global     PIOA_SwitchTo_TF
@     .type       PIOA_SwitchTo_TF, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P15
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P15
@     SetValueWO      PIOA_PIO_PDR, PIOx_P15
@     pop         { pc }

@ PIOA_SwitchTo_TIOA1:    
@     .global     PIOA_SwitchTo_TIOA1
@     .type       PIOA_SwitchTo_TIOA1, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P15
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P15
@     SetValueWO      PIOA_PIO_PDR, PIOx_P15
@     pop         { pc }

@ PIOA_SwitchTo_PWML3:
@     .global     PIOA_SwitchTo_PWML3
@     .type       PIOA_SwitchTo_PWML3, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P15
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P15
@     SetValueWO      PIOA_PIO_PDR, PIOx_P15
@     pop         { pc }

@ PIOA_SwitchTo_TK:
@     .global     PIOA_SwitchTo_TK
@     .type       PIOA_SwitchTo_TK, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P16
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P16
@     SetValueWO      PIOA_PIO_PDR, PIOx_P16
@     pop         { pc }

@ PIOA_SwitchTo_TIOB1:
@     .global     PIOA_SwitchTo_TIOB1
@     .type       PIOA_SwitchTo_TIOB1, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P16
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P16
@     SetValueWO      PIOA_PIO_PDR, PIOx_P16
@     pop         { pc }

@ PIOA_SwitchTo_PWML2:
@     .global     PIOA_SwitchTo_PWML2
@     .type       PIOA_SwitchTo_PWML2, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P16
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P16
@     SetValueWO      PIOA_PIO_PDR, PIOx_P16
@     pop         { pc }

@ PIOA_SwitchTo_TD:
@     .global     PIOA_SwitchTo_TD
@     .type       PIOA_SwitchTo_TD, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P17
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P17
@     SetValueWO      PIOA_PIO_PDR, PIOx_P17
@     pop         { pc }

@ PIOA_SwitchTo_PCK1:
@     .global     PIOA_SwitchTo_PCK1
@     .type       PIOA_SwitchTo_PCK1, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P17
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P17
@     SetValueWO      PIOA_PIO_PDR, PIOx_P17
@     pop         { pc }

@ PIOA_SwitchTo_PWMH3_2:
@     .global     PIOA_SwitchTo_PWMH3_2
@     .type       PIOA_SwitchTo_PWMH3_2, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P17
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P17
@     SetValueWO      PIOA_PIO_PDR, PIOx_P17
@     pop         { pc }

@ PIOA_SwitchTo_RD:
@     .global     PIOA_SwitchTo_RD
@     .type       PIOA_SwitchTo_RD, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P18
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P18
@     SetValueWO      PIOA_PIO_PDR, PIOx_P18
@     pop         { pc }

@ PIOA_SwitchTo_PCK2:
@     .global     PIOA_SwitchTo_PCK2
@     .type       PIOA_SwitchTo_PCK2, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P18
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P18
@     SetValueWO      PIOA_PIO_PDR, PIOx_P18
@     pop         { pc }

@ PIOA_SwitchTo_A14:
@     .global     PIOA_SwitchTo_A14
@     .type       PIOA_SwitchTo_A14, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P18
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P18
@     SetValueWO      PIOA_PIO_PDR, PIOx_P18
@     pop         { pc }

@ PIOA_SwitchTo_RK:
@     .global     PIOA_SwitchTo_RK
@     .type       PIOA_SwitchTo_RK, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P19
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P19
@     SetValueWO      PIOA_PIO_PDR, PIOx_P19
@     pop         { pc }

@ PIOA_SwitchTo_PWML0:
@     .global     PIOA_SwitchTo_PWML0
@     .type       PIOA_SwitchTo_PWML0, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P19
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P19
@     SetValueWO      PIOA_PIO_PDR, PIOx_P19
@     pop         { pc }

@ PIOA_SwitchTo_A15:
@     .global     PIOA_SwitchTo_A15
@     .type       PIOA_SwitchTo_A15, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P19
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P19
@     SetValueWO      PIOA_PIO_PDR, PIOx_P19
@     pop         { pc }

@ PIOA_SwitchTo_RF:
@     .global     PIOA_SwitchTo_RF
@     .type       PIOA_SwitchTo_RF, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P20
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P20
@     SetValueWO      PIOA_PIO_PDR, PIOx_P20
@     pop         { pc }

@ PIOA_SwitchTo_PWML1:
@     .global     PIOA_SwitchTo_PWML1
@     .type       PIOA_SwitchTo_PWML1, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P20
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P20
@     SetValueWO      PIOA_PIO_PDR, PIOx_P20
@     pop         { pc }

@ PIOA_SwitchTo_A16:
@     .global     PIOA_SwitchTo_A16
@     .type       PIOA_SwitchTo_A16, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P20
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P20
@     SetValueWO      PIOA_PIO_PDR, PIOx_P20
@     pop         { pc }

@ PIOA_SwitchTo_RXD1:
@     .global     PIOA_SwitchTo_RXD1
@     .type       PIOA_SwitchTo_RXD1, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P21
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P21
@     SetValueWO      PIOA_PIO_PDR, PIOx_P21
@     pop         { pc }

@ PIOA_SwitchTo_PCK1_1:
@     .global     PIOA_SwitchTo_PCK1_1
@     .type       PIOA_SwitchTo_PCK1_1, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P21
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P21
@     SetValueWO      PIOA_PIO_PDR, PIOx_P21
@     pop         { pc }

@ PIOA_SwitchTo_TXD1:
@     .global     PIOA_SwitchTo_TXD1
@     .type       PIOA_SwitchTo_TXD1, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P22
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P22
@     SetValueWO      PIOA_PIO_PDR, PIOx_P22
@     pop         { pc }

@ PIOA_SwitchTo_NPCS3_2:
@     .global     PIOA_SwitchTo_NPCS3_2
@     .type       PIOA_SwitchTo_NPCS3_2, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P22
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P22
@     SetValueWO      PIOA_PIO_PDR, PIOx_P22
@     pop         { pc }

@ PIOA_SwitchTo_NCS2:
@     .global     PIOA_SwitchTo_NCS2
@     .type       PIOA_SwitchTo_NCS2, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P22
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P22
@     SetValueWO      PIOA_PIO_PDR, PIOx_P22
@     pop         { pc }

@ PIOA_SwitchTo_SCK1:
@     .global     PIOA_SwitchTo_SCK1
@     .type       PIOA_SwitchTo_SCK1, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P23
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P23
@     SetValueWO      PIOA_PIO_PDR, PIOx_P23
@     pop         { pc }

@ PIOA_SwitchTo_PWMH0_2:
@     .global     PIOA_SwitchTo_PWMH0_2
@     .type       PIOA_SwitchTo_PWMH0_2, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P23
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P23
@     SetValueWO      PIOA_PIO_PDR, PIOx_P23
@     pop         { pc }

@ PIOA_SwitchTo_A19:
@     .global     PIOA_SwitchTo_A19
@     .type       PIOA_SwitchTo_A19, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P23
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P23
@     SetValueWO      PIOA_PIO_PDR, PIOx_P23
@     pop         { pc }

@ PIOA_SwitchTo_RTS1:
@     .global     PIOA_SwitchTo_RTS1
@     .type       PIOA_SwitchTo_RTS1, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P24
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P24
@     SetValueWO      PIOA_PIO_PDR, PIOx_P24
@     pop         { pc }

@ PIOA_SwitchTo_PWMH1_2:
@     .global     PIOA_SwitchTo_PWMH1_2
@     .type       PIOA_SwitchTo_PWMH1_2, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P24
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P24
@     SetValueWO      PIOA_PIO_PDR, PIOx_P24
@     pop         { pc }

@ PIOA_SwitchTo_A20:
@     .global     PIOA_SwitchTo_A20
@     .type       PIOA_SwitchTo_A20, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P24
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P24
@     SetValueWO      PIOA_PIO_PDR, PIOx_P24
@     pop         { pc }

@ PIOA_SwitchTo_CTS1:
@     .global     PIOA_SwitchTo_CTS1
@     .type       PIOA_SwitchTo_CTS1, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P25
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P25
@     SetValueWO      PIOA_PIO_PDR, PIOx_P25
@     pop         { pc }

@ PIOA_SwitchTo_PWMH2_2:
@     .global     PIOA_SwitchTo_PWMH2_2
@     .type       PIOA_SwitchTo_PWMH2_2, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P25
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P25
@     SetValueWO      PIOA_PIO_PDR, PIOx_P25
@     pop         { pc }

@ PIOA_SwitchTo_23:
@     .global     PIOA_SwitchTo_A23
@     .type       PIOA_SwitchTo_A23, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P25
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P25
@     SetValueWO      PIOA_PIO_PDR, PIOx_P25
@     pop         { pc }

@ PIOA_SwitchTo_DCD1:
@     .global     PIOA_SwitchTo_DCD1
@     .type       PIOA_SwitchTo_DCD1, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P26
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P26
@     SetValueWO      PIOA_PIO_PDR, PIOx_P26
@     pop         { pc }

@ PIOA_SwitchTo_TIOA2:
@     .global     PIOA_SwitchTo_TIOA2
@     .type       PIOA_SwitchTo_TIOA2, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P26
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P26
@     SetValueWO      PIOA_PIO_PDR, PIOx_P26
@     pop         { pc }

@ PIOA_SwitchTo_MCDA2:
@     .global     PIOA_SwitchTo_MCDA2
@     .type       PIOA_SwitchTo_MCDA2, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P26
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P26
@     SetValueWO      PIOA_PIO_PDR, PIOx_P26
@     pop         { pc }

@ PIOA_SwitchTo_DTR1:
@     .global     PIOA_SwitchTo_DTR1
@     .type       PIOA_SwitchTo_DTR1, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P27
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P27
@     SetValueWO      PIOA_PIO_PDR, PIOx_P27
@     pop         { pc }

@ PIOA_SwitchTo_TIOB2:
@     .global     PIOA_SwitchTo_TIOB2
@     .type       PIOA_SwitchTo_TIOB2, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P27
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P27
@     SetValueWO      PIOA_PIO_PDR, PIOx_P27
@     pop         { pc }

@ PIOA_SwitchTo_MCDA3:
@     .global     PIOA_SwitchTo_MCDA3
@     .type       PIOA_SwitchTo_MCDA3, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P27
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P27
@     SetValueWO      PIOA_PIO_PDR, PIOx_P27
@     pop         { pc }

@ PIOA_SwitchTo_DSR1:
@     .global     PIOA_SwitchTo_DSR1
@     .type       PIOA_SwitchTo_DSR1, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P28
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P28
@     SetValueWO      PIOA_PIO_PDR, PIOx_P28
@     pop         { pc }

@ PIOA_SwitchTo_TCLK1:
@     .global     PIOA_SwitchTo_TCLK1
@     .type       PIOA_SwitchTo_TCLK1, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P28
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P28
@     SetValueWO      PIOA_PIO_PDR, PIOx_P28
@     pop         { pc }

@ PIOA_SwitchTo_MCCDA:
@     .global     PIOA_SwitchTo_MCCDA
@     .type       PIOA_SwitchTo_MCCDA, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P28
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P28
@     SetValueWO      PIOA_PIO_PDR, PIOx_P28
@     pop         { pc }

@ PIOA_SwitchTo_RI1:
@     .global     PIOA_SwitchTo_RI1
@     .type       PIOA_SwitchTo_RI1, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P29
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P29
@     SetValueWO      PIOA_PIO_PDR, PIOx_P29
@     pop         { pc }

@ PIOA_SwitchTo_TCLK2:
@     .global     PIOA_SwitchTo_TCLK2
@     .type       PIOA_SwitchTo_TCLK2, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P29
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P29
@     SetValueWO      PIOA_PIO_PDR, PIOx_P29
@     pop         { pc }

@ PIOA_SwitchTo_MCCK:
@     .global     PIOA_SwitchTo_MCCK
@     .type       PIOA_SwitchTo_MCCK, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P29
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P29
@     SetValueWO      PIOA_PIO_PDR, PIOx_P29
@     pop         { pc }

@ PIOA_SwitchTo_PWML2_1:
@     .global     PIOA_SwitchTo_PWML2_1
@     .type       PIOA_SwitchTo_PWML2_1, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P30
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P30
@     SetValueWO      PIOA_PIO_PDR, PIOx_P30
@     pop         { pc }

@ PIOA_SwitchTo_NPCS2_1:
@     .global     PIOA_SwitchTo_NPCS2_1
@     .type       PIOA_SwitchTo_NPCS2_1, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P30
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P30
@     SetValueWO      PIOA_PIO_PDR, PIOx_P30
@     pop         { pc }

@ PIOA_SwitchTo_MCDA0:
@     .global     PIOA_SwitchTo_MCDA0
@     .type       PIOA_SwitchTo_MCDA0, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P30
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P30
@     SetValueWO      PIOA_PIO_PDR, PIOx_P30
@     pop         { pc }

@ PIOA_SwitchTo_NPCS1_1:
@     .global     PIOA_SwitchTo_NPCS1_1
@     .type       PIOA_SwitchTo_NPCS1_1, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P31
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P31
@     SetValueWO      PIOA_PIO_PDR, PIOx_P31
@     pop         { pc }

@ PIOA_SwitchTo_PCK2_1:
@     .global     PIOA_SwitchTo_PCK2_1
@     .type       PIOA_SwitchTo_PCK2_1, %function
@     push        { lr }
@     SetValueWR      PIOA_PIO_ABCDSR1, PIOx_P31
@     ClearValueWR    PIOA_PIO_ABCDSR2, PIOx_P31
@     SetValueWO      PIOA_PIO_PDR, PIOx_P31
@     pop         { pc }

@ PIOA_SwitchTo_MCDA1:
@     .global     PIOA_SwitchTo_MCDA1
@     .type       PIOA_SwitchTo_MCDA1, %function
@     push        { lr }
@     ClearValueWR    PIOA_PIO_ABCDSR1, PIOx_P31
@     SetValueWR      PIOA_PIO_ABCDSR2, PIOx_P31
@     SetValueWO      PIOA_PIO_PDR, PIOx_P31
@     pop         { pc }

@     @ PIOB Peripheral Options

@ PIOB_SwitchTo_PWMH0:
@     .global     PIOB_SwitchTo_PWMH0
@     .type       PIOB_SwitchTo_PWMH0, %function
@     push        { lr }
@     ClearValueWR    PIOB_PIO_ABCDSR1, PIOx_P00
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P00
@     SetValueWO      PIOB_PIO_PDR, PIOx_P00
@     pop         { pc }

@ PIOB_SwitchTo_PWMH1:
@     .global     PIOB_SwitchTo_PWMH1
@     .type       PIOB_SwitchTo_PWMH1, %function
@     push        { lr }
@     ClearValueWR    PIOB_PIO_ABCDSR1, PIOx_P01
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P01
@     SetValueWO      PIOB_PIO_PDR, PIOx_P01
@     pop         { pc }

@ PIOB_SwitchTo_URXD1:
@     .global     PIOB_SwitchTo_URXD1
@     .type       PIOB_SwitchTo_URXD1, %function
@     push        { lr }
@     ClearValueWR    PIOB_PIO_ABCDSR1, PIOx_P02
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P02
@     SetValueWO      PIOB_PIO_PDR, PIOx_P02
@     pop         { pc }

@ PIOB_SwitchTo_NPCS2:
@     .global     PIOB_SwitchTo_NPCS2
@     .type       PIOB_SwitchTo_NPCS2, %function
@     push        { lr }
@     SetValueWR      PIOB_PIO_ABCDSR1, PIOx_P02
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P02
@     SetValueWO      PIOB_PIO_PDR, PIOx_P02
@     pop         { pc }

@ PIOB_SwitchTo_UTXD1:
@     .global     PIOB_SwitchTo_UTXD1
@     .type       PIOB_SwitchTo_UTXD1, %function
@     push        { lr }
@     ClearValueWR    PIOB_PIO_ABCDSR1, PIOx_P03
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P03
@     SetValueWO      PIOB_PIO_PDR, PIOx_P03
@     pop         { pc }

@ PIOB_SwitchTo_PCK2:
@     .global     PIOB_SwitchTo_PCK2
@     .type       PIOB_SwitchTo_PCK2, %function
@     push        { lr }
@     SetValueWR      PIOB_PIO_ABCDSR1, PIOx_P03
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P03
@     SetValueWO      PIOB_PIO_PDR, PIOx_P03
@     pop         { pc }

@ PIOB_SwitchTo_TWD1:
@     .global     PIOB_SwitchTo_TWD1
@     .type       PIOB_SwitchTo_TWD1, %function
@     push        { lr }
@     ClearValueWR    PIOB_PIO_ABCDSR1, PIOx_P04
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P04
@     SetValueWO      PIOB_PIO_PDR, PIOx_P04
@     pop         { pc }

@ PIOB_SwitchTo_PWMH2:
@     .global     PIOB_SwitchTo_PWMH2
@     .type       PIOB_SwitchTo_PWMH2, %function
@     push        { lr }
@     SetValueWR      PIOB_PIO_ABCDSR1, PIOx_P04
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P04
@     SetValueWO      PIOB_PIO_PDR, PIOx_P04
@     pop         { pc }

@ PIOB_SwitchTo_TWCK1:
@     .global     PIOB_SwitchTo_TWCK1
@     .type       PIOB_SwitchTo_TWCK1, %function
@     push        { lr }
@     ClearValueWR    PIOB_PIO_ABCDSR1, PIOx_P05
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P05
@     SetValueWO      PIOB_PIO_PDR, PIOx_P05
@     pop         { pc }

@ PIOB_SwitchTo_PWML0:
@     .global     PIOB_SwitchTo_PWML0
@     .type       PIOB_SwitchTo_PWML0, %function
@     push        { lr }
@     SetValueWR      PIOB_PIO_ABCDSR1, PIOx_P05
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P05
@     SetValueWO      PIOB_PIO_PDR, PIOx_P05    
@     pop         { pc }

@ PIOB_SwitchTo_PWML1:
@     .global     PIOB_SwitchTo_PWML1
@     .type       PIOB_SwitchTo_PWML1, %function
@     push        { lr }
@     ClearValueWR    PIOB_PIO_ABCDSR1, PIOx_P12
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P12
@     SetValueWO      PIOB_PIO_PDR, PIOx_P12    
@     pop         { pc }

@ PIOB_SwitchTo_PWML2:
@     .global     PIOB_SwitchTo_PWML2
@     .type       PIOB_SwitchTo_PWML2, %function
@     push        { lr }
@     ClearValueWR    PIOB_PIO_ABCDSR1, PIOx_P13
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P13
@     SetValueWO      PIOB_PIO_PDR, PIOx_P13    
@     pop         { pc }

@ PIOB_SwitchTo_PCK0:
@     .global     PIOB_SwitchTo_PCK0
@     .type       PIOB_SwitchTo_PCK0, %function
@     push        { lr }
@     SetValueWR      PIOB_PIO_ABCDSR1, PIOx_P13
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P13
@     SetValueWO      PIOB_PIO_PDR, PIOx_P13    
@     pop         { pc }

@ PIOB_SwitchTo_NPCS1:
@     .global     PIOB_SwitchTo_NPCS1
@     .type       PIOB_SwitchTo_NPCS1, %function
@     push        { lr }
@     ClearValueWR    PIOB_PIO_ABCDSR1, PIOx_P14
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P14
@     SetValueWO      PIOB_PIO_PDR, PIOx_P14    
@     pop         { pc }

@ PIOB_SwitchTo_PWMH3:
@     .global     PIOB_SwitchTo_PWMH3
@     .type       PIOB_SwitchTo_PWMH3, %function
@     push        { lr }
@     SetValueWR      PIOB_PIO_ABCDSR1, PIOx_P14
@     ClearValueWR    PIOB_PIO_ABCDSR2, PIOx_P14
@     SetValueWO      PIOB_PIO_PDR, PIOx_P14    
@     pop         { pc }

    .end
