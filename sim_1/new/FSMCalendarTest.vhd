LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY FSMCalendarTest IS

END FSMCalendarTest;

ARCHITECTURE Behavioral OF FSMCalendarTest IS

  COMPONENT FSMCalendar IS
    PORT (

      reset : IN STD_LOGIC;
      clock : IN STD_LOGIC;
      clkDebounce : IN STD_LOGIC;
      buttonMoreSync : IN STD_LOGIC;
      buttonChoiceSync : IN STD_LOGIC;
      buttonCheckSync : IN STD_LOGIC;

      checkE : OUT STD_LOGIC;
      dispDDMM : OUT STD_LOGIC;
      EDayCounter : OUT STD_LOGIC;
      EMonthCounter : OUT STD_LOGIC;
      EYearCounter : OUT STD_LOGIC
    );

  END COMPONENT;

  SIGNAL mydispDDMM : STD_LOGIC;
  SIGNAL myEDayCounter : STD_LOGIC;
  SIGNAL myEMonthCounter : STD_LOGIC;
  SIGNAL myEYearCounter : STD_LOGIC;
  SIGNAL myCheckE : STD_LOGIC; -- a utiliser 
  SIGNAL mybuttonMoreSync : STD_LOGIC;
  SIGNAL mybuttonChoiceSync : STD_LOGIC;
  SIGNAL mybuttonCheckSync : STD_LOGIC;
  SIGNAL myClkDebounce : STD_LOGIC;
  SIGNAL myclock : STD_LOGIC;
  SIGNAL myreset : STD_LOGIC;

BEGIN

  InstFSMCalendar : FSMCalendar

  PORT MAP(
    buttonMoreSync => mybuttonMoreSync,
    buttonChoiceSync => mybuttonChoiceSync,
    buttonCheckSync => mybuttonCheckSync,
    checkE => myCheckE,
    dispDDMM => mydispDDMM,
    EDayCounter => myEDayCounter,
    EMonthCounter => myEMonthCounter,
    EYearCounter => myEYearCounter,
    clkDebounce => myClkDebounce,
    reset => myreset,
    clock => myclock
  );

  debounceclock : PROCESS

  BEGIN
    -- 200 Hz => T= 5 ms
    myClkDebounce <= '0';
    WAIT FOR 2.5 ms;
    myClkDebounce <= '1';
    WAIT FOR 2.5 ms;

  END PROCESS;

  myrst : PROCESS

  BEGIN

    myreset <= '1';
    WAIT FOR 1 ms;
    myreset <= '0';
    WAIT;
  END PROCESS;
  myButtonChoicepro : PROCESS

  BEGIN
    MybuttonChoiceSync <= '1'; --modDay
    WAIT FOR 30 ms;
    MybuttonChoiceSync <= '0';
    WAIT FOR 5 ms;
    MybuttonChoiceSync <= '1'; --modYear
    WAIT FOR 30 ms;
    MybuttonChoiceSync <= '0';
    WAIT FOR 5 ms;
    MybuttonChoiceSync <= '1'; --modDay
    WAIT FOR 30 ms;
    MybuttonChoiceSync <= '0';
    WAIT FOR 5 ms;
    MybuttonChoiceSync <= '1'; --modYear
    WAIT FOR 30 ms;
    MybuttonChoiceSync <= '0';

    WAIT;
  END PROCESS;

  testclk : PROCESS
  BEGIN
    myclock <= '0';
    WAIT FOR 5 ns;
    myclock <= '1';
    WAIT FOR 5 ns;
  END PROCESS;

  myButtonMorepro : PROCESS

  BEGIN
    mybuttonMoreSync <= '1'; --incrémente pendant 5 ms
    WAIT FOR 40 ms;
    mybuttonMoreSync <= '0';--attend de passer à modDay
    WAIT FOR 6 ms;
    mybuttonMoreSync <= '1';
    WAIT FOR 50 ms;
    mybuttonMoreSync <= '0';
    WAIT FOR 5 ms;
    mybuttonMoreSync <= '1'; --modYear
    WAIT FOR 10 ms;
    mybuttonMoreSync <= '0';
    WAIT;
  END PROCESS;

END Behavioral;