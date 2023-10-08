//Base Driver class
class base_driver extends uvm_driver#(base_seq_item);
    `uvm_component_utils(base_driver)
    
    virtual base_intf base_vif;

    function new(input string name="base_driver", uvm_component parent=null);
        super.new(name,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(),{"Starting Build phase for ",get_full_name()}, UVM_LOW)
        if(!uvm_config_db#(virtual base_intf)::get(this,"","base_intf",base_vif))
            `uvm_fatal(get_type_name(),"Driver VIF Configuration failure!")
    endfunction
    
    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(),{"Start of simulation phase for ",get_full_name()}, UVM_LOW)
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(),{"Starting Driver Run phase for ",get_full_name()}, UVM_LOW)
        forever begin
           seq_item_port.get_next_item(req);
           send_to_dut(req);            
           seq_item_port.item_done();
        end
    endtask
        
    task send_to_dut(base_seq_item req_item);
        `uvm_info(get_type_name(),$sformatf("Driving item: %s",req_item.sprint()),UVM_LOW)
        //@(posedge base_vif.wclk)
        @(base_vif.wclk_blk_drv)
           base_vif.i_wData = req_item.i_wData;
           base_vif.i_wEN   = req_item.i_wEN;
        //@(posedge base_vif.rclk)
        @(base_vif.rclk_blk_drv)
           base_vif.i_rEN   = req_item.i_rEN;
    endtask : send_to_dut
    
endclass : base_driver