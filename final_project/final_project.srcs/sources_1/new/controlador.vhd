----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2021 12:44:03
-- Design Name: 
-- Module Name: controlador - Behavioral
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

entity controlador is
    Port ( clk_100Mhz : in STD_LOGIC;
           reset : in STD_LOGIC;
           micro_clk : out STD_LOGIC;
           micro_data : in STD_LOGIC;
           micro_lr : out STD_LOGIC;
           jack_sd : out STD_LOGIC;
           jack_pwm : out STD_LOGIC);
end controlador;

architecture Behavioral of controlador is

component clk_wiz_0 
 port( 	clk_in1: in std_logic;
 		reset: in std_logic;
 		clk_out1: out std_logic);
end component;
 	
 		
 


component audio_interface 
Port ( clk_12megas :      in STD_LOGIC;        --reloj global
           reset :            in STD_LOGIC;        --reset global
          --GRABAR
          --del controlador
           record_enable :    in STD_LOGIC;        --booleano que indica si está grabando
           sample_out :       out STD_LOGIC_VECTOR(sample_size-1 downto 0); --dato de 8 bits cogido del microfono
           sample_out_ready : out STD_LOGIC;       --señal de control que da un pulso de duranción un pulso de reloj cada vez que se digitaliza un dato
          --del microfono
           micro_clk :        out STD_LOGIC;       --salida del reloj del microfono(3MHz)
           micro_data :       in STD_LOGIC;        --señal PDM del microfono
           micro_LR :         out STD_LOGIC;       --salida del microfono que dice si se toman las muetsras en el flanco de subida o de bajada (nosotros a 1)
          --REPRODUCIR
          --del controlador
           play_enable :      in STD_LOGIC;        --booleano para decir que se va a reproducir
           sample_in :        in STD_LOGIC_VECTOR(sample_size-1 downto 0);  --dato de 8 bits de la señal a reproducir
           sample_request :   out STD_LOGIC;       --señal de control que indica cuando se necesita un dato de sample_in
           --del jack
           jack_sd :          out STD_LOGIC;       --esto a 1
           jack_pwm :         out STD_LOGIC);      --señal PWM generada a partir de sample in
end component;

signal enable,sample_out_ready,sample_request :std_logic:='0';
signal clk_12megas:std_logic:='1';
signal sample:std_logic_vector(sample_size-1 downto 0):=(others=>'0');

begin

clk: clk_wiz_0 port map (	clk_in1=>clk_100Mhz,
							reset=>reset,
							clk_out1=>clk_12megas);


audio_interf: audio_interface port map(	clk_12megas=>clk_12megas,
								reset=> reset,
								record_enable=> enable,
								sample_out=>sample,
								sample_out_ready=>sample_out_ready,
								micro_clk=>micro_clk,
								micro_data=> micro_data,
								micro_lr=> micro_lr,
								play_enable=>enable,
								sample_request=>sample_request,
								sample_in=>sample,
								jack_sd=>jack_sd,
								jack_pwm=> jack_pwm);
								
enable<='1';
								
								
								
end Behavioral;
