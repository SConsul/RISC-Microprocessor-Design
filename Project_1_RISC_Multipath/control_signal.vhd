library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity control_signal is
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
end entity;

architecture Behave of control_signal is
begin
process(X)
begin
if(X(22 downto 18)="00001") then
    alu_op<="00"
	alu_a_mux<="00"
	alu_b_mux<="001";
	rf_en<='0';
	r7_wr_mux<="00";
	rf_a1_mux<= "00";
	rf_a3_mux<= "000";
	rf_d3_mux<= "00";
	mem_write_bar<='1';
	mem_a_mux<="00";
	mem_d_mux<='1';
	en_t1<= '0';
	en_t2<= '0';
	en_t3<= '0';
	en_t4<= '0';
	pc_en<= '1';
	ir_en<= '1';
	flagc_en<='0';
	flagz_en<= '0';
	t1_mux<= "00";
	t2_mux<= "00";
	t3_mux<='0';
	pc_mux<= "000";
	temp_z_en<='1';
--------------------------------------------------------------------------------------State 2
elsif(X(22 downto 18)="00010") then
	temp_z_en<='1';
	if((X(17 downto 14)="0000" or X(17 downto 14)="0010" ) and X(3 downto 1)="100" ) then
		alu_op<="00"
		alu_a_mux<="00"
		alu_b_mux<="001";
		rf_en<='1';
		r7_wr_mux<="01";
		rf_a1_mux<= "00";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="00";
		mem_d_mux<='1';
		en_t1<= '1';
		en_t2<= '1';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "00";
		t2_mux<= "00";
		t3_mux<='0';
		pc_mux<= "000";
	elsif((X(17 downto 14)="0000" or X(17 downto 14)="0010" ) and X(3 downto 2)="01" and X(0) = '0') then
		alu_op<="00"
		alu_a_mux<="00"
		alu_b_mux<="001";
		rf_en<='1';
		r7_wr_mux<="01";
		rf_a1_mux<= "00";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="00";
		mem_d_mux<='1';
		en_t1<= '1';
		en_t2<= '1';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "00";
		t2_mux<= "00";
		t3_mux<='0';
		pc_mux<= "000";
	else
		alu_op<="00"
		alu_a_mux<="00"
		alu_b_mux<="001";
		rf_en<='0';
		r7_wr_mux<="01";
		rf_a1_mux<= "00";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="00";
		mem_d_mux<='1';
		en_t1<= '1';
		en_t2<= '1';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "00";
		t2_mux<= "00";
		t3_mux<='0';
		pc_mux<= "000";
	end if;
-------------------------------------------------------------------------------------- State 3
elsif(X(22 downto 18)="00011") then
	temp_z_en<='1';
	if (X(17 downto 14) = "0000" or X(17 downto 14) = "0010") then
		if(X(17 downto 14) = "0000") then
			alu_op<="00";
		else 	
			alu_op<="10";
		end if;
		alu_a_mux<="01"
		alu_b_mux<="010";
		rf_en<='0';
		r7_wr_mux<="01";
		rf_a1_mux<= "00";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="00";
		mem_d_mux<='1';
		en_t1<= '1';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		if(X(17 downto 14) = "0000") then
			flagc_en<='1';
			flagz_en<= '1';
		else
			flagc_en<='0';
			flagz_en<= '1';
		end if;
		t1_mux<= "01";
		t2_mux<= "00";
		t3_mux<='0';
		pc_mux<= "000";
	elsif(X(17 downto 14) = "0001") then
		alu_op<="00";
		alu_a_mux<="01"
		alu_b_mux<="100";
		rf_en<='0';
		r7_wr_mux<="01";
		rf_a1_mux<= "00";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="00";
		mem_d_mux<='1';
		en_t1<= '1';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='1';
		flagz_en<= '1';
		t1_mux<= "01";
		t2_mux<= "00";
		t3_mux<='0';
		pc_mux<= "000";

	elsif(X(17 downto 14) = "0100") then
		alu_op<="00";
		alu_a_mux<="10"
		alu_b_mux<="100";
		rf_en<='0';
		r7_wr_mux<="01";
		rf_a1_mux<= "00";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="00";
		mem_d_mux<='1';
		en_t1<= '1';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "01";
		t2_mux<= "00";
		t3_mux<='0';
		pc_mux<= "000";
	elsif(X(17 downto 14)="0101") then
		alu_op<="00";
		alu_a_mux<="10"
		alu_b_mux<="100";
		rf_en<='0';
		r7_wr_mux<="01";
		rf_a1_mux<= "00";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="00";
		mem_d_mux<='1';
		en_t1<= '0';
		en_t2<= '1';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "00";
		t2_mux<= "01";
		t3_mux<='0';
		pc_mux<= "000";
	else
		alu_op<="11";
	end if;
---------------------------------------------------------------------------------- State 4
elsif(X(22 downto 18)="00100") then
	temp_z_en<='1';
	if (X(17 downto 14) = "0000" or X(17 downto 14) = "0010") then
		alu_op<="00";
		alu_a_mux<="10"
		alu_b_mux<="100";
		rf_en<='1';
		if(X(7 downto 5)="111")
		r7_wr_mux<="00";
		else
		r7_wr_mux<="01";
		end if;
		rf_a1_mux<= "00";
		rf_a3_mux<= "001";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="00";
		mem_d_mux<='1';
		en_t1<= '0';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "00";
		t2_mux<= "01";
		t3_mux<='0';
		pc_mux<= "010";
		if(X(7 downto 5) = "111") then
		pc_en<= '1';
		else 
		pc_en<= '0';
		end if;
	elsif(X(17 downto 14)="0001") then
		alu_op<="00";
		alu_a_mux<="10"
		alu_b_mux<="100";
		rf_en<='1';
		if(X(10 downto 8)="111")
		r7_wr_mux<="00";
		else
		r7_wr_mux<="01";
		end if;
		rf_a1_mux<= "00";
		rf_a3_mux<= "011";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="00";
		mem_d_mux<='1';
		en_t1<= '0';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "00";
		t2_mux<= "01";
		t3_mux<='0';
		pc_mux<= "010";
		if(X(10 downto 8) = "111") then
		pc_en<= '1';
		else 
		pc_en<= '0';
		end if;
	elsif(X(17 downto 14)="0011") then
		alu_op<="00";
		alu_a_mux<="10"
		alu_b_mux<="100";
		rf_en<='1';
		if(X(13 downto 11)="111")
		r7_wr_mux<="00";
		else
		r7_wr_mux<="01";
		end if;
		rf_a1_mux<= "00";
		rf_a3_mux<= "100";
		rf_d3_mux<= "01";
		mem_write_bar<='1';
		mem_a_mux<="00";
		mem_d_mux<='1';
		en_t1<= '0';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "00";
		t2_mux<= "01";
		t3_mux<='0';
		pc_mux<= "101";
		if(X(13 downto 11) = "111") then
		pc_en<= '1';
		else 
		pc_en<= '0';
		end if;
	else
		alu_op<="11";
	end if;

------------------------------------------------------------------------------- State 6
elsif(X(22 downto 18)="00110") then
		temp_z_en<='1';
		alu_op<="00";
		alu_a_mux<="10"
		alu_b_mux<="100";
		rf_en<='0';
		r7_wr_mux<="01";
		rf_a1_mux<= "00";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="00";
		mem_d_mux<='1';
		en_t1<= '0';
		en_t2<= '1';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "00";
		t2_mux<= "10";
		t3_mux<='0';
		pc_mux<= "000";
------------------------------------------------------------------------------- State 7
elsif(X(22 downto 18)="00111") then
		temp_z_en<='1';
		alu_op<="00";
		alu_a_mux<="10"
		alu_b_mux<="100";
		rf_en<='0';
		r7_wr_mux<="01";
		rf_a1_mux<= "00";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='1';
		en_t1<= '1';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "10";
		t2_mux<= "10";
		t3_mux<='0';
		pc_mux<= "000";	
-------------------------------------------------------------------------------State 8
elsif(X(22 downto 18)="01000") then
		temp_z_en<='1';
		alu_op<="00";
		alu_a_mux<="01"
		alu_b_mux<="000";
		rf_en<='1';
		if(X(13 downto 11)="111")
		r7_wr_mux<="00";
		else
		r7_wr_mux<="01";
		end if;
		rf_a1_mux<= "00";
		rf_a3_mux<= "100";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="00";
		mem_d_mux<='1';
		en_t1<= '0';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '1';
		t1_mux<= "00";
		t2_mux<= "01";
		t3_mux<='0';
		pc_mux<= "010";
		if(X(13 downto 11) = "111") then
		pc_en<= '1';
		else 
		pc_en<= '0';
		end if;
-----------------------------------------------------------------State 9
elsif(X(22 downto 18)="01001") then
		temp_z_en<='1';
		alu_op<="00";
		alu_a_mux<="10"
		alu_b_mux<="100";
		rf_en<='1';
		r7_wr_mux<="01";
		rf_a1_mux<= "00";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='0';
		mem_a_mux<="10";
		mem_d_mux<='0';
		en_t1<= '0';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "10";
		t2_mux<= "10";
		t3_mux<='0';
		pc_mux<= "000";
-----------------------------------------------------------------State 10
elsif(X(22 downto 18)="01010") then
		temp_z_en<='1';
		alu_op<="00";
		alu_a_mux<="10"
		alu_b_mux<="100";
		rf_en<='0';
		r7_wr_mux<="01";
		rf_a1_mux<= "00";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='0';
		en_t1<= '0';
		en_t2<= '1';
		en_t3<= '1';
		en_t4<= '1';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "10";
		t2_mux<= "11";
		t3_mux<='0';
		pc_mux<= "000";
---------------------------------------------------------------State 11
elsif(X(22 downto 18 = "01011")) then
		temp_z_en<='1';
		alu_op<="00";
		alu_a_mux<="01"
		alu_b_mux<="001";
		rf_en<='1';
		if(X(25 downto 23)="111")
		r7_wr_mux<="00";
		else
		r7_wr_mux<="01";
		end if;
		rf_a1_mux<= "00";
		rf_a3_mux<= "101";
		rf_d3_mux<= "10";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='0';
		en_t1<= '1';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		if(X(25 downto 23) = "111") then
		pc_en<= '1';
		else
		pc_en<=0;
		end if;
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "01";
		t2_mux<= "11";
		t3_mux<='0';
		pc_mux<= "100";
-----------------------------------------------------------------State 12
elsif(X(22 downto 18)="01100") then
		temp_z_en<='1';
		alu_op<="00";
		alu_a_mux<="10"
		alu_b_mux<="100";
		rf_en<='0';
		r7_wr_mux<="01";
		rf_a1_mux<= "00";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='0';
		en_t1<= '0';
		en_t2<= '1';
		en_t3<= '0';
		en_t4<= '1';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "10";
		t2_mux<= "11";
		t3_mux<='0';
		pc_mux<= "000";
-----------------------------------------------------------------State 13
elsif(X(22 downto 18)="01101") then
	    temp_z_en<='1';
		alu_op<="00";
		alu_a_mux<="10"
		alu_b_mux<="100";
		rf_en<='0';
		r7_wr_mux<="01";
		rf_a1_mux<= "10";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='0';
		en_t1<= '0';
		en_t2<= '0';
		en_t3<= '1';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "10";
		t2_mux<= "11";
		t3_mux<='1';
		pc_mux<= "000";
-----------------------------------------------------------------State 14
elsif(X(22 downto 18)="01110") then
		temp_z_en<='1';
		alu_op<="00";
		alu_a_mux<="01"
		alu_b_mux<="001";
		rf_en<='1';
		r7_wr_mux<="01";
		rf_a1_mux<= "00";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='0';
		mem_a_mux<="01";
		mem_d_mux<='1';
		en_t1<= '1';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "01";
		t2_mux<= "11";
		t3_mux<='0';
		pc_mux<= "000";
-----------------------------------------------------------------State 15
elsif(X(22 downto 18)="01111") then
		temp_z_en<='1';
		alu_op<="01";
		alu_a_mux<="01"
		alu_b_mux<="010";
		rf_en<='0';
		r7_wr_mux<="01";
		rf_a1_mux<= "01";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='0';
		en_t1<= '1';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "00";
		t2_mux<= "11";
		t3_mux<='0';
		pc_mux<= "000";
----------------------------------------------------------------State 16
elsif(X(22 downto 18)="10000") then
		temp_z_en<='0';
		alu_op<="00";
		alu_a_mux<="01"
		alu_b_mux<="101";
		rf_en<='1';
		if(X(26) = '0')then
		r7_wr_mux<="01";
		pc_en<= '0';
		else
		pc_en<= '1';
		r7_wr_mux<="11";
		end if;
		rf_a1_mux<= "01";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='0';
		en_t1<= '0';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "00";
		t2_mux<= "11";
		t3_mux<='0';
		pc_mux<= "000";
--------------------------------------------------------------STate 17
elsif(X(22 downto 18)="10001") then
	    temp_z_en<='1';
		alu_op<="00";
		alu_a_mux<="01"
		alu_b_mux<="001";
		rf_en<='0';
		r7_wr_mux<="01";
		rf_a1_mux<= "01";
		rf_a3_mux<= "010";
		rf_d3_mux<= "00";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='1';
		en_t1<= '0';
		en_t2<= '0';
		en_t3<= '1';
		en_t4<= '0';
		pc_en<= '0';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "01";
		t2_mux<= "11";
		t3_mux<='1';
		pc_mux<= "000";
--------------------------------------------------------------STate 18
elsif(X(22 downto 18)="10010") then
	    temp_z_en<='1';
		alu_op<="00";
		alu_a_mux<="11"
		alu_b_mux<="011";
		rf_en<='1';
		r7_wr_mux<="11";
		rf_a1_mux<= "01";
		rf_a3_mux<= "100";
		rf_d3_mux<= "10";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='1';
		en_t1<= '0';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '1';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "01";
		t2_mux<= "11";
		t3_mux<='1';
		pc_mux<= "000";
--------------------------------------------------------------STate 19
elsif(X(22 downto 18)="10011") then
	    temp_z_en<='1';
		alu_op<="00";
		alu_a_mux<="11"
		alu_b_mux<="011";
		rf_en<='1';
		r7_wr_mux<="10";
		rf_a1_mux<= "01";
		rf_a3_mux<= "100";
		rf_d3_mux<= "10";
		mem_write_bar<='1';
		mem_a_mux<="01";
		mem_d_mux<='1';
		en_t1<= '0';
		en_t2<= '0';
		en_t3<= '0';
		en_t4<= '0';
		pc_en<= '1';
		ir_en<= '0';
		flagc_en<='0';
		flagz_en<= '0';
		t1_mux<= "01";
		t2_mux<= "11";
		t3_mux<='1';
		pc_mux<= "011";
else
	alu_op<="11";
end if;

end process;

end Behave;

