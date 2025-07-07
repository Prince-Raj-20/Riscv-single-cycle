`timescale 1ns / 1ps

module riscv_top_tb;

  reg clk;
  reg reset;

  // Instantiate the RISC-V top module
  riscv_top dut (
    .clk(clk),
    .reset(reset)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  // Simulation control
  initial begin
    // Dump setup for GTKWave
    $dumpfile("riscywave.vcd");
    $dumpvars(0, riscv_top_tb);

    // Reset sequence
    reset = 1;
    #10 reset = 0;

    // Print header
    $display("\n=== Instruction Execution Trace ===");

    $monitor("Time: %0dns | PC: %08h | Instr: %08h | rd: x%0d | wb_data: %0d",
         $time, dut.pc, dut.instruction, dut.rd, dut.write_back_data);

    // Run simulation
    #300;

    // Final register dump
    $display("\n==== Register File Dump After Execution ====");
    $display("x0  = %0d", dut.regf_unit.regs[0]);
    $display("x1  = %0d", dut.regf_unit.regs[1]);
    $display("x2  = %0d", dut.regf_unit.regs[2]);
    $display("x3  = %0d", dut.regf_unit.regs[3]);
    $display("x4  = %0d", dut.regf_unit.regs[4]);
    $display("x5  = %0d", dut.regf_unit.regs[5]);
    $display("x6  = %0d", dut.regf_unit.regs[6]);
    $display("x7  = %0d", dut.regf_unit.regs[7]);
    $display("x8  = %0d", dut.regf_unit.regs[8]);
    $display("x9  = %0d", dut.regf_unit.regs[9]);
    $display("x10 = %0d", dut.regf_unit.regs[10]);
    $display("x11 = %0d", dut.regf_unit.regs[11]);
    $display("x12 = %0d", dut.regf_unit.regs[12]);
    $display("x13 = %0d", dut.regf_unit.regs[13]);

    $display("==================Finishing=================\n");
    $finish;
  end

endmodule
