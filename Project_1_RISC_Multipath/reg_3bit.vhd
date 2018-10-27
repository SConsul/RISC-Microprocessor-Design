library ieee;
use ieee.std_logic_1164.all;

entity reg_3bit is
  port (EN, CLK: in std_logic;
        ip: in std_logic_vector(2 downto 0);
        op: out std_logic_vector(2 downto 0)
		  );
end entity;

architecture reg3_arch of reg_3bit is
begin
reg1 : process(ip)
begin
  if CLK'event and CLK = '1' then
    if EN = '1' then
      op <= ip;
    end if;
  end if;
end process;

end reg3_arch;
