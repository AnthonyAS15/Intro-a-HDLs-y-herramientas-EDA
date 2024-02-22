// decodificador que convierte código Gray de 4 bits a binario

`timescale 1ns/1ps

module gray_decoder(input logic [3:0] gray_code, output logic [3:0] binary_num);

assign binary_num[3] = gray_code[3];
assign binary_num[2] = binary_num[3] ^ gray_code[2];
assign binary_num[1] = binary_num[2] ^ gray_code[1];
assign binary_num[0] = binary_num[1] ^ gray_code[0];

endmodule
