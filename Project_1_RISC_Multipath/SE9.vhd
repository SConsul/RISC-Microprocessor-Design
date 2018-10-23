library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SE9 is
-- Generic (CLK_BITS : INTEGER := 11)
port (
    ip : in std_logic_vector (8 downto 0),
    op : out std_logic_vector (15 downto 0)
  );
end entity SE9;

architecture SignedExtender of SE9 is
begin
  out(8 downto 0) <= ip;
  out(15 downto 9) <= ip(8);
end SignedExtender;
