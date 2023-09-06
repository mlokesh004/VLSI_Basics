//SR-Latch using Nand gates (wihtout control signal)
module sr_latch(input wire s, r, output reg q, qb);

  always @(*) begin
      q = ~(s & qb);
      qb = ~(r & q);
  end

endmodule : sr_latch


//D-Latch (with control signal)
module d_latch(input wire d, en, output wire q, qb);

  wire intermediate, intermediate_n;
  
  sr_latch sr_inst (intermediate,intermediate_n,q,qb);
  
  assign intermediate = d & en;
  assign intermediate_n = ~d & en;

endmodule : d_latch

/*
//D-Latch (with control signal)
module d_latch(input wire d, en, output reg q, qb);

  // using procedural assignment
  always @(*) begin
    if(en) begin
      q  = d;
      qb = ~q;
    end
  end

endmodule : d_latch
*/

//testbench (with control signal)
module tb_d_latch;

  reg  d,en;
  wire q,qb;

  d_latch dut_inst(d,en,q,qb);

  initial begin
          en  = 1'b0;
           d  = 1'b1;
  end
  
  always #20 en = $random;
  always #5  d  = $random;
  
  initial $monitor("en = %0d\ns = %0d\n---------\nq = %0d\nqb = %0d\n",en,d,q,qb);

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,d_latch);
    #200 $finish;
  end

endmodule : tb_d_latch
