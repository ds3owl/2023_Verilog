module tb_hw_assign;
  reg [2:0] din0; 
  reg [2:0] din1;
  reg [1:0] sel;
  wire [2:0] dout; //output ??? dout? wire? ??, ???? reg? ??

  initial begin
    din0 = 3'h2;
    din1 = 3'h1;
    sel = 2'h0;
    #(10) sel = 2'h1;
    #(10) sel = 2'h2;
    #(10) sel = 2'h3;
    #(10)
    din0 = 3'h3; //3?? din0? 2?? ?? 3 
    din1 = 3'h6; //3?? din1? 2?? ?? -2(2? ?? ??) 
    sel = 2'h0; //2?? sel? 1?? ?? 0
    #(10) sel = 2'h1; //2?? sel? 2?? ?? 1
    #(10) sel = 2'h2; //2?? sel? 3?? ?? 2
    #(10) sel = 2'h3; //2?? sel? 4?? ?? 3
    #(10) $stop;
  end

  hw_assign u_hw_assign ( //????
    .din0(din0),
    .din1(din1),
    .sel(sel),
    .dout(dout)
  );

endmodule