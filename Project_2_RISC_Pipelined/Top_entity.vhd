library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Top_entity is
port(
clock,reset: in std_logic
);
end entity;

architecture Behave of Top_entity is

component IF_stage is
  port(reset,clock,validate_control,PC_en_control: in std_logic;
  PC_control: in std_logic_vector(2 downto 0);
  IF_reg_op : out std_logic_vector (32 downto 0);
  alu3_out,alu2_out,memd_out,RF_d2,memid_08:in std_logic_vector(15 downto 0)
  );
end component
--------------------
component ID_stage is
  port(reset,clock,nullify_ID_control,PE2_mux_control: in std_logic;
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
    RF_d1_mux_control,RF_d2_mux_control: std_logic_vector(3 downto 0);
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
	 alu2_out,PCtoR7: out std_logic_vector(15 downto 0);
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
memrf_en:out std_logic
);

end component;
-----------------
component rem_controls is
port(
ID_opcode,OR_opcode,EX_opcode,mem_opcode,IF_opcode:in std_logic_vector(5 downto 0);
dest_EX,dest_OR,dest_ID,dest_IF,RS_id1: in std_logic_vector(2 downto 0);
nullify_ID,nullify_OR,nullify_EX,alu2z_flag,authentic_c,authentic_z,validate_IF:in std_logic;
PE1_op,PE2_op:in std_logic_vector(7 downto 0);
PC_en_control,ID_en,ID_en_8bits,validate_control_if,nullify_control_id,nullify_control_or,nullify_control_ex,nullify_control_mem: out std_logic;
PC_control: out std_logic_vector(2 downto 0)
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
flag_z_ex,flag_c_ex,flag_z_mem,flag_c_mem,flagz_enable_ex,flagc_enable_ex,load_flag_z,nullify_ex,rf_write_or,flagc_write_or,flagz_write_or: in std logic;
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
cflag_ex,cflag_mem,zflag_ex,zflag_mem,nullify_or,nullify_id,nullify_ex,nullify_mem,user_cflag,user_zflag: in std_logic;
RF_d1_mux_control: out std_logic_vector(3 downto 0)
);

end component;
---------------
component RF_d2_control is
port(
RS_id2,RD_or,RD_ex,RD_mem: in std_logic_vector(2 downto 0);
ID_opcode: in std_logic_vector(3 downto 0);
EX_opcode,OR_opcode,mem_opcode: in std_logic_vector(5 downto 0);
cflag_ex,cflag_mem,zflag_ex,zflag_mem,nullify_or,nullify_id,nullify_ex,nullify_mem,user_cflag,user_zflag: in std_logic;
RF_d2_mux_control: out std_logic_vector(3 downto 0)
);

end component;

-------------------------------------
begin

a: IF_stage port map(reset=>,
					clock=>,
					validate_control=>,
					PC_en_control=>,
					PC_control=>,
					IF_reg_op=>,
					alu3_out=>,
					alu2_out=>,
					memd_out=>,
					RF_d2=>,
					memid_08=>
					);

b: ID_stage port map(reset=>,
					clock=>,
					nullify_ID_control=>,
					PE2_mux_control=>,
					PE2_ip=>,
					IF_reg_op=>,
					ID_reg_op=>,
					mem_id_08=>
)

c: OR_stage port map (
					ID_reg_op=>,
    				PC_ex=>,
    				alu2_out_mem=>,
    				memd_out=>,
    				PC_mem=>,
    				left_shifted=>,
    				alu2_forward=>,
    				memd_forward=>,
    				EX_reg_op_ALU2=>,
    				mem_reg_op_ALU2=>,
    				mem_reg_memd=>,
    				instr08_OR=>,
    				instr08_EX=>,
    				instr08_mem=>,
    				memi35_mem=>,
    				memi911_mem=>,
    				PE1_dest=>,
    				nullify_ex=>,
    				clock=>,
    				reset=>,
    				mem_rf_en=>,
    				nullify_control_OR=>,
    				PE1_mux_control=>,
    				PE1_ip=>, 
    				OR_reg_op=>,
    				PE2_op=>,
    				RF_d1_mux_control=>,
    				RF_d2_mux_control=>,
    				ALU3_op=>,
    				RF_d2_or=>

);
d:EX_stage port map (
					OR_reg_op=>, 
					RF_write_out=>,
					flagc_write_out=>,
					flagz_write_out=>,
					PE1_op=>,
					nullify_control_ex=>,
					reset=>,
					clock=>,
					EX_reg_op=>,
					alu2_out=>,
					PCtoR7=>,
					nullify_ex=>,
					alu2_z=>
);

e:Mem_stage port map(
					reset=>,
					clock=>,
					nullify_control_mem=>,
 					EX_reg_op=>,
 					memd_out=>,
 					Mem_reg_op=>,
 					load_flag_z=>
);
f: WB_stage port map(clock=>,
					 reset=>,
					mem_reg_op=>;
					alu2_out=>,
					memd_out=>,
					PC_mem=>,
					left_shifted=>,
					memi_35=>,
					memi_911=>,
					PE1_dest=>,
					memrf_en=>
);
g: rem_controls port map(
					ID_opcode=>,
					OR_opcode=>,
					EX_opcode=>,
					mem_opcode=>,
					IF_opcode=>,
					dest_EX=>,
					dest_OR=>,
					dest_ID=>,
					dest_IF=>,
					RS_id1=>,
					nullify_ID=>,
					nullify_OR=>,
					nullify_EX=>,
					alu2z_flag=>,
					authentic_c=>,
					authentic_z=>,
					validate_IF=>,
					PE1_op=>,
					PE2_op=>,
					PC_en_control,
					ID_en=>,
					ID_en_8bits=>,
					validate_control_if=>,
					nullify_control_id=>,
					nullify_control_or=>,
					nullify_control_ex=>,
					nullify_control_mem=>,
					PC_control=>
);
h:PE1_mux_control port map(
					OR_reg_opcode=>,
					nullified_or=>,
					PE1_mux_controller=>
); 
i:PE2_mux_control port map(
					ID_reg_opcode=>,
					nullified_id=>,
					PE2_mux_controller=>
);

j:write_control port map(
					opcode_mem=>,
					opcode_EX=>,
					opcode_OR=>,
					flag_z_ex=>,
					flag_c_ex=>,
					flag_z_mem=>,
					flag_c_mem=>,
					flagz_enable_ex=>,
					flagc_enable_ex=>,
					load_flag_z=>,
					nullify_ex=>,
					rf_write_or=>,
					flagc_write_or=>,
					flagz_write_or=>,
					RF_write_out=>,
					flagc_write_out=>,
					flagz_write_out=>,
					authentic_c_op=>,
					authentic_z_op=>
);
k:RF_d1_control port map(
					RS_id1=>,
					RD_or=>,
					RD_ex=>,
					RD_mem=>,
					ID_opcode=>,
					EX_opcode=>,
					OR_opcode=>,
					mem_opcode=>,
					PE1_op=>,
					PE2_stored=>,
					cflag_ex=>,
					cflag_mem=>,
					zflag_ex=>,
					zflag_mem=>,
					nullify_or=>,
					nullify_id=>,
					nullify_ex=>,
					nullify_mem=>,
					user_cflag=>,
					user_zflag=>,
					RF_d1_mux_control=>
);

l: RF_d2_control port map(
					RS_id2=>,
					RD_or=>,
					RD_ex=>,
					RD_mem=>,
					ID_opcode=>,
					EX_opcode=>,
					OR_opcode=>,
					mem_opcode=>,
					cflag_ex=>,
					cflag_mem=>,
					zflag_ex=>,
					zflag_mem=>,
					nullify_or=>,
					nullify_id=>,
					nullify_ex=>,
					nullify_mem=>,
					user_cflag=>,
					user_zflag=>,
					RF_d2_mux_control=>
);
end Behave;


