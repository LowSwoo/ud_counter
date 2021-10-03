
library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;



entity TIMER_IP_COMP is
  port(
    CLK_IN            : in std_logic;
    RESET_N_IN        : in std_logic;
    CTRL_TIMER_IN     : in std_logic_vector(1 downto 0);
    DATA_TIMER_IN     : in std_logic_vector(31 downto 0);
	DIR_TIM			  : in std_logic_vector(1 downto 0);
	REBOOT_VAL		  : in std_logic_vector(31 downto 0);
	RESET_CNT_VAL	  : in std_logic_vector(31 downto 0);
	DATA_TIMER_OUT    : out std_logic_vector(31 downto 0)
  );
end entity TIMER_IP_COMP;

architecture rtl of TIMER_IP_COMP is
signal count : unsigned(31 downto 0) := unsigned(DATA_TIMER_IN);
signal up_down : std_logic;
signal flag_u_d : std_logic;

begin
  process(count)
  begin
	if ((count) = unsigned(REBOOT_VAL)) then
	  flag_u_d <= '1';
	end if;
	if ((count) = unsigned(RESET_CNT_VAL)) then
	  flag_u_d <= '0';
	end if;
  	if ((count) = unsigned(REBOOT_VAL) and flag_u_d = '1') then
	  up_down <= '0';
	end if;
	if ((count) = unsigned(RESET_CNT_VAL) and flag_u_d = '0') then
	  up_down <= '1';
	end if;
  end process;
	
	
	
  -- MAIN PROCESS --
  process(CLK_IN, RESET_N_IN)
  begin
    if RESET_N_IN = '0' then
      count <= (others => '0');
    elsif rising_edge(CLK_IN) then
	  if (CTRL_TIMER_IN = "00") then 
		count <= count;
	  end if;
	  if (CTRL_TIMER_IN = "01") then 
		count <= (others => '0');
	  end if;
	  if (CTRL_TIMER_IN = "10") then
		if (DIR_TIM = "00") then 
		  count <= count + 1;
		end if;
		if (DIR_TIM = "01") then 
		  count <= count - 1;
		end if;
		if (DIR_TIM = "10") then 
		   count <= count + 1;
		end if;
		if (DIR_TIM = "10" and up_down = '1') then 
		   count <= count + 1;
		end if;
		if (DIR_TIM = "10" and up_down = '0') then 
		    count <= count - 1;
		end if;
	  end if;
    end if;
  end process;
 DATA_TIMER_OUT <= std_logic_vector(count);

end rtl;