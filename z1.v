//przyklad
module zad1 (KEY, LEDR);
input[0:0] KEY;
output[0:0] LEDR;

assign LEDR[0] = 1;

endmodule

// CWICZENIA

// Zad 1
// Zaimplementuj program działający zgodnie z następującą zasadą:
// dioda LEDR1 świeci się wtedy i tylko wtedy, gdy oba przyciski KEY0 i KEY1 są wciśnięte.

module zad1 (KEY, LEDR);
input[0:1] KEY;
output[0:0] LEDR;
assign LEDR[0] = ~(KEY[0] & KEY[1]);
endmodule


// Zad 2
// Zaimplementuj program działający zgodnie z następującą zasadą:
// dioda LEDR1 świeci się wtedy i tylko wtedy, gdy co najmniej jeden z przycisków KEY0 i KEY1 jest wciśnięty.

module zad1 (KEY, LEDR);
input[0:1] KEY;
output[0:0] LEDR;
assign LEDR[0] = KEY[0] | KEY[1];
endmodule

// Zad 3 (1 pkt)
// Zaimplementuj program zliczający liczbę wciśniętych przycisków KEY0-KEY3. Liczba powinna być wyświetlana w postaci
// binarnej na diodach LEDR4-LEDR6. Gdy przyciski nie są naciśnięte, to nie powinna się świecić żadna z diod.

module zad1 (KEY, LEDR);
input[0:3] KEY;
output[6:4] LEDR;
assign LEDR[6:4] = !KEY[0] + !KEY[1] + !KEY[2] + !KEY[3];
endmodule

// Zad 4
// Zaimplementuj program, który przekieruje wybraną wartość z przełączników SW8-SW9 na diody LEDR8-LEDR9.

module zad1 (SW, LEDR);
input[8:9] SW;
output[8:9] LEDR;
assign LEDR[8:9] = SW[8:9];
endmodule

// Zad 5 (1 pkt)
// Zaimplementuj program wyświetlający ostatnie 4 cyfry twojego numeru indeksu na wyświetlaczu
// siedmiosegmentowym (HEX0-HEX3).

module zad1 (HEX0, HEX1, HEX2, HEX3);
output[0:6] HEX0;
output[0:6] HEX1;
output[0:6] HEX2;
output[0:6] HEX3;
//6145

//6
assign HEX3[1]=1;
//1
assign HEX2[0]=1;
assign HEX2[5]=1;
assign HEX2[4]=1;
assign HEX2[6]=1;
assign HEX2[3]=1;
//4
assign HEX1[0]=1;
assign HEX1[4]=1;
assign HEX1[3]=1;
//5
assign HEX0[1]=1;
assign HEX0[4]=1;

endmodule

// ZADANIE DOMOWE

// Zad 1 (3 pkt)

// Utwórz moduł, który:
// ma 4 bity wejściowe (zakładamy, że jest to liczba: 0000 = 0, 0101 = 5 itd.),
// ma 7 bitów wyjściowych,
// dla danej cyfry na wejściu zwraca zestaw bitów odpowiadający układowi diod
// wyświetlacza siedmiosegmentowego wyświetlającego tę cyfrę.

module zad1(dec, hex);
input [3:0] dec;
output reg [6:0] hex;

always
case (dec)
	0: hex = 7'b1000000;
	1: hex = 7'b1111001;
	2: hex = 7'b0100100;
	3: hex = 7'b0110000;
	4: hex = 7'b0011001;
	5: hex = 7'b0010010;
 	6: hex = 7'b0000010;
	7: hex = 7'b1111000;
	8: hex = 7'b0000000;
	9: hex = 7'b0011000;
	default: hex = 7'b1111111;
endcase
endmodule

// Zad 2

// Wykorzystaj moduł z zadania domowego 1. w celu wyświetlenia na wyświetlaczu
// ostatnich 4 cyfr twojego numeru indeksu.

module zad1 (SW, HEX0,HEX1,HEX2,HEX3);
input [3:0] SW;
output[6:0] HEX0;
output[6:0] HEX1;
output[6:0] HEX2;
output[6:0] HEX3;

convert_to_hex(5,HEX0);
convert_to_hex(4,HEX1);
convert_to_hex(1,HEX2);
convert_to_hex(6,HEX3);


endmodule

module convert_to_hex(dec, hex);
input [3:0] dec;
output reg [6:0] hex;

always
case (dec)
	0: hex = 7'b1000000;
	1: hex = 7'b1111001;
	2: hex = 7'b0100100;
	3: hex = 7'b0110000;
	4: hex = 7'b0011001;
	5: hex = 7'b0010010;
 	6: hex = 7'b0000010;
	7: hex = 7'b1111000;
	8: hex = 7'b0000000;
	9: hex = 7'b0011000;
	default: hex = 7'b1111111;
endcase
endmodule
