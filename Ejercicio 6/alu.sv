//alu parametrizable de n bits. Recibirá dos entradas de n bits y un bus de ALUControl

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
    
    Mand #(n) AND(.ALUA(ALUA),.ALUB(ALUB),.ALUResult(ALUResult),.ALUFlags(ALUFlags)); //Operación lógica AND
    Mor #(n) OR(.ALUA(ALUA),.ALUB(ALUB),.ALUResult(ALUResult),.ALUFlags(ALUFlags)); //Operación lógica OR
    Madd #(n) ADD(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(ALUResult),.ALUFlags(ALUFlags)); //Suma
    Minc #(n) INC(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(ALUResult),.ALUFlags(ALUFlags)); //Incrementar en uno
    Mdec #(n) DEC(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(ALUResult),.ALUFlags(ALUFlags)); //Decrementar en uno
    Mnot #(n) NOT(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(ALUResult),.ALUFlags(ALUFlags)); //Operación lógica NOT
    Msub #(n) SUB(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(ALUResult),.ALUFlags(ALUFlags)); //Resta
    Mxor #(n) XOR (.ALUA(ALUA),.ALUB(ALUB),.ALUResult(ALUResult),.ALUFlags(ALUFlags)); //Operación lógica XOR
    Msl #(n) SL(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(ALUResult),.ALUFlags(ALUFlags)); //Desplazamiento hacia la izquierda
    Msr #(n) SR(.ALUA(ALUA),.ALUB(ALUB),.ALUFlagIn(ALUFlagIn),.ALUResult(ALUResult),.ALUFlags(ALUFlags)); //Desplazamiento hacia la derecha
   
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
    assign {ALUFlags.C, ALUResult} = ALUA + ALUB + ALUFlagIn;

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

module Mdec #(
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

module Mnot #(
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

module Msub #(
    n = 4
) (
    input logic [n-1:0] ALUA, ALUB,
    input logic ALUFlagIn,
    output logic [n-1:0] ALUResult,
    output ALUFlagsStruct ALUFlags
);
    assign {ALUFlags.C, ALUResult} = ALUA - ALUB + ALUFlagIn;

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

module Mxor #(
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

module Msl #(
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

module Msr #(
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