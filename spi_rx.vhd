----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2021 11:45:59
-- Design Name: 
-- Module Name: spi_rx - Behavioral
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

entity spi_rx is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ssel : in STD_LOGIC;
           sclk : in STD_LOGIC;
           MOSI : in STD_LOGIC;
           rx_buffer : out STD_LOGIC_VECTOR (15 downto 0);
           wr_enable : out STD_LOGIC);
end spi_rx;

architecture Behavioral of spi_rx is

COMPONENT rising_detector is
    Port ( clk : in STD_LOGIC;
           input_clk : in STD_LOGIC;
           clk_rising : out STD_LOGIC);
end COMPONENT;

type state_machine is (idle, data, stop);
signal current_state, next_state : state_machine := idle;

signal internal_dout : STD_LOGIC_VECTOR (15 downto 0); --:= "0000000000000000";
signal s : INTEGER range 0 to 15 := 0;


-- Rising Edge detector signal
signal input_clk_sig : std_logic;
signal sclk_sig : std_logic;

-- Input Buffers

-- 1st level buffers
signal ssel_register_0 : std_logic;
signal sclk_register_0 : std_logic;
signal MOSI_register_0 : std_logic;

-- 2nd level buffers
signal ssel_register_1 : std_logic;
signal sclk_register_1 : std_logic;
signal MOSI_register_1 : std_logic;

signal trig_sclk : std_logic;

begin
	
    U1_Rising_Detector: rising_detector PORT MAP( 
        clk => clk,
       input_clk => sclk,
       clk_rising => sclk_sig
    );
    
    --input_clk_sig <= sclk;
	
	-- Process gérant la clock clk qui cadence la FSM
	process (clk) 
	begin 

		if (rst = '0') then 
			current_state <= idle;
		else
            if(rising_edge(clk)) then
                current_state <= next_state;
                
                -- Buffers update
                -- Fisrt level
                ssel_register_0 <= ssel;
                --sclk_register_0 <= sclk_sig;
                MOSI_register_0 <= MOSI;
                
                -- Second level
                ssel_register_1 <= ssel_register_0;
                --sclk_register_1 <= sclk_register_0;
                MOSI_register_1 <= MOSI_register_0;
            end if;
        end if;
		
	end process;
	
	-- Process gérant le passage d'un état à l'autre
	process (clk)
	begin
	
	   if(rising_edge(clk)) then

            case current_state is
            
                when  idle => 
                    if(ssel_register_1 = '0') then
                        next_state <= data;
                    else
                        next_state <= idle;
                    end if;
                    
                    internal_dout <= "0000000000000000";
                    wr_enable <= '0';
                    
                when  data => 
                    -- Ajout pour N Trames successives
                    if(ssel_register_1 = '0') then
                    -- Ajout pour N Trames successives
                        if(sclk_sig = '1') then
                            internal_dout(15 - s) <= MOSI_register_1;
                            s <= s + 1;
                            if(s = 15) then
                                s <= 0;
                                wr_enable <= '1';
                                next_state <= stop;
                            else
                                next_state <= data;        
                            end if;
                        end if;
                    -- Ajout pour N Trames successives
                    else
                        s <= 0;
                        next_state <= idle;                   
                    end if;
                    -- Ajout pour N Trames successives
                    
                when  stop => 
                    if(ssel_register_1 = '1') then
                        next_state <= idle;
                    else
                    -- Ajout pour N Trames successives
                        if(sclk_sig = '0') then
                            next_state <= data;
                        else
                            next_state <= stop;
                        end if;
                    -- Ajout pour N Trames successives
                    end if;
                    
                    wr_enable <= '0';
                    rx_buffer <= internal_dout;
                        
    
            end case;
        end if;    
				
	end process;


end Behavioral;
