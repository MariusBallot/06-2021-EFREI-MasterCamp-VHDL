LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY Counter IS
    PORT (
        EDayCounter, EMonthCounter, EYearCounter : IN STD_LOGIC;
        CESlow : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        day, month : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        year : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavorial OF Counter IS

    SIGNAL myDay : STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000001";--01
    SIGNAL myMonth : STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000001";--01
    SIGNAL myYear : STD_LOGIC_VECTOR (15 DOWNTO 0) := "0000011110011110"; --1950
    SIGNAL CEFlag : STD_LOGIC := '1';

BEGIN

    PROCESS (clk, reset)
    BEGIN

        IF reset = '1' THEN
            myDay <= "00000001";
            myMonth <= "00000001";
            myYear <= "0000011110011110";
            CEFlag <= '1';

        ELSIF (rising_edge(clk)) THEN

            IF CESlow = '1' THEN
                IF CEFlag = '1' THEN
                    IF EDayCounter = '1' THEN
                        myDay <= myDay + 1;
                        CEFlag <= '0';
                    ELSIF EMonthCounter = '1' THEN
                        myMonth <= myMonth + 1;
                        CEFlag <= '0';

                    ELSIF EYearCounter = '1' THEN
                        myYear <= myYear + 1;
                        CEFlag <= '0';
                    END IF;

                END IF;
            ELSE
                CEFlag <= '1';
            END IF;

        END IF;

    END PROCESS;

    day <= myDay;
    month <= myMonth;
    year <= myYear;

END Behavorial;