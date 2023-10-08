// Virtual Sequence
class fifo_virtual_seq extends uvm_sequence#(uvm_sequence_item);

    `uvm_object_utils(fifo_virtual_seq)
    `uvm_declare_p_sequencer(fifo_virtual_sequencer)

    function new(input string name="fifo_virtual_seq");
        super.new(name);
    endfunction
    
    /*virtual task pre_body();
        uvm_phase phase;
        phase = starting_phase;
        if(phase != null) begin
            phase.raise_objection(this,{"Virtual sequence started : ",get_type_name()});
        end
    endtask
    
    virtual task post_body();
        uvm_phase phase;
        phase = starting_phase;
        if(phase != null) begin
            phase.drop_objection(this,{"Virtual sequence ended : ",get_type_name()});
        end
    endtask*/
    
endclass : fifo_virtual_seq


// Read after Write Sequence
class raw_seq extends fifo_virtual_seq;

    `uvm_object_utils(raw_seq)
   
    wr_raw_seq raw;
    
    function new(input string name="raw_seq");
        super.new(name);
    endfunction
    
    virtual task body();
        `uvm_info(get_full_name(),{"Sequence started ",get_type_name()},UVM_LOW)
        `uvm_do_on(raw, p_sequencer.base_seqr);
        `uvm_info(get_full_name(),{"Sequence ended ",get_type_name()},UVM_LOW)
    endtask

endclass : raw_seq



