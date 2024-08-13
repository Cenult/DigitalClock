library IEEE;
use IEEE.std_logic_1164.all;
USE WORK.EE_232.ALL;

entity COUNTER_SYNC_new is 
	port(CLK : in std_logic;
		  RSTN : in std_logic;
		  UP_DN : in std_logic;
		  LDN : in std_logic; 
		  E : in std_logic;
		  D : in std_logic_vector(3 downto 0);
		  Q : inout std_logic_vector(3 downto 0));
end entity;

architecture structure of couNTER_SYNC_new is

signal QN : std_logic_vector(3 downto 0) ;
signal QD : std_logic_vector(3 downto 0) ;
signal CLK_D,INV_UP, INV_DN  : std_logic ;
signal INV_UP_RST, INV_DN_RST, RSTN_MUX_UPDN,  RSTN_MUX_UP,  RSTN_MUX_DN : std_logic_vector(3 downto 0);

signal Q_UD, C, QE_XOR, LDN_MUX, R0, R9 ,RSTN_MUX : std_logic_vector( 3 downto 0);

begin 

R0 <= '0' & '0' & '0' & '0';
R9 <= '1' & '0' & '0' & '1';

U4 : CLK_DVD port map (CLK,'1', CLK_D);

F0 : for i in 0 to 3 generate
begin
	U0 : D_FF port map (RSTN_MUX(i), CLK, '1', '1', QD(i), QN(i));
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

INV_UP <= QD(3) and (QD(1) or QD(2) or QD(0));
INV_DN <= (QD(3) and (QD(1) or QD(2))) or (not (QD(0) or QD(1) or QD(2) or QD(3)));

F4 : for i in 0 to 3 generate
begin
MX5 : MUX_2X1 port map (LDN_MUX(i), R0(i), INV_UP, INV_UP_RST(i));
MX6 : MUX_2X1 port map (LDN_MUX(i), R9(i), INV_DN, INV_DN_RST(i));
MX7 : MUX_2X1 port map (INV_DN_RST(i), INV_UP_RST(i) , UP_DN, RSTN_MUX_UPDN(i));

MX2 : MUX_2X1 port map (R0(i), RSTN_MUX_UPDN(i), RSTN, RSTN_MUX_UP(i));
MX3 : MUX_2X1 port map (R9(i), RSTN_MUX_UPDN(i), RSTN, RSTN_MUX_DN(i));


MX4 : MUX_2X1 port map(RSTN_MUX_DN(i), RSTN_MUX_UP(i), UP_DN, RSTN_MUX(i));

end generate;

F3 : for i in 0 to 3 generate
begin
    Q(i) <= QD(i);
end generate;


end structure ;

