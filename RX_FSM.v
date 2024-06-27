module RX_FSM(start_bit,parity_error,CLK,RST,shift,parity_load,check_stop);
  input start_bit,parity_error,CLK,RST;
  output reg shift,parity_load,check_stop;
  
  parameter IDLE = 2'b00, DATA = 2'b01, PARITY = 2'b10, STOP = 2'b11;
  reg [1:0] PS,NS;
  wire [7:0] data;
  reg [2:0] counter;
  reg count_en;
  
 always @(posedge CLK or posedge RST) begin
   if (RST)
	  PS <= IDLE;
	else
	  PS <= NS;
  end	  
  
  always @(*) begin
        case (PS)
            IDLE: begin
                   if (start_bit == 0)
                     NS = DATA;
						 else
						   NS = IDLE;
            end
            
            DATA: begin
                if (data) begin
                    NS = PARITY;
                end else begin
					     NS = DATA;
                end 
            end
            
            PARITY: begin
				         if (parity_error)
                      NS = IDLE;
						   else
					       NS = STOP;		
						 end
            
            STOP: begin
                   if  (check_stop)
						   NS = IDLE;
						 else
                     NS = IDLE;
            end
            
            default: NS = IDLE;
        endcase
    end
  
  always @(*) begin
	   case (PS)
		  IDLE : begin
		           parity_load = 1'b0;
				     shift = 1'b0;
				     count_en = 1'b0;
				     check_stop = 1'b1;	  
				end
				
		 DATA : begin
		           parity_load = 1'b0;
				     shift = 1'b1; 
					  count_en = 1'b1;
					  check_stop = 1'b0;
				end
				
		PARITY : begin
		           parity_load = 1'b1;
				     shift = 1'b0; 
					  count_en = 1'b0;
					  check_stop = 1'b0;
				end
				
		STOP :  begin
		           parity_load = 1'b0;
				     shift = 1'b0;
					  count_en = 1'b0;
					  check_stop = 1'b1;
				end
    endcase
	end
	
	assign data = (counter == 7);
    always @(posedge CLK or posedge RST) begin
        if (RST)
            counter <= 3'b0;
        else if (count_en) begin
             counter <= counter + 1;
				 end
        else
             counter <= 3'b0; // Maintain the counter when it's 8
        end 





endmodule