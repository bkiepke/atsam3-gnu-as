    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

    .section .text, "ax"
@
@ Utilities functions
@

    @ Delay for some cycles
    @ r0 : contains the amount of cycles to block for delay, will be decremented until zero
DelayBlocking:
    .global     DelayBlocking
    .type       DelayBlocking, %function
    push        { lr }
DelayBlockingLoop: 
    subs        r0, #1
    bne         DelayBlockingLoop
    pop         { pc }

    .align

    .end
    