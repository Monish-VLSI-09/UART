module UART_Receiver(RX_in,CLK,RST,stop_error,parity_error,RX_out);
  input RX_in,CLK,RST;
  output parity_error,stop_error;
  output [7:0] RX_out;
  
  wire FSM_to_parity_load,start_to_FSM,OUT_to_parity,FSM_to_stop,FSM_shift,parity_to_stop;
  
  SIPO U5(.RX_in(RX_in),
          .CLK(CLK),  
			 .RST(RST),
			 .shift(FSM_shift),
			 .OUT(OUT_to_parity)
  );
  parity_checker U6(.data_in(OUT_to_parity),
                    .parity_load(FSM_to_parity_load),
						  .parity_error(parity_error),
						  .data_out(parity_to_stop)
  );
  detect_start U7(.RX_in(RX_in),
                  .start_bit(start_to_FSM)
	);
  stop_checker(.data_in(parity_to_stop),
               .check_stop(FSM_to_stop),
					.stop_error(stop_error),
					.RX_out(RX_out)
  );
  RX_FSM(.start_bit(start_to_FSM),
         .parity_error(parity_error),
			.CLK(CLK),
			.RST(RST),
			.shift(FSM_shift),
			.parity_load(FSM_to_parity_load),
			.check_stop(FSM_to_stop)
  );
  
endmodule