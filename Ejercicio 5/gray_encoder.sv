// codificador que convierte números binarios de 4 bits a código gray

`timescale 1ns/1ps

module gray_encoder(input logic [3:0] binary_num, output logic [3:0] gray_code);

assign gray_code[3] = binary_num[3];
assign gray_code[2] = binary_num[3] ^ binary_num[2];
assign gray_code[1] = binary_num[2] ^ binary_num[1];
assign gray_code[0] = binary_num[1] ^ binary_num[0];

endmodule
