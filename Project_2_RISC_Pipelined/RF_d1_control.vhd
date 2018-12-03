library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RF_d1_control is
port(
RS_id1,RD_or,RD_ex,RD_mem: in std_logic_vector(2 downto 0);
ID_opcode: in std_logic_vector(3 downto 0);
EX_opcode,OR_opcode,mem_opcode: in std_logic_vector(5 downto 0);
PE1_op,PE2_stored: in std_logic_vector(7 downto 0);
authentic_c,authentic_z,nullify_or,nullify_id,nullify_ex,nullify_mem,user_cflag,user_zflag: in std_logic;
RF_d1_mux_control: out std_logic_vector(3 downto 0)
);

end entity;

architecture Behave of RF_d1_control is
begin
process(RS_id1,RD_or,RD_ex,RD_mem,ID_opcode,EX_opcode,OR_opcode,mem_opcode,authentic_c,authentic_z,nullify_or,nullify_id,nullify_ex,nullify_mem,PE1_op,PE2_stored,user_cflag,user_zflag)
begin
if((OR_opcode(5 downto 2) = "0110" and nullify_or ='0' and PE1_op /= "00000000") or (OR_opcode(5 downto 2) = "0111" and nullify_or ='0' and PE2_stored /= "00000000")) then
	RF_d1_mux_control<="0001";

elsif(((ID_opcode = "0000") or (ID_opcode = "0001") or (ID_opcode = "0010") or (ID_opcode = "0101") or (ID_opcode = "0111") ) and (nullify_id  = '0')) then
	if((((OR_opcode(5 downto 2) = "0000") or (OR_opcode(5 downto 2) = "0001") or (OR_opcode(5 downto 2) = "0010") or (OR_opcode(5 downto 2) = "0011")) and (nullify_or  = '0')) and (RS_id1 = RD_or)) then

		if((OR_opcode(5 downto 0) = "000000") or (OR_opcode(5 downto 2) = "0001") or (OR_opcode(5 downto 0) = "001000")) then
			RF_d1_mux_control<="0001";
		elsif((((OR_opcode(5 downto 0) = "000010") or (OR_opcode(5 downto 0) = "001010")) and (authentic_c = '1')) or (((OR_opcode(5 downto 0) = "000001") or (OR_opcode(5 downto 0) = "001001"))and (authentic_z = '1')) ) then
			RF_d1_mux_control<="0001";
		elsif (OR_opcode(5 downto 2) = "0011") then
			RF_d1_mux_control<="0110";
		else
			RF_d1_mux_control<="0000";

		end if;

	elsif((((EX_opcode(5 downto 2) = "0000") or (EX_opcode(5 downto 2) = "0001") or (EX_opcode(5 downto 2) = "0010") or (EX_opcode(5 downto 2) = "0100") or (EX_opcode(5 downto 2) = "0011")
	 or (EX_opcode(5 downto 2) = "0110")) and (nullify_ex  = '0'))
	 and (RS_id1 = RD_ex)) then
		if((EX_opcode(5 downto 0) = "000000") or (EX_opcode(5 downto 2) = "0001") or (EX_opcode(5 downto 0) = "001000")) then
			RF_d1_mux_control<="0011";
		elsif((((EX_opcode(5 downto 0) = "000010") or (EX_opcode(5 downto 0) = "001010")) and (authentic_c = '1')) or
		(((EX_opcode(5 downto 0) = "000001") or (EX_opcode(5 downto 0) = "001001"))and (authentic_z = '1'))) then
			RF_d1_mux_control<="0011";
		elsif ((EX_opcode(5 downto 2) = "0100") or EX_opcode(5 downto 2) = "0110") then
			RF_d1_mux_control<="0010";
		elsif ((EX_opcode(5 downto 2) = "0011")) then
			RF_d1_mux_control<="0111";
		else
			RF_d1_mux_control<="0000";
		end if;

	elsif((((mem_opcode(5 downto 2) = "0000") or (mem_opcode(5 downto 2) = "0001") or (mem_opcode(5 downto 2) = "0010") or (mem_opcode(5 downto 2) = "0100") or (mem_opcode(5 downto 2) = "0110") or
	(mem_opcode(5 downto 2) = "0011")) and (nullify_mem  = '0')) and (RS_id1 = RD_mem)) then
		if((mem_opcode(5 downto 0) = "000000") or (mem_opcode(5 downto 2) = "0001") or (mem_opcode(5 downto 0) = "001000")) then
			RF_d1_mux_control<="0100";
		elsif((((mem_opcode(5 downto 0) = "000010") or (mem_opcode(5 downto 0) = "001010")) and (user_cflag = '1')) or (((mem_opcode(5 downto 0) = "000001") or (mem_opcode(5 downto 0) = "001001"))and (user_zflag = '1')) ) then
			RF_d1_mux_control<="0100";
		elsif((mem_opcode(5 downto 2) = "0100") or (mem_opcode(5 downto 2) = "0110") ) then
			RF_d1_mux_control<="0101";
		elsif (mem_opcode(5 downto 2) = "0011") then
			RF_d1_mux_control<="1000";
		else
			RF_d1_mux_control<="0000";
		end if;

	else
		RF_d1_mux_control<="0000";
	end if;

else
	RF_d1_mux_control<="0000";
end if;

end process;
end Behave;
