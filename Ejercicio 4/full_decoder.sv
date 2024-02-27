`timescale 1ns / 1ps

module full_decoder(input logic sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, 
sw11, sw12, sw13, sw14, sw15, push_button0, push_button1, output logic s_a, s_b, s_c, 
s_d, s_e, s_f, s_g, anode, dp);

wire [3:0] d0, d1, d2, d3;
wire [3:0] d;

switch_encoder sw_encoder(.sw0(sw0), .sw1(sw1), .sw2(sw2), .sw3(sw3), .sw4(sw4), .sw5(sw5), .sw6(sw6), .sw7(sw7), .sw8(sw8), 
.sw9(sw9), .sw10(sw10), .sw11(sw11), .sw12(sw12), .sw13(sw13), .sw14(sw14), .sw15(sw15), .d0(d0), .d1(d1), .d2(d2), .d3(d3));

mux_4_to_1 mux(.d0(d0), .d1(d1), .d2(d2), .d3(d3), .s({push_button1, push_button0}), .y(d));

seven_segment_display_deco deco(.d(d), .s_a(s_a), .s_b(s_b), .s_c(s_c), .s_d(s_d), .s_e(s_e), .s_f(s_f), .s_g(s_g));

assign anode = 8'b11111110; //Habilitar primer display a la derecha
assign dp = 1; //Desabilitar el punto decimal

endmodule