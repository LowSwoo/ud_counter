library ieee;
use ieee.std_logic_1164.all;

entity up_down_counter_tb is
end entity;

architecture TB of up_down_counter_tb is

  signal cout : std_logic_vector(7 downto 0);
  signal reset : std_logic;
  signal clk : std_logic;

begin

  dut : entity work.up_down_counter
    port map(
      reset => reset,
      clk => clk,
      max_value => "01011000",
      min_value => "01010101",
      cout => cout
      );

  process
  begin
    clk <= '0';
    wait for 1 us;
    clk <= '1';
    wait for 1 us;
  end process;

  process
  begin
    reset <= '1';
    wait for 5 us;
    reset <= '0';
    wait;
  end process;

end;