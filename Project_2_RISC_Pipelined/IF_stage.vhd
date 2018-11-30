library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_instruction is
  port(
      address: in std_logic_vector(15 downto 0);
      data_out: out std_logic_vector(15 downto 0));
end entity;
architecture mem of memory_instruction is
  type RAM_array is array (0 to 2**16-1) of std_logic_vector (15 downto 0);
	signal RAM : RAM_array:= (X"4280",X"5440",X"4680",others=>X"0000");
begin
      data_out <= RAM(to_integer(unsigned(address)));
end architecture mem;
-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity PC is
Generic (NUM_BITS : INTEGER := 16);
  port (EN, reset, CLK: in std_logic;
        ip: in std_logic_vector(NUM_BITS-1 downto 0);
        op: out std_logic_vector(NUM_BITS-1 downto 0)
      );
end entity;

architecture reg_arch of PC is
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
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_1 is
  port(
      alu_in: in std_logic_vector(15 downto 0);
      alu_out: out std_logic_vector(15 downto 0));
end entity;
architecture al of ALU_1 is
  begin
  process (alu_in)
    variable alu_out_var: std_logic_vector(15 downto 0);
    begin
    alu_out_var := std_logic_vector(unsigned(alu_in) + 1);
    alu_out <= alu_out_var;
  end process;
end architecture al;
-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity IF_interface_reg is
Generic (NUM_BITS : INTEGER := 33);
  port (EN, reset, CLK: in std_logic;
        ip: in std_logic_vector(NUM_BITS-1 downto 0);
        op: out std_logic_vector(NUM_BITS-1 downto 0)
      );
end entity;

architecture reg_arch of IF_interface_reg is
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
-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity IF_stage is
  port(reset,clock,validate_control,PC_en_control,IF_en: in std_logic;
  PC_control: in std_logic_vector(2 downto 0);
  IF_reg_op : out std_logic_vector (32 downto 0);
  alu3_ex,alu3_out,alu2_out,memd_out,RF_d2,memid_08:in std_logic_vector(15 downto 0)
  );
end entity;
architecture arc of IF_stage is

component memory_instruction is
  port(
      address: in std_logic_vector(15 downto 0);
      data_out: out std_logic_vector(15 downto 0));
end component;

component PC is
Generic (NUM_BITS : INTEGER := 16);
  port (EN, reset, CLK: in std_logic;
        ip: in std_logic_vector(NUM_BITS-1 downto 0);
        op: out std_logic_vector(NUM_BITS-1 downto 0)
      );
end component;

component ALU_1 is
  port(
      alu_in: in std_logic_vector(15 downto 0);
      alu_out: out std_logic_vector(15 downto 0));
end component;

component IF_interface_reg is
Generic (NUM_BITS : INTEGER := 33);
  port (EN, reset, CLK: in std_logic;
        ip: in std_logic_vector(NUM_BITS-1 downto 0);
        op: out std_logic_vector(NUM_BITS-1 downto 0)
      );
end component;
signal PC_out,PC_in: std_logic_vector(15 downto 0);
signal ALU1_out,mem_instr_out: std_logic_vector(15 downto 0);

begin

a: PC port map(EN => PC_en_control,CLK=>clock,reset=>reset,ip=>PC_in,op=>PC_out);
b: memory_instruction port map(address=>PC_out,data_out=>mem_instr_out);
c: ALU_1 port map(alu_in=>PC_out,alu_out=>ALU1_out);
d: IF_interface_reg port map(
		EN=>IF_en,
		reset=>reset,
		CLk=>clock,
		ip(32 downto 17)=>PC_out,
		ip(16 downto 1)=>mem_instr_out,
		ip(0)=>validate_control,
		op=>IF_reg_op);

process(PC_control,ALU1_out,memd_out,alu3_ex,alu2_out,alu3_out,RF_d2,memid_08)
  begin
  if (PC_control = "000") then
    PC_in<=ALU1_out;
  elsif (PC_control = "001") then
    PC_in<=memd_out;
  elsif (PC_control = "010") then
    PC_in<=alu2_out;
  elsif (PC_control = "011") then
    PC_in<=alu3_out;
  elsif (PC_control = "100") then
    PC_in<=RF_d2;
  elsif (PC_control = "101") then
    PC_in<=memid_08;
  elsif (PC_control = "110") then
    PC_in<=alu3_ex;
  else
    PC_in<=ALU1_out;
  end if;
end process;


end arc;
