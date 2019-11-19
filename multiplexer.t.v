
// Multiplexer testbench
`timescale 1 ns / 1 ps
`include "multiplexer.v"

module testMultiplexer ();
  // Your test code here
  reg addr0;
  reg in0, in1;
  wire out;

  behavioralMultiplexer multiplexer (out,addr0,in0, in1);
  //structuralMultiplexer multiplexer (out,addr0,in0, in1); // Swap after testing

  initial begin
  $dumpfile("multi_dump.vcd");
  $dumpvars;
  $display("I0 I1|A0| Out | Expected Output");
  in0=1;in1=0;addr0=1;  #1000
  $display(" %b  %b | %b |  %b  |  0 ", in0, in1, addr0, out);
  in0=1;in1=0;addr0=0;  #1000
  $display(" %b  %b | %b |  %b  |  1 ", in0, in1, addr0, out);
  in0=0;in1=0;addr0=1;  #1000
  $display(" %b  %b | %b |  %b  |  0 ", in0, in1, addr0, out);
  in0=0;in1=1;addr0=1;  #1000
  $display(" %b  %b | %b |  %b  |  1 ", in0, in1, addr0, out);
  in0=0;in1=0;addr0=0;  #1000
  $display(" %b  %b | %b |  %b  |  0 ", in0, in1, addr0, out);
  in0=0;in1=0;addr0=0;  #1000
  $display(" %b  %b | %b |  %b  |  0 ", in0, in1, addr0, out);
  in0=0;in1=0;addr0=1;  #1000
  $display(" %b  %b | %b |  %b  |  0 ", in0, in1, addr0, out);
  in0=0;in1=0;addr0=1;  #1000
  $display(" %b  %b | %b |  %b  |  0 ", in0, in1, addr0, out);
  end
endmodule
