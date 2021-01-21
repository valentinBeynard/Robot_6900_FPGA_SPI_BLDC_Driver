----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2020 22:28:38
-- Design Name: 
-- Module Name: MUX_CCWseq - Behavioral
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

entity MUX_CCWseq is
    Port ( HALL : in STD_LOGIC_VECTOR (2 downto 0);
           MUX_CCWseq_out : out STD_LOGIC_VECTOR (5 downto 0));
end MUX_CCWseq;

architecture Behavioral of MUX_CCWseq is

begin

 process (HALL) -- enclencher une phase de commutation prticulière en fonction de la valeur de HALL
    
    begin
            case HALL is
               when "101" => MUX_CCWseq_out <= "100100"; -- phase 1 activée (Q1H, Q2L)
               when "001" => MUX_CCWseq_out <= "100001";
               when "011" => MUX_CCWseq_out <= "001001";
               when "010" => MUX_CCWseq_out <= "011000";
               when "110" => MUX_CCWseq_out <= "010010";
               when "100" => MUX_CCWseq_out <= "000110";
               when others => MUX_CCWseq_out <= "000000";     
            end case;    
    end process;
end Behavioral;
