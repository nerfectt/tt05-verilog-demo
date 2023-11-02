`default_nettype none

module EventFilter (
    input wire [1:0] x, // Assuming that x, y, & t are 16-bits
    input wire [1:0] y,
    input wire [1:0] t,
    input wire [1:0] p, // Polarity is 1 bit (1 or 0 (or otherwise))
    input wire rst_n,
    input wire clk, // Clock input

    output reg [1:0] x_out,
    output reg [1:0] y_out,
    output reg [1:0] t_out,
    output reg [1:0] p_out // is there a way to bitmask
);

reg [7:0] out;

    always @(*) begin
        if (p == 2'b01) begin
            out = {x, y, p, t};
        end else begin
            out = 8'b0;
        end
    end

    always @(posedge clk) begin
        if(!rst_n) begin
            x_out <= 2'b0;
            y_out <= 2'b0;
            p_out <= 2'b0;
            t_out <= 2'b0;
        end else begin
            x_out <= out[7:6]; // non-blocking
            y_out <= out[5:4];
            p_out <= out[3:2];
            t_out <= out[1:0];
    end
    end


endmodule

