`default_nettype none

module EventFilter (
    input wire [1:0] x, // Assuming that x, y, & t are 16-bits
    input wire [1:0] y,
    input wire [1:0] t,
    input wire [1:0] p,        // Polarity is 1 bit (1 or 0 (or otherwise))
    input wire rst_n,
    input wire clk, // Clock input

    output reg [1:0] x_out,
    output reg [1:0] y_out,
    output reg [1:0] t_out,
    output reg [1:0] p_out // is there a way to bitmask
);

wire [7:0] out;

    always @(*) begin
        if(!rst_n) begin
        if (p == 1'b1) begin
            out = {x, y, t};
            end
        end else begin
            out = 8'b0;
        end
    end

    always @(posedge clk) begin
        x_out <= out[6:5]; // non-blocking
        y_out <= out[4:3];
        p_out <= p[2:1];
        t_out <= out[1:0];
    end


endmodule

