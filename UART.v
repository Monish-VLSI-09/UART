module UART(TX_data,TX_start,CLK,RST,Start,Stop,parity_error,TX_busy,stop_error,baud_clk,RX_out);
  input [7:0] TX_data;
  input Start,Stop,TX_start,RST,CLK;
  output [7:0] RX_out;
  output parity_error,stop_error,TX_busy,baud_clk;
  wire TXtoRX;
 
 UART_Transmitter UART1(.TX_data(TX_data),
                        .TX_start(TX_start),
								.CLK(baud_clk),
								.RST(RST),
								.Start(Start),
								.Stop(Stop),
								.TX_busy(TX_busy),
								.TX_out(TXtoRX)
 );
 
 UART_Receiver UART2(.RX_in(TXtoRX),
                     .CLK(baud_clk),
							.RST(RST),
							.parity_error(parity_error),
							.stop_error(stop_error),
							.RX_out(RX_out)
							
 );
 
 Baud_Rate_Generator UART3(.CLK(CLK),
                           .RST(RST),
									.baud_clk(baud_clk)
 );
endmodule