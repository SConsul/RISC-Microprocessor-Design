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
	flagc_en:in std_logic;
	flagz_en: in std_logic;
	t1_mux: in std_logic_vector(1 downto 0);
	t2_mux: in std_logic_vector(2 downto 0);
	t3_mux: in std_logic;
	pc_mux: in std_logic_vector(2 downto 0);
  flagc, flagz : out std_logic
  );
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
          rf_d3 : in std_logic_vector(NUM_BITS - 1 downto 0);
          rf_d1, rf_d2 : out std_logic_vector(NUM_BITS - 1 downto 0);
          alu_to_r7, t2_to_r7, pc_to_r7 : in std_logic_vector (NUM_BITS - 1 downto 0);
          r7_op : out std_logic_vector (NUM_BITS - 1 downto 0);
          rf_wr: in std_logic;
          r7_wr_mux : in std_logic_vector(1 downto 0)
        );

    component flip_flop is
      port (EN, CLK: in std_logic;
            D: in std_logic;
            Q: out std_logic;
    end component;

    component memory is
      port(clk: in std_logic;
          mem_write_bar: in std_logic
          address: in std_logic_vector(15 downto 0);
          data_in: in std_logic_vector(15 downto 0));
          data_out: out std_logic_vector(15 downto 0));
    end component;
    signal t1_ip,t1_op, t2_ip, t2_op, t3_ip, t3_op : std_logic_vector(15 downto 0);
    signal t4_ip, t4_op: std_logic_vector(2 downto 0);
    signal mem_d, ir_op: std_logic_vector(15 downto 0);
    signal pc_in, pc_op: std_logic_vector(15 downto 0);
    signal flagc, flagz: std_logic;
    signal rf_a1, rf_a2, rf_a3 : std_logic_vector(2 downto 0);
    signal rf_d1, rf_d2, rf_d3, r7_op : std_logic_vector(15 downto 0);
    signal mem_addr, mem_d_in, mem_d_out : std_logic_vector(15 downto 0);

    begin
      T1: reg port map(EN=>en_t1, CLK=>CLK, ip=>t1_ip, op=>t1_op);
      T2: reg port map(EN=>en_t2, CLK=>CLK, ip=>t2_ip, op=>t2_op);
      T3: reg port map(EN=>en_t3, CLK=>CLK, ip=>t3_ip, op=>t3_op);
      T4: reg_3bit port map(EN=>en_t4, CLK=>CLK, ip=>t4_ip, op=>t4_op);

      IR: reg port map(EN=>ir_en, CLK=>CLK, ip=>mem_d, op=>ir_op);
      PC: reg port map(EN=>pc_en, CLK=>CLK, ip=>pc_ip, op=>pc_op);

      ALU: ALU port map(alu_op=>alu_op, alu_a=>alu_a, alu_b=>alu_b, alu_c=>alu_c, alu_z=>alu_z, alu_out=>alu_out);
      C_flag: flip_flop port map(EN=>flagc_en, CLK=>CLK, D=>alu_c, Q=>flagc);
      Z_flag: flip_flop port map(EN=>flagz_en, CLK=>CLK, D=>alu_z, Q=>flagz);

      PE: priority_encoder port map(ip=>T2_op, op_addr=>t4_ip, update=>t2_update);

      RF: RegFile port map(
      CLK=>CLK,
      rf_a1=>rf_a1,
      rf_a2=>rf_a2,
      rf_a3=>rf_a3,
      rf_d1=>rf_d1,
      rf_d2=>rf_d2,
      rf_d3=>rf_d3,
      alu_to_r7=>alu_op,
      t2_to_r7=>t2_op,
      pc_to_r7=>pc_op,
      r7_op=>r7_op,
      rf_wr=>rf_en,
      r7_wr_mux=>r7_wr_mux
      );

      mem: memory port map (clk=>CLK, mem_write_bar=>mem_write_bar, address=>mem_addr, data_in=>mem_d_in, data_out=>mem_d_out);

      
    end dp;
