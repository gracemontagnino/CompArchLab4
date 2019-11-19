//File includes module for a 1 bit stuctural adder and a 8-bit strucutral adder*/

// define gate delays based on # of inputs and inverters
`define XOR2 xor #30
`define AND2 and #30
`define OR2 or #30

`timescale 1 ns / 1 ps

//1-bit adder takes inputs a,b, and carryin
//returns sum and  carryout
module structuralFullAdder
(
    output sum,
    output carryout,
    input a,
    input b,
    input carryin
);
    wire xorab;
    wire xorcab;
    wire andab;
    wire andcxor;

    `XOR2 xorgate0(xorab,a,b);
    `XOR2 xorgate1(sum,xorab,carryin);
    `AND2 andgate0(andcxor,xorab,carryin);
    `AND2 andgate1(andab,a,b);
    `OR2 orgate(carryout,andab,andcxor);

endmodule

//Module for 8-bit mux, takes 8-bit inputs of a,b, 1-bit subtract signal, returns overflow, carryout and 8-bit sum
module FullAdder8bit
(
  output [7:0] sum,
  output carryout,
  output overflow,
  input [7:0] a,
  input [7:0] b,
  input carryin
  );

  wire [6:0] cout;
  wire [7:0] bin;

  structuralFullAdder bexi0 (.sum(sum[0]),.carryout(cout[0]),.a(a[0]),.b(b[0]),.carryin(carryin));

  generate
  genvar j;
  for (j=1; j < 7; j=j+1) begin
  structuralFullAdder bexi (.sum(sum[j]),.carryout(cout[j]),.a(a[j]),.b(b[j]),.carryin(cout[j-1]));
  end
  endgenerate

  structuralFullAdder bexi7 (.sum(sum[7]),.carryout(carryout),.a(a[7]),.b(b[7]),.carryin(cout[6]));

  // calculate overflow
  `XOR2 xorgate1 (overflow,carryout,cout[6]);

endmodule
