library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity counter_test is
end counter_test;
 
architecture arch of counter_test is
  component counter
  generic (BIT_WIDTH : integer);
  port (CLR  : in  std_logic;
        CLK  : in  std_logic;
        EN   : in  std_logic;
        Q    : out std_logic_vector(BIT_WIDTH-1 downto 0));
  end component;

  signal CLR : std_logic := '0';
  signal CLK : std_logic := '0';
  signal EN : std_logic := '0';

  signal Q : std_logic_vector(2 downto 0);

  constant CLK_period : time := 10 ns;
 
begin
 
  uut: counter
    generic map (BIT_WIDTH => 3)  
    port map (CLR => CLR,
              CLK => CLK,
              EN => EN,
              Q => Q);

  CLK_process :process
  begin
    CLK <= '0';
	  wait for CLK_period/2;
	  CLK <= '1';
	  wait for CLK_period/2;
  end process;

  stim_proc: process
  begin
    CLR <= '1';
    wait for 100 ns;
    CLR <= '0';
    wait for CLK_period;

    assert (Q = "000")
      report "initial Q invalid";
    
    EN <= '1';
    wait for CLK_period;
    assert Q = "001" report "en 1 clk fail";
    wait for CLK_period;
    assert Q = "010" report "en 2 clk fail";
    EN <= '0';
    wait for CLK_period;
    assert Q = "010" report "no-en 3 clk fail";
    EN <= '1';
    wait for CLK_period * 5;
    assert Q = "111" report "en 8 clk fail";
    wait for CLK_period;
    assert Q = "000" report "wrap fail";

    wait;
  end process;

end;
