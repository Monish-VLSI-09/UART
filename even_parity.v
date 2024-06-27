module even_parity(TX_data,LOAD,CLK,RST,parity_out);
  input [7:0] TX_data;
  input LOAD,CLK,RST;
  output reg parity_out;
  
  always @(posedge CLK or posedge RST) begin
   if (RST)
	  parity_out <= 1'b0;
   else  if (LOAD)
    parity_out <= ^ TX_data;
	else
	 parity_out <= parity_out;
  end
  
endmodule