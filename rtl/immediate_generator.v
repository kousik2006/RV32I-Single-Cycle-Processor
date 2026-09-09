module immediate_generator(
    input  wire [31:0] instruction,
    input  wire [2:0]  ImmSrc,
    output wire [31:0] immediate
);

    wire [31:0] imm_I;
    wire [31:0] imm_S;
    wire [31:0] imm_B;
    wire [31:0] imm_U;
    wire [31:0] imm_J;


    // I-type immediate
    assign imm_I = {{20{instruction[31]}}, instruction[31:20]};


    // S-type immediate
    assign imm_S = {{20{instruction[31]}},
                    instruction[31:25],
                    instruction[11:7]};


    // B-type immediate
    assign imm_B = {{19{instruction[31]}},
                    instruction[31],
                    instruction[7],
                    instruction[30:25],
                    instruction[11:8],
                    1'b0}; // as instruction adress cannot be odd, so last bit is forced to zero.. 


    // U-type immediate
    assign imm_U = {instruction[31:12], 12'b0};


    // J-type immediate
    assign imm_J = {{11{instruction[31]}},
                    instruction[31],
                    instruction[19:12],
                    instruction[20],
                    instruction[30:21],
                    1'b0};


    // Select immediate according to instruction format
    assign immediate =
        (ImmSrc == 3'b000) ? imm_I :
        (ImmSrc == 3'b001) ? imm_S :
        (ImmSrc == 3'b010) ? imm_B :
        (ImmSrc == 3'b011) ? imm_U :
        (ImmSrc == 3'b100) ? imm_J :
                             32'b0;

endmodule