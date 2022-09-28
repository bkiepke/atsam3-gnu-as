    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

@
@ Utilities functions
@

    @ Delay for some cycles
DelayBlocking:
    .global     DelayBlocking
    .type       DelayBlocking, %function
    push        { lr }
DelayBlockingLoop: 
    subs        r0, #1
    bne         DelayBlockingLoop
    pop         { pc }

    .end


@@@@@@@

WDT_WDT_MR_Disable:
    .global     WDT_WDT_MR_Disable
    .type       WDT_WDT_MR_Disable, %function
    push        { r0-r1, lr }
    RegisterSetValueWO  WDT_WDT_MR, (1 << WDT_WDT_MR_WDDIS)
    pop         { r0-r1, pc }
