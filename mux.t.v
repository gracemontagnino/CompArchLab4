`include "mux.v"
`timescale 1 ns / 1 ps

module test8Mux ();

  reg [7:0] i;
  reg s0, s1, s2;
  wire out;

  Mux8Way mux (.i0(i[0]),.i1(i[1]),.i2(i[2]),.i3(i[3]),.i4(i[4]),.i5(i[5]),.i6(i[6]),.i7(i[7]),.s0(s0),.s1(s1),.s2(s2));

  initial begin

  i[7:0] = 8'b00000001; s0=0; s1 = 0; s2 = 0; #10000
  $display("in          | s0 | s1 | s2 | out");
  $display("%b       | %b | %b | %b | %b", i, s0, s1, s2, out);
  if (out !== 1) $display("000 failed");

  // in[7:0] = 8'b00000010; s0=0, s1 = 0, s2 = 1; #10000
  // if (out !== 1) $display("001 failed");
  //
  // in[7:0] = 8'b00000100; s0=0, s1 = 1, s2 = 0; #10000
  // if (out !== 1) $display("010 failed");
  //
  // in[7:0] = 8'b00001000; s0=0, s1 = 1, s2 = 1; #10000
  // if (out !== 1) $display("011 failed");
  //
  // in[7:0] = 8'b00010000; s0=1, s1 = 0, s2 = 0; #10000
  // if (out !== 1) $display("100 failed");
  //
  // in[7:0] = 8'b00100000; s0=1, s1 = 0, s2 = 1; #10000
  // if (out !== 1) $display("101 failed");
  //
  // in[7:0] = 8'b01000000; s0=1, s1 = 1, s2 = 0; #10000
  // if (out !== 1) $display("110 failed");
  //
  // in[7:0] = 8'b10000000; s0=1, s1 = 1, s2 = 1; #10000
  // if (out !== 1) $display("111 failed");
  end
endmodule
