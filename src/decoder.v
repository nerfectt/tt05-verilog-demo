'default_nettype none
module EventFilter (
    input wire [15:0] x, // Assuming that x, y, and t are 16-bits
    input wire [15:0] y,
    input wire [15:0] t,
    input wire p,        // Polarity is a 1 bit (1 or 0 (or otherwise))
    output reg [15:0] x_out,
    output reg [15:0] y_out,
    output reg [15:0] t_out,
    output reg p_out
);

always @* begin
    if (p == 1'b1) begin
        x_out = x;
        y_out = y;
        t_out = t;
        p_out = p;
    end else begin
        // If the polarity is not +1, you might want to output some default or null values
        x_out = 32'b0;
        y_out = 32'b0;
        t_out = 32'b0;
        p_out = 1'b0;
    end
end
endmodule

