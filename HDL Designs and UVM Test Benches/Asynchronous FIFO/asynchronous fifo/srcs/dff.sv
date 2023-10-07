`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2023 03:25:35
// Design Name: 
// Module Name: 
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


// D flipflop with synchronous reset 
module dff (input logic i_d,clk,i_rstn, output logic o_q);

  always @(posedge clk) begin
    if(!i_rstn) begin
	    o_q <= 1'b0;
	end
	else begin
	    o_q <= i_d;
	end
  end
  
endmodule : dff
