# Synchronous FIFO Verilog Implementation

This repository contains a **Verilog HDL implementation of a synchronous FIFO (First-In-First-Out) memory** — a commonly used module for buffering data in digital designs.

---

## 📘 Description

A **FIFO** stores data in the order it is written and outputs it in the same order.  
This design is **parameterizable** for different data widths and depths.

**Inputs:**
- `clk` : System clock  
- `rst` : Reset  
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
- Synchronous design (single clock domain)  
- Full and empty flags using pointer MSB trick  
- Circular buffer implementation  

---

### ⚡ Operation Table

| Operation      | Condition                     | Action                                      |
|----------------|-------------------------------|--------------------------------------------|
| Write          | `w_en && !full`               | Write `data_in` to FIFO, increment `w_ptr` |
| Read           | `r_en && !empty`              | Read FIFO into `data_out`, increment `r_ptr` |
| Full           | `{~w_ptr[MSB], w_ptr[addr]} == r_ptr` | `full` flag set                             |
| Empty          | `w_ptr == r_ptr`              | `empty` flag set                            |

---
