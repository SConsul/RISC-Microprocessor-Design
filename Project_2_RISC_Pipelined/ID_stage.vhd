library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ID_interface_reg is
Generic (NUM_BITS : INTEGER := 52);
  port (EN,EN_8bits, reset, CLK: in std_logic;
        ip: in std_logic_vector(NUM_BITS-1 downto 0);
        op: out std_logic_vector(NUM_BITS-1 downto 0)
      );
end entity;

architecture reg_arch of ID_interface_reg is
begin
reg1 : process(CLK, EN, ip)
begin
  if CLK'event and CLK = '1' then
    if reset = '1' then
      op(NUM_BITS-1 downto 0) <= (others=>'0');
    elsif EN = '1' and EN_8bits = '1' then
      op <= ip;
    elsif EN = '0' and EN_8bits = '1' then
      op(7 downto 0)<=ip(7 downto 0);
    end if;
  end if;
end process;
end reg_arch;
-------------------------------------------------------------------------
library ieee;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ID_stage is
  port(reset,clock,nullify_ID_control,PE2_mux_control,EN_id_control,EN_8bits_control: in std_logic;
  PE2_ip: in std_logic_vector (7 downto 0);
  IF_reg_op :in std_logic_vector(32 downto 0);
  ID_reg_op : out std_logic_vector (51 downto 0);
  mem_id_08: out std_logic_vector (15 downto 0)
  );
end entity;
architecture Behave of ID_stage is

component ID_interface_reg is
Generic (NUM_BITS : INTEGER := 52);
  port (EN, reset, CLK, EN_8bits: in std_logic;
        ip: in std_logic_vector(NUM_BITS-1 downto 0);
        op: out std_logic_vector(NUM_BITS-1 downto 0)
      );
end component;

signal RF_enable, mem_write, ALU2_a_mux,flagc_en,flagz_en: std_logic;
signal ALU2_op,RF_D3_mux,RF_a3_mux: std_logic_vector(1 downto 0);
signal PE2_mux_op: std_logic_vector(7 downto 0);
signal dummy_ip8, dummy_ip19, dummy_ip18, dummy_ip10, dummy_ip9: std_logic;
begin

dummy_ip8 <= (nullify_ID_control or not(IF_reg_op(0)));
dummy_ip19 <=(RF_enable and not(nullify_ID_control));
dummy_ip18 <= (mem_write and not(nullify_ID_control));
dummy_ip10 <= (flagc_en and not(nullify_ID_control));
dummy_ip9 <= (flagz_en and not(nullify_ID_control));

a: ID_interface_reg port map(
		EN=>EN_id_control,
		EN_8bits=>EN_8bits_control,
		reset=>reset,
		CLK=>clock,
		ip(51 downto 20)=>IF_reg_op(32 downto 1),
		ip(19)=>dummy_ip19,
		ip(18)=>dummy_ip18,
		ip(17 downto 16)=>ALU2_op,
		ip(15)=>ALU2_a_mux,
		ip(14 downto 13)=>RF_a3_mux,
		ip(12 downto 11)=>RF_D3_mux,
		ip(10)=>dummy_ip10,
		ip(9)=>dummy_ip9,
		ip(8)=>dummy_ip8,
		ip(7 downto 0)=>PE2_mux_op,
		op=>ID_reg_op);


mem_id_08(15 downto 7)<=IF_reg_op(9 downto 1);
mem_id_08(6 downto 0)<="0000000";

process(IF_reg_op)
	begin
	if(IF_reg_op(16 downto 13)="0000") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<="00";
		ALU2_op<="00";
		RF_D3_mux<="01";
		flagc_en<='1';
		flagz_en<='1';

	elsif(IF_reg_op(16 downto 13)="0010") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<="00";
		ALU2_op<="01";
		RF_D3_mux<="01";
		flagc_en<='0';
		flagz_en<='1';

	elsif(IF_reg_op(16 downto 13)="0001") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='1';
		RF_a3_mux<="01";
		ALU2_op<="00";
		RF_D3_mux<="01";
		flagc_en<='1';
		flagz_en<='1';

	elsif(IF_reg_op(16 downto 13)="0010") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<="00";
		ALU2_op<="01";
		RF_D3_mux<="01";
		flagc_en<='0';
		flagz_en<='1';


	elsif(IF_reg_op(16 downto 13)="0011") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<="01";
		ALU2_op<="01";
		RF_D3_mux<="00";
		flagc_en<='0';
		flagz_en<='0';

	elsif(IF_reg_op(16 downto 13)="0100") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='1';
		RF_a3_mux<="01";
		ALU2_op<="00";
		RF_D3_mux<="11";
		flagc_en<='0';
		flagz_en<='1';

	elsif(IF_reg_op(16 downto 13)="0101") then
		RF_enable<='0';
		mem_write<='1';
		ALU2_a_mux<='1';
		RF_a3_mux<="01";
		ALU2_op<="00";
		RF_D3_mux<="11";
		flagc_en<='0';
		flagz_en<='0';

	elsif(IF_reg_op(16 downto 13)="0110") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<="10";
		ALU2_op<="11";
		RF_D3_mux<="11";
		flagc_en<='0';
		flagz_en<='0';


	elsif(IF_reg_op(16 downto 13)="0111") then
		RF_enable<='0';
		mem_write<='1';
		ALU2_a_mux<='0';
		RF_a3_mux<="10";
		ALU2_op<="11";
		RF_D3_mux<="11";
		flagc_en<='0';
		flagz_en<='0';

	elsif(IF_reg_op(16 downto 13)="1100") then
		RF_enable<='0';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<="10";
		ALU2_op<="10";
		RF_D3_mux<="11";
		flagc_en<='0';
		flagz_en<='0';


	elsif(IF_reg_op(16 downto 13)="1000") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<="01";
		ALU2_op<="00";
		RF_D3_mux<="10";
		flagc_en<='0';
		flagz_en<='0';


	elsif(IF_reg_op(16 downto 13)="1001") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<="01";
		ALU2_op<="00";
		RF_D3_mux<="10";
		flagc_en<='0';
		flagz_en<='0';

	else --tunaktunaktun
		RF_enable<='0';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<="01";
		ALU2_op<="00";
		RF_D3_mux<="10";
		flagc_en<='0';
		flagz_en<='0';

	end if;
	end process;
	process( PE2_ip,PE2_mux_control,IF_reg_op)
	begin
		if(PE2_mux_control = '1') then
			PE2_mux_op<=PE2_ip;
		else
			PE2_mux_op<=IF_reg_op(8 downto 1);
		end if;
	end process;
end Behave;
