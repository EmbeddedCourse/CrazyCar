library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity FgndBgndSel is
  Port (        
                 background_en      : in std_logic;
                 background_rgb : in STD_LOGIC_VECTOR ( 2 downto 0 );
                 foreground_rgb : in STD_LOGIC_VECTOR ( 2 downto 0 );
        --         resume_pause   : out std_logic ;
                 final_rgb      : out STD_LOGIC_VECTOR ( 2 downto 0 )

);
end FgndBgndSel;

architecture Behavioral of FgndBgndSel is

begin
       process(background_en,foreground_rgb,background_rgb)
          begin
              --addr_bram_foreground_next<=addr_bram_foreground_reg;                                
                     if background_en ='0'  then
                         final_rgb<=foreground_rgb; 
                        -- resume_pause<='1'; 
                     else
                         final_rgb<=background_rgb; 
                      --   resume_pause <='0'; 
                     end if;             
       end process;


end Behavioral;
