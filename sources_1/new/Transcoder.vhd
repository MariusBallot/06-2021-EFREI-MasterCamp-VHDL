-- Code your design here
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY Transcoder IS
    PORT (
        dispDDMM : IN STD_LOGIC;
        day : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        month : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        year : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        disp0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        disp1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        disp2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        disp3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END Transcoder;

ARCHITECTURE Behavioral OF Transcoder IS

    SIGNAL mydispDDMM : STD_LOGIC;
    SIGNAL myday : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL mymonth : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL myyear : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
    SIGNAL mydisp0 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL mydisp1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL mydisp2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL mydisp3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";

BEGIN

    myprocess : PROCESS (mydispDDMM, mymonth, myday, myyear, mydisp0, mydisp1, mydisp2, mydisp3)
    BEGIN

        IF mydispDDMM = '0' THEN
            mydisp0 <= month(3 DOWNTO 0);
            mydisp1 <= month(7 DOWNTO 4);
            mydisp2 <= day(3 DOWNTO 0);
            mydisp3 <= day(7 DOWNTO 4);
        ELSE
            mydisp0 <= year(3 DOWNTO 0);
            mydisp1 <= year(7 DOWNTO 4);
            mydisp2 <= year(11 DOWNTO 8);
            mydisp3 <= year(15 DOWNTO 12);

        END IF;

    END PROCESS;

    mydispDDMM <= dispDDMM;
    disp0 <= mydisp0;
    disp1 <= mydisp1;
    disp2 <= mydisp2;
    disp3 <= mydisp3;
END Behavioral;