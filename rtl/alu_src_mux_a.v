// main kaj holo register b er data jabe naki immediate er data in alu

module alu_src_mux_a(
    input [31:0]rs1,
    input [31:0]pc,
    input ALUSrcB,
    output [31:0]alu_a
);
    assign alu_a = ALUSrcB ? rs1 : pc;

endmodule

