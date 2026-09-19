module writeback_mux(
    input [31:0] alu_result, // coming from alu
    input [31:0] memory_data, // data coming from memory for load.. 
    input [31:0] pc_plus_4, // next instruction store hobe for jal or jalr
    input [1:0] ResultSrc, // select line
    output [31:0] write_data // je data ta write hobe register file e.. 
);

    always @(*) begin
        case (ResultSrc)
            2'b00 : write_data = alu_result;
            2'b01 : write_data = memory_data;
            2'b10 : write_data = pc_plus_4;
            default : write_data = 32'd0;
        endcase
    end


endmodule
