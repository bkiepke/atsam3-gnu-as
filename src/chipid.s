@ import macros and definitions    
    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/macros.inc"
    .include "/home/benny/Projekte_lokal/02_Coding/01_arm/gnu_as_test/src/peripheral.inc"

    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

@    .section .text, "ax"
    
    @ Chip-IDs of families
    .equ        ATSAM3S1A, 0x28890560
    .equ        ATSAM3S1B, 0x28990560
    .equ        ATSAM3S2C, 0x28A90560
    .equ        ATSAM3S2A, 0x288A0760
    .equ        ATSAM3S2B, 0x289A0760
    .equ        ATSAM3S2C, 0x28AA0760
    .equ        ATSAM3S4A, 0x28800960
    .equ        ATSAM3S4B, 0x28900960                                           @ <- Olimex SAM3 H256
    .equ        ATSAM3S4C, 0x28A00960
    .equ        ATSAM3S8A, 0x288B0A60
    .equ        ATSAM3S8B, 0x289B0A60
    .equ        ATSAM3S8C, 0x28AB0A60
    .equ        ATSAM3SD84A, 0x298B0A60
    .equ        ATSAM3SD84B, 0x299B0A60
    .equ        ATSAM3SD84C, 0x29AB0A60

    @ Register addresses of CHIPID
    .equ        CHIPID_BASE, 0x400E0740                                         @ Base register address
    .equ        CHIPID_CIDR, (CHIPID_BASE + 0x0)                                @ Address to register Chip ID Register
    .equ        CHIPID_EXID, (CHIPID_BASE + 0x4)                                @ Address to register Chip ID Extension Register

    @ Register CHIPID_CIDR
    @ 31  | 30 29 28 | 27 26 25 24 23 22 21 20 | 19 18 17 16 | 15 14 13 12 | 11 10 09 08 | 07 06 05 | 04 03 02 01 00
    @ EXT | NVPTYP   | ARCH                    | SRAMSIZ     | NVPSIZ2     | NVPSIZ      | EPROC    | VERSION

CHIPID_CIDR_Get:
    .global     CHIPID_CIDR_Get
    .type       CHIPID_CIDR_Get, %function    
@    ldr         r1, =CHIPID_CIDR
@    ldr         r0, [r1]
@    bx          lr
    push        { lr }
    RegisterGetValue CHIPID_CIDR
    pop         { pc }

    .end
