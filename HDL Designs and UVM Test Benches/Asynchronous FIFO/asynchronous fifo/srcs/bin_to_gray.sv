`timescale 1ns / 1ps

//Binary to Gray Converter
module bin_2_gray#(parameter POINTER = 6)(

  input  [POINTER:0]   i_Binary,
  output [POINTER:0]   o_Gray
  );

  assign o_Gray = (i_Binary >>1)^(i_Binary);

endmodule
