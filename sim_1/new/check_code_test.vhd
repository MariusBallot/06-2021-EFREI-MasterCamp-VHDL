LIBRARY IEEE; -- top level
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

ENTITY check_code_test IS
END check_code_test;

ARCHITECTURE Behavioral OF check_code_test IS
    COMPONENT Check_Code IS

        PORT (
            clock : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            code : IN STD_LOGIC_VECTOR (51 DOWNTO 0);
            ok : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL myClk : STD_LOGIC := '0';
    SIGNAL myReset : STD_LOGIC := '0';
    SIGNAL myCode : STD_LOGIC_VECTOR (51 DOWNTO 0) := (OTHERS => '0');
    SIGNAL myOK : STD_LOGIC := '1';

BEGIN

    InstCheckCode : Check_Code
    PORT MAP(
        clock => myClk,
        reset => myReset,
        code => myCode,
        ok => myOK
    );

    myclockProcess : PROCESS
    BEGIN

        myClk <= '0';
        WAIT FOR 5 ns;
        myClk <= '1';
        WAIT FOR 5 ns;

    END PROCESS;

    myResetprocess : PROCESS
    BEGIN

        myReset <= '1';
        WAIT FOR 2 ns;
        myReset <= '0';

        WAIT;

    END PROCESS;

    myCodeProcess : PROCESS

    BEGIN
        --WAIT FOR 5 ns;
        --myCode <= "0011000100000001001000000000000100100100100000100001"; --BON
        --WAIT FOR 10 ns;
        --myCode <= "0011000000010001000110011001100100010101100100110010"; --BON
        --WAIT FOR 10 ns;
        --myCode <= "0000011001000010001000000100000001100010000111000111"; --FAUX
        --WAIT FOR 10 ns;
        --myCode <= "0001010000000111001000000001001101100001000010010010"; --Vrai
        --WAIT FOR 10 ns;
          myCode <= "0001010000100111001000010000001101101001000010010010"; --Faux
         WAIT FOR 10 ns;
        WAIT;

    END PROCESS;

END Behavioral;