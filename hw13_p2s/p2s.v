module p2s (
  n_rst,
  clk,
  din,
  load,
  send,
  data,
  vld
  );
  
  input clk;
  input n_rst;
  input [3:0] din;
  input load;
  input send;
  output reg data;
  output reg vld;
  
  reg [3:0] data_copy;
  integer i;
  
  always @ (posedge clk or negedge n_rst)
    if(!n_rst)
      data_copy <= 4'b0000;
    else begin
     data_copy <= (load == 1'b1) ? {din[3],din[2],din[1],din[0]} : data_copy;
    end 
    
  always @ (posedge clk or negedge n_rst)
    if(!n_rst) begin
      data <= 1'b0;
    end
    else if(send == 1'b1) begin 
      data <= data_copy[3];
      data_copy[3] <= data_copy[2];
      data_copy[2] <= data_copy[1];
      data_copy[1] <= data_copy[0];
      data_copy[0] <= 1'b0;
    end
    else begin
      data <= 1'b0;
    end
  
   always @ (posedge clk or negedge n_rst)
    if((send == 1'b1)&&(data_copy != 4'b0000))
      vld <= 1'b1;
    else begin
      vld <= 1'b0;
    end
  
endmodule