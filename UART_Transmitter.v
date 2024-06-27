module UART_Transmitter(TX_data,TX_start,CLK,RST,Start,Stop,TX_busy,TX_out);
 input [7:0] TX_data;
 input Start,Stop,TX_start;
 input RST,CLK;
 output TX_out;
 output TX_busy;
 
 wire OUT_to_Data,load_to_LOAD;
 wire parity_out_to_Parity;
 wire [1:0] SEL_to_sel;
 
 PISO U1(.TX_data(TX_data),
         .LOAD(load_to_LOAD),
			.CLK(CLK),
			.RST(RST),
			.shift(Shift),
			.OUT(OUT_to_Data)
);

 even_parity U2(.TX_data(TX_data),
                .LOAD(load_to_LOAD),
					 .parity_out(parity_out_to_Parity)
);

 TX_mux U3(.Start(Start),
           .Data(OUT_to_Data),
			  .Parity(parity_out_to_Parity),
			  .Stop(Stop),
			  .sel(SEL_to_sel),
			  .TX_out(TX_out)
);

 TX_FSM U4(.TX_start(TX_start),
           .CLK(CLK),
			  .Shift(Shift),
			  .load(load_to_LOAD),
			  .SEL(SEL_to_sel),
			  .TX_busy(TX_busy)
);
endmodule