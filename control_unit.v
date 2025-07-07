module control_unit (
  input wire [6:0] opcode,
  output reg RegWrite,
  output reg ALUSrc,
  output reg Jump
);

  always @(*) begin
    // Default values
    RegWrite = 0;
    ALUSrc   = 0;
    Jump     = 0;

    case (opcode)
      7'b0110011: begin // R-type
        RegWrite = 1;
        ALUSrc   = 0;
        Jump     = 0;
      end

      7'b0010011: begin // I-type (e.g., addi)
        RegWrite = 1;
        ALUSrc   = 1;
        Jump     = 0;
      end

      7'b1101111: begin // J-type (jal)
        RegWrite = 1;
        ALUSrc   = 0; // not used in jal
        Jump     = 1;
      end

      default: begin
        RegWrite = 0;
        ALUSrc   = 0;
        Jump     = 0;
      end
    endcase
  end

endmodule
