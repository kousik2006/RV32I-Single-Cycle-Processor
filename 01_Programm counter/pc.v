// 32 bit program counter jeta current instruction er adress store korbe
// so, reset, clk, pc (current state), pc_next(jeta pore hobe)
// pc next, pc + 4 or other adress o hote pare based on the instruction
// so pc+4 hobe naki other adress this will be select by program counter mux..

module pc(
    input rst,
    input clk,
    output reg [31:0]pc,
    input wire [31:0]pc_next
);

always @(posedge clk) begin
    if(rst) pc <= 32'h0000_0000;
    else pc <= pc_next;
end


endmodule
