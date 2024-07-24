module hw_always (
  input [2:0] din0,
  input [2:0] din1,
  input [1:0] sel,
  output reg [2:0] dout
);
//??2 ??? always, if-else? ??? ??
always @(din0 or din1 or sel)
begin
  if (sel == 2'b00)
    dout = din0 + din1;
  else if (sel == 2'b01) 
    dout = din0 + (~din1 + 2'b01);
  else if (sel == 2'b10)
    dout = din0 & din1;
  else if (sel == 2'b11) 
    dout = {1'b0, din0[2:1]};
  else 
    dout = 3'b000;
end

endmodule