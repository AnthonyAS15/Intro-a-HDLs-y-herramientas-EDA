// decodificador para display de 7 segmentos

`timescale 1ns/1ps

module seven_segment_display_deco(input logic [3:0] d, output logic s_a, s_b, s_c, s_d, s_e, s_f, s_g);

assign s_a = (d[3]|d[2]|d[1]|!d[0])&(d[3]|!d[2]|d[1]|d[0]);
assign s_b = (d[3]|!d[2]|d[1]|!d[0])&(d[3]|!d[2]|!d[1]|d[0])&(!d[3]|!d[2]|d[1]|d[0])&(!d[3]|!d[2]|!d[1]|d[0])&(!d[3]|!d[2]|!d[1]|!d[0]);
assign s_c = (d[3]|d[2]|!d[1]|d[0])&(!d[3]|!d[2]|d[1]|d[0])&(!d[3]|!d[2]|!d[1]|d[0])&(!d[3]|!d[2]|!d[1]|!d[0]);
assign s_d = (d[3]|d[2]|d[1]|!d[0])&(d[3]|!d[2]|d[1]|d[0])&(d[3]|!d[2]|!d[1]|!d[0])&(!d[3]|d[2]|d[1]|!d[0])&(!d[3]|d[2]|!d[1]|d[0])&(!d[3]|!d[2]|!d[1]|!d[0]);										
assign s_e = (d[3]|d[2]|d[1]|!d[0])&(d[3]|d[2]|!d[1]|!d[0])&(d[3]|!d[2]|d[1]|d[0])&(d[3]|!d[2]|d[1]|!d[0])&(d[3]|!d[2]|!d[1]|!d[0])&(!d[3]|d[2]|d[1]|!d[0]);
assign s_f = (d[3]|d[2]|d[1]|!d[0])&(d[3]|d[2]|!d[1]|d[0])&(d[3]|d[2]|!d[1]|!d[0])&(d[3]|!d[2]|!d[1]|!d[0]);								
assign s_g = (d[3]|d[2]|d[1]|d[0])&(d[3]|d[2]|d[1]|!d[0])&(d[3]|!d[2]|!d[1]|!d[0])&(!d[3]|!d[2]|d[1]|d[0])&(!d[3]|!d[2]|d[1]|!d[0]);

endmodule