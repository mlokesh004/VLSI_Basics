//Monitor class
class base_monitor extends uvm_monitor;
    `uvm_component_utils(base_monitor)
    
    virtual base_intf base_vif;

    uvm_analysis_port#(base_seq_item) mon_analysis_port;
    
    function new(input string name="base_monitor", uvm_component parent=null);
        super.new(name,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(),{"Starting Build phase for ",get_full_name()}, UVM_LOW)
        if(!uvm_config_db#(virtual base_intf)::get(this,"","base_intf",base_vif))
            `uvm_fatal(get_type_name(),"Monitor VIF Configuration failure!")
    endfunction
    
    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(),{"Start of simulation phase for ",get_full_name()}, UVM_LOW)
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(),{"Starting Run phase for ",get_full_name()}, UVM_LOW)
        forever begin
            base_seq_item base_seq = base_seq_item::type_id::create("base_seq");
            
            //@(posedge base_vif.wclk)
            @(base_vif.wclk_blk_mon)
            base_seq.i_wData = base_vif.i_wData;
            base_seq.i_wEN   = base_vif.i_wEN;   
            base_seq.o_Full  = base_vif.o_Full;
            
            //@(posedge base_vif.rclk)
            @(base_vif.rclk_blk_mon)
            base_seq.i_rEN   = base_vif.i_rEN;
            base_seq.o_rData = base_vif.o_rData;
            base_seq.o_Empty = base_vif.o_Empty;
            
            `uvm_info(get_type_name(),$sformatf("Monitor Base_seq item: %s",base_seq.sprint()),UVM_LOW)
            #2ns;
        end
    endtask
    
endclass : base_monitor