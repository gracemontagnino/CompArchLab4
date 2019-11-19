
/*
Includes the definition for an 8-way mux.  The mux takes 8 1-bit inputs and 3 1-bit
select signals. It returns one of the inputs as determined by the select signals
*/

//Include timescale and gates file
`timescale 1 ns / 1 ps
`define AND and #50
`define OR8 or #90
`define NOT not #10

//Create a module to be our 8 way mux
module Mux8Way (
  input i0,i1,i2,i3,i4,i5,i6,i7, s0,s1,s2,
  output out
  );
  wire ns0;
  wire ns1;
  wire ns2;

  wire a0;
  wire a1;
  wire a2;
  wire a3;
  wire a4;
  wire a5;
  wire a6;
  wire a7;

  //Inverting the select signals
  `NOT not0 (ns0,s0);
  `NOT not1 (ns1,s1);
  `NOT not2 (ns2,s2);

  `AND and0 (a0,i0,ns2,ns1,ns0);  //  000 is the command key to this one
  `AND and1 (a1,i1,ns2,ns1,s0);   // 001
  `AND and2 (a2,i2,ns2,s1,ns0);  // 010
  `AND and3 (a3,i3,ns2,s1,s0);   //011
  `AND and4 (a4,i4,s2,ns0,ns0); //100
  `AND and5 (a5,i5,s2,ns1,s0); // 101
  `AND and6 (a6,i6,s2,s1,ns0); // 110
  `AND and7 (a7,i7,s2,s1,s0); // 111

  `OR8 or0 (out,a0,a1,a2,a3,a4,a5,a6,a7);

endmodule
