-------- ADDRESS COUNTER-----------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.vga_ref_pack.all;

entity Background is
 
  Port ( 
         clk : in std_logic;
         rst : in std_logic;
         active : in std_logic ;
         not_active : in std_logic ;
	     rgb     : out std_logic_vector(2 downto 0)
        );
end Background;

architecture Behavioral of Background is

signal pixel_count_reg,pixel_count_next : std_logic_vector (18 downto 0) ;
signal green0_reg,green0_next : std_logic_vector (18 downto 0) ;
signal grey_reg,grey_next : std_logic_vector (18 downto 0) ;
signal green1_reg,green1_next : std_logic_vector (18 downto 0) ;
signal black_reg1,black_next1 : std_logic_vector (18 downto 0) ;
signal black_reg2,black_next2 : std_logic_vector (18 downto 0) ;
signal black_line_reg,black_line_next : std_logic_vector (18 downto 0) ;
signal white_line_reg,white_line_next : std_logic_vector (18 downto 0) ;

constant green_field_1      	: std_logic_vector := "0000000000011011100"; --220
constant green_field_2      	: std_logic_vector := "0000000001001111111" ; --639
constant black_strip_1      	: std_logic_vector := "0000000000011011111"; --223
constant black_strip_2      	: std_logic_vector := "0000000000110100111"; --423
constant grey_road              : std_logic_vector := "0000000000110100100"; --420	
constant vis_screen_end         : integer := 307199;			

begin
  seq : process(clk,rst)
            begin
                  if rst ='1' then
                     pixel_count_reg<=(others => '0');
                       green0_reg <= green_field_1;
                       green1_reg <= green_field_2;
                       black_reg1 <=  black_strip_1;
                       black_reg2 <=  black_strip_2;
                       grey_reg <=  grey_road;
                 elsif clk'event and clk='1' then
                     pixel_count_reg<=pixel_count_next;
                     green0_reg<=green0_next;
                     black_reg1<=black_next1;
                     grey_reg<=grey_next;
                     black_reg2<=black_next2;
                     green1_reg<=green1_next;

                 end if;
    end process;

  comb : process(active,not_active,pixel_count_reg,green0_reg,grey_reg,green1_reg,black_reg1,black_reg2)
            begin
                pixel_count_next<=pixel_count_reg;                
                green0_next<=green0_reg;
                grey_next<=grey_reg;
                green1_next<=green1_reg;
                black_next1<=black_reg1;
                black_next2<=black_reg2;
                       if active ='1' and not_active ='0' then
                           if (pixel_count_reg >= vis_screen_end ) then --307199
                                pixel_count_next<=(others => '0');
                                  green0_next <= green_field_1;
                                  green1_next <= green_field_2;
                                  black_next1 <= black_strip_1;
                                  black_next2 <= black_strip_2;
                                  grey_next <= grey_road;                                
                           else
                                pixel_count_next<=pixel_count_reg+1;
                           end if;
               
                       elsif active ='0' and not_active ='0' then                 
                           pixel_count_next<=pixel_count_reg; 
                         if (pixel_count_reg > green0_reg ) then 
                             green0_next<=green0_reg+640;
                             grey_next<=grey_reg+640;
                             green1_next<=green1_reg+640;  
                             black_next1<=black_reg1+640;
                             black_next2<=black_reg2+640;
                          end if;            
                      elsif active ='0' and not_active ='1' then
                          -- pixel_count_next<=(others => '0');
                           
                           
                             if (pixel_count_reg >= "1001010110101111111"  ) then --(307199-640)
                                 pixel_count_next<=(others => '0');
                           else                         
                            pixel_count_next<=pixel_count_reg+640;
                          end if;
                           
                           
                           
                           
                      else
                           pixel_count_next<=pixel_count_reg; 
                      end if;             
    end process;
 

                     
 bg : process(pixel_count_reg,green0_reg,grey_reg,green1_reg,black_reg1,black_reg2,active,not_active)
            begin
                 if active ='1' and not_active ='0' then
                    if (pixel_count_reg < green0_reg ) then 
                        rgb <= COLOR_GREEN;
                    elsif (pixel_count_reg < black_reg1 ) then 
                        rgb <= COLOR_BLACK;
                    elsif (pixel_count_reg < grey_reg ) then 
                        rgb <= COLOR_WHITE;
                    elsif (pixel_count_reg < black_reg2 ) then 
                        rgb <= COLOR_BLACK;
                    else
                        rgb <= COLOR_GREEN;
                    end if;
                  else
                        rgb <= COLOR_GREEN;
                 end if;
    end process;
                      
                  
end Behavioral;