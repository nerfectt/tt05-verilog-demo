`default_nettype none

module tt_um_EventFilter ( 
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // use bidirectionals as outputs
    assign uio_oe = 8'b11111111;
    assign uio_out = 8'b11111111;

    // instantiate 
    EventFilter Filter1(.clk(clk),.rst_n(rst_n),.x(ui_in[7:6]), .y(ui_in[5:4]), .p(ui_in[3:2]), .t(ui_in[1:0]), .x_out(uo_out[7:6]), .y_out(uo_out[5:4]), .p_out(uo_out[3:2]), .t_out(uo_out[1:0]));

endmodule
