`default_nettype none

module EventDenoiser(
    input wire clk,
    input wire reset,
    input wire noisy_event,
    output wire filtered_event
);

reg last_noisy_event;
reg filtered_event;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        last_noisy_event <= 1'b0;
        filtered_event <= 1'b0;
    end else begin
        last_noisy_event <= noisy_event;
        filtered_event <= noisy_event & ~last_noisy_event;
    end
end


endmodule
