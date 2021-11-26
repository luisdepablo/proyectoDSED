----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2021 23:42:52
-- Design Name: 
-- Module Name: pwm_tb - Behavioral
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
use work.package_dsed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm_tb is
--  Port ( );
end pwm_tb;

architecture Behavioral of pwm_tb is

component pwm is
        Port ( clk_12megas : in STD_LOGIC;
               reset : in STD_LOGIC;
               en_2_cycles : in STD_LOGIC;
               sample_in : in STD_LOGIC_VECTOR(sample_size - 1 downto 0);
               sample_request : out STD_LOGIC;
               pwm_pulse : out STD_LOGIC);
end component;

component en_4_cycles                    
    Port ( clk_12megas : in STD_LOGIC;   
            reset : in STD_LOGIC;        
            clk_3megas: out STD_LOGIC;   
            en_2_cycles: out STD_LOGIC;  
            en_4_cycles : out STD_LOGIC);
end component en_4_cycles;               

signal clk_12megas,reset,en_2,sample_request,pwm_pulse:std_logic:='0';
signal sample_in:std_logic_vector(sample_size -1 downto 0):=(others=>'0');

signal clk_3megas,en_4: std_logic; 

constant clk_period: time := 83.3333ns;

begin
UUT : pwm port map(
    clk_12megas => clk_12megas,
    reset => reset,
    en_2_cycles => en_2,
    sample_in => sample_in,
    sample_request => sample_request,
    pwm_pulse => pwm_pulse
);

enable: en_4_cycles Port map ( clk_12megas=>clk_12megas,
             reset=>reset,                           
             clk_3megas=>clk_3megas,                 
             en_2_cycles=>en_2,               
             en_4_cycles=>en_4);                     


clk_process:process           
begin                         
    clk_12megas<='0';         
    wait for clk_period/2;    
    clk_12megas<='1';         
    wait for clk_period/2;    
end process;   
                            


process
begin

	reset <= '1';               
	sample_in <= "10101010";    
	wait for 13 ns;             
	reset <= '0';               
	wait for 50 us;           
	sample_in <= "00000000";    
	wait for 60us;           
	sample_in <= "10000001";    
	wait for 60 us;           
	sample_in <= "11111111";    
	--wait for 60 us;           
	--sample_in <= "00011101";    
	--reset <= '1';               
	--wait for 20 ns;             
	--reset <= '0';               
	wait;                       
end process;

end Behavioral;
