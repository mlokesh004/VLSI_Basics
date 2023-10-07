`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2023 08:28:05
// Design Name: 
// Module Name: dff_sync2
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


module dff_Sync2#(parameter POINTER = 6)(
  
   input                clk,
   input                reset_n,
   input[POINTER:0]     i_D,
   output [POINTER:0]   o_Q_Synced
);

  reg [POINTER:0] r_Sync_Flop1;
  reg [POINTER:0] r_Sync_Flop2;

  always @(posedge clk or negedge reset_n)
    begin
      if(!reset_n)
        begin
          r_Sync_Flop1 <= {POINTER{1'b0}};
          r_Sync_Flop2 <= {POINTER{1'b0}};
        end
      else begin
        r_Sync_Flop1 <= i_D;
        r_Sync_Flop2 <= r_Sync_Flop1;
      end
    end
  assign o_Q_Synced = r_Sync_Flop2;
endmodule
