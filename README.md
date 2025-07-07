# Riscv-single-cycle
🧠 A simple and educational Single-Cycle RISC-V Processor implemented in Verilog. Simulated using Icarus Verilog and GTKWave, with support for R-type, I-type, and J-type instructions.

--- 

# 🚀 Single-Cycle RISC-V Processor – Verilog Project

This project implements a **Single-Cycle RISC-V CPU** using **Verilog HDL**, simulating the execution of RISC-V instructions at the processor level. Designed from scratch, this CPU supports core RISC-V instruction types — **R**, **I**, and **J** — and is tested using **Icarus Verilog** and **GTKWave**.

> ✅ Built and simulated **without hazard detection or pipelining**, this project focuses on fundamental datapath integration and instruction execution flow.

---

## 🎯 Project Objective

To demonstrate:
- A complete **RTL design** of a basic RISC-V processor
- Instruction decoding, control signal generation, and ALU operation
- Working **datapath** including PC, Register File, ALU, Immediate Generator, and Writeback logic
- How a **single-cycle processor** handles **R-type, I-type, and J-type** instructions
- Use of **Icarus Verilog** and **GTKWave** for behavioral simulation and waveform debugging

---

## 🛠️ Architecture Overview

                       +----------------------+
                       |   Program Counter    |
                       +----------+-----------+
                                  |
                                  v
                       +----------------------+
                       |  Instruction Memory  |
                       +----------+-----------+
                                  |
                                  v
                       +----------------------+
                       |   Instruction Decode |
                       +----------------------+
                        |      |       |     |
                        |      |       |     +--> Immediate Generator
                        |      |       |
                        |      |       +--> Control Unit
                        |      |
                        |      +--> Register File (Read)
                        |
                        +--> ALU Control
                                  |
                                  v
                              +-------+
                              |  ALU  |
                              +-------+
                                  |
                                  v
                       +----------------------+
                       |  Write Back to Regs  |
                       +----------------------+

---

## 📁 File Structure

    Riscv_single_cycle/
    ├── riscv_top.v # Main processor integration
    ├── riscv_top_tb.v # Testbench with waveform dumps
    ├── instruction_memory.v # ROM module (reads from .mem)
    ├── register_file.v # 32-register file (x0 to x31)
    ├── alu.v # Arithmetic Logic Unit
    ├── alu_control.v # ALU control logic
    ├── control_unit.v # Main control signals
    ├── imm_generator.v # Immediate extractor
    ├── instructions.mem # Instruction hex (master program)
    ├── riscywave.vcd # Waveform output (auto-generated)
    └── README.md # Project overview and usage

---

## ▶️ Simulation Guide

### ✅ Requirements
- [Icarus Verilog](http://iverilog.icarus.com/)
- [GTKWave](http://gtkwave.sourceforge.net/)

### 🔧 Steps

1. **Compile all modules and the testbench:**

       iverilog -o riscv_test *.v
   
3. **Run the simulation:**
   
       vvp riscv_test
   
3. **Open the waveform output:**

       gtkwave riscywave.vcd

---

### 🔍 Sample Instruction Program (instructions.mem)


    00a00093  // addi x1, x0, 10
    01400113  // addi x2, x0, 20
    002081b3  // add x3, x1, x2
    40218233  // sub x4, x3, x2
    0041a2b3  // slt x5, x3, x4
    00100213  // addi x4, x0, 1
    0080006f  // jal x0, 8 (skip next two instructions)
    00300193  // addi x3, x0, 3 (skipped)
    00400213  // addi x4, x0, 4 (skipped)
    00f00313  // addi x6, x0, 15
    00530433  // add x8, x6, x5

---

### 📈 Sample Output on terminal


    === Instruction Execution Trace ===
    Time:  0ns | PC: 00000000 | Instr: 00a00093 | rd: x1 | wb_data: 10
    Time: 10ns | PC: 00000004 | Instr: 01400113 | rd: x2 | wb_data: 20
    ...
    ==== Register File Dump ====
    x1 = 10
    x2 = 20
    x3 = 30
    x4 = 10
    x5 = 1
    ...
    x10 = 15
    x11 = 2
    x12 = 12

---

## 👨‍💻 Author

    Prince Raj 
    GitHub: Prince-Raj-20

---
