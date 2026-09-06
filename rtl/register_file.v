module register_file(
    input [4:0] rs1, // 1st source register
    input [4:0] rs2, // 2nd source register
    input clk,
    input reg_write, // control signal, write hobe kina
    input [31:0] write_data,
    input [4:0] rd, // destination register
    output [31:0]read_data1,
    output [31:0]read_data2
);

    reg [31:0] registers [31:0]; // 32 general pair register

    initial registers[0] = 32'h0000_0000; // 1st register always set to 0.

    // read operation
    assign read_data1 = registers[rs1];
    assign read_data2 = registers[rs2];

    // write operation
    always @(posedge clk) begin
        if(reg_write && (rd != 4'd0)) // as 1st register kokhono write hobe na.. 
            begin
                registers[rd] <= write_data;
            end
    end

endmodule


