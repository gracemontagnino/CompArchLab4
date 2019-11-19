/*Look up table for CPU Control Unit
Lab 3, the VGA Cables
*/

// define MIPS instruction names and values
`define LW 6'b100011
`define SW 6'b101011
`define BEQ 6'b000100
`define BNE 6'b000101
`define J 6'b000010
`define JR 6'b001000
`define ADD 6'b100000
`define JAL 6'b000011
`define R 6'b000000
`define ADDI 6'b001000
`define XORI 6'b001110
`define SLT 6'b101010
`define SUB 6'b100010
`define MULT 6'b011000
`define MFHI 6'b010000
`define MFLO 6'b010010
// define ALU commands
`define ALU_ADD 3'b000
`define ALU_SUB 3'b001
`define ALU_XOR 3'b010
`define ALU_SLT 3'b011
// define rd and rt for mux select line
`define RD 1'b1
`define RT 1'b0

module cpuControlUnit (
output reg multiplier, jump, jr_sel, jal_sel_d, jal_sel_addr, mem_to_reg, mem_write, beq, bne, alu_src_sel, reg_dest,reg_write_en,pc_source,
output reg [2:0] alu_sel, alui_sel,

input [31:0] instruction

);
wire [5:0]opcode,funct;
assign opcode = instruction[31:26];
assign funct = instruction[5:0];


//creating an initial case
initial begin
  jump=1'b0; jr_sel=1'b0;jal_sel_d=1'b0;jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b0;beq=1'b0;alu_sel=1'b0;    alui_sel=`ALU_XOR;alu_src_sel=1'b0;reg_dest=`RT; pc_source=1'b0;
end

//updating the case every clock cycle based on instruction
always @(*)begin

    case (opcode)
        `LW:   begin multiplier=2'b00;                  jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b1;mem_write=1'b0;reg_write_en=1'b1;beq=1'b0;bne=1'b0;alu_sel=3'b000;    alui_sel=3'b000;     alu_src_sel=1'b1;  reg_dest=1'b0; end
        `SW:   begin multiplier=2'b00;                  jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b1;mem_write=1'b1;reg_write_en=1'b0;beq=1'b0;bne=1'b0;alu_sel=3'b000;    alui_sel=3'b000;     alu_src_sel=1'b1;  reg_dest=1'b0; end
        `BEQ:  begin multiplier=2'b00;                  jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b0;beq=1'b1;bne=1'b0;alu_sel=`ALU_SUB;  alui_sel=3'b000;     alu_src_sel=1'b0;  reg_dest=1'b0; end
        `BNE:  begin multiplier=2'b00;                  jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b0;beq=1'b0;bne=1'b1;alu_sel=`ALU_SUB;  alui_sel=3'b000;     alu_src_sel=1'b0;  reg_dest=1'b0; end
        `J:    begin multiplier=2'b00;                  jump=1'b1; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b0;beq=1'b0;bne=1'b0;alu_sel=3'b000;    alui_sel=3'b000;     alu_src_sel=1'b0;  reg_dest=1'b0; end
        `JAL:  begin multiplier=2'b00;                  jump=1'b1; jr_sel=1'b0; jal_sel_d=1'b1; jal_sel_addr=1'b1;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b1;beq=1'b0;bne=1'b0;alu_sel=3'b000;    alui_sel=3'b000;     alu_src_sel=1'b0;  reg_dest=1'b0; end
        `ADDI: begin multiplier=2'b00;                  jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b1;beq=1'b0;bne=1'b0;alu_sel=3'b000;    alui_sel=`ALU_ADD;   alu_src_sel=1'b1;  reg_dest=1'b0; end
        `XORI: begin multiplier=2'b00;                  jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b1;beq=1'b0;bne=1'b0;alu_sel=3'b000;    alui_sel=`ALU_XOR;   alu_src_sel=1'b1;  reg_dest=1'b0; end
        `R:begin
              if (funct==`JR) begin multiplier=2'b00;   jump=1'b1; jr_sel=1'b1; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b1;beq=1'b0;bne=1'b0;alu_sel=3'b000;    alui_sel=1'b0;       alu_src_sel=1'b0;  reg_dest=1'b1; end
              if (funct==`ADD) begin multiplier=2'b00;  jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b1;beq=1'b0;bne=1'b0;alu_sel=`ALU_ADD;  alui_sel=3'b000;     alu_src_sel=1'b1;  reg_dest=1'b1; end
              if (funct==`SUB) begin multiplier=2'b00;  jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b1;beq=1'b0;bne=1'b0;alu_sel=`ALU_SUB;  alui_sel=1'b0;       alu_src_sel=1'b1;  reg_dest=1'b1; end
              if (funct==`SLT) begin multiplier=2'b00;  jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b1;beq=1'b0;bne=1'b0;alu_sel=`ALU_SLT;  alui_sel=1'b0;       alu_src_sel=1'b1;  reg_dest=1'b1; end
              if (funct==`MULT) begin multiplier=2'b00; jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b1;beq=1'b0;bne=1'b0;alu_sel=3'b000;    alui_sel=1'b0;       alu_src_sel=1'b1;  reg_dest=1'b1; end
              if (funct==`MFHI) begin multiplier=2'b01; jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b1;beq=1'b0;bne=1'b0;alu_sel=3'b000;    alui_sel=1'b0;       alu_src_sel=1'b1;  reg_dest=1'b1; end
if (funct==`MULT) begin multiplier=1'b0;                jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b1;beq=1'b0;bne=1'b0;alu_sel=`ALU_SUB;  alui_sel=1'b0;       alu_src_sel=1'b1;  reg_dest=1'b1; end
              if (funct==`MFLO) begin multiplier=2'b10; jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b1;beq=1'b0;bne=1'b0;alu_sel=3'b000;    alui_sel=1'b0;       alu_src_sel=1'b1;  reg_dest=1'b1; end
              else begin multiplier=2'b00;              jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b0;beq=1'b0;bne=1'b0;alu_sel=3'b000;    alui_sel=`ALU_XOR;   alu_src_sel=1'b0;  reg_dest=1'b0; end

          end
        default: begin multiplier=2'b00;                jump=1'b0; jr_sel=1'b0; jal_sel_d=1'b0; jal_sel_addr=1'b0;mem_to_reg=1'b0;mem_write=1'b0;reg_write_en=1'b0;beq=1'b0;bne=1'b0;alu_sel=3'b000;    alui_sel=`ALU_XOR;alu_src_sel=1'b0;reg_dest=`RT;pc_source=1'b0; end
      endcase
   end
endmodule
