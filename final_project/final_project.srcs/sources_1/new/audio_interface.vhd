----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2021 11:47:04
-- Design Name: 
-- Module Name: audio_interface - Behavioral
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

entity audio_interface is
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
end audio_interface;

architecture Behavioral of audio_interface is

signal en_4,en_2,en_PWM,en_FSMD: std_logic;

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

component pwm is
        Port ( clk_12megas : in STD_LOGIC;
               reset : in STD_LOGIC;
               en_2_cycles : in STD_LOGIC;
               sample_in : in STD_LOGIC_VECTOR(sample_size - 1 downto 0);
               sample_request : out STD_LOGIC;
               pwm_pulse : out STD_LOGIC);
end component;



begin

FSMD:FSMD_microphone port map( clk_12megas=>clk_12megas,
             reset=>reset,        
             enable_4_cycles=>en_FSMD,                   
             micro_data=>micro_data,                 
             sample_out=>sample_out,
             sample_out_ready=>sample_out_ready); 
             
enable_generator: en_4_cycles Port map ( clk_12megas=>clk_12megas,   
             reset=>reset,        
             clk_3megas=>micro_clk,   
             en_2_cycles=>en_2,  
             en_4_cycles=>en_4);


   
                          

U_pwm: pwm port map(
    clk_12megas => clk_12megas,
    reset => reset,
    en_2_cycles => en_PWM,
    sample_in => sample_in,
    sample_request => sample_request,
    pwm_pulse => jack_pwm
);



en_PWM<=en_2 and play_enable;
en_FSMD<=en_4 and record_enable;   

jack_sd<='1';
micro_LR<='0';                       


end Behavioral;
