LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

ENTITY Check_Code_MCU IS
  PORT (
    code : IN STD_LOGIC_VECTOR(51 DOWNTO 0);
    checkEnable : IN STD_LOGIC;
    memoryCode : STD_LOGIC_VECTOR(51 DOWNTO 0);
    reset : IN STD_LOGIC;

    ok : OUT STD_LOGIC;
    res_enable : OUT STD_LOGIC
  );
END Check_Code_MCU;

ARCHITECTURE Behavioral OF Check_Code_MCU IS
  SIGNAL startFlag : STD_LOGIC := '0';
  SIGNAL myres_enable : STD_LOGIC := '0';
BEGIN

  checkProcess : PROCESS (checkEnable, reset, code, memorycode)

  BEGIN
    IF reset = '1' THEN
      ok <= '0';
      startFlag <= '0';
      myres_enable <= '0';
    ELSIF checkEnable = '1' THEN
      startFlag <= '1';
      IF (to_integer(unsigned(code)) = to_integer(unsigned(memorycode))) THEN
        REPORT "yayayayaya";
        myres_enable <= '1';
      END IF;
    ELSE
      IF (startFlag = '1' AND myres_enable = '0') THEN
        ok <= '1';
        myres_enable <= '1';
      END IF;
    END IF;
  END PROCESS;
  res_enable <= myres_enable;

END Behavioral;