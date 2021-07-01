LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

--1011111010111100001000000

ENTITY ClockManagement IS
    PORT (
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        CESlow, clockEnableDisplay, CEDebounce : OUT STD_LOGIC
    );
END ClockManagement;

ARCHITECTURE Behavioral OF ClockManagement IS
    CONSTANT limit1 : NATURAL := 500000; --100*10^6/(200hz) = 25000000
    CONSTANT limit2 : NATURAL := 25000000; --100*10^6/(4hz) = 25000000
BEGIN

    PROCESS (reset, clock) IS
        VARIABLE counter1 : NATURAL RANGE 0 TO 500000;
        VARIABLE counter2 : NATURAL RANGE 0 TO 25000000;
    BEGIN
        IF (reset = '1') THEN
            counter1 := 0;
            counter2 := 0;
        ELSIF rising_edge(clock) THEN
            counter1 := counter1 + 1;
            counter2 := counter2 + 1;
            clockEnableDisplay <= '0';
            CEDebounce <= '0';
            IF counter1 = limit1 THEN
                counter1 := 0;
                clockEnableDisplay <= '1';
                CEDebounce <= '1';

            END IF;

            IF counter2 = limit2 THEN
                counter2 := 0;
                CESlow <= '1';
            END IF;
        END IF;
    END PROCESS;
END Behavioral;