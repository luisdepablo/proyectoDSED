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

type fsmd_state_type is (idle);
signal count : unsigned (sample_size downto 0); 
signal data_1,data_2: unsigned (sample_size-1 downto 0);
signal count_next :  unsigned (sample_size downto 0);
signal data_1_next,data_2_next : unsigned (sample_size-1 downto 0);
signal sample_next,sample : unsigned (sample_size-1 downto 0);
signal sample_ready,sample_ready_next : std_logic;
signal state_reg: fsmd_state_type:=idle;
signal first_cycle,first_cycle_next : std_logic;
begin

--state and data register
reg:process(clk_12megas,reset)
	begin
		if reset='1' then
			count<=(others=>'0');
			data_1<=(others=>'0');
			data_2<=(others=>'0');
			first_cycle<='0';
			
			sample<=(others=>'0');
			sample_ready<='0';
		elsif rising_edge(clk_12megas) then
			if enable_4_cycles='1' then
				count<=count_next;       
				data_1<=data_1_next;      
				data_2<=data_2_next;      
				first_cycle<=first_cycle_next;           
			                            
				sample<=sample_next;  
				sample_ready<=sample_ready_next;   
			end if;
		end if;
	end process;
	
fsm:process(count,data_1,data_2,first_cycle,micro_data,count_next,data_1_next,data_2_next,first_cycle_next,state_reg)
	begin
		--Default values
		count_next<=count;
		data_1_next<=data_1;   
		data_2_next<=data_2;	
		first_cycle_next<=first_cycle;
		sample_out_ready<='0';
		--sample_next<=sample;
		--sample_ready_next<='0';
		state_reg<=idle;
		
		case state_reg is
			when idle=>
				count_next<=count+1;
				if((count_next>=0 and count_next<=105) or (count_next>=0 and count_next<=105)) then					
					if micro_data='1' then	
						data_1_next<=data_1+1;
						data_1_next<=data_1+1;
					end if;
				else	
					if(count_next>=106 and count_next<=149) then
						if micro_data='1' then
							data_1_next<=data_1+1;
						end if;
						if(first_cycle='1' and count_next<=106) then	
							sample_out<=std_logic_vector(data_2_next);
							data_2_next<=(others=>'0');
							sample_out_ready<=enable_4_cycles;
						end if;
					else
						if count=299 then
							count_next<=(others=>'0');
							first_cycle_next<='1';
						end if;
						if micro_data<='1' then
							data_2_next<=data_2+1;
						end if;
						if count=256 then
							sample_out<=std_logic_vector(data_1);
							data_1_next<=(others=>'0');
							sample_out_ready<=enable_4_cycles;
						end if;
					end if;
				end if;
		end case;
	end process;
							
						
						
			
			
			
			
			
			
			
			
		
		
		
			


        
end Behavioral;