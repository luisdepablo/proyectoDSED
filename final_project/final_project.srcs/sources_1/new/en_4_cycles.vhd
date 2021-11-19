----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2021 13:43:39
-- Design Name: 
-- Module Name: en_4_cycles - Behavioral
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
USE IEEE.NUMERIC_STD.ALL;


entity en_4_cycles is
    Port ( clk_12megas : in STD_LOGIC;
            reset : in STD_LOGIC;
            clk_3megas: out STD_LOGIC;
            en_2_cycles: out STD_LOGIC;
            en_4_cycles : out STD_LOGIC);
end en_4_cycles;

architecture Behavioral of en_4_cycles is

signal r_reg,r_next: unsigned(2 downto 0) := "000";
signal en_2_cycles_aux: std_logic;



begin

--CLK REGISTER
    process(clk_12megas,reset)
    begin
        if(reset='1') then
            r_reg<=(others=>'0');
        elsif(rising_edge(clk_12megas)) then
            r_reg<=r_next;
        end if;
    end process;
                  
--next state logic
    process(r_next,r_reg)
    begin
        if (r_reg = 1) then 
            r_next <= (others => '0');
          else     
          r_next <=  r_reg +1;   
        end if;    
    end process;
    

--output logic
process(r_next,r_reg,en_2_cycles_aux)
    begin
        if (r_reg = 1) then 
           en_2_cycles_aux <= '1';
          else     
           en_2_cycles_aux<=  '0';  
        end if;    
    end process;
en_2_cycles<= en_2_cycles_aux;


end Behavioral;
