ORG 0000H
LJMP MAIN
TH2 SET 0CDH
TL2 SET 0CCH
T2CON SET 0C8H
ORG 002BH              ;przerwanie od timera T0
CALL DISPLAY           ;wywolanie procedury DISPLAY
CALL START             ;wywolanie procedury START
RETI                   ;powrot z przerwania

MAIN :
MOV SCON,#01010000B    ;ustawienie slowa SCON tryb pracy 1,uaktywnienie odbiornika transmisji
MOV TMOD,#00000001B    ;ustawienie timera T0 wtryb 1, 16bitowy 
SETB T2CON.1           ;wlaczenie trybu zliczania impulsów zewnetrznych licznika T2
SETB EA                ;wlaczenie wektora przerwañ
SETB IE.1              ;wlaczenie przerwan od timera T0
MOV R0,#100D           ;wpisanie do R0 liczby 100 
CALL START             ;wywolanie procedury START
LJMP $                 ;petla

START :
CLR T2CON.7            ;zerowanie flagi przepelnienia licznika T2
CLR TF0                ;zerowanie flagi przepelnienia timera T0
MOV TH0,#0D8H          ;wpisanie do timera T0 liczby 55535
MOV TL0,#0EFH
SETB TR0               ;wlaczenie zliczania timera T0
SETB T2CON.2           ;wlaczanie zliczania licznika T2
RET                    ;powrot z procedury

DISPLAY : 
DJNZ R0,NEXT           ;dekrementowanie póki R0/=0
MOV R0,#100            ;wpisanie do R0 liczby 100 
CLR TR0                ;stop timera T0
CLR T2CON.2            ;stop licznika T2

MOV A, TL2             ;mlodsza czesc licznika T2 do akumlatora
MOV B,#0AH             ;przepisanie 10D do B
DIV AB                 ;dzielenie A i B
MOV 67H,B              ;przepisanie wartosci B do 67H
MOV B,#0AH             ;przepisanie 10D do B
DIV AB                 ;dzielenie A i B
MOV 66H,B              ; przepisanie wartosci B do 66H
MOV 65H,A              ; przepisanie wartosci A do 65H

MOV A,65H
ANL A,#0FH             ;najbardziej znaczaca cyfra-zamiana do ASCII
ADD A,#30H 
MOV SBUF,A             ;przepisanie wartosci do portu szeregowego
MOV 65H,A              ;przepisanie wartosci do komórki(sprawdzenie)

MOV A,66H
ANL A,#0FH             ;srodkowa cyfra-zamiana do ASCII
ADD A,#30H
MOV SBUF,A             ;przepisanie wartosci do portu szeregowego
MOV 66H,A              ;przepisanie wartosci do komórki(sprawdzenie)

MOV A,67H
ANL A,#0FH             ;najmniej znaczaca cyfra-zamiana do ASCII
ADD A,#30H
MOV SBUF,A             ;przepisanie wartosci do portu szeregowego
MOV 67H,A              ;przepisanie wartosci do komórki(sprawdzenie)

CLR TI                 ;zerowanie flagi (transmitting interrupt flag)

MOV TL2,#00            ;zerowanie licznika T2
MOV TH2,#00
NEXT : RET             ;powrót z procedury
END