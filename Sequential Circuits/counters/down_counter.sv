//Simple down Counter
module down_counter (input logic clk,rst,
		   output logic [3:0] count);

  always_ff @(posedge clk)
    //Synchronous reset
    if(rst)
       count <= 0;
    else
       count <= count - 1;

endmodule : down_counter


// Testbench
module tb_down_counter;
 
  logic clk,rst;
  logic [3:0] count;

  down_counter dut_inst (clk,rst,count);

  initial begin
    {clk,rst} = 2'b11;
    #20  rst  = 1'b0;
  end

  initial forever #5 clk = ~clk;
  initial $monitor("time = %0d\nrst = %0d\nclk = %0d\n----------\ncount = %p\n",$time,rst,clk,count);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,down_counter);
    #200 $finish;
  end

endmodule : tb_down_counter
