
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rem_controls is
port(
ID_opcode,OR_opcode,EX_opcode,mem_opcode,IF_opcode:in std_logic_vector(5 downto 0);
dest_EX,dest_OR,dest_IF,dest_ID,RS_id1,RS_id2: in std_logic_vector(2 downto 0);
nullify_ID,nullify_OR,nullify_EX,alu2z_flag,authentic_c,authentic_z,validate_IF:in std_logic;
PE1_op,PE2_op:in std_logic_vector(7 downto 0);
PC_en_control,ID_en,ID_en_8bits,validate_control_if,nullify_control_id,nullify_control_or,nullify_control_ex,nullify_control_mem,IF_en: out std_logic;
PC_control: out std_logic_vector(2 downto 0);
ID_intermediate_reg :in std_logic_vector(32 downto 0);
OR_intermediate_reg: in std_logic_vector (51 downto 0);
EX_intermediate_reg: in std_logic_vector (99 downto 0)
);
end entity;

architecture Behave of rem_controls is


signal pc_control_lmlhi,pc_control_smlhi:std_logic_vector(2 downto 0);



begin



process(ID_opcode,OR_opcode,EX_opcode,mem_opcode,ID_intermediate_reg,OR_intermediate_reg,EX_intermediate_reg,IF_opcode,dest_EX,dest_OR,dest_IF,dest_ID,RS_id1,nullify_ID,nullify_OR,nullify_EX,alu2z_flag,authentic_c,authentic_z,validate_IF,PE1_op,PE2_op,pc_control_lmlhi,pc_control_smlhi,RS_id2)
begin
	if ((IF_opcode(5 downto 2) = "0011") and (dest_IF = "111") and (validate_IF = '1')) then
		PC_en_control <= '1';
		ID_en<='1';
		ID_en_8bits<='1';
		PC_control <= "101"; --pc_control_lmlhi and pc_control_smlhi will be 101 if lhi in IF and not  nullified with dest R7 else 000
		validate_control_if<='0';
		nullify_control_id<=not validate_IF;
		nullify_control_or<=nullify_ID;
		nullify_control_ex<=nullify_OR;
		nullify_control_mem<=nullify_EX;
		IF_en<='1';
	elsif(((EX_opcode(5 downto 2) = "0100") or (EX_opcode(5 downto 2) = "0110")) and (dest_EX = "111") and (nullify_EX = '0')) then
			PC_control <= "001";
			PC_en_control <= '1';
			validate_control_if<='0';
			nullify_control_id<='1';
			nullify_control_or<='1';
			nullify_control_ex<='1';
			nullify_control_mem<=nullify_EX;
			ID_en<='1';
			ID_en_8bits<='1';
			IF_en<='1';
	elsif(((OR_opcode = "000000") or (OR_opcode = "001000") or (OR_opcode(5 downto 2) = "0001")) and (dest_OR = "111") and (nullify_OR = '0')) then
			PC_control <= "010";
			PC_en_control <= '1';
			validate_control_if<='0';
			nullify_control_id<='1';
			nullify_control_or<='1';
			nullify_control_ex<='0';
			nullify_control_mem<=nullify_EX;
			ID_en<='1';
			ID_en_8bits<='1';
			IF_en<='1';
	elsif (((OR_opcode = "000001") or (OR_opcode = "001001")) and (dest_OR = "111") and (nullify_OR = '0') and authentic_z = '1') then
			PC_control <= "010";
			PC_en_control <= '1';
			validate_control_if<='0';
			nullify_control_id<='1';
			nullify_control_or<='1';
			nullify_control_ex<='0';
			nullify_control_mem<=nullify_EX;
			ID_en<='1';
			ID_en_8bits<='1';
			IF_en<='1';
	elsif (((OR_opcode = "000010") or (OR_opcode = "001010")) and (dest_OR = "111") and (nullify_OR = '0') and authentic_c = '1') then
			PC_control <= "010";
			PC_en_control <= '1';
			validate_control_if<='0';
			nullify_control_id<='1';
			nullify_control_or<='1';
			nullify_control_ex<='0';
			nullify_control_mem<=nullify_EX;
			ID_en<='1';
			ID_en_8bits<='1';
			IF_en<='1';
	elsif ((OR_opcode(5 downto 2) = "1100") and (nullify_OR = '0') and (alu2z_flag = '1')) then
			PC_control <= "110";
			PC_en_control <= '1';
			validate_control_if<='0';
			nullify_control_id<='1';
			nullify_control_or<='1';
			nullify_control_ex<='0';
			nullify_control_mem<=nullify_EX;
			ID_en<='1';
			ID_en_8bits<='1';
			IF_en<='1';
	elsif (((ID_opcode(5 downto 2) = "1000") or (ID_opcode(5 downto 2) = "1001")) and  (nullify_ID = '0')) then
			if (ID_opcode(5 downto 2) = "1000") then
				PC_control <= "011";
			else
				PC_control <= "100";
			end if;
			PC_en_control <= '1';
			validate_control_if<='0';
			nullify_control_id<='1';
			nullify_control_or<='0';
			nullify_control_ex<=nullify_OR;
			nullify_control_mem<=nullify_EX;
			ID_en<='1';
			ID_en_8bits<='1';
			IF_en<='1';
	elsif (((EX_intermediate_reg(83 downto 80) = "0110") and (EX_intermediate_reg(8) = '0') and (PE1_op = "00000000"))
	 or ((ID_intermediate_reg(16 downto 13) = "0110") and (ID_intermediate_reg(0) = '1'))
	 or ((OR_intermediate_reg(35 downto 32) = "0110") and (OR_intermediate_reg(8) = '0') and ((PE1_op /= "00000000") or (PE2_op /= "00000000")))) then
			if((EX_intermediate_reg(83 downto 80) = "0110") and (EX_intermediate_reg(8) = '0') and (PE1_op = "00000000")) then
				PC_en_control <= '1';
				ID_en<='1';
				ID_en_8bits<='1';
				PC_control <= pc_control_lmlhi;
				validate_control_if<='1';
				nullify_control_id<=not validate_IF;
				nullify_control_or<='1';
				nullify_control_ex<=nullify_OR;
				nullify_control_mem<=nullify_EX;
				IF_en<='1';
			elsif((OR_intermediate_reg(35 downto 32) = "0110") and (OR_intermediate_reg(8) = '0') and ((PE1_op /= "00000000") or (PE2_op /= "00000000"))) then
				PC_en_control <= '0';
				ID_en<='0';
				ID_en_8bits<='0';
				PC_control <= pc_control_lmlhi;
				validate_control_if<='1';
				nullify_control_id<=not validate_IF;
				nullify_control_or<='0';
				nullify_control_ex<=nullify_OR;
				nullify_control_mem<=nullify_EX;
				IF_en<='1';
			else
				PC_en_control <= '0';
				ID_en<='1';
				ID_en_8bits<='1';
				PC_control <= "000";
				validate_control_if<='1';
				nullify_control_id<=not validate_IF;
				nullify_control_or<=nullify_ID;
				nullify_control_ex<=nullify_OR;
				nullify_control_mem<=nullify_EX;
				IF_en<='1';
			end if;
	elsif(((ID_intermediate_reg(16 downto 13) = "0111") and (ID_intermediate_reg(0) = '1')) or
				((OR_intermediate_reg(35 downto 32) = "0111") and (OR_intermediate_reg(8) = '0')))  then
			if  ((OR_intermediate_reg(35 downto 32) = "0111") and (OR_intermediate_reg(8) = '0') and (PE2_op = "00000000")) then
				PC_en_control <= '1';
				ID_en<='1';
				ID_en_8bits<='1';
				PC_control <= pc_control_smlhi;
				validate_control_if<='1';
				nullify_control_id<='1';
				nullify_control_or<=nullify_ID;
				nullify_control_ex<=nullify_OR;
				nullify_control_mem<=nullify_EX;
				IF_en<='1';
			elsif ((OR_intermediate_reg(35 downto 32) = "0111") and (OR_intermediate_reg(8) = '0') and (PE2_op /= "00000000")) then
				PC_en_control <= '0';
				ID_en<='0';
				ID_en_8bits<='1';
				PC_control <= pc_control_smlhi;
				validate_control_if<='1';
				nullify_control_id<=not validate_IF;
				nullify_control_or<=nullify_ID;
				nullify_control_ex<=nullify_OR;
				nullify_control_mem<=nullify_EX;
				IF_en<='1';
			else
				PC_en_control <= '0';
				ID_en<='1';
				ID_en_8bits<='1';
				PC_control <= "000";
				validate_control_if<='1';
				nullify_control_id<=not validate_IF;
				nullify_control_or<=nullify_ID;
				nullify_control_ex<=nullify_OR;
				nullify_control_mem<=nullify_EX;
				IF_en<='1';
			end if;
	elsif(((OR_opcode(5 downto 2) = "0100") and (nullify_OR = '0') and ((RS_id1 = dest_OR) or (RS_id2 = dest_OR))
	and ((ID_opcode(5 downto 2) = "0000") or (ID_opcode(5 downto 2) = "0010") or (ID_opcode(5 downto 2) = "0001") or (ID_opcode(5 downto 2) = "0101") ))) then
		if((OR_opcode(5 downto 2) = "0100") and (nullify_OR = '0') and (RS_id1 = dest_OR)and ((ID_opcode(5 downto 2) = "0000") or (ID_opcode(5 downto 2) = "0010") or (ID_opcode(5 downto 2) = "0001")or (ID_opcode(5 downto 2) = "0101"))) then
			PC_en_control <= '0';
			ID_en<='0';
			ID_en_8bits<='0';
			PC_control <= "000";
			validate_control_if<='1';
			nullify_control_id<=not validate_IF;
			nullify_control_or<='1';
			nullify_control_ex<=nullify_OR;
			nullify_control_mem<=nullify_EX;
			IF_en<='0';
		else
			PC_en_control <= '1';
			ID_en<='1';
			ID_en_8bits<='1';
			PC_control <= "000";
			validate_control_if<='1';
			nullify_control_id<=not validate_IF;
			nullify_control_or<=nullify_ID;
			nullify_control_ex<=nullify_OR;
			nullify_control_mem<=nullify_EX;
			IF_en<='1';
		end if;
		if((OR_opcode(5 downto 2) = "0100") and (nullify_OR = '0') and (RS_id2 = dest_OR)and ((ID_opcode(5 downto 2) = "0000") or (ID_opcode(5 downto 2) = "0010") or (ID_opcode(5 downto 2) = "0101") ))then
			PC_en_control <= '0';
			ID_en<='0';
			ID_en_8bits<='0';
			PC_control <= "000";
			validate_control_if<='1';
			nullify_control_id<=not validate_IF;
			nullify_control_or<='1';
			nullify_control_ex<=nullify_OR;
			nullify_control_mem<=nullify_EX;
			IF_en<='0';
		else
			PC_en_control <= '1';
			ID_en<='1';
			ID_en_8bits<='1';
			PC_control <= "000";
			validate_control_if<='1';
			nullify_control_id<=not validate_IF;
			nullify_control_or<=nullify_ID;
			nullify_control_ex<=nullify_OR;
			nullify_control_mem<=nullify_EX;
			IF_en<='1';
		end if;
else
	PC_en_control <= '1';
	ID_en<='1';
	ID_en_8bits<='1';
	PC_control <= "000";
	validate_control_if<='1';
	nullify_control_id<=not validate_IF;
	nullify_control_or<=nullify_ID;
	nullify_control_ex<=nullify_OR;
	nullify_control_mem<=nullify_EX;
	IF_en<='1';
end if;
end process;

process(IF_opcode,dest_IF,validate_IF)
begin
	if ((IF_opcode(5 downto 2) = "0011") and (dest_IF = "111") and (validate_IF = '1')) then
		pc_control_lmlhi <= "101";
		pc_control_smlhi <= "101";
	else
		pc_control_lmlhi <= "000";
		pc_control_smlhi <= "000";
	end if;
end process;

end Behave;
