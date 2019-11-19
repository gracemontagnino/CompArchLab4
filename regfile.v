`include "decoders.v"
`include "mux32to1by1.v"
`include "mux32to1by32.v"
`include "register32zero.v"
`include "register.v"
`include "register32.v"

//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------

module regfile
(
output[31:0]	ReadData1,	// Contents of first register read
output[31:0]	ReadData2,	// Contents of second register read
input[31:0]	WriteData,	// Contents to write to register
input[4:0]	ReadRegister1,	// Address of first register to read
input[4:0]	ReadRegister2,	// Address of second register to read
input[4:0]	WriteRegister,	// Address of register to write
input		RegWrite,	// Enable writing of register when High
input		Clk		// Clock (Positive Edge Triggered)
);
wire [31:0] outd;
wire [31:0] reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14,reg15,reg16,reg17,reg18,reg19,reg20,reg21,reg22,reg23,reg24,reg25,reg26,reg27,reg28,reg29,reg30,reg31;
decoder1to32 d32(.out(outd),.enable(RegWrite),.address(WriteRegister));

register32zero r0(.q(reg0),.wrenable(outd[0]),.d(WriteData),.clk(Clk));
register32 r1(.q(reg1),.wrenable(outd[1]),.d(WriteData),.clk(Clk));
register32 r2(.q(reg2),.wrenable(outd[2]),.d(WriteData),.clk(Clk));
register32 r3(.q(reg3),.wrenable(outd[3]),.d(WriteData),.clk(Clk));
register32 r4(.q(reg4),.wrenable(outd[4]),.d(WriteData),.clk(Clk));
register32 r5(.q(reg5),.wrenable(outd[5]),.d(WriteData),.clk(Clk));
register32 r6(.q(reg6),.wrenable(outd[6]),.d(WriteData),.clk(Clk));
register32 r7(.q(reg7),.wrenable(outd[7]),.d(WriteData),.clk(Clk));
register32 r8(.q(reg8),.wrenable(outd[8]),.d(WriteData),.clk(Clk));
register32 r9(.q(reg9),.wrenable(outd[9]),.d(WriteData),.clk(Clk));
register32 r10(.q(reg10),.wrenable(outd[10]),.d(WriteData),.clk(Clk));
register32 r11(.q(reg11),.wrenable(outd[11]),.d(WriteData),.clk(Clk));
register32 r12(.q(reg12),.wrenable(outd[12]),.d(WriteData),.clk(Clk));
register32 r13(.q(reg13),.wrenable(outd[13]),.d(WriteData),.clk(Clk));
register32 r14(.q(reg14),.wrenable(outd[14]),.d(WriteData),.clk(Clk));
register32 r15(.q(reg15),.wrenable(outd[15]),.d(WriteData),.clk(Clk));
register32 r16(.q(reg16),.wrenable(outd[16]),.d(WriteData),.clk(Clk));
register32 r17(.q(reg17),.wrenable(outd[17]),.d(WriteData),.clk(Clk));
register32 r18(.q(reg18),.wrenable(outd[18]),.d(WriteData),.clk(Clk));
register32 r19(.q(reg19),.wrenable(outd[19]),.d(WriteData),.clk(Clk));
register32 r20(.q(reg20),.wrenable(outd[20]),.d(WriteData),.clk(Clk));
register32 r21(.q(reg21),.wrenable(outd[21]),.d(WriteData),.clk(Clk));
register32 r22(.q(reg22),.wrenable(outd[22]),.d(WriteData),.clk(Clk));
register32 r23(.q(reg23),.wrenable(outd[23]),.d(WriteData),.clk(Clk));
register32 r24(.q(reg24),.wrenable(outd[24]),.d(WriteData),.clk(Clk));
register32 r25(.q(reg25),.wrenable(outd[25]),.d(WriteData),.clk(Clk));
register32 r26(.q(reg26),.wrenable(outd[26]),.d(WriteData),.clk(Clk));
register32 r27(.q(reg27),.wrenable(outd[27]),.d(WriteData),.clk(Clk));
register32 r28(.q(reg28),.wrenable(outd[28]),.d(WriteData),.clk(Clk));
register32 r29(.q(reg29),.wrenable(outd[29]),.d(WriteData),.clk(Clk));
register32 r30(.q(reg30),.wrenable(outd[30]),.d(WriteData),.clk(Clk));
register32 r31(.q(reg31),.wrenable(outd[31]),.d(WriteData),.clk(Clk));
// assign ReadData1 = RegWrite<<ReadRegister1;
  // assign ReadData2 = 42;
  // These two lines are clearly wrong.  They are included to showcase how the
  // test harness works. Delete them after you understand the testing process,
  // // and replace them with your actual code.
  // assign ReadData1 = RegWrite<<ReadRegister1;
  // assign ReadData2 = 42;
mux32to1by32 mux1(ReadData1,ReadRegister1,reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14,reg15,reg16,reg17,reg18,reg19,reg20,reg21,reg22,reg23,reg24,reg25,reg26,reg27,reg28,reg29,reg30,reg31);
mux32to1by32 mux2(ReadData2,ReadRegister2,reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14,reg15,reg16,reg17,reg18,reg19,reg20,reg21,reg22,reg23,reg24,reg25,reg26,reg27,reg28,reg29,reg30,reg31);
endmodule
