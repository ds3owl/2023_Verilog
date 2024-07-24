module doorlock (
  input clk,
  input n_rst,
  input bt_0,
  input bt_1,
  input bt_2,
  input start,
  output reg led_0,
  output reg led_1,
  output reg led_2,
  output reg led_ok,
  output reg led_fail
  );
  
  parameter S_IDLE = 3'h0;
  parameter S_WAIT = 3'h1;
  parameter S_FIRST = 3'h2;
  parameter S_OK = 3'h3;
  parameter S_FAIL = 3'h4;
  parameter S_FAIL_WAIT = 3'h5;
  
  reg [2:0] c_state;
  reg [2:0] n_state;
  reg led_0_state;
  reg led_1_state;
  reg led_2_state;
  
  always @(posedge clk or negedge n_rst)
    if(!n_rst)
      c_state <= S_IDLE;
    else
      c_state <= n_state;
      
  always @(posedge clk or negedge n_rst)
    if(!n_rst)
      begin
        led_0_state <= 1'b0;
        led_1_state <= 1'b0;
        led_2_state <= 1'b0;
      end
    else
      begin
        led_0_state <= (bt_0 == 1'b1 || led_0 == 1'b1) ? 1'b1 : 1'b0;
        led_1_state <= (bt_1 == 1'b1 || led_1 == 1'b1) ? 1'b1 : 1'b0;
        led_2_state <= (bt_2 == 1'b1 || led_2 == 1'b1) ? 1'b1 : 1'b0;
      end
      
  always @(c_state or bt_0 or bt_1 or bt_2 or start)
    case(c_state)
      S_IDLE : begin
        n_state = (start == 1'b1) ? S_WAIT : c_state;
      end
      S_WAIT : begin
        n_state = (bt_0 == 1'b1 || bt_1 == 1'b1) ? S_FAIL_WAIT : 
        (bt_2 == 1'b1) ? S_FIRST : c_state; 
      end
      S_FIRST : begin
        n_state = (bt_1 == 1'b1 || bt_2 == 1'b1) ? S_FAIL : 
       (bt_0 == 1'b1) ? S_OK : c_state;
      end
      S_OK : begin
        n_state = (start == 1'b0) ? S_IDLE : c_state;
      end
      S_FAIL_WAIT : begin
        n_state = ((bt_0 == 1'b1)||(bt_1 == 1'b1)|| (bt_2 == 1'b1)) ? S_FAIL : c_state;
      end
      S_FAIL : begin
        n_state = (start == 1'b1) ? c_state : S_IDLE;
      end
      default : begin
        n_state = S_IDLE;
      end
    endcase
    
  always @(c_state or bt_0 or bt_1 or bt_2)
  begin
    case(c_state)
      S_IDLE : begin 
        led_0 = 1'b0;
        led_1 = 1'b0;
        led_2 = 1'b0;
        led_ok = 1'b0;
        led_fail = 1'b0;
      end
      S_WAIT : begin
        led_0 = 1'b0;
        led_1 = 1'b0;
        led_2 = 1'b0;
        led_ok = 1'b0;
        led_fail = 1'b0;
      end
      S_FIRST : begin
        led_0 = 1'b0;
        led_1 = 1'b0;
        led_2 = 1'b1;
        led_ok = 1'b0;
        led_fail = 1'b0;
      end
      S_OK : begin
        led_0 = 1'b1;
        led_1 = 1'b0;
        led_2 = 1'b1;
        led_ok = 1'b1;
        led_fail = 1'b0;
      end
      S_FAIL : begin
        led_0 = led_0_state;
        led_1 = led_1_state;
        led_2 = led_2_state;
        led_ok = 1'b0;
        led_fail = 1'b1;
      end
      S_FAIL_WAIT : begin
        led_0 = led_0_state;
        led_1 = led_1_state;
        led_2 = 1'b0;
        led_ok = 1'b0;
        led_fail = 1'b0;
      end
    endcase
  end
endmodule     