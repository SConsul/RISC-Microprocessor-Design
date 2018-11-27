library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PE2_mux_control is
port(
ID_reg_opcode: in std_logic_vector(3 downto 0);
nullified_id: in std_logic;
PE2_mux_controller:out std_logic
);
end entity;

architecture Behave of PE2_mux_control is
	begin
	process(ID_reg_opcode,nullified_id)
	begin
	if(ID_reg_opcode = "0111" and nullified_id='0') then
		PE2_mux_controller<='1';
	else
		PE2_mux_controller<='0';
end if;
end process;
end Behave;