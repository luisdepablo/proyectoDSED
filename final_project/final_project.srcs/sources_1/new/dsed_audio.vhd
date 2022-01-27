


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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dsed_audio is
    Port ( clk_100Mhz : in STD_LOGIC;
           reset : in STD_LOGIC;
           micro_clk : out STD_LOGIC;
           micro_data : in STD_LOGIC;
           micro_lr : out STD_LOGIC;
           jack_sd : out STD_LOGIC;
           jack_pwm : out STD_LOGIC;
                                 
           BTNR: in std_logic;
           BTNL: in std_logic;
           BTNC: in std_logic;
           SW0: in std_logic;
           SW1: in std_logic);
end dsed_audio;

architecture Behavioral of dsed_audio is

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

component fir_filter 
    Port ( 
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            sample_in : in  std_logic_vector (sample_size-1 downto 0);
            sample_in_enable : in STD_LOGIC;
            filter_select : in STD_LOGIC;
            sample_out : out  std_logic_vector (sample_size -1 downto 0);
            sample_out_ready : out STD_LOGIC);
end component;

 component blk_mem_gen_0 is
     PORT (
           clka : IN STD_LOGIC;
           ena : IN STD_LOGIC;
           wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
           addra : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
           dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
           douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
     );
   end component;

signal sample_out_ready,sample_request :std_logic:='0';
signal clk_12megas:std_logic:='1';
signal sample_in,sample_out:std_logic_vector(sample_size-1 downto 0):=(others=>'0');

signal play_enable, record_enable,sample_in_enable_filtro, filter_select, sample_out_ready_filtro: std_logic:='0';

signal ena : std_logic :='0';
signal wea : std_logic_vector(0 downto 0);
signal pointer : std_logic_vector(18 downto 0):= (others => '0');
signal escritura_reg, lectura_reg, escritura_next, lectura_next, reves_reg, reves_next : std_logic_vector(18 downto 0):= (others => '0');
signal douta : std_logic_vector(sample_size-1 downto 0);
signal sample_out_filtro,filter_in :  std_logic_vector(sample_size-1 downto 0);
    
type state_type is (IDLE, BORRAR, GRABAR, REPRODUCIR,NORMAL, AL_REVES, PASO_BAJO, PASO_ALTO);
signal state_reg, state_next : state_type;

begin

SYNC : process (clk_12megas, reset)
    begin
        if (reset = '1') then
            state_reg <= BORRAR;
            reves_reg <= (others => '0');
            escritura_reg <= (others => '0'); 
            lectura_reg <= (others => '0');
        else
            if (clk_12megas'event AND clk_12megas = '1') then
                state_reg <= state_next;
                reves_reg <= reves_next;
                escritura_reg <= escritura_next; 
                lectura_reg <= lectura_next; 
            end if;
        end if;
    end process;




OUTPUT: process (state_reg, sample_out_ready, sample_request, escritura_reg, lectura_reg, ena, douta, sample_out_filtro, reves_reg, state_next) 
    begin               
        
        wea <="1";
        ena <= '0';              
        escritura_next <= escritura_reg;
        lectura_next <= lectura_reg;
        reves_next <= reves_reg;
        pointer <= escritura_reg;
        filter_in <= (others => '0');
        sample_in_enable_filtro <= '0' ;
        filter_select <= '0';
        sample_in <=(others => '0');
        record_enable <= '0';
        play_enable <= '0';  
        
        case(state_reg) is
            when IDLE =>
                record_enable <= '0';
                play_enable <= '0';
                if (state_next = REPRODUCIR) then
                    lectura_next <= (others => '0');
                 end if;    
      
      
               
            when BORRAR =>
                escritura_next <= (others => '0');
                lectura_next <= (others => '0'); 
                record_enable <= '0';
                play_enable <= '0';   
                
                         
            when GRABAR =>
                pointer<=escritura_reg;
                ena <= sample_out_ready;
                record_enable <= '1';
                play_enable <= '0';
                wea<= "1";
                if(sample_out_ready ='1') then 
                    escritura_next<= std_logic_vector(unsigned(escritura_reg) +1);
                end if;                
           
            when REPRODUCIR =>          
             if(state_next = AL_REVES) then
                 reves_next<= escritura_reg;
             else
                lectura_next <= (others => '0');
             end if;
             
            when NORMAL =>
            pointer<=lectura_reg;
            sample_in<=douta;         
            ena<=sample_request;
            record_enable<='0';
            play_enable<='1';
            wea<="0";
            if (sample_request ='1') then
                lectura_next <= std_logic_vector(unsigned(lectura_reg) +1);
            end if;
            
            
            when AL_REVES =>
            ena<=sample_request;
            record_enable<='0';
            play_enable<='1';
            wea<="0";
            pointer<= reves_reg;
            sample_in<=douta;
            if(ena ='1') then 
                reves_next <= std_logic_vector(unsigned(reves_reg) -1);
            end if;   
            
                    
            when PASO_BAJO =>            
            filter_select<='0';
            ena<=sample_request;
            record_enable<='0';
            play_enable<='1';
            wea<="0";
            pointer<= reves_reg;
            sample_in_enable_filtro<=sample_request;
            filter_in<=(not(douta(7)& douta(6 downto 0)));
            sample_in<=std_logic_vector(not(sample_out_filtro(7))& sample_out_filtro(6 downto 0));
            pointer<=lectura_reg;
            if (sample_request ='1') then
               lectura_next <= std_logic_vector(unsigned(lectura_reg) +1);
            end if;
            
            
            when PASO_ALTO =>  
            filter_select<='1';
            ena<=sample_request;
            record_enable<='0';
            play_enable<='1';
            wea<="0";
            pointer<= reves_reg;
            sample_in_enable_filtro<=sample_request;
            filter_in<=(not(douta(7)& douta(6 downto 0)));
            sample_in<=std_logic_vector(not(sample_out_filtro(7))& sample_out_filtro(6 downto 0));
            pointer<=lectura_reg;
            if (sample_request ='1') then
               lectura_next <= std_logic_vector(unsigned(lectura_reg) +1);
            end if;            
            
            
             
         end case;
end process;   
            
                          
NEXT_STATE_LOGIC: 
 process (BTNR, BTNL, BTNC, SW0, SW1, state_reg, lectura_reg, reves_reg, escritura_reg)     
    begin
        state_next<=state_reg;
        case(state_reg) is
            when IDLE =>
                if(BTNR='0' AND BTNL='0' AND BTNC='1' ) then
                    state_next <= BORRAR;
               elsif (BTNR='0' AND BTNL='1' AND BTNC='0') then 
                    state_next <= GRABAR;
               elsif (BTNR='1' AND BTNL='0' AND BTNC='0') then
                    state_next <= REPRODUCIR;   
               else
                    state_next <= IDLE;
               end if;   
                  
                               
            when BORRAR =>
                if(BTNC = '1') then
                    state_next<= BORRAR;
                else
                    state_next<= IDLE;
                end if;
                
                
                
            when GRABAR =>
                if (BTNL ='1') then
                    state_next <= GRABAR;
                else
                    state_next<=IDLE;
                end if;            
              
              
              
            when REPRODUCIR =>
                if(SW1 = '0' and SW0 = '0') then
                    state_next<= NORMAL;
                elsif(SW1 = '0' and SW0 = '1') then
                       state_next<= AL_REVES;
                elsif(SW1 = '1' and SW0 = '0') then
                       state_next<= PASO_BAJO;
                else
                       state_next<= PASO_ALTO;
                end if;
            
            
            
            when NORMAL =>
                if(lectura_reg = escritura_reg) then
                    state_next<= IDLE;
                else
                    state_next<= NORMAL;
                    
                end if;                    
                     
                     
                       
            when AL_REVES =>
                 if(reves_reg = "0000000000000000000") then
                     state_next<= IDLE;
                 else
                     state_next<= AL_REVES;
                 end if;    
                 
                 
                 
            when PASO_BAJO =>
                  if(lectura_reg = escritura_reg) then
                       state_next<= IDLE;
                  else
                       state_next<= PASO_BAJO;
                  end if;                            
             
             
             
             when PASO_ALTO =>
                  if(lectura_reg = escritura_reg) then
                        state_next<= IDLE;
                  else
                        state_next<= PASO_ALTO;
                  end if;
                  
                  
        end case;
 end process;       
   

Clk: clk_wiz_0 port map (	clk_in1=>clk_100Mhz,
							reset=>reset,
							clk_out1=>clk_12megas);


Audio_interf: audio_interface port map(	clk_12megas=>clk_12megas,
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
								
Memoria: blk_mem_gen_0 port map(  clka => clk_12megas,
                        ena => ena,
                        wea => wea,
                        addra => pointer,
                        dina => sample_out,
                        douta => douta);
                        
                        
Filtro: fir_filter port map( clk =>clk_12megas ,
                             reset => reset, 
                             sample_in => filter_in, 
                             sample_in_enable =>sample_in_enable_filtro , 
                             filter_select => filter_select ,
                             sample_out => sample_out_filtro ,
                             sample_out_ready => sample_out_ready_filtro) ;								
								
								
end Behavioral;
