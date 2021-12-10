----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2021 11:18:35
-- Design Name: 
-- Module Name: controlador_tb - Behavioral
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

entity controlador_tb is
--  Port ( );
end controlador_tb;

architecture Behavioral of controlador_tb is

component controlador 
    Port ( clk_100Mhz : in STD_LOGIC;
           reset : in STD_LOGIC;
           micro_clk : out STD_LOGIC;
           micro_data : in STD_LOGIC;
           micro_lr : out STD_LOGIC;
           jack_sd : out STD_LOGIC;
           jack_pwm : out STD_LOGIC);
end component;

signal micro_clk,reset,micro_data,micro_lr,jack_sd,jack_pwm :std_logic:='0';
signal clk_100Mhz:std_logic:='1';

signal a,b,c: std_logic:='0';


begin

control: controlador Port map ( clk_100Mhz =>clk_100Mhz,
           reset=> reset,
           micro_clk=>micro_clk, 
           micro_data=>micro_data, 
           micro_lr=>micro_lr,
           jack_sd=>jack_sd, 
           jack_pwm=>jack_pwm );

clk_100Mhz<= not clk_100Mhz after clk_100Mhz_period/2;

reset<='1','0' after 10 ns;


a <= not a after 1300 ns;
b <= not b after 2100 ns;
c <= not c after 3700 ns;
micro_data <= a xor b xor c;







end Behavioral;
