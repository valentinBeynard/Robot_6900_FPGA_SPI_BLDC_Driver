----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2020 21:32:42
-- Design Name: 
-- Module Name: MUX_start - Behavioral
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

entity MUX_start is
    Port ( START : in STD_LOGIC;
           MUX_start_OUT : out STD_LOGIC);
end MUX_start;

architecture Behavioral of MUX_start is

begin

    process(START)
    begin
        if START = '1' then
            MUX_start_OUT <= '1';
        
        else
            MUX_start_OUT <= '0';         
        end if;
    end process;
    
end Behavioral;
