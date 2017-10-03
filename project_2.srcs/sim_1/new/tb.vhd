library ieee;
use ieee.std_logic_1164.all;

entity tb_vga is
end tb_vga;

architecture tb_vga_arch of tb_vga is


   
 component vga_ref is
       Port (  clk         : in  std_logic;
               rst         : in  std_logic;
               hs          : out std_logic;
               vs          : out std_logic;
               rgb_out     : out std_logic_vector (11 downto 0)
           );
   end component;

   signal hs,vs       : std_logic;
   signal clk,rst       : std_logic := '0';
   signal rgb_out   :  std_logic_vector (11 downto 0);
  
   
   constant period   : time := 2.5 ns;
   

   


begin  -- structural
  
  
  
    inst_vga_ref: vga_ref
    port map ( clk         => clk,
              rst         => rst,
              hs        => hs,
              vs    => vs,
              rgb_out      => rgb_out
            );


         
         
    clk <= not(clk) after period;
    rst <= '1', '0' after period*4;  



end tb_vga_arch;