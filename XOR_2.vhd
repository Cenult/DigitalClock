LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use work.ee_232.all;

entity xor_2 is 
	port(I0, I1 : in std_logic;
		O0 : out std_logic);
end xor_2 ;

architecture structure of xor_2 is




signal s1 : std_logic ;
signal s2 : std_logic ;
signal s3 : std_logic ;
signal s4 : std_logic ;

begin 
	U0 : not_1 port map ( I0,s1) ;
	U1 : not_1 port map (I1 , s2) ;
	U2 : and_2 port map (s1,I1,s3);
	U3 : and_2 port map (s2,I0,s4) ;
	U4 : or_2 port map (s3,s4,o0) ; 
end structure;


