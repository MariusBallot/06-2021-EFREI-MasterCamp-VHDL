LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY byte_gen IS
    PORT (
        id_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        code_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        en : OUT STD_LOGIC;
        byte_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY byte_gen;

ARCHITECTURE behavior OF byte_gen IS
BEGIN
    PROCESS (id_i, code_i) IS
    BEGIN
        byte_o <= id_i & code_i;
        en <= '1';
    END PROCESS;
END ARCHITECTURE behavior;