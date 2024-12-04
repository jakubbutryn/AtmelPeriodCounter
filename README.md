Zaprojektuj układ mikroprocesorowy mierzący częstotliwość sygnału okresowego za pomocą licznika T2. Zakładamy, że procesor posiada pamięć programu. Wyniki pomiaru przesyła łączem szeregowym do modemu.


Algorytm programu:
1.	Licznik T2 działający w trybie licznika 16-bitowego zlicza impulsy sygnału okresowego zadanego na pin T2.
2.	Licznik T0 działa w trybie czasomierza 16-bitowego.
3.	Po upływie czasu zmierzonego przez licznik T0 zgłaszane jest przerwanie.
4.	W procedurze „DISPLAY” przerwania od licznika T0 wyłączamy licznik T2 a ilość zliczonych impulsów przesyłamy portem szeregowym do przetwornika
5.	W procedurze „START” ustawiamy liczniki oraz rozpoczynamy zliczanie


Konfiguracja liczników:
Licznik T2 – tryb pracy licznika 16-bitowego
T2CON = #00000(0/1)10B
	T2CON.2(TR2) = 1 – Włączanie licznika T2
T2CON.1(C/T2) = 1 – Tryb pracy licznika – zliczanie impulsów


	
Licznik T0 – Tryb 1, funkcja czasomierza, licznik 16-bitowy
TMOD = #00000001B
TMOD.2(C/T) = 0 – Funkcja czasomierza
TMOD.1[0] = 0[1] – Tryb 1 licznika T0

TCON = #00110000B
TCON.5 – 1 - Znacznik przepełnienia licznika
TCON.4 – 1 –Powoduje pracę licznika T0
Konfiguracja portu szeregowego:
Tryb pracy 1
SCON = #01010000B
SCON.7(SM0)=0,SCON.6(SM1)=1-Transmisja szeregowa asynchroniczna, znaki 8-bitowe, szybkość transmisji ustawiona programowo
SCON.4(REN=1)-Uaktywnienie odbiornika transmisji szeregowej
