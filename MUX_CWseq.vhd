----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2020 21:50:02
-- Design Name: 
-- Module Name: MUX_CWseq - Behavioral
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

entity MUX_CWseq is
    Port ( HALL : in STD_LOGIC_VECTOR (2 downto 0);
           MUX_CWseq_out : out STD_LOGIC_VECTOR (5 downto 0));
end MUX_CWseq;

architecture Behavioral of MUX_CWseq is

begin
        
    process (HALL) -- enclencher une phase de commutation prticulière en fonction de la valeur de HALL
    
    begin
        case HALL is
           when "101" => MUX_CWseq_out <= "011000"; -- phase 1 activée (Q1H, Q2L)
           when "001" => MUX_CWseq_out <= "010010"; --(Q1H, Q3L) 
           when "011" => MUX_CWseq_out <= "000110"; --(Q2H, Q3L)
           when "010" => MUX_CWseq_out <= "100100"; --(Q2H, Q1L)
           when "110" => MUX_CWseq_out <= "100001"; --(Q3H, Q1L)
           when "100" => MUX_CWseq_out <= "001001"; --(Q3H, Q2L)
           when others => MUX_CWseq_out <= "000000";     
        end case;    
    end process;
        
end Behavioral;
