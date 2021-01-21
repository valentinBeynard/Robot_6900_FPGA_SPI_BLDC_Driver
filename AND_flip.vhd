-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2020 19:53:58
-- Design Name: 
-- Module Name: AND - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AND_flip is
    Port ( PWM_signal : in STD_LOGIC;
           START_state : in STD_LOGIC;
           MUX_out : in STD_LOGIC_VECTOR (5 downto 0);
           IN_LM : out STD_LOGIC_VECTOR (2 downto 0);
           EN_LM : out STD_LOGIC_VECTOR (2 downto 0));
end AND_flip;

architecture Behavioral of AND_flip is

--signal EN_reg : std_logic_vector (2 downto 0) := "000";

begin
    
    EN_LM(0) <= (MUX_out(0) AND PWM_signal AND START_state AND NOT(MUX_out(1))) OR MUX_out(1);
    EN_LM(1) <= (MUX_out(2) AND PWM_signal AND START_state AND NOT(MUX_out(3))) OR MUX_out(3);
    EN_LM(2) <= (MUX_out(4) AND PWM_signal AND START_state AND NOT(MUX_out(5))) OR MUX_out(5);

--    EN_LM(0) <= (MUX_out(0) AND PWM_signal AND NOT(MUX_out(1))) OR MUX_out(1);
--    EN_LM(1) <= (MUX_out(2) AND PWM_signal AND NOT(MUX_out(3))) OR MUX_out(3);
--    EN_LM(2) <= (MUX_out(4) AND PWM_signal AND NOT(MUX_out(5))) OR MUX_out(5);
    
    -- Driver INs
    IN_LM(0) <= NOT MUX_out(0);
    IN_LM(1) <= NOT MUX_out(2);
    IN_LM(2) <= NOT MUX_out(4);

end Behavioral;

