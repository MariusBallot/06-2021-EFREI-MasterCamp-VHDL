-- Code your testbench here
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY TranscoderTest IS

END TranscoderTest;

ARCHITECTURE Behavioral OF TranscoderTest IS

    COMPONENT Transcoder IS
        PORT (
            dispDDMM : IN STD_LOGIC;
            day : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            month : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            year : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            disp0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            disp1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            disp2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            disp3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    SIGNAL testdispDDMM : STD_LOGIC;
    SIGNAL testday : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL testmonth : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL testyear : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL testdisp0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL testdisp1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL testdisp2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL testdisp3 : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
    InstTranscoder : Transcoder

    PORT MAP(
        dispDDMM => testdispDDMM,
        day => testday,
        month => testmonth,
        year => testyear,
        disp0 => testdisp0,
        disp1 => testdisp1,
        disp2 => testdisp2,
        disp3 => testdisp3
    );

    mydispDDMMproc : PROCESS
    BEGIN

        testdispDDMM <= '0';
        WAIT FOR 10 ms;
        testdispDDMM <= '1';
        WAIT FOR 10 ms;
        testdispDDMM <= '0';
        WAIT;
    END PROCESS;

    mymonthproc : PROCESS
    BEGIN

        testmonth <= "00000001";
        WAIT FOR 10 ms;
        testmonth <= "00000010";
        WAIT FOR 10 ms;
        testmonth <= "00010001";
        WAIT;
    END PROCESS;

    mydayproc : PROCESS
    BEGIN

        testday <= "00000001";
        WAIT FOR 10 ms;
        testday <= "00000010";
        WAIT FOR 10 ms;
        testday <= "00010001";
        WAIT;
    END PROCESS;

    myyearproc : PROCESS
    BEGIN
        testyear <= "0000000000000001";
        WAIT FOR 10 ms;
        testyear <= "0000000000000010";
        WAIT FOR 10 ms;
        testyear <= "0000000000010001";
        WAIT;
    END PROCESS;

END Behavioral;