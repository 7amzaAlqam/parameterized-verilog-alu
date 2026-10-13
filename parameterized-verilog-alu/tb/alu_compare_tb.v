`timescale 1ns/1ps
module alu_compare_tb;
    localparam WIDTH=4;
    reg [WIDTH-1:0] x,y; reg [2:0] op_sel;
    wire signed [WIDTH+1:0] structural_result, behavioral_result;
    integer op, errors;
    alu_structural #(.WIDTH(WIDTH)) dut_s(.x(x),.y(y),.op_sel(op_sel),.result(structural_result));
    alu_behavioral #(.WIDTH(WIDTH)) dut_b(.x(x),.y(y),.op_sel(op_sel),.result(behavioral_result));
    initial begin
        errors=0; x=4'd10; y=4'd6;
        for(op=0; op<8; op=op+1) begin
            op_sel=op[2:0]; #10;
            if(structural_result !== behavioral_result) begin
                $display("Mismatch op=%b structural=%0d behavioral=%0d",op_sel,structural_result,behavioral_result); errors=errors+1;
            end
        end
        if(errors==0) $display("PASS: structural and behavioral ALUs match.");
        else $display("FAIL: %0d mismatches found.",errors);
        $finish;
    end
endmodule
