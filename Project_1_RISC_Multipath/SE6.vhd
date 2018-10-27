library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SE6 is
port (
    ip : in std_logic_vector (5 downto 0);
    op : out std_logic_vector (15 downto 0)
  );
end entity SE6;

architecture SignedExtender of SE6 is
begin
  op(5 downto 0) <= ip;
  op(15 downto 6) <= ip(5);
end SignedExtender;
