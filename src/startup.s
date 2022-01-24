    .syntax     unified
    .arch       armv6-m

    .section    .stack
    .align      3
#ifdef __STACK_SIZE
    .equ        Stack_Size, __STACK_SIZE
#else
    .equ        Stack_Size, 0x00000400
#endif
    .globl      __StackTop
    .globl      __StackLimit
__StackLimit:
    .space      Stack_Size
    .size       __StackLimit, . - __StackLimit
__StackTop:
    .size       __StackTop, . - __StackTop

    .section    .heap
    .align      3
#ifdef __HEAP_SIZE
    .equ        Heap_Size, __HEAP_SIZE
#else
    .equ        Heap_Size, 0x00000400
#endif
    .globl      __HeapBase
    .globl      __HeapLimit
__HeapBase:
    .if Heap_Size
    .space      Heap_Size
    .endif
    .size       __HeapBase, . - __HeapBase
__HeapLimit:
    .size       __HeapLimit, . - __HeapLimit

    .section    .vectors
    .align      2
    .globl      __Vectors
__Vectors:
    .long       __StackTop                 /* Top of Stack */
    .long       Reset_Handler              /* Reset Handler */
    .long       NMI_Handler                /* NMI Handler */
    .long       HardFault_Handler          /* Hard Fault Handler */
    .long       Default_Handler            /* Reserved */
    .long       Default_Handler            /* Reserved */
    .long       Default_Handler            /* Reserved */
    .long       Default_Handler            /* Reserved */
    .long       Default_Handler            /* Reserved */
    .long       Default_Handler            /* Reserved */
    .long       Default_Handler            /* Reserved */
    .long       SVC_Handler                /* SVCall Handler */
    .long       Default_Handler            /* Reserved */
    .long       sl_app_properties          /* Application properties */
    .long       PendSV_Handler             /* PendSV Handler */
    .long       SysTick_Handler            /* SysTick Handler */

    /* External interrupts */

    .long       DMA_IRQHandler             /* 0 - DMA */
    .long       GPIO_EVEN_IRQHandler       /* 1 - GPIO_EVEN */
    .long       TIMER0_IRQHandler          /* 2 - TIMER0 */
    .long       ACMP0_IRQHandler           /* 3 - ACMP0 */
    .long       ADC0_IRQHandler            /* 4 - ADC0 */
    .long       I2C0_IRQHandler            /* 5 - I2C0 */
    .long       GPIO_ODD_IRQHandler        /* 6 - GPIO_ODD */
    .long       TIMER1_IRQHandler          /* 7 - TIMER1 */
    .long       USART1_RX_IRQHandler       /* 8 - USART1_RX */
    .long       USART1_TX_IRQHandler       /* 9 - USART1_TX */
    .long       LEUART0_IRQHandler         /* 10 - LEUART0 */
    .long       PCNT0_IRQHandler           /* 11 - PCNT0 */
    .long       RTC_IRQHandler             /* 12 - RTC */
    .long       CMU_IRQHandler             /* 13 - CMU */
    .long       VCMP_IRQHandler            /* 14 - VCMP */
    .long       MSC_IRQHandler             /* 15 - MSC */
    .long       AES_IRQHandler             /* 16 - AES */
    .long       USART0_RX_IRQHandler       /* 17 - USART0_RX */
    .long       USART0_TX_IRQHandler       /* 18 - USART0_TX */
    .long       USB_IRQHandler             /* 19 - USB */
    .long       TIMER2_IRQHandler          /* 20 - TIMER2 */


    .size       __Vectors, . - __Vectors

    .text
    .thumb
    .thumb_func
    .align      2
    .globl      Reset_Handler
    .type       Reset_Handler, %function
Reset_Handler:
#ifndef __NO_SYSTEM_INIT
    ldr     r0, =SystemInit
    blx     r0
#endif

#ifndef __START
#define __START _start
#endif
    bl      __START

    .pool
    .size   Reset_Handler, . - Reset_Handler

    .align  1
    .thumb_func
    .weak   Default_Handler
    .type   Default_Handler, %function
    .weak   sl_app_properties
    .type   sl_app_properties, %common
Default_Handler:
sl_app_properties: /* Provide a dummy value for the sl_app_properties symbol. */
    b       .
    .size   Default_Handler, . - Default_Handler

/*    Macro to define default handlers. Default handler
 *    will be weak symbol and just dead loops. They can be
 *    overwritten by other handlers.
 */
    .macro  def_irq_handler	handler_name
    .weak   \handler_name
    .set    \handler_name, Default_Handler
    .endm

    def_irq_handler     NMI_Handler
    def_irq_handler     HardFault_Handler
    def_irq_handler     SVC_Handler
    def_irq_handler     PendSV_Handler
    def_irq_handler     SysTick_Handler

    def_irq_handler     DMA_IRQHandler
    def_irq_handler     GPIO_EVEN_IRQHandler
    def_irq_handler     TIMER0_IRQHandler
    def_irq_handler     ACMP0_IRQHandler
    def_irq_handler     ADC0_IRQHandler
    def_irq_handler     I2C0_IRQHandler
    def_irq_handler     GPIO_ODD_IRQHandler
    def_irq_handler     TIMER1_IRQHandler
    def_irq_handler     USART1_RX_IRQHandler
    def_irq_handler     USART1_TX_IRQHandler
    def_irq_handler     LEUART0_IRQHandler
    def_irq_handler     PCNT0_IRQHandler
    def_irq_handler     RTC_IRQHandler
    def_irq_handler     CMU_IRQHandler
    def_irq_handler     VCMP_IRQHandler
    def_irq_handler     MSC_IRQHandler
    def_irq_handler     AES_IRQHandler
    def_irq_handler     USART0_RX_IRQHandler
    def_irq_handler     USART0_TX_IRQHandler
    def_irq_handler     USB_IRQHandler
    def_irq_handler     TIMER2_IRQHandler


    .end
