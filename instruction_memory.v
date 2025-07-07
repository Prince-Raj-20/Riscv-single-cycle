module instruction_memory (
  input wire [31:0] addr,
  output wire [31:0] instruction
);

  reg [31:0] memory [0:255];  // 1 KB memory, 256 words

  initial begin
    $readmemh("instructions.mem", memory);
  end

  // Word-aligned access: use bits [9:2] of address (ignore lower 2 bits)
  assign instruction = memory[addr[9:2]];  
endmodule
