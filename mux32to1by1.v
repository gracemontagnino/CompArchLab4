module mux32to1by1
(
output      out,
input[4:0]  address,
input[31:0] inputs
);
wire[31:0] inputsofmux;
wire       outputofmux;

assign outputofmux=inputsofmux[address];

endmodule



// module mux32to1by1
// (
// output      out,
// input[4:0]  address,
// input[31:0] inputs
// );
//   assign out=inputs[address];
// endmodule
