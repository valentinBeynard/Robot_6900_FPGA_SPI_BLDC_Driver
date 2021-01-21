----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2021 10:51:53
-- Design Name: 
-- Module Name: HALL_Generator - Behavioral
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

entity HALL_Generator is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           HALL_in : in STD_LOGIC_VECTOR (2 downto 0);
           --clk_cnt_out : out integer; --test
           --led0 : out STD_LOGIC;    --utilisation pour test
           HALL_out : out STD_LOGIC_VECTOR (2 downto 0);
           clk_HALL : out STD_LOGIC);  --utilisation pour test
end HALL_Generator;

architecture Behavioral of HALL_Generator is

--signaux internes
signal clk_cnt : integer := 0; --count pour créer clk à 5kHz
signal clk_5kHz : std_logic := '0'; --signal intermédiaire de création de clk HALL
signal HALL_o : std_logic_vector (2 downto 0) := "000";
--signal HALL_i : std_logic_vector (2 downto 0) := "000";

begin
-- 2 PROCESS EN PARALLELE
     
    process (clk,rst) --creation de la clock 5khz à partir de la clock 100MHz
    
    begin
    
        --led0 <= '1'; 
    
        if (rst = '1') then
            clk_cnt <= 0;
            clk_5kHz <= '0';
        
        elsif (rising_edge(clk)) then
            clk_cnt <= clk_cnt + 1;
            if (clk_cnt = 19999) then -- on veut passer d'une clk à 100M à 5k : compter jusqu'à 20k
                clk_5kHz <= '1';
                clk_cnt <= 0;
            else
                clk_5kHz <= '0';
            end if;
        end if;
        clk_HALL <= clk_5kHz; --clk à 2MHz, à utiliser pour test
        --clk_cnt_out <= clk_cnt; --utilisation pour test
    end process;

    process (clk_5kHz, rst, HALL_in) -- génération des signaux HALL à 1 freq de 5kHz
    begin 
    
        if (rst = '1') then
            HALL_o <= "000";
            
        elsif (rising_edge(clk_5kHz)) then --on change de phase, cad de valeur de HALL_out en fonction de celle de HALL_in
            case HALL_in is
                when "101" => HALL_o <= "001"; --passage de la phase 1 à 2
                when "001" => HALL_o <= "011";
                when "011" => HALL_o <= "010";
                when "010" => HALL_o <= "110";
                when "110" => HALL_o <= "100";
                when "100" => HALL_o <= "101";
                when others => HALL_o <= "000";
           end case;
         --IL ME FAUT COPIER LA VALEUR DE HALL_OUT DANS HALL-IN (BUFFER NEEDED ???) AFIN 
         --QU'AU PROCHAIN PASSAGE DANS LA BOUCLE, ON EST ENSUITE UN CHANGEMENT DE VALEUR
       end if;
       HALL_out <= HALL_o;
    end process;


end Behavioral;
