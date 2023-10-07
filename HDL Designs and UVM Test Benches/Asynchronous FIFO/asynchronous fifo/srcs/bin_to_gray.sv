`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2023 08:28:05
// Design Name: 
// Module Name: bin_2_gray
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


module bin_2_gray#(parameter POINTER = 6)(

  input[POINTER:0]               i_Binary,
  output[POINTER:0]              o_Gray
);

  assign o_Gray = (i_Binary >>1)^(i_Binary);

endmodule
