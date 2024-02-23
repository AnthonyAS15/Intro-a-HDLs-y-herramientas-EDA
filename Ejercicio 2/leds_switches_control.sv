// activación por grupos de leds a través de switches gobernados por un push button

module sw_led(input logic sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, sw11, sw12, sw13, sw14, sw15,
output logic led0, led1, led2, led3, led4, led5, led6, led7, led8, led9, led10, led11, led12, led13, led14, led15);

logic push_button1, push_button2, push_button3, push_button4;

assign led0 = (push_button1) ? 0 : sw0;
assign led1 = (push_button1) ? 0 : sw1;
assign led2 = (push_button1) ? 0 : sw2;
assign led3 = (push_button1) ? 0 : sw3;

assign led4 = (push_button2) ? 0 : sw4;
assign led5 = (push_button2) ? 0 : sw5;
assign led6 = (push_button2) ? 0 : sw6;
assign led7 = (push_button2) ? 0 : sw7;

assign led8 = (push_button3) ? 0 : sw8;
assign led9 = (push_button3) ? 0 : sw9;
assign led10 = (push_button3) ? 0 : sw10;
assign led11 = (push_button3) ? 0 : sw11;

assign led12 = (push_button4) ? 0 : sw12;
assign led13 = (push_button4) ? 0 : sw13;
assign led14 = (push_button4) ? 0 : sw14;
assign led15 = (push_button4) ? 0 : sw15;

endmodule