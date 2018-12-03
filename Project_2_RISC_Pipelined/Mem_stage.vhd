library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_data is
  port(clk: in std_logic;
      mem_write: in std_logic;
      address: in std_logic_vector(15 downto 0);
      data_in: in std_logic_vector(15 downto 0);
      data_out: out std_logic_vector(15 downto 0));
end entity;

architecture mem of memory_data is
  type RAM_array is array (0 to 2**16-1) of std_logic_vector (15 downto 0);
	signal RAM : RAM_array:= (X"3201",X"3603",X"3A05",X"702A",X"6058",X"C285",others=>X"0000");
begin
  process(clk, mem_write, data_in, address, RAM)
    begin
    if rising_edge(clk) then
      if(mem_write = '1') then
        RAM(to_integer(unsigned(address)))<= data_in;
      end if;
    end if;
      data_out <= RAM(to_integer(unsigned(address)));
  end process;
end architecture mem;

------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_interface_reg is
Generic (NUM_BITS : INTEGER := 77);
  port (EN, reset, CLK: in std_logic;
        ip: in std_logic_vector(NUM_BITS-1 downto 0);
        op: out std_logic_vector(NUM_BITS-1 downto 0)
      );
end entity;

architecture reg_arch of mem_interface_reg is
begin
reg1 : process(CLK, EN, ip)
begin
  if CLK'event and CLK = '1' then
    if reset = '1' then
      op(NUM_BITS-1 downto 0) <= (others=>'0');
    elsif EN = '1' then
      op <= ip;
    end if;
  end if;
end process;

end reg_arch;

-------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mem_stage is
 port(
 reset,clock,nullify_control_mem:in std_logic;
 EX_reg_op:in std_logic_vector(93 downto 0);
 memd_out: out std_logic_vector(15 downto 0);
 Mem_reg_op:out std_logic_vector(76 downto 0);
 load_flag_z: out std_logic
);

end entity;

architecture Behave of Mem_stage is
component memory_data is
  port(clk: in std_logic;
      mem_write: in std_logic;
      address: in std_logic_vector(15 downto 0);
      data_in: in std_logic_vector(15 downto 0);
      data_out: out std_logic_vector(15 downto 0));
end component;

component mem_interface_reg is
Generic (NUM_BITS : INTEGER := 77);
  port (EN, reset, CLK: in std_logic;
        ip: in std_logic_vector(NUM_BITS-1 downto 0);
        op: out std_logic_vector(NUM_BITS-1 downto 0)
      );
end component;

signal memd_z_flag,memd_muxz_output: std_logic;
signal mem_muxaddr_op ,mem_data_out_sig,mem_mux_datain_op: std_logic_vector(15 downto 0);
signal dummy_mem_write: std_logic;
begin
dummy_mem_write<=(EX_reg_op(60) and not(EX_reg_op(0)));

a: memory_data port map(clk=>clock,
                        mem_write=>dummy_mem_write,
                        address=>mem_muxaddr_op,
                        data_in=>mem_mux_datain_op,
                        data_out=>mem_data_out_sig);

b:mem_interface_reg port map(EN=>'1',
                              CLK=>clock,
                              reset=>reset,
                              ip(76 downto 61)=>EX_reg_op(93 downto 78),
                              ip(60 downto 45)=>EX_reg_op(77 downto 62),
                              ip(44 downto 29)=>mem_data_out_sig,
                              ip(28 downto 13)=>EX_reg_op(53 downto 38),
                              ip(5 downto 3)=>EX_reg_op(5 downto 3),
                              ip(2)=>EX_reg_op(2),
                              ip(1)=>memd_muxz_output,
                              ip(0)=>nullify_control_mem,
                              ip(12)=>EX_reg_op(61),
                              ip(11 downto 6)=>EX_reg_op(59 downto 54),
                              op=>Mem_reg_op);

memd_out<= mem_data_out_sig;
load_flag_z<=memd_muxz_output;

process(mem_data_out_sig)
begin
if (mem_data_out_sig = "0000000000000000")then
  memd_z_flag<='1';
else
  memd_z_flag<='0';
end if;
end process;

process(EX_reg_op,memd_z_flag)
begin
if((EX_reg_op(77 downto 74)="0100") and (EX_reg_op(0)='0')) then
  memd_muxz_output<=memd_z_flag;
else
  memd_muxz_output<=EX_reg_op(1);
end if;
end process;

process(EX_reg_op)
begin
if (EX_reg_op(77 downto 74)="0111" ) then
  mem_mux_datain_op<=EX_reg_op(21 downto 6);
else
  mem_mux_datain_op<=EX_reg_op(37 downto 22);
end if;
end process;

process(EX_reg_op)
begin
if ((EX_reg_op(77 downto 74) = "0111") or ((EX_reg_op(77 downto 74) = "0110"))) then
  mem_muxaddr_op<=std_logic_vector(unsigned(EX_reg_op(53 downto 38)) - 1);
else
  mem_muxaddr_op<=EX_reg_op(53 downto 38);
end if;
end process;
end Behave;
