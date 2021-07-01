LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
ENTITY LEDManagementTest IS

END LEDManagementTest;

ARCHITECTURE Behavioral OF LEDManagementTest IS
  COMPONENT LEDManagement IS
    PORT (
      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      totalDayNumber : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      OK : IN STD_LOGIC;
      led : OUT STD_LOGIC_VECTOR

    );
  END COMPONENT;

  SIGNAL testtotalDayNumber : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL testOK : STD_LOGIC;
  SIGNAL testled : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL testcheckE : STD_LOGIC;
  SIGNAL myreset : STD_LOGIC;
  SIGNAL myclock : STD_LOGIC;

BEGIN

  InstLEDManagement : LEDManagement
  PORT MAP(

    totalDayNumber => testtotalDayNumber,
    OK => testOK,
    led => testled,
    reset => myreset,
    clock => myclock
  );

  myresetTest : PROCESS
  BEGIN
    myreset <= '1';
    WAIT FOR 10 ns;
    myreset <= '0';
    WAIT;
  END PROCESS;

  myclocktest : PROCESS
  BEGIN
    myclock <= '0';
    WAIT FOR 5 ns;
    myclock <= '1';
    WAIT FOR 5 ns;
  END PROCESS;

  totalDayTest : PROCESS
  BEGIN
    testtotalDayNumber <= "100";
    WAIT FOR 5 ms;
    testtotalDayNumber <= "101";
    WAIT FOR 5 ms;
  END PROCESS;

  checkEtest : PROCESS
  BEGIN
    testcheckE <= '0';
    WAIT FOR 15 ms;
    testcheckE <= '1';
    WAIT FOR 15 ms;
  END PROCESS;

  OKtest : PROCESS
  BEGIN
    testOK <= '0';
    WAIT FOR 20 ms;
    testOK <= '1';
    WAIT FOR 20 ms;
  END PROCESS;

END Behavioral;