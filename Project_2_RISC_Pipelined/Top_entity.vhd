
----------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Top_entity is
port(
clock,reset: in std_logic
);
end entity;

architecture Behave of Top_entity is

---------------------------------

component IF_stage is
  port(reset,clock,validate_control,PC_en_control,IF_en: in std_logic;
  PC_control: in std_logic_vector(2 downto 0);
  IF_reg_op : out std_logic_vector (32 downto 0);
  alu3_ex,alu3_out,alu2_out,memd_out,RF_d2,memid_08:in std_logic_vector(15 downto 0)
  );
end component;
--------------------
component ID_stage is
  port(reset,clock,nullify_ID_control,PE2_mux_control,EN_id_control,EN_8bits_control: in std_logic;
  PE2_ip: std_logic_vector (7 downto 0);
  IF_reg_op :in std_logic_vector(32 downto 0);
  ID_reg_op : out std_logic_vector (51 downto 0);
  mem_id_08: out std_logic_vector (15 downto 0)
  );
end component;
--------------------
component OR_stage is
    port(ID_reg_op: in std_logic_vector (51 downto 0);
    PC_ex,alu2_out_mem,memd_out,PC_mem,left_shifted,alu2_forward,memd_forward,EX_reg_op_ALU2,mem_reg_op_ALU2,mem_reg_memd,instr08_OR,instr08_EX,instr08_mem: in std_logic_vector (15 downto 0);
    memi35_mem,memi911_mem,PE1_dest: in std_logic_vector (2 downto 0);
    nullify_ex,clock,reset,mem_rf_en,nullify_control_OR,PE1_mux_control: in std_logic;
    PE1_ip: in std_logic_vector (7 downto 0);
    OR_reg_op: out std_logic_vector (99 downto 0);
    PE2_op: out std_logic_vector (7 downto 0);
    RF_a3_control,RF_d3_control: in std_logic_vector(1 downto 0);
    RF_d1_mux_control,RF_d2_mux_control: std_logic_vector(3 downto 0);
	 	 PE2_dest : out std_logic_vector(2 downto 0);

    ALU3_op,RF_d2_or:out std_logic_vector (15 downto 0)
    );
end component;
-------------------
component EX_stage is
port (OR_reg_op: in std_logic_vector(99 downto 0);
	 RF_write_out,flagc_write_out,flagz_write_out: in std_logic;
	 PE1_op: out std_logic_vector (7 downto 0);
	 nullify_control_ex,reset,clock:in std_logic;
	 EX_reg_op: out std_logic_vector(93 downto 0);
	  alu3_ex,alu2_out,PCtoR7: out std_logic_vector(15 downto 0);
	 nullify_ex,alu2_z: out std_logic

);
end component;
-------------------
component Mem_stage is
 port(
 reset,clock,nullify_control_mem:in std_logic;
 EX_reg_op:in std_logic_vector(93 downto 0);
 memd_out: out std_logic_vector(15 downto 0);
 Mem_reg_op:out std_logic_vector(76 downto 0);
 load_flag_z: out std_logic
);

end component;
-------------------
component WB_stage is
port(clock,reset:in std_logic;
mem_reg_op:in std_logic_vector(76 downto 0);
alu2_out,memd_out,PC_mem,left_shifted:out std_logic_vector(15 downto 0);
memi_35,memi_911,PE1_dest: out std_logic_vector(2 downto 0);
memrf_en,user_cflag,user_zflag:out std_logic;
RF_a3_control_mux,RF_d3_control_mux:out std_logic_vector(1 downto 0)
);

end component;
-----------------
component rem_controls is
port(
ID_opcode,OR_opcode,EX_opcode,mem_opcode,IF_opcode:in std_logic_vector(5 downto 0);
dest_EX,dest_OR,dest_ID,dest_IF,RS_id1,RS_id2: in std_logic_vector(2 downto 0);
nullify_ID,nullify_OR,nullify_EX,alu2z_flag,authentic_c,authentic_z,validate_IF:in std_logic;
PE1_op,PE2_op:in std_logic_vector(7 downto 0);
PC_en_control,ID_en,ID_en_8bits,validate_control_if,nullify_control_id,nullify_control_or,nullify_control_ex,nullify_control_mem,IF_en: out std_logic;
PC_control: out std_logic_vector(2 downto 0);
ID_intermediate_reg :in std_logic_vector(32 downto 0);
OR_intermediate_reg: in std_logic_vector (51 downto 0);
EX_intermediate_reg: in std_logic_vector (99 downto 0)
);
end component;
-----------------
component PE1_mux_control
port(
OR_reg_opcode: in std_logic_vector(3 downto 0);
nullified_or: in std_logic;
PE1_mux_controller:out std_logic
);
end component;
-----------------
component PE2_mux_control
port(
ID_reg_opcode: in std_logic_vector(3 downto 0);
nullified_id: in std_logic;
PE2_mux_controller:out std_logic
);
end component;
-----------------
component write_control is

port(
opcode_mem,opcode_EX,opcode_OR: in std_logic_vector(5 downto 0);
flag_z_ex,flag_c_ex,flag_z_mem,flag_c_mem,user_flagc,user_flagz,flagz_enable_ex,flagc_enable_ex,flagz_enable_mem,flagc_enable_mem,load_flag_z,nullify_ex,rf_write_or,flagc_write_or,flagz_write_or: in std_logic;
RF_write_out,flagc_write_out,flagz_write_out,authentic_c_op,authentic_z_op: out std_logic
);

end component;

----------------
component RF_d1_control is
port(
RS_id1,RD_or,RD_ex,RD_mem: in std_logic_vector(2 downto 0);
ID_opcode: in std_logic_vector(3 downto 0);
EX_opcode,OR_opcode,mem_opcode: in std_logic_vector(5 downto 0);
PE1_op,PE2_stored: in std_logic_vector(7 downto 0);
authentic_c,authentic_z,nullify_or,nullify_id,nullify_ex,nullify_mem,user_cflag,user_zflag: in std_logic;
RF_d1_mux_control: out std_logic_vector(3 downto 0)
);

end component;
---------------
component RF_d2_control is
port(
RS_id2,RD_or,RD_ex,RD_mem: in std_logic_vector(2 downto 0);
ID_opcode: in std_logic_vector(3 downto 0);
EX_opcode,OR_opcode,mem_opcode: in std_logic_vector(5 downto 0);
authentic_c,authentic_z,nullify_or,nullify_id,nullify_ex,nullify_mem,user_cflag,user_zflag: in std_logic;
RF_d2_mux_control: out std_logic_vector(3 downto 0)
);

end component;

signal validate_control_sig,
		PC_en_control_sig,
		nullify_ID_control_sig,
		PE2_mux_control_sig,
		PE1_mux_control_sig,
		nullify_ex_sig,
		nullify_control_OR_sig,
		nullify_control_ex_sig,
		nullify_control_mem_sig,
		RF_write_out_sig,
		flagc_write_out_sig,
		flagz_write_out_sig,
		alu2z_sig,
		load_flag_z_sig,
		mem_rf_en_sig,
		authentic_c_sig,
		authentic_z_sig,
		EN_id_control_sig,
		EN_8bits_control_sig,
		user_zflag_sig,
		user_cflag_sig,
    IF_en_sig: std_logic;
signal PE2_ip_signal,PE1_ip_signal:std_logic_vector(7 downto 0);
signal PC_control_sig,
		memi35_sig,
		memi911_sig,
		PE1_dest_sig,
		PE2_dest_sig,
    dest_EX_sig,
    dest_OR_sig,
    dest_ID_sig,
    dest_IF_sig,
    RS_id1_sig,
    RS_id2_sig,
    RD_ex_sig,
    RD_or_sig,
    RD_mem_sig: std_logic_vector(2 downto 0);
signal RF_d2_mux_control_sig,
	   RF_d1_mux_control_sig: std_logic_vector(3 downto 0);
signal OR_opcode_sig,
	   EX_opcode_sig,
	   mem_opcode_sig: std_logic_vector(5 downto 0);
signal alu3_out_sig,
	   alu2_out_sig,
	   alu2_out_mem_sig,
	   memd_sig,
	   memd_stored_sig,
	   RF_d2_sig,
	   memid_08_sig,
	   PCtoR7_sig,
	   left_shifted_sig,
	   PC_mem_sig,
     alu3_ex_sig: std_logic_vector(15 downto 0);
signal RF_a3_control_sig,RF_d3_control_sig: std_logic_vector(1 downto 0);
signal IF_reg_op_sig: std_logic_vector(32 downto 0);
signal ID_reg_op_sig: std_logic_vector(51 downto 0);
signal OR_reg_op_sig: std_logic_vector(99 downto 0);
signal EX_reg_op_sig: std_logic_vector(93 downto 0);
signal mem_reg_op_sig: std_logic_vector(76 downto 0);
-------------------------------------
begin

a: IF_stage port map(reset=>reset,
					clock=>clock,
					validate_control=>validate_control_sig,
					PC_en_control=>PC_en_control_sig,
					PC_control=>PC_control_sig,
					IF_reg_op=>IF_reg_op_sig,
					alu3_out=>alu3_out_sig,
					alu2_out=>alu2_out_sig,
					memd_out=>memd_sig,
					RF_d2=>RF_d2_sig,
					memid_08=>memid_08_sig,
          alu3_ex => alu3_ex_sig,
          IF_en=>IF_en_sig
          );

b: ID_stage port map(reset=>reset,
					clock=>clock,
					nullify_ID_control=>nullify_ID_control_sig,
					PE2_mux_control=>PE2_mux_control_sig,
					PE2_ip=>PE2_ip_signal,
					IF_reg_op=>IF_reg_op_sig,
					ID_reg_op=>ID_reg_op_sig,
					mem_id_08=>memid_08_sig,
					EN_id_control=>EN_id_control_sig,
					EN_8bits_control=>EN_8bits_control_sig
);

c: OR_stage port map (
					ID_reg_op=>ID_reg_op_sig,
    				PC_ex=>PCtoR7_sig,
    				alu2_out_mem=>alu2_out_mem_sig,
    				memd_out=>memd_stored_sig,
    				PC_mem=>PC_mem_sig,
    				left_shifted=>left_shifted_sig,
    				alu2_forward=>alu2_out_sig,
    				memd_forward=>memd_sig,
    				EX_reg_op_ALU2=>EX_reg_op_sig(53 downto 38),
    				mem_reg_op_ALU2=>alu2_out_mem_sig,
    				mem_reg_memd=>memd_stored_sig,
    				instr08_OR(15 downto 7)=>OR_reg_op_sig(76 downto 68),
    				instr08_OR(6 downto 0)=>"0000000",
    				instr08_EX(15 downto 7)=>EX_reg_op_sig(70 downto 62),
    				instr08_EX(6 downto 0)=>"0000000",
    				instr08_mem(15 downto 7)=>mem_reg_op_sig(53 downto 45),
    				instr08_mem(6 downto 0)=>"0000000",
    				memi35_mem=>memi35_sig,
    				memi911_mem=>memi911_sig,
    				PE1_dest=>PE1_dest_sig,
    				nullify_ex=>nullify_ex_sig,
    				clock=>clock,
    				reset=>reset,
    				mem_rf_en=>mem_rf_en_sig,
    				nullify_control_OR=>nullify_control_OR_sig,
    				PE1_mux_control=>PE1_mux_control_sig,
    				PE1_ip=>PE1_ip_signal,
    				OR_reg_op=>OR_reg_op_sig,
    				PE2_op=>PE2_ip_signal,
    				RF_d1_mux_control=>RF_d1_mux_control_sig,
    				RF_d2_mux_control=>RF_d2_mux_control_sig,
    				ALU3_op=>alu3_out_sig,
    				RF_d2_or=>RF_d2_sig,
    				RF_a3_control=>RF_a3_control_sig,
    				RF_d3_control=>RF_d3_control_sig,
					PE2_dest => PE2_dest_sig
);
d:EX_stage port map (
					OR_reg_op=>OR_reg_op_sig,
					RF_write_out=>RF_write_out_sig,
					flagc_write_out=>flagc_write_out_sig,
					flagz_write_out=>flagz_write_out_sig,
					PE1_op=>PE1_ip_signal,
					nullify_control_ex=>nullify_control_ex_sig,
					reset=>reset,
					clock=>clock,
					EX_reg_op=>EX_reg_op_sig,
					alu2_out=>alu2_out_sig,
					PCtoR7=>PCtoR7_sig,
					nullify_ex=>nullify_ex_sig,
					alu2_z=>alu2z_sig,
          alu3_ex => alu3_ex_sig
);

e:Mem_stage port map(
					reset=>reset,
					clock=>clock,
					nullify_control_mem=>nullify_control_mem_sig,
 					EX_reg_op=>EX_reg_op_sig,
 					memd_out=>memd_sig,
 					Mem_reg_op=>mem_reg_op_sig,
 					load_flag_z=>load_flag_z_sig
);
f: WB_stage port map(clock=>clock,
					 reset=>reset,
					mem_reg_op=>mem_reg_op_sig,
					alu2_out=>alu2_out_mem_sig,
					memd_out=>memd_stored_sig,
					PC_mem=>PC_mem_sig,
					left_shifted=>left_shifted_sig,
					memi_35=>memi35_sig,
					memi_911=>memi911_sig,
					PE1_dest=>PE1_dest_sig,
					memrf_en=>mem_rf_en_sig,
					user_zflag=>user_zflag_sig,
					user_cflag=>user_cflag_sig,
					RF_a3_control_mux=>RF_a3_control_sig,
					RF_d3_control_mux=>RF_d3_control_sig
);
g: rem_controls port map(
					ID_opcode(5 downto 2)=>ID_reg_op_sig(35 downto 32),
					ID_opcode(1 downto 0)=>ID_reg_op_sig(21 downto 20),
					OR_opcode=>OR_opcode_sig,
					EX_opcode=>EX_opcode_sig,
					mem_opcode=>mem_opcode_sig,
					IF_opcode(5 downto 2)=>IF_reg_op_sig(16 downto 13),
					IF_opcode(1 downto 0)=>IF_reg_op_sig(2 downto 1),
					dest_EX=>dest_EX_sig,
					dest_OR=>dest_OR_sig,
					dest_ID=>dest_ID_sig,
					dest_IF=>dest_IF_sig,
					RS_id1=>RS_id1_sig,
					RS_id2=>RS_id2_sig,
					nullify_ID=>ID_reg_op_sig(8),
					nullify_OR=>OR_reg_op_sig(8),
					nullify_EX=>nullify_ex_sig,
					alu2z_flag=>alu2z_sig,
					authentic_c=>authentic_c_sig,
					authentic_z=>authentic_z_sig,
					validate_IF=>IF_reg_op_sig(0),
					PE1_op=>PE1_ip_signal,
					PE2_op=>PE2_ip_signal,
					PC_en_control=>PC_en_control_sig,
					ID_en=>EN_id_control_sig,
					ID_en_8bits=>EN_8bits_control_sig,
					validate_control_if=>validate_control_sig,
					nullify_control_id=>nullify_ID_control_sig,
					nullify_control_or=>nullify_control_OR_sig,
					nullify_control_ex=>nullify_control_ex_sig,
					nullify_control_mem=>nullify_control_mem_sig,
					PC_control=>PC_control_sig,
					ID_intermediate_reg => IF_reg_op_sig,
					OR_intermediate_reg => ID_reg_op_sig,
					EX_intermediate_reg => OR_reg_op_sig,
          IF_en => IF_en_sig
);
h:PE1_mux_control port map(
					OR_reg_opcode=>OR_reg_op_sig(83 downto 80),
					nullified_or=>OR_reg_op_sig(8),
					PE1_mux_controller=>PE1_mux_control_sig
);
i:PE2_mux_control port map(
					ID_reg_opcode=>ID_reg_op_sig(35 downto 32),
					nullified_id=>ID_reg_op_sig(8),
					PE2_mux_controller=>PE2_mux_control_sig
);
--CHECK THIS! (EDIT: added outputs authentis_c_op,authentic_z_op)
j:write_control port map(
					opcode_mem=>mem_opcode_sig,
					opcode_EX=>EX_opcode_sig,
					opcode_OR=>OR_opcode_sig,
					flag_z_ex=>EX_reg_op_sig(1),
					flag_c_ex=>EX_reg_op_sig(2),
					flag_z_mem=>mem_reg_op_sig(1),
					flag_c_mem=>mem_reg_op_sig(2),
					flagz_enable_ex=>EX_reg_op_sig(54),
					flagc_enable_ex=>EX_reg_op_sig(55),
					load_flag_z=>load_flag_z_sig,
					nullify_ex=>nullify_ex_sig,
					rf_write_or=>OR_reg_op_sig(19),
					flagc_write_or=>OR_reg_op_sig(10),
					flagz_write_or=>OR_reg_op_sig(9),
					RF_write_out=>RF_write_out_sig,
					flagc_write_out=>flagc_write_out_sig,
					flagz_write_out=>flagz_write_out_sig,
					authentic_c_op=>authentic_c_sig,
					authentic_z_op=>authentic_z_sig,
          user_flagc=>user_cflag_sig,
					user_flagz=>user_zflag_sig,
					flagz_enable_mem=>mem_reg_op_sig(6),
					flagc_enable_mem=>mem_reg_op_sig(7)
);
k:RF_d1_control port map(
					RS_id1=>RS_id1_sig,
					RD_or=>RD_or_sig,
					RD_ex=>RD_ex_sig,
					RD_mem=>RD_mem_sig,
					ID_opcode=>ID_reg_op_sig(35 downto 32),
					EX_opcode=>EX_opcode_sig,
					OR_opcode=>OR_opcode_sig,
					mem_opcode=>mem_opcode_sig,
					PE1_op=>PE1_ip_signal,
					PE2_stored=>ID_reg_op_sig(7 downto 0),
					authentic_c=>authentic_c_sig,
          authentic_z=>authentic_z_sig,
					nullify_or=>OR_reg_op_sig(8),
					nullify_id=>ID_reg_op_sig(8),
					nullify_ex=>nullify_ex_sig,
					nullify_mem=>mem_reg_op_sig(0),
					user_cflag=>user_cflag_sig,
					user_zflag=>user_zflag_sig,
					RF_d1_mux_control=>RF_d1_mux_control_sig
);

l: RF_d2_control port map(
					RS_id2=>RS_id2_sig,
					RD_or=>RD_or_sig,
					RD_ex=>RD_ex_sig,
					RD_mem=>RD_mem_sig,
					ID_opcode=>ID_reg_op_sig(35 downto 32),
					EX_opcode=>EX_opcode_sig,
					OR_opcode=>OR_opcode_sig,
					mem_opcode=>mem_opcode_sig,
          authentic_c=>authentic_c_sig,
          authentic_z=>authentic_z_sig,
					nullify_or=>OR_reg_op_sig(8),
					nullify_id=>ID_reg_op_sig(8),
					nullify_ex=>nullify_ex_sig,
					nullify_mem=>mem_reg_op_sig(0),
					user_cflag=>user_cflag_sig,
					user_zflag=>user_zflag_sig,
					RF_d2_mux_control=>RF_d2_mux_control_sig
);
OR_opcode_sig(5 downto 2)<= OR_reg_op_sig(83 downto 80);
OR_opcode_sig(1 downto 0)<= OR_reg_op_sig(69 downto 68);
EX_opcode_sig(5 downto 2)<= EX_reg_op_sig(77 downto 74);
EX_opcode_sig(1 downto 0)<= EX_reg_op_sig(63 downto 62);
mem_opcode_sig(5 downto 2)<= mem_reg_op_sig(60 downto 57);
mem_opcode_sig(1 downto 0)<= mem_reg_op_sig(46 downto 45);
dest_EX_sig <= EX_reg_op_sig(73 downto 71);
dest_ID_sig <= ID_reg_op_sig(31 downto 29);
dest_IF_sig <= IF_reg_op_sig(12 downto 10);

process(OR_reg_op_sig)
begin
case(OR_reg_op_sig(83 downto 80)) is
  when "0000" =>
    dest_OR_sig <= OR_reg_op_sig(73 downto 71);
  when "0001" =>
    dest_OR_sig <= OR_reg_op_sig(79 downto 77);
  when "0010" =>
    dest_OR_sig <= OR_reg_op_sig(73 downto 71);
  when "0100" =>
    dest_OR_sig <= OR_reg_op_sig(79 downto 77);
  when others =>
    dest_OR_sig <= "111";
end case;
end process;

process(ID_reg_op_sig)
begin
  case(ID_reg_op_sig(35 downto 32)) is
    when "0000" =>
      RS_id1_sig <= ID_reg_op_sig(31 downto 29);
    when "0010" =>
      RS_id1_sig <= ID_reg_op_sig(31 downto 29);
    when "0001" =>
      RS_id1_sig <= ID_reg_op_sig(31 downto 29);
    when "0101" =>
      RS_id1_sig <= ID_reg_op_sig(31 downto 29);
    when "0111" =>
      RS_id1_sig <= ID_reg_op_sig(31 downto 29);
    when others =>
      RS_id1_sig <= "000";
  end case;
end process;

process(ID_reg_op_sig,PE2_dest_sig)
begin
  case(ID_reg_op_sig(35 downto 32)) is
    when "0000" =>
      RS_id2_sig <= ID_reg_op_sig(28 downto 26);
    when "0010" =>
      RS_id2_sig <= ID_reg_op_sig(28 downto 26);
    when "0101" =>
      RS_id2_sig <= ID_reg_op_sig(28 downto 26);
    when "0111" =>
      RS_id2_sig <= PE2_dest_sig;
    when others =>
      RS_id2_sig <= "111";
  end case;
end process;

process(OR_reg_op_sig)
begin
  case(OR_reg_op_sig(83 downto 80)) is
    when "0000" =>
      RD_or_sig <= OR_reg_op_sig(73 downto 71);
    when "0010" =>
      RD_or_sig <= OR_reg_op_sig(73 downto 71);
    when "0001" =>
      RD_or_sig <= OR_reg_op_sig(79 downto 77);
    when "0011" =>
      RD_or_sig <= OR_reg_op_sig(79 downto 77);
    when "0100" =>
      RD_or_sig <= OR_reg_op_sig(79 downto 77);
    when others =>
      RD_or_sig <= "000";
  end case;
end process;

process(EX_reg_op_sig)
begin
-- CHECK THIS!!
  case(EX_reg_op_sig(77 downto 74)) is
    when "0000" =>
      RD_ex_sig <= EX_reg_op_sig(67 downto 65);
    when "0010" =>
      RD_ex_sig <= EX_reg_op_sig(67 downto 65);
    when "0001" =>
      RD_ex_sig <= EX_reg_op_sig(73 downto 71);
    when "0011" =>
      RD_ex_sig <= EX_reg_op_sig(73 downto 71);
    when "0100" =>
      RD_ex_sig <= EX_reg_op_sig(73 downto 71);
    when "0110" =>
      RD_ex_sig <= EX_reg_op_sig(5 downto 3);
    when others =>
      RD_ex_sig <= "000";
  end case;
end process;

process(mem_reg_op_sig)
begin
  case(mem_reg_op_sig(60 downto 57)) is
    when "0000" =>
      RD_mem_sig <= mem_reg_op_sig(50 downto 48);
    when "0010" =>
      RD_mem_sig <= mem_reg_op_sig(50 downto 48);
    when "0001" =>
      RD_mem_sig <= mem_reg_op_sig(56 downto 54);
    when "0011" =>
      RD_mem_sig <= mem_reg_op_sig(56 downto 54);
    when "0100" =>
      RD_mem_sig <= mem_reg_op_sig(56 downto 54);
    when "0110" =>
      RD_mem_sig <= mem_reg_op_sig(5 downto 3);
    when others =>
      RD_mem_sig <= "000";
  end case;
end process;

end Behave;
