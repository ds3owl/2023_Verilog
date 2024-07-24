`timescale 1ns/1ps

`define T_CLK 10

module tb_top;

reg clk;
reg n_rst;
initial clk = 1'b1;
always #(`T_CLK/2) clk = ~clk;

initial begin
  n_rst = 1'b0;
  #(`T_CLK*1.2) n_rst = 1'b1;
end

reg [3:0] din;
reg load;
reg send;
wire [3:0]dout;
wire dout_vld;

initial begin
  din = 4'b0000;
  load = 1'b0;
  send = 1'b0;
  #(`T_CLK*3.1) din = 4'b1001; load = 1'b1;
  #(`T_CLK) load = 1'b0;
  #(`T_CLK*2) send = 1'b1;
  #(`T_CLK*4) send = 1'b0;
  #(`T_CLK*3) din = 4'b0011; load = 1'b1;
  #(`T_CLK) load = 1'b0;
  #(`T_CLK*2) send = 1'b1;
  #(`T_CLK*4) send = 1'b0;
  #(`T_CLK*2) $stop;
end

top u_top(
  .clk(clk),
  .n_rst(n_rst),
  .din(din),
  .send(send),
  .load(load),
  .dout(dout),
  .dout_vld(dout_vld)
  );

endmodule


