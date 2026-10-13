`timescale 1ns/1ps
module not_unit #(parameter WIDTH=4)(input wire [WIDTH-1:0] a, output wire [WIDTH-1:0] result);
    assign result = ~a;
endmodule
