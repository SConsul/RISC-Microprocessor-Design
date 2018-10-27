library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity FSM is
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

end entity;

architecture Behave of FSM is

component control_signal is
	port(X: in std_logic_vector(26 downto 0); 
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

component Next_state is 
	port( x : in std_logic_vector(39 downto 0); z : out std_logic_vector(4 downto 0));
end component;

signal q: std_logic_vector(4 downto 0);
signal nq: std_logic_vector( 4 downto 0);

begin


a: Next_state port map(x(39 downto 24)=>IR,x(23)=>Carry_reg,x(22)=>Zero_reg,x(21 downto 6)=>T2,x(5)=>temp_z, x(4 downto 0)=>q, z=>nq);
b: control_signal port map(X(26)=>temp_z,X(25 downto 23)=>T4,X(22 downto 18)=>q,X(17 downto 2)=>IR, X(1)=>Carry_reg,X(0)=>Zero_reg,alu_op=>alu_op, alu_a_mux=>alu_a_mux, alu_b_mux=>alu_b_mux,rf_en=>rf_en,r7_wr_mux=>r7_wr_mux,rf_a1_mux=>rf_a1_mux,rf_a3_mux=>rf_a3_mux,rf_d3_mux=>rf_d3_mux,mem_write_bar=>mem_write_bar,mem_a_mux=>mem_a_mux,mem_d_mux=>mem_d_mux,en_t1=>en_t1,en_t2=>en_t2,en_t3=>en_t3,en_t4=>en_t4,pc_en=>pc_en,ir_en=>ir_en,temp_z_en=>temp_z_en,flagc_en=>flagc_en,flagz_en=>flagz_en,t1_mux=>t1_mux,t2_mux=>t2_mux,t3_mux=>t3_mux,pc_mux=>pc_mux);

process(nq,clock,reset,q)
begin
if(clock'event and clock='1') then
	if(reset='1') then
		q<="00001";
	else
	 	q<=nq;
	end if;
end if;
end process;
end Behave;
