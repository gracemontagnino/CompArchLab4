/*A test bench intended to test specific cases for an ALU*/

`include "alu.v"
`timescale 1 ns / 1 ps

module testALU ();

  reg [31:0] A;
  reg [31:0] B;
  reg [2:0] command;

  wire [31:0] result;
  wire carryout, zero, overflow;


//call function that contains the results for all operations done in this implementation of the ALU
  ALU alu (.result(result), .operandA(A), .operandB(B), .overflow(overflow), .carryout(carryout), .zero(zero), .command(command));

  initial begin
    $dumpfile("fullalu.vcd");
    $dumpvars();

  $display(" ");

  //Add test cases
  command=3'b000; A=32'b00000000000000000000000000000000; B=32'b00000000000000000000000000000000; #100000
  $display("ADDER--------------------------------------------------------------------------------------------------------------");
  $display("cmd |A                                |B                                |result                           |of| cout");
  $display("%b |%b |%b |%b |%b | %b   ", command,A,B,result,overflow,carryout);
  //auto-detection of how the test is failing, if failing at all
   if (result !== 32'b00000000000000000000000000000000)  $display("Test 1a- result failed"); //checks result
   if (carryout !== 0)    $display("Test 1a- carryout failed"); //checks carryout flag
   if (zero !== 1)        $display("Test 1a- zero flag failed");  //checks zero flag
   if (overflow !== 0)    $display("Test 1a- overflow flag failed"); //checks overflow flag
  //
  // command=3'b000;A=32'b11111111111111111111111111111111;B=32'b11111111111111111111111111111111; #100000
  // $display("%b |%b |%b |%b |%b | %b   ", command,A,B,result,overflow,carryout);
  //  if (result !== 32'b11111111111111111111111111111110)  $display("Test 1b- result failed");
  //  if (carryout !== 1)    $display("Test 1b- carryout failed");
  //  if (zero !== 0)        $display("Test 1b- zero flag failed");
  //  if (overflow !== 0)    $display("Test 1b- overflow flag failed");
  //
  //  command=3'b000; A=32'b10101010101010101010101010101010; B=32'b10101010101010101010101010101010; #100000
  //   $display("%b |%b |%b |%b |%b | %b   ", command,A,B,result,overflow,carryout);
  //   if (result !== 32'b01010101010101010101010101010100)  $display("Test 1c- result failed");
  //   if (carryout !== 1)    $display("Test 1c- carryout failed");
  //   if (zero !== 0)        $display("Test 1c- zero flag failed");
  //   if (overflow !== 1)    $display("Test 1c- overflow flag failed");
  //
  //   command=3'b000; A=32'b01010101010101010101010101010101; B=32'b01010101010101010101010101010101; #100000
  //     $display("%b |%b |%b |%b |%b | %b   ", command,A,B,result,overflow,carryout);
  //    if (result !== 32'b10101010101010101010101010101010)  $display("Test 1d- result failed");
  //    if (carryout !== 0)    $display("Test 1d- carryout failed");
  //    if (zero !== 0)        $display("Test 1d- zero flag failed");
  //    if (overflow !== 1)    $display("Test 1d- overflow flag failed");

   $display(" ");
//
  //subtractor test cases
  command=3'b001;A=32'b11111111111111111111111111111111;B=32'b11111111111111111111111111111111; #100000
  $display("SUBTRACTOR---------------------------------------------------------------------------------------------------------");
  $display("cmd |A                                |B                                |result                           |of| cout");
  $display("%b |%b |%b |%b |%b | %b   ", command,A,B,result,overflow,carryout);
   if (result !== 32'b00000000000000000000000000000000)  $display("Test 2a- result failed");
   if (carryout !== 1)    $display("Test 2a- carryout failed");
   if (zero !== 1)        $display("Test 2a- zero flag failed");
   if (overflow !== 0)    $display("Test 2a- overflow flag failed");

  command=3'b001;A=32'b10101010101010101010101010101010;B=32'b01010101010101010101010101010101; #100000
  $display("%b |%b |%b |%b |%b | %b   ", command,A,B,result,overflow,carryout);
   if (result !== 32'b01010101010101010101010101010101)  $display("Test 2b- result failed");
   if (carryout !== 1)    $display("Test 2b- carryout failed");
   if (zero !== 0)        $display("Test 2b- zero flag failed");
   if (overflow !== 1)    $display("Test 2b- overflow flag failed");

   command=3'b001;A=32'b0000000000000000000000000000010;B=32'b00000000000000000000000000000001; #100000
   $display("%b |%b |%b |%b |%b | %b   ", command,A,B,result,overflow,carryout);
    if (result !== 32'b00000000000000000000000000000001)  $display("Test 2c- result failed");
    if (carryout !== 1)    $display("Test 2c- carryout failed");
    if (zero !== 0)        $display("Test 2c- zero flag failed");
    if (overflow !== 0)    $display("Test 2c- overflow flag failed");
//
    command=3'b001;A=32'b01010101010101010101010101010101;B=32'b10111011101110111011101110111011; #100000
    $display("%b |%b |%b |%b |%b | %b   ", command,A,B,result,overflow,carryout);
     if (result !== 32'b10011001100110011001100110011010)  $display("Test 2d- result failed");
     if (carryout !== 0)    $display("Test 2d- carryout failed");
     if (zero !== 0)        $display("Test 2d- zero flag failed");
     if (overflow !== 1)    $display("Test 2d- overflow flag failed");

  $display(" ");
//
//
//
//   //SLT test cases
//   command=3'b011;A=32'b10000000000000000000000100000000;B=32'b00000010000010000010000100000000; #100000
//   $display("SLT-------------------------------------------------------------------------------------------------------");
//   $display("cmd |A                                |B                                |result                           ");
//   $display("%b |%b |%b |%b ", command,A,B,result);
//    if (result !== 1)  $display("Test 4a SLT- result failed");
//   command=3'b011;A=32'd4;B=32'd2; #100000
//   $display("%b |%b |%b |%b ", command,A,B,result);
//    if (result !== 0)  $display("Test 4b SLT- result failed");
//   command=3'b011;A=32'd300;B=-32'd600; #100000
//   $display("%b |%b |%b |%b ", command,A,B,result);
//    if (result !== 0)  $display("Test 4c SLT- result failed");
//   command=3'b011;A=-32'd600;B=32'd300; #100000
//   $display("%b |%b |%b |%b ", command,A,B,result);
//    if (result !== 1)  $display("Test 4d SLT- result failed");
//   command=3'b011;A=-32'd2;B=-32'd5; #100000
//   $display("%b |%b |%b |%b ", command,A,B,result);
//    if (result !== 0)  $display("Test 4e SLT- result failed");
//   command=3'b011;A=-32'd5;B=-32'd2; #100000
//   $display("%b |%b |%b |%b ", command,A,B,result);
//    if (result !== 1)  $display("Test 4f SLT- result failed");
//    command=3'b011;A=32'b0000000000000000000000000000010;B=32'b00000000000000000000000000000001; #100000
//    $display("%b |%b |%b |%b ", command,A,B,result);
//     if (result !== 0)  $display("Test 4f SLT- result failed");
//   $display(" ");
//
  //XOR cases
  command=3'b010;A=32'b10101010101010101010101010101010;B=32'b00110011001100110011001100110011; #100000
  $display("XOR-------------------------------------------------------------------------------------------------------");
  $display("cmd |A                                |B                                |result                           ");
  $display("%b |%b |%b |%b ", command,A,B,result);
  if (result !== 32'b10011001100110011001100110011001)  $display("Test 3a XOR- result failed");
  command=3'b010;A=32'b000000000000000000000000000000;B=32'b000000000000000000000000000000; #100000
  $display("%b |%b |%b |%b ", command,A,B,result);
  if (result !== 32'b000000000000000000000000000000)  $display("Test 3b XOR- result failed");
  $display(" ");
//
//   //AND cases
//   command=3'b100;A=32'b10101010101010101010101010101010;B=32'b11101110111011101110111011101110; #100000
//   $display("AND gate--------------------------------------------------------------------------------------------------");
//   $display("cmd |A                                |B                                |result                           ");
//   $display("%b |%b |%b |%b ", command,A,B,result);
//    if (result !== 32'b10101010101010101010101010101010)  $display("Test 5 AND- result failed");
// $display(" ");
//    //NAND cases
//   command=3'b101;A=32'b10101010101010101010101010101010;B=32'b00110011001100110011001100110011; #100000
//   $display("NAND gate--------------------------------------------------------------------------------------------------");
//   $display("cmd |A                                |B                                |result                           ");
//   $display("%b |%b |%b |%b ", command,A,B,result);
//    if (result !== 32'b11011101110111011101110111011101)  $display("Test 6 NAND- result failed");
// $display(" ");
//
//    //NOR cases
//    command=3'b110;A=32'b100000000000000000000001000000;B=32'b000000000000000000000000000000; #1000000
//    $display("NOR gate--------------------------------------------------------------------------------------------------");
//    $display("cmd |A                                |B                                |result                           ");
//    $display("%b |%b |%b |%b ", command,A,B,result);
//
// $display(" ");
//   //OR cases
//   command=3'b111;A=32'b10101010101010101010101010101010;B=32'b10011001100110011001100110011001; #100000
//   $display("OR gate--------------------------------------------------------------------------------------------------");
//   $display("cmd |A                                |B                                |result                           ");
//   $display("%b |%b |%b |%b ", command,A,B,result);
//   if (result !== 32'b10111011101110111011101110111011)  $display("Test 8 OR- result failed");
// $display(" ");

  end
endmodule
