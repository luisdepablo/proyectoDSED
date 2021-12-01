----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2021 12:06:01
-- Design Name: 
-- Module Name: audio_interface_tb - Behavioral
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

entity audio_interface_tb is
--  Port ( );
end audio_interface_tb;

architecture Behavioral of audio_interface_tb is

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

signal reset,record_enable,sample_out_ready,micro_clk,micro_data,micro_LR,play_enable,sample_request,jack_sd,jack_pwm :std_logic:='0';
signal clk_12megas:std_logic:='1';
signal sample_out,sample_in:std_logic_vector(sample_size-1 downto 0):=(others=>'0');
signal a,b,c: std_logic:='0';




begin

UTT: audio_interface port map(	clk_12megas=>clk_12megas,
								reset=> reset,
								record_enable=> record_enable,
								sample_out=>sample_out,
								sample_out_ready=>sample_out_ready,
								micro_clk=>micro_clk,
								micro_data=> micro_data,
								micro_lr=> micro_lr,
								play_enable=>play_enable,
								sample_request=>sample_request,
								sample_in=>sample_in,
								jack_sd=>jack_sd,
								jack_pwm=> jack_pwm);
								
clk_12megas<= not clk_12megas after clk_period/2;

reset<='1','0' after 10 ns;


a <= not a after 1300 ns;
b <= not b after 2100 ns;
c <= not c after 3700 ns;
micro_data <= a xor b xor c;

sample: process
 begin
   sample_in <= "00000000";
   wait for 50us; 
   sample_in <= "10110101";
   wait for 50us;
   sample_in <= "11111111";
   wait for 50us;
  
 end process;


enables: process
begin
   wait for 25us;
   record_enable <= '1';
   wait for 500us;
   record_enable <= '1'; 
   play_enable <= '1'; 
   wait for 500us;
   play_enable <= '0';
end process;



end Behavioral;
