//------------------------------------------------------------------------
// Sequential multiplier
//------------------------------------------------------------------------
`include "fsm_2.v"
`include "shiftreg.v"
`include "pre_mux.v"
`include "adder8bit.v"
`include "register_multiplier.v"
`include "shiftregmodes.v"


module multiplier
(
  output [63:0] result,   // Final result, valid when "done" is true
  output done,  // High for one cycle when result is valid/complete
  input [31:0] a, b,  // Inputs to be multiplied
  input clk,   // Output transitions synchronized to posedge
  input start  // High for one cycle when inputs A and B are valid, initiates multiplication sequence
);

wire standby, setup, register, done;
wire [63:0] reg_a_pIn;
wire [31:0] reg_b_pIn;
wire reg_a_sIn;
wire reg_b_sIn;
wire [1:0] reg_a_mode;
wire [1:0] reg_b_mode;
wire [63:0] reg_a_out;  //output of shift reg a
wire [31:0] reg_b_out;  //output of shift reg b
wire reg_plain_enable;
wire [63:0] adderOut;
wire [63:0] mux_out;
wire [63:0] reg_plain_out;
wire [63:0] reg_plain_input;
wire reg_mux_address;
wire mux_a_address;

//instantiation of the FSM control path
fsm machine (.start(start),
            .clk(clk),
            .standby(standby),
            .setup(setup),
            .register(register),
            .done(done),
            .b(b),
            .reg_a_mode(reg_a_mode),
            .reg_b_mode(reg_b_mode),
            .reg_a_pIn(reg_a_pIn),
            .reg_b_pIn(reg_b_pIn),
            .reg_a_sIn(reg_a_sIn),
            .reg_b_sIn(reg_b_sIn),
            .reg_plain_enable(reg_plain_enable),
            .reg_mux_address(reg_mux_address));

//instantiation of shift register to move a
shiftregister8 shifta  (.parallelOut(reg_a_out),
                       .clk(clk),
                       .mode(reg_a_mode),
                       .parallelIn({32'b00000000000000000000000000000000,a}),
                       .serialIn(reg_a_sIn));

//instantiation of shift register to move b
shiftregister4 shiftb  (.parallelOut(reg_b_out),
                       .clk(clk),
                       .mode(reg_b_mode),
                       .parallelIn(reg_b_pIn),
                       .serialIn(reg_b_sIn));

//mux to select shift a or all zero based on LSB of b as it gets shifted
mux2way_8bit mux0 (.out(mux_out),
                  .address(reg_b_out[0]),
                  .input0(64'b0000000000000000000000000000000000000000000000000000000000000000),
                  .input1(reg_a_out));
//adder module
FullAdder8bit adder
                  (.sum(adderOut),
                   .carryout(),
                   .overflow(),
                   .a(mux_out),
                   .b(reg_plain_out),
                   .carryin(1'b0));
//rgister to hold output of adder
register8bit reg_plain
                   (.q(reg_plain_out),
                    .d(reg_plain_input),
                    .wrenable(reg_plain_enable),
                    .clk(clk));
//instantiate mux that feeds into the reg_plain that feeds into adder
mux2way_8bit mux1 (.out(reg_plain_input),
                  .address(reg_mux_address),
                  .input0(64'b0000000000000000000000000000000000000000000000000000000000000000),
                  .input1(adderOut));
//instantiate the plain register 2 that pull output from adder and shows result during done stage
register8bit reg_plain2
                   (.q(result),
                    .d(adderOut),
                    .wrenable(done),
                    .clk(clk));

endmodule
