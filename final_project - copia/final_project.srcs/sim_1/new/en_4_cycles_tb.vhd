----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2021 12:30:12
-- Design Name: 
-- Module Name: en_4_cycles_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity en_4_cycles_tb is
--  Port ( );
end en_4_cycles_tb;

architecture Behavioral of en_4_cycles_tb is

component en_4_cycles
    Port ( clk_12megas : in STD_LOGIC;
            reset : in STD_LOGIC;
            clk_3megas: out STD_LOGIC;
            en_2_cycles: out STD_LOGIC;
            en_4_cycles : out STD_LOGIC);
end component en_4_cycles;

constant clk_period: time := 83.3333333ns;

signal clk_12megas,reset,clk_3megas,en_2_cycles,en_4: std_logic;

begin

UUT: en_4_cycles Port map ( clk_12megas=>clk_12megas,   
             reset=>reset,        
             clk_3megas=>clk_3megas,   
             en_2_cycles=>en_2_cycles,  
             en_4_cycles=>en_4);
             
clk_process:process
begin
    clk_12megas<='0';
    wait for clk_period/2;
    clk_12megas<='1';
    wait for clk_period/2;
end process;

reset<='1','0' after 1*clk_period;

end Behavioral;
