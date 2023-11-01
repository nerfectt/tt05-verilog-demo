'default_nettype none
module EventFilter (
    input wire [15:0] x, // Assuming that x, y, & t are 16-bits
    input wire [15:0] y,
    input wire [15:0] t,
    input wire p,        // Polarity is a 1 bit (1 or 0 (or otherwise))

    output reg [15:0] x_out,
    output reg [15:0] y_out,
    output reg [15:0] t_out,
    output reg p_out
);

always @* begin // Comb logic
    if (p == 1'b1) begin // If event is high, just output the tuplr
        x_out = x;
        y_out = y;
        p_out = p;
        t_out = t;
    end else begin
        // If the polarity is not +1, event is low -- is it better to output 0 or like X or Z?
        x_out = 16'b0; // can it be 16'bz as a dont care output
        y_out = 16'b0;
        p_out = 1'b0;
        t_out = 16'b0;
    end
end
endmodule

