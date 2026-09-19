module instruction_decoder (
    input  wire [31:0] instruction,

    output wire [6:0]  opcode,
    output reg  [4:0]  rs1,
    output reg  [4:0]  rs2,
    output reg  [4:0]  rd,
    output reg  [2:0]  funct3,
    output reg  [6:0]  funct7,
    output reg  [2:0]  ImmSrc
);

    assign opcode = instruction[6:0];

    localparam [6:0] OP       = 7'b0110011; // R
    localparam [6:0] OP_IMM   = 7'b0010011; // I
    localparam [6:0] LOAD     = 7'b0000011; // I
    localparam [6:0] JALR     = 7'b1100111; // I
    localparam [6:0] MISC_MEM = 7'b0001111; // I
    localparam [6:0] SYSTEM   = 7'b1110011; // I
    localparam [6:0] STORE    = 7'b0100011; // S
    localparam [6:0] BRANCH   = 7'b1100011; // B
    localparam [6:0] LUI      = 7'b0110111; // U
    localparam [6:0] AUIPC    = 7'b0010111; // U
    localparam [6:0] JAL      = 7'b1101111; // J

    // ImmSrc encoding:
    // 000=I  001=S  010=B  011=U  100=J  111=no immediate

    always @(*) begin

        rs1    = 5'b0;
        rs2    = 5'b0;
        rd     = 5'b0;
        funct3 = 3'b0;
        funct7 = 7'b0;
        ImmSrc = 3'b111;

        case (opcode)

            // R-type
            OP: begin
                funct7 = instruction[31:25];
                rs2    = instruction[24:20];
                rs1    = instruction[19:15];
                funct3 = instruction[14:12];
                rd     = instruction[11:7];
            end

            // I-type
            // funct7 has no real field in I-type, but instruction[30]
            // (= funct7[5]) distinguishes SRLI(0) vs SRAI(1)
            OP_IMM,
            LOAD,
            JALR,
            MISC_MEM,
            SYSTEM: begin
                funct7 = instruction[31:25];
                rs1    = instruction[19:15];
                funct3 = instruction[14:12];
                rd     = instruction[11:7];
                ImmSrc = 3'b000;
            end

            // S-type
            STORE: begin
                rs2    = instruction[24:20];
                rs1    = instruction[19:15];
                funct3 = instruction[14:12];
                ImmSrc = 3'b001;
            end

            // B-type
            BRANCH: begin
                rs2    = instruction[24:20];
                rs1    = instruction[19:15];
                funct3 = instruction[14:12];
                ImmSrc = 3'b010;
            end

            // U-type
            LUI,
            AUIPC: begin
                rd     = instruction[11:7];
                ImmSrc = 3'b011;
            end

            // J-type
            JAL: begin
                rd     = instruction[11:7];
                ImmSrc = 3'b100;
            end

        endcase
    end

endmodule