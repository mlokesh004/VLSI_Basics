//dff using 2x1 mux for both positive and negative edge triggered clks

//2x1 Mux
module mux_2_1(input logic a,b,s, output logic out);
  
  assign out = s ? b : a;
  
endmodule

//DFF
module dff_mux (input logic d,clk, output logic out);
  
  wire w1;
  
  mux_2_1 m1 (w1,d,~clk,w1);		// Positive-edge triggered clk
  mux_2_1 m2 (out,w1,clk,out);
  
  //mux_2_1 m1 (w1,d,clk,w1);		// Negative-edge triggered clk
  //mux_2_1 m2 (out,w1,~clk,out);
  
endmodule



//Simple test-bench
module tb_dff;
  
  logic d,clk = 0, out;
  
  
  dff_mux dut_inst(d,clk,out);
  
  
  always #9 d = $random;
  
  initial 
    forever #5 clk = ~clk;
  
  initial begin
    $monitor("%m : clk = %d ---- d = %d ---- out = %0d\n",clk,d,out);
    $dumpfile("dump.vcd");
    $dumpvars(0,dff_mux);
    #200 $finish;
  end
endmodule
