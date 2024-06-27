module PISO(TX_data,LOAD,CLK,RST,shift,OUT);
 input [7:0] TX_data;
 input LOAD,CLK,RST,shift;
 output OUT;
 reg [7:0] IN;
 
 assign OUT = IN[0];
 
 always @(posedge CLK or posedge RST) begin
  if (RST) begin
     IN <= 8'b0;
   end
	
  else if (LOAD) begin
     IN <= TX_data;
	end
	 
  else if (shift) begin
	  IN <= {1'b0,IN[7:1]};
   end
  else
     IN <= IN;
	end
endmodule
  
	