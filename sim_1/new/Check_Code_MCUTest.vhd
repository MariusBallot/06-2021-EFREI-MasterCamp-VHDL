LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- coucou lmes frero

ENTITY Check_Code_MCUTest IS
END Check_Code_MCUTest;

ARCHITECTURE Behavioral OF Check_Code_MCUTest IS
  COMPONENT Check_Code_MCU IS
    PORT (
      code : IN STD_LOGIC_VECTOR(51 DOWNTO 0);
      checkEnable : IN STD_LOGIC;
      memoryCode : STD_LOGIC_VECTOR(51 DOWNTO 0);
      reset : IN STD_LOGIC;

      ok : OUT STD_LOGIC;
      res_enable : OUT STD_LOGIC
    );

  END COMPONENT;
  SIGNAL mycode : STD_LOGIC_VECTOR(51 DOWNTO 0);
  SIGNAL mycheckEnable : STD_LOGIC;
  SIGNAL mymemoryCode : STD_LOGIC_VECTOR(51 DOWNTO 0);
  SIGNAL myreset : STD_LOGIC;
  SIGNAL myok : STD_LOGIC;
  SIGNAL myres_enable : STD_LOGIC;
BEGIN

  instCheck_Code_MCU : Check_Code_MCU
  PORT MAP(
    code => mycode,
    checkEnable => mycheckEnable,
    memoryCode => mymemoryCode,
    reset => myreset,
    ok => myok,
    res_enable => myres_enable
  );

  resetProc : PROCESS
  BEGIN
    myreset <= '1';
    WAIT FOR 5ns;
    myreset <= '0';
    WAIT;
  END PROCESS;

  memoProc : PROCESS
  BEGIN
    mycode <= "0111011100001001110111010010011000111101110010111100";
    mycheckEnable <= '1';
    WAIT FOR 5ns;
    mymemoryCode <= "0011100001101001110111111010100011111100001010000110";
    WAIT FOR 5ns;
    mymemoryCode <= "0000001100111100000111111111101011010111001010001000";
    WAIT FOR 5ns;
    mymemoryCode <= "0111010001100101100111010110100011111110101000000110";
    WAIT FOR 5ns;
    mymemoryCode <= "0111010001100101100111010110100011111110101000000110";
    WAIT FOR 5ns;
    mymemoryCode <= "0111011100001001110111010010011000111101110010111100";
    WAIT FOR 5ns;

    mycheckEnable <= '0';

    WAIT;
  END PROCESS;
END Behavioral;