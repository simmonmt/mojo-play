library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity base is
  port(BTN_N : in std_logic;
       CLK : in std_logic;
	     LED : out std_logic_vector(7 downto 0);
		
       SPI_MISO    : out std_logic := 'Z';
	     AVR_RX      : out std_logic := 'Z';
       SPI_CHANNEL : out std_logic_vector(3 downto 0) := "ZZZZ"); 
end base;

architecture arch of base is
  component debounce
    generic (COUNTER_WIDTH : integer := 19);
    port (BTN : in  std_logic;
          CLK : in  std_logic;
          RES : out std_logic);
  end component;

  component counter
    generic (BIT_WIDTH : integer);
    port (CLR  : in  std_logic;
          CLK  : in  std_logic;
          EN   : in  std_logic;
          Q    : out std_logic_vector(BIT_WIDTH-1 downto 0));
  end component;
  
  signal button_raw : std_logic;
  signal button : std_logic;

begin
  button_raw <= not BTN_N;

  button_debounce: debounce
    port map (BTN => button_raw,
              CLK => CLK,
              RES => button);

  cnt: counter
    generic map (BIT_WIDTH => 8)
    port map (CLR => '0',
              CLK => button,
--              CLK => button_raw,
              EN => '1',
              Q => LED);

--  LED(0) <= button_raw;
--  LED(7 downto 1) <= "0000000";

end arch;

