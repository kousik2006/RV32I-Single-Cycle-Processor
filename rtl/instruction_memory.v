module instruction_memory(
    input wire [31:0] address,
    output wire [31:0] instruction
);

reg [31:0] mem [255:0]; // total memory location 256 as each contained 32 bit instrucion
assign instruction = mem[address >> 2]; // as adress/4 korle memory location pabo, as each memory location holds 4 byte instruction

endmodule

