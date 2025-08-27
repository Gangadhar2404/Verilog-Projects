# Asynchronous FIFO Verilog Implementation

This repository contains a **Verilog HDL implementation of an asynchronous FIFO (First-In-First-Out) memory** — a module for buffering data between two different clock domains safely.

---

## 📘 Description

A **FIFO** stores data in the order it is written and outputs it in the same order.  
This design supports **different write and read clocks** and uses **Gray-coded pointers with two-flop synchronizers** to prevent metastability.

**Inputs:**
- `w_clk` : Write clock  
- `r_clk` : Read clock  
- `rst` : Asynchronous reset  
- `w_en` : Write enable  
- `r_en` : Read enable  
- `data_in` : Data to be written  

**Outputs:**
- `data_out` : Data read from FIFO  
- `full` : High when FIFO is full  
- `empty` : High when FIFO is empty  

---

### 💡 Features

- Parameterizable **data width** and **FIFO depth**  
- Asynchronous design (separate read and write clocks)  
- Gray-coded pointers with 2-flop synchronizers for safe CDC  
- Full and empty flags  
- Synthesizable for FPGA/ASIC  

---

### ⚡ Operation Table

| Operation       | Condition                     | Action                                         |
|-----------------|-------------------------------|-----------------------------------------------|
| Write           | `w_en && !full`               | Write `data_in` to FIFO, increment `wb_ptr`  |
| Read            | `r_en && !empty`              | Read FIFO into `data_out`, increment `rb_ptr` |
| Empty           | `rg_ptr == wg_ptr_sync2`      | `empty` flag set                              |
| Full            | `wg_ptr_next == {~rg_ptr_sync2[MSB:MSB-1], rg_ptr_sync2[MSB-2:0]}` | `full` flag set |

---

### ⚙️ Notes

- **Gray-coded pointers:** Prevents metastability during clock domain crossing.  
- **2-flop synchronizers:** Safely pass write pointer to read domain and vice versa.  
- FIFO depth and data width can be adjusted using parameters: `depth` and `width`.  

---

### 📂 Directory Structure

