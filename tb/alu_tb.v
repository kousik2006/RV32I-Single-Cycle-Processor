`timescale 1ns/1ps

module alu_tb;

    reg [31:0] a, b;
    reg [3:0] alu_control;
    wire [31:0] result;
    wire zero;

    alu uut (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero)
    );

    task test;
        input [31:0] expected;
        begin
            #1;
            if (result !== expected)
                $display("FAIL | ctrl=%b a=%h b=%h result=%h expected=%h",
                         alu_control, a, b, result, expected);
            else
                $display("PASS | ctrl=%b a=%h b=%h result=%h",
                         alu_control, a, b, result);
        end
    endtask

    initial begin
        $dumpfile("waves/alu_tb.vcd");
        $dumpvars(0, alu_tb);

        // ADD
        a = 10; b = 20; alu_control = 4'b0000;
        test(30);

        // SUB
        a = 20; b = 10; alu_control = 4'b0001;
        test(10);

        // AND
        a = 32'hF0F0F0F0; b = 32'h0FF00FF0; alu_control = 4'b0010;
        test(32'h00F000F0);

        // OR
        a = 32'hF0F00000; b = 32'h0000FFFF; alu_control = 4'b0011;
        test(32'hF0F0FFFF);

        // XOR
        a = 32'hAAAAAAAA; b = 32'h55555555; alu_control = 4'b0100;
        test(32'hFFFFFFFF);

        // SLT
        a = -10; b = 5; alu_control = 4'b0101;
        test(1);

        // SLTU
        a = 5; b = 32'hFFFFFFFF; alu_control = 4'b0110;
        test(1);

        // SLL
        a = 1; b = 4; alu_control = 4'b0111;
        test(16);

        // SRL
        a = 32'h80000000; b = 4; alu_control = 4'b1000;
        test(32'h08000000);

        // SRA
        a = 32'h80000000; b = 4; alu_control = 4'b1001;
        test(32'hF8000000);

        // Zero flag
        a = 10; b = 10; alu_control = 4'b0001;
        #1;
        $display("ZERO TEST | result=%h zero=%b", result, zero);

        // Default
        a = 10; b = 20; alu_control = 4'b1111;
        test(0);

        $finish;
    end

endmodule