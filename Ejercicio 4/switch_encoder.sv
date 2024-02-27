`timescale 1ns / 1ps

module switch_encoder(input logic sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, 
sw11, sw12, sw13, sw14, sw15, output logic [3:0] d0, d1, d2, d3);

assign d0 = {sw3, sw2, sw1, sw0};
assign d1 = {sw7, sw6, sw5, sw4};
assign d2 = {sw11, sw10, sw9, sw8};
assign d3 = {sw15, sw14, sw13, sw12};

endmodule