library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity user_flagz is
Generic (NUM_BITS : INTEGER :=1);
  port (EN, reset, CLK: in std_logic;
        ip: in std_logic;
        op: out std_logic);
end entity;

architecture reg_arch of user_flagz is
begin
reg1 : process(CLK, EN, ip)
begin
  if CLK'event and CLK = '1' then
    if reset = '1' then
      op <= '0';
    elsif EN = '1' then
      op <= ip;
    end if;
  end if;
end process;

end reg_arch;

-----------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity user_flagc is
Generic (NUM_BITS : INTEGER :=1);
  port (EN, reset, CLK: in std_logic;
        ip: in std_logic;
        op: out std_logic);
end entity;

architecture reg_arch of user_flagc is
begin
reg1 : process(CLK, EN, ip)
begin
  if CLK'event and CLK = '1' then
    if reset = '1' then
      op<= '0';
    elsif EN = '1' then
      op <= ip;
    end if;
  end if;
end process;

end reg_arch;

----------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WB_stage is
port(clock,reset:in std_logic;
mem_reg_op:in std_logic_vector(76 downto 0);
alu2_out,memd_out,PC_mem,left_shifted:out std_logic_vector(15 downto 0);
memi_35,memi_911,PE1_dest: out std_logic_vector(2 downto 0);
memrf_en,user_cflag,user_zflag:out std_logic;
RF_a3_control_mux,RF_d3_control_mux:out std_logic_vector(1 downto 0)

);

end entity;

architecture Behave of WB_stage is

component user_flagz is
Generic (NUM_BITS : INTEGER :=1);
  port (EN, reset, CLK: in std_logic;
        ip: in std_logic;
        op: out std_logic
      );
end component;

component user_flagc is
Generic (NUM_BITS : INTEGER :=1);
  port (EN, reset, CLK: in std_logic;
        ip: in std_logic;
        op: out std_logic
      );
end component;

begin

a: user_flagz port map(EN=>mem_reg_op(6),CLK=>clock,reset=>reset,ip=>mem_reg_op(1),op=>user_zflag);
b: user_flagc port map(EN=>mem_reg_op(7),CLK=>clock,reset=>reset,ip=>mem_reg_op(2),op=>user_cflag);
left_shifted(15 downto 7)<=mem_reg_op(53 downto 45);
left_shifted(6 downto 0)<="0000000";
alu2_out<=mem_reg_op(28 downto 13);
memd_out<=mem_reg_op(44 downto 29);
PC_mem<=mem_reg_op(76 downto 61);
memi_35<=mem_reg_op(50 downto 48);
memi_911<=mem_reg_op(56 downto 54);
PE1_dest<=mem_reg_op(5 downto 3);
memrf_en<=mem_reg_op(12);
RF_a3_control_mux<=mem_reg_op(11 downto 10);
RF_d3_control_mux<=mem_reg_op(9 downto 8);
end Behave;