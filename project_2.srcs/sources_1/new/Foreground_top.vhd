

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity BramForeground is  port (
         clk : in STD_LOGIC;
         rst : in STD_LOGIC;
  	     hcount      : in std_logic_vector(10 downto 0);
         vcount      : in std_logic_vector(10 downto 0);
         foreground_rgb : out STD_LOGIC_VECTOR ( 2 downto 0 );
         background_en : out std_logic;
         BRAM_FOREGROUND_en : in STD_LOGIC;
         BRAM_FOREGROUND_we : in STD_LOGIC_VECTOR ( 0 to 0 )
);
end BramForeground;



architecture Behavioral of BramForeground is




component Address_counter_Foreground is
  Port ( 
         clk : in std_logic;
         rst : in std_logic;
	     hcount      : in std_logic_vector(10 downto 0);
         vcount      : in std_logic_vector(10 downto 0);
         fgd_rgb_tocount : in STD_LOGIC_VECTOR ( 2 downto 0 );
         background_en : out std_logic;
         addr_bram_foreground : out std_logic_vector (12 downto 0) 
        );
end component;

component ForegroundBRAM_wrapper is
  port (
    BRAM_PORTA_addr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    BRAM_PORTA_clk : in STD_LOGIC;
    BRAM_PORTA_din : in STD_LOGIC_VECTOR ( 2 downto 0 );
    BRAM_PORTA_dout : out STD_LOGIC_VECTOR ( 2 downto 0 );
    BRAM_PORTA_en : in STD_LOGIC;
    BRAM_PORTA_we : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end component;





     --signals
        signal addr_bram_foreground :  std_logic_vector (12 downto 0) ;
        signal rgb_bram_tocount :  STD_LOGIC_VECTOR ( 2 downto 0 );

begin


    Inst_Address_counter_Foreground : Address_counter_Foreground
    Port map ( 
           clk=>clk,           
           rst=>rst,
           hcount=>hcount,
           vcount=>vcount,          
           fgd_rgb_tocount => rgb_bram_tocount, 
           background_en=>background_en,
           addr_bram_foreground=>addr_bram_foreground
          );
          
    Inst_BRAMforForeground_wrapper : ForegroundBRAM_wrapper
              Port map ( 
                     BRAM_PORTA_addr=>addr_bram_foreground,
                     BRAM_PORTA_clk=>clk,
                     BRAM_PORTA_din=>(others => '0'),
                     BRAM_PORTA_dout=>rgb_bram_tocount,
                     BRAM_PORTA_en=>BRAM_FOREGROUND_en,
                     BRAM_PORTA_we=>BRAM_FOREGROUND_we
                    );   
   foreground_rgb <= rgb_bram_tocount;
end Behavioral;
