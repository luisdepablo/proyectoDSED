----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2021 11:23:40
-- Design Name: 
-- Module Name: fir_filter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use work.package_dsed.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fir_filter is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sample_in : in STD_LOGIC_VECTOR (sample_size-1 downto 0);
           sample_in_enable : in STD_LOGIC;
           filter_select : in STD_LOGIC;
           sample_out : out STD_LOGIC_VECTOR (sample_size -1 downto 0);
           sample_out_ready : out STD_LOGIC);
end fir_filter;

architecture Behavioral of fir_filter is

signal R0,R1,R2 :signed(2*sample_size -1 downto 0);
signal R0_next,R1_next,R2_next :signed(2*sample_size -1 downto 0);
signal C0,C1,C2,C3,C4,C,X0,X1,X2,X3,X4,X :signed (sample_size -1 downto 0);
signal op:signed(2*sample_size -1 downto 0);
type state_FSMD is (idle,t1,t2,t3,t4,t5,t6,t7,t8);
signal state,state_next: state_FSMD;
signal MUX1:unsigned(2 downto 0);
signal MUX3: std_logic;



begin


registers: process(clk,reset)
begin
	if reset='1' then
		R0<=(others=>'0');
		R1<=(others=>'0');
		R2<=(others=>'0');
	elsif rising_edge(clk) then
		R0<=R0_next;
		R1<=R1_next;
		R1<=R2_next;
	end if;
end process;

FILTER: PROCESS(R0,R1,R2,C,X,op)
begin
R0_next<=C*X;
R1_next<=R0;
R2_next<=R1+op;
end process;

MUX: PROCESS(C0,C1,C2,C3,C4,C,X0,X1,X2,X3,X4,X)
BEGIN
	case MUX1 is				--MUX1
		when "000" =>C<=C0;
		when "001" =>C<=C1;
		when "010" =>C<=C2;
		when "011" =>C<=C3;
		when "100" =>C<=C4;
		when others=>
			C<=(others=>'0');
			X<=(others=>'0');
	end case;
	
	case MUX1 is             	--MUX2
		when "000" =>X<=X0;     
		when "001" =>X<=X1;     
		when "010" =>X<=X2;     
		when "011" =>X<=X3;     
		when "100" =>X<=X4;     
	end case;
end process;
op<=(others=>'0') when MUX3='0' else R2;       --MUX3    


STATES: process(state)
begin
	case state is
		when idle => state_next<=t1;
		when t1=> 
			state_next<=t2;
			MUX1<="000";
			MUX3<='0';	
		when t2=> 
			state_next<=t3;
			MUX1<="001";
			MUX3<='0';			
		when t3=> 
			state_next<=t4;
			MUX1<="010";
			MUX3<='0';	
		when t4=> 
			state_next<=t5;
			MUX1<="011";
			MUX3<='1';	
		when t5=> 
			state_next<=t6;
			MUX1<="100";
			MUX3<='1';	
		when t6=> 
			state_next<=t7;
			MUX1<="101";
			MUX3<='1';	
		when t7=> 
			state_next<=t8;
			MUX1<="101";
			MUX3<='1';	
		when t8=> 
			state_next<=t1;
			MUX1<="000";
			MUX3<='1';	
	END CASE;
END PROCESS;
	                         
	
	
	
	
		
		
	

end Behavioral;

