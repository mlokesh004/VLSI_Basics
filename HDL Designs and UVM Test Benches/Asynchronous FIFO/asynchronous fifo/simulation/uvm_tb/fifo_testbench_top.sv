`timescale 1ns / 1ps

// Fifo Interface
`include "fifo_interface.sv"
// Fifo test lib
`include "fifo_files_inc.sv"

//Test-Bench top
module fifo_tb_top;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import fifo_pkg::*;

    bit wclk, rclk, rstn;
    
    base_intf#(8) base_vif(wclk, rclk, rstn);
    
    //DUT
	Async_FIFO DUT_inst (.i_wClk(base_vif.wclk),// Write clk (Transmitter side)
                             .i_rClk(base_vif.rclk), // Read clk (receiver side)
                             .reset_n(base_vif.rstn),
                             .i_wData(base_vif.i_wData),
                             .i_wEN(base_vif.i_wEN),
                             .i_rEN(base_vif.i_rEN),
                             .o_rData(base_vif.o_rData),
                             .o_Full(base_vif.o_Full),
                             .o_Empty(base_vif.o_Empty));
    
    initial begin
        {wclk,rclk} = 'b11;
        reset_fifo();
    end
    
    initial forever #5  wclk = ~wclk;
    initial forever #10 rclk = ~rclk;
    
    initial begin
    uvm_config_db#(virtual base_intf)::set(uvm_root::get(),"*","base_intf",base_vif);
    run_test("raw_test");
    end
    
    task reset_fifo();
        $display("Resetting the FIFO !!");
        rstn = 'b0;
        #50ns;
        rstn = 'b1;
        $display("FIFO is out of Reset !!");
    endtask : reset_fifo 

endmodule : fifo_tb_top