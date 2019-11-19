`include "multiplier.v"//include necessary modules

module testMultiplier ();//declare all variables needed to test multiplier

    wire [31:0] a;
    wire [31:0] b;
    wire clk;
    wire start;
    wire [63:0] result;
    wire done;
    reg begintest;
    wire endtest;
    wire dutpassed;

multiplier DUT (.a(a),
                .b(b),
                .clk(clk),
                .start(start),
                .result(result),
                .done(done));//instatiate the multiplier

testbench tester (.begintest(begintest),
                  .result(result),
                  .clk(clk),
                  .endtest(endtest),
                  .dutpassed(dutpassed),
                  .a(a),
                  .b(b),
                  .start(start));//instatiate the test bench module, so we can actually run stuff...

initial begin//gtk wave stuff
$dumpfile("dump-multiplier.vcd");
$dumpvars();
  begintest=0;
  #10;
  begintest=1;
  #1000;


end

// Display test results ('dutpassed' signal) once 'endtest' goes high
always @(posedge endtest) begin //at the pos edge of the clock,start running tests
  $display("DUT passed?: %b", dutpassed);
end

endmodule

module testbench (

  input begintest,
  input [63:0] result,
  output reg endtest,
  output reg dutpassed,
  output reg start,
  output reg [31:0] a,
  output reg [31:0] b,
  // output reg carryout,
  // output reg overflow,
  output reg clk
  );

  initial begin
    clk=0;
    start=0;
  end

  always @(posedge begintest) begin

    endtest = 0;
    dutpassed = 1;
    #10

    // Test Case 1:
    a = 32'b00000000000000000000000000000000;
    b = 32'b00000000000000000000000000000000;
    start = 1;

    //tick the clock!
    #200 clk=1; #200 clk=0;
    start = 0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;
    #200 clk=1; #200 clk=0;

    //after module has run, check to see if reuslt is as expected
    if(result  === 64'b0000000000000000000000000000000000000000000000000000000000000000) begin
    $display("!!!-Test 1 Passed-!!!");
    end
    //if passed, say passed

    if(result !== 64'b0000000000000000000000000000000000000000000000000000000000000000) begin
    dutpassed = 0;
    $display("???-Test 1 Failed-???");
    $display("%b", result);
    end
    //if failed, say so, and print what result we are actually getting

    endtest = 1;
  end
endmodule
