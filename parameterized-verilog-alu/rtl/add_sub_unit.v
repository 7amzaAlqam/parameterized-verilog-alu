`timescale 1ns/1ps
module add_sub_unit #(parameter WIDTH=4)(input wire [WIDTH-1:0] a,b, input wire subtract, output reg signed [WIDTH+1:0] result);
    always @(*) begin
        if (subtract) result = $signed({1'b0,a}) - $signed({1'b0,b});
        else          result = $signed({1'b0,a}) + $signed({1'b0,b});
    end
endmodule
