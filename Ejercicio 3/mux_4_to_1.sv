// mux 4:1 parametrizado para un ancho de datos "n" de entrada y salida variable

`timescale 1ns/1ps

module mux_4_to_1#(parameter n = 4)(input logic [n-1:0] d0, d1, d2, d3, input logic [1:0] s, output logic [n-1:0] y);

assign y = s[1] ? ( s[0] ? (d3) : (d2) ) : ( s[0] ? (d1) : (d0) );

endmodule