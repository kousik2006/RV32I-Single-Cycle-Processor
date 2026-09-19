module alu_control(
    input [2:0] funct3,
    input [6:0] funct7,
    input [2:0] ALUOp, // control unit theke asche 
    output reg [3:0] alu_control
);

    // ALUOp r general idea ekta
    // 000 :- add
    // 001 :- subtract
    // 010 :- R type :- depend on function 3 and function 7, operation thik hobe
    // 011 :- I type instruction :- same as above
    // 100 :- branch comparison :- alada vabe handle hobe..
    // 101 :- LUI Special handling
    // 110 :- AUIPC
    // 111 :- JUMP ba special operarion er jonyo..

    always @(*) begin

    case (ALUOp)
        3'b000 : alu_control = 4'b0000; // add
        3'b001 : alu_control = 4'b0001; // subtract

        // R type instruction
        3'b010 : begin
            case(funct3)
                3'b000 : begin 
                    if(funct7 == 7'd0) alu_control = 4'b0000; // add
                    else alu_control = 4'b0001; // subtract
                end
                3'b001: alu_control = 4'b0111; /// sll
                3'b010: alu_control = 4'b0101; /// slt
                3'b011: alu_control = 4'b0110; /// sltu
                3'b100: alu_control = 4'b0100; // xor
                3'b101: begin
                    if(funct7=7'd0) alu_control = 4'b1000; // srl
                    else alu_control = 4'b1001; // sra
                end
                3'b110: alu_control = 4'b0011;
                3'b111: alu_control = 4'b0010;
            endcase
            end

    endcase
    end


endmodule