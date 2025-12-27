# UART_PROTOCOL
UART Protocol Implementation on FPGA in Verilog

# Overview
This project is a complete UART communication system written in Verilog, designed for FPGA or simulation-based testing.
It includes:
UART Transmitter
UART Receiver with oversampling
transmitter ans reciver testbenchs for verification

# Key Specs
Clock Frequency: 100 MHz (configurable)
Baud Rate: 9600 bps (configurable)
Receiver Oversampling: ×4
Data Depth:1 byte

# FPGA BOARD:-
Xillinx Edge spartan 7

# Software use:-
Tera term

 # Project Structure
UART_PROTOCOL/

│

├── transmitter.sv     # UART transmitter

├── receiver.sv        # UART receiver with oversampling

├── mem.txt           # memory file containig a 1 byte number(1000_0001)

├──Testbench

  ├──Testbench/reciver.sv     # Testbench for reciever

  ├── top.sv      # Self-checking  testbench includes both trasmitter and receiver at 2 different clock

  └── transmitter.sv #Testbench for transmitter



# Module Descriptions
1. Transmitter (transmitter.sv)
Converts 8-bit parallel data into serial UART format.
Frame: 1 Start bit → 8 Data bits → 1 Stop bit.
Parameters:
CLK_FREQ (default 100 MHz)
BAUD_RATE (default 9600 bps)
 Outputs:
txd: Serial data line
busy: Transmission on flag

2. Receiver (receiver.sv)
Receives UART serial data with ×4 oversampling.
Assembles bits into an 8-bit data word.
Parameters:
CLK_FREQ (default 100 MHz)
BAUD_RATE (default 9600)
DIV_SAMPLE (default 4)
Outputs:
rxddata: Received byte
rdone: High when a full byte is received




# Data Flow Diagram
Transmitter:-
<img width="4270" height="5530" alt="image" src="https://github.com/user-attachments/assets/5a89eae5-57f6-4dbf-8c9a-5868a3c67399" />

Reciever:-
<img width="10423" height="8005" alt="image" src="https://github.com/user-attachments/assets/8f6f2c86-4484-4877-962e-a00ba9fd91ed" />

# Parameters Overview
Parameter	Module	Description	Default
CLK_FREQ	TX, RX	System clock frequency (Hz)	100_000_000
BAUD_RATE	TX, RX	UART baud rate	9600
DIV_SAMPLE	RX	Oversampling factor	4
WIDTH	Memory	Data width (bits)	8

# Applications
FPGA-based UART debugging
Embedded systems training
Educational projects in digital communication

Hardware protocol verification
