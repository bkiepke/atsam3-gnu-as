    .syntax unified
    .cpu cortex-m3
    .arch armv7-m
    .thumb

    @ Register addresses of UDP
    .equ        UDP_BASE, 0x400E0400                                            @ Base register address
    .equ        UDP_FRM_NUM, (UDP_BASE + 0x0000)                                @ Address to register Frame Number Register
    .equ        UDP_GLB_STAT, (UDP_BASE + 0x0004)                               @ Address to register Global State Register
    .equ        UDP_FADDR, (UDP_BASE + 0x0008)                                  @ Address to register Function Address Register  
    .equ        UDP_IER, (UDP_BASE + 0x0010)                                    @ Address to register Interrupt Enable Register
    .equ        UDP_IDR, (UDP_BASE + 0x0014)                                    @ Address to register Interrupt Disable Register
    .equ        UDP_IMR, (UDP_BASE + 0x0018)                                    @ Address to register Interrupt Mask Register
    .equ        UDP_ISR, (UDP_BASE + 0x001C)                                    @ Address to register Interrupt Status Register
    .equ        UDP_ICR, (UDP_BASE + 0x0020)                                    @ Address to register Interrupt Clear Register
    .equ        UDP_RST_EP, (UDP_BASE + 0x0028)                                 @ Address to register Reset Endpoint Register
    .equ        UDP_CSR0, (UDP_BASE + 0x0030)                                   @ Address to register Endpoint Control and Status Register 0
    .equ        UDP_CSR1, (UDP_BASE + 0x0034)                                   @ Address to register Endpoint Control and Status Register 1
    .equ        UDP_CSR2, (UDP_BASE + 0x0038)                                   @ Address to register Endpoint Control and Status Register 2
    .equ        UDP_CSR3, (UDP_BASE + 0x003C)                                   @ Address to register Endpoint Control and Status Register 3
    .equ        UDP_CSR4, (UDP_BASE + 0x0040)                                   @ Address to register Endpoint Control and Status Register 4
    .equ        UDP_CSR5, (UDP_BASE + 0x0044)                                   @ Address to register Endpoint Control and Status Register 5
    .equ        UDP_CSR6, (UDP_BASE + 0x0048)                                   @ Address to register Endpoint Control and Status Register 6
    .equ        UDP_CSR7, (UDP_BASE + 0x004C)                                   @ Address to register Endpoint Control and Status Register 7
    .equ        UDP_FDR0, (UDP_BASE + 0x0050)                                   @ Address to register Endpoint FIFO Data Register 0
    .equ        UDP_FDR1, (UDP_BASE + 0x0054)                                   @ Address to register Endpoint FIFO Data Register 1
    .equ        UDP_FDR2, (UDP_BASE + 0x0058)                                   @ Address to register Endpoint FIFO Data Register 2
    .equ        UDP_FDR3, (UDP_BASE + 0x005C)                                   @ Address to register Endpoint FIFO Data Register 3
    .equ        UDP_FDR4, (UDP_BASE + 0x0060)                                   @ Address to register Endpoint FIFO Data Register 4
    .equ        UDP_FDR5, (UDP_BASE + 0x0064)                                   @ Address to register Endpoint FIFO Data Register 5
    .equ        UDP_FDR6, (UDP_BASE + 0x0068)                                   @ Address to register Endpoint FIFO Data Register 6
    .equ        UDP_FDR7, (UDP_BASE + 0x006C)                                   @ Address to register Endpoint FIFO Data Register 7
    .equ        UDP_TXVC, (UDP_BASE + 0x0074)                                   @ Address to register Transceiver Control Register

    @ Register UDP_FRM_NUM, read-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 | 17     | 16      | 15 14 13 12 11 | 10 09 08 07 06 05 04 03 02 01 00
    @                         -  -  -  -  -  -  | FRM_OK | FRM_ERR | -  -  -  -  -  | FRM_NUM
    @
    @ FRM_NUM : This 11-bit value is incremented by the host on a per frame basis. This value is updated at each start of frame.
    @           Value Updated at the SOF_EOP (Start of Frame End of Packet).
    @ FRM_ERR : This bit is set at SOF_EOP when the SOF packet is received containing an error.
    @           This bit is reset upon receipt of SOF_PID.
    @ FRM_OK  : This bit is set at SOF_EOP when the SOF packet is received without any error. 
    @           This bit is reset upon receipt of SOF_PID (Packet Identification).
    @           In the Interrupt Status Register, the SOF interrupt is updated upon receiving SOF_PID. This bit is set without waiting for EOP.

    @ Register UDP_GLB_STAT, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 07 06 05 | 04     | 03      | 02  | 01    | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | RMWUPE | RSMINPR | ESR | CONFG | FADDEN
    @
    @ FADDEN : Read : 0 = Device is not in address state.
    @               : 1 = Device is in address state.
    @          Write : 0 = No effect, only a reset can bring back a device to default state.
    @                : 1 = Sets device in address state. 
    @ CONFG : Read : 0 = Device is not in configured state.
    @              : 1 = Device is in configured state.
    @         Write : 0 = Sets device in non configured state.
    @               : 1 = Sets device in configured state.
    @ ESR : 0 = Mandatory value prior to starting any Remote Wake Up procedure. 
    @       1 = Starts the Remote Wake Up procedure if this bit value was 0 and if RMWUPE is enabled.
    @ RSMINPR : 0 = ?
    @         : 1 = ?
    @ RMWUPE : 0 = The Remote Wake Up feature of the device is disabled.
    @        : 1 = The Remote Wake Up feature of the device is enabled.

    @ Register UDP_FADDR, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 | 08  | 07 06 05 04 03 02 01 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | FEN | FADD
    @
    @ FADD : The Function Address Value must be programmed by firmware once the device receives a set address request from the
    @        host, and has achieved the status stage of the no-data control sequence.
    @ FEN : Read : 0 = Function endpoint disabled.
    @            : 1 = Function endpoint enabled.
    @       Write : 0 = Disables function endpoint.
    @             : 1 = Default value.

    @ Register UDP_IER, write-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 | 13     | 12 | 11     | 10     | 09    | 08     | 07     | 06     | 05     | 04     | 03     | 02     | 01     | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | WAKEUP | -  | SOFINT | EXTRSM | RXRSM | RXSUSP | EP7INT | EP6INT | EP5INT | EP4INT | EP3INT | EP2INT | EP1INT | EP0INT
    @
    @ EPxINT : 0 = no effect.
    @        : 1 = Enables corresponding Endpoint Interrupt.
    @ RXSUSP : 0 = no effect.
    @        : 1 = Enables UDP Suspend Interrupt.
    @ RXRSM  : 0 = no effect.
    @        : 1 = Enables UDP Resume Interrupt.
    @ SOFINT : 0 = no effect.
    @        : 1 = Enables Start Of Frame Interrupt.
    @ WAKEUP : 0 = no effect.
    @        : 1 = Enables USB bus Interrupt.

    @ Register UDP_IDR, write-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 | 13     | 12 | 11     | 10     | 09    | 08     | 07     | 06     | 05     | 04     | 03     | 02     | 01     | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | WAKEUP | -  | SOFINT | EXTRSM | RXRSM | RXSUSP | EP7INT | EP6INT | EP5INT | EP4INT | EP3INT | EP2INT | EP1INT | EP0INT
    @
    @ EPxINT : 0 = no effect.
    @        : 1 = Disables corresponding Endpoint Interrupt.
    @ RXSUSP : 0 = no effect.
    @        : 1 = Disables UDP Suspend Interrupt.
    @ RXRSM  : 0 = no effect.
    @        : 1 = Disables UDP Resume Interrupt.
    @ SOFINT : 0 = no effect.
    @        : 1 = Disables Start Of Frame Interrupt.
    @ WAKEUP : 0 = no effect.
    @        : 1 = Disables USB bus Interrupt.
    
    @ Register UDP_IMR, read-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 | 13     | 12    | 11     | 10     | 09    | 08     | 07     | 06     | 05     | 04     | 03     | 02     | 01     | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | WAKEUP | BIT12 | SOFINT | EXTRSM | RXRSM | RXSUSP | EP7INT | EP6INT | EP5INT | EP4INT | EP3INT | EP2INT | EP1INT | EP0INT
    @
    @ EPxINT : 0 = Corresponding Endpoint Interrupt is disabled.
    @        : 1 = Corresponding Endpoint Interrupt is enabled.
    @ RXSUSP : 0 = UDP Suspend Interrupt is disabled.
    @        : 1 = UDP Suspend Interrupt is enabled.
    @ RXRSM  : 0 = UDP Resume Interrupt is disabled.
    @        : 1 = UDP Resume Interrupt is enabled.
    @ SOFINT : 0 = Start of Frame Interrupt is disabled.
    @        : 1 = Start of Frame Interrupt is enabled.
    @ BIT12  : Bit 12 of UDP_IMR cannot be masked and is always read at 1.
    @ WAKEUP : 0 = USB Bus Wakeup Interrupt is disabled.
    @        : 1 = USB Bus Wakeup Interrupt is enabled.

    @ Register UDP_ISR, read-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 | 13     | 12        | 11     | 10     | 09    | 08     | 07     | 06     | 05     | 04     | 03     | 02     | 01     | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | WAKEUP | ENDBUSRES | SOFINT | EXTRSM | RXRSM | RXSUSP | EP7INT | EP6INT | EP5INT | EP4INT | EP3INT | EP2INT | EP1INT | EP0INT
    @
    @ EPxINT : 0 = No Endpointx Interrupt pending.
    @        : 1 = Endpointx Interrupt has been raised.
    @ RXSUSP : 0 = No UDP Suspend Interrupt pending.
    @        : 1 = UDP Suspend Interrupt has been raised.
    @ RXRSM  : 0 = No UDP Resume Interrupt pending.
    @        : 1 = UDP Resume Interrupt has been raised.
    @ SOFINT : 0 = No Start of Frame Interrupt pending.
    @        : 1 = Start of Frame Interrupt has been raised.
    @ ENDBUSRES : 0 = No End of Bus Reset Interrupt pending.
    @           : 1 = End of Bus Reset Interrupt has been raised.
    @ WAKEUP : 0 = No Wakeup Interrupt pending.
    @        : 1 = A Wakeup Interrupt (USB Host Sent a RESUME or RESET) occurred since the last clear.

    @ Register UDP_ISR, read-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 | 13     | 12        | 11     | 10     | 09    | 08     | 07     | 06     | 05     | 04     | 03     | 02     | 01     | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | WAKEUP | ENDBUSRES | SOFINT | EXTRSM | RXRSM | RXSUSP | EP7INT | EP6INT | EP5INT | EP4INT | EP3INT | EP2INT | EP1INT | EP0INT
    @
    @ EPxINT : 0 = No Endpointx Interrupt pending.
    @        : 1 = Endpointx Interrupt has been raised.
    @ RXSUSP : 0 = No UDP Suspend Interrupt pending.
    @        : 1 = UDP Suspend Interrupt has been raised.
    @ RXRSM  : 0 = No UDP Resume Interrupt pending.
    @        : 1 = UDP Resume Interrupt has been raised.
    @ SOFINT : 0 = No Start of Frame Interrupt pending.
    @        : 1 = Start of Frame Interrupt has been raised.
    @ ENDBUSRES : 0 = No End of Bus Reset Interrupt pending.
    @           : 1 = End of Bus Reset Interrupt has been raised.
    @ WAKEUP : 0 = No Wakeup Interrupt pending.
    @        : 1 = A Wakeup Interrupt (USB Host Sent a RESUME or RESET) occurred since the last clear.

    @ Register UDP_ICR, write-only
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 | 13     | 12        | 11     | 10     | 09    | 08     | 07 06 05 04 03 02 01 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | WAKEUP | ENDBUSRES | SOFINT | EXTRSM | RXRSM | RXSUSP | -  -  -  -  -  -  -  -
    @
    @ RXSUSP : 0 = No effect.
    @        : 1 = Clears UDP Suspend Interrupt.
    @ RXRSM  : 0 = No effect.
    @        : 1 = Clears UDP Resume Interrupt.
    @ SOFINT : 0 = No effect.
    @        : 1 = Clears Start of Frame Interrupt.
    @ ENDBUSRES : 0 = No effect.
    @           : 1 = Clears End of Bus Reset Interrupt.
    @ WAKEUP : 0 = No effect.
    @        : 1 = Clears Wakeup Interrupt.

    @ Register UDP_RST_EP, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 | 07  | 06  | 05  | 04  | 03  | 02  | 01  | 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | EP7 | EP6 | EP5 | EP4 | EP3 | EP2 | EP1 | EP0
    @
    @ EPx : 0 = No reset.
    @     : 1 = Forces the corresponding endpoint FIF0 pointers to 0, therefore RXBYTECNT field is read at 0 in UDP_CSRx register.

    @ Register UDP_CSRx, read-write
    @ 31 30 29 28 27 | 26 25 24 23 22 21 20 19 18 17 16 | 15    | 14 | 13 | 12 | 11    | 10 09 08 | 07  | 06          | 05          | 04       | 03                | 02      | 01          | 00
    @ -  -  -  -  -  | RXBYTECNT                        | EPEDS | -  | -  | -  | DTGLE | EPTYPE   | DIR | RX_DATA_BK1 | FORCE_STALL | TXPKTRDY | STALLSENTISOERROR | RXSETUP | RX_DATA_BK0 | TXCOMP
    @
    @ TXCOMP : Write : 0 = Clear flag, clear interrupt.
    @                : 1 = No effect.
    @        : Read : 0 = Data IN transaction has not been acknowledged by the host.
    @               : 1 = Data IN transaction is achieved, acknowledged by the host.
    @ RX_DATA_BK0 : Write : 0 = Notify USB peripheral device that data have been read in the FIFO's Bank 0.
    @                     : 1 = To leave the read value unchanged.
    @               Read  : 0 = No data packet has been received in the FIFO's Bank 0.
    @                     : 1 = A data packet has been received, it has been stored in the FIFO's Bank 0.
    @ RXSETUP : Read : 0 = No setup packet available.
    @                : 1 = A setup data packet has been sent by the host and is available in the FIFO.
    @           Write : 0 = Device firmware notifies the USB peripheral device that it has read the setup data in the FIFO.
    @                 : 1 = No effect.
    @ STALLSENT : Read : 0 = The host has not acknowledged a STALL.
    @                  : 1 = Host has acknowledged the STALL.
    @             Write : 0 = Resets the STALLSENT flag, clears the interrupt.
    @                   : 1 = No effect.
    @ ISOERROR : Read : 0 = No error in the previous isochronous transfer.
    @                 : 1 = CRC error has been detected, data available in the FIFO are corrupted.
    @            Write : 0 = Resets the ISOERROR flag, clears the interrupt.
    @                  : 1 = No effect.
    @ TXPKTRDY : Read : 0 = There is no data to send.
    @                 : 1 = The data is waiting to be sent upon reception of token IN.
    @            Write : 0 = Can be used in the procedure to cancel transmission data. 
    @                  : 1 = A new data payload has been written in the FIFO by the firmware and is ready to be sent.
    @ FORCESTALL : Read : 0 = Normal state.
    @                   : 1 = Stall state.
    @              Write : 0 = Return to normal state.
    @                    : 1 = Send STALL to the host.
    @ RX_DATA_BK1 : Read : 0 = No data packet has been received in the FIFO's Bank 1.
    @                    : 1 = A data packet has been received, it has been stored in FIFO's Bank 1.
    @               Write : 0 = Notifies USB device that data have been read in the FIFO’s Bank 1.
    @                     : 1 = To leave the read value unchanged.
    @ DIR : Read-Write : 0 = Allows Data OUT transactions in the control data stage.
    @                  : 1 = Enables Data IN transactions in the control data stage.
    @ EPTYPE : Read-Write : 000 CTRL
    @                     : 001 ISO_OUT
    @                     : 101 ISO_IN
    @                     : 010 BULK_OUT
    @                     : 110 BULK_IN
    @                     : 011 INT_OUT
    @                     : 111 INT_IN
    @ DTGLE : Read : 0 = Identifies DATA0 packet.
    @              : 1 = Identifies DATA1 packet.
    @ EPEDS : Read : 0 = Endpoint disabled.
    @              : 1 = Endpoint enabled.
    @         Write : 0 = Disables endpoint.
    @               : 1 = Enables endpoint.
    @ RXBYTECNT : Read : Amount of bytes received
    
    @ Register UDP_FDRx, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 09 08 | 07 06 05 04 03 02 01 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | FIFO_DATA
    @
    @ FIFO_DATA : Read-Write : value to send or received

    @ Register UDP_TXVC, read-write
    @ 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 | 09   | 08      | 07 06 05 04 03 02 01 00
    @ -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  | PUON | TXVDIS  | -  -  -  -  -  -  -  -
    @
    @ TXVDIS : Read-Write : Disable UDP transceiver to save power
    @ PUON : Read-Write : 0 = The 1.5KΩ integrated pull-up on DDP is disconnected.
    @                   : 1 = The 1.5 KΩ integrated pull-up on DDP is connected.

    


