module detect_start(RX_in,start_bit);
  input RX_in;
  output start_bit;
   
  assign start_bit = !RX_in;
endmodule
		