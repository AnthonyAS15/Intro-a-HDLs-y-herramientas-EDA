`timescale 1ns/1ps

module tb_full_decoder();

reg sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, sw11, sw12, sw13, sw14, sw15, push_button0, push_button1;
wire s_a, s_b, s_c, 
s_d, s_e, s_f, s_g;

full_decoder dut(sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, 
sw11, sw12, sw13, sw14, sw15, push_button0, push_button1, s_a, s_b, s_c, 
s_d, s_e, s_f, s_g, anode, dp);

initial begin

for (int i = 0; i < 50; i++) begin

sw0 = $urandom();
sw1 = $urandom();
sw2 = $urandom();
sw3 = $urandom();
sw4 = $urandom();
sw5 = $urandom();
sw6 = $urandom();
sw7 = $urandom();
sw8 = $urandom();
sw9 = $urandom();
sw10 = $urandom();
sw11 = $urandom();
sw12 = $urandom();
sw13 = $urandom();
sw14 = $urandom();
sw15 = $urandom();
push_button0 = $urandom();
push_button1 = $urandom();

#10;

end 
$finish;

end

endmodule
