`timescale 1ns/1ps
module alu_behavioral #(parameter WIDTH=4)(input wire [WIDTH-1:0] x,y, input wire [2:0] op_sel, output reg signed [WIDTH+1:0] result);
    always @(*) begin
        case(op_sel)
            3'b000: result = (x + y) >> 1;
            3'b001: result = (x + y) << 1;
            3'b010: result = (x >> 1) + y;
            3'b011: result = $signed({1'b0,x}) - $signed({1'b0,(y >> 1)});
            3'b100: result = ~(x & y);
            3'b101: result = ~x;
            3'b110: result = ~(x | y);
            3'b111: result = x ^ y;
            default: result = 0;
        endcase
    end
endmodule
