`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2023 05:02:28 AM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input fpga_125mhz_clk
    );
    
    wire rst = 1'd0;
    reg rst_reg = 1'd0;
    wire en = 1'd1;
    reg en_reg = 1'd1;
    wire [3:0] counter_out;

    assign rst = rst_reg;
    assign en = en_reg;

    driver counter_driver (
        .clk(fpga_125mhz_clk),
        .switches(switches[1:0]),
        .counter_out(counter_out[3:0]),
        .rst(rst),
        .en(en),
        .leds(leds)
    );
    
    clock_counter counter (
        .clk(fpga_125mhz_clk),
        .rst(rst),
        .en(en),
        .out(counter_out)
     );
     
endmodule
