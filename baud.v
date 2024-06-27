module Baud_Rate_Generator (
    input wire CLK,      // System clock input
    input wire RST,      // Reset input
    output reg baud_clk  // Baud rate clock output
);

    // Assuming system clock of 50 MHz and desired baud rate of 9600
    reg [31:0] counter;
    reg [31:0] DIVISOR;

    initial begin
        DIVISOR = 50000000 / (16 * 9600);  // Assuming 16x oversampling
    end

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            counter <= 32'd0;
            baud_clk <= 1'b0;
        end else begin
            if (counter >= (DIVISOR - 1)) begin
                counter <= 32'd0;
                baud_clk <= ~baud_clk;  // Toggle the baud clock
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule
