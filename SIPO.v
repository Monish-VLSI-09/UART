module SIPO(RX_in,CLK,RST,shift,OUT);
  input RX_in;
  input CLK,RST,shift;
  output [9:0] OUT;  // 8bit data + 1 bit start + 1 bit parity
  reg [9:0] data;
  reg sample_done;
  
  always @(posedge CLK or posedge RST) begin
    if (RST)
	   data <= 8'b0;
	 else if (shift) begin
	    if (sample_done)
		   data <= {data[9:1],RX_in};
		 else
		    data <= data;
		 end
	 else
	   data <= data;
  end	
  assign OUT = data;
 endmodule 
	   
    