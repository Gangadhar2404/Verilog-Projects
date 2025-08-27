# Verilog Communication & FIFO Modules

This repository contains **Verilog HDL implementations** of commonly used digital design modules: **UART, Asynchronous FIFO, and Synchronous FIFO**. These modules are designed to be **parameterizable**, **modular**, and suitable for FPGA/ASIC projects.

---

## 1. UART (Universal Asynchronous Receiver/Transmitter)

A UART module enables serial communication by converting parallel data into serial data and vice versa. It is commonly used to interface microcontrollers and peripherals.

### 📘 Description
- Converts parallel data to serial data for transmission (`tx`) and serial data to parallel data for reception (`rx`).  
- Supports configurable data width and baud rate.  

**Inputs:**
- `clk` : System clock  
- `rst` : Reset  
- `tx_data` : Data to transmit  
- `rx` : Serial input  

**Outputs:**
- `tx` : Serial output  
- `rx_data` : Data received  

### 💡 Features
- Parameterizable data width and baud rate  
- Simple interface  
- Fully synthesizable  

### ⚡ Operation Table

| Operation      | Condition          | Action                                  |
|----------------|------------------|----------------------------------------|
| Transmit       | `tx_valid`        | Load `tx_data` into shift register and send serially |
| Receive        | Serial data present | Shift bits into receive register until complete byte |
| Ready          | No transmission/receive pending | UART is ready for next byte |

---

## 2. Asynchronous FIFO (Async FIFO)

This module buffers data between **different clock domains**, preventing metastability issues.

### 📘 Description
A **FIFO** stores data in the order it is written and outputs it in the same order.  
Supports **different write and read clocks**, using **Gray-coded pointers with two-flop synchronizers**.

**Inputs:**
- `w_clk` : Write clock  
- `r_clk` : Read clock  
- `rst` : Asynchronous reset  
- `w_en` : Write enable  
- `r_en` : Read enable  
- `data_in` : Data to write  

**Outputs:**
- `data_out` : Data read from FIFO  
- `full` : High when FIFO is full  
- `empty` : High when FIFO is empty  

### 💡 Features
- Parameterizable **data width** and **FIFO depth**  
- Gray-coded pointers with 2-flop synchronizers for safe CDC  
- Full and empty flags  
- Synthesizable for FPGA/ASIC  

### ⚡ Operation Table

| Operation       | Condition                     | Action                                         |
|-----------------|-------------------------------|-----------------------------------------------|
| Write           | `w_en && !full`               | Write `data_in` to FIFO, increment `wb_ptr`  |
| Read            | `r_en && !empty`              | Read FIFO into `data_out`, increment `rb_ptr` |
| Empty           | `rg_ptr == wg_ptr_sync2`      | `empty` flag set                              |
| Full            | `wg_ptr_next == {~rg_ptr_sync2[MSB:MSB-1], rg_ptr_sync2[MSB-2:0]}` | `full` flag set |

---

## 3. Synchronous FIFO (Sync FIFO)

This module buffers data **within the same clock domain** for reliable sequential access.

### 📘 Description
- Stores data in order of writing and outputs in the same order.  
- Single clock domain design.  

**Inputs:**
- `clk` : System clock  
- `rst` : Reset  
- `wr_en` : Write enable  
- `rd_en` : Read enable  
- `data_in` : Data to write  

**Outputs:**
- `data_out` : Data read from FIFO  
- `full` : High when FIFO is full  
- `empty` : High when FIFO is empty  

### 💡 Features
- Parameterizable **data width** and **FIFO depth**  
- Simple same-clock interface  
- Full and empty flags  
- Synthesizable for FPGA/ASIC  

### ⚡ Operation Table

| Operation       | Condition           | Action                                      |
|-----------------|-------------------|--------------------------------------------|
| Write           | `wr_en && !full`    | Write `data_in` to FIFO, increment write pointer |
| Read            | `rd_en && !empty`   | Read FIFO into `data_out`, increment read pointer |
| Empty           | `rd_ptr == wr_ptr`  | `empty` flag set                            |
| Full            | `wr_ptr_next == rd_ptr` | `full` flag set                          |

---

## 📂 Directory Structure
