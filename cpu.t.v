/*This is our top levle module for the single cycle cpu*/


`include "cpu.v"


module cpu_test ();

    reg clk;
    // Clock generation
    initial clk=0;
    always #200 clk = !clk;

    // Instantiate cpu
    CPU cpu(.clk(clk));

    // Filenames for memory images and VCD dump file
    reg [1023:0] mem_text_fn;
    reg [1023:0] mem_data_fn;
    reg [1023:0] dump_fn;
    reg init_data = 0;      // Initializing .data segment is optional

initial cpu.PC.q = 32'b0;
    //Test sequence
    initial begin
    if (! $value$plusargs("mem_text_fn=%s", mem_text_fn)) begin
    	    $display("ERROR: provide +mem_text_fn=[path to .text memory image] argument");
    	    $finish();
            end

    	if (! $value$plusargs("dump_fn=%s", dump_fn)) begin
    	    $display("ERROR: provide +dump_fn=[path for VCD dump] argument");
    	    $finish();
            end

        // Load CPU memory from (assembly) dump files
	$readmemh(mem_text_fn, cpu.Mem.mem, 0);
        if (init_data) begin
	    $readmemh(mem_data_fn, cpu.Mem.mem, 4095);
        end


//display status of program counter and instructions
	$dumpfile(dump_fn);
	$dumpvars();
  $dumpvars (0,cpu.Mem.mem[4094]); //memory at 16376
	$display("Time | PC       | Instruction");
	repeat(20) begin
        $display("%4t | %h | %h", $time, cpu.PC_curr, cpu.instruction); #20;
        end
	$display("... more execution (see waveform)");

	#20000 $finish();
    end

endmodule
