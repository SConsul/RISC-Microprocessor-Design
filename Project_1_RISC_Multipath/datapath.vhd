library ieee;
use ieee.std_logic_1164.all;

entity datapath is
  port(
  CLK: in std_logic;
  alu_op: in std_logic_vector(1 downto 0);
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
	flac_en:in std_logic;
	flagz_en: in std_logic;
	t1_mux: in std_logic_vector(1 downto 0);
	t2_mux: in std_logic_vector(2 downto 0);
	t3_mux: in std_logic;
	pc_mux: in std_logic_vector(2 downto 0));
  end entity;

  architecture dp is

    component ALU is
      port(alu_op: in std_logic_vector(2 downto 1);
          alu_a: in std_logic_vector(15 downto 0);
          alu_b: in std_logic_vector(15 downto 0);
          alu_c: out std_logic;
          alu_z: out std_logic;
          alu_out: out std_logic_vector(15 downto 0));
    end component;

    component reg is
      port (EN, CLK: in std_logic;
            ip: in std_logic_vector(15 downto 0);
            op: out std_logic_vector(15 downto 0));
    end component;

    component priority_encoder is
    port (
        ip : in std_logic_vector (7 downto 0);
        op_addr : out std_logic_vector (2 downto 0);
        update : out std_logic_vector (7 downto 0)
      );
    end component priority_encoder;

    component reg_3bit is
      port (
            EN, CLK: in std_logic;
            ip: in std_logic_vector(2 downto 0);
            op: out std_logic_vector(2 downto 0));
    end component;

    component RegFile is
    port (
        CLK : in std_logic;
        rf_a1, rf_a2, rf_a3 : in std_logic_vector (2 downto 0);
        rf_d3 : in std_logic_vector(15 downto 0);
        rf_d1, rf_d2 : out std_logic_vector(15 downto 0);
        r7_ip : in std_logic_vector (15 downto 0);
        r7_op : out std_logic_vector (15 downto 0);
        rf_wr, r7_wr : in std_logic);
    end component RegFile;

    component memory is
      port(clk: in std_logic;
          mem_write_bar: in std_logic
          address: in std_logic_vector(15 downto 0);
          data: inout std_logic_vector(15 downto 0));
    end component;
    signal T1_ip,T1_op, T2_ip, T2_op, T3_ip, T3_op,
    signal T4_ip, T4_op: std std_logic_vector(2 downto 0);
    begin
      T1: reg port map(EN=>en_t1, CLK=>CLK, ip=> , op=>)


    end dp;
