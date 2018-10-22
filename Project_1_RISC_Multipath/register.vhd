library ieee;
use ieee.std_logic_1164.all;

entity register is
  port (EN, CLK: in std_logic;
        D: in std_logic(15 downto 0);
        Q: out std_logic(15 downto 0));
end entity;

architecture reg_arch of register is

component ff_with_clear is
  port (D, CLEAR, EN, CLK: in std_logic; Q: out std_logic);

end component;

begin
s00: ff_with_clear port map(D => D(00), CLEAR=>'0', EN=>EN, Q=>Q(00));
s01: ff_with_clear port map(D => D(01), CLEAR=>'0', EN=>EN, Q=>Q(01));
s02: ff_with_clear port map(D => D(02), CLEAR=>'0', EN=>EN, Q=>Q(02));
s03: ff_with_clear port map(D => D(03), CLEAR=>'0', EN=>EN, Q=>Q(03));
s04: ff_with_clear port map(D => D(04), CLEAR=>'0', EN=>EN, Q=>Q(04));
s05: ff_with_clear port map(D => D(05), CLEAR=>'0', EN=>EN, Q=>Q(05));
s06: ff_with_clear port map(D => D(06), CLEAR=>'0', EN=>EN, Q=>Q(06));
s07: ff_with_clear port map(D => D(07), CLEAR=>'0', EN=>EN, Q=>Q(07));
s08: ff_with_clear port map(D => D(08), CLEAR=>'0', EN=>EN, Q=>Q(08));
s09: ff_with_clear port map(D => D(09), CLEAR=>'0', EN=>EN, Q=>Q(09));
s10: ff_with_clear port map(D => D(10), CLEAR=>'0', EN=>EN, Q=>Q(10));
s11: ff_with_clear port map(D => D(11), CLEAR=>'0', EN=>EN, Q=>Q(11));
s12: ff_with_clear port map(D => D(12), CLEAR=>'0', EN=>EN, Q=>Q(12));
s13: ff_with_clear port map(D => D(13), CLEAR=>'0', EN=>EN, Q=>Q(13));
s14: ff_with_clear port map(D => D(14), CLEAR=>'0', EN=>EN, Q=>Q(14));
s15: ff_with_clear port map(D => D(15), CLEAR=>'0', EN=>EN, Q=>Q(15));
end reg_arch;
