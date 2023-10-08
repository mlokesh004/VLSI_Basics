//Base Agent
class base_agent extends uvm_agent;
    
    base_sequencer base_seqr;
    base_driver base_drv;
    base_monitor base_mon;
    virtual base_intf base_vif;
    
    `uvm_component_utils_begin(base_agent)
         `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
    `uvm_component_utils_end
        
    function new(input string name="base_agent", uvm_component parent=null);
        super.new(name,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
       super.build_phase(phase);
       `uvm_info(get_type_name(),{"Starting Build phase for ",get_full_name()}, UVM_LOW)
	   base_mon = base_monitor::type_id::create("base_mon", this);
	   if(!uvm_config_db#(virtual base_intf)::get(this,"","base_intf",base_vif))
          `uvm_fatal(get_type_name(),"Driver Interface Configuration failure!")
	   if(is_active == UVM_ACTIVE) begin
	      base_seqr = base_sequencer::type_id::create("base_seqr", this);
          base_drv  = base_driver::type_id::create("base_drv", this);
       end
    endfunction
    
    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(),{"Start of simulation phase for ",get_full_name()}, UVM_LOW)
    endfunction
    
    virtual function void connect_phase(uvm_phase phase);
        `uvm_info(get_type_name(),{"Starting Connect phase for ",get_full_name()}, UVM_LOW)
        super.connect_phase(phase);
	    if(is_active == UVM_ACTIVE) begin
           base_drv.seq_item_port.connect(base_seqr.seq_item_export);
        end
    endfunction
    
endclass : base_agent