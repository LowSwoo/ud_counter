library ieee;
use ieee.std_logic_1164.all;

entity up_down_counter_tb is
end entity;

architecture TB of up_down_counter_tb is

    signal cout     : std_logic_vector(3 downto 0);
    signal up_down  : std_logic;
    signal reset    : std_logic;
    signal clk      : std_logic;

begin

  dut: entity work.up_down_counter
  port map (reset, clk, up_down, cout);

  process
  begin
    clk <= '0'; wait for 1 us;
    clk <= '1'; wait for 1 us;
  end process;

  process
  begin
    up_down <= '1';
    reset   <= '1'; wait for 5 us;
    reset   <= '0'; wait for 35 us;
    up_down <= '0'; wait;
  end process;

end;
