# Single-Cycle RISC-V-Like Processor

This project implements a **single-cycle RISC-V-like processor** in Verilog with:

- 32 general-purpose registers (`x0-x31`, `x0` always 0)  
- 1024-word data and instruction memory  
- R-type, I-type, Load/Store, Branch instructions  
- ALU supporting ADD, SUB, AND, OR, SLT  
- Flag outputs: Zero, Negative, Overflow, Carry  
- Program counter (PC) with branch support  

---

## 📂 Project Structure

├── TopModule.v # Top-level processor module

├── Program_Counter.v # PC logic

├── Adder.v # Adder for PC + offset

├── Instruction_Memory.v

├── Register_file.v

├── Sign_Extend.v

├── ALU.v

├── ALU_Decoder.v

├── Control_unit.v

├── Data_Memory.v

├── mux1.v / mux2.v

├── Tb_TopModule.v # Testbench with simulation and verification

├── README.md


---

## 🧩 Instruction Set Architecture (ISA)

### 1️⃣ R-type (Register ALU)
- Format: `[31:25] func7 | [24:20] rs2 | [19:15] rs1 | [14:12] func3 | [11:7] rd | [6:0] opcode`
- Operations: ADD, SUB, AND, OR, SLT  
- Destination: `rd`  
- Sources: `rs1`, `rs2`

### 2️⃣ I-type (Immediate ALU / Load)
- Format: `[31:20] imm | [19:15] rs1 | [14:12] funct3 | [11:7] rd | [6:0] opcode`
- Operations: ADDI, SUBI, LW  
- Destination: `rd`  
- Source: `rs1 + imm`

### 3️⃣ S-type (Store)
- Format: `[31:25] imm[11:5] | [24:20] rs2 | [19:15] rs1 | [14:12] funct3 | [11:7] imm[4:0] | [6:0] opcode`
- Operation: SW (`MEM[rs1+imm] = rs2`)

### 4️⃣ B-type (Branch)
- Format: `[31] imm[12] | [30:25] imm[10:5] | [24:20] rs2 | [19:15] rs1 | [14:12] funct3 | [11:8] imm[4:1] | [7] imm[11] | [6:0] opcode`
- Operations: BEQ, BNE

---

## 🏗️ Processor Modules

| Module                  | Description |
|-------------------------|-------------|
| `TopModule`             | Top-level processor, instantiates ALU, RF, memory, control, PC logic |
| `Program_Counter`       | Updates PC with next address or branch target |
| `Adder`                 | PC + 4 or PC + immediate |
| `Instruction_Memory`    | Fetches instruction from program memory |
| `Register_file`         | 32-register file with asynchronous read, synchronous write |
| `Sign_Extend`           | Extends immediate values based on instruction type |
| `Control_unit`          | Generates control signals from opcode and flags |
| `ALU_Decoder`           | Converts ALUOp + funct fields to ALU control |
| `ALU`                   | Computes arithmetic/logic operations, sets flags |
| `Data_Memory`           | Word-addressable data memory for load/store |
| `mux1` / `mux2`         | Select ALU input and write-back data |

---

## 🔧 Control Signals

| Signal      | Function |
|------------|---------|
| `RegWrite` | Enable register write-back |
| `ALUSrc`   | Select ALU input: register or immediate |
| `MemWrite` | Enable memory write |
| `ResultSrc`| Select write-back data: ALU result or memory data |
| `ImmSrc`   | Select immediate type: I, S, B |
| `ALUOp`    | ALU operation code for decoder |
| `PcSrc`    | Select PC source (branch taken or PC+4) |

---

## 🧪 Testbench Example

- Clock generation:

```verilog
initial clk = 0;
always #5 clk = ~clk; // 10ns period

Initialize registers & memory:

dut.RF.Register_Bank[1] = 32'd5;    // x1
dut.RF.Register_Bank[2] = 32'd10;   // x2
dut.DM.Data_Memory[0] = 32'd99;     // preload


dut.IM.I_Mem[0] = 32'b0000000_00010_00001_000_00011_0110011; // ADD x3,x1,x2
dut.IM.I_Mem[1] = 32'b0100000_00010_00001_000_00100_0110011; // SUB x4,x1,x2
dut.IM.I_Mem[2] = 32'b0000000_00010_00001_111_01000_0110011; // AND x8,x1,x2
dut.IM.I_Mem[3] = 32'b0000000_00010_00001_110_01001_0110011; // OR x9,x1,x2
dut.IM.I_Mem[4] = 32'b0000000_00010_00001_010_01010_0110011; // SLT x10,x1,x2


```
---
## Sample expected results:

Register	Value
x3	         15
x4	        -5
x8	         0
x9	         15
x10	         1
x15	        15


Zero, Negative, Overflow, Cout

## ⚡ Notes

x0 is hardwired to 0.

Branch instructions update PC if PcSrc=1.

Memory and registers are word-addressable.

ALU sets standard flags (Z, N, V, C) for result evaluation.


```
          +----------------+
          |    PC          |
          +--------+-------+
                   |
                   v
          +----------------+
          | Instruction    |
          | Memory (IM)    |
          +--------+-------+
                   |
                   v
          +----------------+
          |  Register File  |
          |   (RF)          |
          +----+------+----+
               |      |
               |      v
               |   +------+
               |   | Mux1 | <- Sign-Extend (imm)
               |   +---+--+
               v       |
           +---+-------+---+
           |      ALU      |
           +---+-------+---+
               |       |
               v       v
          +----+-------+----+
          |   Data Memory   |
          +----+-------+----+
               |
               v
             +----+
             |Mux2|  (select ALU or Memory)
             +----+
               |
               v
          +----------------+
          | Register File   |
          | Writeback (RF) |
          +----------------+
```

- mux1 selects between register or immediate for ALU.

- mux2 selects between ALU or memory for write-back.


## 📚 References

- MERL-DSU – RISC-V processor pipeline architecture reference


