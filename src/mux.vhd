library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_4to1 is
    Port ( D3 : in  STD_LOGIC;
           D2 : in  STD_LOGIC;
           D1 : in  STD_LOGIC;
           D0 : in  STD_LOGIC;
           SEL : in  STD_LOGIC_VECTOR (1 downto 0);
           MX_OUT : out  STD_LOGIC);
end mux_4to1;

architecture mux_4to1_arch of mux_4to1 is
begin

  with SEL select
    MX_OUT <= D3 when "11",
	           D2 when "10",
				  D1 when "01",
				  D0 when "00",
				  '0' when others;

end mux_4to1_arch;
