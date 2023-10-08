//Interface
interface base_intf #(parameter DATA_WIDTH = 8)(input bit wclk, rclk, rstn);
    
    logic [DATA_WIDTH-1:0]  i_wData;
    logic                   i_wEN;
    logic                   i_rEN;
    logic [DATA_WIDTH-1:0]  o_rData;    
    logic                   o_Full;
    logic                   o_Empty;
    
    //modport driver_DUT (input o_rData, o_Full, o_Empty, output i_wData, i_wEN, i_rEN);
    //modport mon_TB     (input wclk, rclk, rstn, o_rData, o_Full, o_Empty, i_wData, i_wEN, i_rEN);  
      
    modport driver_DUT (input o_rData, o_Full, o_Empty, output i_wData, i_wEN, i_rEN);
    modport mon_TB     (input wclk, rclk, rstn, o_rData, o_Full, o_Empty, i_wData, i_wEN, i_rEN);    
      
    clocking wclk_blk_drv @(posedge wclk);
       default input #2ns output #1ns;
       //input o_rData, o_Full, o_Empty;
       output i_wData, i_wEN, i_rEN;
    endclocking
    
    clocking rclk_blk_drv @(posedge rclk);
       default input #2ns output #1ns;
       //input o_rData, o_Full, o_Empty;
       output i_rEN;
    endclocking
        
    clocking wclk_blk_mon @(posedge wclk);
       default input #1ns output #1ns;
       input wclk, rstn, o_Full, i_wData, i_wEN;
       //output i_wClk, i_rClk, reset_n, i_wData, i_wEN, i_rEN;
    endclocking
    
    clocking rclk_blk_mon @(posedge rclk);
       default input #1ns output #1ns;
       input rclk, rstn, o_rData, o_Empty, i_rEN;
       //output i_wClk, i_rClk, reset_n, i_wData, i_wEN, i_rEN;
    endclocking
    
endinterface : base_intf