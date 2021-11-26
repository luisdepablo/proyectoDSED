----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2021 11:50:41
-- Design Name: 
-- Module Name: FSM_microphone_tb - Behavioral
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

entity FSMD_microphone_tb is
--  Port ( );
end FSMD_microphone_tb;

architecture Behavioral of FSM_microphone_tb is

component FSMD_microphone 
    Port ( clk_12megas : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable_4_cycles : in STD_LOGIC;
           micro_data : in STD_LOGIC;
           sample_out : out STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_out_ready : out STD_LOGIC);
end component;

component en_4_cycles                    
    Port ( clk_12megas : in STD_LOGIC;   
            reset : in STD_LOGIC;        
            clk_3megas: out STD_LOGIC;   
            en_2_cycles: out STD_LOGIC;  
            en_4_cycles : out STD_LOGIC);
end component en_4_cycles;         

begin


DUT:FSMD_microphone port map(

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
                               

end Behavioral;
