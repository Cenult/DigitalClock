library ieee;
use ieee.std_logic_1164.all;

entity AND_2 is

	port( I0,I1: in std_logic;
	O0 : out std_logic);
	
end entity;

architecture Functionality of AND_2 is
begin
	O0 <= I0 and I1;
	
end Functionality;
