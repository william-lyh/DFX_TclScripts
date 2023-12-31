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
    input fpga_125mhz_clk,
    input [1:0] switches,
    input btn,
    output [3:0] leds
    );
    
    wire rst;
    wire en;
    wire [3:0] counter_out;

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
