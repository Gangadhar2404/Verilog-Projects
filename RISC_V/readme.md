# RISC-V Processor RTL (RV32I Subset)



This project implements a simplified **RV32I RISC-V processor** in Verilog. It features a 5-stage pipeline and supports a subset of RISC-V instructions including arithmetic, logical, shift, load/store, and branch operations. This design is **educational and modular**, ideal for understanding pipeline behavior, ALU operations, and hazard handling.  

---

## **Features**

- **Pipeline Stages**:
  1. **Fetch (F)** – Fetch instructions from `Instruction_Memory`.
  2. **Decode (D)** – Read register file, sign-extend immediate, generate control signals.
  3. **Execute (E)** – Perform ALU operations and calculate branch targets.
  4. **Memory (M)** – Execute load/store operations.
  5. **Write-Back (W)** – Write results back to register file.

- **Supported Instructions (Operations)**:

| Type      | Instruction | Syntax         | Description |
|-----------|------------|----------------|------------|
| **R-Type** | `add`      | `add rd, rs1, rs2` | Adds two registers |
|           | `sub`      | `sub rd, rs1, rs2` | Subtracts two registers |
|           | `and`      | `and rd, rs1, rs2` | Bitwise AND |
|           | `or`       | `or rd, rs1, rs2`  | Bitwise OR |
|           | `xor`      | `xor rd, rs1, rs2` | Bitwise XOR |
|           | `sll`      | `sll rd, rs1, rs2` | Logical shift left |
|           | `srl`      | `srl rd, rs1, rs2` | Logical shift right |
| **I-Type** | `addi`     | `addi rd, rs1, imm` | Add immediate |
|           | `andi`     | `andi rd, rs1, imm` | AND with immediate |
|           | `ori`      | `ori rd, rs1, imm` | OR with immediate |
|           | `xori`     | `xori rd, rs1, imm` | XOR with immediate |
|           | `slli`     | `slli rd, rs1, shamt` | Shift left logical immediate |
|           | `srli`     | `srli rd, rs1, shamt` | Shift right logical immediate |
|           | `nop`      | `addi x0, x0, 0` | No operation |
| **Load/Store** | `lw`   | `lw rd, offset(rs1)` | Load word from memory |
|           | `sw`       | `sw rs2, offset(rs1)` | Store word to memory |
| **Branch** | `beq`      | `beq rs1, rs2, label` | Branch if equal |

- **ALU Zero Flag** for branch evaluation  
- Manual **hazard handling** using NOP insertion  
- Register file with **32 general-purpose registers (x0–x31)**  
- Modular design for easy understanding and modification  

---

## **Vivado Simulation Setup**

### Requirements
- **Xilinx Vivado** (any version supporting Verilog simulation)  
- Basic familiarity with Vivado **RTL simulation**

### Running Simulation
1. Create a new **RTL Project** in Vivado.  
2. Add all Verilog files from your project (RTL modules and `tb_TopModule.v` testbench).  
3. Set `tb_TopModule` as the **top module for simulation**.  
4. Launch **Simulation > Run Behavioral Simulation**.  
5. Observe **register outputs** in the Waveform window or via `$display` statements in the testbench.


---

## **Pipeline Diagram**

| Fetch (F) | Decode (D) | Execute (E) | Memory (M) | Write Back (W) |
|------------|------------|-------------|------------|----------------|
|     →      |     →      |      →      |     →      |       →        |


---


## Sample Simulation Output (Register Values per Cycle)

The table below shows the contents of the 32 registers (`x0`–`x31`) during the first 50 simulation cycles. `x` indicates an undefined or uninitialized value at that cycle.

| Cycle | x0 | x1  | x2  | x3  | x4  | x5       | x6 | x7  | x8  | x9 | x10 | x11 | x12 | x13 | x14 | x15 | x16 | x17 | x18 | x19 | x20 | x21 | x22 | x23 | x24 | x25 | x26 | x27 | x28 | x29 | x30 | x31 |
|-------|----|-----|-----|-----|-----|----------|----|-----|-----|----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
| 0     | 0  | x   | x   | x   | x   | x        | x  | x   | x   | x  | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   |
| 1     | 0  | x   | x   | x   | x   | x        | x  | x   | x   | x  | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   |
| 4     | 0  | 10  | x   | x   | x   | x        | x  | x   | x   | x  | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   |
| 5     | 0  | 10  | 20  | x   | x   | x        | x  | x   | x   | x  | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   |
| 9     | 0  | 10  | 20  | 30  | x   | x        | x  | x   | x   | x  | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   |
| 10    | 0  | 10  | 20  | 30  | 10  | x        | x  | x   | x   | x  | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   |
| 15    | 0  | 10  | 20  | 30  | 10  | 10485760  | 0  | 30  | 30  | 0  | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   |
| 20    | 0  | 10  | 20  | 30  | 10  | 10485760  | 0  | 30  | 30  | 0  | 20  | x   | 20  | 5   | 0   | 15  | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   | x   |
| 30    | 0  | 10  | 20  | 30  | 10  | 10485760  | 0  | 30  | 30  | 0  | 20  | x   | 20  | 5   | 0   | 15  | 10  | x   | 30  | x   | 20  | 5   | x   | x   | x   | 35  | 10  | 60  | 10  | x   | x   | x   |
| 49    | 0  | 10  | 20  | 30  | 10  | 10485760  | 0  | 30  | 30  | 0  | 20  | x   | 20  | 5   | 0   | 15  | 10  | x   | 30  | x   | 20  | 5   | x   | x   | x   | 35  | 10  | 60  | 10  | x   | x   | x   |

> ⚠ **Note:** `x` indicates uninitialized or unknown values.  
> The full 50-cycle simulation can be viewed in `tb_TopModule.v` or the waveform output in Vivado.


---

## **Advantages**
- Clear **modular design** for each pipeline stage  
- Demonstrates **pipeline execution and data flow**  
- Supports basic RV32I subset for learning purposes  
- Simple hazard management via NOPs  

---

## **Limitations**
- Only a subset of RV32I implemented  
- Manual NOP insertion for hazard avoidance  
- No forwarding or branch prediction  
- Single-port memory  

---

## **Future Improvements**
- Full RV32I instruction set (mul/div, CSR instructions)  
- Hardware hazard detection & forwarding  
- Branch prediction & pipeline flush  

---

## **Author**
**Gangadhara K** – Electronics & Communication Engineering, BE from Government SKSJTI  

---

## **License**
Educational use; freely modifiable for learning.

---
## **References**

- Merl – Lecture notes on RISC-V and pipeline design.

- Hardware Modelling Using Verilog – YouTube lectures by Prof. Indranil Sengupta.

