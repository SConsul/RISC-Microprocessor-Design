library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity write_control is

port(
opcode_mem,opcode_EX,opcode_OR: in std_logic_vector(5 downto 0);
flag_z_ex,flag_c_ex,flag_z_mem,flag_c_mem,flagz_enable_ex,flagc_enable_ex,load_flag_z,nullify_ex,rf_write_or,flagc_write_or,flagz_write_or: in std logic;
RF_write_out,flagc_write_out,flagz_write_out: out std_logic
);

end entity;

architecture Behave of write_control is
signal authentic_z,authentic_c: std_logic;
begin
process(flag_z_ex,flag_z_mem,opcode_mem,opcode_EX,flagz_enable_ex)
begin
	if(((opcode_EX = "000001")or (opcode_EX ="001001")) and (flagz_enable_ex = '0')) then
		authentic_z<=flag_z_mem;
	else
		authentic_z<=flag_z_ex;
end if;
end process;

process(flag_c_ex,flag_c_mem,opcode_mem,opcode_EX,flagc_enable_ex)
begin
	if(((opcode_EX = "000010")or (opcode_EX ="001010")) and (flagc_enable_ex = '0')) then
		authentic_c<=flag_c_mem;
	else
		authentic_c<=flag_c_ex;
end if;
end process;

process(authentic_c,authentic_z,opcode_EX,opcode_OR,load_flag_z,nullify_ex)
begin
	if((((opcode_OR = "000001") or (opcode_OR = "001001")) and (authentic_z = '0')) or (((opcode_OR = "000010") or (opcode_OR = "001010")) and (authentic_c = '0')) or ((opcode_EX(5 downto 2) = "0100") and ((opcode_OR = "000001") or (opcode_OR = "001001")) and (load_flag_z = '0') and (nullify_ex = '0'))) then
		RF_write_out<='0';
		flagc_write_out<='0';
		flagz_write_out<='0';
	else
		RF_write_out<=rf_write_or;
		flagc_write_out<=flagc_write_or;
		flagz_write_out<=flagz_write_or;
	end if;
end process;
end Behave;



