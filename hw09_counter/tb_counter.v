`timescale 1ns/1ps
`define T_CLK 10

module tb_counter;

reg clk;
reg n_rst;
initial clk = 1'b1;
always #(`T_CLK/2) clk = ~clk;

initial begin
	n_rst = 1'b0;
	#(`T_CLK * 1.2) n_rst = 1'b1;
end

reg up;
wire [1:0] cnt1;
wire [1:0] cnt2;

initial begin
	up = 1'b0;
	wait(n_rst == 1'b1);
	#(`T_CLK) up = 1'b1 ;
	#(`T_CLK * 3) up = 1'b0;
	#(`T_CLK * 4) up = 1'b1;
	#(`T_CLK * 5) up = 1'b0;
	#(`T_CLK * 6) up = 1'b1;
	#(`T_CLK * 7) up = 1'b0;
	#(`T_CLK * 8) $stop;
end

counter u_counter(
.clk(clk),
.n_rst(n_rst),
.up(up),
.cnt1(cnt1),
.cnt2(cnt2)
);

endmodule