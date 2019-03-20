//Stwórz prosty kalkulator:

//Pierwsza liczba to wartość bitowa na SW4-SW0.
//Druga liczba to wartość bitowa na SW9-SW5.
//Wynik wyświetla się w postaci binarnej na diodach LEDR.
//Działanie należy wykonać, gdy wciśnięto przycisk:
//KEY0 - dodawanie,
//KEY1 - odejmowanie,
//KEY2 - mnożenie.
//Jeżeli wynikiem operacji (odejmowania) jest liczba mniejsza niż 0, 
//wynik może być niepoprawny.

module zad1 (SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3);
input [9:0] SW;
input [3:0] KEY;
output reg [9:0] LEDR;
output[6:0] HEX0;
output[6:0] HEX1;
output[6:0] HEX2;
output[6:0] HEX3;


always
if(KEY[0] == 0)
	LEDR[9:0] = SW[9:5] + SW[4:0];
	
else if(KEY[1] == 0)
	LEDR[9:0] = SW[9:5] - SW[4:0];
	
else if(KEY[2] == 0)
	LEDR[9:0] = SW[9:5] * SW[4:0];
	
else
	LEDR[9:0] = SW[9:0];
endmodule

//Rozbuduj kalkulator utworzony w poprzednim zadaniu o następującą funkcjonalność:
//wynik powinien być wyświetlany na wyświetlaczu siedmiosegmentowym.

module zad1 (SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3);
input [9:0] SW;
input [3:0] KEY;
output reg [9:0] LEDR;
output [6:0] HEX0;
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;


convert_to_hex jednosci (LEDR[9:0] % 10, HEX0);
convert_to_hex dziesiatki ((LEDR[9:0] / 10) %10 , HEX1);
convert_to_hex setki ((LEDR[9:0] / 100) %10, HEX2);
convert_to_hex tysiace ((LEDR[9:0] / 1000) %10, HEX3);

always
if(KEY[0] == 0)
	LEDR[9:0] = SW[9:5] + SW[4:0];
else if(KEY[1] == 0)
	LEDR[9:0] = SW[9:5] - SW[4:0];
else if(KEY[2] == 0)
	LEDR[9:0] = SW[9:5] * SW[4:0];
else
	LEDR[9:0] = SW[9:0];

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
//Rozbuduj kalkulator utworzony w poprzednim zadaniu o następującą funkcjonalność:
//wynik powinien być wyświetlany na wyświetlaczu siedmiosegmentowym.

module zad1 (SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3);
input [9:0] SW;
input [3:0] KEY;
output reg [9:0] LEDR;
output [6:0] HEX0;
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;


dec_to_hex y0 (LEDR[8:0] % 10, HEX0);
dec_to_hex y1 ((LEDR[8:0] / 10) %10 , HEX1);
dec_to_hex y2 ((LEDR[8:0] / 100) %10, HEX2);
//dec_to_hex y3 ((LEDR[9:0] / 1000) %10, HEX3);
dec_to_hex y3 (LEDR[9] * 10, HEX3);


always
if(KEY[0] == 0)
	begin
	LEDR[9] = 0;
	LEDR[8:0] = SW[9:5] + SW[4:0];
	end
else if(KEY[1] == 0)
	begin
	if (SW[9:5] < SW[4:0])
		begin
		LEDR[9] = 1;
		LEDR[8:0] = SW[4:0] - SW[9:5];
	   end
	else
		begin
		LEDR[9] = 0;
		LEDR[8:0] = SW[9:5] - SW[4:0];
		end
	end
else if(KEY[2] == 0)
	begin
	LEDR[9] = 0;
	LEDR[8:0] = SW[9:5] * SW[4:0];
	end
else
	begin
	LEDR[9] = 0;
	LEDR[8:0] = SW[9:0];
	end

endmodule

module dec_to_hex(dec, hex);
input [3:0] dec;
output reg [6:0] hex;

always
case (dec)
	10: hex = 7'b0111111;
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


module zad1 (SW,KEY,HEX0,HEX1,HEX2,HEX3,dec,hex,hex1,hex2,hex3,hex4);

	input[9:0] SW;
	input[2:0] KEY;
	output reg[9:0] hex;
	output reg[9:0] hex1;
	output reg[9:0] hex2;
	output reg[9:0] hex3;
	output reg[9:0] hex4;
	output[6:0] HEX3;
	output[6:0] HEX2;
	output[6:0] HEX1;
	output[6:0] HEX0;
	output reg[0:9] dec;

	
	always
	begin
		if(!KEY[0]) 	  //dodawanie
		begin
			hex[9:0] = SW[4:0] + SW[9:5];
			hex1 = hex/1000;
			hex2 = (hex/100)%10;
			hex3 = (hex/10)%10;
			hex4 = hex%10;
		end
		else if(!KEY[1]) //odejmowanie HEX3 HEX2 - HEX1 HEX0
		begin
			hex[9:0] = SW[9:5] - SW[4:0];
			if(SW[9:5] < SW[4:0])  //jezeli wychodzi ujemne to zamienia i
			begin
				hex = SW[4:0] - SW[9:5];
				hex1 = 11; // puste 
				hex2 = 10; //dodaje minus
				hex3 = (hex/10)%10;
				hex4 = hex%10;
			end
		else				 
			begin
				hex1 = hex/1000;
				hex2 = (hex/100)%10;
				hex3 = (hex/10)%10;
				hex4 = hex%10;
			end
		end
		else if(!KEY[2]) //mnozenie
		begin
			hex[9:0] = SW[4:0] * SW[9:5];
			hex1 = hex/1000;
			hex2 = (hex/100)%10;
			hex3 = (hex/10)%10;
			hex4 = hex%10;
		end
		else
		begin
			if(SW[9:5] > 0) 
			begin
				hex1 = SW[9:5];
				if(hex1 < 10)  //mniejsze niz 10 to zapisuje na 1 bicie
				begin
					hex2 = hex1;
					hex1 = 11;
				end
				else
				begin				 //wieksze niz 10 to zapisuje na 2 bitach
					hex2 = hex1%10;
					hex1 = hex1/10;
				end
			end
			else if(SW[9:5] == 0) //domyslne puste i zero
			begin
				hex1 = 11;
				hex2 = 0;
			end
			if(SW[4:0] > 0) //jezeli wieksze niz 0 to 
			begin
				hex3 = SW[4:0];
				if(hex3 < 10)  //mniejsze niz 10 to zapisuje na 1 bicie
				begin
					hex4 = hex3;
					hex3 = 11;
				end
				else          //wieksze niz 10 to zapisuje na 2 bitach
				begin
					hex4 = hex3%10;
					hex3 = hex3/10;
				end
			end
			else if(SW[4:0] == 0) //domyslne puste i zero
			begin
				hex3 = 11;
				hex4 = 0;
			end
		end
	end
	convert_to_hex(hex1,HEX3);
	convert_to_hex(hex2,HEX2);
	convert_to_hex(hex3,HEX1);
	convert_to_hex(hex4,HEX0);	
endmodule	
module convert_to_hex(dec, hex);
		input [9:0] dec;
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
			9: hex = 7'b0010000;
			10: hex = 7'b0111111;
			11: hex = 7'b1111111;
			default: hex = 7'b1111111;
		endcase
endmodule
