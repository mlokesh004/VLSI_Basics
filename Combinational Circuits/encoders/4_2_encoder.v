//4-to-2 encoder
module encoder_4_2 (input wire [3:0] a, input wire en, output reg [1:0] out);

  always @(*) begin     
    if(en) begin
        out = 2'd0;
           case(a)
              4'b0001 : out = 2'd0;
              4'b0010 : out = 2'd1;
              4'b0100 : out = 2'd2;
              4'b1000 : out = 2'd3;
              default : out = 2'd0;
           endcase
     end
  end

endmodule : encoder_4_2



//Testbench
module tb_4_2_enc;

  reg  [7:0] a;
  reg  en;
  wire [2:0] out;

  encoder_4_2 dut_inst(a, en, out);

  initial begin
	en = 1'b0;
    #5  a  = 4'b0001;
    #5  a  = 4'b0010;
    #5  a  = 4'b0100;
    #5  a  = 4'b1000;
        en = 1'b1;
    #5  a  = 4'b0000;
    #5  a  = 4'b0001;
    #5  a  = 4'b0010;
    #5  a  = 4'b0100;
    #5  a  = 4'b1000;
  end

  initial $monitor("a = %p\nen = %0d\n---------\nout = %p\n",a,en,out);

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,encoder_4_2);
    #100 $finish;
  end

endmodule : tb_4_2_enc
