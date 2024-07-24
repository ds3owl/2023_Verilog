module carry_select_adder(
    din_a,
    din_b,
    cin,
    sum,
    cout
  );

    input [7:0] din_a;
    input [7:0] din_b;
    input cin;
    output reg [7:0] sum;
    output cout;
    wire [7:0] g = (din_a & din_b);
    wire [7:0] p = (din_a ^ din_b);   
    reg [7:1] c;

assign sum[1:0] = din_a[1:0] + din_b[1:0] + cin;
assign c[1] = g[0] + (p[0] & cin);
assign c[2] = g[1] + (p[1] & c[1]);

assign sum[3:2] = (c[2] == 1'h0) ? (din_a[3:2] + din_b[3:2]) : (din_a[3:2] + din_b[3:2] + 8'b1);
assign c[3] = g[2] + (p[2] & c[2]);
assign c[4] = g[3] + (p[3] & c[3]);

always @(din_a or din_b or c) begin
	
	if(c[4] == 1'b0) begin
		sum[5:4] = din_a[5:4] + din_b[5:4];
	end
	else begin
		sum[5:4] = din_a[5:4] + din_b[5:4] + 8'b1;
	end
end

assign c[5] = g[4] + (p[4] & c[4]);
assign c[6] = g[5] + (p[5] & c[5]);

always @(din_a or din_b or c)
	case(c[6])
		8'b0 : sum[7:6] = din_a[7:6] + din_b[7:6];
		8'b1 : sum[7:6] = din_a[7:6] + din_b[7:6] + 8'b1;
		default : sum[7:6] = din_a[7:6] + din_b[7:6];
	endcase

assign c[7] = g[6] + (p[6] & c[6]);
assign cout = g[7] + (p[7] & c[7]);

endmodule
