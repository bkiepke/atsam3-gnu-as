    @ Note: This subsystem is embedded to each peripheral subsystem, so only
    @       common definitions are given here.

    @ Register PERIPH_PTCR, write-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 | 09      | 08    | 07 06 05 04 03 02 | 01      | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | TXTDIS  | TXTEN | -  -  -  -  -  -  | RXTDIS  | RXTEN
    @
    @ RXTEN : 0 = No effect.
    @       : 1 = Enables PDC receiver channel requests if RXTDIS is not set.
    @
    @ RXTDIS : 0 = No effect.
    @        : 1 = Disables PDC receiver channel requests.
    @
    @ TXTEN : 0 = No effect.
    @       : 1 = Enables the PDC transmitter channel requests.
    @
    @ TXTDIS : 0 = No effect.
    @        : 1 = Disables the PDC transmitter channel requests.
    @
    .equ        PERIPH_PTCR_RXTEN, (1 << 0)
    .equ        PERIPH_PTCR_RXTDIS, (1 << 1)
    .equ        PERIPH_PTCR_TXTEN, (1 << 8)
    .equ        PERIPH_PTCR_TXTDIS, (1 << 9)
    
    @ Register PERIPH_PTSR, read-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 | 08    | 07 06 05 04 03 02 01 | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | TXTEN | -  -  -  -  -  -  -  | RXTEN
    @
    @ RXTEN : 0 = PDC receiver channel requests are disabled.
    @       : 1 = PDC receiver channel requests are enabled.
    @
    @ TXTEN : 0 = PDC transmitter channel requests are disabled.
    @       : 1 = PDC transmitter channel requests are enabled.
    @
    .equ        PERIPH_PTSR_RXTEN, (1 << 0)
    .equ        PERIPH_PTSR_TXTEN, (1 << 8)


 
