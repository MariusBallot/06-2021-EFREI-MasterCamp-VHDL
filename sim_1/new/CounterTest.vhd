LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY CounterTest IS

END CounterTest;

ARCHITECTURE Behavioral OF CounterTest IS

    COMPONENT Counter IS

        PORT (
            EDayCounter, EMonthCounter, EYearCounter : IN STD_LOGIC;
            CESlow : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            clk : IN STD_LOGIC;

            day, month : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
            year : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL myEDayCounter : STD_LOGIC;
    SIGNAL myEMonthCounter : STD_LOGIC;
    SIGNAL myEYearCounter : STD_LOGIC;
    SIGNAL myCESlow : STD_LOGIC;
    SIGNAL myreset : STD_LOGIC;
    SIGNAL myclk : STD_LOGIC;

    SIGNAL myDay : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL myMonth : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL myYear : STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN

    InstCounter : Counter

    PORT MAP(
        EDayCounter => myEDayCounter,
        EMonthCounter => myEMonthCounter,
        EYearCounter => myEYearCounter,
        CESlow => myCESlow,
        reset => myreset,
        clk => myclk,

        day => myDay,
        month => myMonth,
        year => myYear
    );

    myclock : PROCESS

    BEGIN
        -- 100 Hz => T= 2 ms
        myclk <= '0';
        WAIT FOR 5 ns;
        myclk <= '1';
        WAIT FOR 5 ns;

    END PROCESS;
    myclockDebounce : PROCESS

    BEGIN
        -- 4 Hz => T= 250 ms/2 = 125
        myCESlow <= '0';
        WAIT FOR 10 ms;
        myCESlow <= '1';
        WAIT FOR 10 ms;

    END PROCESS;

    myrst : PROCESS

    BEGIN

        myreset <= '1';
        WAIT FOR 1 ms;
        myreset <= '0';
        WAIT;

    END PROCESS;

    EDayCounterpro : PROCESS

    BEGIN

        myEDayCounter <= '0';
        WAIT FOR 10 ms;
        myEDayCounter <= '1';
        WAIT FOR 30 ms;
        myEDayCounter <= '0';
        WAIT;

    END PROCESS;

    EMonthCounterpro : PROCESS

    BEGIN

        myEMonthCounter <= '0';
        WAIT FOR 40 ms;
        myEMonthCounter <= '1';
        WAIT FOR 50 ms;
        myEMonthCounter <= '0';
        WAIT;

    END PROCESS;

    EYearCounter : PROCESS

    BEGIN

        myEYearCounter <= '0';
        WAIT FOR 95 ms;
        myEYearCounter <= '1';
        WAIT FOR 30 ms;
        myEYearCounter <= '0';
        WAIT;

    END PROCESS;
END Behavioral;