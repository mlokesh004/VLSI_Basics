// T flipflop with synchronous reset 
module t_flipflop (input logic t,clk,rst, output logic q);

  always @(posedge clk) begin
    if(rst) begin
	    q <= 1'b0;
	end
	else begin
	  if(t)
	    q <= ~q;
      else
        q <= q;
	end
  end
  
endmodule : t_flipflop

//testbench
module tb_tff;

  logic  t,clk,rst, q;

  //DUT instantiation
  t_flipflop dff_inst (t,clk,rst,q);

  initial begin 
       clk = 1'b0; 
       rst = 1'b1;
         t = 1'b1;
     #8  t = 1'b0;
     #8  t = 1'b1;
       rst = 1'b0;
  end
  
  initial forever #5 clk = ~clk;
  always #8 t = $random;
  initial $monitor("rst = %0d\nt = %0d\n---------\nq = %0d\n",rst,t,q);

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,t_flipflop);
    #200 $finish;
  end
  
endmodule : tb_tff
