`timescale 1ns/1ps

module edgeconv_top (
    input         clk,
    input         rst_n,
    input         valid_in,
    input  [7:0]  pixel_in,
    output [3:0]  digit_out,
    output        valid_out
);
    edgeconv core (
        .clk       (clk),
        .rst_n     (rst_n),
        .valid_in  (valid_in),
        .pixel_in  (pixel_in),
        .digit_out (digit_out),
        .valid_out (valid_out)
    );
endmodule
