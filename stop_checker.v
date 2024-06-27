module stop_checker(data_in,check_stop,stop_error,RX_out);
  input check_stop;
  input [7:0] data_in;
  output stop_error;
  output [7:0] RX_out;
  wire stop_in;
  
  assign stop_error = check_stop && (!stop_in);  //if check_stop = 1 && stop_in == 0, stop_error =1
  assign RX_out = stop_error ? 0 : data_in;
  
  /*always @(posedge CLK or posedge RST) begin
    if (RST) begin
	   stop_error <= 1'b0;
		RX_out <= 8'b0;
	  end
	 else if (check_stop) begin 
	   stop_error <= 1'b1;
		RX_out <= {RX_out[7:1],RX_in};
	  end
	 else begin
	   stop_error <= 1'b0;
		RX_out <= 8'b0;
	  end
	end
*/	


endmodule