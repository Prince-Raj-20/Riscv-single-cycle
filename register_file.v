module register_file (
  input wire clk,
  input wire [4:0] rs1,
  input wire [4:0] rs2,
  input wire [4:0] rd,
  input wire RegWrite,
  input wire [31:0] write_data,
  output wire [31:0] read_data1,
  output wire [31:0] read_data2
);

  reg [31:0] regs[0:31];

  // Read ports (combinational)
  assign read_data1 = (rs1 != 0) ? regs[rs1] : 32'b0;
  assign read_data2 = (rs2 != 0) ? regs[rs2] : 32'b0;

  // Write port (synchronous)
  always @(posedge clk) begin
    if (RegWrite && rd != 0) begin
      regs[rd] <= write_data;
    end
    regs[0] <= 32'b0; // x0 always zero
  end

endmodule
