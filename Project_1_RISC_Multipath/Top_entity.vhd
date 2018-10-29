library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity Top_entity is
	port(reset,clock:in std_logic);
end entity;

architecture Behave of Top_entity is

component FSM is
	port(reset,clock: in std_logic;
	IR: in std_logic_vector(15 downto 0);
	Carry_reg,Zero_reg: in std_logic;
	T2: in std_logic_vector(15 downto 0);
	temp_z: in std_logic;
	T4: in std_logic_vector(2 downto 0);
	alu_op: out std_logic_vector(1 downto 0);
	alu_a_mux: out std_logic_vector( 1 downto 0);
	alu_b_mux: out std_logic_vector( 2 downto 0);
	rf_en: out std_logic;
	r7_wr_mux: out std_logic_vector( 1 downto 0);
	rf_a1_mux: out std_logic_vector( 1 downto 0);
	rf_a3_mux: out std_logic_vector( 2 downto 0);
	rf_d3_mux: out std_logic_vector( 1 downto 0);
	mem_write_bar: out std_logic;
	mem_a_mux: out std_logic_vector( 1 downto 0);
	mem_d_mux: out std_logic;
	en_t1: out std_logic;
	en_t2: out std_logic;
	en_t3: out std_logic;
	en_t4: out std_logic;
	pc_en: out std_logic;
	ir_en: out std_logic;
	temp_z_en: out std_logic;
	flagc_en:out std_logic;
	flagz_en: out std_logic;
	t1_mux: out std_logic_vector(1 downto 0);
	t2_mux: out std_logic_vector(1 downto 0);
	t3_mux: out std_logic;
	pc_mux: out std_logic_vector(2 downto 0));

end component;

component datapath is
Generic (NUM_BITS : INTEGER := 16);
  port(
  CLK,reset: in std_logic;
  alu_opr: in std_logic_vector(1 downto 0);
	alu_a_mux: in std_logic_vector( 1 downto 0);
	alu_b_mux: in std_logic_vector( 2 downto 0);
	rf_en: in std_logic;
	r7_wr_mux: in std_logic_vector( 1 downto 0);
	rf_a1_mux: in std_logic_vector( 1 downto 0);
	rf_a3_mux: in std_logic_vector( 2 downto 0);
	rf_d3_mux: in std_logic_vector( 1 downto 0);
	mem_write_bar: in std_logic;
	mem_a_mux: in std_logic_vector( 1 downto 0);
	mem_d_mux: in std_logic;
	en_t1, en_t2, en_t3, en_t4 : in std_logic;
	pc_en: in std_logic;
	ir_en: in std_logic;
	flagc_en:in std_logic;
	flagz_en: in std_logic;
	t1_mux: in std_logic_vector(1 downto 0);
	t2_mux: in std_logic_vector(1 downto 0);
	t3_mux: in std_logic;
	pc_mux: in std_logic_vector(2 downto 0);
  temp_z_en: in std_logic;
  flagc, flagz: out std_logic;
  t4_out: out std_logic_vector(2 downto 0);
  t2_out: out std_logic_vector(15 downto 0);
  ir_out: out std_logic_vector(15 downto 0);
  tempz: out std_logic
  );
  end component;
signal ir_sig: std_logic_vector(15 downto 0);
signal	Carry_reg_sig,Zero_reg_sig: std_logic;
signal	T2_sig: std_logic_vector(15 downto 0);
signal	temp_z_sig: std_logic;
signal	T4_sig: std_logic_vector(2 downto 0);
signal	alu_op_sig: std_logic_vector(1 downto 0);
signal	alu_a_mux_sig: std_logic_vector( 1 downto 0);
signal	alu_b_mux_sig: std_logic_vector( 2 downto 0);
signal	rf_en_sig: std_logic;
signal	r7_wr_mux_sig: std_logic_vector( 1 downto 0);
signal	rf_a1_mux_sig: std_logic_vector( 1 downto 0);
signal	rf_a3_mux_sig: std_logic_vector( 2 downto 0);
signal	rf_d3_mux_sig: std_logic_vector( 1 downto 0);
signal	mem_write_bar_sig: std_logic;
signal	mem_a_mux_sig: std_logic_vector( 1 downto 0);
signal	mem_d_mux_sig: std_logic;
signal	en_t1_sig: std_logic;
signal	en_t2_sig: std_logic;
signal	en_t3_sig: std_logic;
signal	en_t4_sig: std_logic;
signal	pc_en_sig: std_logic;
signal	ir_en_sig: std_logic;
signal	temp_z_en_sig: std_logic;
signal	flagc_en_sig: std_logic;
signal	flagz_en_sig: std_logic;
signal	t1_mux_sig: std_logic_vector(1 downto 0);
signal	t2_mux_sig: std_logic_vector(1 downto 0);
signal	t3_mux_sig: std_logic;
signal	pc_mux_sig: std_logic_vector(2 downto 0);

  begin

  a: FSM port map(clock=>clock,reset=>reset,IR=>ir_sig,Carry_reg=>Carry_reg_sig,Zero_reg=>Zero_reg_sig,T2=>T2_sig,temp_z=>temp_z_sig,T4=>T4_sig, alu_op=>alu_op_sig, alu_a_mux=>alu_a_mux_sig, alu_b_mux=>alu_b_mux_sig,rf_en=>rf_en_sig,r7_wr_mux=>r7_wr_mux_sig,rf_a1_mux=>rf_a1_mux_sig,rf_a3_mux=>rf_a3_mux_sig,rf_d3_mux=>rf_d3_mux_sig,mem_write_bar=>mem_write_bar_sig,mem_a_mux=>mem_a_mux_sig,mem_d_mux=>mem_d_mux_sig,en_t1=>en_t1_sig,en_t2=>en_t2_sig,en_t3=>en_t3_sig,en_t4=>en_t4_sig,pc_en=>pc_en_sig,ir_en=>ir_en_sig,temp_z_en=>temp_z_en_sig,flagc_en=>flagc_en_sig,flagz_en=>flagz_en_sig,t1_mux=>t1_mux_sig,t2_mux=>t2_mux_sig,t3_mux=>t3_mux_sig,pc_mux=>pc_mux_sig);

  b: datapath port map(CLK=>clock,reset=>reset,alu_opr=>alu_op_sig, alu_a_mux=>alu_a_mux_sig, alu_b_mux=>alu_b_mux_sig,rf_en=>rf_en_sig,r7_wr_mux=>r7_wr_mux_sig,rf_a1_mux=>rf_a1_mux_sig,rf_a3_mux=>rf_a3_mux_sig,rf_d3_mux=>rf_d3_mux_sig,mem_write_bar=>mem_write_bar_sig,mem_a_mux=>mem_a_mux_sig,mem_d_mux=>mem_d_mux_sig,en_t1=>en_t1_sig,en_t2=>en_t2_sig,en_t3=>en_t3_sig,en_t4=>en_t4_sig,pc_en=>pc_en_sig,ir_en=>ir_en_sig,temp_z_en=>temp_z_en_sig,flagc_en=>flagc_en_sig,flagz_en=>flagz_en_sig,t1_mux=>t1_mux_sig,t2_mux=>t2_mux_sig,t3_mux=>t3_mux_sig,pc_mux=>pc_mux_sig,ir_out=>ir_sig,flagc=>Carry_reg_sig,flagz=>Zero_reg_sig,t2_out=>T2_sig,tempz=>temp_z_sig,t4_out=>T4_sig);
  end Behave;

