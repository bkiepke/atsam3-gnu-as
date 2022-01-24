    .syntax unified
    .cpu cortex-m3
    .arch armv6-m
    .thumb

    .word 0x20000400
    .word 0x080000ed
    .space 0xe4

@    .global main
    .global _exit
@    .global _start
    .global __START


    .global SystemInit
@    .global __copy_table_start__
@    .global __copy_table_end__
@    .global __data_start__
@    .global __data_end__
@    .global __zero_table_start__
@    .global __zero_table_end__

@main:
@_start:
__START:
    nop		@ Do Nothing
    movs    r0,#1

    b .		@ Endless loop

@ test

SystemInit:
    nop     @ Do Nothing
    bx      lr
    
@__copy_table_start__:
@__copy_table_end__:
@__data_start__:
@__data_end__:
@__zero_table_start__:
@__zero_table_end__:
@    bx      lr

@_exit:
@    bx      lr

    .end
    