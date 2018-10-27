library ieee;
use ieee.std_logic_1164.all;

entity flip_flop is
  port (D, EN, CLK: in std_logic;
  Q: out std_logic);
end entity;

architecture FlipFlop of flip_flop is
begin

   process(CLK, EN)
   begin

  if CLK'event and (CLK = '1') then
    if(EN='1') then
        Q <= D;
      end if;
	 end if;
   end process;

end FlipFlop;
