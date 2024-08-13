library IEEE;
use IEEE.std_logic_1164.all;
use work.EE_232.all;

entity CLOCK is 									-- Entity declaration
	port(CLK : in std_logic; 							-- Clock input of the counter
		RESET : in std_logic; 							-- Active low reset input of the counter
		UP_DN : in std_logic; 							-- Count up if UP_DN is high, down if low
 		STOP : in std_logic; 	
 							-- Count if E is high, retain otherwise
 		SEC, MIN, HOUR : in std_logic;
 		SEC0, SEC1, MIN0, MIN1, HOUR0, HOUR1 : inout std_logic_vector(6 downto 0)); 				-- Output state of the counter
end CLOCK;

architecture FUNCTIONALITY of CLOCK is

signal RSTN, STOPN , F0,F1,F2,F3,F4,F5, INV1 , CLK1, INV2,INV3,INV4, CLK2, CLK3, CLK4, CLK5, CLK_D : std_logic;
signal T, Q , S0, S1, M0, M1, H0: std_logic_vector(3 downto 0);
signal QD0, QN0, R5,R0,R50, QD1, QN1, R_5, R_0, R_50 ,QD2,QN2, R19,R10, R1_90: std_logic;
signal CLK6 , CLK7 , R29,R20,R2_90, QD3, QN3, DN_CHK, DN_CHK1, CLK_DN: std_logic;
signal H_BCD : std_logic_vector(7 downto 0);


begin
T <= '0' & '0' & '0' & '1';

N0 : NOT_1 port map (RESET , RSTN);
N1 : NOT_1 port map (STOP, STOPN);

C0 : CLK_DVD port map (CLK, '1', CLK_D);


MX0 : MUX_2X1 port map (CLK_D, SEC, STOP, CLK1);
CLK_DN <= DN_CHK1 and CLK1;

A0 : COUNTER_SYNC_MOD10 port map (CLK_DN, RSTN, UP_DN, '1', '1', T , S0, INV1);

R19 <= S0(3) and (not S0(2)) and (not S0(1)) and S0(0);
R10 <= not (S0(0) or S0(1) or S0(2) or S0(3));

MX5 : MUX_2X1 port map (R10, R19, UP_DN, R1_90);
D2 : D_FF port map (R1_90, CLK_D, '1', '1', QD2, QN2);

CLK6 <= QD2 and INV1;

A1 : COUNTER_SYNC_MOD6 port map (CLK6, RSTN, UP_DN, '1', '1', T , S1, INV2);

R5 <= not S1(3) and S1(2) and (not S1(1)) and S1(0);
R0 <= not (S1(0) or S1(1) or S1(2) or S1(3));

MX3 : MUX_2X1 port map (R0, R5, UP_DN, R50);

D0 : D_FF port map (R50, CLK_D, '1', '1', QD0, QN0);
CLK4 <= QD0 and INV2;

MX1 : MUX_2X1 port map (CLK4, MIN, STOP, CLK2); 
A2 : COUNTER_SYNC_MOD10 port map (CLK2, RSTN, UP_DN, '1', '1', T , M0, INV3);

R29 <= M0(3) and (not M0(2)) and (not M0(1)) and M0(0);
R20 <= not (M0(0) or M0(1) or M0(2) or M0(3));
MX6 : MUX_2X1 port map (R20, R29, UP_DN, R2_90);

D3 : D_FF port map (R2_90, CLK_D, '1', '1', QD3, QN3);


CLK7 <= QD3 and INV3;

A3 : COUNTER_SYNC_MOD6 port map (CLK7, RSTN, UP_DN, '1', '1', T , M1, INV4);

R_5 <= not M1(3) and M1(2) and (not M1(1)) and M1(0);
R_0 <= not (M1(0) or M1(1) or M1(2) or M1(3));

MX4 : MUX_2X1 port map (R_0, R_5, UP_DN, R_50);

D1 : D_FF port map (R_50, CLK_D, '1', '1' , QD1, QN1);
CLK5 <= QD1 and INV4;
MX2 : MUX_2X1 port map (CLK5, HOUR, STOP, CLK3);

A4 : COUNTER_SYNC_MOD12 port map (CLK3, RSTN, UP_DN, '1', '1', T , H0);
DN_CHK <= H0(3) or H0(2) or H0(1) or H0(0) or (not R_0) or (not R0) or (not R10) or (not R20);

DN_CHK1 <= UP_DN or DN_CHK;

B0 : BCD2SSD port map (S0, SEC0, F0);
B1 : BCD2SSD port map (S1, SEC1, F1);
B2 : BCD2SSD port map (M0, MIN0, F2);
B3 : BCD2SSD port map (M1, MIN1, F3);

H_BCD(7 downto 5) <= '0' & '0' & '0';
H_BCD(4) <= H0(3) and (H0(2) or H0(1));
B4 : BCD2SSD port map (H_BCD(7 downto 4) , HOUR1, F4);

H_BCD(0) <= H0(0);
H_BCD(1) <= (H0(3) and H0(2) and (not H0(1))) or ((not H0(3)) and H0(1));
H_BCD(2) <= ((not H0(3)) and H0(2)) or (H0(1) and H0(2));
H_BCD(3) <= H0(3) and (not H0(2)) and (not H0(1));


B5 : BCD2SSD port map (H_BCD(3 downto 0), HOUR0, F5);

end FUNCTIONALITY;