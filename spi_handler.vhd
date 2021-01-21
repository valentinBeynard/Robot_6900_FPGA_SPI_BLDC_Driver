----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2021 13:41:58
-- Design Name: 
-- Module Name: spi_handler - Behavioral
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

entity spi_handler is
    Port ( clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       ssel : in STD_LOGIC;
       sclk : in STD_LOGIC;
       MOSI : in STD_LOGIC;
       MISO : out STD_LOGIC;
       reg_RX : out STD_LOGIC_VECTOR (15 downto 0);
       m1_start : out STD_LOGIC;
       m1_dir : out STD_LOGIC;
       m1_duty : out STD_LOGIC_VECTOR (6 downto 0);
       m1_freq : out STD_LOGIC_VECTOR (6 downto 0);
       m2_start : out STD_LOGIC;
       m2_dir : out STD_LOGIC;
       m2_duty : out STD_LOGIC_VECTOR (6 downto 0);
       m2_freq : out STD_LOGIC_VECTOR (6 downto 0);
       cmd_debug_leds : out STD_LOGIC_VECTOR (3 downto 0);
       led_test : out STD_LOGIC
       );
end spi_handler;

architecture Behavioral of spi_handler is

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
               m1_freq : out STD_LOGIC_VECTOR (6 downto 0);
               m2_start : out STD_LOGIC;
               m2_dir : out STD_LOGIC;
               m2_duty : out STD_LOGIC_VECTOR (6 downto 0);
               m2_freq : out STD_LOGIC_VECTOR (6 downto 0);
               cmd_debug_leds : out STD_LOGIC_VECTOR (3 downto 0)
               );
    end COMPONENT;

--Inputs
        
signal clk_sig : std_logic := '0';

signal rst_sig : std_logic := '0';

signal ssel_sig : std_logic := '1';
signal sclk_sig : std_logic := '0';

signal MOSI_sig : std_logic := '0';


--Outputs
signal MISO_sig : std_logic := '0';

signal rx_buffer_sig : std_logic_vector(15 downto 0) := "0000000000000000";
signal wr_enable_sig : std_logic := '0';

signal tx_buffer_sig : std_logic_vector (15 downto 0) := "0000000000000000";
signal rd_enable_sig : std_logic := '0';

signal m1_start_sig : std_logic := '0';
signal m1_dir_sig : std_logic := '0';
signal m1_duty_sig : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
--signal m1_freq_sig : STD_LOGIC_VECTOR (6 downto 0) := "0000000";

signal m2_start_sig : std_logic := '0';
signal m2_dir_sig : std_logic := '0';
signal m2_duty_sig : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
--signal m2_freq_sig : STD_LOGIC_VECTOR (6 downto 0) := "0000000";


signal debug_leds_sig : STD_LOGIC_VECTOR (3 downto 0) := "0000";

begin

-- Instantiate the Unit Under Test (UUT)
   U1_Rx_SPI: spi_rx PORT MAP (
          clk => clk_sig,
              rst => rst,
              ssel => ssel_sig,
              sclk => sclk_sig,
              MOSI => MOSI,
              rx_buffer => rx_buffer_sig,
              wr_enable => wr_enable_sig
        );
        
-- Instantiate the Unit Under Test (UUT)
   U2_Tx_SPI : spi_tx PORT MAP (
          clk => clk_sig,
              rst => rst,
              ssel => ssel_sig,
              sclk => sclk_sig,
              MISO => MISO_sig,
              tx_buffer => tx_buffer_sig,
              rd_enable => rd_enable_sig
        );
        
     U3_SPI_Decoder: spi_decoder PORT MAP (
                clk => clk_sig,
                rst => rst,
                rx_buffer => rx_buffer_sig,
                wr_enable => wr_enable_sig,
                tx_buffer => tx_buffer_sig,
                rd_enable => rd_enable_sig,
                m1_start => m1_start_sig,
                m1_dir => m1_dir_sig,
                m1_duty => m1_duty_sig,
                m1_freq => m1_freq,
                m2_start => m2_start_sig,
                m2_dir => m2_dir_sig,
                m2_duty => m2_duty_sig,
                m2_freq => m2_freq,
                cmd_debug_leds => debug_leds_sig
        );  
    
 -- Map signals
 
-- Inputs
clk_sig <= clk;
rst_sig <= rst;

ssel_sig <= ssel;
sclk_sig <= sclk;
--MOSI_sig <= MOSI;

--Outputs
m1_start <= m1_start_sig;
m1_dir <= m1_dir_sig;
m1_duty <= m1_duty_sig;
 
m2_start <= m2_start_sig;
m2_dir <= m2_dir_sig;
m2_duty <= m2_duty_sig;
 
cmd_debug_leds <= debug_leds_sig;

MISO <= MISO_sig;    

reg_RX <= rx_buffer_sig;

led_test <= '1';
              
end Behavioral;
