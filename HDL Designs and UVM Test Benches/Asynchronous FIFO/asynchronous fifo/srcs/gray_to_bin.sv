`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2023 02:12:26
// Design Name: 
// Module Name: gray_to_bin
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


module gray_2_bin#(parameter POINTER = 6) (

  input  [POINTER:0] i_Gray,
  output [POINTER:0] o_Binary
  );
  
  genvar i;
  generate
    for(i=0; i<(POINTER+1); i++) begin
      assign o_Binary[i] = ^(i_Gray >> i);
    end
  endgenerate
  
endmodule
