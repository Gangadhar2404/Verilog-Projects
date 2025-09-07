# 🖥️ 5-Stage Pipelined Processor (RISC-Inspired)

This project implements a **5-stage pipelined CPU** in Verilog, inspired by the RISC architecture.  
It supports arithmetic, logic, memory, branch, and halt instructions with **two-phase clocking** and **hazard handling**.  
Designed and simulated using **Xilinx Vivado**.  

---

## 📂 Project Structure

├── RISC_V.v # Processor RTL design
├── tb_riscv.v # Testbench for simulation
├── README.md # Documentation


---

## 🧩 Module Description

### `RISC_V`
- **Inputs:**
  - `CLK1, CLK2` → Two-phase clock signals  
  - `RST` → Reset (synchronous, active-high)  

- **Internal Registers:**
  - `PC` → Program Counter  
  - `IF/ID`, `ID/EX`, `EX/MEM`, `MEM/WB` → Pipeline registers  
  - `Reg[0:31]` → 32×32 register file (x0 fixed at zero)  
  - `Mem[0:1023]` → Unified 1K×32 instruction/data memory  

- **Output:**
  - `pc_out` → Current program counter  

---

## 🚦 Pipeline Stages

1. **IF – Instruction Fetch:** Fetch instruction and next PC.  
2. **ID – Instruction Decode:** Decode opcode, read registers, generate immediate.  
3. **EX – Execute:** Perform ALU operations and branch evaluation.  
4. **MEM – Memory Access:** Read/write data memory if required.  
5. **WB – Write Back:** Write results back to register file.  

---

## ⚡ Features

- 5-stage instruction pipeline with two-phase clocking  
- Unified instruction/data memory (Harvard-lite style)  
- Register file with x0 hardwired to zero  
- Control hazard flushing for correct branching  
- Supports arithmetic, logic, load/store, branch, and halt instructions  
- **Tested and verified in Xilinx Vivado**  

---

## 🏗️ Timing & Throughput

- **Latency:** 5 cycles for first instruction to complete  
- **Throughput:** 1 instruction per cycle (after pipeline fills)  

---

## ▶️ Simulation Example

Sample execution flow:  
- Arithmetic and logic instructions update registers correctly  
- Load/Store operations interact with unified memory  
- Branch instructions flush incorrect instructions from the pipeline  
- Halt instruction stops program execution  

---

## 🛠️ Running Simulation (Vivado)

1. Open **Xilinx Vivado**.  
2. Create a new project and add `RISC_V.v` and `tb_riscv.v`.  
3. Set the testbench (`tb_riscv.v`) as the simulation top.  
4. Run behavioral simulation.  
5. Use the Vivado waveform viewer to analyze pipeline stages.  

---

## 📘 Tools Used
- Verilog HDL  
- **Xilinx Vivado (Design & Simulation)**  
- GTKWave / Vivado Waveform Viewer  
