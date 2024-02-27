//alu parametrizable de n bits. Recibirá dos entradas de n bits un bus de ALUControl y una bandera de entrada

`timescale 1ns/1ps

typedef struct {logic C; logic Z;} ALUFlagsStruct; //Estructura para almacenar las banderas de salida.

module alu #(
    n = 4
) (
    input logic [n-1:0] ALUA, ALUB,
    input logic ALUFlagIn,
    input logic [3:0] ALUControl,
    output logic [n-1:0] ALUResult,
    output ALUFlagsStruct ALUFlags
);
    //Resultados de cada una de las operaciones
    logic [n-1:0] Result0, Result1, Result2, Result3, Result4, Result5, Result6, Result7, Result8, Result9;
    //Banderas de salida de cada una de las operaciones
    ALUFlagsStruct ALUFlags0, ALUFlags1, ALUFlags2, ALUFlags3, ALUFlags4, ALUFlags5, ALUFlags6, ALUFlags7, ALUFlags8, ALUFlags9;
    //Señal de control para el multiplexor que tiene como salida a ALUFlags.C
    logic [1:0] c_signal;
    
    //Módulos de las operaciones
    Mand #(n) AND(.ALUA(ALUA),.ALUB(ALUB),.ALUResult(Result0),.ALUFlags(ALUFlags0)); //Operación lógica AND
    Mor #(n) OR(.ALUA(ALUA),.ALUB(ALUB),.ALUResult(Result1),.ALUFlags(ALUFlags1)); //Operación lógica OR
    Madd #(n) ADD(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(Result2),.ALUFlags(ALUFlags2)); //Suma
    Minc #(n) INC(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(Result3),.ALUFlags(ALUFlags3)); //Incrementar en uno
    Mdec #(n) DEC(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(Result4),.ALUFlags(ALUFlags4)); //Decrementar en uno
    Mnot #(n) NOT(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(Result5),.ALUFlags(ALUFlags5)); //Operación lógica NOT
    Msub #(n) SUB(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(Result6),.ALUFlags(ALUFlags6)); //Resta
    Mxor #(n) XOR (.ALUA(ALUA),.ALUB(ALUB),.ALUResult(Result7),.ALUFlags(ALUFlags7)); //Operación lógica XOR
    Msl #(n) SL(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(Result8),.ALUFlags(ALUFlags8)); //Desplazamiento hacia la izquierda
    Msr #(n) SR(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(Result9),.ALUFlags(ALUFlags9)); //Desplazamiento hacia la derecha
    
    //Multiplexor para obtener ALUResult
    mux_10_to_1 #(n) MUXR(.I0(Result0),.I1(Result1),.I2(Result2),.I3(Result3),.I4(Result4),.I5(Result5),.I6(Result6),.I7(Result7),.I8(Result8),.I9(Result9),.Control(ALUControl),.Result(ALUResult));
    
    //Multiplexor para obtener ALUFlags.Z
    mux_10_to_1 #(n) MUXZ(.I0(ALUFlags0.Z),.I1(ALUFlags1.Z),.I2(ALUFlags2.Z),.I3(ALUFlags3.Z),.I4(ALUFlags4.Z),.I5(ALUFlags5.Z),.I6(ALUFlags6.Z),.I7(ALUFlags7.Z),.I8(ALUFlags8.Z),.I9(ALUFlags9.Z),.Control(ALUControl),.Result(ALUFlags.Z));
    
    //Determinar la señal de control para el multiplexor que tiene como salida a ALUFlags.C
    always_comb
    begin
        case(ALUControl)
            4'h2: //Para la suma
                c_signal = 2'b00;
            4'h6: //Para la resta
                c_signal = 2'b01;
            4'h8: //Para el corrimiento hacia la izquierda
                c_signal = 2'b10;
            4'h9: //Para el corrimiento hacia la derecha
                c_signal = 2'b11;
        endcase
    end
    
    //Multiplexor para obtener ALUFlags.C
    mux_4_to_1 #(n) MUXC(.d0(ALUFlags2.C),.d1(ALUFlags6.C),.d2(ALUFlags8.C),.d3(ALUFlags9.C),.s(c_signal),.y(ALUFlags.C));
    
endmodule

module Mand #( //Módulo para hacer AND entre dos entradas
    n = 4
) (
    input logic [n-1:0] ALUA, ALUB,
    output logic [n-1:0] ALUResult,
    output ALUFlagsStruct ALUFlags
);
    assign ALUResult = ALUA & ALUB;
    
    always_comb
    begin
        if (ALUResult == 0)
        begin
            ALUFlags.Z = 1'b1;
        end
        else
        begin
            ALUFlags.Z = 1'b0;
        end
    end

endmodule

module Mor #( //Módulo para hacer OR entre dos entradas
    n = 4
) (
    input logic [n-1:0] ALUA, ALUB,
    output logic [n-1:0] ALUResult,
    output ALUFlagsStruct ALUFlags
);
    assign ALUResult = ALUA | ALUB;

    always_comb
    begin
        if (ALUResult == 0)
        begin
            ALUFlags.Z = 1'b1;
        end
        else
        begin
            ALUFlags.Z = 1'b0;
        end
    end

endmodule

module Madd #( //Módulo para sumar dos entradas y un acarreo
    n = 4
) (
    input logic [n-1:0] ALUA, ALUB,
    input logic ALUFlagIn,
    output logic [n-1:0]  ALUResult, 
    output ALUFlagsStruct ALUFlags
);  
    logic [n:0] sum = ALUA + ALUB + ALUFlagIn;
    assign ALUFlags.C = sum[n];
    assign ALUResult = sum[n-1:0];

    always_comb
    begin
        if (ALUResult == 0)
        begin
            ALUFlags.Z = 1'b1;
        end
        else
        begin
            ALUFlags.Z = 1'b0;
        end
    end

endmodule

module Minc #( //Módulo para incrementar en uno 
n = 4) (
    input logic [n-1:0] ALUA, ALUB,
    input logic ALUFlagIn,
    output logic [n-1:0] ALUResult,
    output ALUFlagsStruct ALUFlags
);
    always_comb
    begin
        if (!ALUFlagIn)
        begin
            ALUResult = ALUA + 1;
        end
        else
        begin
            ALUResult = ALUB + 1;
        end

    end

    always_comb
    begin
        if (ALUResult == 0)
        begin
            ALUFlags.Z = 1'b1;
        end
        else
        begin
            ALUFlags.Z = 1'b0;
        end
    end

endmodule

module Mdec #( //Módulo para decrementar en uno 
    n = 4
) (
    input logic [n-1:0] ALUA, ALUB,
    input logic ALUFlagIn,
    output logic [n-1:0] ALUResult,
    output ALUFlagsStruct ALUFlags
);
    always_comb
    begin
        if (!ALUFlagIn)
        begin
            ALUResult = ALUA - 1;
        end
        else
        begin
            ALUResult = ALUB - 1;
        end
    end

    always_comb
    begin
        if (ALUResult == 0)
        begin
            ALUFlags.Z = 1'b1;
        end
        else
        begin
            ALUFlags.Z = 1'b0;
        end
    end

endmodule

module Mnot #( //Módulo para hacer NOT a una entrada 
    n = 4
) (
    input logic [n-1:0] ALUA, ALUB,
    input logic ALUFlagIn,
    output logic [n-1:0] ALUResult,
    output ALUFlagsStruct ALUFlags
);
    always_comb
    begin
        if (!ALUFlagIn)
        begin
            ALUResult = ~ALUA;
        end
        else
        begin
            ALUResult = ~ALUB;
        end
    end

    always_comb
    begin
        if (ALUResult == 0)
        begin
            ALUFlags.Z = 1'b1;
        end
        else
        begin
            ALUFlags.Z = 1'b0;
        end
    end
endmodule

module Msub #( //Módulo para restar dos entradas y un acarreo 
    n = 4
) (
    input logic [n-1:0] ALUA, ALUB,
    input logic ALUFlagIn,
    output logic [n-1:0] ALUResult,
    output ALUFlagsStruct ALUFlags
);
    logic [n:0] sum = ALUA - ALUB + ALUFlagIn;
    assign ALUFlags.C = sum[n];
    assign ALUResult = sum[n-1:0];

    always_comb
    begin
        if (ALUResult == 0)
        begin
            ALUFlags.Z = 1'b1;
        end
        else
        begin
            ALUFlags.Z = 1'b0;
        end
    end
endmodule

module Mxor #( //Módulo para hacer XOR entre dos entradas
    n = 4
) (
    input logic [n-1:0] ALUA, ALUB,
    output logic [n-1:0] ALUResult,
    output ALUFlagsStruct ALUFlags
);
    assign ALUResult = ALUA ^ ALUB;

    always_comb
    begin
        if (ALUResult == 0)
        begin
            ALUFlags.Z = 1'b1;
        end
        else
        begin
            ALUFlags.Z = 1'b0;
        end
    end
endmodule

module Msl #( //Módulo para hacer un desplazamiento hacia la izquierda
    n = 4
) (
    input logic [n-1:0] ALUA, ALUB,
    input logic ALUFlagIn,
    output logic [n-1:0] ALUResult,
    output ALUFlagsStruct ALUFlags
);  
    logic [n-1:0] counter = 0;
    assign ALUResult = ALUA;
    
    always_comb
    begin
        if(!(counter == ALUB))
        begin
            ALUFlags.Cout  = ALUA[n-1];
            ALUResult = {ALUResult[n-2:0],ALUFlagIn};
            counter = counter + 1;
        end
        else
        begin
            counter = 0;
        end
    end
    
    always_comb
    begin
        if (ALUResult == 0)
        begin
           ALUFlags.Z = 1'b1;
        end
        else
        begin
            ALUFlags.Z = 1'b0;
        end
    end
endmodule

module Msr #( //Módulo para hacer un desplazamiento hacia la derecha
    n = 4
) (
    input logic [n-1:0] ALUA, ALUB,
    input logic ALUFlagIn,
    output logic [n-1:0] ALUResult,
    output ALUFlagsStruct ALUFlags
);
    logic [n-1:0] counter = 0;
    assign ALUResult = ALUA;
    
    always_comb
    begin
        if(!(counter == ALUB))
        begin
            ALUFlags.Cout = ALUA[0];
            ALUResult = {ALUFlagIn,ALUResult[n-1:1]};
            counter = counter + 1;
        end
        else
        begin
            
            counter = 0;
        end
    end
    
    always_comb
    begin
        if (ALUResult == 0)
        begin
            ALUFlags.Z = 1'b1;
        end
        else
        begin
            ALUFlags.Z = 1'b0;
        end
    end
endmodule