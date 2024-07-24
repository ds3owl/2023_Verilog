module counter(
	clk,
	n_rst,
	up,
	cnt1,
	cnt2
);

input clk;
input n_rst;
input up;
output[1:0] cnt1;
output[1:0] cnt2;

reg [1:0] cnt1;
reg [1:0] cnt2;

always @(posedge clk or negedge n_rst) //units
	if(!n_rst) begin
		cnt1 <= 2'b00;
	end

	else begin
		cnt1 <= ((up == 1'b1)&&(cnt1 == 2'b10)) ? 2'b00 :
			(up == 1'b1)? cnt1 + 2'b1 : cnt1;
	end

always @(posedge clk or negedge n_rst) //tens
	if(!n_rst) begin
		cnt2 <= 2'b00;
	end

	else begin
		cnt2 <= ((up == 1'b1)&&(cnt1 == 2'b10)&&(cnt2 == 2'b10)) ? 2'b00 :
			((up == 1'b1)&&(cnt1 == 2'b10))? cnt2 + 2'b1 : cnt2;
	end

endmodule
