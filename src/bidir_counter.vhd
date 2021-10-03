library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bidir_counter is
port (
     reset   : in  std_logic;                     -- Input reset
     clk     : in  std_logic;                     -- Input clock
     max_value : in  std_logic_vector(7 downto 0);  
     min_value : in  std_logic_vector(7 downto 0);                     
     cout    : out std_logic_vector (7 downto 0)  -- Output
   );
end entity;

architecture rtl of bidir_counter is

  signal count : unsigned(7 downto 0);
  signal direction : std_logic;

begin

  process (clk, reset)
  begin
    if reset = '1' then
      count <= unsigned(min_value);
      direction <= '1';
    elsif rising_edge(clk) then
      if (count = unsigned(max_value)) then
        direction <= '0';
      elsif (count = unsigned(min_value)) then
        direction <= '1';
      end if;
      
      if (direction = '1') then
        count <= count + 1;
      elsif (direction = '0') then
        count <= count -1;
      end if;

    end if;
  end process;

  cout <= std_logic_vector(count);

end architecture;
