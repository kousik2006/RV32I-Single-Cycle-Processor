// main kaj holo register b er data jabe naki immediate er data in alu

module alu_src_mux_b(
    input [31:0]rs2,
    input [31:0]immediate,
    input ALUSrcA,
    output [31:0]alu_b
);
    assign alu_b = ALUSrcA ? immediate : rs2;

endmodule

