// 1-bit 4-to-1 mux
module mux_4_1 (input wire a, b, c, d, input wire [1:0] sel, output wire out);
	
  // using proceduaral assignment (in case of using this, out has to be a reg)
//   always @(*) begin
//     case(sel)
//	2'b00    : out  = a;
//	2'b01    : out  = b;
//	2'b10    : out  = c;
//	2'b11    : out  = d;
//	default  : out  = a;
//     endcase
//   end

  // using Ternary operator  (continuous assignment)
   assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a);


endmodule : mux_4_1



// testbench
module tb_4_1_mux;

  reg  a, b, c, d;
  reg [1:0] sel;
  wire out;

  mux_4_1 dut_inst(a, b, c, d, sel, out);

  initial begin
        {a,b,c,d} = 4'd0;
              sel = 2'd0;
     #5 {a,b,c,d} = 4'd1;
              sel = 2'd1;
     #5 {a,b,c,d} = 4'd2;
              sel = 2'd2;
     #5 {a,b,c,d} = 4'd3;
              sel = 2'd3;
     #5 {a,b,c,d} = 4'd4;
              sel = 2'd0;
     #5 {a,b,c,d} = 4'd5;
              sel = 2'd1;
     #5 {a,b,c,d} = 4'd6;
              sel = 2'd2;
     #5 {a,b,c,d} = 4'd7;
              sel = 2'd3;
     #5 {a,b,c,d} = 4'd8;
              sel = 2'd0;
     #5 {a,b,c,d} = 4'd9;
              sel = 2'd1;
     #5 {a,b,c,d} = 4'd10;
              sel = 2'd2;
     #5 {a,b,c,d} = 4'd11;
              sel = 2'd3;
     #5 {a,b,c,d} = 4'd12;
              sel = 2'd0;
     #5 {a,b,c,d} = 4'd13;
              sel = 2'd1;
     #5 {a,b,c,d} = 4'd14;
              sel = 2'd2;
     #5 {a,b,c,d} = 4'd15;
              sel = 2'd3;
  end

  initial $monitor("a = %0d\nb = %0d\nc = %0d\nd = %0d\nsel[0] = %0d\nsel[1] = %0d\n---------\nout = %0d\n",a,b,c,d,sel[0],sel[1],out);

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,mux_4_1);
    #100 $finish;
  end

endmodule : tb_4_1_mux
