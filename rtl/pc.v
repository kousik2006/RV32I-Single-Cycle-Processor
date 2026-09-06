// program counter:- 32 bit register, which will store the the next instruction adress

module pc(
    input wire rst,
    input wire clk,
    input wire [31:0]pc_next,
    output reg [31:0]pc
);

    always @(posedge clk) begin
        if(rst) pc <= 32'h0000_0000;
        else pc <= pc_next;
    end


endmodule