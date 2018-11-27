library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rem_controls is
port(
ID_opcode,OR_opcode,EX_opcode,mem_opcode,IF_opcode:in std_logic_vector(5 downto 0);
dest_EX,dest_OR,dest_IF,RS_id1: in std_logic_vector(2 downto 0);
nullify_ID,nullify_OR,nullify_EX,alu2z_flag,authentic_c,authentic_z,validate_IF:in std_logic;
PE1_op,PE2_op:in std_logic_vector(7 downto 0);
PC_en_control,ID_en,ID_en_8bits,validate_control_if,nullify_control_id,nullify_control_or,nullify_control_ex: out std_logic;
PC_control: out std_logic_vector(2 downto 0)
);
end entity;

architecture Behave of rem_controls is
begin
process(ID_opcode,OR_opcode,EX_opcode,mem_opcode,IF_opcode,dest_EX,dest_OR,dest_IF,RS_id1,nullify_ID,nullify_OR,nullify_EX,alu2z_flag,authentic_c,authentic_z,validate_IF,PE1_op,PE2_op)
begin
	if(((EX_opcode = "") or (EX_opcode = "")) and (dest_EX = ""))


end Behave
