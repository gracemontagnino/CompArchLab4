`timescale 1 ns / 1 ps //set timescale for the mux

module mux2way_8bit(//this module is a 2 way 8 bit mux
  output [7:0] out,//initialize the 8 bit output
  input address,
  input[7:0] input0, input1//each of the two inputs are 8 bits
  );

  wire [7:0] mux [7:0];

  assign mux[0] = input0; //assign input 0 to mux[0]
  assign mux[1] = input1;//assign input 1 to mux[1]
  assign out = mux[address];//return the input for the given address

endmodule
