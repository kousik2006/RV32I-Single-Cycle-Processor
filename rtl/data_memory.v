module data_memory (
    input clk,
    input mem_read,
    input mem_write,
    input [2:0] funct3,
    input [31:0] address,
    input [31:0] write_data,
    output reg [31:0] read_data
);

reg [7:0] mem [0:4095]; // riscv er modhey byte addressable memory ache..

wire [11:0] address_index = address[11:0];

wire [7:0] b0 = mem[address_index];
wire [7:0] b1 = mem[address_index + 1];
wire [7:0] b2 = mem[address_index + 2];
wire [7:0] b3 = mem[address_index + 3];

always @(*) begin

    read_data = 32'b0;

    if(mem_read) begin
        case(funct3)

            3'b000: read_data = {{24{b0[7]}},b0};     // LB
            3'b001: read_data = {{16{b1[7]}},b1,b0};   // LH
            3'b010: read_data = {b3,b2,b1,b0};         // LW
            3'b100: read_data = {24'b0,b0};            // LBU
            3'b101: read_data = {16'b0,b1,b0};         // LHU

            default: read_data = 32'b0;

        endcase
    end
end

always @(posedge clk) begin

    if(mem_write) begin
        case(funct3)

            3'b000: begin // SB
                mem[address_index] <= write_data[7:0];
            end

            3'b001: begin // SH
                mem[address_index]     <= write_data[7:0];
                mem[address_index + 1] <= write_data[15:8];
            end

            3'b010: begin // SW
                mem[address_index]     <= write_data[7:0];
                mem[address_index + 1] <= write_data[15:8];
                mem[address_index + 2] <= write_data[23:16];
                mem[address_index + 3] <= write_data[31:24];
            end

            default: ;

        endcase
    end
end

endmodule