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
  temp_z_en: in std_logic;
  flagc, flagz : out std_logic
  );
  end entity;

  architecture dp of datapath is

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

    component SE6 is
    port (
        ip : in std_logic_vector (5 downto 0);
        op : out std_logic_vector (15 downto 0));
    end component SE6;

    component SE9 is
    port (
        ip : in std_logic_vector (8 downto 0);
        op : out std_logic_vector (15 downto 0));
    end component SE9;

    signal t1_ip,t1_op, t2_ip, t2_op, t3_ip, t3_op : std_logic_vector(15 downto 0);
    signal t4_ip, t4_op: std_logic_vector(2 downto 0);
    signal mem_d, ir_op: std_logic_vector(15 downto 0);
    signal pc_in, pc_op: std_logic_vector(15 downto 0);
    signal flagc, flagz, tempz: std_logic;
    signal rf_a1, rf_a2, rf_a3 : std_logic_vector(2 downto 0);
    signal rf_d1, rf_d2, rf_d3, r7_op : std_logic_vector(15 downto 0);
    signal mem_addr, mem_d_in, mem_d_out : std_logic_vector(15 downto 0);
    signal se9ir08_out, se6ir05_out : std_logic_vector (15 downto 0);

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
      temp_Z: flip_flop port map(EN=>temp_z_en, CLK=>CLK, D=>alu_z, Q=>tempz);
      PE: priority_encoder port map(ip=>T2_op, op_addr=>t4_ip, update=>t2_update);

      RF: RegFile port map(
      CLK=>CLK,
      rf_a1=>rf_a1,
      rf_a2=>ir_op(8 downto 6),
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

      SE9_ir_0_8 : SE9 port map (ip=> ir_op(8 downto 0), op=>se9ir08_out)
      SE6_ir_0_5 : SE6 port map (ip=>ir_op(5 downto 0) , op=>se6ir05_out)

      case(alu_a_mux) is
        when "00"=>
          rf_a1 <= pc_op;
        when "01"=>
          alu_a <= t1_op;
        when "10"=>
          alu_a <= t2_op;
        when "11"=>
          alu_a <= se9ir08_out;
      end case;

      case(alu_b_mux) is
        when "000"=>
          alu_b(15 downto 0) <= '0';
        when "001"=>
          alu_b(15 downto 1) <= '0';
          alu_b(0) <= '1';
        when "010"=>
          alu_b <= t2_op
        when "011"=>
          alu_b <= t3_op;
        when "100"=>
          alu_b <= se6ir05_out;
        when "101"=>
            alu_b <= se9ir08_out;
        when others =>
          null;
      end case;

      case(rf_a1_mux) is
        when "00"=>
          rf_a1 <= ir(11 downto 9);
        when "01"=>
          rf_a1 <= "111";
        when "10"=>
          rf_a1 <= t4_op;
        when "11"=>
          null;
      end case;

      case(rf_a3_mux) is
        when "001"=>
          rf_a3 <= ir_op(5 downto 3);
        when "010"=>
          rf_a3 <= "111";
        when "011"=>
          rf_a3 <= ir_op(8 downto 6);
        when "100"=>
          rf_a3 <= ir_op(11 downto 9);
        when "101"=>
          rf_a3 <= t4_op;
        when others =>
          null;
      end case;

      case(rf_d3_mux) is
        when "00"=>
          rf_a1 <= t1;
        when "01"=>
          rf_a1(15 downto 7) <= ir(8 downto 0);
          rf_a1(7 downto 0) <='0';
        when "10"=>
          rf_a1 <= t3_op;
        when "11"=>
          null;
      end case;

      case(mem_a_mux) is
        when "00"=>
          mem_addr <= pc;
        when "01"=>
          mem_addr <= t1
        when "10"=>
          mem_addr <= t2;
        when "11"=>
          null;
      end case;

      case(mem_d_mux) is
        when "0"=>
          mem_d_in <= t1_op;
        when "1"=>
          mem_d_in <= t3_op;
      end case;

      case(t1_mux) is
        when "00"=>
          t1_ip <= rf_d1;
        when "01"=>
          t1_ip <= alu_out;
        when "10"=>
          t1_ip <= mem_d_out;
        when "11"=>
          null;
      end case;

      case(t2_mux) is -- 3 bits
        when "00"=>
          t2_ip <= rf_d2;
        when "01"=>
          t2_ip <= alu_out;
        when "10"=>
          t2_ip <= se9ir08_out;
        when "11"=>
          t2_ip <= t2_update;
      end case;

      case(t3_mux) is
        when "0"=>
          t3_ip <= mem_d_out;
        when "1"=>
          t3_ip <= rf_d1;
      end case;
    end dp;

    case(pc_mux) is
      when "000"=>
        pc_ip <= alu_out;
      when "001"=>
        pc_ip <= rf_d1;
      when "010"=>
        pc_ip <= t1;
      when "011"=>
        pc_ip <= t2;
      when "100"=>
        pc_ip <= t3;
      when "101"=>
        pc_ip(15 downto 7) <= ir_op(8 downto 0);
        pc_ip(6 downto 0) <= '0';
      when others =>
        null;
    end case;
