   @ Register addresses of NVIC
    .equ        NVIC_ISER0, 0xE000E100                                          @ Address to register Interrupt Set-enable Register 0
    .equ        NVIC_ISER1, 0xE000E104                                          @ Address to register Interrupt Set-enable Register 1
    .equ        NVIC_ICER0, 0xE000E180                                          @ Address to register Interrupt Clear-enable Register 0
    .equ        NVIC_ICER1, 0xE000E184                                          @ Address to register Interrupt Clear-enable Register 1
    .equ        NVIC_ISPR0, 0xE000E200                                          @ Address to register Interrupt Set-pending Register 0
    .equ        NVIC_ISPR1, 0xE000E204                                          @ Address to register Interrupt Set-pending Register 1
    .equ        NVIC_ICPR0, 0xE000E280                                          @ Address to register Interrupt Clear-pending Register 0
    .equ        NVIC_ICPR1, 0xE000E284                                          @ Address to register Interrupt Clear-pending Register 1
    .equ        NVIC_IABR0, 0xE000E300                                          @ Address to register Interrupt Active Bit Register 0
    .equ        NVIC_IABR1, 0xE000E304                                          @ Address to register Interrupt Active Bit Register 1
    .equ        NVIC_IPR0, 0xE000E400                                           @ Address to register Interrupt Priority Register 0
    .equ        NVIC_IPR1, 0xE000E404                                           @ Address to register Interrupt Priority Register 1
    .equ        NVIC_IPR2, 0xE000E408                                           @ Address to register Interrupt Priority Register 2
    .equ        NVIC_IPR3, 0xE000E40C                                           @ Address to register Interrupt Priority Register 3
    .equ        NVIC_IPR4, 0xE000E410                                           @ Address to register Interrupt Priority Register 4
    .equ        NVIC_IPR5, 0xE000E414                                           @ Address to register Interrupt Priority Register 5
    .equ        NVIC_IPR6, 0xE000E418                                           @ Address to register Interrupt Priority Register 6
    .equ        NVIC_IPR7, 0xE000E41C                                           @ Address to register Interrupt Priority Register 7
    .equ        NVIC_IPR8, 0xE000E420                                           @ Address to register Interrupt Priority Register 8
    .equ        NVIC_STIR, 0xE000EF00                                           @ Address to register Software Trigger Interrupt Register

    @ Offset within NVIC_IPRx register
    .equ        NVIC_IPRx_OFFSET_0, 0
    .equ        NVIC_IPRx_OFFSET_1, 8
    .equ        NVIC_IPRx_OFFSET_2, 16
    .equ        NVIC_IPRx_OFFSET_3, 24

    @ Offset of priority
    .equ        NVIC_PRIO_0, 0x00 
    .equ        NVIC_PRIO_1, 0x10
    .equ        NVIC_PRIO_2, 0x20
    .equ        NVIC_PRIO_3, 0x30
    .equ        NVIC_PRIO_4, 0x40
    .equ        NVIC_PRIO_5, 0x50
    .equ        NVIC_PRIO_6, 0x60
    .equ        NVIC_PRIO_7, 0x70
    .equ        NVIC_PRIO_8, 0x80
    .equ        NVIC_PRIO_9, 0x90
    .equ        NVIC_PRIO_10, 0xA0
    .equ        NVIC_PRIO_11, 0xB0
    .equ        NVIC_PRIO_12, 0xC0
    .equ        NVIC_PRIO_13, 0xD0
    .equ        NVIC_PRIO_14, 0xE0
    .equ        NVIC_PRIO_15, 0xF0

    @ Subsystem interrupt enable routines
    .global     DACC_DACC_IER_Enable


    @ Macro to enable interrupts of subsystems
    .global NVIC_SetupInterrupts
    .macro NVIC_SetupInterrupts
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_SUPC), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_0), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR0, SUPC_SUPC_SMMR_InterruptEnable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_RSTC), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_1), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR0, RSTC_RSTC_MR_InterruptEnable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_RTC), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_2), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR0, RTT_RTT_MR_InterruptEnable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_RTT), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_3), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR0, RTC_RTC_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_WDT), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_0), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR1, WDT_WDT_MR_InterruptEnable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_PMC), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_1), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR1, PMC_PMC_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_EEFC), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_2), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR1, EEFC_EEFC_FMR_InterruptEnable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_UART0), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_0), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR2, UART0_UART_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_UART1), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_1), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR2, UART1_UART_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_SMC), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_2), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR2, SUPC_SUPC_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_PIOA), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_3), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR2, PIOA_PIO_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_PIOB), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_0), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR3, PIOB_PIO_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_PIOC), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_1), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR3, PIOC_PIO_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_USART0), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_2), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR3, USART0_US_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_USART1), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_3), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR3, USART1_US_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_HSMCI), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_2), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR4, HSMCI_HSMCI_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_TWI0), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_3), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR4, TWI0_TWI_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_TWI1), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_0), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR5, TWI1_TWI_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_SPI), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_1), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR5, SPI_SPI_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_SSC), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_2), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR5, SSC_SSC_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_TC0), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_3), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR5, TC0_TC_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_TC1), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_0), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR6, TC1_TC_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_TC2), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_1), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR6, TC2_TC_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_TC3), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_2), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR6, TC3_TC_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_TC4), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_3), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR6, TC4_TC_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_TC5), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_0), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR7, TC5_TC_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_ADC), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_1), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR7, ADC_ADC_IER_Enable
    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_DACC), (NVIC_PRIO_7 << NVIC_IPRx_OFFSET_2), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR7, DACC_DACC_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_0_PWM), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_3), NVIC_ISER0, NVIC_ICER0, NVIC_ICPR0, NVIC_IPR7, PWM_PWM_IER_InterruptEnable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_1_CRCCU), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_0), NVIC_ISER1, NVIC_ICER1, NVIC_ICPR1, NVIC_IPR8, CCRCU_CCRUC_IER_InterruptEnable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_1_ACC), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_1), NVIC_ISER1, NVIC_ICER1, NVIC_ICPR1, NVIC_IPR8, ACC_ACC_IER_Enable
@    CallSub     NVIC_InterruptEnable, (1 << PERIPHERAL_1_UDP), (NVIC_PRIO_15 << NVIC_IPRx_OFFSET_2), NVIC_ISER1, NVIC_ICER1, NVIC_ICPR1, NVIC_IPR8, UDP_UDP_IER_Enable
    .endm
