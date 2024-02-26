//alu parametrizable de n bits. Recibirá dos entradas de n bits y un bus de control

`timescale 1ns/1ps

module alu #(
    n = 4
) (
    input logic [n-1:0] A, B,
    input logic FlagIn,
    input logic [3:0] Control,
    output logic [n-1:0] Result,
    output logic Cout, Z
);
    case (Control)
        4'b0000:
            and #(n) AND(.A(A),.B(B),.Result(Result),.Z(Z)); //Operación lógica AND
        4'b0001:
            or #(n) OR(.A(A),.B(B),.Result(Result),.Z(Z)); //Operación lógica OR
        4'b0010:
            add #(n) ADD(.A(A),.B(B),.FlagIn(FlagIn),.Result(Result),.Cout(Cout),.Z(Z)); //Suma
        4'b0011:
            inc #(n) INC(.A(A),.B(B),.FlagIn(FlagIn),.Result(Result),.Z(Z)); //Incrementar en uno
        4'b0100:
            dec #(n) DEC(.A(A),.B(B),.FlagIn(FlagIn),.Result(Result),.Z(Z)); //Decrementar en uno
        4'b0101:
            not #(n) NOT(.A(A),.B(B),.FlagIn(FlagIn),.Result(Result),.Z(Z)); //Operación lógica NOT
        4'b0110:
            sub #(n) SUB(.A(A),.B(B),.FlagIn(FlagIn),.Result(Result),.Cout(Cout),.Z(Z)); //Resta
        4'b0111:
            xor #(n) XOR (.A(A),.B(B),.Result(Result),.Z(Z)); //Operación lógica XOR
        4'b1000:
            sl #(n) SL(.A(A),.B(B),.FlagIn(FlagIn),.Result(Result),.Cout(Cout),.Z(Z)); //Desplazamiento hacia la izquierda
        4'b1001:
            sr #(n) SR(.A(A),.B(B),.FlagIn(FlagIn),.Result(Result),.Cout(Cout),.Z(Z)); //Desplazamiento hacia la derecha
    endcase
endmodule

module and #( //Módulo para hacer AND entre dos entradas
    n = 4
) (
    input logic [n-1:0] A, B,
    output logic [n-1:0] Result,
    output logic Z
);
    assign Result = A & B;

    always_comb
    begin
        if (Result == 0)
        begin
            Z = 1'b1;
        end
        else
        begin
            Z = 1'b0;
        end
    end

endmodule

module or #( //Módulo para hacer OR entre dos entradas
    n = 4
) (
    input logic [n-1:0] A, B,
    output logic [n-1:0] Result
    output logic Z
);
    assign Result = A | B;

    always_comb
    begin
        if (Result == n'b0)
        begin
            Z = 1'b1;
        end
        else
        begin
            Z = 1'b0;
        end
    end

endmodule

module add #( //Módulo para sumar dos entradas y un acarreo
    n = 4
) (
    input logic [n-1:0] A, B,
    input logic FlagIn,
    output logic [n-1:0]  Result, 
    output logic Cout, Z
);
    assign {Cout, Result} = A + B + FlagIn;

    always_comb
    begin
        if (Result == n'b0)
        begin
            Z = 1'b1;
        end
        else
        begin
            Z = 1'b0;
        end
    end

endmodule

module inc #( //Módulo para incrementar en uno 
n = 4) (
    input logic [n-1:0] A, B,
    input logic FlagIn,
    output logic [n-1:0] Result,
    output logic Z
);
    always_comb
    begin
        if (!FlagIn)
        begin
            Result = A + n'b1;
        end
        else
        begin
            Result = B + n'b1;
        end

    end

    always_comb
    begin
        if (Result == n'b0)
        begin
            Z = 1'b1;
        end
        else
        begin
            Z = 1'b0;
        end
    end

endmodule

module dec #(
    n = 4
) (
    input logic [n-1:0] A, B,
    input logic FlagIn,
    output logic [n-1:0] Result,
    output logic Z
);
    always_comb
    begin
        if (!FlagIn)
        begin
            Result = A - n'b1;
        end
        else
        begin
            Result = B - n'b1;
        end
    end

    always_comb
    begin
        if (Result == n'b0)
        begin
            Z = 1'b1;
        end
        else
        begin
            Z = 1'b0;
        end
    end

endmodule

module not #(
    n = 4
) (
    input logic [n-1:0] A, B,
    input logic FlagIn,
    output [n-1:0] logic Result,
    output logic Z
);
    always_comb
    begin
        if (!FlagIn)
        begin
            Result = ~A;
        end
        else
        begin
            Result = ~B;
        end
    end

    always_comb
    begin
        if (Result == n'b0)
        begin
            Z = 1'b1;
        end
        else
        begin
            Z = 1'b0;
        end
    end
endmodule

module sub #(
    n = 4
) (
    input logic [n-1:0] A, B,
    input logic FlagIn,
    output [n-1:0] logic Result,
    output logic Cout, Z
);
    assign {Cout, Result} = A - B + FlagIn;

    always_comb
    begin
        if (Result == n'b0)
        begin
            Z = 1'b1;
        end
        else
        begin
            Z = 1'b0;
        end
    end
endmodule

module xor #(
    n = 4
) (
    input logic [n-1:0] A, B,
    output logic [n-1:0] Result,
    output logic Z
);
    assign Result = A ^ B;

    always_comb
    begin
        if (Result == n'b0)
        begin
            Z = 1'b1;
        end
        else
        begin
            Z = 1'b0;
        end
    end
endmodule

module sl #(
    n = 4
) (
    input logic [n-1:0] A, B,
    input logic FlagIn,
    output logic [n-1:0] Result,
    output logic Cout, Z
);
    logic [B-1:0] filler;

    assign filler = {B{FlagIn}};

    assign Result = {filler, A[n-B-1:0]};

    always_comb
    begin
        if (Result == n'b0)
        begin
            Z = 1'b1;
        end
        else
        begin
            Z = 1'b0;
        end
    end
endmodule

module sr #(
    n = 4
) (
    input logic [n-1:0] A, B,
    input logic FlagIn,
    output logic [n-1:0] Result,
    output logic Cout, Z
);
    logic [B-1:0] filler;

    assign filler = {B{FlagIn}};

    assign Result = {A[n-1:B-1], filler};

    always_comb
    begin
        if (Result == n'b0)
        begin
            Z = 1'b1;
        end
        else
        begin
            Z = 1'b0;
        end
    end
endmodule