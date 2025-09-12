# Pipelined MIPS-like Processor with Two-Phase Clock

This project implements a **5-stage pipelined MIPS-like processor** in Verilog with:

- 32 general-purpose registers (`REG_FILE[0:31]`)  
- 1024-word unified memory (`MEM[0:1023]`)  
- R-type, I-type, Load/Store, Branch, and HALT instructions  
- Two-phase clocking (`CLK1`, `CLK2`) to separate pipeline stages  
- Simple branch flush and HALT handling


![Pipeline Diagram](44ef724e-5274-4385-bb33-32e48d0f2ad1.png)

---

## 📂 Project Structure

├── RISC_MIPS.v # Pipelined processor design
├── Tb_RISC_MIPS.v # Testbench with instructions and verification
├── README.md # Documentation


---

## 🧩 Instruction Set Architecture (ISA)

### 1️⃣ R-type (Register ALU)
[31:26] opcode | [25:21] rs | [20:16] rt | [15:11] rd | [10:0] unused

- Operations: ADD, SUB, AND, OR, SLT, MUL  
- Destination: `rd`  
- Source: `rs`, `rt`  

### 2?? I-type (Register-Immediate ALU)
[31:26] opcode | [25:21] rs | [20:16] rt | [15:0] immediate

- Operations: ADDI, SUBI, SLTI  
- Destination: `rt`  
- Source: `rs + immediate`  

### 3️⃣ Load/Store
[31:26] opcode | [25:21] base | [20:16] rt | [15:0] offset

- LW: `rt = MEM[base + offset]`  
- SW: `MEM[base + offset] = rt`  

### 4️⃣ Branch
[31:26] opcode | [25:21] rs | [20:16] unused | [15:0] offset

- BEQZ: branch if `rs == 0`  
- BNEQZ: branch if `rs != 0`  

### 5️⃣ HALT
[31:26] opcode | [25:0] unused

- Stops processor execution

---

## 🏗️ Pipeline Stages

| Stage | Clock | Description |
|-------|-------|-------------|
| IF    | CLK1  | Fetch instruction, increment PC, handle branch redirect |
| ID    | CLK2  | Decode opcode, read registers, sign-extend immediate, assign instruction type |
| EX    | CLK1  | ALU computation, branch target calculation, branch condition evaluation |
| MEM   | CLK2  | Memory read/write, forward ALU result |
| WB    | CLK1  | Write results to register file, HALT handling |

**Branch Handling:**
- `TAKEN_BRANCH` flushes the instruction in ID stage.  
- Branch target PC computed in EX stage (`EX_MEM_ALUOUT`).  

**Registers & Memory:**
- Registers: `REG_FILE[0:31]` (x0 always 0)  
- Memory: `MEM[0:1023]` (word-addressable)

---

## 🔧 Control Signals

- `TAKEN_BRANCH` → flush pipeline on branch taken  
- `HALTED` → stops further instruction fetch  
- `EX_MEM_COND` → branch condition evaluation  

---

## 🧪 Testbench Example

- Two-phase clock generation:
```verilog
initial begin
  CLK1 = 0; CLK2 = 0;
  forever begin
    #5 CLK1 = 1; #5 CLK1 = 0;
    #5 CLK2 = 1; #5 CLK2 = 0;
  end
end

Memory and register initialization:

for (k = 0; k < 1024; k = k + 1) cpu.MEM[k] = 32'd0;
for (k = 0; k < 32;   k = k + 1) cpu.REG_FILE[k] = 32'd0;

Sample instructions loaded:

cpu.MEM[0] = {6'b001010, 5'd0, 5'd1, 16'd5};    // ADDI R1,R0,5
cpu.MEM[1] = {6'b001010, 5'd0, 5'd2, 16'd10};   // ADDI R2,R0,10
cpu.MEM[4] = {6'b000000, 5'd1, 5'd2, 5'd3, 11'd0}; // ADD R3,R1,R2
cpu.MEM[13]= {6'b001001, 5'd0, 5'd3, 16'd30};   // SW R3,30(R0)
cpu.MEM[16]= {6'b001000, 5'd0, 5'd12,16'd30};   // LW R12,30(R0)
cpu.MEM[34]= {6'b111111, 26'd0};                // HALT


Expected results (partial):

R1  = 5
R2  = 10
R3  = 15
R12 = 15
MEM[30] = 15

⚡ Notes

x0 (REG_FILE[0]) is hardwired to 0

HALT stops all subsequent instruction execution

Branch instructions flush the pipeline to avoid incorrect execution

Throughput: 1 instruction per cycle after pipeline is filled

📊 Pipeline Diagram (Conceptual)

Cycle:   1    2    3    4    5    6    7
Instr1:  IF -> ID -> EX -> MEM -> WB
Instr2:       IF -> ID -> EX -> MEM -> WB
Instr3:            IF -> ID -> EX -> MEM -> WB
...


IF/EX: CLK1

ID/MEM: CLK2

WB: CLK1


---

<img width="1887" height="603" alt="pipelining_Schematic" src="https://github.com/user-attachments/assets/19744afc-4e25-43b0-bb07-a0157a7028de" />



