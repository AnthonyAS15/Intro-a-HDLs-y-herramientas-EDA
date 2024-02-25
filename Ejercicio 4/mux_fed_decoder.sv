// decodificador para display de 7 segmentos con entrada controlada por un mux4:1

`timescale 1ns / 1ps

module seven_segment_display_decoder_mux_controled(input logic sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, 
sw11, sw12, sw13, sw14, sw15, push_button1, push_button2, output logic s_a, s_b, s_c, s_d, s_e, s_f, s_g, output logic [7:0] anode, output logic dp);

logic [3:0] d0 = {sw0, sw1, sw2, sw3};
logic [3:0] d1 = {sw4, sw5, sw6, sw7};
logic [3:0] d2 = {sw8, sw9, sw10, sw11};
logic [3:0] d3 = {sw12, sw13, sw14, sw15};

logic [1:0] s = {push_button1, push_button2};

logic [3:0] d = s[1] ? ( s[0] ? (d3) : (d2) ) : ( s[0] ? (d1) : (d0) );

assign s_a = (d[3]|d[2]|d[1]|!d[0])&(d[3]|!d[2]|d[1]|d[0]);
assign s_b = (d[3]|!d[2]|d[1]|!d[0])&(d[3]|!d[2]|!d[1]|d[0])&(!d[3]|!d[2]|d[1]|d[0])&(!d[3]|!d[2]|!d[1]|d[0])&(!d[3]|!d[2]|!d[1]|!d[0]);
assign s_c = (d[3]|d[2]|!d[1]|d[0])&(!d[3]|!d[2]|d[1]|d[0])&(!d[3]|!d[2]|!d[1]|d[0])&(!d[3]|!d[2]|!d[1]|!d[0]);
assign s_d = (d[3]|d[2]|d[1]|!d[0])&(d[3]|!d[2]|d[1]|d[0])&(d[3]|!d[2]|!d[1]|!d[0])&(!d[3]|d[2]|d[1]|!d[0])&(!d[3]|d[2]|!d[1]|d[0])&(!d[3]|!d[2]|!d[1]|!d[0]);										
assign s_e = (d[3]|d[2]|d[1]|!d[0])&(d[3]|d[2]|!d[1]|!d[0])&(d[3]|!d[2]|d[1]|d[0])&(d[3]|!d[2]|d[1]|!d[0])&(d[3]|!d[2]|!d[1]|!d[0])&(!d[3]|d[2]|d[1]|!d[0]);
assign s_f = (d[3]|d[2]|d[1]|!d[0])&(d[3]|d[2]|!d[1]|d[0])&(d[3]|d[2]|!d[1]|!d[0])&(d[3]|!d[2]|!d[1]|!d[0]);								
assign s_g = (d[3]|d[2]|d[1]|d[0])&(d[3]|d[2]|d[1]|!d[0])&(d[3]|!d[2]|!d[1]|!d[0])&(!d[3]|!d[2]|d[1]|d[0])&(!d[3]|!d[2]|d[1]|!d[0]);

assign anode = 8'b11111110; //Habilitar primer display a la derecha
assign dp = 1; //Desabilitar el punto decimal

endmodule
