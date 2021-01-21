----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.01.2021 15:08:07
-- Design Name: 
-- Module Name: Convert_LM - Behavioral
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

entity Convert_LM is
    Port ( Convert_LM_in : in STD_LOGIC_VECTOR (5 downto 0);
           --IN_LM : out STD_LOGIC_VECTOR (2 downto 0);
           EN_LM : out STD_LOGIC_VECTOR (2 downto 0));

--    Port (  clk_HALL : in STD_LOGIC;
--            --rst : in STD_LOGIC;
--            PWM_signal : in STD_LOGIC;
--           START_state : in STD_LOGIC;
--           MUX_out : in STD_LOGIC_VECTOR (5 downto 0);
--           IN_LM : out STD_LOGIC_VECTOR (2 downto 0);
--           clk_HALL_out : out STD_LOGIC;
--           EN_LM : out STD_LOGIC_VECTOR (2 downto 0));
end Convert_LM;

architecture Behavioral of Convert_LM is

-- SIGNAUX INTERNES 
--signal MUX_out_bis : STD_LOGIC_VECTOR (5 downto 0);
--signal EN_LM_bis : STD_LOGIC_VECTOR (2 downto 0) := "000"; --EN_LM intermediaire
--signal j : integer := 0; -- signal de test indice pair ou impair


begin

--    EN_LM(0) <= Convert_LM_in(0) XOR Convert_LM_in(1);
--    EN_LM(1) <= Convert_LM_in(2) XOR Convert_LM_in(3);
--    EN_LM(2) <= Convert_LM_in(4) XOR Convert_LM_in(5);
    EN_LM(0) <= Convert_LM_in(1);
    EN_LM(1) <= Convert_LM_in(3);
    EN_LM(2) <= Convert_LM_in(5);
            

--    IN_LM(0) <= not Convert_LM_in(0);
--    IN_LM(1) <= not Convert_LM_in(2);
--    IN_LM(2) <= not Convert_LM_in(4);

--process (clk_HALL, MUX_out, rst)


--begin

--    if (rst = '1') then
--        EN_LM(0) <= '0';
--        EN_LM(1) <= '0';
--        EN_LM(2) <= '0';

--    elsif (rising_edge(clk_HALL)) then
    
--    ---- EN_LM indique si la branche (QL + QH) est activée
--        EN_LM(0) <= (MUX_out(0) XOR MUX_out(1)) AND PWM_signal AND START_state ;
--        EN_LM(1) <= (MUX_out(2) XOR MUX_out(3)) AND PWM_signal AND START_state ;
--        EN_LM(2) <= (MUX_out(4) XOR MUX_out(5)) AND PWM_signal AND START_state ;
        
--    -- IN_LM indique lequel des transistors conduit 
--    -- si QL(i) conduit, IN_LM(i) = 0 (état bas)
--    -- si QH(i) conduit, IN_LM(i) = 1 (état haut)
        
--        -- état bas indique la conduction de QL
--        if (MUX_out(0) = '1' ) then 
--            IN_LM(0) <= '0'; 
            
--        elsif (MUX_out(2) = '1') then 
--            IN_LM(1) <= '0'; 
        
--        elsif (MUX_out(4) = '1') then 
--            IN_LM(2) <= '0'; 
            
--        -- état HAUT indique la conduction de QH
--        elsif (MUX_out(0) = '0') then
--            IN_LM(0) <= '1';
            
--        elsif (MUX_out(2) = '0') then
--            IN_LM(1) <= '1';
            
--        elsif (MUX_out(4) = '0') then
--            IN_LM(2) <= '1';
      
--        end if;
--    end if;
--    clk_HALL_out <= clk_HALL;
--end process;

end Behavioral;

--    generate_EN_LM : for i in 0 to 2 generate
    
--        EN_LM(i) <= (MUX_out(i*2) XOR MUX_out((i*2)+1)) AND PWM_signal AND START_state; --test si l'un des 2 transistors de la branche à l'etat H
--        -- cad branche doit conduire, on applique le signal de PWM est appliqué sur la branche
        
--    end generate generate_EN_LM;

-- IN_LM indique lequel des transistors conduit 
-- si QL(i) conduit, IN_LM(i) = 0 (état bas)
-- si QH(i) conduit, IN_LM(i) = 1 (état haut)
  
--    generate_IN_LM : for k in 0 to 2 generate
         
--        if_QL_H : if ( MUX_out(2*k) = '1') generate --si QL à l'état H, cad QL doit conduire
--            IN_LM(k) <= '0'; --état bas indique la conduction de QL
--        end generate if_QL_H;
        
--        if_QL_L : if ( MUX_out(2*k) = '0') generate --si QL à l'état L, cad QH doit pas conduire
--            IN_LM(k) <= '1'; --état haut indique la conduction de QH
--        end generate if_QL_L;      

--    end generate generate_IN_LM;
 
    

