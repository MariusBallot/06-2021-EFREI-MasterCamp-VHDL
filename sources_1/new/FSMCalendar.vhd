LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_unsigned.ALL;
USE IEEE.STD_LOGIC_arith.ALL;
ENTITY FSMCalendar IS
    PORT (
        buttonMoreSync, buttonChoiceSync, buttonCheckSync : IN STD_LOGIC;
        clkDebounce : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        clock : IN STD_LOGIC;

        checkE : OUT STD_LOGIC;
        dispDDMM : OUT STD_LOGIC;
        EDayCounter, EMonthCounter : OUT STD_LOGIC;
        EYearCounter : OUT STD_LOGIC
    );
END FSMCalendar;

ARCHITECTURE Behavioral OF FSMCalendar IS

    SIGNAL mydispDDMM : STD_LOGIC;
    SIGNAL myEDayCounter : STD_LOGIC := '0';
    SIGNAL myEMonthCounter : STD_LOGIC := '0';
    SIGNAL myEYearCounter : STD_LOGIC := '0';

    SIGNAL myCheckE : STD_LOGIC; -- a utiliser 

    SIGNAL waitflag : STD_LOGIC := '0';
BEGIN

    PROCESS (clock, clkDebounce, reset)

        VARIABLE state : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

    BEGIN

        IF reset = '1' THEN
            mydispDDMM <= '0';
            myEDayCounter <= '0';
            myEMonthCounter <= '0';
            myEYearCounter <= '0';
            myCheckE <= '0';
            state := "00";

        ELSIF (rising_edge(clock)) THEN
            IF clkDebounce = '1' THEN

                IF buttonChoiceSync = '1' THEN
                    waitflag <= '1';
                ELSIF waitflag = '1' THEN
                    state := state + 1;
                    waitflag <= '0';
                END IF;

                myEDayCounter <= '0';
                myEMonthCounter <= '0';
                myEYearCounter <= '0';
                CASE (state) IS

                    WHEN "00" =>
                        mydispDDMM <= '0';
                        IF buttonMoreSync = '1' THEN
                            myEDayCounter <= '1';
                        END IF;

                    WHEN "01" =>
                        mydispDDMM <= '0';
                        IF buttonMoreSync = '1' THEN
                            myEMonthCounter <= '1';
                        END IF;

                    WHEN "10" =>
                        mydispDDMM <= '1';
                        IF buttonMoreSync = '1' THEN
                            myEYearCounter <= '1';
                        END IF;
                    WHEN OTHERS =>
                        state := "00";

                END CASE;

            END IF;
        END IF;

    END PROCESS;

    dispDDMM <= mydispDDMM;
    EDayCounter <= myEDayCounter;
    EMonthCounter <= myEMonthCounter;
    EYearCounter <= myEYearCounter;
    checkE <= mycheckE;

END Behavioral;