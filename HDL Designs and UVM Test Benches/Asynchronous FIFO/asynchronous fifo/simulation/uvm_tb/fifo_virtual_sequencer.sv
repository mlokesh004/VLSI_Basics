// Virtual sequencer class
class fifo_virtual_sequencer extends uvm_sequencer;
    `uvm_component_utils(fifo_virtual_sequencer)
    
    base_sequencer base_seqr;
    
    function new(input string name="fifo_virtual_sequencer", uvm_component parent=null);
        super.new(name, parent);
    endfunction
    
    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(),{"Start of simulation phase for ",get_full_name()}, UVM_LOW)
    endfunction
    
endclass : fifo_virtual_sequencer