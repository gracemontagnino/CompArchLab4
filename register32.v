module register32
(
output reg [31:0] q,
input       [31:0] d,
input       wrenable,
input       clk
);
//genvar i;
//generate
//for (i=0;i<32;i=i+1)begin
    always @(posedge clk) begin
        if(wrenable) begin
            q<= d;
        end
    end
  //  end
endmodule
