library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PE1_mux_control is
port(
OR_reg_opcode: in std_logic_vector(3 downto 0);
nullified_or: in std_logic;
PE1_mux_controller:out std_logic
);
end entity;

architecture Behave of PE1_mux_control is
	begin
	process(OR_reg_opcode,nullified_or)
	begin
	if(OR_reg_opcode = "0110" and nullified_or='0') then
		PE1_mux_controller<='1';
	else
		PE1_mux_controller<='0';
end if;
end process;
end Behave;


