`timescale 1ns/1ps

module encoder_decoder(input [3:0] binary_input, output [3:0] binary_output);

wire [3:0] encoder_output_decoder_input;

gray_encoder encoder1(.binary_num(binary_input), .gray_code(encoder_output_decoder_input));
gray_decoder decoder1(.gray_code(encoder_output_decoder_input), .binary_num(binary_output));

endmodule