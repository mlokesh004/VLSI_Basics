//8-to-3 encoder
module encoder_8_3 (input wire [7:0] a, input wire en, output reg [2:0] out);

  always @(*) begin     
    if(en) begin
        out = 3'd0;
           case(a)
              8'b0000_0001 : out = 3'd0;
              8'b0000_0010 : out = 3'd1;
              8'b0000_0100 : out = 3'd2;
              8'b0000_1000 : out = 3'd3;
              8'b0001_0000 : out = 3'd4;
              8'b0010_0000 : out = 3'd5;
              8'b0100_0000 : out = 3'd6;
              8'b1000_0000 : out = 3'd7;
       	      default      : out = 3'd0;
           endcase
     end
  end

endmodule : encoder_8_3



//Testbench
module tb_8_3_enc;

  reg  [7:0] a;
  reg  en;
  wire [2:0] out;

  encoder_8_3 dut_inst(a, en, out);

  initial begin
	en = 1'b0;
    #5  a  = 8'b0001_0000;
    #5  a  = 8'b0010_0000;
    #5  a  = 8'b0100_0000;
    #5  a  = 8'b1000_0000;
        en = 1'b1;
    #5  a  = 8'b0000_0000;
    #5  a  = 8'b0000_0001;
    #5  a  = 8'b0000_0010;
    #5  a  = 8'b0000_0100;
    #5  a  = 8'b0000_1000;
    #5  a  = 8'b0001_0000;
    #5  a  = 8'b0010_0000;
    #5  a  = 8'b0100_0000;
    #5  a  = 8'b1000_0000;
  end

  initial $monitor("a = %p\nen = %0d\n---------\nout = %p\n",a,en,out);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,encoder_8_3);
    #100 $finish;
  end

endmodule : tb_8_3_enc
