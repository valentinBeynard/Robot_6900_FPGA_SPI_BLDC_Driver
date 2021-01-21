----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.01.2021 15:18:47
-- Design Name: 
-- Module Name: spi_rx_tb - Behavioral
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

entity spi_rx_tb is
--  Port ( );
end spi_rx_tb;

architecture Behavioral of spi_rx_tb is

    COMPONENT spi_rx
    Port( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ssel : in STD_LOGIC;
           sclk : in STD_LOGIC;
           MOSI : in STD_LOGIC;
           rx_buffer : out STD_LOGIC_VECTOR (15 downto 0);
           wr_enable : out STD_LOGIC
          );
    end COMPONENT;

--Inputs

signal clk : std_logic := '0';

signal rst : std_logic := '0';

signal ssel_tb : std_logic := '1';
signal sclk_tb : std_logic := '0';
signal MOSI_tb : std_logic := '0';



--Outputs
signal rx_buffer_tb : std_logic_vector(15 downto 0);
signal wr_enable_tb : std_logic := '0';

signal MISO_buff : std_logic_vector (15 downto 0) := "1010110001101011";
signal i : INTEGER range 0 to 15 := 0;


-- Clock period definitions

-- Clk tick for 100MHz
constant clk_period : time := 20 ns;

-- Clk tick for SPI 6 MHz;
constant s_tick_period : time := 166 ns;
--constant s_tick_period : time := 500 ns;

constant baudrate : time := 104 us;


begin

-- Instantiate the Unit Under Test (UUT)
   uut: spi_rx PORT MAP (
          clk => clk,
              rst => rst,
              ssel => ssel_tb,
              sclk => sclk_tb,
              MOSI => MOSI_tb,
              rx_buffer => rx_buffer_tb,
              wr_enable => wr_enable_tb
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
            MOSI_tb <= MISO_buff(i);
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
        end if;
    end process;

--    -- s_tick process definitions
--    s_tick_process :process
--    begin
--        sclk_tb <= '1' and not(ssel_tb);
--        wait for (s_tick_period/2);
--        sclk_tb <= '0' and not(ssel_tb);
--        wait for (s_tick_period/2);      
--    end process;
    
        
--    -- MOSI process definitions
--    MOSI_process :process
--    begin
--        wait for (s_tick_period);
--        if(ssel_tb = '0') then
--            if(i >= 15) then
--                i <= 0;
--            else
--                i <= i + 1;
--            end if;
--        else
--            wait for 20 ns; 
--        end if;
--        MOSI_tb <= MISO_buff(i);   
--    end process;
    
    -- Stimulus process
    stim_proc: process
    begin        
        -- hold reset state for 100 ns.
        wait for 200 ns;    
        
        wait for clk_period*10;
        
        -- insert stimulus here 
        rst <= '0';
        ssel_tb <= '1';
        
        wait for 1 us;
        
        ssel_tb <= '0';
        
        wait for 17*s_tick_period;
        
        ssel_tb <= '1';
        --    rx <= '1', '0' after 100 us, '1' after (100 + 1 * baudrate) us;
        
--        MOSI_tb <= '1', '0' after s_tick_period, '1' after 2*s_tick_period, '0' after 3*s_tick_period, '1' after 4*s_tick_period,
--        '1' after 5*s_tick_period, '0' after 6*s_tick_period, '1' after 7*s_tick_period, '0' after 8*s_tick_period, 
--        ;
        wait;
    end process;

   
end Behavioral;
