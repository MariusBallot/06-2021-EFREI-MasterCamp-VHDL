LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SingleSync IS
  PORT (
    clock, reset : IN STD_LOGIC;
    button : IN STD_LOGIC;
    buttonSync : OUT STD_LOGIC
  );
END ENTITY SingleSync;

ARCHITECTURE behavior OF SingleSync IS
  CONSTANT limit : NATURAL := 20000000;
  SIGNAL mybuttonSync : STD_LOGIC;

BEGIN

  PROCESS (clock, reset) IS
    VARIABLE counter : NATURAL RANGE 0 TO 20000000;

  BEGIN

    IF (reset = '1') THEN
      myButtonSync <= '0';
      buttonSync <= '0';
      counter := 0;
    ELSIF rising_edge(clock) THEN
      IF mybuttonsync /= button THEN
        counter := 0;
        mybuttonsync <= button;

      ELSIF mybuttonsync = button THEN
        counter := counter + 1;
        IF counter = limit THEN
          counter := 0;
          buttonSync <= mybuttonSync;
        END IF;
      END IF;
    END IF;

  END PROCESS;
END ARCHITECTURE behavior;