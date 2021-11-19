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

signal r_reg_2,r_next_2: unsigned(2 downto 0) := "000";
signal en_2_cycles_aux: std_logic;

signal r_reg_4,r_next_4: unsigned(2 downto 0) := "000";
signal en_4_cycles_aux: std_logic;

signal r_reg_3,r_next_3: unsigned(2 downto 0) := "000";
signal en_3megas: std_logic;
signal clk3_meg:std_logic:='0';



begin

--CLK REGISTER
    process(clk_12megas,reset)
    begin
        if(reset='1') then
            r_reg_2<=(others=>'0');
            r_reg_4<=(others=>'0');
            r_reg_3<=(others=>'0');
        elsif(rising_edge(clk_12megas)) then
            r_reg_2<=r_next_2;
            r_reg_4<=r_next_4;
            r_reg_3<=r_next_3;
        end if;
    end process;
                  
--next state logic
    process(r_next_2,r_reg_2)
    begin
        if (r_reg_2 = 1) then 
            r_next_2 <= (others => '0');
          else     
          r_next_2 <=  r_reg_2 +1;   
        end if;    
    end process;
    

--output logic
process(r_next_2,r_reg_2,en_2_cycles_aux)
    begin
        if (r_reg_2 = 1) then 
           en_2_cycles_aux <= '1';
          else     
           en_2_cycles_aux<=  '0';  
        end if;    
    end process;
en_2_cycles<= en_2_cycles_aux;

--CIRCUIT FOR EN_4_CICLES
--next state logic
    process(r_next_4,r_reg_4)
    begin
        if (r_reg_4 = 4) then 
            r_next_4 <= (others => '0');
          else     
          r_next_4 <=  r_reg_4 +1;   
        end if;    
    end process;
    

--output logic
process(r_next_4,r_reg_4,en_4_cycles_aux)
    begin
        if (r_reg_4 = 2) then 
           en_4_cycles_aux <= '1';
          else     
           en_4_cycles_aux<=  '0';  
        end if;    
    end process;
en_4_cycles<= en_4_cycles_aux;

--CIRCUIT FOR CLK3MHZ
--next state logic
    process(r_next_3,r_reg_3)             
    begin
                                        
        if (r_reg_3 = 3) then             
            r_next_3 <= (others => '0');
             
          else
                              
          r_next_3 <=  r_reg_3 +1;        
        end if;                           
    end process;                          

--output logic
clk_3megas<= '1' when (r_reg_3>1 and r_reg_3<=3) else '0';


end Behavioral;
