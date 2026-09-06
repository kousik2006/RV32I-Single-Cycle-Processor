`timescale 1ns/1ps

module pc_tb;

    reg        clk;
    reg        rst;
    reg [31:0] pc_next;
    wire [31:0] pc;

    pc dut (
        .clk     (clk),
        .rst     (rst),
        .pc_next (pc_next),
        .pc      (pc)
    );

    // 10 ns clock period
    initial clk = 1'b0;
    always #5 clk = ~clk;

    integer errors = 0;

    task check_pc;
        input [31:0] expected;
        begin
            if (pc !== expected) begin
                $display("FAIL t=%0t expected=%h got=%h",
                         $time, expected, pc);
                errors = errors + 1;
            end
            else begin
                $display("PASS t=%0t pc=%h", $time, pc);
            end
        end
    endtask

    initial begin
        $dumpfile("waves/pc.vcd");
        $dumpvars(0, pc_tb);

        // Reset test
        rst     = 1'b1;
        pc_next = 32'h0000_0000;

        @(posedge clk);
        #1;
        check_pc(32'h0000_0000);

        // Normal update tests
        rst     = 1'b0;

        pc_next = 32'h0000_0004;
        @(posedge clk);
        #1;
        check_pc(32'h0000_0004);

        pc_next = 32'h0000_0008;
        @(posedge clk);
        #1;
        check_pc(32'h0000_0008);

        // Branch/jump-like arbitrary address
        pc_next = 32'h0000_0100;
        @(posedge clk);
        #1;
        check_pc(32'h0000_0100);

        // Reset again
        rst = 1'b1;
        @(posedge clk);
        #1;
        check_pc(32'h0000_0000);

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d error(s)", errors);

        $finish;
    end

endmodule