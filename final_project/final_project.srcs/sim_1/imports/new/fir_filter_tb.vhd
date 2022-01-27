----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2022 23:02:15
-- Design Name: 
-- Module Name: fir_filter_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--TEST PARA COMPROBAR EL DATA PATH

entity fir_filter_tb is
--  Port ( );
end fir_filter_tb;

architecture Behavioral of fir_filter_tb is

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
signal sample_in,sample_out:std_logic_vector(sample_size-1 downto 0);
begin

DUT_FIR_FILTER: fir_filter port map(	clk=>clk,
										reset=>reset,
										sample_in=>sample_in,
										sample_in_enable=>sample_in_enable,
										filter_select=>'1',
										sample_out=>sample_out,
										sample_out_ready=>sample_out_ready);
										
clk<=not clk after clk_period/2;

process
begin
	reset<='1';
	wait for 40ns;
	reset<='0';
	sample_in_enable<='1';
	sample_in<="00110100";
	wait;
end process;



end Behavioral;
