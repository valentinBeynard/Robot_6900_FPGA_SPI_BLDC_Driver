----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2021 11:06:38
-- Design Name: 
-- Module Name: HALL_Generator_and_BLDC_Controller - Behavioral
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

entity HALL_Generator_and_BLDC_Controller is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           freq : in STD_LOGIC_VECTOR (6 downto 0);
           duty_cycle : in STD_LOGIC_VECTOR (6 downto 0);
           START : in STD_LOGIC;
           DIR : in STD_LOGIC;
           HALL_in : in STD_LOGIC_VECTOR (2 downto 0);
           clk_PWM : out STD_LOGIC;
           clk_HALL_out : out STD_LOGIC;
           led0 : out STD_LOGIC;
           IN_LM : out STD_LOGIC_VECTOR (2 downto 0);
           EN_LM : out STD_LOGIC_VECTOR (2 downto 0));
end HALL_Generator_and_BLDC_Controller;

architecture Behavioral of HALL_Generator_and_BLDC_Controller is

COMPONENT BLDC_controller
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           duty_cycle : in STD_LOGIC_VECTOR (6 downto 0);
           freq : in STD_LOGIC_VECTOR (6 downto 0);
           DIR : in STD_LOGIC;
           START : in STD_LOGIC;
           HALL : in STD_LOGIC_VECTOR (2 downto 0);
           clk_HALL : in STD_LOGIC;
           --BLDC_controller_out : out STD_LOGIC_VECTOR (5 downto 0));
           clk_PWM : out STD_LOGIC;
           clk_HALL_out : out STD_LOGIC;
           led0 : out STD_LOGIC;
           EN_LM : out STD_LOGIC_VECTOR (2 downto 0);
           IN_LM : out STD_LOGIC_VECTOR (2 downto 0));
end COMPONENT;

COMPONENT HALL_Generator
Port ( clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       HALL_in : in STD_LOGIC_VECTOR (2 downto 0);
       --led0 : out STD_LOGIC;    --utilisation pour test
       HALL_out : out STD_LOGIC_VECTOR (2 downto 0);
       clk_HALL : out STD_LOGIC);  --utilisation pour test
end COMPONENT;

----------- SIGNAUX INTERNES AU SYSTEME ------

-- BLDC_Controller
signal HALL_out : STD_LOGIC_VECTOR (2 downto 0);
signal clk_HALL : STD_LOGIC;

begin

U10 : HALL_Generator 
    Port Map( clk => clk,
            rst => rst,
            HALL_in => HALL_in,
            HALL_out => HALL_out,
            clk_HALL => clk_HALL);

U11 : BLDC_controller
Port Map( clk => clk,
        rst => rst,
        duty_cycle => duty_cycle,
        freq => freq,
        DIR => DIR,
        HALL => HALL_out,
        clk_HALL => clk_HALL,
        START => START,
        clk_PWM => clk_PWM,
        clk_HALL_out => clk_HALL_out,
        led0 => led0,
        EN_LM => EN_LM,
        IN_LM => IN_LM);


end Behavioral;
