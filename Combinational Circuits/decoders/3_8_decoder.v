//3-to-8 Decoder
module decoder_3_8 (input wire [2:0] a, input wire en, output reg [7:0] out);

  always @(*) begin
     
    if(en) begin
        out = 8'b0000_0000;
           case(a)
              3'd0 : out[0] = 1;
              3'd1 : out[1] = 1;
              3'd2 : out[2] = 1;
              3'd3 : out[3] = 1;
              3'd4 : out[4] = 1;
              3'd5 : out[5] = 1;
              3'd6 : out[6] = 1;
              3'd7 : out[7] = 1;
       	   default : out = 8'b0000_0000;
           endcase
     end
  end

endmodule : decoder_3_8



//Testbench
module tb_3_8_dec;

  reg  [2:0] a;
  reg  en;
  wire [7:0] out;

  decoder_3_8 dut_inst(a, en, out);

  always begin
    #5 a = $random;
      en = $random;
  end

  initial begin
    a  = 3'b000;
    en = 1'b0;
    $monitor("a = %p\n---------\nout = %p\n",a,out);
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,decoder_3_8);
    #100 $finish;
  end

endmodule : tb_3_8_dec
