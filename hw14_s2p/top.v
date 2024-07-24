module top (
  input clk,
  input n_rst,
  input [3:0] din,
  input send,
  input load,
  output wire data,
  output wire vld,
  output [3:0]dout,
  output dout_vld
  );

p2s u_p2s(
  .clk(clk),
  .n_rst(n_rst),
  .din(din),
  .send(send),
  .load(load),
  .data(data),
  .vld(vld)
  );
  
s2p u_s2p(
  .clk(clk),
  .n_rst(n_rst),
  .data(data),
  .vld(vld),
  .dout(dout),
  .dout_vld(dout_vld)
  );
endmodule