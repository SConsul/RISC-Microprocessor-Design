use ieee.std_logic_1164.all;
entity memory is
  port(clk: in std_logic;
      mem_write_bar: in std_logic
      address: in std_logic_vector(15 downto 0);
      data: inout std_logic_vector(15 downto 0));
end entity;

architecture mem of memory is
  type RAM_array is array (0 to 2**16-1) of std_ulogic_vector (15 downto 0);

begin
  process(clk, mem_write_bar, data, address)
    begin
    if(mem_write_bar = '0') then
      if rising_edge(clk) then
        RAM_array(to_integer(unsigned(address)))<= data;
      end if;
    else
      data <= RAM_array(to_integer(unsigned(address)));
    end if;
  end process;
end architecture mem;
T2toR7
