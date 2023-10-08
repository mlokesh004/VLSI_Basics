//Base Environment
class base_env extends uvm_env;

    `uvm_component_utils(base_env)
    
    fifo_virtual_sequencer vseqr;
    base_agent base_agt;
    virtual base_intf base_vif;
    
    function new(input string name="base_env", uvm_component parent=null);
        super.new(name,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(),{"Starting Build phase for ",get_full_name()}, UVM_LOW)
        super.build_phase(phase);
        if(!uvm_config_db#(virtual base_intf)::get(this,"","base_intf",base_vif))
            `uvm_fatal(get_type_name(),"Driver Interface Configuration failure!")
        base_agt   = base_agent::type_id::create("base_agt",this);
        vseqr      = fifo_virtual_sequencer::type_id::create("vseqr",this);
    endfunction
    
    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(),{"Start of simulation phase for ",get_full_name()}, UVM_LOW)
    endfunction
    
    //use if needed
    virtual function void connect_phase(uvm_phase phase);
        `uvm_info(get_type_name(),{"Starting Connect phase for ",get_full_name()}, UVM_LOW)
        super.connect_phase(phase);
        vseqr.base_seqr = base_agt.base_seqr;
    endfunction
    
endclass : base_env