----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2021 09:17:13
-- Design Name: 
-- Module Name: spi_decoder - Behavioral
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

entity spi_decoder is
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
end spi_decoder;

architecture Behavioral of spi_decoder is

type state_machine is (init, idle, decode);
signal current_state, next_state : state_machine := idle;

-- Intermitant Processing signal
signal sig_m1_start : std_logic := '0';
signal sig_m1_dir : std_logic := '0';
signal sig_m1_duty : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
signal sig_m1_freq : STD_LOGIC_VECTOR (6 downto 0) := "0011000";

signal sig_m2_start : std_logic := '0';
signal sig_m2_dir : std_logic := '0';
signal sig_m2_duty : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
signal sig_m2_freq : STD_LOGIC_VECTOR (6 downto 0) := "0011000";

signal sig_cmd_debug_leds : STD_LOGIC_VECTOR (3 downto 0) := "0000";

signal sig_SoF : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal sig_cmd : STD_LOGIC_VECTOR (2 downto 0) := "000";
signal sig_cmd_value : STD_LOGIC_VECTOR (6 downto 0) := "0000000";

signal sig_motor_id : STD_LOGIC := '0';


constant cmd_mask : STD_LOGIC_VECTOR (15 downto 0) := "0000111100000000";
constant value_mask : STD_LOGIC_VECTOR (15 downto 0) := "0000000011111110";
constant motor_mask_bit : INTEGER := 11;

constant default_SoF : STD_LOGIC_VECTOR (3 downto 0) := "1010";
constant default_tx_ack : STD_LOGIC_VECTOR (15 downto 0) := "1111000010100101";




begin

-- Process gérant la clock clk qui cadence la FSM
	process (clk, rst) 
	begin 

		if (rst = '0') then 
			current_state <= init; 
		else
            if(rising_edge(clk)) then
                    current_state <= next_state;
            end if;
		end if;
		
	end process;
	
	-- Process gérant le passage d'un état à l'autre
	process (clk)
	begin
	
	   if(rising_edge(clk)) then
            case current_state is
            
                when  init => 
                    
                    sig_m1_start <= '0';
                    sig_m1_dir <= '0';
                    sig_m1_duty <= "0000000";
                    
                    sig_m2_start <= '0';
                    sig_m2_dir <= '0';
                    sig_m2_duty <= "0000000";
                    
                    sig_cmd_debug_leds <= "0000";
                    
                    next_state <= idle;
                    
                when  idle => 
                    if(wr_enable = '1') then
                        next_state <= decode;
                    else
                        next_state <= idle;
                    end if;
                    
                    tx_buffer <= default_tx_ack;
                    rd_enable <= '1';
                    
                    m1_start <= sig_m1_start;
                    m1_dir <= sig_m1_dir;
                    m1_duty <= sig_m1_duty;
                    m1_freq <= sig_m1_freq;
                    
                    m2_start <= sig_m2_start;
                    m2_dir <= sig_m2_dir;
                    m2_duty <= sig_m2_duty;
                    m2_freq <= sig_m2_freq;
                    
                    cmd_debug_leds <= sig_cmd_debug_leds;
                    --wr_enable <= '0';
                    --s <= 0;                
    
                when  decode => 
    
                    rd_enable <= '1';
                    sig_SoF <= rx_buffer(15) & rx_buffer(14) & rx_buffer(13) & rx_buffer(12);
                    sig_cmd <= rx_buffer(10) & rx_buffer(9) & rx_buffer(8);
                    sig_cmd_value <= rx_buffer(7) & rx_buffer(6) & rx_buffer(5) & rx_buffer(4) & rx_buffer(3) & rx_buffer(2) & rx_buffer(1);
                    sig_motor_id <= rx_buffer(motor_mask_bit);
                    
                    -- ###############################################################################
                    -- Motor 
                    -- ###############################################################################
                    if(sig_SoF = default_SoF) then
                        -- Start and Stop Command
                        if (sig_cmd = "001") then
                        
                            if(sig_motor_id = '0') then
                                sig_m1_start <= sig_cmd_value(0);
                            else
                                sig_m2_start <= sig_cmd_value(0);
                            end if;
                            
                            sig_cmd_debug_leds <= "0001";
                            
                        -- Rotation Command
                        elsif(sig_cmd = "010") then
                        
                            if(sig_motor_id = '0') then
                                sig_m1_dir <= sig_cmd_value(0);
                            else
                                sig_m2_dir <= sig_cmd_value(0);
                            end if;
                            
                            sig_cmd_debug_leds <= "0010";
                        
                        -- PWM Frequency Command
                        elsif(sig_cmd = "100") then
                        
                            if(sig_motor_id = '0') then
                                sig_m1_freq <= sig_cmd_value;
                            else
                                sig_m2_freq <= sig_cmd_value;
                            end if;
                            
                            sig_cmd_debug_leds <= "0100";
                            
                        -- Duty Cycle Command
                        elsif(sig_cmd = "111") then
                        
                            if(sig_motor_id = '0') then
                                sig_m1_duty <= sig_cmd_value;
                            else
                                sig_m2_duty <= sig_cmd_value;
                            end if;
                            sig_cmd_debug_leds <= "0111";              
                        else
                            sig_cmd_debug_leds <= "0000";
                        end if;
                        
                        m1_start <= sig_m1_start;
                        m1_dir <= sig_m1_dir;
                        m1_duty <= sig_m1_duty;
                        m1_freq <= sig_m1_freq;
                        
                        m2_start <= sig_m2_start;
                        m2_dir <= sig_m2_dir;
                        m2_duty <= sig_m2_duty;
                        m2_freq <= sig_m2_freq;

                    
                    end if;
                    
                    next_state <= idle;
                                        
            end case;
        end if;
				
	end process;
	
end Behavioral;
