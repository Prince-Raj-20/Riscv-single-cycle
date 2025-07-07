module alu_control (
  input wire [6:0] opcode,
  input wire [2:0] funct3,
  input wire [6:0] funct7,
  output reg [3:0] alu_ctrl_out
);

  always @(*) begin
    case (opcode)

      // ----------------------
      // R-type Instructions
      // ----------------------
      7'b0110011: begin
        case ({funct7, funct3})
          10'b0000000000: alu_ctrl_out = 4'b0010; // add
          10'b0100000000: alu_ctrl_out = 4'b0110; // sub
          10'b0000000111: alu_ctrl_out = 4'b0000; // and
          10'b0000000110: alu_ctrl_out = 4'b0001; // or
          10'b0000000010: alu_ctrl_out = 4'b0111; // slt
          default:        alu_ctrl_out = 4'b1111; // invalid
        endcase
      end

      // ----------------------
      // I-type Instructions
      // ----------------------
      7'b0010011: begin
        case (funct3)
          3'b000: alu_ctrl_out = 4'b0010; // addi
          3'b111: alu_ctrl_out = 4'b0000; // andi
          3'b110: alu_ctrl_out = 4'b0001; // ori
          3'b010: alu_ctrl_out = 4'b0111; // slti
          default: alu_ctrl_out = 4'b1111; // invalid
        endcase
      end

      // ----------------------
      // Unknown Opcode
      // ----------------------
      default: begin
        alu_ctrl_out = 4'b1111;
      end

    endcase
  end

endmodule
