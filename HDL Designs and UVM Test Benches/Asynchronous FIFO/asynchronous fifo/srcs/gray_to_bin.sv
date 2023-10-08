`timescale 1ns / 1ps

//Gray to Binary Converter
module gray_2_bin#(parameter POINTER = 6) (

  input  [POINTER:0] i_Gray,
  output [POINTER:0] o_Binary
  );
  
  genvar i;
  generate
    for(i=0; i<(POINTER+1); i++) begin
      assign o_Binary[i] = ^(i_Gray >> i);
    end
  endgenerate
  
endmodule
