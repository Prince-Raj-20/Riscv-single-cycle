module riscv_top (
  input wire clk,
  input wire reset
);

  reg [31:0] pc;
  wire [31:0] instruction;
  wire [6:0] opcode;
  wire [4:0] rd, rs1, rs2;
  wire [2:0] funct3;
  wire [6:0] funct7;
  wire [31:0] immediate;

  wire [31:0] reg_data1, reg_data2;
  wire [31:0] alu_result;
  wire [31:0] write_back_data;
  wire [31:0] alu_operand_b;

  wire ctrl_RegWrite, ctrl_ALUSrc, ctrl_Jump;
  wire [3:0] alu_control;

  wire [31:0] next_pc = pc + 32'd4;

  // ================================
  // PROGRAM COUNTER
  // ================================
  always @(posedge clk or posedge reset) begin
    if (reset)
      pc <= 32'b0;
    else if (ctrl_Jump)
      pc <= pc + immediate;  // for jal
    else
      pc <= next_pc;
  end

  // ================================
  // INSTRUCTION MEMORY
  // ================================
  instruction_memory imem_unit (
    .addr(pc),
    .instruction(instruction)
  );

  assign opcode = instruction[6:0];
  assign rd     = instruction[11:7];
  assign funct3 = instruction[14:12];
  assign rs1    = instruction[19:15];
  assign rs2    = instruction[24:20];
  assign funct7 = instruction[31:25];

  // ================================
  // CONTROL UNIT
  // ================================
  control_unit ctrl_unit (
    .opcode(opcode),
    .RegWrite(ctrl_RegWrite),
    .ALUSrc(ctrl_ALUSrc),
    .Jump(ctrl_Jump)
  );

  // ================================
  // REGISTER FILE
  // ================================
  register_file regf_unit (
    .clk(clk),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .RegWrite(ctrl_RegWrite),
    .write_data(write_back_data),
    .read_data1(reg_data1),
    .read_data2(reg_data2)
  );

  // ================================
  // IMMEDIATE GENERATOR
  // ================================
  imm_generator immgen_unit (
    .instruction(instruction),
    .imm_out(immediate)
  );

  // ================================
  // ALU CONTROL UNIT
  // ================================
  alu_control aluctrl_unit (
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .alu_ctrl_out(alu_control)
  );

  assign alu_operand_b = ctrl_ALUSrc ? immediate : reg_data2;

  // ================================
  // ALU
  // ================================
  alu alu_unit (
    .a(reg_data1),
    .b(alu_operand_b),
    .alu_ctrl(alu_control),
    .result(alu_result),
    .zero()
  );

  // ================================
  // WRITE BACK
  // ================================
  assign write_back_data = ctrl_Jump ? next_pc : alu_result;
endmodule
