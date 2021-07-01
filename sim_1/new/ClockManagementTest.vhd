LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY ClockManagementTest IS

END ClockManagementTest;

ARCHITECTURE behavioral_arch OF ClockManagementTest IS

  COMPONENT ClockManagement IS
    PORT (
      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;

      CESlow, clockEnableDisplay, CEDebounce : OUT STD_LOGIC
    );
  END COMPONENT;

  SIGNAL testclock : STD_LOGIC;
  SIGNAL testreset : STD_LOGIC;

  SIGNAL testCESlow : STD_LOGIC;
  SIGNAL testclockEnableDisplay : STD_LOGIC;
  SIGNAL testCEDebounce : STD_LOGIC;

BEGIN

  InstClockMan : ClockManagement

  PORT MAP(
    clock => testclock,
    reset => testreset,
    CESlow => testCESlow,
    clockEnableDisplay => testclockEnableDisplay,
    CEDebounce => testCEDebounce
  );

  testclk : PROCESS
  BEGIN

    testclock <= '0';
    WAIT FOR 5 ns;
    testclock <= '1';
    WAIT FOR 5 ns;

  END PROCESS;

  testrst : PROCESS
  BEGIN

    testreset <= '1';
    WAIT FOR 5 ns;
    testreset <= '0';
    WAIT;

  END PROCESS;

END behavioral_arch;