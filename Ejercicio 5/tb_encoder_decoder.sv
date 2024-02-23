`timescale 1ns/1ps

module tb__encoder_decoder();

reg [3:0] binary_input;
wire [3:0] binary_output;

encoder_decoder dut(.binary_input(binary_input), .binary_output(binary_output)); 

initial begin

binary_input = 4'b0000; #10;
binary_input = 4'b0001; #10;
binary_input = 4'b0010; #10;
binary_input = 4'b0011; #10;
binary_input = 4'b0100; #10;
binary_input = 4'b0101; #10;
binary_input = 4'b0110; #10;
binary_input = 4'b0111; #10;
binary_input = 4'b1000; #10;
binary_input = 4'b1001; #10;
binary_input = 4'b1010; #10;
binary_input = 4'b1011; #10;
binary_input = 4'b1100; #10;
binary_input = 4'b1101; #10;
binary_input = 4'b1110; #10;
binary_input = 4'b1111; #10;

$finish;

end

endmodule
