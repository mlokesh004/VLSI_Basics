`timescale 1ns / 1ps

//2-FlipFlop Reset Synchronizer
module rst_2ff_sync (

  input  logic ip_D, i_clk, i_Rstn, 
  output logic o_Rst_Synced
  );
  
  reg rst_Sync_Flop1, rst_Sync_Flop2;
      
  assign o_Rst_Synced = rst_Sync_Flop2;
  
  always @(posedge i_clk or negedge i_Rstn)
    begin
      if(!i_Rstn) begin
          rst_Sync_Flop1 <= 'b0;
          rst_Sync_Flop2 <= 'b0;
      end
      else begin
          rst_Sync_Flop1 <= ip_D;
          rst_Sync_Flop2 <= rst_Sync_Flop1;
      end
  end
  
endmodule : rst_2ff_sync