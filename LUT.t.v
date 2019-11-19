`include "LUT.v"


module testLUT();

  reg [3:0] signalCommand;
  wire jump,jr_sel,jal_sel_d,jal_sel_addr,mem_to_reg,mem_write,branch,reg_dest,alu_src_sel;
  wire [2:0] alu_sel, alui_sel;

  cpuControlUnit cpu (.jump(jump),
                      .signalCommand(signalCommand),
                      .jr_sel(jr_sel),
                      .jal_sel_d(jal_sel_d),
                      .jal_sel_addr(jal_sel_addr),
                      .mem_to_reg(mem_to_reg),
                      .mem_write(mem_write),
                      .branch(branch),
                      .alu_sel(alu_sel),
                      .alui_sel(alui_sel),
                      .alu_src_sel(alu_src_sel),
                      .reg_dest(reg_dest));

    initial begin
        $dumpfile("lut-signals.vcd");
        $dumpvars();

        $display(" ");
        signalCommand = `LW; #1000
        $display("LW -------------------");
        $display(" %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  |", jump,jr_sel,jal_sel_d,jal_sel_addr,mem_to_reg,mem_write,branch, alu_sel, alui_sel, alu_src_sel, reg_dest);

        signalCommand = `SW; #1000
        $display("SW -------------------");
        $display(" %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  |", jump,jr_sel,jal_sel_d,jal_sel_addr,mem_to_reg,mem_write,branch, alu_sel, alui_sel, alu_src_sel, reg_dest);

        signalCommand = `BEQ; #1000
        $display("BEQ -------------------");
        $display(" %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  |", jump,jr_sel,jal_sel_d,jal_sel_addr,mem_to_reg,mem_write,branch, alu_sel, alui_sel, alu_src_sel, reg_dest);

        signalCommand = `BNE; #1000
        $display("BNE -------------------");
        $display(" %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  |", jump,jr_sel,jal_sel_d,jal_sel_addr,mem_to_reg,mem_write,branch, alu_sel, alui_sel, alu_src_sel, reg_dest);

        signalCommand = `J; #1000
        $display("J -------------------");
        $display(" %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  |", jump,jr_sel,jal_sel_d,jal_sel_addr,mem_to_reg,mem_write,branch, alu_sel, alui_sel, alu_src_sel, reg_dest);

        signalCommand = `JR; #1000
        $display("JR -------------------");
        $display(" %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  |", jump,jr_sel,jal_sel_d,jal_sel_addr,mem_to_reg,mem_write,branch, alu_sel, alui_sel, alu_src_sel, reg_dest);

        signalCommand = `JAL; #1000
        $display("JAL -------------------");
        $display(" %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  |", jump,jr_sel,jal_sel_d,jal_sel_addr,mem_to_reg,mem_write,branch, alu_sel, alui_sel, alu_src_sel, reg_dest);

        signalCommand = `ADD; #1000
        $display("ADD -------------------");
        $display(" %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  |", jump,jr_sel,jal_sel_d,jal_sel_addr,mem_to_reg,mem_write,branch, alu_sel, alui_sel, alu_src_sel, reg_dest);

        signalCommand = `ADDI; #1000
        $display("ADDI -------------------");
        $display(" %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  |", jump,jr_sel,jal_sel_d,jal_sel_addr,mem_to_reg,mem_write,branch, alu_sel, alui_sel, alu_src_sel, reg_dest);

        signalCommand = `XORI; #1000
        $display("XORI -------------------");
        $display(" %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  | %b  |", jump,jr_sel,jal_sel_d,jal_sel_addr,mem_to_reg,mem_write,branch, alu_sel, alui_sel, alu_src_sel, reg_dest);

        end

        endmodule
