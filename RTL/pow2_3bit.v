`timescale 1ns / 1ps

module pow2_3bit(
    input clk,
    input rst,
    input [2:0] x,
    output reg [7:0] y
);

    reg [2:0] x_reg;

    always @(posedge clk) begin
        if (rst) begin
            x_reg <= 3'b000;
            y <= 8'b00000000;
        end
        else begin
            x_reg <= x;

            case (x_reg)
                3'd0: y <= 8'b00000001;
                3'd1: y <= 8'b00000010;
                3'd2: y <= 8'b00000100;
                3'd3: y <= 8'b00001000;
                3'd4: y <= 8'b00010000;
                3'd5: y <= 8'b00100000;
                3'd6: y <= 8'b01000000;
                3'd7: y <= 8'b10000000;
                default: y <= 8'b00000000;
            endcase
        end
    end

endmodule
