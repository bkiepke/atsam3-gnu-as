    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/macros.inc"
    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/peripheral.inc"

    @ Macros
@    .macro Macro_ , label, value, flag
@\label:
@    .global     \label
@    .type       \label, %function
@    push        { lr }
@    SetValueWO      PMC_CKGR_MOR, \value
@    VerifyFlagSet   PMC_PMC_SR, \flag
@    pop         { pc }
@    .endm


@    .section .text, "ax"

    @ Register addresses of DACC
    .equ        DACC_BASE, 0x4003C000                                           @ Base register address
    .equ        DACC_DACC_CR, (DACC_BASE + 0x0000)                              @ Address to register Control Register
    .equ        DACC_DACC_MR, (DACC_BASE + 0x0004)                              @ Address to register Mode Register
    .equ        DACC_DACC_CHER, (DACC_BASE + 0x0010)                            @ Address to register Channel Enable Register 
    .equ        DACC_DACC_CHDR, (DACC_BASE + 0x0014)                            @ Address to register Channel Disable Register
    .equ        DACC_DACC_CHSR, (DACC_BASE + 0x0018)                            @ Address to register Channel Status Register
    .equ        DACC_DACC_CDR, (DACC_BASE + 0x0020)                             @ Address to register Conversion Data Register
    .equ        DACC_DACC_IER, (DACC_BASE + 0x0024)                             @ Address to register Interrupt Enable Register
    .equ        DACC_DACC_IDR, (DACC_BASE + 0x0028)                             @ Address to register Interrupt Disable Register
    .equ        DACC_DACC_IMR, (DACC_BASE + 0x002C)                             @ Address to register Interrupt Mask Register
    .equ        DACC_DACC_ISR, (DACC_BASE + 0x0030)                             @ Address to register Interrupt Status Register
    .equ        DACC_DACC_ACR, (DACC_BASE + 0x0094)                             @ Address to register Analog Current Register
    .equ        DACC_DACC_WPMR, (DACC_BASE + 0x00E4)                            @ Address to register Write Protect Mode Register
    .equ        DACC_DACC_WPSR, (DACC_BASE + 0x00E8)                            @ Address to register Write Protect Status Register

    @ Register DACC_CR, write-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | SWRST
    @
    @ SWRST : 0 = No effect.
    @       : 1 = Resets the DACC simulating a hardware reset.
    .equ        DACC_DACC_CR_SWRST, 0x00000001

    @ Register DACC_MR, read-write
    @ 31 30 | 29 28 27 26 25 24 | 23 22 | 21   | 20  | 19 18 | 17 16    | 15 14 13 12 11 10 09 08 | 07 | 06       | 05    | 04   | 03 02 01 | 00
    @ -  -  | STARTUP           | -  -  | MAXS | TAG | -  -  | USER_SEL | REFRESH                 | -  | FASTWKUP | SLEEP | WORD | TRGSEL   | TRGEN
    @
    @ TRGEN : 0 = External trigger mode disabled. DACC in free running mode.
    @       : 1 = External trigger mode enabled.
    @ TRGSEL : 0 = External trigger.
    @        : 1 = TIO Output of the Timer Counter Channel 0.
    @        : 2 = TIO Output of the Timer Counter Channel 1.
    @        : 3 = TIO Output of the Timer Counter Channel 2.
    @        : 4 = PWM Event Line 0.
    @        : 5 = PWM Event Line 1.
    @ WORD : 0 = Half-Word transfer.
    @      : 1 = Word transfer.
    @ SLEEP : 0 = Normal mode.
    @       ; 1 = Sleep mode.
    @ FASTWKUP : 0 = Normal Sleep Mode.
    @          : 1 = Fast Wake up Sleep Mode.
    @ REFRESH : Refresh Period = 1024 * REFRESH / DACC Clock = 1024 * REFRESH / MCK / 2.
    @ USER_SEL : 0 = CHANNEL 0
    @          : 1 = CHANNEL 1
    @ TAG : 0 = Tag selection mode disabled. Using USER_SEL to select the channel for the conversion
    @     : 1 = Tag selection mode enabled.
    @ MAXS : 0 = Normal Mode.
    @      : 1 = Max Speed Mode enabled.
    @ STARTUP : 0 = 0 periods of DAC Clock.
    @         ; 1 = 8 periods of DAC Clock.
    @         : 2 = 16 periods of DAC Clock.
    @         : 3 = 24 periods of DAC Clock.
    @         : 4 = 64 periods of DAC Clock.
    @         : 5 = 80 periods of DAC Clock.
    @         : 6 = 96 periods of DAC Clock.
    @         : 7 = 112 periods of DAC Clock.
    @         : 8 = 512 periods of DAC Clock.
    @         : 9 = 576 periods of DAC Clock.
    @         : 10 = 640 periods of DAC Clock.
    @         : 11 = 704 periods of DAC Clock. 
    @         : 12 = 768 periods of DAC Clock.
    @         : 13 = 832 periods of DAC Clock.
    @         : 14 = 896 periods of DAC Clock. 
    @         : 15 = 960 periods of DAC Clock.
    @
    .equ        DACC_DACC_MR_TRGEN, 0
    .equ        DACC_DACC_MR_TRGSEL, 1
    .equ        DACC_DACC_MR_WORD, 4
    .equ        DACC_DACC_MR_SLEEP, 5
    .equ        DACC_DACC_MR_FASTWKUP, 6
    .equ        DACC_DACC_MR_REFRESH, 8
    .equ        DACC_DACC_MR_USER_SEL, 16
    .equ        DACC_DACC_MR_TAG, 20
    .equ        DACC_DACC_MR_MAXS, 21
    .equ        DACC_DACC_MR_STARTUP, 24

DACC_DACC_MR_Setup:
    .global     DACC_DACC_MR_Setup
    .type       DACC_DACC_MR_Setup, %function
    push        { lr }
    SetValueWO  DACC_DACC_MR, (8 << DACC_DACC_MR_STARTUP) | (1 << DACC_DACC_MR_TAG) | (127 << DACC_DACC_MR_REFRESH)
    pop         { pc }

    @ Register DACC_CHER, write-only
    @ Register DACC_CHDR, write-only
    @ Register DACC_CHSR, read-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 | 01  | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | CH1 | CH0
    @
    @ CH0 : 0 = No effect.
    @     : 1 = Enables Channel 0
    @ CH1 : 0 = No effect.
    @     : 1 = Enables Channel 1
    @
    .equ        DACC_DACC_CHxR_CH0, 0
    .equ        DACC_DACC_CHxR_CH1, 1

DACC_DACC_CHER_Enable:
    .global     DACC_DACC_CHER_Enable
    .type       DACC_DACC_CHER_Enable, %function
    push        { lr }
    SetValueWO  DACC_DACC_CHER, (1 << DACC_DACC_CHxR_CH1) | (1 << DACC_DACC_CHxR_CH0)
    pop         { pc }

    @ Register DACC_CDR, write-only
    @ WORD-Transfer:
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
    @ DATA
    @
    @ HALF-WORD-Transfer:
    @ 31 30 | 29 28   | 27 26 25 24 23 22 21 20 19 18 17 16 | 15 14 | 13 12   | 11 10 09 08 07 06 05 04 03 02 01 00
    @ -  -  | HWH_CHx | HWH_DATA                            | -  -  | HWL_CHx | HWL_DATA

    .equ        DACC_DACC_CDR_DATA_WT, 0

    .equ        DACC_DACC_CDR_DATA_HWTH, 16                                     @ upper half word, bits [31..16]
    .equ        DACC_DACC_CDR_DATA_HWTL, 0                                      @ lower half word, bits [15..00]

    .equ        DACC_DACC_CDR_DATA_CH0, 0x0000                                  @ select channel 0
    .equ        DACC_DACC_CDR_DATA_CH1, 0x1000                                  @ select channel 1

    .equ        DACC_DACC_CDR_DATA_VOLT0, 0x003F                                @ value range [000...FFF]
    .equ        DACC_DACC_CDR_DATA_VOLT1, 0x0100

DACC_DACC_CDR_Convert:
    .global     DACC_DACC_CDR_Convert
    .type       DACC_DACC_CDR_Convert, %function
    push        { lr, r1 }
    SetValueWO_R  DACC_DACC_CDR, r2 @ (((DACC_DACC_CDR_DATA_CH1 | DACC_DACC_CDR_DATA_VOLT1 ) << DACC_DACC_CDR_DATA_HWTH) | ((DACC_DACC_CDR_DATA_CH0 | DACC_DACC_CDR_DATA_VOLT0 ) << DACC_DACC_CDR_DATA_HWTL))
    pop         { r1, pc }


    @ Register DACC_IER, write-only
    @ Register DACC_IDR, write-only
    @ Register DACC_IMR, read-only
    @ Register DACC_ISR, read-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 | 03     | 02    | 01  | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | TXBUFE | ENDTX | EOC | TXRDY
    @
    @ TXRDY : 0 = No effect.
    @       : 1 = Transmit Ready Interrupt.
    @ EOC : 0 = No effect.
    @     : 1 = End of Conversion Interrupt.
    @ ENDTX : 0 = No effect.
    @       : 1 = End of Transmit Buffer Interrupt.
    @ TXBUFE : 0 = No effect.
    @        : 1 = Transmit Buffer Empty Interrupt.
    @
    .equ        DACC_DACC_IxR_TXRDY, 0
    .equ        DACC_DACC_IxR_EOC, 1
    .equ        DACC_DACC_IxR_ENDTX, 2
    .equ        DACC_DACC_IxR_TXBUFE, 3

    @ Register DACC_ACR, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 | 09 08        | 07 06 05 04 | 03 02    | 01 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | IBCTLDACCORE | -  -  -  -  | IBCTLCH1 | IBCTLCH0
    @
    @ IBCTLCHx : Analog Output Current Control.
    @ IBCTLDACCORE: Bias Current Control for DAC Core.
    @
    .equ        DACC_DACC_ACR_IBCTLCH0, 0
    .equ        DACC_DACC_ACR_IBCTLCH1, 1
    .equ        DACC_DACC_ACR_IBCTLDACCORE, 8

    @ Register DACC_WPMR, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 | 07 06 05 04 03 02 01  | 00
    @ WPKEY                                                                   | -  -  -  -  -  -  -   | WPEN 
    @
    @ WPEN : 0 = Disables the Write Protect if WPKEY corresponds to "DAC" (0x444143)
    @      : 1 = Enables the Write Protect if WPKEY corresponds to "DAC" (0x444143)
    @ WPKEY : Write Protect key
    @
    .equ        DACC_WPMR_ENABLE, 0x44414301
    .equ        DACC_WPMR_DISABLE, 0x4441430

DACC_DACC_WPMR_WriteProtectEnable:
    .global     DACC_DACC_WPMR_WriteProtectEnable
    .type       DACC_DACC_WPMR_WriteProtectEnable, %function
    push        { lr }
    SetValueWO  DACC_DACC_WPMR, DACC_WPMR_ENABLE
    pop         { pc }

DACC_DACC_WPMR_WriteProtectDisable:
    .global     DACC_DACC_WPMR_WriteProtectDisable
    .type       DACC_DACC_WPMR_WriteProtectDisable, %function
    push        { lr }
    SetValueWO  DACC_DACC_WPMR, DACC_WPMR_DISABLE
    pop         { pc }

    @ Register DACC_WPSR, read-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 | 15 14 13 12 11 10 09 08 | 07 06 05 04 03 02 01 | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | -  -  -  -  -  -  -  -  | -  -  -  -  -  -  -  | WPROTERR
    @
    @ WPROTADDR : Write protect error address
    @ WPROTERR : Write protect error
    @
    .equ        DACC_DACC_WPSR_WPROTERR, 0
    .equ        DACC_DACC_WPSR_WPROTADDR, 8

    .end
