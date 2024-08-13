library IEEE;
use IEEE.std_logic_1164.all;
use work.EE_232.all;

entity COUNTER_SYNC_MOD12 is 						  -- Entity declaration
	port(CLK : in std_logic; 						  -- Clock input of the counter
		RSTN : in std_logic; 						  -- Active low reset input of the counter
		UP_DN : in std_logic; 						  -- Count up if UP_DN is high, down if low
		LDN : in std_logic; 							  -- Load D to the counter if LDN is low
 		E : in std_logic; 							  -- Count if E is high, retain otherwise
		D : in std_logic_vector(3 downto 0); 	  -- Count to load when LDN is low
 		Q : inout std_logic_vector(3 downto 0)); -- Output state of the counter
end COUNTER_SYNC_MOD12;

architecture FUNCTIONALITY of COUNTER_SYNC_MOD12 is

signal QN : std_logic_vector(3 downto 0);
signal CLK_D,INV_UP, INV_DN  : std_logic;
signal QD : std_logic_vector( 3 downto 0);
signal INV_UP_RST, INV_DN_RST, RSTN_MUX_UPDN,  RSTN_MUX_UP,  RSTN_MUX_DN : std_logic_vector(3 downto 0);


signal Q_UD, C, QE_XOR, LDN_MUX, R0, R11 ,RSTN_MUX : std_logic_vector( 3 downto 0);

begin

R0 <= '0' & '0' & '0' & '0';
R11 <= '1' & '0' & '1' & '1';


--U4 : CLK_DVD port map (CLK, '1', CLK_D);

	

F0 : for i in 0 to 3 generate
begin
	U0 : D_FF port map (RSTN_MUX(i), CLK, RSTN, '1', QD(i), QN(i));
end generate;

F1 : for i in 0 to 3 generate
begin
MX0 : MUX_2X1 port map (QN(i),QD(i),UP_DN,Q_UD(i));
end generate;


C(0) <= Q_UD(0) and E;
C(1) <= Q_UD(1) and C(0);
C(2) <= Q_UD(2) and C(1);
C(3) <= Q_UD(3) and C(2);


QE_XOR(0) <= E xor QD(0);
QE_XOR(1) <= C(0) xor QD(1);
QE_XOR(2) <= C(1) xor QD(2);
QE_XOR(3) <= C(2) xor QD(3);


F2 : for i in 0 to 3 generate 
begin
	MX1 : MUX_2X1 port map (D(i), QE_XOR(i), LDN, LDN_MUX(i));
end generate;



INV_UP <= QD(3) and (QD(2) or (QD(1) and QD(0)));
INV_DN <= (QD(3) and QD(2)) or (not (QD(0) or QD(1) or QD(2) or QD(3)));



F4 : for i in 0 to 3 generate
begin
MX5 : MUX_2X1 port map (LDN_MUX(i), R0(i), INV_UP, INV_UP_RST(i));
MX6 : MUX_2X1 port map (LDN_MUX(i), R11(i), INV_DN, INV_DN_RST(i));
MX7 : MUX_2X1 port map (INV_DN_RST(i), INV_UP_RST(i) , UP_DN, RSTN_MUX_UPDN(i));

MX2 : MUX_2X1 port map (R0(i), RSTN_MUX_UPDN(i), RSTN, RSTN_MUX_UP(i));
MX3 : MUX_2X1 port map (R11(i), RSTN_MUX_UPDN(i), RSTN, RSTN_MUX_DN(i));


MX4 : MUX_2X1 port map(RSTN_MUX_DN(i), RSTN_MUX_UP(i), UP_DN, RSTN_MUX(i));

end generate;




F3 : for i in 0 to 3 generate
begin
    Q(i) <= QD(i);
end generate;


end FUNCTIONALITY;