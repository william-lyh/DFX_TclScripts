`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2023 05:02:28 AM
// Design Name: 
// Module Name: clock_counter
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


module clock_counter(
    input clk,
    input rst,
    input en,
    output [3:0] out
);
    
    reg [3:0] count = 4'd0;
    reg [27:0] cycles_count = 27'b0;
    
    assign out[3:0] = count[3:0];
    
    always @(posedge clk) begin
        if (rst) begin
            count <= 4'd0;
            cycles_count <= 28'd0;
        end     
        else if (en) begin
            if(cycles_count == 28'd31250000) begin
                if (count == 4'd15) begin
                    count <= 4'd0;
                end
                else begin
                    count <= count + 4'd1;
                end
		        cycles_count <= 27'b0;
            end
            else begin
                cycles_count <= cycles_count + 27'd1;
            end
        end
        else begin
            count <= count;
        end
    end
      
endmodule
