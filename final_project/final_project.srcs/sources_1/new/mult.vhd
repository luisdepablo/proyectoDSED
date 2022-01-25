----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2022 19:33:02
-- Design Name: 
-- Module Name: mult - Behavioral
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

entity mult is
    Port ( m_op1 : in std_logic_vector (sample_size -1 downto 0);
           m_op2 : in std_logic_vector (sample_size -1 downto 0);
           m_out : out std_logic_vector (sample_size -1 downto 0));
end mult;



architecture Behavioral of mult is
signal mult: std_logic_vector (2*sample_size-1 downto 0);

begin

mult<=std_logic_vector(signed(m_op1)*signed(m_op2));

m_out<=mult(2*sample_size -2 downto sample_size-1);



end Behavioral;
