module imm_generator (
  input wire [31:0] instruction,
  output reg [31:0] imm_out
);

  wire [6:0] opcode = instruction[6:0];
  wire [2:0] funct3 = instruction[14:12];

  always @(*) begin
    case (opcode)

      // -------------------------
      // I-type: addi, andi, ori, slti
      // -------------------------
      7'b0010011: begin
        case (funct3)
          3'b001: begin
            imm_out = {27'b0, instruction[24:20]};
          end
          default: begin
            imm_out = {{20{instruction[31]}}, instruction[31:20]};
          end
        endcase
      end

      // -------------------------
      // J-type: jal
      // -------------------------
      7'b1101111: begin
        imm_out = {
          {12{instruction[31]}},            // sign-extend
          instruction[19:12],               // imm[19:12]
          instruction[20],                  // imm[11]
          instruction[30:21],               // imm[10:1]
          1'b0                              // imm[0] (always 0)
        };
      end

      // --------------
      // Default:
      // --------------
      default: begin
        imm_out = 32'b0;
      end

    endcase
  end

endmodule
