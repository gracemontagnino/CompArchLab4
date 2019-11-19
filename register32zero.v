module register32zero
(
output reg [31:0] q,
input       [31:0] d,
input       wrenable,
input       clk
);
//genvar i;
////for (i=0;i<32;i=i+1)begin
    // always @(posedge clk) begin
    //     if(wrenable) begin
    //         q <= 32'd0;
    //     end
    // end
    //end

initial begin
  q=32'b00000000000000000000000000000000;
end
endmodule
