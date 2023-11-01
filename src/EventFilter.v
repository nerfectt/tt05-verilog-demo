`default_nettype none

module EventFilter (
    input wire [7:0] x, // Assuming that x, y, & t are 16-bits
    input wire [7:0] y,
    input wire [7:0] t,
    input wire p,        // Polarity is 1 bit (1 or 0 (or otherwise))
    input wire rst_n,
    input wire clk, // Clock input

    output reg [7:0] x_out,
    output reg [7:0] y_out,
    output reg [7:0] t_out,
    output reg p_out
);

wire [23:0] out;


    always @(*) begin
        if(!rst_n) begin
        if (p == 1'b1) begin
            out = {x, y, t};
            end
        end else begin
            out = 23'b0;
        end
    end

    always @(posedge clk) begin
        x_out <= out[24:16]; // non-blocking
        y_out <= out[15:8];
        t_out <= out[7:0];
        p_out <= p;
    end


endmodule

