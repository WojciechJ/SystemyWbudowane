//Wprowadzając dodatkową zmienną zapisującą stan układu, zmodyfikuj program "kalkulator" 
//z poprzednich ćwiczeń tak, aby wynik działania pozostawał wyświetlony również po zwolnieniu przycisku.

//W zadaniach potrzebne będzie użycie tzw. listy wrażliwości procesu w instrukcji always. Na liście tej 
//można dodać informację, by blok został wykonany np. przy narastającym (posedge) lub opadającym (negedge) zboczu jakiegoś sygnału (np. clk - zegara):

//always @(posedge clk)
//begin
//...
//end

module zad1 (clk,SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3,dec,hex,hex1,hex2);

	input clk;
	input[9:0] SW;
	input[2:0] KEY;
	output[8:0] LEDR;
	output reg[8:0] hex;
	output reg[8:0] hex1;
	output reg[8:0] hex2;
	output[6:0] HEX3;
	output[6:0] HEX2;
	output[6:0] HEX1;
	output[6:0] HEX0;
	output reg[0:8] dec;
	initial
	begin
	hex1 = 0;
	hex2 = 0;
	end
	
	always @ (posedge clk)
	begin
	if(!KEY[0])
		begin
		hex[8:0] = SW[4:0] + SW[9:5];
		hex1 = hex/100;
		hex2 = hex%100;
		end
	else if(!KEY[1])
		begin
			hex[8:0] = SW[9:5] - SW[4:0];
			if(SW[9:5] < SW[4:0])
				begin
					hex1 = 100;
					hex = SW[4:0] - SW[9:5];
					hex2 = hex%100;
				end
			else
				begin
					hex1 = hex/100;
					hex2 = hex%100;
				end
		end
	else if(!KEY[2])
	begin
		hex[8:0] = SW[9:5] * SW[4:0];
		hex1 = hex/100;
		hex2 = hex%100;
		end
	end
	convert_to_hex(hex2%10,HEX0);
	convert_to_hex(hex2/10,HEX1);	
	convert_to_hex(hex1%10,HEX2);
	convert_to_hex(hex1/10,HEX3);
	
endmodule	

module convert_to_hex(dec, hex);
		input [8:0] dec;
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

//Stwórz licznik, który zlicza liczbę sekund od uruchomienia układu. W tym celu skorzystaj z sygnału CLOCK_50.
//Wciśnięcie przycisku KEY[0] powinno zerować licznik. Liczba zmierzonych sekund powinna być wyświetlana na wyświetlaczach siedmiosegmentowych HEX0 - HEX3.

module zad1(HEX0,HEX1,HEX2,HEX3,KEY,CLOCK_50,R,count,);
	input CLOCK_50;
	input[0:0] KEY;
	output[6:0] HEX0;
	output[6:0] HEX1;
	output[6:0] HEX2;
	output[6:0] HEX3;
	output reg [25:0] R;
	output reg [9:0] count;
	
	initial
	begin
		count = 0;
	end
	
	always @(posedge CLOCK_50)
	begin
		if (R<50000000)
			R = R + 1;
		else
		begin
			R = 0;
			count = count + 1;
		end
		if(!KEY[0])
			count = 0;
	end
  convert_to_hex(count%10,HEX0);
	convert_to_hex((count/10)%10,HEX1);
	convert_to_hex((count/100)%10,HEX2);
	convert_to_hex(count/1000,HEX3);
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

//Stwórz program - stoper:

//Czas wyświetlany jest na wyświetlaczu siedmiosegmentowym liczony w dziesiątych częściach sekundy (1 p.).
//Naciśnięcie przycisku KEY[0] uruchamia licznik (1 p.).
//Naciśnięcie przycisku KEY[1] wstrzymuje licznik (1 p.).
//Naciśnięcie przycisku KEY[2] zeruje licznik (1 p.).
//Naciśnięcie przycisku KEY[3] powoduje rozpoczęcie odliczania z 3-sekundowym opóźnieniem (2 p.).

module zad1(KEY,CLOCK_50,msec,count,HEX0,HEX1,HEX2,HEX3,On,count3s,fsec,delayOn);
	input CLOCK_50;
	input[3:0] KEY;
	output[6:0] HEX0;
	output[6:0] HEX1;
	output[6:0] HEX2;
	output[6:0] HEX3;
	output reg [25:0] msec;
	output reg [25:0] fsec;
	output reg [13:0] count;
	output reg [13:0] count3s;
	output reg[1:0] On;
	output reg[1:0] delayOn;
	
	initial
	begin
		count = 0;
		On = 0;
		count3s = 0;
		fsec = 0;
		delayOn = 0;
	end
	
	always @(posedge CLOCK_50)
	begin
	
		if(!KEY[0])//start
			On = 1;
		if (msec<5000000) 
			msec = msec + 1;
		else if(On == 1)
		begin
			msec = 0;
			if(count < 9999) 
				count = count + 1;
			else
			begin
				count = 0;
				On = 0;		
			end
		end
		if(!KEY[1])//stop
			On = 0;
		if(!KEY[2])//reset
			count = 0;
		if(!KEY[3])//opoznienie 3s
			delayOn = 1;
		if(delayOn == 1)
		begin
			if (fsec<50000000) 
				fsec = fsec + 1;
			else
			begin
				fsec = 0;
				count3s = count3s + 1;
			end
			if(count3s == 3)
			begin
				On = 1;
				count3s = 0;
				delayOn = 0;
			end
		end		
	end
	convert_to_hex(count/1000,HEX3);
	convert_to_hex((count/100)%10,HEX2);
	convert_to_hex((count/10)%10,HEX1);
	convert_to_hex(count%10,HEX0);	
endmodule

module convert_to_hex(dec, hex);
		input [13:0] dec;
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
