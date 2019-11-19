/*Test bench to ensure that the Set Less Than component is working (slt32.v). This file just calls that module under a few different test cases to compare for accuracy. */

//declare timing
`timescale 1ns / 1 ps
`include "slt32.v"

module testslt32();
//import variables needed to run FullSLT32bit module
  reg [31:0] a;
  reg [31:0] b;
  wire [31:0]slt;
//call the slt function
  FullSLT32bit slt1(.a(a),.b(b),.slt(slt));
//display/run various test cases, manual comparisons at this point
  initial begin
  $display(" a | b | slt | expected slt");
  a=32'b10000000000000000000000100000000; b=32'b00000010000010000010000100000000; #10000
  $display(" %b | %b | %b | %b", a,b,slt,1);

  $display(" a | b | slt | expected slt");
  a=32'b10000010000010000010000100000000; b=32'b10000010000010000010000100000000; #10000
  $display(" %b | %b | %b | %b", a,b,slt,0);

  $display(" a | b | slt | expected slt");
  a=32'b10000010000010000010000100000000; b=32'b10000000000000000000000000000000; #10000
  $display(" %b | %b | %b | %b", a,b,slt,0);

  $display(" a | b | slt | expected slt");
  a=32'b00000010001100000011000000000011;; b=32'b11111111110000011111111000001111; #10000
  $display(" %b | %b | %b | %b", a,b,slt,0);

  $display(" a | b | slt | expected slt");
  b=32'b00000010001100000011000000000011; a=32'b11111111110000011111111000001111; #10000
  $display(" %b | %b | %b | %b", a,b,slt,1);

end
endmodule
