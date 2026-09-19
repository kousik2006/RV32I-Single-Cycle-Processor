module alu_control (
    input      [2:0] funct3,
    input            funct7,   // only bit [30] needed
    input      [2:0] ALUOp,
    output reg [3:0] ALUControl
);

    always @(*) begin
        case (ALUOp)
            3'b000: ALUControl = 4'b0000; // ADD  — Load / Store / AUIPC / ADDI

            3'b001: ALUControl = 4'b0001; // SUB  — Branch

            // R-type and I-type share the same funct3 → ALUControl map.
            // funct7 naturally handles ADD/SUB and SRL/SRA in both cases.
            3'b010,
            3'b011: case (funct3)
                3'b000: ALUControl = funct7 ? 4'b0001 : 4'b0000; // SUB  / ADD
                3'b001: ALUControl = 4'b0111;                     // SLL  / SLLI
                3'b010: ALUControl = 4'b0101;                     // SLT  / SLTI
                3'b011: ALUControl = 4'b0110;                     // SLTU / SLTIU
                3'b100: ALUControl = 4'b0100;                     // XOR  / XORI
                3'b101: ALUControl = funct7 ? 4'b1001 : 4'b1000; // SRA  / SRL
                3'b110: ALUControl = 4'b0011;                     // OR   / ORI
                3'b111: ALUControl = 4'b0010;                     // AND  / ANDI
                default: ALUControl = 4'b0000;
            endcase

            default: ALUControl = 4'b0000;
        endcase
    end

endmodule