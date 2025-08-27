# Verilog Communication & Analysis Modules

This repository contains **Verilog HDL implementations** of UART, FIFOs, and a Skitter Circuit for FPGA/ASIC projects.

---

## 1. UART
- Provides serial communication (parallel ↔ serial).  
- Configurable data width and baud rate.  
- Inputs: `clk`, `rst`, `tx_data`, `rx`; Outputs: `tx`, `rx_data`.  
- Fully synthesizable and easy to interface with FIFOs.

---

## 2. Asynchronous FIFO
- Buffers data between different clock domains safely.  
- Gray-coded pointers with 2-flop synchronizers prevent metastability.  
- Inputs: `w_clk`, `r_clk`, `rst`, `w_en`, `r_en`, `data_in`; Outputs: `data_out`, `full`, `empty`.  
- Parameterizable width and depth, synthesizable for FPGA/ASIC.

---

## 3. Synchronous FIFO
- Buffers data within the same clock domain.  
- Simple interface with full and empty flags.  
- Inputs: `clk`, `rst`, `wr_en`, `rd_en`, `data_in`; Outputs: `data_out`, `full`, `empty`.  
- Parameterizable width and depth, synthesizable for FPGA/ASIC.

---

## 4. Skitter Circuit
- Tracks rising edge propagation through buffer stages under voltage variations.  
- XOR-based edge detection identifies exact buffer stage (bin).  
- Histogram counters provide statistical distribution of edge positions.  
- Inputs: `clk`, `rst`, `in`; Outputs: `edge_position`, `binXX_YY`; implemented in Verilog and simulated in Vivado.

---


