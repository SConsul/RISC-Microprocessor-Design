library ieee;
use ieee.std_logic_1164.all;

entity flip_flop is
  port (D, EN, reset, CLK: in std_logic;
  Q: out std_logic);
end entity;

architecture FlipFlop of flip_flop is
begin

   process(CLK, EN, D)
   begin

  if CLK'event and (CLK = '1') then
    if reset = '1' then
      Q <= '0';
    elsif(EN='1') then
        Q <= D;
    end if;
	 end if;
   end process;

end FlipFlop;
