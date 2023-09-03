// 1-bit 8-to-1 mux
module mux_8_1 (input wire a, b, c, d, e, f, g, h, input wire [2:0] sel, output wire out);
	
  // using proceduaral assignment (in case of using this, out has to be a reg)
//   always @(*) begin
//     case(sel)
//	3'b000    : out  = a;
//	3'b001    : out  = b;
//	3'b010    : out  = c;
//	3'b011    : out  = d;
//	3'b100    : out  = e;
//	3'b101    : out  = f;
//	3'b110    : out  = g;
//	3'b111    : out  = h;
//	default  : out  = a;
//     endcase
//   end

  // using Ternary operator  (continuous assignment)
   assign out = sel[2] ? (sel[1] ? (sel[0] ? h : g) : (sel[0] ? f : e)) : (sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a));


endmodule : mux_8_1



// testbench
module tb_8_1_mux;

  reg  a, b, c, d, e, f, g, h;
  reg  [2:0] sel;
  wire out;

  mux_8_1 dut_inst(a, b, c, d, e, f, g, h, sel, out);

  always begin

       #5 {a, b, c, d, e, f, g, h} = $random;
       sel 			   = $random;
  end

  initial begin
    {a, b, c, d, e, f, g, h} = 8'b0011_0000;
    sel 	   	     = 3'b011;
    $monitor("a = %0d\nb = %0d\nc = %0d\nd = %0d\ne = %0d\nf = %0d\ng = %0d\nh = %0d\nsel[0] = %0d\nsel[1] = %0d\nsel[2] = %0d\n---------\nout = %0d\n",a,b,c,d,e,f,g,h,sel[0],sel[1],sel[2],out);
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,mux_8_1);
    #100 $finish;
  end

endmodule : tb_8_1_mux
