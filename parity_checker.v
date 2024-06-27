module parity_checker(
  input [7:0] data_in,
  input parity_load,
  output parity_error,
  output [7:0] data_out  
);
  wire parity_in;
  assign parity_error = parity_load && (parity_in != ^data_in); // if parity_load =1 and parity_in != data_in, parity error =1
  assign data_out = parity_error ? 0 : data_in;

  /*wire parity_check;
  wire parity;
  
  assign parity = parity_load ^ RX_in;
  assign parity_check = parity;
  
 
 always @(posedge CLK or posedge RST) begin
   if (RST)
	   error <= 1'b1;
   else if (parity_check == 1'b0)
	  error <= 1'b0;
	 else
	  error <= 1'b1;
 end*/
endmodule