//Base Test
class base_test extends uvm_test;   
    `uvm_component_utils(base_test)
    
    virtual base_intf base_vif;
    base_env base_env0;
    
    uvm_factory my_factory;
    uvm_objection base_test_objection; 

    function new(input string name="base_test", uvm_component parent=null);
        super.new(name,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        uvm_config_int::set( this, "*", "recording_detail", 1);
        super.build_phase(phase);
        base_env0 = base_env::type_id::create("base_env0",this);
    endfunction
    
    virtual function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info(get_full_name(),{"Starting End of Elaboration phase for ",get_type_name()}, UVM_LOW)
        uvm_top.print_topology();
        my_factory = uvm_factory::get();
        my_factory.print();
    endfunction
    
    virtual function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_full_name(),{"Start of simulation phase for ",get_type_name()}, UVM_LOW)
    endfunction
    
    virtual function void check_phase(uvm_phase phase);
      	`uvm_info(get_type_name(),"We are in Check Phase",UVM_LOW);
      	`uvm_info(get_type_name(),"Check Config Usage:",UVM_LOW);
		check_config_usage();
	endfunction
    
    virtual task run_phase(uvm_phase phase);
         base_test_objection = phase.get_objection();
         base_test_objection.set_drain_time(this, 3000);
    endtask
    
endclass : base_test


//RAW Test
class raw_test extends base_test;
    `uvm_component_utils(raw_test)
    
    raw_seq vseq;
    uvm_objection raw_test_objection;
    
    function new(input string name="raw_test", uvm_component parent=null);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        //uvm_config_wrapper::set(this, "base_env0.vseqr.run_phase", "default_sequence", raw_seq::get_type());
        set_type_override_by_type(base_sequence::get_type(), raw_seq::get_type());
        super.build_phase(phase);
    endfunction
    
    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
    endfunction
    
    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
    endfunction
    
    virtual function void check_phase(uvm_phase phase);
        super.check_phase(phase);
	endfunction
    
    task run_phase(uvm_phase phase);
        `uvm_info(get_full_name(),{"Starting Run phase for ",get_type_name()}, UVM_LOW)
        vseq = raw_seq::type_id::create("vseq");
        if(phase != null) begin
            phase.raise_objection(this, {"Sequence started : ",get_name()});
            vseq.start(base_env0.vseqr);
            #10ns;
            phase.drop_objection(this, {"Sequence ended : ",get_name()} );
            
            raw_test_objection = phase.get_objection();
            raw_test_objection.set_drain_time(this, 3000);
        end
    endtask
    
endclass : raw_test


//Write Test
class write_test extends base_test;
    `uvm_component_utils(write_test)
    
    consecutive_write_seq write_seq;
    uvm_objection write_test_objection;
    
    function new(input string name="write_test", uvm_component parent=null);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        set_type_override_by_type(base_sequence::get_type(), consecutive_write_seq::get_type());
        super.build_phase(phase);
    endfunction
    
    // End_of_elaboration_phase
    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
    endfunction
    
    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
    endfunction
    
    virtual function void check_phase(uvm_phase phase);
        super.check_phase(phase);
	endfunction
    
    task run_phase(uvm_phase phase);
        `uvm_info(get_full_name(),{"Starting Run phase for ",get_type_name()}, UVM_LOW)
        write_seq = consecutive_write_seq::type_id::create("write_seq");
        if(phase != null) begin
            phase.raise_objection(this, {"Sequence started : ",get_name()});
            write_seq.start(base_env0.base_agt.base_seqr);
            #10ns;
            phase.drop_objection(this, {"Sequence ended : ",get_name()} );
            
            write_test_objection = phase.get_objection();
            write_test_objection.set_drain_time(this, 800);
        end
    endtask
    
endclass : write_test


