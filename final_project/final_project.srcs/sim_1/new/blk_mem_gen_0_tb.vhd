----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2022 18:40:01
-- Design Name: 
-- Module Name: blk_mem_gen_0_tb - Behavioral
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.package_dsed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity blk_mem_gen_0_tb is
--  Port ( );
end blk_mem_gen_0_tb;

architecture Behavioral of blk_mem_gen_0_tb is

component blk_mem_gen_0
port (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;

    signal  clka : STD_LOGIC := '0' ;
    signal ena :  STD_LOGIC := '0' ;
    signal wea :  STD_LOGIC_VECTOR(0 DOWNTO 0) := "0" ;
    signal addra :  STD_LOGIC_VECTOR(18 DOWNTO 0) := (others => '0') ;
    signal dina :  STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0') ;
    signal douta :  STD_LOGIC_VECTOR(7 DOWNTO 0);
      
    constant clk_period : time := 83.3 ns;
    
begin
UUT_ram : blk_mem_gen_0
PORT MAP (
      clka   => clka,
      ena  => ena,
      wea => wea,
      addra => addra,
      dina  => dina,
      douta => douta
   );
   
CLK_proc : process
      begin
           clka <= '0';
           wait for clk_period/2;
           clka <= '1';
           wait for clk_period/2;
      end process;
      
write_read : process
         begin   
                
             ena <= '1';
             wait for 3*clk_period;
             wea <= "1";
             wait for 3*clk_period;
             dina <= "10000000";
             addra <= "0000000000000000001";
             wait for 3*clk_period;
             addra <= "0000000000000000000";
             dina <= "10101010";
             wait for 3*clk_period;
             wea <= "0";
             wait for 3*clk_period;
             addra <= "0000000000000000000";
             wait for 3*clk_period;
             addra <= "0000000000000000001";
             wait;
         end process;

end Behavioral;
