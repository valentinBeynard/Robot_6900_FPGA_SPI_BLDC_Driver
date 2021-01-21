----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2020 15:56:06
-- Design Name: 
-- Module Name: Multiplexor - Behavioral
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

entity Multiplexor is
    Port ( DIR : in STD_LOGIC;
           CW_seq : in STD_LOGIC_VECTOR (5 downto 0);
           CCW_seq : in STD_LOGIC_VECTOR (5 downto 0);
           MUX_out : out STD_LOGIC_VECTOR (5 downto 0));
end Multiplexor;

architecture Behavioral of Multiplexor is
begin
    process(DIR,CW_seq,CCW_seq)
    begin
        case DIR is
            when '0' => MUX_out <= CW_seq;
            when others => MUX_out <= CCW_seq;
        end case;
    end process;

end Behavioral;
