-- Debounces button input by watching the input value over a period of time.
--
-- Implemented from the schematic at 
-- https://eewiki.net/pages/viewpage.action?pageId=4980758
--
-- There are certainly more terse ways to implement this (whether that means
-- more efficient, I don't have the VHDL experience to judge), but this
-- implementation was easy to validate, test, and understand.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- The value of BTN is sampled once every CLK until the value stays the same
-- long enough for the counter (which is reset when the value changes) to
-- overflow. COUNTER_WIDTH sets the bit width of the counter.
entity debounce is
  generic (COUNTER_WIDTH : integer := 19);

  port (BTN : in  std_logic;
        CLK : in  std_logic;
        RES : out std_logic);
end debounce;

architecture arch of debounce is
  component counter
  generic (BIT_WIDTH : integer);
  port (CLR  : in  std_logic;
        CLK  : in  std_logic;
        EN   : in  std_logic;
        Q    : out std_logic_vector(BIT_WIDTH-1 downto 0));
  end component;

  component dff
    port (D   : in  std_logic;
          EN  : in  std_logic;
          CLK : in  std_logic;
          Q   : out std_logic);
  end component;
  
  signal ff1_out : std_logic;
  signal ff2_out : std_logic;
  signal counter_val : std_logic_vector(COUNTER_WIDTH-1 downto 0);
  signal counter_clr : std_logic;
  signal counter_cout : std_logic;
  signal counter_en : std_logic;

begin

  ff1: dff
    port map (D => BTN,
              CLK => CLK,
              EN => '1',
              Q => ff1_out);
              
  ff2: dff
    port map (D => ff1_out,
              CLK => CLK,
              EN => '1',
              Q => ff2_out);
              
  counter_clr <= ff1_out xor ff2_out;
  
  cnt: counter
    generic map (BIT_WIDTH => COUNTER_WIDTH)
    port map (CLR => counter_clr,
              CLK => CLK,
              EN => counter_en,
              Q => counter_val);
              
  counter_cout <= counter_val(COUNTER_WIDTH-1);            
  counter_en <= not counter_cout;
              
  ff3: dff
    port map (D => ff2_out,
              CLK => CLK,
              EN => counter_cout,
              Q => RES);

end arch;

