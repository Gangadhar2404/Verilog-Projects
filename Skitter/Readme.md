# Skitter Circuit with Histogram for Voltage-Based Delay Analysis

This repository contains a **Verilog HDL implementation of a Skitter Circuit** — a module for analyzing **signal propagation delay variations caused by voltage fluctuations**.

---

## 📘 Description

A **Skitter Circuit** tracks the **movement of a rising clock edge** through a chain of buffers, allowing precise monitoring of **delay shifts** due to voltage variations.  
**D flip-flops** sample the buffered signal at each stage, and **XOR-based edge detection logic** identifies the exact buffer stage (bin) where the rising edge occurs.  

A **Histogram Module** counts how many times the edge lands in each bin, providing a **statistical distribution** of delay variations.

**Inputs:**
- `clk` : Main clock signal  
- `rst` : Reset signal  
- `in` : Bin index or edge detection input (for histogram module)  

**Outputs:**
- `edge_position` : Position of rising edge in the buffer chain  
- `binXX_YY` : Histogram counters showing how many times the edge was captured in each bin  

---

### 💡 Features

- Tracks rising edge movement across **buffer stages** under voltage fluctuations  
- **XOR-based edge detection** to determine exact stage (bin) of edge occurrence  
- **Histogram counters** for statistical analysis of delay shifts  
- Provides **voltage-sensitive timing characterization**  
- Implemented in **Verilog HDL** and simulated in **Xilinx Vivado**  

---

### ⚡ Operation Table

| Operation                   | Condition                                   | Action                                      |
|------------------------------|--------------------------------------------|--------------------------------------------|
| Edge propagation             | Clock passes through buffer chain           | Rising edge moves stage by stage           |
| Edge detection               | XOR of adjacent flip-flops                  | Detect exact buffer stage (bin)            |
| Histogram update             | Rising edge captured in a bin               | Increment corresponding bin counter        |
| Voltage fluctuation          | Supply voltage changes                      | Edge may shift forward/backward, reflected in histogram |

---

### ⚙️ Notes

- **Buffer chain:** Creates incremental delay for edge propagation  
- **D flip-flops:** Sample signal at each stage for precise timing  
- **XOR edge detection:** Identifies transition between stages  
- **Histogram module:** Tracks statistical distribution of edge occurrences  
- **Applications:** On-chip voltage sensitivity analysis

---

## 🔄 Flow and Working

The **Skitter Circuit with Histogram** works by tracking how a rising clock edge propagates through a chain of buffers and recording its position in histogram bins. The overall flow can be summarized as follows:

### 1️⃣ Clock Propagation through Buffer Chain
- The **clock signal** enters the **buffer chain**.
- Each **buffer stage introduces incremental delay**, simulating the propagation delay in real circuits.
- The rising edge moves **forward through the stages** based on the delay per buffer.

### 2️⃣ Sampling Using D Flip-Flops
- **D flip-flops** are connected at each buffer stage.
- Flip-flops **sample the signal at every clock cycle**, capturing the current position of the rising edge.
- The sampled outputs form a **bit vector**, representing the edge position across stages.

### 3️⃣ XOR-Based Edge Detection
- Adjacent flip-flop outputs are processed using **XOR logic**:

- This identifies the **exact stage (bin)** where the rising edge is currently located.

### 4️⃣ Histogram Counting
- The detected **bin index** is fed into the **Histogram Module**.
- Each bin (`bin17_18`, `bin19_20`, …, `bin37_38`) maintains a **counter**.
- The counter **increments every time the rising edge is detected** in that bin.
- Over multiple clock cycles, a **statistical distribution** of delay positions is obtained.

### 5️⃣ Monitoring Voltage Fluctuation Effects
- When **supply voltage changes**, buffer delays vary.
- This causes the **rising edge to shift forward or backward**.
- The histogram **captures these shifts**, providing a visual and statistical insight into **voltage-sensitive delay variations**.

### 6️⃣ Summary Flow
Clock Signal -> Buffer Chain -> D Flip-Flops -> XOR Edge Detection -> Histogram Counters -> Voltage Delay Analysis


- This flow enables **real-time tracking** and **statistical monitoring** of signal delays under varying voltage conditions.

