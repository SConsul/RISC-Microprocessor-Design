library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SE9 is
port (
    ip : in std_logic_vector (8 downto 0);
    op : out std_logic_vector (15 downto 0)
  );
end entity SE9;

architecture SignedExtender of SE9 is
begin
  op(8 downto 0) <= ip;
  process(ip)
  begin
  if ip(8) = '1' then
	op(15 downto 9) <= (others=>'1');
  else
	op(15 downto 9) <= (others=>'0');
end if;
end process;
end SignedExtender;
