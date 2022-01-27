----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2021 22:03:03
-- Design Name: 
-- Module Name: package_dsed - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package package_dsed is
	constant sample_size: integer := 8;
	
	constant clk_period: time :=83.3333 ns;
	constant clk_100Mhz_period: time :=10 ns;

	--Filter
		--Low Pass
		constant C0_LP,C4_LP: std_logic_vector(sample_size -1 downto 0):="00000101";
		constant C1_LP,C3_LP: std_logic_vector(sample_size -1 downto 0):="00011111";
		constant C2_LP: std_logic_vector(sample_size -1 downto 0):="00111001";
		--High Pass
		constant C0_HP,C4_HP: std_logic_vector(sample_size -1 downto 0):="11111111";
		constant C1_HP,C3_HP: std_logic_vector(sample_size -1 downto 0):="11100110";
		constant C2_HP: std_logic_vector(sample_size -1 downto 0):="01001101";


end package;
