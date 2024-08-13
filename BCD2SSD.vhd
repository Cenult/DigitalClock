library ieee;
use ieee.std_logic_1164.all;
use work.EE_232.all;

entity BCD2SSD is 							-- Entity declaration
	port(X : in std_logic_vector(3 downto 0); 		-- Input BCD number
		Y : out std_logic_vector(6 downto 0); 		-- Output SSD code
		F : out std_logic); 					-- Invalid input indicator
end BCD2SSD;

architecture FUNCTIONALITY of BCD2SSD is

signal X3X2, X3X1, X0N, X1N, X2N, X3N, X1NX0N, X2X1NX0N, X3NX2NX1NX0, X3NX2NX1N, X3NX2N : std_logic ;
signal X1X0_XOR, X2NX1, X2X1,X2X1X0, X2X1N, X1X0, X3NX2NX0, X3NX2NX1, X3NX2NX0_X3NX2NX1,Y6  : std_logic;

begin
	A0 : AND_2 port map (X(3), X(2), X3X2);
	A1 : AND_2 port map (X(3), X(1), X3X1);
	O0 : OR_2 port map (X3X2, X3X1, F);

	N0 : NOT_1 port map (X(0), X0N);
	N1 : NOT_1 port map (X(1), X1N);
	N2 : NOT_1 port map (X(2), X2N);
	N3 : NOT_1 port map (X(3), X3N);

	A2 : AND_2 port map (X1N, X0N, X1NX0N);
	
	A3 : AND_2 port map (X1NX0N, X(2), X2X1NX0N);
	A4 : AND_2 port map (X3N, X2N , X3NX2N);
	A5 : AND_2 port map (X3NX2N, X1N , X3NX2NX1N);
	A6 : AND_2 port map (X3NX2NX1N, X(0), X3NX2NX1NX0);
	O1 : OR_2 port map (X2X1NX0N, X3NX2NX1NX0, Y6);
    Y(6) <= Y6;
	X0 : XOR_2 port map (X(0), X(1), X1X0_XOR);
	A7 : AND_2 port map (X1X0_XOR, X(2), Y(5));
	
	A8 : AND_2 port map (X2N, X(1), X2NX1);
	A9 : AND_2 port map (X2NX1, X0N, Y(4));

	A10 : AND_2 port map (X(2), X(1), X2X1);
	A11 : AND_2 port map (X2X1, X(0) , X2X1X0);
	O2 : OR_2 port map (X2X1X0, Y6, Y(3));

	A12 : AND_2 port map (X(2), X1N, X2X1N);
	O3 : OR_2 port map (X2X1N, X(0), Y(2));

	A13 : AND_2 port map (X(1), X(0), X1X0);
	A14 : AND_2 port map (X3NX2N, X(0), X3NX2NX0);
	A15 : AND_2 port map (X3NX2N, X(1), X3NX2NX1);
	O4 : OR_2 port map (X3NX2NX0, X3NX2NX1, X3NX2NX0_X3NX2NX1);
	O5 : OR_2 port map (X3NX2NX0_X3NX2NX1, X1X0, Y(1));

	O6 : OR_2 port map (X3NX2NX1N, X2X1X0, Y(0));


end FUNCTIONALITY;