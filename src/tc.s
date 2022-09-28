    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/macros.inc"
    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/peripheral.inc"

    @ Register addresses of TC
    .equ        TC0_TC0_BASE, 0x40010000                                        @ Base register address
    .equ        TC0_TC1_BASE, 0x40010040                                        @ Base register address
    .equ        TC0_TC2_BASE, 0x40010080                                        @ Base register address

    .equ        TC1_TC3_BASE, 0x40014000                                        @ Base register address
    .equ        TC1_TC4_BASE, 0x40014040                                        @ Base register address
    .equ        TC1_TC5_BASE, 0x40014080                                        @ Base register address

    .equ        TC0_TC0_TC_CCR, (TC0_TC0_BASE + 0x0000)                         @ Address to register Channel Control Register 0
    .equ        TC0_TC0_TC_CMR, (TC0_TC0_BASE + 0x0004)                         @ Address to register Channel Mode Register 0
    .equ        TC0_TC0_TC_SMMR, (TC0_TC0_BASE + 0x0008)                        @ Address to register Stepper Motor Mode Register 0
    .equ        TC0_TC0_TC_CV, (TC0_TC0_BASE + 0x0010)                          @ Address to register Counter Value 0
    .equ        TC0_TC0_TC_RA, (TC0_TC0_BASE + 0x0014)                          @ Address to register Register A 0
    .equ        TC0_TC0_TC_RB, (TC0_TC0_BASE + 0x0018)                          @ Address to register Register B 0
    .equ        TC0_TC0_TC_RC, (TC0_TC0_BASE + 0x001C)                          @ Address to register Register C 0
    .equ        TC0_TC0_TC_SR, (TC0_TC0_BASE + 0x0020)                          @ Address to register Status Register 0
    .equ        TC0_TC0_TC_IER, (TC0_TC0_BASE + 0x0024)                         @ Address to register Interrupt Enable Register 0
    .equ        TC0_TC0_TC_IDR, (TC0_TC0_BASE + 0x0028)                         @ Address to register Interrupt Disable Register 0
    .equ        TC0_TC0_TC_IMR, (TC0_TC0_BASE + 0x002C)                         @ Address to register Interrupt Mask Register 0

    .equ        TC0_TC1_TC_CCR, (TC0_TC1_BASE + 0x0000)                         @ Address to register Channel Control Register 1
    .equ        TC0_TC1_TC_CMR, (TC0_TC1_BASE + 0x0004)                         @ Address to register Channel Mode Register 1
    .equ        TC0_TC1_TC_SMMR, (TC0_TC1_BASE + 0x0008)                        @ Address to register Stepper Motor Mode Register 1
    .equ        TC0_TC1_TC_CV, (TC0_TC1_BASE + 0x0010)                          @ Address to register Counter Value 1
    .equ        TC0_TC1_TC_RA, (TC0_TC1_BASE + 0x0014)                          @ Address to register Register A 1
    .equ        TC0_TC1_TC_RB, (TC0_TC1_BASE + 0x0018)                          @ Address to register Register B 1
    .equ        TC0_TC1_TC_RC, (TC0_TC1_BASE + 0x001C)                          @ Address to register Register C 1
    .equ        TC0_TC1_TC_SR, (TC0_TC1_BASE + 0x0020)                          @ Address to register Status Register 1
    .equ        TC0_TC1_TC_IER, (TC0_TC1_BASE + 0x0024)                         @ Address to register Interrupt Enable Register 1
    .equ        TC0_TC1_TC_IDR, (TC0_TC1_BASE + 0x0028)                         @ Address to register Interrupt Disable Register 1
    .equ        TC0_TC1_TC_IMR, (TC0_TC1_BASE + 0x002C)                         @ Address to register Interrupt Mask Register 1

    .equ        TC0_TC2_TC_CCR, (TC0_TC2_BASE + 0x0000)                         @ Address to register Channel Control Register 2
    .equ        TC0_TC2_TC_CMR, (TC0_TC2_BASE + 0x0004)                         @ Address to register Channel Mode Register 2
    .equ        TC0_TC2_TC_SMMR, (TC0_TC2_BASE + 0x0008)                        @ Address to register Stepper Motor Mode Register 2
    .equ        TC0_TC2_TC_CV, (TC0_TC2_BASE + 0x0010)                          @ Address to register Counter Value 2
    .equ        TC0_TC2_TC_RA, (TC0_TC2_BASE + 0x0014)                          @ Address to register Register A 2
    .equ        TC0_TC2_TC_RB, (TC0_TC2_BASE + 0x0018)                          @ Address to register Register B 2
    .equ        TC0_TC2_TC_RC, (TC0_TC2_BASE + 0x001C)                          @ Address to register Register C 2
    .equ        TC0_TC2_TC_SR, (TC0_TC2_BASE + 0x0020)                          @ Address to register Status Register 2
    .equ        TC0_TC2_TC_IER, (TC0_TC2_BASE + 0x0024)                         @ Address to register Interrupt Enable Register 2
    .equ        TC0_TC2_TC_IDR, (TC0_TC2_BASE + 0x0028)                         @ Address to register Interrupt Disable Register 2
    .equ        TC0_TC2_TC_IMR, (TC0_TC2_BASE + 0x002C)                         @ Address to register Interrupt Mask Register 2

    .equ        TC1_TC3_TC_CCR, (TC1_TC3_BASE + 0x0000)                         @ Address to register Channel Control Register 3
    .equ        TC1_TC3_TC_CMR, (TC1_TC3_BASE + 0x0004)                         @ Address to register Channel Mode Register 3
    .equ        TC1_TC3_TC_SMMR, (TC1_TC3_BASE + 0x0008)                        @ Address to register Stepper Motor Mode Register 3
    .equ        TC1_TC3_TC_CV, (TC1_TC3_BASE + 0x0010)                          @ Address to register Counter Value 3
    .equ        TC1_TC3_TC_RA, (TC1_TC3_BASE + 0x0014)                          @ Address to register Register A 3
    .equ        TC1_TC3_TC_RB, (TC1_TC3_BASE + 0x0018)                          @ Address to register Register B 3
    .equ        TC1_TC3_TC_RC, (TC1_TC3_BASE + 0x001C)                          @ Address to register Register C 3
    .equ        TC1_TC3_TC_SR, (TC1_TC3_BASE + 0x0020)                          @ Address to register Status Register 3
    .equ        TC1_TC3_TC_IER, (TC1_TC3_BASE + 0x0024)                         @ Address to register Interrupt Enable Register 3
    .equ        TC1_TC3_TC_IDR, (TC1_TC3_BASE + 0x0028)                         @ Address to register Interrupt Disable Register 3
    .equ        TC1_TC3_TC_IMR, (TC1_TC3_BASE + 0x002C)                         @ Address to register Interrupt Mask Register 3

    .equ        TC1_TC4_TC_CCR, (TC1_TC4_BASE + 0x0000)                         @ Address to register Channel Control Register 4
    .equ        TC1_TC4_TC_CMR, (TC1_TC4_BASE + 0x0004)                         @ Address to register Channel Mode Register 4
    .equ        TC1_TC4_TC_SMMR, (TC1_TC4_BASE + 0x0008)                        @ Address to register Stepper Motor Mode Register 4
    .equ        TC1_TC4_TC_CV, (TC1_TC4_BASE + 0x0010)                          @ Address to register Counter Value 4
    .equ        TC1_TC4_TC_RA, (TC1_TC4_BASE + 0x0014)                          @ Address to register Register A 4
    .equ        TC1_TC4_TC_RB, (TC1_TC4_BASE + 0x0018)                          @ Address to register Register B 4
    .equ        TC1_TC4_TC_RC, (TC1_TC4_BASE + 0x001C)                          @ Address to register Register C 4
    .equ        TC1_TC4_TC_SR, (TC1_TC4_BASE + 0x0020)                          @ Address to register Status Register 4
    .equ        TC1_TC4_TC_IER, (TC1_TC4_BASE + 0x0024)                         @ Address to register Interrupt Enable Register 4
    .equ        TC1_TC4_TC_IDR, (TC1_TC4_BASE + 0x0028)                         @ Address to register Interrupt Disable Register 4
    .equ        TC1_TC4_TC_IMR, (TC1_TC4_BASE + 0x002C)                         @ Address to register Interrupt Mask Register 4

    .equ        TC1_TC5_TC_CCR, (TC1_TC5_BASE + 0x0000)                         @ Address to register Channel Control Register 5
    .equ        TC1_TC5_TC_CMR, (TC1_TC5_BASE + 0x0004)                         @ Address to register Channel Mode Register 5
    .equ        TC1_TC5_TC_SMMR, (TC1_TC5_BASE + 0x0008)                        @ Address to register Stepper Motor Mode Register 5
    .equ        TC1_TC5_TC_CV, (TC1_TC5_BASE + 0x0010)                          @ Address to register Counter Value 5
    .equ        TC1_TC5_TC_RA, (TC1_TC5_BASE + 0x0014)                          @ Address to register Register A 5
    .equ        TC1_TC5_TC_RB, (TC1_TC5_BASE + 0x0018)                          @ Address to register Register B 5
    .equ        TC1_TC5_TC_RC, (TC1_TC5_BASE + 0x001C)                          @ Address to register Register C 5
    .equ        TC1_TC5_TC_SR, (TC1_TC5_BASE + 0x0020)                          @ Address to register Status Register 5
    .equ        TC1_TC5_TC_IER, (TC1_TC5_BASE + 0x0024)                         @ Address to register Interrupt Enable Register 5
    .equ        TC1_TC5_TC_IDR, (TC1_TC5_BASE + 0x0028)                         @ Address to register Interrupt Disable Register 5
    .equ        TC1_TC5_TC_IMR, (TC1_TC5_BASE + 0x002C)                         @ Address to register Interrupt Mask Register 5

    .equ        TC_TC_BCR, (TC0_TC0_BASE + 0x00C0)                              @ Address to register Block Control Register
    .equ        TC_TC_BMR, (TC0_TC0_BASE + 0x00C4)                              @ Address to register Mode Register
    .equ        TC_TC_QIER, (TC0_TC0_BASE + 0x00C8)                             @ Address to register QDEC Interrupt Enable Register
    .equ        TC_TC_QIDR, (TC0_TC0_BASE + 0x00CC)                             @ Address to register QDEC Interrupt Disable Register
    .equ        TC_TC_QIMR, (TC0_TC0_BASE + 0x00D0)                             @ Address to register QDEC Interrupt Mask Register
    .equ        TC_TC_QISR, (TC0_TC0_BASE + 0x00D4)                             @ Address to register QDEC Interrupt Status Register
    .equ        TC_TC_FMR, (TC0_TC0_BASE + 0x00D8)                              @ Address to register Fault Mode Register
    .equ        TC_TC_WPMR, (TC0_TC0_BASE + 0x00E4)                             @ Address to register Write Protect Mode Register

    @ Register TC_BCR, write-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | SYNC
    @
    @ SYNC : 0 = No effect.
    @      : 1 = Asserts the SYNC signal which generates a software trigger simultaneously for each of the channels.
    .equ        TC_TC_BCR_SYNC, 0x00000001

TC_TC_BCR_Sync:
    .global     TC_TC_BCR_Sync
    .type       TC_TC_BCR_Sync, %function
    push        { lr }
    RegisterSetValueWO  TC_TC_BCR, TC_TC_BCR_SYNC
    pop         { pc }

    @ Register TC_BMR, read-write
    @ 31 30 29 28 27 26 | 25 24 23 22 21 20 | 19      | 18 | 17     | 16   | 15     | 14   | 13   | 12     | 11      | 10      | 09    | 08   | 07 06 | 05 04   | 03 02   | 01 00
    @ -  -  -  -  -  -  | MAXFILT           | FILTER  | -  | IDXPHB | SWAP | INVIDX | INVB | INVA | EDGPHA | QDTRANS | SPEEDEN | POSEN | QDEN | -  -  | TC2XC2S | TC1XC1S | TC0XC0S
    @
    @ TX0XC0S : 0 = Signal connected to XC0: TCLK0.
    @         : 1 = Reserved.
    @         : 2 = Signal connected to XC0: TIOA1.
    @         : 3 = Signal connected to XC0: TIOA2.
    @
    @ TX1XC1S : 0 = Signal connected to XC1: TCLK1.
    @         : 1 = Reserved.
    @         : 2 = Signal connected to XC1: TIOA0.
    @         : 3 = Signal connected to XC1: TIOA2.
    @
    @ TX2XC2S : 0 = Signal connected to XC2: TCLK2.
    @         : 1 = Reserved.
    @         : 2 = Signal connected to XC2: TIOA1.
    @         : 3 = Signal connected to XC2: TIOA2.
    @
    @ QDEN : 0 = disabled.
    @      : 1 = enables the quadrature decoder logic (filter, edge detection and quadrature decoding).
    @
    @ POSEN : 0 = disable position.
    @       : 1 = enables position measure on channel 0 and 1
    @
    @ SPEEDEN : 0 = disabled.
    @         : 1 = enables the speed measure on channel 0, the time base being provided by channel 2.
    @
    @ QDTRANS : 0 = full quadrature decoding logic is active (direction change detected).
    @         : 1 = quadrature decoding logic is inactive (direction change inactive) but input filtering and edge detection are performed.
    @
    @ EDGPHA : 0 = edges are detected on both PHA and PHB.
    @        : 1 = edges are detected on PHA only.
    @
    @ INVA : 0 = PHA (TIOA0) is directly driving quadrature decoder logic.
    @      : 1 = PHA is inverted before driving quadrature decoder logic.
    @
    @ INVB : 0 = PHB (TIOB0) is directly driving quadrature decoder logic.
    @      : 1 = PHB is inverted before driving quadrature decoder logic.
    @
    @ SWAP : 0 = no swap between PHA and PHB.
    @      : 1 = swap PHA and PHB internally, prior to driving quadrature decoder logic.
    @
    @ INVIDX : 0 = IDX (TIOA1) is directly driving quadrature logic.
    @        : 1 = IDX is inverted before driving quadrature logic.
    @
    @ IDXPHB : 0 = IDX pin of the rotary sensor must drive TIOA1.
    @        : 1 = IDX pin of the rotary sensor must drive TIOB0.
    @
    @ FILTER : 0 = IDX, PHA, PHB input pins are not filtered.
    @        : 1 = IDX, PHA, PHB input pins are filtered using MAXFILT value.
    @
    @ MAXFILT: 1..63 = defines the filtering capabilities. Pulses with a period shorter than MAXFILT + 1 MCK clock cycles are discarded.
    @

    @ Register TC_QIER, write-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 | 02   | 01     | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | QERR | DIRCHG | IDX
    @
    @ IDX : 0 = no effect.
    @     : 1 = enables the interrupt when a rising edge occurs on IDX input.
    @
    @ DIRCHG : 0 = no effect.
    @        : 1 = enables the interrupt when a change on rotation direction is detected.
    @
    @ QERR : 0 = no effect.
    @      : 1 = enables the interrupt when a quadrature error occurs on PHA, PHB.
    @

    @ Register TC_QIDR, write-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 | 02   | 01     | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | QERR | DIRCHG | IDX
    @
    @ IDX : 0 = no effect.
    @     : 1 = disables the interrupt when a rising edge occurs on IDX input.
    @
    @ DIRCHG : 0 = no effect.
    @        : 1 = disables the interrupt when a change on rotation direction is detected.
    @
    @ QERR : 0 = no effect.
    @      : 1 = disables the interrupt when a quadrature error occurs on PHA, PHB.
    @

    @ Register TC_QIMR, read-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 | 02   | 01     | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | QERR | DIRCHG | IDX
    @
    @ IDX : 0 = the interrupt on IDX is disabled.
    @     : 1 = the interrupt on IDX is enabled.
    @
    @ DIRCHG : 0 = the interrupt on rotation direction change is disabled.
    @        : 1 = the interrupt on rotation direction change is enabled.
    @
    @ QERR : 0 = the interrupt on quadrature error is disabled.
    @      : 1 = the interrupt on quadrature error is enabled.
    @

    @ Register TC_QISR, read-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 | 08  | 07 06 05 04 03 | 02   | 01     | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | DIR | -  -  -  -  -  | QERR | DIRCHG | IDX
    @
    @ IDX : 0 = no index input change since the last read of TC_QISR.
    @     : 1 = the IDX input has change since the last read of TC_QISR.
    @
    @ DIRCHG : 0 = no change on rotation direction since the last read of TC_QISR.
    @        : 1 = the rotation direction changed since the last read of TC_QISR.
    @
    @ QERR : 0 = no quadrature error since the last read of TC_QISR.
    @      : 1 = a quadrature error occurred since the last read of TC_QISR.
    @
    @ DIR : returns an image of the actual rotation direction.
    @

    @ Register TC_FMR, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 | 01    | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | ENCF1 | ENCF0
    @
    @ ENCF0 : 0 = disables the FAULT output source (CPCS flag) from channel 0.
    @       : 1 = enables the FAULT output source (CPCS flag) from channel 0.
    @
    @ ENCF1 : 0 = disables the FAULT output source (CPCS flag) from channel 1.
    @       : 1 = enables the FAULT output source (CPCS flag) from channel 1.
    @    

    @ Register TC_WPMR, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 | 08 07 06 05 04 03 02 01 | 00
    @ WPKEY                                                                | -  -  -  -  -  -  -  -  | WPEN
    @
    @ WPEN : 0 = disables the Write Protect if WPKEY corresponds to 0x54494D ("TIM" in ASCII).
    @      : 1 = enables the Write Protect if WPKEY corresponds to 0x54494D ("TIM" in ASCII).
    @
    @ WPKEY : This security code is needed to set/reset the WPROT bit value. Must be filled with "TIM" ASCII code.
    @

    @ Register TC_CCRx, write-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 04 03 | 02    | 01     | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | SWTRG | CLKDIS | CLKEN
    @
    @ CLKEN : 0 = no effect.
    @       : 1 = enables the clock if CLKDIS is not 1.
    @
    @ CLKDIS : 0 = no effect.
    @        : 1 = disables the clock.
    @
    @ SWTRG : 0 = no effect.
    @       : 1 = a software trigger is performed: the counter is reset and the clock is started.
    @

    @ Register TC_CMRx, read-write (WAVE = 0)
    @ 31 30 29 28 27 26 25 24 23 22 21 20 | 19 18 | 17 16 | 15   | 14     | 13 12 11 | 10     | 09 08   | 07     | 06      | 05 04 | 03   | 02 01 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  | LDRB  | LDRA  | WAVE | CPCTRG | -  -  -  | ABETRG | ETRGEDG | LDBDIS | LDBSTOP | BURST | CLKI | TCCLKS
    @
    @ TCCLKS : 0 = Clock selected: TCLK1.
    @        : 1 = Clock selected: TCLK2.
    @        : 2 = Clock selected: TCLK3. 
    @        : 3 = Clock selected: TCLK4.
    @        : 4 = Clock selected: TCLK5.
    @        : 5 = Clock selected: XC0.
    @        : 6 = Clock selected: XC1.
    @        : 7 = Clock selected: XC2.
    @
    @ CLKI : 0 = counter is incremented on rising edge of the clock.
    @      : 1 = counter is incremented on falling edge of the clock.
    @
    @ BURST : 0 = The clock is not gated by an external signal.
    @       : 1 = XC0 is ANDed with the selected clock.
    @       : 2 = XC1 is ANDed with the selected clock.
    @       : 3 = XC2 is ANDed with the selected clock.
    @
    @ LDBSTOP : 0 = counter clock is not stopped when RB loading occurs.
    @         : 1 = counter clock is stopped when RB loading occurs.
    @
    @ LDBDIS : 0 = counter clock is not disabled when RB loading occurs.
    @        : 1 = counter clock is disabled when RB loading occurs.
    @
    @ ETRGEDG : 0 = The clock is not gated by an external signal.
    @         : 1 = Rising edge
    @         : 2 = Falling edge
    @         : 3 = Each edge
    @
    @ ABETRG : 0 = TIOB is used as an external trigger.
    @        : 1 = TIOA is used as an external trigger.
    @
    @ CPCTRG : 0 = RC Compare has no effect on the counter and its clock.
    @        : 1 = RC Compare resets the counter and starts the counter clock.
    @
    @ WAVE : 0 = Capture Mode is enabled.
    @      : 1 = Capture Mode is disabled (Waveform Mode is enabled).
    @
    @ LDRA : 0 = None
    @      : 1 = Rising edge of TIOA
    @      : 2 = Falling edge of TIOA
    @      : 3 = Each edge of TIOA
    @
    @ LDRB : 0 = None
    @      : 1 = Rising edge of TIOB
    @      : 2 = Falling edge of TIOB
    @      : 3 = Each edge of TIOB
    @

    @ Register TC_CMRx, read-write
    @ 31 30  | 29 28 | 27 26 | 25 24 | 23 22  | 21 20 | 19 18 | 17 16 | 15   | 14 13  | 12     | 11 10 | 09 08   | 07     | 06      | 05 04 | 03   | 02 01 00
    @ BSWTRG | BEEVT | BCPC  | BCPB  | ASWTRG | AEEVT | ACPC  | ACPA  | WAVE | WAVSEL | ENETRG | EEVT  | EEVTEDG | CPCDIS | CPCSTOP | BURST | CLKI | TCCLKS
    @
    @ TCCLKS : 0 = Clock selected: TCLK1
    @        : 1 = Clock selected: TCLK2
    @        : 2 = Clock selected: TCLK3
    @        : 3 = Clock selected: TCLK4
    @        : 4 = Clock selected: TCLK5
    @        : 5 = Clock selected: XC0
    @        : 6 = Clock selected: XC1
    @        : 7 = Clock selected: XC2
    @
    @ CLKI : 0 = counter is incremented on rising edge of the clock.
    @      : 1 = counter is incremented on falling edge of the clock.
    @
    @ BURST : 0 = The clock is not gated by an external signal.
    @       : 1 = XC0 is ANDed with the selected clock.
    @       : 2 = XC1 is ANDed with the selected clock.
    @       : 3 = XC2 is ANDed with the selected clock.
    @
    @ CPCSTOP : 0 = counter clock is not stopped when counter reaches RC.
    @         : 1 = counter clock is stopped when counter reaches RC.