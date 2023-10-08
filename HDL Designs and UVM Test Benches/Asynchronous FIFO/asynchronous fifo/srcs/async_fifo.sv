`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer: Lokesh Methuku
// Project Name: Asynchronous fifo Version 1.0
// 
// Description: 
// FIFOs are often used to safely pass data from one clock domain to another asynchronous clock domain. Using a
// FIFO to pass data from one clock domain to another clock domain requires multi-asynchronous clock design
// techniques. There are many ways to design a FIFO wrong. There are many ways to design a FIFO right but still
// make it difficult to properly synthesize and analyze the design.
//
// General Spec: 
//        Depth       = 64 
//        Write CLOCK = 100 MHz
//        Read CLOCK  = 50  MHz
//
// Dependencies: 
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// Mandatory includes
`include "dff_synchronizer.sv"
`include "bin_to_gray.sv"
`include "gray_to_bin.sv"
`include "reset_synchronizer.sv"


// Asynchronous FIFO Design
module Async_FIFO #(parameter FIFO_DEPTH = 64,
                    parameter DATA_WIDTH = 8,
		            parameter POINTER    = 6 )(
  
    input logic                    i_wClk,      // Write clk (Transmitter side)
    input logic                    i_rClk,      // Read clk (receiver side)
    input logic                    reset_n,     // Global reset (active low)
    input logic  [DATA_WIDTH-1:0]  i_wData,     // Write data on write clk
    input logic                    i_wEN,       // Write enable signal on write clk
    input logic                    i_rEN,       // Read enable signal on Read clk
    output logic [DATA_WIDTH-1:0]  o_rData,     // output read data on Read clk
    output logic                   o_Full,      // Fifo full pointer output
    output logic                   o_Empty      // Fifo empty pointer output
);

  //Internal reg/wire Declaration
  logic [POINTER:0] r_Wr_Ptr, r_Rd_Ptr;                                                // Additional MSB-bit for 'Full and Empty' Conditions check
  logic [POINTER:0] r_Wr_Ptr_G, r_Rd_Ptr_G, r_Wr_Ptr_G_Synced, r_Rd_Ptr_G_Synced;      // Internal Gray pointers - Write and Read
  logic [POINTER:0] r_Wr_Ptr_B_Synced, r_Rd_Ptr_B_Synced;                              // Internal Binary pointers after 2-ff sync
  logic Empty, Full;                                                                   // Internal wires for full and empty outputs
  logic Rstn_Synced;
  
  //Memory or FIFO buffer
  logic [DATA_WIDTH-1:0] Mem [0:FIFO_DEPTH -1];   
  
  
  //Reset Synchronizer
  rst_2ff_sync fifo_rst_sync_2ff (.ip_D(1'b1), .i_clk(i_wClk), .i_Rstn(reset_n), .o_Rst_Synced(Rstn_Synced));
  
  
  //Binary 2 Gray Converter
  bin_2_gray#(POINTER) b2g_wr_ptr(.i_Binary(r_Wr_Ptr), .o_Gray(r_Wr_Ptr_G)); 
  bin_2_gray#(POINTER) b2g_rd_ptr(.i_Binary(r_Rd_Ptr), .o_Gray(r_Rd_Ptr_G));

  //Synchronizing Read/Write Pointers
  dff_Sync2#(POINTER) dff_sync2_wr_ptr(.clk(i_rClk), .reset_n(Rstn_Synced), .i_D(r_Wr_Ptr_G), .o_Q_Synced(r_Wr_Ptr_G_Synced));
  dff_Sync2#(POINTER) dff_sync2_rd_ptr(.clk(i_wClk), .reset_n(Rstn_Synced), .i_D(r_Rd_Ptr_G), .o_Q_Synced(r_Rd_Ptr_G_Synced));
  
  //Gray 2 Binary Converter
  gray_2_bin#(POINTER) g2b_wr_ptr(.i_Gray(r_Wr_Ptr_G_Synced), .o_Binary(r_Wr_Ptr_B_Synced)); 
  gray_2_bin#(POINTER) g2b_rd_ptr(.i_Gray(r_Rd_Ptr_G_Synced), .o_Binary(r_Rd_Ptr_B_Synced));


  //Internal Buffer Full and Empty Assignments
  assign Full  = ({~r_Wr_Ptr[POINTER:POINTER],r_Wr_Ptr[POINTER-1:0]} == r_Rd_Ptr_B_Synced);
  assign Empty = (r_Wr_Ptr_B_Synced == r_Rd_Ptr);
  
  
  // Full Pointer
  always @(posedge i_wClk or negedge Rstn_Synced)
    begin
      if(!Rstn_Synced)
        begin
          o_Full <= 'b0;
        end
      else
        begin
          o_Full <= Full;
        end
    end
    
  // Empty Pointer
  always @(posedge i_rClk or negedge Rstn_Synced)
    begin
      if(!Rstn_Synced)
        begin
          o_Empty <= 'b1;
        end
      else
        begin
          o_Empty <= Empty;
        end
    end


  // Internal Write Pointer Update 
  always @(posedge i_wClk or negedge Rstn_Synced) 
    begin
      if(!Rstn_Synced)
        begin
          r_Wr_Ptr <= 'b0;
        end
      else if(i_wEN && !Full)         // Check for Write Enable & Fifo Full(not full) to write pointer increment
        begin
          r_Wr_Ptr <= r_Wr_Ptr + 1;
        end
    end

  
  // Internal Read Pointer Update
  always @(posedge i_rClk or negedge Rstn_Synced)
    begin
      if(!Rstn_Synced)
        begin
          r_Rd_Ptr <= 'b0;
        end
      else if(i_rEN && !Empty)        // Check for Read Enable & Fifo empty(not empty) to Read pointer increment
        begin
          r_Rd_Ptr <= r_Rd_Ptr + 1;
        end
    end


  // Memory Write
  always @(posedge i_wClk or negedge Rstn_Synced) begin
      if(!Rstn_Synced) 
        Mem <= '{default:8'b00};
      else begin
        if (i_wEN && !Full)             // Check for Write Enable & Fifo Full(not full) to write pointer increment
        begin    
           Mem[r_Wr_Ptr] <= i_wData;
           //$display("%m : Data write into memory Mem[%0d] = %0h",r_Wr_Ptr, Mem[r_Wr_Ptr]);
        end
      end
    end

  // Memory Read
  always @(posedge i_rClk or negedge Rstn_Synced) begin
      if(!Rstn_Synced)
        o_rData <= 8'h00;
      else begin
        if(i_rEN && !Empty) begin      // Check for Read Enable & Fifo empty(not empty) to Read pointer increment
          o_rData <= Mem[r_Rd_Ptr];
          //$display("%m : Data read from Memory r_Data = %0h",Mem[r_Rd_Ptr]);
        end
      end
  end

endmodule : Async_FIFO

