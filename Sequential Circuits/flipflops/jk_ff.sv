//JK-FF with synchronous reset
module jk_flipflop (input logic j,k,clk,rst, output logic q);

  always @(posedge clk) begin
    if(rst) //synchronous reset
        q <= 0;
    else
	case({j,k})
	   2'b00 : begin $display("NO CHANGE"); q <= q;  end
	   2'b01 : begin $display("RESET");     q <= 0;  end
	   2'b10 : begin $display("SET");       q <= 1;  end
	   2'b11 : begin $display("TOGGLE");    q <= ~q; end
        endcase
  end

endmodule : jk_flipflop


//testbench
module tb_jk_flipflop;

  logic  j,k,clk,rst,q;

  jk_flipflop dut_inst (j,k,clk,rst,q);

  initial begin 
       clk = 1'b0; 
       rst = 1'b1;
     {j,k} = 1'b1;
  #8 {j,k} = 1'b1;
  #8 {j,k} = 1'b1;
       rst = 1'b0;
  end
  
  initial forever #5 clk = ~clk;
  always #8 {j,k} = $random;
  initial $monitor("rst = %0d\nj = %0d\nk = %0d\n---------\nq = %0d\n",rst,j,k,q);

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,jk_flipflop);
    #200 $finish;
  end

endmodule : tb_jk_flipflop
