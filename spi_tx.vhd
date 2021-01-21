----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.01.2021 18:50:33
-- Design Name: 
-- Module Name: spi_tx - Behavioral
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

entity spi_tx is
    Port ( clk : in STD_LOGIC;
       rst : in STD_LOGIC;
       ssel : in STD_LOGIC;
       sclk : in STD_LOGIC;
       MISO : out STD_LOGIC;
       tx_buffer : in STD_LOGIC_VECTOR (15 downto 0);
       rd_enable : in STD_LOGIC);
end spi_tx;

architecture Behavioral of spi_tx is

COMPONENT rising_detector is
    Port ( clk : in STD_LOGIC;
           input_clk : in STD_LOGIC;
           clk_rising : out STD_LOGIC);
end COMPONENT;

type state_machine is (idle, data, stop);
signal current_state, next_state : state_machine;

--signal internal_din : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
--signal miso_s : STD_LOGIC := '0';
signal s : INTEGER range 0 to 15 := 0;

signal input_clk_sig : std_logic;
signal sclk_sig : std_logic;

-- Input Buffers

-- 1st level buffers
signal ssel_register_0 : std_logic;
signal sclk_register_0 : std_logic;

-- 2nd level buffers
signal ssel_register_1 : std_logic;
signal sclk_register_1 : std_logic;

begin

    U1_Rising_Detector: rising_detector PORT MAP( 
        clk => clk,
       input_clk => sclk,
       clk_rising => sclk_sig
    );
    

	-- Process gérant la clock clk qui cadence la FSM
	process (clk, rst) 
	begin 

		if (rst = '0') then 
			current_state <= idle;
		else
            if(rising_edge(clk)) then
                    current_state <= next_state;
                    
                -- Synchronize External asynchrone signals
                
                -- Fisrt level
                ssel_register_0 <= ssel;
                
                -- Second level
                ssel_register_1 <= ssel_register_0;
            end if;            
		end if;
		
	end process;
	
	-- Process gérant le passage d'un état à l'autre
	process (clk)
	begin
	
	if(rising_edge(clk)) then
		
		case current_state is
		
			when  idle => 
				if(rd_enable = '1') then
                    if(ssel_register_1 = '0') then
                        next_state <= data;
                    else
                        next_state <= idle;
                    end if;
				end if;
				
				MISO <= '0';
				
			when  data => 

				if(sclk_sig = '1') then
					MISO <= tx_buffer(15 - s);
					s <= s + 1;
					
					if(s = 15) then
                        s <= 0;
                        next_state <= stop;
                    else
                        next_state <= data;
                    end if;
				end if;
				
			when  stop => 
				if(ssel_register_1 = '1') then
					MISO <= '0';
					next_state <= idle;
				else
				    next_state <= stop;
				end if;
				
				--MISO <= '0';
									
--			when others => next_state<= idle;

		end case;
	end if;
				
	end process;

end Behavioral;
