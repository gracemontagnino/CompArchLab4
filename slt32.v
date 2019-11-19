
/*
A 32-bit SLT module that take a and b and returns the 1-bit result in variable slt
*/
// gate delays based on # of inputs and inverters
`define NOT not #10
`define XOR2 xor #30
`include "adder32.v"
`timescale 1 ns / 1 ps

module FullSLT32bit
(
  input [31:0] a,
  input [31:0] b,
  output [31:0] slt
  );
  wire carryout;
  wire [31:0] sum;
  wire overflow;
  wire [31:0] slt;
  wire s0;
  wire andOut;
  wire invsum1;
  wire in0;
  wire in1;
  wire sel;

  //instaation of the FullAdder32bit module where the subtract signal is all set to 1
  FullAdder32bit slt32 (.a(a),.b(b),.sum(sum),.subtract(1'b1),.overflow(overflow),.carryout(carryout));
  //If there is overflow, the ouput is the opposite of the most significant bit in sum
  //Without overflow, the output in the most significant bit in sum
  `NOT notgate(invsum1,sum[31]);
  `XOR2 xorgate(s0,overflow,sum[31]);

  assign slt = {31'b0, s0};




endmodule
