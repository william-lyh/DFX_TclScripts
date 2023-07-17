`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2023 05:02:28 AM
// Design Name: 
// Module Name: driver
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


module driver(
    input clk,
    input [1:0] switches,
    input [3:0] counter_out,
    output rst,
    output en,
    output [3:0] leds
    );
    
    reg drived_rst = 1'd0;
    reg drived_en = 1'd0;
    reg [3:0] drived_leds = 4'd0;

    assign rst = drived_rst;
    assign en = drived_en;
    assign leds[3:0] = drived_leds[3:0];
    
    reg [27:0] cycles_count = 27'b0;
    
    always @(posedge clk) begin
        if(cycles_count == 28'd125000000) begin
            drived_rst <= switches[0];
            drived_en <= switches[1];
            cycles_count <= 28'd0;
        end
        else begin
            cycles_count <= cycles_count + 27'd1;
        end
        if (counter_out == 4'd0) begin
            drived_leds <= 4'd15;
        end
        else begin
            drived_leds <= counter_out;
        end 
    end
    
endmodule
