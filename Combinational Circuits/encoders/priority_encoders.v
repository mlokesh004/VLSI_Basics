//8-to-3 priority encoder
module pri_enc_8_3 (input wire [7:0] a, input wire en, output reg [2:0] out);

  always @(*) begin     
    if(en) begin
        out = 3'd0;
           casex(a)	// using casex here which actually consider dont care conditions 'x'
              8'b0000_0001 : out = 3'd0;
              8'b0000_001x : out = 3'd1;
              8'b0000_01xx : out = 3'd2;
              8'b0000_1xxx : out = 3'd3;
              8'b0001_xxxx : out = 3'd4;
              8'b001x_xxxx : out = 3'd5;
              8'b01xx_xxxx : out = 3'd6;
              8'b1xxx_xxxx : out = 3'd7;
       	      default      : out = 3'd0;
           endcase
     end
  end

endmodule : pri_enc_8_3



//Testbench
module tb_8_3_pri_enc;

  reg  [7:0] a;
  reg  en;
  wire [2:0] out;

  pri_enc_8_3 dut_inst(a, en, out);

  always begin
    #5  a  = $random;
     	en = $random;
  end

  initial begin
	en = 1'b1;
        a  = 8'b1000_0000;
  end

  initial $monitor("a = %p\nen = %0d\n---------\nout = %p\n",a,en,out);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,pri_enc_8_3);
    #100 $finish;
  end

endmodule : tb_8_3_pri_enc
