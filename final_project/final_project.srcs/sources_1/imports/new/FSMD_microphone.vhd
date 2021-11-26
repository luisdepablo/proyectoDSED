----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2021 10:45:34
-- Design Name: 
-- Module Name: FSMD_microphone - Behavioral
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
use work.package_dsed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSMD_microphone is
    Port ( clk_12megas : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable_4_cycles : in STD_LOGIC;
           micro_data : in STD_LOGIC;
           sample_out : out STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_out_ready : out STD_LOGIC);
end FSMD_microphone;

architecture Behavioral of FSMD_microphone is

type fsmd_state_type is (idle,inicio);
signal count, data_1,data_2: unsigned (sample_size-1 downto 0);
signal count_next, data_1_next,data_2_next : unsigned (sample_size-1 downto 0);
signal state_reg,state_next: fsmd_state_type;
signal first_cycle,first_cycle_next : std_logic;
begin

--state and data register

-- next state logic and data path functional 

    process(clk_12megas, reset,
             state_reg,state_next,
             count, data_1,data_2,first_cycle,
             count_next, data_1_next,data_2_next,first_cycle_next)
    begin
    case state_reg is        
        when idle=>
            if (reset ='1') then
                count_next<= (others=>'0');
                data_1_next<= (others=>'0');
                data_2_next<= (others=>'0');
                first_cycle_next<= (others=>'0');
                state_next<= idle;
            elsif ((count>=0 and count<= 105) or(count>=150 and count<= 255) ) then
                count_next<= count + 1;
                if(micro_data='1') then
                    data_1_next<= data_1 + 1;
                    data_2_next<= data_2 + 1;
                end if;
                state_next<= idle;
            elsif((count>=106 and count<= 149)) then
                count_next <= count + 1;
                    if (micro_data='1') then
                        data_1_next <= data_1 + 1; 
                    end if;
                    if ((first_cycle =1) and count = 106)then
                        data_2_next<= (others=>'0');
                        sample_out <= std_logic_vector(data_2);
                        --sample_out_ready <= enable_4_cycles;                   
                    else
                        sample_out_ready <='0';
                    end if;
                    state_next<= inicio;
            else
                if( micro_data='1') then
                    data_2_next <= data_2 + 1;
                end if;
                if (count =299) then
                    count_next<=(others=>'0');
                    first_cycle_next=> '1';
                    --sample_out_ready<='0';
                    state_next<= idle;
                else
                    count_next <= count + 1;
                    if(count =256) then
                        sample_out<=std_logic_vector(data_1);
                        data_1_next <= (others=>'0');
                        --sample_out_ready=> enable_4_cycles;
                    else
                        sample_out_ready<='0';
                end if;
                state_next<= idle;
                         
        end case;     
        
        
end Behavioral;
