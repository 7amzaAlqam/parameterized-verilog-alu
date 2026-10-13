`timescale 1ns/1ps
module alu_structural #(parameter WIDTH=4)(input wire [WIDTH-1:0] x,y, input wire [2:0] op_sel, output wire signed [WIDTH+1:0] result);
    localparam OUT_WIDTH = WIDTH + 2;
    wire signed [WIDTH+1:0] sum_xy, x_minus_half_y;
    wire signed [WIDTH+1:0] sum_half, sum_double, half_x_plus_y;
    wire signed [WIDTH+1:0] x_ext = $signed({1'b0,x});
    wire signed [WIDTH+1:0] y_ext = $signed({1'b0,y});
    wire signed [WIDTH+1:0] half_x = x_ext >>> 1;
    wire signed [WIDTH+1:0] half_y = y_ext >>> 1;
    wire [WIDTH-1:0] nand_w, not_w, nor_w, xor_w;
    wire signed [WIDTH+1:0] nand_ext = $signed({2'b00,nand_w});
    wire signed [WIDTH+1:0] not_ext  = $signed({2'b00,not_w});
    wire signed [WIDTH+1:0] nor_ext  = $signed({2'b00,nor_w});
    wire signed [WIDTH+1:0] xor_ext  = $signed({2'b00,xor_w});

    add_sub_unit #(.WIDTH(WIDTH)) add_xy (.a(x), .b(y), .subtract(1'b0), .result(sum_xy));
    bidirectional_shifter #(.WIDTH(OUT_WIDTH)) half_sum (.data_in(sum_xy), .shift_right(1'b1), .data_out(sum_half));
    bidirectional_shifter #(.WIDTH(OUT_WIDTH)) double_sum (.data_in(sum_xy), .shift_right(1'b0), .data_out(sum_double));
    assign half_x_plus_y = half_x + y_ext;
    assign x_minus_half_y = x_ext - half_y;

    nand_unit #(.WIDTH(WIDTH)) u_nand(.a(x),.b(y),.result(nand_w));
    not_unit  #(.WIDTH(WIDTH)) u_not (.a(x),.result(not_w));
    nor_unit  #(.WIDTH(WIDTH)) u_nor (.a(x),.b(y),.result(nor_w));
    xor_unit  #(.WIDTH(WIDTH)) u_xor (.a(x),.b(y),.result(xor_w));

    mux8to1 #(.WIDTH(OUT_WIDTH)) select_result(
        .in0(sum_half), .in1(sum_double), .in2(half_x_plus_y), .in3(x_minus_half_y),
        .in4(nand_ext), .in5(not_ext), .in6(nor_ext), .in7(xor_ext), .sel(op_sel), .out(result));
endmodule
