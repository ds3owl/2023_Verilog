module p2s(
   input clk,
   input n_rst,
   input [3:0] din,
   input send,
   input load,
   output wire data,
   output wire vld
);

reg [3:0] temp_din;

always @(posedge clk or negedge n_rst) begin
   if (!n_rst) begin
      temp_din <= 4'b0000;
   end
   else if (load) begin
      temp_din <= din;
   end
   else if (send) begin
      temp_din[3] <= 1'b0;
      temp_din[2] <= temp_din[3];
      temp_din[1] <= temp_din[2];
      temp_din[0] <= temp_din[1];
   end
end

assign data = temp_din[0];
assign vld = (send) ? 1'b1 : 1'b0;

endmodule
