`timescale 1ns/1ps

module tb_edgeconv;
    reg clk = 0;
    reg rst_n = 0;
    reg valid_in = 0;
    reg [7:0] pixel_in = 0;
    wire [3:0] digit_out;
    wire valid_out;
    
    always #12.5 clk = ~clk;
    
    edgeconv_top dut (
        .clk(clk),
        .rst_n(rst_n),
        .valid_in(valid_in),
        .pixel_in(pixel_in),
        .digit_out(digit_out),
        .valid_out(valid_out)
    );
    
    integer i;
    
    initial begin
        $dumpfile("tb_edgeconv.vcd");
        $dumpvars(0, tb_edgeconv);
        $display("=== EdgeConv Testbench Started ===");
        
        #100 rst_n = 1;
        $display("Reset released at %0t", $time);
        
        for (i = 0; i < 784; i = i + 1) begin
            @(posedge clk);
            valid_in = 1;
            pixel_in = i % 256;
        end
        
        @(posedge clk);
        valid_in = 0;
        $display("All pixels sent at %0t", $time);
        
        wait(valid_out);
        $display("=== RESULT: digit = %d at time %0t ===", digit_out, $time);
        
        #1000;
        $display("=== Testbench Complete ===");
        $finish;
    end
    
    initial begin
        #100000;
        $display("ERROR: Timeout!");
        $finish;
    end
endmodule
