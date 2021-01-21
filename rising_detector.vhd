----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2021 17:31:28
-- Design Name: 
-- Module Name: rising_detector - Behavioral
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

entity rising_detector is
    Port ( clk : in STD_LOGIC;
           input_clk : in STD_LOGIC;
           clk_rising : out STD_LOGIC);
end rising_detector;

architecture Behavioral of rising_detector is

signal sclk_sig : std_logic;
signal sclk_sig_1 : std_logic;


begin


	-- Process gérant la clock clk qui cadence la FSM
	process (clk) 
	begin 
	
    if(rising_edge(clk)) then
        sclk_sig <= input_clk;
        sclk_sig_1 <= sclk_sig;
    end if;

	end process;

--clk_rising <= input_clk and (not(sclk_sig));
clk_rising <= sclk_sig and (not(sclk_sig_1));

end Behavioral;
