`timescale 1ns/1ps
module nor_unit #(parameter WIDTH=4)(input wire [WIDTH-1:0] a,b, output wire [WIDTH-1:0] result);
    assign result = ~(a | b);
endmodule
