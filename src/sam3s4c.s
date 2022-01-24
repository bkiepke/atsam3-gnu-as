.equ    BOOT_MEMORY,    0x00000000
.equ    INTERNAL_FLASH, 0x00400000
.equ    INTERNAL_ROM,   0x00800000
.equ    SRAM,           0x20000000


# Peripherals
.equ    HSMCI_BASE,     0x40000000
.equ    SSC_BASE,       0x40004000
.equ    SPI_BASE,       0x40008000
.equ    TC0_BASE,       0x40010000
.equ    TC1_BASE,       0x40010040
.equ    TC2_BASE,       0x40010080
.equ    TC3_BASE,       0x40014000
.equ    TC4_BASE,       0x40014040
.equ    TC5_BASE,       0x40014080
.equ    TWI0_BASE,      0x40018000
.equ    TWI1_BASE,      0x4001C000
.equ    PWM_BASE,       0x40020000
.equ    USART0_BASE,    0x40024000
.equ    USART1_BASE,    0x40028000
.equ    UDP_BASE,       0x40034000
.equ    ADC_BASE,       0x40038000
.equ    DACC_BASE,      0x4003C000
.equ    ACC_BASE,       0x40040000
.equ    CRCCU_BASE,     0x40044000
.equ    SMC_BASE,       0x400E0000
.equ    MATRIX_BASE,    0x400E0200
.equ    PMC_BASE,       0x400E0400
.equ    UART0_BASE,     0x400E0600
.equ    CHIPID_BASE,    0x400E0740
.equ    UART1_BASE,     0x400E0800
.equ    EFC_BASE,       0x400E0A00
.equ    PIOA_BASE,      0x400E0C00
.equ    PIOB_BASE,      0x400E1000
.equ    PIOC_BASE,      0x400E1200
.equ    RSTC_BASE,      0x400E1400
.equ    SUPC_BASE,      0x400E1410
.equ    RTT_BASE,       0x400E1430
.equ    WDT_BASE,       0x400E1450
.equ    RTC_BASE,       0x400E1460
.equ    GPBR_BASE,      0x400E1490

.equ    SMC_CHIP_SELECT_0,   0x60000000
.equ    SMC_CHIP_SELECT_1,   0x61000000
.equ    SMC_CHIP_SELECT_2,   0x62000000
.equ    SMC_CHIP_SELECT_3,   0x63000000


# Vector addresses
.equ    VECTOR_BOOT,        0x00000000
.equ    VECTOR_RESET,       0x00000004
.equ    VECTOR_NMI,         0x00000008
.equ    VECTOR_HARD_FAULT,  0x0000000C
.equ    VECTOR_MEM_FAULT,   0x00000010
.equ    VECTOR_BUS_FAULT,   0x00000014
.equ    VECTOR_USE_FAULT,   0x00000018
.equ    VECTOR_RESERVED_1,  0x0000001C
.equ    VECTOR_RESERVED_2,  0x00000020
.equ    VECTOR_RESERVED_3,  0x00000024
.equ    VECTOR_RESERVED_4,  0x00000028
.equ    VECTOR_SVC,         0x0000002C
.equ    VECTOR_RESERVED_5,  0x00000030
.equ    VECTOR_RESERVED_6,  0x00000034
.equ    VECTOR_PEND_SV,     0x00000038
.equ    VECTOR_SYS_TICK,    0x0000003C

# Vector addresses of peripherals
