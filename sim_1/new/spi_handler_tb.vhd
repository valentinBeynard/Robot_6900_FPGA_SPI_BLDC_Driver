----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2021 14:44:40
-- Design Name: 
-- Module Name: spi_handler_tb - Behavioral
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

entity spi_handler_tb is
--  Port ( );
end spi_handler_tb;

architecture Behavioral of spi_handler_tb is

COMPONENT spi_handler is
    Port ( clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       ssel : in STD_LOGIC;
       sclk : in STD_LOGIC;
       MOSI : in STD_LOGIC;
       MISO : out STD_LOGIC;
       m1_start : out STD_LOGIC;
       m1_dir : out STD_LOGIC;
       m1_duty : out STD_LOGIC_VECTOR (6 downto 0);
       m2_start : out STD_LOGIC;
       m2_dir : out STD_LOGIC;
       m2_duty : out STD_LOGIC_VECTOR (6 downto 0);
       cmd_debug_leds : out STD_LOGIC_VECTOR (3 downto 0);
       led_test : out STD_LOGIC
       );
end COMPONENT;

--Inputs
signal clk : std_logic := '0';
signal rst : std_logic := '0';

signal MOSI_tb : std_logic := '0';
signal ssel_tb : std_logic := '1';
signal sclk_tb : std_logic := '0';

--Outputs
signal m1_start_tb : std_logic := '0';
signal m1_dir_tb : std_logic := '0';
signal m1_duty_tb : STD_LOGIC_VECTOR (6 downto 0) := "0000000";

signal m2_start_tb : std_logic := '0';
signal m2_dir_tb : std_logic := '0';
signal m2_duty_tb : STD_LOGIC_VECTOR (6 downto 0) := "0000000";

signal debug_leds_tb : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal led_test_tb : std_logic := '1';

signal MISO_tb : std_logic := '0';

signal MOSI_buff : std_logic_vector (15 downto 0) := "0100000010010000"; --"0000100100000010";
signal i : INTEGER range 0 to 15 := 0;


-- Clock period definitions

-- Clk tick for 100MHz
constant clk_period : time := 20 ns;

-- Clk tick for SPI 6 MHz;
constant s_tick_period : time := 166 ns;

begin
    U1_SPI_Handler: spi_handler PORT MAP( 
        clk => clk,
       rst => rst,
       ssel => ssel_tb,
       sclk => sclk_tb,
       MOSI => MOSI_tb,
       MISO => MISO_tb,
       m1_start => m1_start_tb,
       m1_dir => m1_dir_tb,
       m1_duty => m1_duty_tb,
       m2_start => m2_start_tb,
       m2_dir => m2_dir_tb,
       m2_duty => m2_duty_tb,
       cmd_debug_leds => debug_leds_tb,
       led_test => led_test_tb
       );

-- 100MHz Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    s_tick_process :process
    begin
        if(ssel_tb = '0') then
            MOSI_tb <= MOSI_buff(i);
            sclk_tb <= '0';
            wait for (s_tick_period/2);
            if(i >= 15) then
                i <= 0;
            else
                i <= i + 1;
            end if;
            sclk_tb <= '1';
            wait for (s_tick_period/2);
        else
            wait for 1 ns;
            i <= 0; 
        end if;
    end process;
-- Stimulus process
    stim_proc: process
    begin        
        -- hold reset state for 100 ns.
        wait for 200 ns;    
        
        wait for clk_period*10;
        
        -- insert stimulus here 
        rst <= '1';
        ssel_tb <= '1';
        
        led_test_tb <= '1';
        
        -- Start SPI frame after 1us
        -- ##########################################################
        wait for 1 us;
        ssel_tb <= '0';
        
        -- Wait for SPI transmission to happen
        wait for 16*s_tick_period;
        -- Wait one more half_period 
        wait for s_tick_period/2;
        -- Stop SPI transmission
        ssel_tb <= '1';
        
        wait for 200 ns;
        
        MOSI_buff <= "0000000010010000";
        
        -- Start SPI frame after 1us
        -- ##########################################################
        wait for 1 us;
        ssel_tb <= '0';
        
        -- Wait for SPI transmission to happen
        wait for 16*s_tick_period;
        -- Wait one more half_period 
        wait for s_tick_period/2;
        -- Stop SPI transmission
        ssel_tb <= '1';
      
        wait for 200 ns;
                
        MOSI_buff <= "0100000010000000";
        
        -- Start SPI frame after 1us
        -- ##########################################################
        wait for 1 us;
        ssel_tb <= '0';
        
        -- Wait for SPI transmission to happen
        wait for 16*s_tick_period;
        -- Wait one more half_period 
        wait for s_tick_period/2;
        -- Stop SPI transmission
        ssel_tb <= '1';
      
        wait for 200 ns;
                
        MOSI_buff <= "0101110011100000";
        
                -- Start SPI frame after 1us
        -- ##########################################################
        wait for 1 us;
        ssel_tb <= '0';
        
        -- Wait for SPI transmission to happen
        wait for 16*s_tick_period;
        -- Wait one more half_period 
        wait for s_tick_period/2;
        -- Stop SPI transmission
        ssel_tb <= '1';
      
        wait for 200 ns;
      
        wait;
    end process;    

end Behavioral;
