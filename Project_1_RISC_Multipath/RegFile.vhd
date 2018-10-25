library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegFile is
Generic (NUM_BITS : INTEGER := 16);
port (
    CLK : in std_logic;
    rf_a1, rf_a2, rf_a3 : in std_logic_vector (2 downto 0);
    rf_d3 : in std_logic_vector(NUM_BITS - 1 downto 0);
    rf_d1, rf_d2 : out std_logic_vector(NUM_BITS - 1 downto 0);
    r7_ip : in std_logic_vector (NUM_BITS - 1 downto 0);
    r7_op : out std_logic_vector (NUM_BITS - 1 downto 0);
    rf_wr, r7_wr : in std_logic
  );
end entity RegFile;

architecture Register_file of RegFile is

type reg_file is array(0 to 7) of std_logic_vector(NUM_BITS - 1 downto 0);
signal rf : reg_file;

begin

rf_d1 <= rf(to_integer(unsigned(rf_a1)));
rf_d2 <= rf(to_integer(unsigned(rf_a2)));
r7_op <= rf(7);

process(rf_a1,rf_a2,rf_a3,r7_ip, CLK)
begin
  if CLK'event and CLK = '1' then
    if rf_wr = '1' then
      rf(to_integer(unsigned(rf_a3))) <= rf_d3;
    end if;
    if r7_wr = '1' then
      rf(7) <= r7_ip;
    end if;
  end if;
end process;
end Register_file;
