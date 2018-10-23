library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity priority_encoder is
-- Generic (CLK_BITS : INTEGER := 11)
port (
    ip : in std_logic_vector (7 downto 0),
    op_addr : out std_logic_vector (2 downto 0),
    op_mask : out std_logic_vector (7 downto 0)
  );
end entity priority_encoder;

architecture PriorityEncoder of priority_encoder is
begin
process(ip, op_addr, op_mask)
  if ip(0) then
    op_addr <= "000";
    op_mask <= "00000001"
  elsif ip(1) then
    op_addr <= "001";
    op_mask <= "00000010"
  elsif ip(2) then
    op_addr <= "010";
    op_mask <= "00000100"
  elsif ip(3) then
    op_addr <= "011";
    op_mask <= "00001000"
  elsif ip(4) then
    op_addr <= "100";
    op_mask <= "00010000"
  elsif ip(5) then
    op_addr <= "101";
    op_mask <= "00100000"
  elsif ip(6) then
    op_addr <= "110";
    op_mask <= "01000000"
  elsif ip(7) then
    op_addr <= "111";
    op_mask <= "10000000"
  end if
end process
end PriorityEncoder;
