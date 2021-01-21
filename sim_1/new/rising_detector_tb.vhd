----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2021 08:16:55
-- Design Name: 
-- Module Name: rising_detector_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rising_detector_tb is

end rising_detector_tb;

architecture Behavioral of rising_detector_tb is

COMPONENT rising_detector is
    Port ( clk : in STD_LOGIC;
           input_clk : in STD_LOGIC;
           clk_rising : out STD_LOGIC);
end COMPONENT;

signal clk : std_logic := '0';
signal rst : std_logic := '0';

signal input_clk_tb : std_logic := '0';
signal clk_rising_tb : std_logic := '0';

-- Clock period definitions

-- Clk tick for 100MHz
constant clk_period : time := 20 ns;

-- Clk tick for SPI 6 MHz;
constant s_tick_period : time := 166 ns;

begin

    U1_Rising_Detector: rising_detector PORT MAP( 
        clk => clk,
       input_clk => input_clk_tb,
       clk_rising => clk_rising_tb
       );
       
    -- 100MHz Clock process definitions
   clk_process :process
   begin
       clk <= '0';
       wait for clk_period/2;
       clk <= '1';
       wait for clk_period/2;
   end process;
   
   -- s_tick process definitions
   s_tick_process :process
   begin
       input_clk_tb <= '0';
       wait for (s_tick_period/2);
       input_clk_tb <= '1';
       wait for (s_tick_period/2);      
   end process;       



-- Stimulus process
    stim_proc: process
    begin        
        -- insert stimulus here 
        rst <= '1';
        
        -- hold reset state for 100 ns.
        wait for 200 ns;    
        
        -- insert stimulus here 
        rst <= '0';
        
        

        
        

      
        wait;
    end process;
    
end Behavioral;
