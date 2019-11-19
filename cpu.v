`include "LUT.v"
`include "alu.v"
`include "memory.v"
`include "2way32b.v"
`include "2way5b.v"
`include "regfile.v"
`include "signextend.v"

module CPU (
input clk
  );
/*WIRING*/

//Control Unit
wire [3:0] signalCommand;
wire [2:0] alu_sel, alui_sel;
wire jump, jr_sel, jal_sel_d, jal_sel_addr;
wire mem_to_reg, mem_write, bne, beq, alu_src_sel, reg_dest, reg_write_en;


//PC wires
wire [31:0] PC_curr; //current program counter to be fed into memory
wire pcSource; //source for one of the PC mux
wire [31:0] holdPC;
//mem wires
wire [31:0] ReadData,ALUResult,instruction,WriteData,MemToMux;
//wire mem_write;
wire [31:0]WDin;
//register file wires
wire [31:0]RD1;//,ALUResult;
wire [31:0]RegWrite;
wire [4:0]a3muxW,a3in;
//ALU
wire zero;
wire [31:0]ALUb;
//Sign Extesion
wire [31:0] extendedInst;
//ALUi
wire [31:0] aluiA;
wire [31:0] aluiOut;
wire [31:0] jumpMuxOut;
wire [31:0] pcMuxOut;
wire [31:0] pcJump;
wire [31:0] shift2mux;
wire [63:0] multout;
wire done_mult;
//adderOut
wire [31:0]adderOut;
wire [31:0]reg_hi_out;
wire [31:0]reg_hi_out;
wire [63:0]multiplier_data;
/*MODULE INSTANTIATION*/
cpuControlUnit CU (.jump(jump),
                  .jr_sel(jr_sel),
                  .jal_sel_d(jal_sel_d),
                  .jal_sel_addr(jal_sel_addr),
                  .mem_to_reg(mem_to_reg),
                  .mem_write(mem_write),
                  .bne(bne),
                  .beq(beq),
                  .alu_src_sel(alu_src_sel),
                  .reg_dest(reg_dest),
                  .alu_sel(alu_sel),
                  .reg_write_en(reg_write_en),
                  .alui_sel(alui_sel),
                  .instruction(instruction));

memory Mem(    //instmem
               .PC(PC_curr),		// Program counter (instruction address)
               .instruction(instruction),
               //datamem
               .data_out(MemToMux),
               .data_in(WriteData),
               .data_addr(ALUResult),
               .clk(clk),
               .wr_en(mem_write)//IS THIS THE RIGHT CONTROL SIGNAL????
            );

mux2way32b MemOutMux (.out(ReadData),//initialize the 8 bit output
                      .address(mem_to_reg),
                      .input0(ALUResult),
                      .input1(MemToMux)//each of the two inputs are 8 bits
                      );
mux2way5b a3mux (.out(a3muxW),//initialize the 8 bit output
                      .address(jal_sel_addr),
                      .input0(a3in),
                      .input1(5'b11111));//each of the two inputs are 8 bits
mux2way5b instmux(.out(a3in),//initialize the 8 bit output
                       .address(reg_dest),
                       .input0(instruction[20:16]),
                       .input1(instruction[15:11])
                                            );
mux2way32b Regwritemux(.out(RegWrite),//initialize the 8 bit output
                   .address(jal_sel_d),
                   .input0(ReadData),
                   .input1(adderOut)//
                  );

regfile regfile
            (.ReadData1(RD1),	// Contents of first register read
            .ReadData2(WriteData),	// Contents of second register read
            .WriteData(WDin),	// Contents to write to register
            .ReadRegister1(instruction[25:21]),	// Address of first register to read
            .ReadRegister2(instruction[20:16]),	// Address of second register to read
            .WriteRegister(a3muxW),	// Address of register to write
            .RegWrite(reg_write_en),	// Enable writing of register when High
            .Clk(clk)		// Clock (Positive Edge Triggered)
            );
ALU alu
            (.operandA(RD1),
             .operandB(ALUb),
             .result(ALUResult),
             .command(alu_sel),
             .carryout(),
             .overflow(),
             .zero(zero));
//and gate to handle branch case
// and zeroflag (pcSource,zero,bne);

not notbne      (n_bne, bne);
not notbeq      (n_beq, beq);
not notzero     (n_zero, zero);
and andbne      (bneout,zero,n_bne,beq);
and andbeq      (beqout,n_zero,n_beq,bne);
or pcsourceor   (pcSource,bneout, beqout);


mux2way32b alumux(.out(ALUb),
                   .address(alu_src_sel),
                   .input0(WriteData),
                   .input1(extendedInst));

signextend signExtend(.sign_in(instruction[15:0]),
                      .sign_out(extendedInst));  //extended instruction

ALU adder(.operandA(PC_curr),
          .operandB(32'b00000000000000000000000000000100),
          .result(adderOut),
          .command(3'b000),
          .carryout(),
          .overflow(),
          .zero());

register32 PC  (.q(PC_curr),
               .d(holdPC),
               .wrenable(1'b1),
               .clk(clk));
//Shift by 2 after sign extension
assign aluiA={extendedInst[29:0],2'b00};

//shift by 2
assign shift2mux ={instruction[25:0],2'b00}; //the shift by 2 that is aprt of the PC
//Concatinate 26 bits with 4 MSB of current PC
assign pcJump={adderOut[31:28],shift2mux};


ALU alu_imm (.operandA(aluiA),
             .operandB(adderOut),
             .result(aluiOut),
             .command(alui_sel),
             .carryout(),
             .overflow(),
             .zero());

mux2way32b JRmux(.out(holdPC),
                  .address(jr_sel),
                  .input0(jumpMuxOut),
                  .input1(RD1));

mux2way32b Jumpmux(.out(jumpMuxOut),
                  .address(jump),
                  .input0(pcMuxOut),
                  .input1(pcJump));

mux2way32b pc_sourceMUX(.out(pcMuxOut),
                        .address(pcSource),
                        .input0(adderOut),
                        .input1(aluiOut));

register32 lo_reg (.q(reg_lo_out),
                   .d(multout[0:31]),
                   .wrenable(done_mult,
                   .clk(mul_clk));

register32 hi_reg (.q(reg_hi_out),
                   .d(multout[32:63]),
                   .wrenable(done_mult),
                   .clk(mul_clk));

multiplier  mult32  (.a(RD1),
                     .b(WriteData),
                     .clk(mul_clk),
                     .start(clk),
                     .done(done_mult),
                     .result(multout));

mux3way32b multiplierMUX(.out(WDin),
                        .address(pcSource),
                        .input0(RegWrite),
                        .input1(reg_hi_out),
                        .input2(reg_lo_out));
endmodule
