/*This test bench was created to test all of the modules in ALUgates.v it simply calls each of the modules with a few test cases*/
`//import file and timing
include "ALUgates.v"
`timescale 1 ns / 1 ps
//Each module gets called in separate test module, where it is passed examples to test its validity

//Testing OR
module testOR ();
  reg [31:0] a;

  reg [31:0] b;
  wire [31:0] out;

  ALUor testor (.a(a),.b(b),.out(out));

initial begin
$display(" a               | b                | out                  ");
a=32'b10000000000000000000000000000000; b=32'b01000000000000000000000000000000; #10000
$display("%b | %b | %b ", a, b, out);

$display(" a               | b                | out                  ");
a=32'b00000000000000111111111111111111; b=32'b00000000011111111100000000000000; #10000
$display("%b | %b | %b ", a, b, out);
end
endmodule
//Testing NOR
module testNOR ();
  reg [31:0] a;
  reg [31:0] b;
  wire [31:0] out;

  ALUnor testnor (.a(a),.b(b),.out(out));

initial begin
$display(" nora               | b                | out                  ");
a=32'b10101010101010101010101010101010; b=32'b00110011001100110011001100110011; #10000
$display("%b | %b | %b ", a, b, out);

$display(" nora               | b                | out                  ");
a=32'b00000000000000111111111111111111; b=32'b00000000011111111100000000000000; #10000
$display("%b | %b | %b ", a, b, out);
end
endmodule
//TestingXOR
module testXOR ();
  reg [31:0] a;
  reg [31:0] b;
  // wire [31:0] out;
  wire [31:0] orOut;
  wire [31:0] andOut;
  wire [31:0] norOut;
  wire [31:0] xorOut;
  wire [31:0] nandOut;
//
  ALUxor testxor (.a(a),.b(b),.out(out));
//   callALUgates callGates (.a(a),.b(b),.orOut(orOut),.andOut(andOut),.norOut(norOut),.xorOut(xorOut),.nandOut(nandOut));

initial begin
$display(" a               | b                | out                  ");
a=32'b10000000000000000000000000000000; b=32'b01000000000000000000000000000000; #10000
$display("%b | %b | %b ", a, b, xorOut);

$display(" a               | b                | out                  ");
a=32'b00000000000000111111111111111111; b=32'b00000000011111111100000000000000; #10000
$display("%b | %b | %b ", a, b, xorOut);
end
endmodule
//Testing AND
module testAND ();
  reg [31:0] a;
  reg [31:0] b;
  wire [31:0] out;

  ALUand testand (.a(a),.b(b),.out(out));

initial begin
$display("--------------------_AND--------------------");
$display(" a               | b                | out                  ");
a=32'b10000000000000000000000000000000; b=32'b01000000000000000000000000000000; #10000
$display("%b | %b | %b ", a, b, out);

$display(" a               | b                | out                  ");
a=32'b00000000000000111111111111111111; b=32'b00000000011111111100000000000000; #10000
$display("%b | %b | %b ", a, b, out);
end
// endmodule
