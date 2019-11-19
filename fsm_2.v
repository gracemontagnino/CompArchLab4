/*The finate state machine for our implemntation of an unsigned sequentail multiplier*/

`include "shiftregmodes.v"
`timescale 1 ns / 1 ps

module fsm
(
  input start, //start signal from top-level multiplier
  input clk,
  input standby,
  input setup,
  input register,
  input [3:0] b,


  output reg [1:0] reg_a_mode,
  output reg [1:0] reg_b_mode,
  output reg [7:0] reg_a_pIn,
  output reg [3:0] reg_b_pIn,
  output reg reg_a_sIn,
  output reg reg_b_sIn,
  output reg reg_plain_enable,
  output reg done,  //done signal returned by top-level multiplier
  output reg reg_mux_address);

  reg [2:0] state;
  reg [2:0] count;

//State encoding
  localparam STANDBY = 3'b000;
  localparam STANDBY2 = 3'b001;
  localparam SETUP = 3'b010;
  localparam SETUP2 = 3'b011;
  localparam REGISTER = 3'b100;
  localparam REGISTER2 = 3'b101;
  localparam DONE = 3'b110;

// State update logic
  initial begin
    state <= STANDBY;
  end

// Change state on the clk edges
  always @(posedge clk) begin

  // STANDBY
  if (state == STANDBY && start) begin
      state <= STANDBY2;
  end

  if (state == STANDBY2) begin
      state <= SETUP;
  end

  //SETUP
  if (state == SETUP) begin
      state <= REGISTER;
  end


  //REGISTER
  if (state == REGISTER) begin
      state <= REGISTER2;
  end

  if (state == REGISTER2) begin
    count = count + 1'b1;
    if (state == REGISTER2 && count < 3) begin
      state <= REGISTER;
    end
    if (state == REGISTER2 && count > 2) begin
      state <= DONE;
    end
  end

  // DONE
  if (state == DONE) begin
    state <= STANDBY;
  end

end

// Output logic, depends only on state
  always @(state) begin
      case(state)

      STANDBY: begin

      reg_a_mode = `HOLD;
      reg_b_mode = `HOLD;
      reg_b_pIn = 4'b0000;
      reg_a_sIn = 1'b0;
      reg_b_sIn = 1'b0;
      reg_plain_enable=1'b1;
      done=1'b0;
      reg_mux_address=1'b0;

      count = 2'b00;
      end

      STANDBY2: begin

      reg_a_mode = `PLOAD;
      reg_b_mode = `PLOAD;

      reg_b_pIn = 4'b0000;
      reg_a_sIn = 1'b0;
      reg_b_sIn = 1'b0;
      reg_plain_enable=1'b1;
      done=1'b0;
      reg_mux_address=1'b0;

      count = 2'b00;
      end

      SETUP: begin

      reg_a_mode = `PLOAD;
      reg_b_mode = `PLOAD;

      reg_b_pIn = b;

      reg_plain_enable = 1'b0;
      reg_mux_address = 1'b1;

      reg_a_sIn = 1'b0;
      reg_b_sIn = 1'b0;

      done = 1'b0;
      end

      REGISTER: begin

      reg_plain_enable = 1'b1;
      reg_a_mode = `LEFT;
      reg_b_mode = `RIGHT;

      reg_a_sIn = 1'b0;
      reg_b_sIn = 1'b0;
      done = 1'b0;
      reg_b_pIn = b;
      reg_mux_address = 1'b1;

      end

      REGISTER2: begin

      reg_plain_enable = 1'b0;
      reg_a_mode = `HOLD;
      reg_b_mode = `HOLD;

      reg_a_sIn = 1'b0;
      reg_b_sIn = 1'b0;
      done = 1'b0;
      reg_b_pIn = b;
      reg_mux_address = 1'b1;

      end

      DONE: begin
      reg_a_mode = `HOLD;
      reg_b_mode = `HOLD;
      reg_b_pIn = 4'b0000;
      reg_a_sIn = 1'b0;
      reg_b_sIn = 1'b0;
      reg_plain_enable = 1'b0;

      reg_mux_address = 1'b1;

      done = 1'b1;
      end

      endcase
  end
endmodule
