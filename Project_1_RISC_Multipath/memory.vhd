use ieee.std_logic_1164.all;
entity memory is
  port(clk: in std_logic;
      mem_write_bar: in std_logic
      address: in std_logic_vector(15 downto 0);
      data_in: in std_logic_vector(15 downto 0));
      data_out: out std_logic_vector(15 downto 0));
end entity;

architecture mem of memory is
  type RAM_array is array (0 to 2**16-1) of std_logic_vector (15 downto 0);

begin
  process(clk, mem_write_bar, data, address)
    begin
    if rising_edge(clk) then
      if(mem_write_bar = '0') then
        RAM_array(to_integer(unsigned(address)))<= data_in;
      end if;
    end if;
      data_out <= RAM_array(to_integer(unsigned(address)));
  end process;
end architecture mem;
T2toR7
