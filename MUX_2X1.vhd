library IEEE;
use IEEE.std_logic_1164.all;
use work.EE_232.all;

entity MUX_2X1 is 
	port(I0, I1, S0 : in std_logic; -- Inputs
		O0 : out std_logic); -- Output 
end MUX_2X1;

architecture FUNCTIONALITY of MUX_2X1 is

signal A1, A2, A3 : std_logic;
begin
	U0 : NOT_1 port map(S0,A1);
	U1 : AND_2 port map(I0, A1, A2);
	U2 : AND_2 port map(I1, S0, A3);
	U3 : OR_2 port map(A2, A3 , O0);
	
end FUNCTIONALITY;