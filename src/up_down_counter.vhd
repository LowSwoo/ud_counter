library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity up_down_counter is
port (
     reset   : in  std_logic;                     -- Input reset
     clk     : in  std_logic;                     -- Input clock
     up_down : in  std_logic;                     -- up/down control for counter
     cout    : out std_logic_vector (3 downto 0)  -- Output
   );
end entity;

architecture rtl of up_down_counter is

  signal count : unsigned(3 downto 0);

begin

  process (clk, reset)
  begin
    if reset = '1' then
      count <= (others => '0');
    elsif rising_edge(clk) then
      if up_down = '1' then
        count <= count + 1;
      else
        count <= count - 1;
      end if;
    end if;
  end process;

  cout <= std_logic_vector(count);

end architecture;
