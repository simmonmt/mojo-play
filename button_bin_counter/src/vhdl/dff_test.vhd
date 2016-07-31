library ieee;
use ieee.std_logic_1164.ALL;

entity dff_test is
end dff_test;
 
architecture arch of dff_test is
  component dff
  port (D   : in  std_logic;
        EN  : in  boolean;
        CLK : in  std_logic;
        Q   : out std_logic);
  end component;
  
  signal D   : std_logic := '0';
  signal EN  : boolean   := true;
  signal CLK : std_logic := '0';

  signal Q : std_logic;

  constant CLK_period : time := 10 ns;
 
begin
 
  uut: dff port map (D => D,
                     EN => EN,
                     CLK => CLK,
                     Q => Q);

  CLK_process: process
  begin
	  CLK <= '0';
	 	wait for CLK_period/2;
	 	CLK <= '1';
		wait for CLK_period/2;
  end process;
 
  stim_proc: process
  begin		
    wait for CLK_period * 10;
    assert Q = '0' report "initial Q invalid";
    
    D <= '1';
    wait for CLK_period / 2;
    assert Q = '0' report "Q went 1 too soon";
    wait for CLK_period;
    assert Q = '1' report "Q didn't go 1";
    wait for CLK_period / 2;
  
    D <= '0';
    wait for CLK_period / 2;
    assert Q = '1' report "Q went 0 too soon";
    wait for CLK_period;
    assert Q = '0' report "Q didn't go 0";
    
    EN <= false;
    D <= '1';
    wait for CLK_period * 2;
    assert Q = '0' report "Q went high in spite of EN=0";
    
    EN <= true;
    D <= '1';
    wait for CLK_period * 2;
    EN <= false;
    D <= '0';
    wait for CLK_period * 2;
    assert Q = '1' report "Q went low in spite of EN=0";
 
    wait;
  end process;

end;
