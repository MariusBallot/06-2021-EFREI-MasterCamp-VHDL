LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY LEDManagement IS
    PORT (
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        totalDayNumber : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        OK : IN STD_LOGIC;
        led : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
    );
END LEDManagement;

ARCHITECTURE Behavioral OF LEDManagement IS

    SIGNAL mytotalDayNumber : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL myOK : STD_LOGIC;
    SIGNAL myled : STD_LOGIC_VECTOR (6 DOWNTO 0);

BEGIN
    myprocess : PROCESS (clock, reset, myled)
    BEGIN
        IF (reset = '1') THEN
            myled <= "0000000";

        ELSIF rising_edge(clock) THEN

            IF OK = '0' THEN
                CASE totalDayNumber IS
                    WHEN "110" =>
                        myled <= "0000001";
                    WHEN "101" =>
                        myled <= "0000010";
                    WHEN "100" =>
                        myled <= "0000100";
                    WHEN "011" =>
                        myled <= "0001000";
                    WHEN "010" =>
                        myled <= "0010000";
                    WHEN "001" =>
                        myled <= "0100000";
                    WHEN "000" =>
                        myled <= "1000000";
                    WHEN OTHERS =>
                        myled <= "0000000";
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    led <= myled;

END Behavioral;