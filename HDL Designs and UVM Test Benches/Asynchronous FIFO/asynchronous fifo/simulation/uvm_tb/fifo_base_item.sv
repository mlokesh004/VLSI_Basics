//Base_sequence_item
import uvm_pkg::*;
`include "uvm_macros.svh"

//Base sequence item
class base_seq_item extends uvm_sequence_item;

    rand  logic [7:0]  	          i_wData;
    rand  logic                   i_wEN;
    rand  logic                   i_rEN;
          logic [7:0]             o_rData;    
          logic                   o_Full;
          logic                   o_Empty;
    
    `uvm_object_utils_begin(base_seq_item)
         `uvm_field_int(i_wData,UVM_ALL_ON)
         `uvm_field_int(i_wEN,UVM_ALL_ON)
         `uvm_field_int(i_rEN,UVM_ALL_ON)
         `uvm_field_int(o_rData,UVM_ALL_ON)
         `uvm_field_int(o_Full,UVM_ALL_ON)
         `uvm_field_int(o_Empty,UVM_ALL_ON)
    `uvm_object_utils_end

    function new(input string name="base_seq_item");
       super.new(name);
    endfunction
            
    constraint i_wdata_range {i_wData inside {[0:255]};}

endclass : base_seq_item