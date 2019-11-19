// Multiplexer circuit

module behavioralMultiplexer
(
    output out,
    input address0,
    input in0, in1
);
    // Join single-bit inputs into a bus, use address as index
    wire[3:0] inputs = {in1, in0};
    wire address0;
    assign out = inputs[address0];
endmodule


// module structuralMultiplexer
// (
//     output out,
//     input address0,
//     input in0, in1
// );
//     wire nA0;
//     wire I1;
//     wire I0;
//     not A0inv(nA0, address0);
//     and andgate3(I3,in3,address0,address1);
//     and andgate2(I2,in2,nA0, address1);
//     and andgate1(I1,in1,address0, nA1);
//     and andgate0(I0,in0,nA1, nA1);
//     or orgate(out,I3,I2,I1,I0);
// endmodule
