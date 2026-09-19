// main kaj holo register b er data jabe naki immediate er data in alu

module alu_src_mux_a(
    input [31:0]rs1,
    input [31:0]pc,
    input ALUSrcA,
    output [31:0]alu_a
);
    assign alu_a = ALUSrcA ? rs1 : pc;

endmodule

