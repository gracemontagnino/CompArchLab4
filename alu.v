// /* Contains the final ALU module which takes 32-bit A and B, 3-bit command signal and
// returns 32-bit results, carryout, overflow, and zero
//  */
//
// //included files
// `include "slt32.v"
// `include "mux.v"
// `include "ALUgates.v"
// `timescale 1 ns / 1 ps
//
// //timing defintions for gates
// `define OR4 or #50
// `define NOT not #10
// `define OR2 or #30
//
// module ALU
// (
//   input [31:0]operandA,
//   input [31:0]operandB,
//   output [31:0]result,
//   input [2:0]command,
//   output carryout,
//   output overflow,
//   output zero );
//
// wire [31:0] orOut;
// wire [31:0] andOut;
// wire [31:0] norOut;
// wire [31:0] xorOut;
// wire [31:0] nandOut;
// wire [31:0] sum;
// wire [31:0] diff;
// wire [31:0] slt;
// wire overflowSum;
// wire overflowDiff;
// wire carryoutSum;
// wire carryoutDiff;
// wire orOut0;
// wire orOut1;
// wire orOut2;
// wire orOut3;
// wire orOut4;
// wire orOut5;
// wire orOut6;
// wire orOut7;
// wire orOut8;
// wire orOut9;
// wire nzero;
//
//
// // instantiate all subcircuits of the ALU processes
// callALUgates callGates (.a(operandA),.b(operandB),.orOut(orOut),.andOut(andOut),.norOut(norOut),.xorOut(xorOut),.nandOut(nandOut));
// FullSLT32bit callSLT (.a(operandA),.b(operandB),.slt(slt));
// FullAdder32bit callAdder (.sum(sum),.carryout(carryoutSum),.overflow(overflowSum),.a(operandA),.b(operandB),.subtract(1'b0)); //hardcoded carryin to force addition
// FullAdder32bit callSubtractor (.sum(diff),.carryout(carryoutDiff),.overflow(overflowDiff),.a(operandA),.b(operandB),.subtract(1'b1)); //hardcoded carryin to force subtraction
//
// //Insantiates 8-way mux 32 times to generate the 32-bit result
// generate
// genvar m;
// for (m=0; m < 32; m=m+1) begin
// Mux8Way mux (.i0(sum[m]),.i1(diff[m]),.i2(xorOut[m]),.i3(slt[m]),.i4(andOut[m]),.i5(nandOut[m]),.i6(norOut[m]),.i7(orOut[m]),.s0(command[0]),.s1(command[1]),.s2(command[2]),.out(result[m]));
// end
// endgenerate
//
// // overflow mux
// Mux8Way muxof (.i0(overflowSum),.i1(overflowDiff),.i2(1'b0),.i3(1'b0),.i4(1'b0),.i5(1'b0),.i6(1'b0),.i7(1'b0),.s0(command[0]),.s1(command[1]),.s2(command[2]),.out(overflow));
// // // carryout mux
// Mux8Way muxcarry (.i0(carryoutSum),.i1(carryoutDiff),.i2(1'b0),.i3(1'b0),.i4(1'b0),.i5(1'b0),.i6(1'b0),.i7(1'b0),.s0(command[0]),.s1(command[1]),.s2(command[2]),.out(carryout));
//
// //Zero flag
// `OR4 orgate0 (orOut0,result[31],result[30],result[29],result[28]);
// `OR4 orgate1 (orOut1,result[27],result[26],result[25],result[24]);
// `OR4 orgate2 (orOut2,result[23],result[22],result[21],result[20]);
// `OR4 orgate3 (orOut3,result[19],result[18],result[17],result[16]);
// `OR4 orgate4 (orOut4,result[15],result[14],result[13],result[12]);
// `OR4 orgate5 (orOut5,result[11],result[10],result[9],result[8]);
// `OR4 orgate6 (orOut6,result[7],result[6],result[5],result[4]);
// `OR4 orgate7 (orOut7,result[3],result[2],result[1],result[0]);
// `OR4 orgate8 (orOut8,orOut0,orOut1,orOut2,orOut3);
// `OR4 orgate9 (orOut9,orOut4,orOut5,orOut6,orOut7);
// `OR2 orgate10 (nzero, orOut8,orOut9);
// `NOT notgate (zero,nzero);
//
//
// endmodule
//This is the alu.v module from Vicky and Allison '20
`include "bitslice.v"

`define XOR xor //#60
`define AND1 and //#20
`define AND3 and //#40
`define NOT not //#10
`define NOR32 nor //#320
`define OR or //#30

`timescale 1ns/1ps
// *************defined gates from bitslice.v**************
//`define AND and #20
// `define OR or #20
// `define NOT not #10
// `define XOR xor #20
// `define AND3 and #30
// `define OR4 or #40

// `define ADD_ALU  3'd0
// `define SUB_ALU  3'd1
// `define XOR_ALU  3'd2
// `define SLT_ALU  3'd3
// `define AND_ALU  3'd4
// `define NAND_ALU 3'd5
// `define NOR_ALU  3'd6
// `define OR_ALU   3'd7
// *********************************************************


module ALU
(
output [31:0]  result,     // result
output        carryout,   // carryout bitstream
output        zero,       // returns 1 if the answer is all zeros, 0 other cases
output        overflow,   // overflow bitstream
input[31:0]   operandA,   // first input bitstream
input[31:0]   operandB,   // second input bitstream
input[2:0]    command     // 3 bits control signal
);

  wire notCommand1, notCommand2, subtract, slt, suborslt;
  wire[31:0] carryoutArray;

  // get the value of subtract
  `NOT notGate(notCommand1, command[1]);
  `NOT notGate2(notCommand2, command[2]);
  `AND3 andGate(subtract, command[0], notCommand1, notCommand2);
  `AND3 andGateslt(slt, command[0], command[1], notCommand2);
  `OR orGatesub(suborslt, subtract, slt);

  structuralBitSlice bitslice1(result[0], carryoutArray[0], command, operandA[0], operandB[0], suborslt);

  genvar i;
  generate
    for (i=1; i<32; i=i+1)
    begin:genblock
      structuralBitSlice bitslice1(result[i], carryoutArray[i], command, operandA[i], operandB[i], carryoutArray[i-1]);
    end
  endgenerate

  // always @(result) begin
  //   if(result == 32'dx)
  //     result <= 32'd0;
  // end

  `XOR xorGate(overflow, carryoutArray[30], carryoutArray[31]);
  `AND1 andGate2(carryout, carryoutArray[31]);
  `NOR32 norGate(zero, result[0], result[1], result[2], result[3], result[4], result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15],result[16],result[17],result[18],result[19],result[20],result[21],result[22],result[23],result[24],result[25],result[26],result[27],result[28],result[29],result[30],result[31]);



endmodule
