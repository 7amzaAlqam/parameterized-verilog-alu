`timescale 1ns/1ps
module bidirectional_shifter #(parameter WIDTH=6)(input wire signed [WIDTH-1:0] data_in, input wire shift_right, output reg signed [WIDTH-1:0] data_out);
    always @(*) begin
        if (shift_right) data_out = data_in >>> 1;
        else             data_out = data_in <<< 1;
    end
endmodule
