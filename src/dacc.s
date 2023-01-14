    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

    .include "./macros.inc"
    @.include "./peripheral.inc"
    .include "./pdc.inc"

    @ Variables in RAM of subsystem
    .section .data
    
    @ Single access
    .global DACC_CH0_DATA
    DACC_CH0_DATA: .space 2 @ Reserve 2 bytes
    .global DACC_CH1_DATA
    DACC_CH1_DATA: .space 2 @ Reserve 2 bytes

    @ DMA-based access
    @ Note: The DACC provides two channels, so the buffer may contain tagged values.
    @       Therefore values within buffer need to have the following structure, including the channel tag:
    @           0x0<value channel 1>0<value channel 1>  -> channel 1 is used only
    @       or  0x1<value channel 2>0<value channel 1>  -> channel 1 and channel 2 is used
    @       or  0x0<value channel 1>1<value channel 2>  -> channel 1 and channel 2 is used
    @       or  0x1<value channel 2>1<value channel 2>  -> channel 2 is used only
    @       <value channel 2> in the range [000..FFF]
    @       <value channel 1> in the range [000..FFF]
    @
    .global DACC_DMA_DATA_POINTER
    DACC_DMA_DATA_POINTER: .space 4 @ Reserve 4 bytes for address of data
    .global DACC_DMA_DATA_AMOUNT
    DACC_DMA_DATA_AMOUNT: .space 2 @ Reserve 2 bytes for amount of data

    .section .text, "ax"

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

    @ Register addresses of DACC PDC (DACC Peripheral direct memory access controller)
    .equ        DACC_PDC_PERIPH_TPR, (DACC_BASE + 0x0108)                       @ Address to register Transmit Pointer Register
    .equ        DACC_PDC_PERIPH_TCR, (DACC_BASE + 0x010C)                       @ Address to register Transmit Counter Register
    .equ        DACC_PDC_PERIPH_TNPR, (DACC_BASE + 0x0118)                      @ Address to register Transmit Next Pointer Register
    .equ        DACC_PDC_PERIPH_TNCR, (DACC_BASE + 0x011C)                      @ Address to register Transmit Next Counter Register
    .equ        DACC_PDC_PERIPH_PTCR, (DACC_BASE + 0x0120)                      @ Address to register Transfer Control Register
    .equ        DACC_PDC_PERIPH_PTSR, (DACC_BASE + 0x0124)                      @ Address to register Transfer Status Register

    @ Register DACC_CR, write-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | SWRST
    @
    @ SWRST : 0 = No effect.
    @       : 1 = Resets the DACC simulating a hardware reset.
    .equ        DACC_DACC_CR_SWRST, 0x00000001

DACC_DACC_CR_Reset:
    .global     DACC_DACC_CR_Reset
    .type       DACC_DACC_CR_Reset, %function
    push        { lr }
    RegisterSetValueWO  DACC_DACC_CR, DACC_DACC_CR_SWRST
    pop         { pc }



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
    @ STARTUP : 16 = 1024 periods of DAC Clock.
    @         ; 17 = 1088 periods of DAC Clock.
    @         : 18 = 1152 periods of DAC Clock.
    @         : 19 = 1216 periods of DAC Clock.
    @         : 20 = 1280 periods of DAC Clock.
    @         : 21 = 1344 periods of DAC Clock.
    @         : 22 = 1408 periods of DAC Clock.
    @         : 23 = 1472 periods of DAC Clock.
    @         : 24 = 1536 periods of DAC Clock.
    @         : 25 = 1600 periods of DAC Clock.
    @         : 26 = 1664 periods of DAC Clock.
    @         : 27 = 1728 periods of DAC Clock.
    @         : 28 = 1792 periods of DAC Clock.
    @         : 29 = 1856 periods of DAC Clock.
    @         : 30 = 1920 periods of DAC Clock.
    @         : 31 = 1984 periods of DAC Clock.
    @ STARTUP : 32 = 2048 periods of DAC Clock.
    @         ; 33 = 2112 periods of DAC Clock.
    @         : 34 = 2176 periods of DAC Clock.
    @         : 35 = 2240 periods of DAC Clock.
    @         : 36 = 2304 periods of DAC Clock.
    @         : 37 = 2368 periods of DAC Clock.
    @         : 38 = 2432 periods of DAC Clock.
    @         : 39 = 2496 periods of DAC Clock.
    @         : 40 = 2560 periods of DAC Clock.
    @         : 41 = 2624 periods of DAC Clock.
    @         : 42 = 2688 periods of DAC Clock.
    @         : 43 = 2752 periods of DAC Clock.
    @         : 44 = 2816 periods of DAC Clock.
    @         : 45 = 2880 periods of DAC Clock.
    @         : 46 = 2944 periods of DAC Clock.
    @         : 47 = 3008 periods of DAC Clock.
    @ STARTUP : 48 = 3072 periods of DAC Clock.
    @         ; 49 = 3136 periods of DAC Clock.
    @         : 50 = 3200 periods of DAC Clock.
    @         : 51 = 3264 periods of DAC Clock.
    @         : 52 = 3328 periods of DAC Clock.
    @         : 53 = 3392 periods of DAC Clock.
    @         : 54 = 3456 periods of DAC Clock.
    @         : 55 = 3520 periods of DAC Clock.
    @         : 56 = 3584 periods of DAC Clock.
    @         : 57 = 3648 periods of DAC Clock.
    @         : 58 = 3712 periods of DAC Clock.
    @         : 59 = 3776 periods of DAC Clock.
    @         : 60 = 3840 periods of DAC Clock.
    @         : 61 = 3904 periods of DAC Clock.
    @         : 62 = 3968 periods of DAC Clock.
    @         : 63 = 4032 periods of DAC Clock.
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
@    .global     PMC_PMC_PCERO_PeripheralEnable
@    bl          PMC_PMC_PCERO_PeripheralEnable

    .global     DACC_DACC_MR_Setup
    .type       DACC_DACC_MR_Setup, %function
    push        { lr }
    RegisterSetValueWO  DACC_DACC_MR, (30 << DACC_DACC_MR_STARTUP) | (1 << DACC_DACC_MR_TAG) | (1 << DACC_DACC_MR_REFRESH) | (1 << DACC_DACC_MR_WORD)
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
    RegisterSetValueWO  DACC_DACC_CHER, (1 << DACC_DACC_CHxR_CH1) | (1 << DACC_DACC_CHxR_CH0)
    pop         { pc }

    @ Register DACC_CDR, write-only
    @ WORD-Transfer:
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
    @ DATA
    @
    @ HALF-WORD-Transfer:
    @ 31 30 | 29 28   | 27 26 25 24 23 22 21 20 19 18 17 16 | 15 14 | 13 12   | 11 10 09 08 07 06 05 04 03 02 01 00
    @ -  -  | HWH_CHx | HWH_DATA                            | -  -  | HWL_CHx | HWL_DATA

    .equ        DACC_DACC_CDR_DATA_HWTH, 16                                     @ upper half word, bits [31..16]
    .equ        DACC_DACC_CDR_DATA_HWTL, 0                                      @ lower half word, bits [15..00]

    .equ        DACC_DACC_CDR_DATA_CH0, 0x0000                                  @ select channel 0
    .equ        DACC_DACC_CDR_DATA_CH1, 0x1000                                  @ select channel 1

    .equ        DACC_DACC_CDR_DATA_MASK, 0x0FFF0FFF                             @ value range [000...FFF]
    .equ        DACC_DACC_CDR_DATA_CHANNELS, 0x10000000

DACC_DACC_CDR_Convert:
    @ r0 : Register for addresses
    @ r1 : Register for values
    @ r2 : Register for constants
    .global     DACC_DACC_CDR_Convert
    .type       DACC_DACC_CDR_Convert, %function
    push        { r0-r2, lr }
    RegisterVerifyFlagIsSet DACC_DACC_ISR, DACC_DACC_IxR_TXRDY
    ldr         r0, =DACC_CH1_DATA
    ldr         r1, [r0]
    lsl         r1, r1, #DACC_DACC_CDR_DATA_HWTH
    ldr         r0, =DACC_CH0_DATA
    ldr         r1, [r0]
    ldr         r2, =DACC_DACC_CDR_DATA_MASK
    ands        r1, r1, r2
    ldr         r2, =DACC_DACC_CDR_DATA_CHANNELS
    orrs        r1, r1, r2
    ldr         r0, =DACC_DACC_CDR                                              @ Prepare access to register
    str         r1, [r0]                                                        @ Write value to register
    pop         { r0-r2, pc }


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
    .equ        DACC_DACC_IxR_TXRDY, 1
    .equ        DACC_DACC_IxR_EOC, 2
    .equ        DACC_DACC_IxR_ENDTX, 4
    .equ        DACC_DACC_IxR_TXBUFE, 8
DACC_DACC_IER_Enable:
    .global     DACC_DACC_IER_Enable
    .type       DACC_DACC_IER_Enable, %function
    push        { lr }
    RegisterSetValueWO  DACC_DACC_IER, DACC_DACC_IxR_ENDTX
    pop         { pc }

@DACC_IRQHandler:
@    .global     DACC_IRQHandler
@    .type       DACC_IRQHandler, %function
@    ldr         r0, =DACC_DACC_ISR
@    tst         r0, #DACC_DACC_IxR_ENDTX
@    bne         DACC_IRQHandler_End
 @DACC_IRQHandler_TXRDY:
    @ Has the transmit ready interrupt TXRDY fired?

@DACC_IRQHandler_EOC:
    @ Has the end of conversion interrupt EOC fired?
    @ Readint the DACC_ISR register clears the EOC bit

@DACC_IRQHandler_ENDTX:
    @ Has the end of transmit buffer interrupt ENDTX fired?
@    CallSub     DACC_PDC_PERIPH_TPR_Start

@DACC_IRQHandler_TXBUFE:
    @ Has the transmit buffer empty interrupt TXBUFE fired?

@DACC_IRQHandler_End:
@    bx          lr

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
    RegisterSetValueWO  DACC_DACC_WPMR, DACC_WPMR_ENABLE
    pop         { pc }

DACC_DACC_WPMR_WriteProtectDisable:
    .global     DACC_DACC_WPMR_WriteProtectDisable
    .type       DACC_DACC_WPMR_WriteProtectDisable, %function
    push        { lr }
    RegisterSetValueWO  DACC_DACC_WPMR, DACC_WPMR_DISABLE
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


    @ Register PERIPH_TPR, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
    @ TXPTR
    @
    @ TXPTR : transfer buffer address
    @

    @ Register PERIPH_TCR, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 | 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | TXCTR
    @
    @ TXCTR : 0 = Stops peripheral data transfer to the transmitter
    @       : 1..65535 = Starts peripheral data transfer if corresponding channel is active
    @

DACC_PDC_PERIPH_TPR_Start:
    .global     DACC_PDC_PERIPH_TPR_Start
    .type       DACC_PDC_PERIPH_TPR_Start, %function
    push        { r0-r1, lr }
    UpdateRegisterByRAM DACC_DMA_DATA_POINTER, DACC_PDC_PERIPH_TPR
    UpdateRegisterByRAM DACC_DMA_DATA_AMOUNT, DACC_PDC_PERIPH_TCR
    UpdateRegisterByRAM DACC_DMA_DATA_POINTER, DACC_PDC_PERIPH_TNPR
    UpdateRegisterByRAM DACC_DMA_DATA_AMOUNT, DACC_PDC_PERIPH_TNCR
    RegisterSetValueWO  DACC_PDC_PERIPH_PTCR, PERIPH_PTCR_TXTEN
    RegisterVerifyFlagIsSet DACC_PDC_PERIPH_PTSR, PERIPH_PTSR_TXTEN
    pop         { r0-r1, pc }

DACC_PDC_PERIPH_TPR_Trigger:
    .global     DACC_PDC_PERIPH_TPR_Trigger
    .type       DACC_PDC_PERIPH_TPR_Trigger, %function
    push        { lr }
    RegisterVerifyFlagIsSet DACC_DACC_ISR, DACC_DACC_IxR_ENDTX
    CallSub     DACC_PDC_PERIPH_TPR_Start
    pop         { pc }


    .align

    .end
