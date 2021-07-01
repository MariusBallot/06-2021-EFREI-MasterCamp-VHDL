library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity id_code_gen is
port(
done:in std_logic;
byte_i: in std_logic_vector(7 downto 0);
id_o: out std_logic_vector(3 downto 0);
code_o: out std_logic_vector(3 downto 0)
);
end entity id_code_gen;

ARCHITECTURE behavior of id_code_gen is
begin
process (done) is
begin
report("id_code_gen");
if done = '1' then
	id_o <= byte_i(7 downto 4);
	code_o <= byte_i(3 downto 0);
end if;
report("FIN id_code_gen");
end process;
end architecture behavior;