// 1-bit half_adder
module half_adder (input wire a, b, output sum, carry);
  
  assign {carry, sum} = a + b;
  
endmodule : half_adder



// half_adder tb
module tb_half_adder;
  
  reg  a, b;
  wire sum, carry;
  
  half_adder dut_inst(a,b,sum,carry);
  
  initial begin
       {a,b} = 2'd0;
    #5 {a,b} = 2'd1;
    #5 {a,b} = 2'd2;
    #5 {a,b} = 2'd3;
  end
 
  initial $monitor("a = %0d\nb = %0d\n---------\nsum = %0d\ncarry = %0d\n",a,b,sum,carry); 
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,half_adder);
    #20 $finish;
  end

endmodule
