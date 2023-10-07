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


module rst_2ff_sync (

  input logic i_D, i_clk, i_Rstn, 
  output logic o_Rst_Synced
  );
  
  wire d_intermediate;
    
  dff dff1 (.i_d(i_D), .clk(i_clk), .i_rstn(i_Rstn), .o_q(d_intermediate));
  dff dff2 (.i_d(d_intermediate), .clk(i_clk), .i_rstn(i_Rstn), .o_q(o_Rst_Synced));

endmodule : rst_2ff_sync