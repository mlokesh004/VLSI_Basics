//Modulo-n Counter
module mod_n_counter #(parameter N=10)(
                      input logic clk,rst,
	              input logic [N-1:0] n,
                  output logic [N-1:0] count,
	              output logic cnt_done);

  always_ff @(posedge clk) begin
    //Synchronous reset
    if(rst) begin
       count <= 0;
       cnt_done <= 0;
    end
    else begin
       count <= count + 1;
       cnt_done <= (count==n) ? 1 : 0;
    end
  end

endmodule : mod_n_counter



// Testbench
module tb_mod_n_counter;
 
  logic clk,rst;
  logic [9:0] n;
  logic [9:0] count;
  logic cnt_done;

  mod_n_counter dut_inst (clk,rst,n,count,cnt_done);

  initial begin
    {clk,rst} = 2'b11;
    #20  rst  = 1'b0;
         n    = 5'd30;
  end

  initial forever #5 clk = ~clk;
  initial $monitor("time = %0d\nrst = %0d\nclk = %0d\n----------\ncount = %p\n",$time,rst,clk,count);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,mod_n_counter);
    #1000 $finish;
  end

endmodule : tb_mod_n_counter
