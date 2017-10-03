library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.vga_ref_pack.all;

entity vga_ref is
	Port (  clk         : in  std_logic;
		    rst         : in  std_logic;
		    start_frmMB : in std_logic;
		    hs          : out std_logic;
		    vs          : out std_logic;
		    rgb_out     : out std_logic_vector (11 downto 0)
		 --   wren        : in std_logic;
         --   waddr       : in STD_LOGIC_VECTOR (1 downto 0);
          --  wdata       : in STD_LOGIC_VECTOR (31 downto 0);
          --  rden        : in STD_LOGIC;
          --  raddr       : in STD_LOGIC_VECTOR (1 downto 0)
		  );
end vga_ref;

architecture Behavioral of vga_ref is


component BramForeground is  port (
         clk : in STD_LOGIC;
         rst : in STD_LOGIC;
  	     hcount      : in std_logic_vector(10 downto 0);
         vcount      : in std_logic_vector(10 downto 0);
         foreground_rgb : out STD_LOGIC_VECTOR ( 2 downto 0 );
         background_en : out std_logic;
         BRAM_FOREGROUND_en : in STD_LOGIC;
         BRAM_FOREGROUND_we : in STD_LOGIC_VECTOR ( 0 to 0 )
);
end component;
component Background is
 
  Port ( 
         clk : in std_logic;
         rst : in std_logic;
         active : in std_logic ;
         not_active : in std_logic ;
	     rgb     : out std_logic_vector(2 downto 0)
        );
end component;

component clk_wrapper is
  port (
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    locked : out STD_LOGIC;
    reset : in STD_LOGIC
  );
end component;
  
component vga_controller_640_60 is
      port ( rst       : in  std_logic; 
             pixel_clk : in  std_logic; 
             HS        : out std_logic; 
             active        : out std_logic; 
             not_active        : out std_logic; 
             VS        : out std_logic; 
             blank     : out std_logic; 
             hcount    : out std_logic_vector(10 downto 0); 
             vcount    : out std_logic_vector(10 downto 0)
			  );
end component;
	
component FgndBgndSel is
     Port (        
                    background_en      : in std_logic;
                    background_rgb : in STD_LOGIC_VECTOR ( 2 downto 0 );
                    foreground_rgb : in STD_LOGIC_VECTOR ( 2 downto 0 );
               --     resume_pause   : out std_logic ;
                    final_rgb      : out STD_LOGIC_VECTOR ( 2 downto 0 )
   
   );
end component;
	
	
	-- General signals
	signal clk_sys	: std_logic; 
	signal clk_locked, rst_sys : std_logic;
	
	-- VGA module
	signal blank : std_logic;
	signal hcount,vcount : std_logic_vector(10 downto 0);
	
	signal background_en : std_logic;
	signal rgb,rgb_ram      : std_logic_vector(2 downto 0);
	signal active, not_active : std_logic;


    --foreground vs background
    signal foreground_rgb :  STD_LOGIC_VECTOR ( 2 downto 0 );
    signal background_rgb :  STD_LOGIC_VECTOR ( 2 downto 0 );

begin 

	rst_sys <= rst;
	
	-- Replicate the r g and b signals for nexys 4 board

	rgb_out(3)  <= rgb(0);
    rgb_out(2)  <= rgb(0);
	rgb_out(1)  <= rgb(0);
	rgb_out(0)  <= rgb(0);

	rgb_out(7)  <= rgb(1);
    rgb_out(6)  <= rgb(1);
	rgb_out(5)  <= rgb(1);
	rgb_out(4)  <= rgb(1);


	rgb_out(11)  <= rgb(2);
    rgb_out(10)  <= rgb(2);
	rgb_out(9)  <= rgb(2);
	rgb_out(8)  <= rgb(2);	



	Inst_BramForeground: BramForeground
	port map (   clk  	=> clk_sys,
				 rst     => rst,
		     	 hcount     => hcount,
				 vcount     => vcount,
                 background_en		=> background_en,
				 BRAM_FOREGROUND_en     => '1',
				 BRAM_FOREGROUND_we     => "0",
				 foreground_rgb     => foreground_rgb);
				 
				 
	Inst_FgndBgndSel: FgndBgndSel
	port map (   background_en  	=> background_en,
				 background_rgb     => background_rgb,
				 foreground_rgb     => foreground_rgb,
				 final_rgb     => rgb_ram);
       
	
	Inst_clock_gen:
	clk_wrapper
	port map (   clk_in1  	=> clk,
				 clk_out1 	=> clk_sys,			-- Don't touch! active high reset
				 reset    	=> rst,		-- Divided 50MHz input clock
				 locked     => clk_locked
				);
				
                      
	vgactrl640_60 : vga_controller_640_60
            port map ( pixel_clk => clk_sys,
                       rst			=> rst_sys,
                       blank		=> blank,
                       hcount		=> hcount,
                       hs			=> hs,
                       active => active,
                       not_active => not_active,
                       vcount		=> vcount,
                       vs			=> vs
                       );

                  
                             
	Inst_background : Background
                  port map  ( 
                       clk			=> clk_sys,
                       rst			=> rst_sys,
                       active		=> active,
                       not_active => not_active,
                       rgb => background_rgb
                             );        
 
                       
     picture_display:process (clk_sys)
                 begin
                  if clk_sys = '1' and clk_sys'event then
                 --   if blank = '1' then
                    if blank = '1' or start_frmMB = '0' then
                                rgb <= (others => '0');  -- Have to be zeros during the blank period
                    else
                                rgb <= rgb_ram;   -- Background color                                        
                    end if;
                   end if;

                 end process;
                                                       
end Behavioral;
