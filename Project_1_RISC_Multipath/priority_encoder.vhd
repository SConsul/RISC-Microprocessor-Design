library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity priority_encoder is
-- Generic (CLK_BITS : INTEGER := 11)
port (
    ip : in std_logic_vector (7 downto 0),
    op_addr : out std_logic_vector (2 downto 0),
    update : out std_logic_vector (7 downto 0)
  );
end entity priority_encoder;

architecture PriorityEncoder of priority_encoder is
begin
process(ip, op_addr, update)
  if ip(0) then
    op_addr <= "000";
    update(7 downto 1) <= ip(7 downto 1);
    update(0) <= '0';
  elsif ip(1) then
    op_addr <= "001";
    update(7 downto 2) <= ip(7 downto  2);
    update(1 downto 0) <= "00";
  elsif ip(2) then
    op_addr <= "010";
    update(7 downto 3) <= ip(7 downto 3);
    update(2 downto 0) <= "000";
  elsif ip(3) then
    op_addr <= "011";
    update(7 downto 4) <= ip(7 downto 4);
    update(3 downto 0) <= "0000";
  elsif ip(4) then
    op_addr <= "100";
    update(7 downto 5) <= ip(7 downto 5);
    update(4 downto 0) <= "00000";
  elsif ip(5) then
    op_addr <= "101";
    update(7 downto 6) <= ip(7 downto 6);
    update(5 downto 0) <= "000000";
  elsif ip(6) then
    op_addr <= "110";
    update(7) <= ip(7);
    update(6 downto 0) <= "0000000";
  elsif ip(7) then
    op_addr <= "111";
    update <= "00000000";
  end if;
end process
end PriorityEncoder;
