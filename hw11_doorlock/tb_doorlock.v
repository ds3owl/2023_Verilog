`timescale 1ns/10ps
`define T_CLK 10
module tb_doorlock;

reg clk, n_rst;
initial clk = 1'b1;
always #(`T_CLK/2) clk = ~clk;

initial begin
  n_rst = 1'b0;
  #(`T_CLK*1.1) n_rst = 1'b1;
end

reg bt_0;
reg bt_1;
reg bt_2;
reg start;
wire led_0;
wire led_1;
wire led_2;
wire led_ok;
wire led_fail;

initial begin
  bt_0 = 1'b0;
  bt_1 = 1'b0;
  bt_2 = 1'b0;
  start = 1'b0;
  
  #(`T_CLK*2.2) start = 1'b1;
  #(`T_CLK) bt_2 = 1'b1;
  #(`T_CLK) bt_2 = 1'b0;
  #(`T_CLK) bt_0 = 1'b1;
  #(`T_CLK) bt_0 = 1'b0;
  #(`T_CLK) start = 1'b0;
  #(`T_CLK) start = 1'b1;
  #(`T_CLK) bt_2 = 1'b1;
  #(`T_CLK) bt_2 = 1'b0;
  #(`T_CLK) bt_1 = 1'b1;
  #(`T_CLK) bt_1 = 1'b0;
  #(`T_CLK) start = 1'b0;
  #(`T_CLK) start = 1'b1;
  #(`T_CLK) bt_0 = 1'b1;
  #(`T_CLK) bt_0 = 1'b0;
  #(`T_CLK) bt_0 = 1'b1;
  #(`T_CLK) bt_0 = 1'b0;
  #(`T_CLK) start = 1'b0;
  #(`T_CLK*3) $stop;
end

doorlock u_doorlock(
  .clk(clk),
  .n_rst(n_rst),
  .bt_0(bt_0),
  .bt_1(bt_1),
  .bt_2(bt_2),
  .start(start),
  .led_0(led_0),
  .led_1(led_1),
  .led_2(led_2),
  .led_ok(led_ok),
  .led_fail(led_fail)
  );
endmodule
  