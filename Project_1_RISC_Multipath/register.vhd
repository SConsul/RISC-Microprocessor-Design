library ieee;
use ieee.std_logic_1164.all;

entity reg is
  port (EN, CLK: in std_logic;
        D: in std_logic_vector(15 downto 0);
        Q: out std_logic_vector(15 downto 0));
end entity;

architecture reg_arch of reg is

component ff_with_clear is
  port (D, CLEAR, EN, CLK: in std_logic; Q: out std_logic);

end component;

begin
s00: ff_with_clear port map(D => D(00), CLEAR=>'0', EN=>EN, Q=>Q(00), CLK=>CLK);
s01: ff_with_clear port map(D => D(01), CLEAR=>'0', EN=>EN, Q=>Q(01), CLK=>CLK);
s02: ff_with_clear port map(D => D(02), CLEAR=>'0', EN=>EN, Q=>Q(02), CLK=>CLK);
s03: ff_with_clear port map(D => D(03), CLEAR=>'0', EN=>EN, Q=>Q(03), CLK=>CLK);
s04: ff_with_clear port map(D => D(04), CLEAR=>'0', EN=>EN, Q=>Q(04), CLK=>CLK);
s05: ff_with_clear port map(D => D(05), CLEAR=>'0', EN=>EN, Q=>Q(05), CLK=>CLK);
s06: ff_with_clear port map(D => D(06), CLEAR=>'0', EN=>EN, Q=>Q(06), CLK=>CLK);
s07: ff_with_clear port map(D => D(07), CLEAR=>'0', EN=>EN, Q=>Q(07), CLK=>CLK);
s08: ff_with_clear port map(D => D(08), CLEAR=>'0', EN=>EN, Q=>Q(08), CLK=>CLK);
s09: ff_with_clear port map(D => D(09), CLEAR=>'0', EN=>EN, Q=>Q(09), CLK=>CLK);
s10: ff_with_clear port map(D => D(10), CLEAR=>'0', EN=>EN, Q=>Q(10), CLK=>CLK);
s11: ff_with_clear port map(D => D(11), CLEAR=>'0', EN=>EN, Q=>Q(11), CLK=>CLK);
s12: ff_with_clear port map(D => D(12), CLEAR=>'0', EN=>EN, Q=>Q(12), CLK=>CLK);
s13: ff_with_clear port map(D => D(13), CLEAR=>'0', EN=>EN, Q=>Q(13), CLK=>CLK);
s14: ff_with_clear port map(D => D(14), CLEAR=>'0', EN=>EN, Q=>Q(14), CLK=>CLK);
s15: ff_with_clear port map(D => D(15), CLEAR=>'0', EN=>EN, Q=>Q(15), CLK=>CLK);
end reg_arch;
