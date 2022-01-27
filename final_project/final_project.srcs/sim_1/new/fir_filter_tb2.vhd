----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2022 19:10:27
-- Design Name: 
-- Module Name: fir_filter_tb2 - Behavioral
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
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.package_dsed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--TEST PARA COMPROBAR EL DATA PATH

entity fir_filter_tb2 is
--  Port ( );
end fir_filter_tb2;

architecture Behavioral of fir_filter_tb2 is

component fir_filter is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sample_in : in STD_LOGIC_VECTOR (sample_size-1 downto 0);
           sample_in_enable : in STD_LOGIC;
           filter_select : in STD_LOGIC;
           sample_out : out STD_LOGIC_VECTOR (sample_size -1 downto 0);
           sample_out_ready : out STD_LOGIC);
end component fir_filter;

signal clk,reset,sample_in_enable,sample_out_ready:std_logic:='0';
signal sample_in,sample_out:std_logic_vector(sample_size-1 downto 0):=(others=>'0');
begin

DUT_FIR_FILTER: fir_filter port map(	clk=>clk,
										reset=>reset,
										sample_in=>sample_in,
										sample_in_enable=>sample_in_enable,
										filter_select=>'1',
										sample_out=>sample_out,
										sample_out_ready=>sample_out_ready);
										
clk<=not clk after clk_period/2;

rst: process
begin
	reset<='1';
	wait for clk_period;
	reset<='0';
	wait;
end process;

enable_sample_in: process
begin
	sample_in_enable<='0';
	wait for 9*clk_period;
	sample_in_enable<='1';
	wait for clk_period;
end process;

entradas: process
variable apartado:bit:='0';	--0-->2.9/1--2.10
begin
	if apartado='0' then
		--0.5*2^7=64=="0100000"
		wait for 10*clk_period;
		sample_in<=(others=>'0');
		wait for 10*clk_period;  
		sample_in<=(others=>'0');
		wait for 10*clk_period;  
		sample_in<=(others=>'0');
		wait for 10*clk_period;  
		sample_in<=(others=>'0');
		wait for 10*clk_period;  
		sample_in<="01000000";
		wait for 10*clk_period;  
		sample_in<=(others=>'0');
		wait for 10*clk_period;  
		sample_in<=(others=>'0');
		wait for 10*clk_period;  
		sample_in<=(others=>'0');
		wait for 10*clk_period;  
		sample_in<=(others=>'0');
		wait for 50*clk_period;
	else
		--0.125*2^7=16=="00010000"
		wait for 10*clk_period;  
		sample_in<=(others=>'0');
		wait for 10*clk_period;  
		sample_in<="01000000";
		wait for 10*clk_period;  
		sample_in<=(others=>'0');
		wait for 10*clk_period;  
		sample_in<="00010000";
		wait for 10*clk_period;  
		sample_in<=(others=>'0');   
		wait for 10*clk_period;  
		sample_in<=(others=>'0');
		wait for 10*clk_period;  
		sample_in<=(others=>'0');
		wait for 10*clk_period;  
		sample_in<=(others=>'0');
		wait for 10*clk_period;  
		sample_in<=(others=>'0');
		wait for 50*clk_period;
	end if;
end process;  




end Behavioral;
