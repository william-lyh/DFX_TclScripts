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
    input USER_SI570_CLOCK_P,
    input USER_SI570_CLOCK_N
    );
    
    wire clk;
    wire rst;
    wire en;
    wire [3:0] counter_out;

    wire [3:0] leds;
    wire [1:0] switches = 2'b00;
    
    
    // IBUFDS: Differential Input Buffer
    //         UltraScale
    // Xilinx HDL Language Template, version 2021.1
    
    IBUFDS IBUFDS_inst (
       .O(clk),   // 1-bit output: Buffer output
       .I(USER_SI570_CLOCK_P),   // 1-bit input: Diff_p buffer input (connect directly to top-level port)
       .IB(USER_SI570_CLOCK_N)  // 1-bit input: Diff_n buffer input (connect directly to top-level port)
    );
    
    // End of IBUFDS_inst instantiation

    driver counter_driver (
        .clk(clk),
        .switches(switches[1:0]),
        .counter_out(counter_out[3:0]),
        .rst(rst),
        .en(en),
        .leds(leds)
    );
    
    clock_counter counter (
        .clk(clk),
        .rst(rst),
        .en(en),
        .out(counter_out)
     );
     
endmodule
