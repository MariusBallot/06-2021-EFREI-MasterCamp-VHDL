LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY SingleSyncTest IS
END SingleSyncTest;

ARCHITECTURE Behavioral OF SingleSyncTest IS
  COMPONENT SingleSync IS
    PORT (
      clock, reset, button : IN STD_LOGIC;
      buttonSync : OUT STD_LOGIC
    );
  END COMPONENT;
  SIGNAL testclock : STD_LOGIC;
  SIGNAL testreset : STD_LOGIC;
  SIGNAL testbutton : STD_LOGIC;
  SIGNAL testbuttonSync : STD_LOGIC;

BEGIN

  InstSingleSync : SingleSync

  PORT MAP(
    clock => testclock,
    reset => testreset,
    button => testbutton,
    buttonSync => testbuttonSync
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

  tesbutton : PROCESS
  BEGIN

    testbutton <= '1';
    WAIT FOR 5 ns;
    testbutton <= '0';
    WAIT FOR 5 ns;
    testbutton <= '1';
    WAIT FOR 10 ns;
    testbutton <= '0';
    WAIT FOR 5 ns;
    testbutton <= '1';
    WAIT FOR 50 ms;
    testbutton <= '0';
    WAIT FOR 5 ns;
    testbutton <= '1';
    WAIT;

  END PROCESS;
END Behavioral;