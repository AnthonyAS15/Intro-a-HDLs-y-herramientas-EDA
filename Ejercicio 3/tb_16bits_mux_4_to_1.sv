`timescale 1ns/1ps

module tb();

reg [15:0] d0, d1, d2, d3;
reg [1:0] s;
wire [15:0] y;

mux_4_to_1 #(16) dut(d0, d1, d2, d3, s, y);

initial begin

for (int i = 0; i < 50; i++) begin

s = $urandom_range(3, 0);
d0 = $urandom_range(65535, 0);
d1 = $urandom_range(65535, 0);
d2 = $urandom_range(65535, 0);
d3 = $urandom_range(65535, 0);

#10;

end 
$finish;

end

endmodule
