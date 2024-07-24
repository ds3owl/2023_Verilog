module s2p(
  input clk,
  input n_rst,
  input data,
  input vld,
  output reg [3:0]dout,
  output dout_vld
  );
  
  reg [2:0] cnt;
  
always @(posedge clk or negedge n_rst)
  if(!n_rst) begin
    dout <= 4'b0000;
  end
  else if (vld) begin
    dout[3] <= data; 
    dout[2] <= dout[3];
    dout[1] <= dout[2];
    dout[0] <= dout[1];
  end
  
always @(posedge clk or negedge n_rst)
  if(!n_rst) begin
    cnt <= 3'b000;
  end
  else begin
    cnt <= (vld == 1'b1) ? cnt+2'b01 : (cnt == 3'b100) ? 3'b000 : cnt;
  end
  
assign dout_vld = (cnt == 3'b100) ? 1'b1 : 1'b0;

endmodule
    