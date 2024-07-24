module de0_led_slider (
din,
dout,
fnd_30_out,
fnd_74_out
);

input [3:0] din;
output [7:0] dout;
output [6:0] fnd_30_out;
output [6:0] fnd_74_out;

assign dout[3:0] = din;
assign dout[7:4] = {2'b0, din[1:0]} + {2'b0, din[3:2]};

fnd_encoder u_fnd_encoder_1(
.number(dout[3:0]),
.fnd_on(fnd_30_out)
);

fnd_encoder u_fnd_encoder_2(
.number(dout[7:4]),
.fnd_on(fnd_74_out)
);
endmodule