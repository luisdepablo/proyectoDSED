----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2021 11:23:40
-- Design Name: 
-- Module Name: fir_filter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use work.package_dsed.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fir_filter is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sample_in : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_in_enable : in STD_LOGIC;
           filter_select : in STD_LOGIC;
           sample_out : out STD_LOGIC_VECTOR (sample_size -1 downto 0);
           sample_out_ready : out STD_LOGIC);
end fir_filter;

architecture Behavioral of fir_filter is

signal R0,R1,R2 :std_logic_vector(sample_size -1 downto 0);
signal R0_next,R1_next,R2_next :std_logic_vector(sample_size -1 downto 0);
signal C0,C1,C2,C3,C4,X0,X1,X2,X3,X4:std_logic_vector (sample_size -1 downto 0);
signal X0_next,X1_next,X2_next,X3_next,X4_next :std_logic_vector (sample_size -1 downto 0);
type state_FSMD is (idle,t1,t2,t3,t4,t5,t6,t7);
signal state,state_next: state_FSMD;


signal r_out,r_out_next :std_logic_vector(sample_size -1 downto 0);
signal r_out_ready,r_out_ready_next: std_logic;

--mult
signal m_op1,m_op2,m_out :std_logic_vector(sample_size-1 downto 0);
--sum
signal s_op1,s_op2,s_out :std_logic_vector(sample_size-1 downto 0);

component mult 
    Port ( m_op1 : in std_logic_vector (sample_size -1 downto 0);
           m_op2 : in std_logic_vector (sample_size -1 downto 0);
           m_out : out std_logic_vector (sample_size -1 downto 0));
end component mult;

component sum 
    Port ( s_op1 : in std_logic_vector (sample_size-1 downto 0);
           s_op2 : in std_logic_vector (sample_size-1 downto 0);
           s_out : out std_logic_vector (sample_size-1 downto 0));
end component sum;
begin

--MULT
UUT_MULT: mult PORT MAP(m_op1=>m_op1,
						m_op2=>m_op2,
						m_out=>m_out);
					
UUT_SUM: sum PORT MAP(	s_op1=>s_op1,
						s_op2=>s_op2,
						s_out=>s_out);
					


registers: process(clk,reset)
begin
	if reset='1' then
		R0<=(others=>'0');
		R1<=(others=>'0');
		R2<=(others=>'0');
		
		X0<=(others=>'0');
		X1<=(others=>'0');
		X2<=(others=>'0');
		X3<=(others=>'0');
		X4<=(others=>'0');
		
		r_out<=(others=>'0');
		r_out_ready<='0';
		state<= idle;
	elsif rising_edge(clk) then
		R0<=R0_next;
		R1<=R1_next;
		R2<=R2_next;
		
		X0<=X0_next;
		X1<=X1_next;
		X2<=X2_next;
		X3<=X3_next;
		X4<=X4_next;
		
		r_out<=r_out_next;
		r_out_ready<=r_out_ready_next;
		state<=state_next;
	end if;
end process;

--FILTER TYPE
C0<= C0_LP WHEN filter_select='0' else C0_HP;
C1<= C1_LP WHEN filter_select='0' else C1_HP;
C2<= C2_LP WHEN filter_select='0' else C2_HP;
C3<= C3_LP WHEN filter_select='0' else C3_HP;
C4<= C4_LP WHEN filter_select='0' else C4_HP;

process(X0,X1,X2,X3,X4,sample_in,sample_in_enable)
begin
	X0_next<=X0;
	X1_next<=X1;
	X2_next<=X2;
	X3_next<=X3;
	X4_next<=X4;
	
	if sample_in_enable='1' then
		X0_next<=sample_in;
		X1_next<=X0;
		X2_next<=X1;
		X3_next<=X2;
		X4_next<=X3;
	end if;
end process;


OUTPUT_DECODE: process(state,r_out,r_out_ready,R0,R1,R2,X0,X1,X2,X3,X4,C0,C1,C2,C3,C4,m_out,s_out)
begin
	r_out_next<=r_out;
	r_out_ready_next<=r_out_ready;
	R0_next<=R0;
	R1_next<=R1;
	R2_next<=R2;
	
	m_op1<=(others=>'0');
	m_op2<=(others=>'0');
	s_op1<=(others=>'0');
	s_op2<=(others=>'0');
	case state is
		when idle => 
			r_out_ready_next<='0';
		when t1=> 
			m_op1<=C0;
			m_op2<=X0;
			R0_next<=m_out;				
		when t2=> 
			m_op1<=C1;
			m_op2<=X1;
			R0_next<=m_out;
			R1_next<=R0;				
		when t3=> 
			m_op1<=C2;       
			m_op2<=X2;
			s_op1<=R1;
			s_op1<=(others=>'0');       
			R0_next<=m_out;  
			R1_next<=R0;
			R2_next<=s_out;			
		when t4=>
			m_op1<=C3;        
			m_op2<=X3;        
			s_op1<=R1;        
			s_op2<=R2;
			R0_next<=m_out;   
			R1_next<=R0; 
			R2_next<=s_out;
		when t5=> 
			m_op1<=C4;     
			m_op2<=X4;     
			s_op1<=R1;     
			s_op2<=R2;     
			R0_next<=m_out;
			R1_next<=R0;   
			R2_next<=s_out;
		when t6=>    
			s_op1<=R1;     
			s_op2<=R2;
			R1_next<=R0;   
			R2_next<=s_out;
				
		when t7=> 
			s_op1<=R1; 
			s_op2<=R2;
			r_out_next<=s_out;
			r_out_ready_next<='1'; 		
	END CASE;
END PROCESS;

--CONTROL PATH
STATES: process(state,sample_in_enable)
begin
	state_next<=idle;
	case state is
		when idle => 
			if sample_in_enable='1' then
		     	state_next<=t1;
			end if;
		when t1=> 
			state_next<=t2;
		when t2=> 
			state_next<=t3;		
		when t3=> 
			state_next<=t4;
		when t4=> 
			state_next<=t5;	
		when t5=> 
			state_next<=t6;
		when t6=> 
			state_next<=t7;
		when t7=> 
			state_next<=idle;
	END CASE;
END PROCESS;

sample_out<=r_out;
sample_out_ready<=r_out_ready;

end Behavioral;
