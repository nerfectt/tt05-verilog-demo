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

parameter [1:0]  
        IDLE = 2'b01,
        EVENT = 2'b10
;

reg[1:0] state = IDLE;
reg[1:0] p_prev = 2'b0;
reg[2:0] counter = 3'b0;


always @(posedge clk) begin
    if(!rst_n) begin
        state <= IDLE;
        counter <= 3'b0;
        p_prev <= 2'b0
        x_out <= 2'b0;
        y_out <= 2'b0;
        p_out <= 2'b0;
        t_out <= 2'b0;
    end

    case (state)
    IDLE begin
        p_prev <= 2'b0;
        counter <= 3'b0;
        p_prev <= p;
        state <= EVENT;
    end
    

    EVENT begin
        if (counter < 5) begin
            if (p_prev != p) begin
                state <= IDLE;
            end else begin 
                counter <= counter + 1;
            end
        end else begin
            p_prev <= 0;
            {x_out, y_out, p_out, t_out} ={x, y, p, t};
            state <= IDLE;
            counter <= 0;
        end
    end
    
endcase
end

    // always @(*) begin
    //     if (p == 2'b01) begin
    //         out = {x, y, p, t};
    //     end else begin
    //         out = 8'b0;
    //     end
    // end

    // always @(posedge clk) begin
    //     if(!rst_n) begin
    //         x_out <= 2'b0;
    //         y_out <= 2'b0;
    //         p_out <= 2'b0;
    //         t_out <= 2'b0;
    //     end else begin
    //         x_out <= out[7:6]; // non-blocking
    //         y_out <= out[5:4];
    //         p_out <= out[3:2];
    //         t_out <= out[1:0];
    // end
    // end


endmodule

