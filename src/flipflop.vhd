library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dff is
  port (D   : in  std_logic;
        EN  : in  std_logic;
        CLK : in  std_logic;
        Q   : out std_logic);
end dff;

architecture arch of dff is
begin

  proc: process (CLK, EN) begin
    if (rising_edge(CLK) and EN = '1') then
      Q <= D;
    end if;
  end process;

end arch;

