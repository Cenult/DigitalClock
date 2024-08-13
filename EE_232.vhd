LIBRARY IEEE;
use IEEE.std_logic_1164.all;

package ee_232 is

	component and_2 is
	port(I0,I1 : in std_logic;
		o0 :out std_logic) ;
end component;

	component or_2 is
	port(I0, I1 : in std_logic;
			O0 : out std_logic);
end component;

	component not_1 is
	port(I0 : in std_logic;
		 O0 : out std_logic);
	
end component;

	component xor_2 is
	port(I0, I1 : in std_logic;
		O0 : out std_logic);
end component;
		
	component XNOR_2 is
    port (I0,I1 :in std_logic;
          O0: out std_logic);

end component;
	
	component half_adder is
	port(A, B : in std_logic;
		  S, C : out std_logic);
		  
end component ;

	component full_adder is 
	port(A, B,cI : in std_logic;
		  S, CO : out std_logic);

end component ;

	component MUX_2X1 is 
	port(I0, I1, S0 : in std_logic; -- Inputs
		O0 : out std_logic); -- Output 
end component;


component DEMUX_1X2 is
	port(x,s : in std_logic;
	y0,y1 : out std_logic);
	
end component;

component nibble_adder is
	port(A : in std_logic_vector(3 downto 0); -- First operand
			B : in std_logic_vector(3 downto 0); -- Second operand
			CIN : in std_logic; -- Carry-in to the first bit
			SUM : out std_logic_vector(4 downto 0)); -- 5 bit output
end component;

component VALID_BCD is
	port (A : in std_logic_vector(3 downto 0);
		O : out std_logic);
end component;

component D_LATCH is -- Entity declaration
port( D : in std_logic; -- Data input of the D latch
LTCH : in std_logic; -- Latch input of the D latch
Q : buffer std_logic; -- Q output of the D latch
QN : out std_logic); -- Q_bar output of the D latch
end component;

component D_LATCHN is -- Entity declaration
port( D : in std_logic; -- Data input of the D latch
LTCHN : in std_logic; -- Latch input of the D latch
Q : buffer std_logic; -- Q output of the D latch
QN : out std_logic); -- Q_bar output of the D latch
end component;



component D_FFN is -- Entity declaration
port( D : in std_logic; -- Data input of the D flipflop
CLK : in std_logic; -- Clock input of the D flipflop
CLRN : in std_logic; -- Active low clear input of the D flipflop
PREN : in std_logic; -- Active low preset input of the D flipflop
Q : buffer std_logic; -- Q output of the D flipflop
QN : out std_logic); -- Q_bar output of the D flipflop
end component;



component COUNTER_SYNC_MOD6 is 									-- Entity declaration
		port(CLK : in std_logic; 							-- Clock input of the counter
			RSTN : in std_logic; 							-- Active low reset input of the counter
			UP_DN : in std_logic; 							-- Count up if UP_DN is high, down if low
			LDN : in std_logic; 							-- Load D to the counter if LDN is low
 			E : in std_logic; 							-- Count if E is high, retain otherwise
			D : in std_logic_vector(3 downto 0); 				-- Count to load when LDN is low
 			Q : inout std_logic_vector(3 downto 0); 				-- Output state of the counter
 			INV : out std_logic);
			
	end component;

	component COUNTER_SYNC_MOD10 is 									-- Entity declaration
		port(CLK : in std_logic; 							-- Clock input of the counter
			RSTN : in std_logic; 							-- Active low reset input of the counter
			UP_DN : in std_logic; 							-- Count up if UP_DN is high, down if low
			LDN : in std_logic; 							-- Load D to the counter if LDN is low
 			E : in std_logic; 							-- Count if E is high, retain otherwise
			D : in std_logic_vector(3 downto 0); 				-- Count to load when LDN is low
 			Q : inout std_logic_vector(3 downto 0); 				-- Output state of the counter
 			INV : out std_logic);
	end component;

	component COUNTER_SYNC_MOD12 is 									-- Entity declaration
		port(CLK : in std_logic; 							-- Clock input of the counter
			RSTN : in std_logic; 							-- Active low reset input of the counter
			UP_DN : in std_logic; 							-- Count up if UP_DN is high, down if low
			LDN : in std_logic; 							-- Load D to the counter if LDN is low
 			E : in std_logic; 							-- Count if E is high, retain otherwise
			D : in std_logic_vector(3 downto 0); 				-- Count to load when LDN is low
 			Q : inout std_logic_vector(3 downto 0)); 				-- Output state of the counter
	end component;

	component COUNTER_SYNC_NEW is 									-- Entity declaration
		port(CLK : in std_logic; 							-- Clock input of the counter
			RSTN : in std_logic; 							-- Active low reset input of the counter
			UP_DN : in std_logic; 							-- Count up if UP_DN is high, down if low
			LDN : in std_logic; 							-- Load D to the counter if LDN is low
 			E : in std_logic; 							-- Count if E is high, retain otherwise
			D : in std_logic_vector(3 downto 0); 				-- Count to load when LDN is low
 			Q : inout std_logic_vector(3 downto 0)); 				-- Output state of the counter
	end component;

	component BCD2SSD is 							-- Entity declaration
		port(X : in std_logic_vector(3 downto 0); 		-- Input BCD number
			Y : out std_logic_vector(6 downto 0); 		-- Output SSD code
			F : out std_logic); 					-- Invalid input indicator
	end component;

	component CLK_DVD is
		port(CLK_IN : in std_logic; -- Input clock
			RSTN : in std_logic; -- Active low reset
			CLK_OUT : out std_logic); -- Output clock
	end component;

	component D_FF is -- Entity declaration 
		port ( D : in std_logic; -- Data input of the D flipflop 
			CLK : in std_logic; -- Clock input of the D flipflop 
			CLRN : in std_logic; -- Active low clear input of the D flipflop 
			PREN : in std_logic; -- Active low preset input of the D flipflop 
			Q : buffer std_logic; -- Q output of the D flipflop 
			QN : out std_logic); -- Q_bar output of the D flipflop 
	end component;


end package ;
