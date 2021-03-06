library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
  port(alu_op: in std_logic_vector(2 downto 1);
      alu_a: in std_logic_vector(15 downto 0);
      alu_b: in std_logic_vector(15 downto 0);
      alu_c: out std_logic;
      alu_z: out std_logic;
      alu_out: out std_logic_vector(15 downto 0));
end entity;

architecture al of ALU is

begin

  process(alu_op, alu_a, alu_b)
  variable a_a, a_b : std_logic_vector(16 downto 0);
  variable a_o : std_logic_vector(16 downto 0);
  
	 begin
    
    a_a(15 downto 0) := alu_a;
    a_a(16) := '0';
    a_b(15 downto 0) := alu_b;
    a_b(16) := '0';

	 case (alu_op) is
		when "00" =>
			a_o := std_logic_vector(unsigned(a_a) + unsigned(a_b));
		when "01" =>
			a_o(15 downto 0) := std_logic_vector(unsigned(a_a(15 downto 0)) - unsigned(a_b(15 downto 0)));
			a_o(16) := '0';
		when "10" =>
			a_o(15 downto 0) := a_a(15 downto 0) nand a_b(15 downto 0);
			a_o(16) := '0';
		when others =>
			a_o(16 downto 0) := (others=>'0');
    end case;
    alu_out <= a_o(15 downto 0);
    alu_c <= a_o(16);
    alu_z <= not (a_o(15) or a_o(14) or a_o(13) or a_o(12) or a_o(11) or a_o(10) or a_o(9) or a_o(8) or a_o(7) or a_o(6) or a_o(5) or a_o(4) or a_o(3) or a_o(2) or a_o(1) or a_o(0));
  end process;
end architecture al;
