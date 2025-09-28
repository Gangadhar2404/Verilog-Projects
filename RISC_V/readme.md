
---

## **Sample Simulation Output**

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
- Simulation-only (no FPGA synthesis)

---

## **Future Improvements**
- Full RV32I instruction set (mul/div, CSR instructions)  
- Hardware hazard detection & forwarding  
- Branch prediction & pipeline flush  
- Multi-port memory for concurrency  
- Exception and interrupt handling  
- FPGA synthesis and bitstream generation  

---

## **Author**
**Gangadhar** – Electronics & Communication Engineering, BE from Government SKSJTI  

---

## **License**
Educational use; freely modifiable for learning.
