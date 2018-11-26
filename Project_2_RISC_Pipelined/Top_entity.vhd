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
end component;

component ID_stage is
  port(reset,clock,nullify_ID_control,PE2_mux_control: in std_logic;
  PE2_ip: std_logic_vector (7 downto 0);
  IF_reg_op :in std_logic_vector(32 downto 0);
  ID_reg_op : out std_logic_vector (51 downto 0);
  mem_id_08: out std_logic_vector (15 downto 0)
  );
end component;

component OR_stage is
    port(ID_reg_op: in std_logic_vector (51 downto 0);
    PC_ex,alu2_out_mem,memd_out,PC_mem,left_shifted,alu2_forward,memd_forward: in std_logic_vector (15 downto 0);
    memi35_mem,memi911_mem,PE1_dest: in std_logic_vector (2 downto 0);
    nullify_ex,clock,reset,mem_rf_en,nullify_control_OR,PE1_mux_control: in std_logic;
    PE1_ip: in std_logic_vector (7 downto 0); 
    OR_reg_op: out std_logic_vector (99 downto 0);
    PE2_op: out std_logic_vector (7 downto 0);
    RF_d1_mux_control,RF_d2_mux_control: std_logic_vector(1 downto 0);
    ALU3_op,RF_d2_or:out std_logic_vector (15 downto 0)
    );
end component; 

component EX_stage is 
port (OR_reg_op: in std_logic_vector(99 downto 0);
	 flag_z_mux_control,load_flag_z: in std_logic;
	 PE1_op: out std_logic_vector (7 downto 0);
	 nullify_control_ex,reset,clock:in std_logic;
	 EX_reg_op: out std_logic_vector(93 downto 0);
	 alu2_out,PCtoR7: out std_logic_vector(15 downto 0);
	 nullify_ex: out std_logic;

);
end component;

component Mem_stage is
 port(
 reset,clock,nullify_control_mem:in std_logic;
 EX_reg_op:in std_logic_vector(93 downto 0);
 memd_out: out std_logic_vector(15 downto 0);
 Mem_reg_op:out std_logic_vector(76 downto 0);
 load_flag_z: out std_logic
);

end component;

component WB_stage is
port(clock,reset:in std_logic;
mem_reg_op:in std_logic_vector(76 downto 0);
alu2_out,memd_out,PC_mem,left_shifted:out std_logic_vector(15 downto 0);
memi_35,memi_911,PE1_dest: out std_logic_vector(2 downto 0);
memrf_en:out std_logic
);

end component;

signal 

begin
