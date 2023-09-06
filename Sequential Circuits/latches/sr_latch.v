/*
//SR-Latch using Nand gates (wihtout control signal)
module sr_latch(input wire s, r, output reg q, qb);

  always @(*) begin
      q = ~(s & qb);
      qb = ~(r & q);
  end

endmodule : sr_latch
*/


//SR-Latch using Nand gates (with control signal)
module sr_latch(input wire s, r, en, output reg q, qb);

  always @(*) begin
    if(en) begin
      q = ~(s & qb);
      qb = ~(r & q);
    end
  end

endmodule : sr_latch


/*
//testbench (wihtout control signal)
module tb_sr_latch;

  reg  s,r;
  wire q,qb;

  sr_latch dut_inst(s,r,q,qb);
/*
  initial begin
       {s,r} = 2'b00;
    #5 {s,r} = 2'b00;
    #5 {s,r} = 2'b01;
    #5 {s,r} = 3'b10;
    #5 {s,r} = 3'b11;
    #5 {s,r} = 3'b00;
  end
  */

  initial {s,r}  = 2'b11;
  
  always #5  {s,r}  = $random; 

  initial $monitor("s = %0d\nr = %0d\n---------\nq = %0d\nqb = %0d\n",s,r,q,qb);

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,sr_latch);
    #100 $finish;
  end

endmodule : tb_sr_latch
*/


//testbench (with control signal)
module tb_sr_latch;

  reg  s,r,en;
  wire q,qb;

  sr_latch dut_inst(s,r,en,q,qb);

  /*
  initial begin
       {en,s,r} = 3'b000;
    #5 {en,s,r} = 3'b100;
    #5 {en,s,r} = 3'b101;
    #5 {en,s,r} = 3'b110;
    #5 {en,s,r} = 3'b111;
    #5 {en,s,r} = 3'b101;
    #5 {en,s,r} = 3'b111;
  end
  */

  initial begin
    en     = 1'b0;
    {s,r}  = 2'b11;
  end
  
  always #20 en = $random;
  always #5  {s,r}  = $random;  

  initial $monitor("en = %0d\ns = %0d\nr = %0d\n---------\nq = %0d\nqb = %0d\n",en,s,r,q,qb);

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,sr_latch);
    #100 $finish;
  end

endmodule : tb_sr_latch
