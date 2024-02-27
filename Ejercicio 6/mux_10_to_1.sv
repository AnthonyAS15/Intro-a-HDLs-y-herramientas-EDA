//multiplexor de 10 a 1 para elegir el resultado o la bandera de salida Z

module mux_10_to_1 #(
    n = 4
) (
    input logic [n-1:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9,
    input  logic [3:0] Control,
    output logic [n-1:0] Result
);

    always_comb
    begin
        case (Control)
            4'h0:
                Result = I0;
            4'h1:
                Result = I1;
            4'h2: 
                Result = I2;
            4'h3: 
                Result = I3;
            4'h4: 
                Result = I4;
            4'h5: 
                Result = I5;
            4'h6: 
                Result = I6;
            4'h7: 
                Result = I7;
            4'h8: 
                Result = I8;
            4'h9: 
                Result = I9;
        endcase
    end
    
endmodule