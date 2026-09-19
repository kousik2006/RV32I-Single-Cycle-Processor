// main kaj holo register b er data jabe naki immediate er data in alu

module alu_src_mux(
    input [31:0]reg_data,
    input [31:0]immediate,
    input ALUSrc,
    output [31:0]alu_b
);
    assign alu_b = ALUSrc ? immediate : reg_data;

endmodule

