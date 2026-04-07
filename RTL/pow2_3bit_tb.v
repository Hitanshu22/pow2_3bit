`timescale 1ns / 1ps

module tb_pow2_3bit;

    // Inputs
    reg clk;
    reg rst;
    reg [2:0] x;

    // Output
    wire [7:0] y;

    // Instantiate the DUT (Device Under Test)
    pow2_3bit uut (
        .clk(clk),
        .rst(rst),
        .x(x),
        .y(y)
    );

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    // FSDB dump
    initial begin
        $fsdbDumpfile("pow2_3bit.fsdb");
        $fsdbDumpvars(0, tb_pow2_3bit);
    end

    // Stimulus
    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        x = 3'b000;

        // Apply reset
        #10 rst = 0;

        // Apply test inputs
        #10 x = 3'd0;
        #10 x = 3'd1;
        #10 x = 3'd2;
        #10 x = 3'd3;
        #10 x = 3'd4;
        #10 x = 3'd5;
        #10 x = 3'd6;
        #10 x = 3'd7;

        // Finish simulation
        #20 $finish;
    end

endmodule
