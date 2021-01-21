----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2020 22:48:29
-- Design Name: 
-- Module Name: BLDC_controller - Behavioral
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

entity BLDC_controller is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           duty_cycle : in STD_LOGIC_VECTOR (6 downto 0);
           freq : in STD_LOGIC_VECTOR (6 downto 0);
           DIR : in STD_LOGIC;
           START : in STD_LOGIC;
           HALL : in STD_LOGIC_VECTOR (2 downto 0);
           --clk_HALL : in STD_LOGIC;
           --BLDC_controller_out : out STD_LOGIC_VECTOR (5 downto 0));
           clk_PWM : out STD_LOGIC;
           led0 : out STD_LOGIC;
           EN_LM : out STD_LOGIC_VECTOR (2 downto 0);
           IN_LM : out STD_LOGIC_VECTOR (2 downto 0));
end BLDC_controller;

architecture Behavioral of BLDC_controller is

COMPONENT MUX_start
    Port ( START : in STD_LOGIC;
           MUX_start_OUT : out STD_LOGIC);
end COMPONENT;

COMPONENT PWM_generator
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           freq : in STD_LOGIC_VECTOR (6 downto 0);
           duty_cycle : in STD_LOGIC_VECTOR (6 downto 0);
           clk_PWM : out STD_LOGIC;
           led0 : out STD_LOGIC;
           PWM_signal : out  STD_LOGIC );
end COMPONENT;

COMPONENT MUX_CWseq
    Port ( HALL : in STD_LOGIC_VECTOR (2 downto 0);
           MUX_CWseq_out : out  STD_LOGIC_VECTOR (5 downto 0 ));
end COMPONENT;

COMPONENT MUX_CCWseq
    Port ( HALL : in STD_LOGIC_VECTOR (2 downto 0);
           MUX_CCWseq_out : out  STD_LOGIC_VECTOR (5 downto 0 ));
end COMPONENT;

COMPONENT Multiplexor
    Port ( DIR : in STD_LOGIC;
            CW_seq : in STD_LOGIC_VECTOR (5 downto 0);
            CCW_seq : in STD_LOGIC_VECTOR (5 downto 0);
            MUX_out : out  STD_LOGIC_VECTOR (5 downto 0 ));
end COMPONENT;

COMPONENT AND_flip
    Port ( PWM_signal : in STD_LOGIC;
            START_state : in STD_LOGIC;
            MUX_out : in STD_LOGIC_VECTOR (5 downto 0);
            IN_LM : out STD_LOGIC_VECTOR (2 downto 0);
            EN_LM : out STD_LOGIC_VECTOR (2 downto 0));
end COMPONENT;

--COMPONENT Convert_LM
--   Port ( --Convert_LM_in : in  STD_LOGIC_VECTOR (5 downto 0);
--            rst : in STD_LOGIC;
--            clk_HALL : in STD_LOGIC;
--            PWM_signal : in STD_LOGIC;
--            START_state : in STD_LOGIC;
--            MUX_out : in STD_LOGIC_VECTOR (5 downto 0);
--            EN_LM : out STD_LOGIC_VECTOR (2 downto 0);
--            clk_HALL_out : out STD_LOGIC;
--            IN_LM : out STD_LOGIC_VECTOR (2 downto 0));
--end COMPONENT;

----------- SIGNAUX INTERNES AU SYSTEME ------

-- PWM_generator
signal PWM_signal : STD_LOGIC ;  --sortie

signal START_MUX_out : STD_LOGIC;


-- MUX_CWseq & CCWseq
signal MUX_CWseq_out : STD_LOGIC_VECTOR (5 downto 0);
signal MUX_CCWseq_out : STD_LOGIC_VECTOR (5 downto 0);

-- Multiplexor
signal MUX_out : STD_LOGIC_VECTOR (5 downto 0);

--AND_flip
signal START_state : STD_LOGIC; --entrée
signal AND_flip_out : STD_LOGIC_VECTOR (5 downto 0);

begin
U0 : PWM_generator PORT MAP(
        rst => rst,
        clk => clk,
        freq => freq,
        duty_cycle => duty_cycle,
        clk_PWM => clk_PWM,
        led0 => led0,
        PWM_signal => PWM_signal
        );     
        
U1 : MUX_start PORT MAP(
        START => START,
        MUX_start_OUT => START_MUX_out
        );
        
U2 : MUX_CWseq PORT MAP(
        HALL => HALL,
        MUX_CWseq_out => MUX_CWseq_out
        ); 
        
U3 : MUX_CCWseq PORT MAP(
        HALL => HALL,
        MUX_CCWseq_out => MUX_CCWseq_out
        ); 
 
        
U4 : Multiplexor PORT MAP(
        DIR => DIR,
        CW_seq => MUX_CWseq_out,
        CCW_seq => MUX_CCWseq_out,
        MUX_out => MUX_out
        ); 
        
U6 : AND_flip PORT MAP(
        PWM_signal => PWM_signal,
        START_state => START_MUX_out,
        IN_LM => IN_LM,
        MUX_out => MUX_out,
        EN_LM => EN_LM
        );                     
                       
end Behavioral;
