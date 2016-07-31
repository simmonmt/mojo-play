LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY mux_4to1_test IS
END mux_4to1_test;
 
ARCHITECTURE behavior OF mux_4to1_test IS 
  COMPONENT mux_4to1
    PORT(
      D3 : IN  std_logic;
      D2 : IN  std_logic;
      D1 : IN  std_logic;
      D0 : IN  std_logic;
      SEL : IN  std_logic_vector(1 downto 0);
      MX_OUT : OUT  std_logic
    );
  END COMPONENT;

  signal D3 : std_logic := '0';
  signal D2 : std_logic := '0';
  signal D1 : std_logic := '0';
  signal D0 : std_logic := '0';
  signal SEL : std_logic_vector(1 downto 0) := (others => '0');

  signal MX_OUT : std_logic;
 
BEGIN
   uut: mux_4to1 PORT MAP (
          D3 => D3,
          D2 => D2,
          D1 => D1,
          D0 => D0,
          SEL => SEL,
          MX_OUT => MX_OUT
        );

   stim: process
	begin
	  D0 <= '1'; D1 <= '0'; D2 <= '0'; D3 <= '0'; SEL <= "00";
	  wait for 100ns;
	  assert MX_OUT = '1' report "MX_OUT invalid for 1000 00";

	  D0 <= '0'; D1 <= '0'; D2 <= '0'; D3 <= '0'; SEL <= "00";
	  wait for 100ns;
	  assert MX_OUT = '0' report "MX_OUT invalid for 0000 00";

	  D0 <= '0'; D1 <= '1'; D2 <= '0'; D3 <= '0'; SEL <= "01";
	  wait for 100ns;
	  assert MX_OUT = '1' report "MX_OUT invalid for 0100 01";

	  D0 <= '0'; D1 <= '0'; D2 <= '0'; D3 <= '0'; SEL <= "01";
	  wait for 100ns;
	  assert MX_OUT = '0' report "MX_OUT invalid for 0000 01";

	  D0 <= '0'; D1 <= '0'; D2 <= '1'; D3 <= '0'; SEL <= "10";
	  wait for 100ns;
	  assert MX_OUT = '1' report "MX_OUT invalid for 0010 10";

	  D0 <= '0'; D1 <= '0'; D2 <= '0'; D3 <= '0'; SEL <= "10";
	  wait for 100ns;
	  assert MX_OUT = '0' report "MX_OUT invalid for 0000 10";

	  D0 <= '0'; D1 <= '0'; D2 <= '0'; D3 <= '1'; SEL <= "11";
	  wait for 100ns;
	  assert MX_OUT = '1' report "MX_OUT invalid for 0001 11";

	  D0 <= '0'; D1 <= '0'; D2 <= '0'; D3 <= '0'; SEL <= "11";
	  wait for 100ns;
	  assert MX_OUT = '0' report "MX_OUT invalid for 0000 11";
		 
	  wait;
	end process;
END;
