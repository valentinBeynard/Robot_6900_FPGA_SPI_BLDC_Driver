----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2021 08:25:24
-- Design Name: 
-- Module Name: spi_tx_tb - Behavioral
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

entity spi_tx_tb is
--  Port ( );
end spi_tx_tb;

architecture Behavioral of spi_tx_tb is

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
    
COMPONENT spi_tx
    Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               ssel : in STD_LOGIC;
               sclk : in STD_LOGIC;
               MISO : out STD_LOGIC;
               tx_buffer : in STD_LOGIC_VECTOR (15 downto 0);
               rd_enable : in STD_LOGIC);
        end COMPONENT;  
        
--Inputs
        
signal clk : std_logic := '0';

signal rst : std_logic := '0';

signal ssel_tb : std_logic := '1';
signal sclk_tb : std_logic := '0';

-- Rx UTT
signal MOSI_tb : std_logic := '0';

-- Tx UTT
signal tx_buffer_tb : std_logic_vector(15 downto 0);
signal TX_buff : std_logic_vector (15 downto 0) := "1111000010100101";

signal rd_enable_tb : std_logic := '0';


--Outputs
signal rx_buffer_tb : std_logic_vector(15 downto 0);
signal MISO_buff : std_logic_vector (15 downto 0) := "1010110001101011";

signal wr_enable_tb : std_logic := '0';

signal i : INTEGER range 0 to 15 := 0;

-- Tx UTT
signal MISO_tb : std_logic := '0';


-- Clock period definitions

-- Clk tick for 100MHz
constant clk_period : time := 20 ns;

-- Clk tick for SPI 6 MHz;
constant s_tick_period : time := 166 ns;

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
        
-- Instantiate the Unit Under Test (UUT)
   uut_2: spi_tx PORT MAP (
          clk => clk,
              rst => rst,
              ssel => ssel_tb,
              sclk => sclk_tb,
              MISO => MISO_tb,
              tx_buffer => TX_buff,
              rd_enable => rd_enable_tb
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
        rd_enable_tb <= '1';
        
        -- Start SPI frame after 1us
        wait for 1 us;
        ssel_tb <= '0';
        
        -- Wait for SPI transmission to happen
        wait for 16*s_tick_period;
        -- Wait one more half_period 
        wait for s_tick_period/2;
        -- Stop SPI transmission
        ssel_tb <= '1';
        
        
        
        --    rx <= '1', '0' after 100 us, '1' after (100 + 1 * baudrate) us;
        
--        MOSI_tb <= '1', '0' after s_tick_period, '1' after 2*s_tick_period, '0' after 3*s_tick_period, '1' after 4*s_tick_period,
--        '1' after 5*s_tick_period, '0' after 6*s_tick_period, '1' after 7*s_tick_period, '0' after 8*s_tick_period, 
--        ;
        --wait;
    end process;


end Behavioral;
