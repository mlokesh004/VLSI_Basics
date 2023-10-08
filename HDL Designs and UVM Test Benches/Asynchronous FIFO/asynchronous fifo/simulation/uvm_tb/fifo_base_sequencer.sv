//Sequencer class
class base_sequencer extends uvm_sequencer#(base_seq_item);
    `uvm_component_utils(base_sequencer)
    
    function new(input string name="base_sequencer", uvm_component parent=null);
        super.new(name,parent);
    endfunction
    
    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(),{"Start of simulation phase for ",get_full_name()}, UVM_LOW)
    endfunction
    
endclass : base_sequencer
