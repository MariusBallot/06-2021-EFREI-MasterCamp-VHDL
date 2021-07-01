-- Code your testbench here
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
--USE IEEE.STD_LOGIC_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY CheckTest IS

END CheckTest;

ARCHITECTURE Behavioral OF CheckTest IS

        COMPONENT Check IS
                PORT (
                        checkE : IN STD_LOGIC;
                        day : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                        month : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                        year : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                        totalDayNumber : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                        ok : OUT STD_LOGIC

                );
        END COMPONENT;
        SIGNAL mycheckE : STD_LOGIC;
        SIGNAL myday : STD_LOGIC_VECTOR (7 DOWNTO 0);
        SIGNAL mymonth : STD_LOGIC_VECTOR (7 DOWNTO 0);
        SIGNAL myyear : STD_LOGIC_VECTOR (15 DOWNTO 0);
        SIGNAL mytotalDayNumber : STD_LOGIC_VECTOR (2 DOWNTO 0);
        SIGNAL myok : STD_LOGIC;

        --SIGNAL mybisextMod : integer := 0;
BEGIN

        InstCheck : Check
        PORT MAP(

                checkE => mycheckE,
                day => myday,
                month => mymonth,
                year => myyear,
                totalDayNumber => mytotalDayNumber,
                ok => myok
        );
        checkEtest : PROCESS

        BEGIN

                mycheckE <= '1';
                WAIT;
        END PROCESS;

        dayTest : PROCESS

        BEGIN
                myday <= "00100000";
                WAIT;
        END PROCESS;

        monthTest : PROCESS

        BEGIN
                mymonth <= "00010000";
                WAIT;
        END PROCESS;
        yearTest : PROCESS

        BEGIN
                myyear <= "0010000000000000";
                WAIT;

        END PROCESS;

END Behavioral;