//alu parametrizable de n bits. Recibirá dos entradas de n bits y un bus de control

`timescale 1ns/1ps

module alu #(
    n = 4
) (
    input [n-1:0] A, B,
    input FlagIn,
    input [3:0] Control,
    output [n-1:0] logic Result
    output logic Cout, Z
);
    case (Control)
        4'b0000:  
        4'b0001:  
        4'b0010:  
        4'b0011:  
        4'b0100:  
        4'b0101:  
        4'b0110:  
        4'b0111:  
        4'b1000:  
        4'b1001:  
        4'b1010:  
        default: 
    endcase
endmodule

module and #(
    n = 4
) (
    input [n-1:0] A, B,
    output [n-1:0] logic Result,
    output logic Z
);
    assign Result = A & B;

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

module or #(
    n = 4
) (
    input [n-1:0] A, B,
    output [n-1:0] logic Result
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

module add #(
    n = 4
) (
    input [n-1:0] A, B,
    input FlagIn,
    output [n-1:0] logic Result, 
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

module inc #(
    n = 4
) (
    input [n-1:0] C,
    output [n-1:0] logic Result,
    output logic Z
);
    assign Result = C + n'b1;

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
    input [n-1:0] C,
    output [n-1:0] logic Result,
    output logic Z
);
    assign Result = C - n'b1;

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
    input [n-1:0] C,
    output [n-1:0] logic Result,
    output logic Z
);
    assign Result = ~C;

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
    input [n-1:0] A, B,
    input FlagIn,
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
    input [n-1:0] A, B,
    output [n-1:0] logic Result,
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
    input [n-1:0] A, B,
    input FlagIn,
    output [n-1:0] logic Result,
    output logic Cout, Z
);

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
    input [n-1:0] A, B,
    input FlagIn,
    output [n-1:0] logic Result,
    output logic Cout, Z
);

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