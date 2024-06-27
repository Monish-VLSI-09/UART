module TX_FSM (
    input TX_start, 
    input CLK,RST,
    output reg load,
    output reg TX_busy,
    output reg [7:0] Shift,
    output reg [1:0] SEL
);
    parameter IDLE = 3'b000, START = 3'b001, DATA = 3'b010, PARITY = 3'b011, STOP = 3'b100;
    reg [2:0] PS, NS;
    wire data;  // Assume data is driven by some external source
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
                   if (TX_start)
                     NS = START;
						 else
						   NS = IDLE;
            end
            
            START: begin
                NS = DATA;
            end
            
            DATA: begin
                if (data) begin
                    NS = PARITY;
                end else begin
					     NS = DATA;
                end 
            end
            
            PARITY: begin
                      NS = STOP;  
						 end
            
            STOP: begin
                   if  (TX_start)
						   NS = START;
						 else
                     NS = IDLE;
            end
            
            default: NS = IDLE;
        endcase
    end
	 
	 always @(*) begin
	   case (PS)
		  IDLE : begin
		           load = 1'b0;
					  TX_busy = 1'b0;
					  SEL = 2'b11;
				     Shift = 1'b0;
					  count_en = 1'b0; 
				end
				
		 START :  begin
		           load = 1'b1;
					  TX_busy = 1'b1;
					  SEL = 2'b00;
				     Shift = 1'b0;
					  count_en = 1'b0; 
				end
				
		 DATA : begin
		           load = 1'b1;
					  TX_busy = 1'b1;
					  SEL = 2'b01;
				     Shift = 1'b1;
					  count_en = 1'b1; 
				end
				
		PARITY : begin
		           load = 1'b0;
					  TX_busy = 1'b11;
					  SEL = 2'b10;
				     Shift = 1'b0;
					  count_en = 1'b0; 
				end
				
		STOP :  begin
		           load = 1'b0;
					  TX_busy = 1'b1;
					  SEL = 2'b11;
				     Shift = 1'b0;
					  count_en = 1'b0; 
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


			
					 
					  
					  
					 
	