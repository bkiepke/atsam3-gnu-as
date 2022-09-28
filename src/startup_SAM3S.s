@/*****************************************************************************
@ * @file:    startup_SAM3S.s
@ * @purpose: CMSIS Cortex-M3 Core Device Startup File
@ *           for the Atmel SAM3S Device Series
@ * @version: V1.20
@ * @date:    14. December 2015
@ *------- <<< Use Configuration Wizard in Context Menu >>> ------------------
@ *
@ * Copyright (C) 2011-2013 ARM Limited. All rights reserved.
@ * ARM Limited (ARM) is supplying this software for use with Cortex-M3
@ * processor based microcontrollers.  This file can be freely distributed
@ * within development tools that are supporting such ARM based processors.
@ *
@ * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
@ * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
@ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
@ * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
@ * CONS.equENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
@ *
@ *****************************************************************************/

    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

@ <h> Stack Configuration
@   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
@ </h>

    .equ        __stack_size__, 0x00000200

    .section    .stack, "axw" 
    .balign     8
Stack_Mem:       
    .org        Stack_Mem + __stack_size__
__initial_sp:
    .size       __initial_sp, . - __initial_sp

@ <h> Heap Configuration
@   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
@ </h>

    @ .equ        Heap_Size, 0x00000000
@ 
    @ .section    .bss, "aw"
    @ .balign     8
@ __heap_base:
@ Heap_Mem:
    @ .org        Heap_Mem + Heap_Size
@ __heap_limit:
    @ .eabi_attribute Tag_ABI_align_preserved, 1

@ 
@ Vector Table Mapped to Address 0 at Reset

    .section    .vectors, "ax"
    .global     __Vectors
    .balign     4

__Vectors:
    .word       __initial_sp              @  0: Top of Stack
    .word       Reset_Handler             @  1: Reset Handler
    .word       NMI_Handler               @  2: NMI Handler
    .word       HardFault_Handler         @  3: Hard Fault Handler
    .word       MemManage_Handler         @  4: MPU Fault Handler
    .word       BusFault_Handler          @  5: Bus Fault Handler
    .word       UsageFault_Handler        @  6: Usage Fault Handler
    .word       0                         @  7: Reserved
    .word       0                         @  8: Reserved
    .word       0                         @  9: Reserved
    .word       0                         @ 10: Reserved
    .word       SVC_Handler               @ 11: SVCall Handler
    .word       DebugMon_Handler          @ 12: Debug Monitor Handler
    .word       0                         @ 13: Reserved
    .word       PendSV_Handler            @ 14: PendSV Handler
    .word       SysTick_Handler           @ 15: SysTick Handler

    @ External Interrupts
    .word       SUPC_IRQHandler           @  0: Supply Controller
    .word       RSTC_IRQHandler           @  1: Reset Controller
    .word       RTC_IRQHandler            @  2: Real Time Clock
    .word       RTT_IRQHandler            @  3: Real Time Timer
    .word       WDT_IRQHandler            @  4: Watchdog Timer
    .word       PMC_IRQHandler            @  5: Power Management Controller
    .word       EEFC_IRQHandler           @  6: Enhanced Embedded Flash Controller
    .word       0                         @  7: Reserved
    .word       UART0_IRQHandler          @  8: UART0
    .word       UART1_IRQHandler          @  9: UART1
    .word       0                         @ 10: Reserved
    .word       PIOA_IRQHandler           @ 11: Parallel I/O Controller A
    .word       PIOB_IRQHandler           @ 12: Parallel I/O Controller B
    .word       PIOC_IRQHandler           @ 13: Parallel I/O Controller C
    .word       USART0_IRQHandler         @ 14: USART 0
    .word       USART1_IRQHandler         @ 15: USART 1
    .word       0                         @ 16: Reserved
    .word       0                         @ 17: Reserved
    .word       HSMCI_IRQHandler          @ 18: Multimedia Card Interface
    .word       TWI0_IRQHandler           @ 19: Two Wire Interface 0
    .word       TWI1_IRQHandler           @ 20: Two Wire Interface 1
    .word       SPI_IRQHandler            @ 21: Serial Peripheral Interface
    .word       SSC_IRQHandler            @ 22: Synchronous Serial Controller
    .word       TC0_IRQHandler            @ 23: Timer/Counter 0
    .word       TC1_IRQHandler            @ 24: Timer/Counter 1
    .word       TC2_IRQHandler            @ 25: Timer/Counter 2
    .word       TC3_IRQHandler            @ 26: Timer/Counter 3
    .word       TC4_IRQHandler            @ 27: Timer/Counter 4
    .word       TC5_IRQHandler            @ 28: Timer/Counter 5
    .word       ADC_IRQHandler            @ 29: Analog-to-Digital Converter
    .word       DACC_IRQHandler           @ 30: Digital-to-Analog Converter
    .word       PWM_IRQHandler            @ 31: Pulse Width Modulation
    .word       CRCCU_IRQHandler          @ 32: CRC Calculation Unit
    .word       ACC_IRQHandler            @ 33: Analog Comparator
    .word       UDP_IRQHandler            @ 34: USB Device Port

    .size       __Vectors, . - __Vectors
    
    .section    .vectors, "ax"
    .thumb
    .thumb_func
    .balign     4

    
@ Reset Handler
Reset_Handler:
    .global     Reset_Handler
    .type       Reset_Handler, %function
    .global     SystemInit
    .global     main
    bl          SystemInit
    b           main

@ Dummy Exception Handlers (infinite loops which can be modified)
NMI_Handler:     
    .global     NMI_Handler
    .type       NMI_Handler, %function
    b           .

HardFault_Handler:
    .global     HardFault_Handler
    .type       HardFault_Handler, %function
    b           .

MemManage_Handler:
    .global     MemManage_Handler
    .type       MemManage_Handler, %function
    b           .

BusFault_Handler:
    .global     BusFault_Handler
    .type       BusFault_Handler, %function
    b           .

UsageFault_Handler:
    .global     UsageFault_Handler
    .type       UsageFault_Handler, %function
    b           .

SVC_Handler:     
    .global     SVC_Handler
    .type       SVC_Handler, %function    
    b           .

DebugMon_Handler:
    .global     DebugMon_Handler
    .type       DebugMon_Handler, %function
    b           .

PendSV_Handler:  
    .global     PendSV_Handler
    .type       PendSV_Handler, %function    
    b           .

SysTick_Handler:
    .global     SysTick_Handler
    .type       SysTick_Handler, %function    
    bx          lr

@ Hardware Interrupt Handlers
SUPC_IRQHandler:
    .global     SUPC_IRQHandler
    .type       SUPC_IRQHandler, %function    
    bx          lr

RSTC_IRQHandler:
    .global     RSTC_IRQHandler
    .type       RSTC_IRQHandler, %function    
    bx          lr
    
RTC_IRQHandler:
    .global     RTC_IRQHandler
    .type       RTC_IRQHandler, %function    
    bx          lr
    
RTT_IRQHandler:
    .global     RTT_IRQHandler
    .type       RTT_IRQHandler, %function    
    bx          lr
    
WDT_IRQHandler:
    .global     WDT_IRQHandler
    .type       WDT_IRQHandler, %function    
    bx          lr
    
PMC_IRQHandler:
    .global     PMC_IRQHandler
    .type       PMC_IRQHandler, %function        
    bx          lr
    
EEFC_IRQHandler:
    .global     EEFC_IRQHandler
    .type       EEFC_IRQHandler, %function        
    bx          lr
    
UART0_IRQHandler:
    .global     UART0_IRQHandler
    .type       UART0_IRQHandler, %function        
    bx          lr
    
UART1_IRQHandler:
    .global     UART1_IRQHandler
    .type       UART1_IRQHandler, %function        
    bx          lr
    
SMC_IRQHandler:
    .global     SMC_IRQHandler
    .type       SMC_IRQHandler, %function        
    bx          lr
    
PIOA_IRQHandler:
    .global     PIOA_IRQHandler
    .type       PIOA_IRQHandler, %function        
    bx          lr
    
PIOB_IRQHandler:
    .global     PIOB_IRQHandler
    .type       PIOB_IRQHandler, %function        
    bx          lr
    
PIOC_IRQHandler:
    .global     PIOC_IRQHandler
    .type       PIOC_IRQHandler, %function        
    bx          lr
    
USART0_IRQHandler:
    .global     USART0_IRQHandler
    .type       USART0_IRQHandler, %function        
    bx          lr

USART1_IRQHandler:
    .global     USART1_IRQHandler
    .type       USART1_IRQHandler, %function    
    bx          lr
    
HSMCI_IRQHandler:
    .global     HSMCI_IRQHandler
    .type       HSMCI_IRQHandler, %function        
    bx          lr
    
TWI0_IRQHandler:
    .global     TWI0_IRQHandler
    .type       TWI0_IRQHandler, %function        
    bx          lr
    
TWI1_IRQHandler:
    .global     TWI1_IRQHandler
    .type       TWI1_IRQHandler, %function        
    bx          lr
    
SPI_IRQHandler:
    .global     SPI_IRQHandler
    .type       SPI_IRQHandler, %function        
    bx          lr
    
SSC_IRQHandler:
    .global     SSC_IRQHandler
    .type       SSC_IRQHandler, %function        
    bx          lr
    
TC0_IRQHandler:
    .global     TC0_IRQHandler
    .type       TC0_IRQHandler, %function        
    bx          lr
    
TC1_IRQHandler:
    .global     TC1_IRQHandler
    .type       TC1_IRQHandler, %function        
    bx          lr
    
TC2_IRQHandler:
    .global     TC2_IRQHandler
    .type       TC2_IRQHandler, %function        
    bx          lr
    
TC3_IRQHandler:
    .global     TC3_IRQHandler
    .type       TC3_IRQHandler, %function        
    bx          lr
    
TC4_IRQHandler:
    .global     TC4_IRQHandler
    .type       TC4_IRQHandler, %function        
    bx          lr
    
TC5_IRQHandler:
    .global     TC5_IRQHandler
    .type       TC5_IRQHandler, %function    
    bx          lr
    
ADC_IRQHandler:
    .global     ADC_IRQHandler
    .type       ADC_IRQHandler, %function    
    bx          lr
    
DACC_IRQHandler:
    .global     DACC_IRQHandler
    .type       DACC_IRQHandler, %function    
    bx          lr
    
PWM_IRQHandler:
    .global     PWM_IRQHandler
    .type       PWM_IRQHandler, %function        
    bx          lr
    
CRCCU_IRQHandler:
    .global     CRCCU_IRQHandler
    .type       CRCCU_IRQHandler, %function        
    bx          lr
    
ACC_IRQHandler:
    .global     ACC_IRQHandler
    .type       ACC_IRQHandler, %function        
    bx          lr
    
UDP_IRQHandler:
    .global     UDP_IRQHandler
    .type       UDP_IRQHandler, %function        
    bx          lr
    
    .align

@ User Initial Stack & Heap
@ .ifdef __MICROLIB
@     .global __initial_sp
@     .global __heap_base
@     .global __heap_limit
@ .else
@     .global __use_two_region_memory
@     .global __user_initial_stackheap
@ __user_initial_stackheap:
@     ldr     r0, = Heap_Mem
@     ldr     r1, = (Stack_Mem + __stack_size__)
@     ldr     r2, = (Heap_Mem + Heap_Size)
@     ldr     r3, = Stack_Mem
@     bx      lr
@     .align
@ .endif
    .end
