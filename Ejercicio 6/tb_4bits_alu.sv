//testbench para la alu

`timescale 1ns/1ps

module tb_4bits_alu ();
    reg [3:0] ALUA, ALUB;
    reg ALUFlagIn;
    reg [3:0] ALUControl;
    wire [3:0] ALUResult;
    ALUFlagsStruct ALUFlags;

    alu dut(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUControl(ALUControl),.ALUResult(ALUResult),.ALUFlags(ALUFlags));

    initial
    begin
        //AND
        ALUA = 4'b1010;
        ALUB = 4'b0101;
        ALUControl = 4'h0;
        #10;
        //OR
        ALUA = 4'b1010;
        ALUB = 4'b1001;
        ALUControl = 4'h1;
        #10;
        //Suma
        ALUA = 4'b0001;
        ALUB = 4'b0010;
        ALUFlagIn = 1'b0;
        ALUControl = 4'h2;
        #10;
        //Incrementar en uno
        ALUA = 4'b1001;
        ALUB = 4'b1010;
        ALUFlagIn = 1'b0;
        ALUControl = 4'h3;
        #10;
        //Decrementar en uno
        ALUA = 4'b1001;
        ALUB = 4'b1111;
        ALUFlagIn = 1'b1;
        ALUControl = 4'h4;
        #10;
        //NOT
        ALUA = 4'b1001;
        ALUB = 4'b1111;
        ALUFlagIn = 1'b1;
        ALUControl = 4'h5;
        #10;
        //Resta
        ALUA = 4'b0010;
        ALUB = 4'b1000;
        ALUFlagIn = 1'b0;
        ALUControl = 4'h6;
        #10;
        //XOR
        ALUA = 4'b1011;
        ALUB = 4'b1101;
        ALUFlagIn = 1'b0;
        ALUControl = 4'h7;
        #10;
        //Corrimiento hacia la izquierda
        ALUA = 4'b1010;
        ALUB = 4'b0010;
        ALUFlagIn = 1'b1;
        ALUControl = 4'h8;
        #10;
        //Corrimiento hacia la derecha
        ALUA = 4'b1011;
        ALUB = 4'b0010;
        ALUFlagIn = 1'b0;
        ALUControl = 4'h9;
        #10;
    #10;
    $finish;
    end
    

endmodule