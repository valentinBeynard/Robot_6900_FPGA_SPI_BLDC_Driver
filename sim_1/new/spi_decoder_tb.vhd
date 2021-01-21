----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2021 10:46:09
-- Design Name: 
-- Module Name: spi_decoder_tb - Behavioral
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

entity spi_decoder_tb is
  
end spi_decoder_tb;

architecture Behavioral of spi_decoder_tb is

    COMPONENT spi_decoder
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               rx_buffer : in STD_LOGIC_VECTOR (15 downto 0);
               wr_enable : in STD_LOGIC;
               tx_buffer : out STD_LOGIC_VECTOR (15 downto 0);
               rd_enable : out STD_LOGIC;
               m1_start : out STD_LOGIC;
               m1_dir : out STD_LOGIC;
               m1_duty : out STD_LOGIC_VECTOR (6 downto 0);
               m2_start : out STD_LOGIC;
               m2_dir : out STD_LOGIC;
               m2_duty : out STD_LOGIC_VECTOR (6 downto 0);
               cmd_debug_leds : out STD_LOGIC_VECTOR (3 downto 0)
               );
    end COMPONENT;

--Inputs
signal clk : std_logic := '0';
signal rst : std_logic := '0';

--Outputs
signal rx_buffer_tb : std_logic_vector(15 downto 0) := "0000100100000010";
signal wr_enable_tb : std_logic := '0';

signal tx_buffer_tb : std_logic_vector (15 downto 0) := "0000000000000000";
signal rd_enable_tb : std_logic := '0';

signal m1_start_tb : std_logic := '0';
signal m1_dir_tb : std_logic := '0';
signal m1_duty_tb : STD_LOGIC_VECTOR (6 downto 0) := "0000000";

signal m2_start_tb : std_logic := '0';
signal m2_dir_tb : std_logic := '0';
signal m2_duty_tb : STD_LOGIC_VECTOR (6 downto 0) := "0000000";


signal debug_leds_tb : STD_LOGIC_VECTOR (3 downto 0) := "0000";

-- Clock period definitions

-- Clk tick for 100MHz
constant clk_period : time := 20 ns;

begin

    utt_decoder: spi_decoder PORT MAP (
            clk => clk,
            rst => rst,
            rx_buffer => rx_buffer_tb,
            wr_enable => wr_enable_tb,
            tx_buffer => tx_buffer_tb,
            rd_enable => rd_enable_tb,
            m1_start => m1_start_tb,
            m1_dir => m1_dir_tb,
            m1_duty => m1_duty_tb,
            m2_start => m2_start_tb,
            m2_dir => m2_dir_tb,
            m2_duty => m2_duty_tb,
            cmd_debug_leds => debug_leds_tb
            );

-- 100MHz Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
-- Stimulus process
    stim_proc: process
    begin        
        -- hold reset state for 100 ns.
        wait for 300 ns;    
            
        -- insert stimulus here 
        rst <= '0';
        wr_enable_tb <= '1';
        
        wait for clk_period;
        wr_enable_tb <= '0';
        
        wait for 200 ns;
        
        rx_buffer_tb <= "0000000100000010";
        wr_enable_tb <= '1';
        
        wait for clk_period;
        wr_enable_tb <= '0';
      
        
        --    rx <= '1', '0' after 100 us, '1' after (100 + 1 * baudrate) us;
        
--        MOSI_tb <= '1', '0' after s_tick_period, '1' after 2*s_tick_period, '0' after 3*s_tick_period, '1' after 4*s_tick_period,
--        '1' after 5*s_tick_period, '0' after 6*s_tick_period, '1' after 7*s_tick_period, '0' after 8*s_tick_period, 
--        ;
        wait;
    end process;    
    
end Behavioral;
