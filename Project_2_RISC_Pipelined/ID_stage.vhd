library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ID_interface_reg is
Generic (NUM_BITS : INTEGER := 52);
  port (EN, reset, CLK: in std_logic;
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
    elsif EN = '1' then
      op <= ip;
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
  port(reset,clock,nullify_ID_control: in std_logic;
  IF_reg_op :in std_logic_vector(32 downto 0);
  ID_reg_op : out std_logic_vector (51 downto 0);
  )
end entity;
architecture Behave of ID_stage is

component ID_interface_reg is
Generic (NUM_BITS : INTEGER := 52);
  port (EN, reset, CLK: in std_logic;
        ip: in std_logic_vector(NUM_BITS-1 downto 0);
        op: out std_logic_vector(NUM_BITS-1 downto 0)
      );
end component;

signal RF_enable, mem_write, ALU2_a_mux,flagc_en,flagz_en: std_logic;
signal ALU2_op,RF_D3_mux,RF_a3_mux: std_logic_vector(1 downto 0);

begin
a: ID_interface_reg(EN=>'1',reset=>reset,CLK=>clock,ip(51 downto 20)=>IF_reg_op(32 downto 1),ip(8)=>(nullify_ID_control or not(IF_reg_op(0))),ip(7 downto 0)=>IF_reg_op(8 downto 1),ip(19)=>RF_enable,ip(18)=>mem_write,ip(17 downto 16)=>ALU2_op,ip(15)=>ALU2_a_mux,ip(14 downto 13)=>RF_a3_mux,ip(12 downto 11)=>RF_D3_mux,op=>ID_reg_op,ip(10)=>flagc_en,ip(9)=>flagz_en);

process(IF_reg_op)
	begin
	if(IF_reg_op(16 downto 13)="0000") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<"00";
		ALU2_op<="00";
		RF_D3_mux<="01";
		flagc_en<='1';
		flagz_en<='1';

	elsif(IF_reg_op(16 downto 13)="0010") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<"00";
		ALU2_op<="01";
		RF_D3_mux<="01";
		flagc_en<='0';
		flagz_en<='1';

	elsif(IF_reg_op(16 downto 13)="0001") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='1';
		RF_a3_mux<"01";
		ALU2_op<="00";
		RF_D3_mux<="01";
		flagc_en<='1';
		flagz_en<='1';

	elsif(IF_reg_op(16 downto 13)="0010") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<"00";
		ALU2_op<="01";
		RF_D3_mux<="01";
		flagc_en<='0';
		flagz_en<='1';


	elsif(IF_reg_op(16 downto 13)="0011") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<"01";
		ALU2_op<="01";
		RF_D3_mux<="00";
		flagc_en<='0';
		flagz_en<='0';
		
	elsif(IF_reg_op(16 downto 13)="0100") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='1';
		RF_a3_mux<"01";
		ALU2_op<="00";
		RF_D3_mux<="11";
		flagc_en<='0';
		flagz_en<='1';

	elsif(IF_reg_op(16 downto 13)="0101") then
		RF_enable<='0';
		mem_write<='1';
		ALU2_a_mux<='1';
		RF_a3_mux<"01";
		ALU2_op<="00";
		RF_D3_mux<="11";
		flagc_en<='0';
		flagz_en<='0';	

	elsif(IF_reg_op(16 downto 13)="0110") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<"10";
		ALU2_op<="11";
		RF_D3_mux<="11";
		flagc_en<='0';
		flagz_en<='0';


	elsif(IF_reg_op(16 downto 13)="0111") then
		RF_enable<='0';
		mem_write<='1';
		ALU2_a_mux<='0';
		RF_a3_mux<"10";
		ALU2_op<="11";
		RF_D3_mux<="11";
		flagc_en<='0';
		flagz_en<='0';

	elsif(IF_reg_op(16 downto 13)="1100") then
		RF_enable<='0';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<"10";
		ALU2_op<="10";
		RF_D3_mux<="11";
		flagc_en<='0';
		flagz_en<='0';


	elsif(IF_reg_op(16 downto 13)="1000") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<"01";
		ALU2_op<="00";
		RF_D3_mux<="10";
		flagc_en<='0';
		flagz_en<='0';


	elsif(IF_reg_op(16 downto 13)="1001") then
		RF_enable<='1';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<"01";
		ALU2_op<="00";
		RF_D3_mux<="10";
		flagc_en<='0';
		flagz_en<='0';

	else --tunaktunaktun
		RF_enable<='0';
		mem_write<='0';
		ALU2_a_mux<='0';
		RF_a3_mux<"01";
		ALU2_op<="00";
		RF_D3_mux<="10";
		flagc_en<='0';
		flagz_en<='0';

	end if;
	end process;
	end Behave;











