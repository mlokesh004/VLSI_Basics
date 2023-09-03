module mux_2_1 (input wire a, b, sel, output wire out);
	
   // using proceduaral assignment (in case of using this, out has to be a reg)
//   always @(*) begin
//     case(sel)
//	1'b0    : out  = a;
//	1'b1    : out  = b;
//	default : out  = a;
//     endcase
//   end

   // using Ternary operator  (continuous assignment)
   assign out = sel ? b : a;

endmodule : mux_2_1



// testbench
module tb_2_1_mux;

  reg  a, b, sel;
  wire out;

  mux_2_1 dut_inst(a, b, sel, out);

  initial begin
        {a,b} = 2'd0;
          sel = 1'b0;
     #5 {a,b} = 2'd1;
          sel = 1'b1;
     #5 {a,b} = 2'd2;
          sel = 1'b0;
     #5 {a,b} = 2'd3;
          sel = 1'b1;
  end

  initial $monitor("a = %0d\nb = %0d\nsel = %0d\n---------\nout = %0d\n",a,b,sel,out);

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,mux_2_1);
    #100 $finish;
  end

endmodule : tb_2_1_mux
