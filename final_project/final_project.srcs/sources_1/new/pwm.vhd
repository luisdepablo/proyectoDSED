----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2021 21:49:30
-- Design Name: 
-- Module Name: pwm - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use work.package_dsed.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm is
    Port ( clk_12megas : in STD_LOGIC;
           reset : in STD_LOGIC;
           en_2_cycles : in STD_LOGIC;
           sample_in : in STD_LOGIC_VECTOR (sample_size-1 downto 0);
           sample_request : out STD_LOGIC;
           pwm_pulse : out STD_LOGIC);
end pwm;

architecture Behavioral of pwm is

signal next_state,current_state: unsigned (8 downto 0):=(others=>'0');
signal next_sample,current_sample: std_logic_vector(sample_size-1 downto 0):=(others=>'0');

begin

--Register
process(clk_12megas,reset)
begin
	if(reset='1') then	
		current_state<=(others=>'0');
		current_sample<=(others=>'0');
	elsif rising_edge(clk_12megas) then
		current_state<=next_state;
		current_sample<=next_sample;
	end if;
end process;

--next state logic

process(current_state,next_state,en_2_cycles)
begin
	if(en_2_cycles='1') then
		if(current_state<299) then
			next_state<=current_state+1; 
		else 
			next_state<=(others=>'0');
		end if;
	else
	next_state<=current_state;
	end if;
end process;

next_sample<=sample_in when current_state=299 else current_sample;

--Output logic
pwm_pulse<='1' when(unsigned(current_sample)>current_state) else '0';
sample_request<= '1' when (current_state=299)else '0';	

end Behavioral;
