----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.10.2020 11:49:45
-- Design Name: 
-- Module Name: PWM_generator - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWM_generator is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           freq : in STD_LOGIC_VECTOR (6 downto 0);
           duty_cycle : in STD_LOGIC_VECTOR (6 downto 0);
           --clk_cnt_out : out integer; --utilisation pour test
           PWM_cnt_out : out integer; --utilisation pour test
           led0 : out STD_LOGIC;
           clk_PWM : out STD_LOGIC; --utilisation pour test
           PWM_signal : out STD_LOGIC
           );
end PWM_generator;


architecture Behavioral of PWM_generator is

--signaux internes
signal clk_cnt : integer range 0 to 49 := 0; --count pour créer clk à 2MHz
signal PWM_cnt : integer range 0 to 100 := 1; --count pour créer signal PMW de sortie : on commence à compter à 1
signal clk_2MHz : std_logic := '0'; --signal intermédiaire de création de clk PMW
signal PWM_out : std_logic; --signal local de creéation du signal PWM de sortie
--signal duty_cycle : std_logic_vector(6 downto 0) := "0011001";
signal duty_cycle_convert : unsigned (6 downto 0); --conversion du duty cycle voulu 
signal freq_convert : unsigned (6 downto 0); --conversion du duty cycle voulu 
begin
-- 2 PROCESS EN PARALELLE

process (clk) --creation de la clock 2Mhz à partir de la clock 100MHz
begin
    
    --freq_convert <= unsigned(freq); 
    
--    if (rst = '0') then
--        clk_cnt <= 0;
--        clk_2MHz <= '0';
--    else
        if (rising_edge(clk)) then
            if (clk_cnt = 24) then -- 49 --on veut passer d'une clk à 100M à 2M = le facteur est de 50  
                --clk_2MHz <= '1';     
                clk_2MHz <= not(clk_2MHz);
                clk_cnt <= 0;
            else
                 clk_cnt <= clk_cnt + 1;
                --clk_2MHz <= '0';     
            end if;
            

        end if;
--    end if;

end process;

-- création de la PMW en sortie en fonction du duty cycle voulu et de la freq du moteur
-- on va créer 100 créneaux de 2MHz (valeur de duty cycle de 1 = 2MHz à 100 = 20kHz = freq moteur)
process (clk_2MHz)

begin
    
--    if (rst = '0') then
--        PWM_out <= '0';
--        PWM_cnt <= 1; --initialisation à 1 car duty cycle de 1 à 100 
--    else 
        if (rising_edge(clk_2MHz)) then --sur le front montant de notre clk à 2MHz, on effectue le scrutage
            
            duty_cycle_convert <= unsigned(duty_cycle); 
            
            if (PWM_cnt <= duty_cycle_convert) then --scrutin pour obtenir le rapport cyclique voulu 
                PWM_out <= '1';
                if (PWM_cnt < 100) then  --signal PWM constitué par 100 coups de clk à 2MHz
                    PWM_cnt <= PWM_cnt + 1; -- on incrémente valeur du compteur à chaque front montant de la clk à 2MHz
                else 
                    PWM_cnt <= 1; --initialisation count
                end if;    
            else --si on a depassé notre valeur de duty cycle
                PWM_out <= '0';
                if (PWM_cnt < 100) then
                    PWM_cnt <= PWM_cnt + 1; --on continue d'incrémenter compteur pour compléter notre signal
                else
                    PWM_cnt <=1; --initialisation count
                end if;  
            end if;
        end if;   
--    end if;
    
    led0 <= '1'; 
    PWM_signal <= PWM_out;
    clk_PWM <= PWM_out;
    PWM_cnt_out <= PWM_cnt; --utilisation pour test
    
end process;

end Behavioral;
