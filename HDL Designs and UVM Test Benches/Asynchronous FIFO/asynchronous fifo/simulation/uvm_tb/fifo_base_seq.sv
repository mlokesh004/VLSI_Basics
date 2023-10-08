import uvm_pkg::*;
`include "uvm_macros.svh"

//ASYNC FIFO Base sequence class
class base_sequence extends uvm_sequence#(base_seq_item);

    `uvm_object_utils(base_sequence)

    function new(input string name="base_sequence");
        super.new(name);
    endfunction
    
    virtual task pre_body();
        uvm_phase phase;
        phase = starting_phase;
        if(phase != null) begin
            phase.raise_objection(this,{"Raised Objection : ",get_type_name()});
        end
    endtask
    
    virtual task post_body();
        uvm_phase phase;
        phase = starting_phase;
        if(phase != null) begin
            phase.drop_objection(this,{"Dropped Objection : ",get_type_name()});
        end
    endtask 
      
endclass : base_sequence


//consecutive_writes Sequence
class consecutive_write_seq extends base_sequence;

    `uvm_object_utils(consecutive_write_seq)

    function new(input string name="consecutive_write_seq");
        super.new(name);
    endfunction

    task body();
        repeat(64) begin
            `uvm_do_with(req, {i_wEN == 1; i_rEN == 0;});
        end
    endtask : body 
      
endclass : consecutive_write_seq


//consecutive reads Sequence
class consecutive_read_seq extends base_sequence;

    `uvm_object_utils(consecutive_read_seq)

    function new(input string name="consecutive_read_seq");
        super.new(name);
    endfunction

    task body();
        repeat(64) begin
            `uvm_do_with(req, {i_rEN == 1; i_wEN == 0; i_wData == 0;});
        end
    endtask : body 
      
endclass : consecutive_read_seq


//Read after Write Sequence
class wr_raw_seq extends base_sequence;

    `uvm_object_utils(wr_raw_seq)
    
    consecutive_write_seq write_seq;
    consecutive_read_seq  read_seq;

    function new(input string name="wr_seq");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_full_name(),{"Inside sequence ", get_type_name()},UVM_LOW)
        `uvm_do(write_seq)
        `uvm_do(read_seq)
        `uvm_info(get_full_name(),{"Sequence done ", get_type_name()},UVM_LOW)
    endtask : body 
      
endclass : wr_raw_seq


