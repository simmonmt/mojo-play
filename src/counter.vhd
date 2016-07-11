library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
  generic (BIT_WIDTH : integer := 8);

  port (CLR  : in   std_logic;
        CLK  : in   std_logic;
        EN   : in   std_logic;
        Q    : out  std_logic_vector (BIT_WIDTH-1 downto 0));
end counter;

architecture arch of counter is
  signal counter : unsigned(BIT_WIDTH-1 downto 0);
begin

  proc: process (CLK) begin
    if (rising_edge(CLK)) then
      if (CLR = '1') then
        counter <= to_unsigned(0, BIT_WIDTH);
      elsif (EN = '1') then
        counter <= counter + 1;
      end if;
    end if;
  end process;

  Q <= std_logic_vector(counter);

end arch;

