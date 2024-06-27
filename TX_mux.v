module TX_mux(Start,Data,Parity,Stop,sel,TX_out);
  input Start,Data,Parity,Stop;
  input [1:0] sel;
  output reg TX_out;
  
  always @(sel,Data,Parity) begin
  case (sel) 
   2'b00 : TX_out = Start;
	2'b01 : TX_out = Data;
	2'b10 : TX_out = Parity;
	2'b11 : TX_out = Stop;
	default : TX_out = 1'b0;
  endcase
 end
endmodule