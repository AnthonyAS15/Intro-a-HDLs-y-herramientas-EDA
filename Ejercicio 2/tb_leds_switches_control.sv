`timescale 1ns/1ps

module tb_constraint1();

reg sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, sw11, sw12, sw13, sw14, sw15, push_button1, push_button2, push_button3, push_button4;
wire led0, led1, led2, led3, led4, led5, led6, led7, led8, led9, led10, led11, led12, led13, led14, led15;

sw_led dut(sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10,
 sw11, sw12, sw13, sw14, sw15, push_button1, push_button2, push_button3, push_button4, 
 led0, led1, led2, led3, led4, led5, led6, led7, led8, led9, led10, led11, 
 led12, led13, led14, led15);

initial begin

for (int i = 0; i < 10; i++) begin

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
push_button1 = $urandom();
push_button2 = $urandom();
push_button3 = $urandom();
push_button4 = $urandom();

#10;

end 
$finish;

end

endmodule