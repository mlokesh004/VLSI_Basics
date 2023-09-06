// D flipflop with synchronous reset 
module d_flipflop (input logic d,clk,rst, output logic q,qb);

  always @(posedge clk) begin
    if(rst) begin
	    q <= 1'b0;
	end
	else begin
	    q <= d;
	end
  end
  
  //qb will always be inversion of q
  assign qb = ~q;
  
endmodule : d_flipflop


//testbench
module tb_dff;

  logic  d,clk,rst, q,qb;

  //DUT instantiation
  d_flipflop dff_inst (d,clk,rst,q,qb);

  initial begin 
       clk = 1'b0; 
       rst = 1'b1;
         d = 1'b1;
     #8  d = 1'b0;
     #8  d = 1'b1;
       rst = 1'b0;
  end
  
  initial forever #5 clk = ~clk; 
  
  always #8 d = $random;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,d_flipflop);
    #100 $finish;
  end
  
endmodule : tb_dff
