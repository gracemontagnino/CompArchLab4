/*This file contains a module for each gate operation that allows the gate to process 32 bits through usage of a for loop*/

// define gate delays based on # of inputs and inverters
`define AND2 and #30
`define OR2 or #30
`define NAND2 nand #20
`define NOR2 nor #20
`define XOR2 xor #20

`timescale 1 ns / 1 ps
//Or Module
module ALUor (
  output [31:0] out,
  input [31:0] a,
  input [31:0] b
);
generate
genvar i;
for (i=0; i < 32; i=i+1) begin//for loop to go through all 32 bits, otherwise it cannot handle the number of bits

  `OR2 orgate(out[i], a[i], b[i]);

  end
  endgenerate
endmodule

//ALUnor

module ALUnor (
  output [31:0] out,
  input [31:0] a,
  input [31:0] b
);
  generate
  genvar i;
  for (i=0; i < 32; i=i+1) begin

      `NOR2 norgate(out[i], a[i], b[i]);

  end
  endgenerate
endmodule

//ALUxor

module ALUxor (
  output [31:0] out,
  input [31:0] a,
  input [31:0] b
);
  generate
  genvar i;
  for (i=0; i < 32; i=i+1) begin

    `XOR2 xorgate(out[i], a[i], b[i]);

  end
  endgenerate
endmodule

//ALUand

module ALUand (
  output [31:0] out,
  input [31:0] a,
  input [31:0] b
);
  generate
  genvar i;
  for (i=0; i < 32; i=i+1) begin

    `AND2 andgate(out[i], a[i], b[i]);

  end
  endgenerate
endmodule

//ALUnand

module ALUnand (
  output [31:0] out,
  input [31:0]a,
  input [31:0]b
);
generate
genvar i;
for (i=0; i < 32; i=i+1) begin

    `NAND2 nandgate(out[i], a[i], b[i]);

  end
  endgenerate

endmodule

//This module calls all of the above gates, and returns the 32 bit answer to each operation

module callALUgates
(
  input [31:0] a,
  input [31:0] b,
  output [31:0] orOut,
  output [31:0] andOut,
  output [31:0] nandOut,
  output [31:0] xorOut,
  output [31:0] norOut
  );

ALUor aluor (.a(a),.b(b),.out(orOut));
ALUnor alunor (.a(a),.b(b),.out(norOut));
ALUxor aluxor(.a(a),.b(b),.out(xorOut));
ALUand aluand (.a(a),.b(b),.out(andOut));
ALUnand alunand(.a(a),.b(b),.out(nandOut));

endmodule
