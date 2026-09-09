// total 10 ta operation hobe...
// shamt ta b input er last 5 ta bit as, 2 to the power of 5 = 32.

module alu(
    input [31:0]a,
    input [31:0]b,
    input [3:0] alu_control,
    output reg [31:0] result,
    output zero
);
    wire [4:0]shamt = b[4:0]; // shift amount er short form.

always @(*) begin
    case (alu_control)
        4'b0000 : result = a + b; // add
        4'b0001 : result = a - b; // subtract
        4'b0010 : result = a & b; // and operation
        4'b0011 : result = a | b; // or operation
        4'b0100 : result = a ^ b; // xor operation
        4'b0101 : result = (($signed (a)) < ($signed (b))) ? 32'd1 : 32'd0; //slt :- set less than
        4'b0110 : result = a < b ? 32'd1 : 32'd0; //sltu :- set less than unsigned
        4'b0111 : result = a << shamt; // sll | shift left logical 
        4'b1000 : result = a >> shamt; // srl :- shift right logical
        4'b1001 : result = $signed(a)  >>> shamt; // sra :- shift right arithmatic.

        default : result = 32'd0;
    endcase    
    
    assign zero = (result==32'd0) ? 1'b1 : 1'b0;
end

endmodule