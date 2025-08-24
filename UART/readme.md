# UART Verilog Implementation

This repository contains a **Verilog HDL implementation and testbench for a UART (Universal Asynchronous Receiver/Transmitter)** — a key module for asynchronous serial communication.  

---

## 📘 Description

UART allows devices to communicate **bit by bit** without a shared clock. Data transmission uses:

- **Start bit** → `0`  
- **Data bits** → typically 8 bits, LSB first  
- **Stop bit** → `1`  

This project includes three main modules:

1. **Baudrate Generator** – produces `tick` signals to synchronize transmission/reception.  
2. **Transmitter (TX)** – FSM-based module to send 8-bit data serially.  
3. **Receiver (RX)** – FSM-based module to receive 8-bit data and indicate when data is ready.  

---

## 💡 Modules & Features

### **1. Baudrate Generator**
- Generates timing tick based on `freq` (system clock) and `baud` (UART speed).  
- Uses 16x oversampling for reliable reception.  
- Parameters:  
  - `freq` : System clock in Hz  
  - `baud` : UART baud rate in bps  

---

### **2. Transmitter (TX)**
FSM with 4 states:

| State  | Description                             | TX Output | Busy |
|--------|-----------------------------------------|-----------|------|
| IDLE   | Waiting for `load` signal                | 1         | 0    |
| START  | Send start bit `0`                       | 0         | 1    |
| DATA   | Shift out 8 data bits LSB first          | Data bit  | 1    |
| STOP   | Send stop bit `1`                        | 1         | 0    |

---

### **3. Receiver (RX)**
FSM with 4 states:

| State  | Description                             | Action            | Busy | rx_done |
|--------|-----------------------------------------|-----------------|------|---------|
| IDLE   | Wait for falling edge on RX (start bit) | Detect start     | 0    | 0       |
| START  | Confirm start bit                        | Sample at mid-bit| 1    | 0       |
| DATA   | Sample 8 data bits LSB first             | Shift into reg   | 1    | 0       |
| STOP   | Confirm stop bit `1`                     | Output data      | 0    | 1       |