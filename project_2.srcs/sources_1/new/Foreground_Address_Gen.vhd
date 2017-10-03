------- ADDRESS COUNTER FOREGROUND-----------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use ieee.numeric_std.all;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

entity Address_counter_Foreground is
  Port ( 
         clk : in std_logic;
         rst : in std_logic;
	     hcount      : in std_logic_vector(10 downto 0);
         vcount      : in std_logic_vector(10 downto 0);
         fgd_rgb_tocount : in STD_LOGIC_VECTOR ( 2 downto 0 );
         background_en : out std_logic;
         addr_bram_foreground : out std_logic_vector (12 downto 0) 
        );
end Address_counter_foreground;



architecture Behavioral of Address_counter_foreground is

signal address_count_reg,address_count_next : std_logic_vector (12 downto 0) ;
signal background_en_reg,background_en_next : std_logic ;
constant vcount_con_start      	: integer := 420;	
constant vcount_con_stop      	: integer := 500;			
constant hcount_con_start       : integer := 280;            
constant hcount_con_stop        : integer := 360; 



constant COLOR_WHITE			: std_logic_vector(2 downto 0) := "111";      

           
constant fgd_car_size           : integer := 6400;            

begin




  seq : process(clk,rst)
            begin
                  if rst ='1' then
                     address_count_reg<=(others => '0');
                     background_en_reg<='1';
                 elsif clk'event and clk='1' then
                     address_count_reg<=address_count_next;
                     background_en_reg<=background_en_next;
                 end if;
    end process;

  comb : process(address_count_reg,background_en_reg,hcount,vcount)
            begin
                address_count_next<=address_count_reg;                
                background_en_next <=  background_en_reg;
                           if (address_count_reg >= fgd_car_size ) then
                                address_count_next<=(others => '0');
                          else      
                                if (hcount >= hcount_con_start and hcount < hcount_con_stop and  vcount >= hcount_con_start and  vcount < hcount_con_stop) then 
                                         background_en_next <=  '0';            
                                         address_count_next <= address_count_reg+1;
                                        --HERE THE IF ABOUT THE COLOUR
                                        if (fgd_rgb_tocount = COLOR_WHITE) then
                                            background_en_next <=  '1';
                                        else
                                            background_en_next <=  '0';
                                        end if;        
                                        
                                else
                                        background_en_next <=  '1';
                                        address_count_next <= address_count_reg;
                                 end if;            
                                                         
                            end if;
                                        
    end process;
                
 addr_bram_foreground<=address_count_reg;                   
 background_en<=background_en_reg;                   
                                  
                  
end Behavioral;