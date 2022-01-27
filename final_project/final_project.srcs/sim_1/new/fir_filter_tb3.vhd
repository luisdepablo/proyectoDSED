----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2022 22:17:03
-- Design Name: 
-- Module Name: fir_filter_tb3 - Behavioral
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
use STD.TEXTIO.ALL;
use work.package_dsed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fir_filter_tb3 is
--  Port ( );
end fir_filter_tb3;

architecture Behavioral of fir_filter_tb3 is

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
	reset<='0';
	wait for 2ns;
	reset<='1';
	wait for 20ns;
	reset<='0';
	wait;
end process;

read_process: process(sample_in_enable)
	FILE in_file: text OPEN read_mode IS "sample_in.dat";
	
	variable in_line:line;
	variable in_int:integer;
	variable in_read_ok:boolean;
	
begin

	if rising_edge(sample_in_enable) then
		if not endfile(in_file) then
			ReadLine(in_file,in_line);
			Read(in_file,in_line,in_read_ok);
			sample_in<=std_logic_vector(to_signed(in_int,sample_size));
		else
			assert false report "Simulation finished" severity failure;
		end if;
	end if;
end process;

write_process: process(sample_out_ready)

	FILE out_file: text OPEN write_mode IS "sample_out.dat";
	variable out_line: line;
	variable sample_out_mat: integer;

begin
	if rising_edge(sample_out_ready) then
		sample_out_mat:= to_integer(signed(sample_out));
		Write(out_line,sample_out_mat);
		Write(out_file,out_line);
	end if;
end process;



end Behavioral;
