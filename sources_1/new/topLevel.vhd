LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY topLevel IS
  PORT (
    clock : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    buttonMore : IN STD_LOGIC;
    buttonChoice : IN STD_LOGIC;
    buttonCheck : IN STD_LOGIC;
    led : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    AN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    sevenSeg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
  );

END topLevel;

ARCHITECTURE Behavioral OF topLevel IS

  COMPONENT ModuloFour
    PORT (
      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      clockEnableDisplay : IN STD_LOGIC;
      AN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      mod4 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT Transcoder
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
  COMPONENT Mux4to1
    PORT (
      disp0 : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      disp1 : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      disp2 : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      disp3 : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
      mod4 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      sevenSeg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT SevenSegmentDecod
    PORT (
      disp0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      disp1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      disp2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      disp3 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      dout0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      dout1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      dout2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      dout3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT LEDManagement
    PORT (
      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      totalDayNumber : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      OK : IN STD_LOGIC;
      led : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT ClockManagement
    PORT (
      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;

      CESlow, clockEnableDisplay, CEDebounce : OUT STD_LOGIC
    );
  END COMPONENT;

  COMPONENT SingleSync
    PORT (
      clock, reset : IN STD_LOGIC;
      button : IN STD_LOGIC;
      buttonSync : OUT STD_LOGIC
    );
  END COMPONENT;
  COMPONENT FSMCalendar
    PORT (
      buttonMoreSync, buttonChoiceSync, buttonCheckSync : IN STD_LOGIC;
      clkDebounce : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      clock : IN STD_LOGIC;
      checkE : OUT STD_LOGIC;
      dispDDMM : OUT STD_LOGIC;
      EDayCounter, EMonthCounter : OUT STD_LOGIC;
      EYearCounter : OUT STD_LOGIC
    );
  END COMPONENT;
  COMPONENT Counter
    PORT (
      EDayCounter, EMonthCounter, EYearCounter : IN STD_LOGIC;
      CESlow : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      clk : IN STD_LOGIC;

      day, month : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      year : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT Check
    PORT (
      checkE : IN STD_LOGIC;
      day : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      month : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      year : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      totalDayNumber : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
      OK : OUT STD_LOGIC
    );
  END COMPONENT;
  -- Signaux d'horloges internes --

  SIGNAL myclkDebounce : STD_LOGIC := '0';
  SIGNAL myCESlow : STD_LOGIC := '0';
  SIGNAL myclockEnableDisplay : STD_LOGIC := '0';
  SIGNAL clock100Mhz : STD_LOGIC := '0';

  SIGNAL myled : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL mysevenSeg : STD_LOGIC_VECTOR(6 DOWNTO 0);

  SIGNAL myrst : STD_LOGIC := '0';
  SIGNAL myCheckE : STD_LOGIC := '0';
  SIGNAL myOK : STD_LOGIC := '0';
  SIGNAL myDay : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL myMonth : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL myYear : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL mytotalDayNumber : STD_LOGIC_VECTOR (2 DOWNTO 0);

  SIGNAL mydispDDMM : STD_LOGIC;
  SIGNAL myEDayCounter : STD_LOGIC := '0';
  SIGNAL myEMonthCounter : STD_LOGIC := '0';
  SIGNAL myEYearCounter : STD_LOGIC := '0';
  -- SIGNAL myCheckE : STD_LOGIC;

  SIGNAL myButtonChoiceSync : STD_LOGIC := '0';
  SIGNAL myButtonMoreSync : STD_LOGIC := '0';
  SIGNAL myButtonCheckSync : STD_LOGIC := '0';

  SIGNAL mydisp0 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
  SIGNAL mydisp1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
  SIGNAL mydisp2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
  SIGNAL mydisp3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";

  SIGNAL mymod4 : STD_LOGIC_VECTOR (1 DOWNTO 0);

  SIGNAL mydout0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL mydout1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL mydout2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL mydout3 : STD_LOGIC_VECTOR(6 DOWNTO 0);

  SIGNAL myButtChoice : STD_LOGIC;
  SIGNAL myButtMore : STD_LOGIC;
  SIGNAL myButtCheck : STD_LOGIC;

  SIGNAL myAN : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

  Inst_ModuloFour : ModuloFour

  PORT MAP(
    clock => clock100Mhz,
    reset => myrst,
    clockEnableDisplay => myclockEnableDisplay,
    AN => myAN,
    mod4 => mymod4
  );

  Inst_Check : Check

  PORT MAP(
    day => myDay,
    month => myMonth,
    year => myYear,
    totalDayNumber => mytotalDayNumber,
    OK => myOK,
    checkE => myCheckE
  );

  Inst_Counter : Counter
  PORT MAP(
    EDayCounter => myEDayCounter,
    EMonthCounter => myEMonthCounter,
    EYearCounter => myEYearCounter,
    CESlow => myCESlow,
    reset => myrst,
    clk => clock100Mhz,
    day => myDay,
    month => myMonth,
    year => myYear
  );

  Inst_FSMCalendar : FSMCalendar
  PORT MAP(

    buttonMoreSync => myButtonMoreSync,
    buttonChoiceSync => myButtonChoiceSync,
    buttonCheckSync => myButtonCheckSync,
    clkDebounce => myclkDebounce,
    reset => myrst,
    clock => clock100Mhz,
    checkE => myCheckE,
    dispDDMM => mydispDDMM,
    EDayCounter => myEDayCounter,
    EMonthCounter => myEMonthCounter,
    EYearCounter => myEYearCounter
  );

  Inst_SingleSyncChoice : SingleSync
  PORT MAP(

    clock => clock100Mhz,
    reset => myrst,
    button => myButtChoice,
    buttonSync => myButtonChoiceSync
  );

  Inst_SingleSyncMore : SingleSync
  PORT MAP(

    clock => clock100Mhz,
    reset => myrst,
    button => myButtMore,
    buttonSync => myButtonMoreSync
  );

  Inst_SingleSyncCheck : SingleSync
  PORT MAP(

    clock => clock100Mhz,
    reset => myrst,
    button => myButtCheck,
    buttonSync => myButtonCheckSync
  );

  Inst_ClockManagement : ClockManagement
  PORT MAP(

    clock => clock100Mhz,
    reset => myrst,
    CESlow => myCESlow,
    clockEnableDisplay => myclockEnableDisplay,
    CEDebounce => myclkDebounce
  );

  Inst_LEDManagement : LEDManagement
  PORT MAP(
    clock => clock100Mhz,
    reset => myrst,
    totalDayNumber => mytotalDayNumber,
    OK => myOK,
    led => myled
  );

  Inst_SevenSegmentDecod : SevenSegmentDecod
  PORT MAP(

    disp0 => mydisp0,
    disp1 => mydisp1,
    disp2 => mydisp2,
    disp3 => mydisp3,
    dout0 => mydout0,
    dout1 => mydout1,
    dout2 => mydout2,
    dout3 => mydout3
  );

  Inst_Mux4to1 : Mux4to1
  PORT MAP(

    disp0 => mydout0, -- sortie du SSD
    disp1 => mydout1,
    disp2 => mydout2,
    disp3 => mydout3,
    mod4 => mymod4,
    sevenSeg => mysevenSeg
  );

  Inst_Transcoder : Transcoder
  PORT MAP(

    dispDDMM => mydispDDMM,
    day => myDay,
    month => myMonth,
    year => myYear,
    disp0 => mydisp0,
    disp1 => mydisp1,
    disp2 => mydisp2,
    disp3 => mydisp3
  );

  clock100Mhz <= clock;
  myrst <= reset;
  myButtChoice <= buttonMore;
  myButtMore <= buttonChoice;
  myButtCheck <= buttonCheck;
  led <= myled;
  AN <= myAN;
  sevenSeg <= mysevenSeg;

END behavioral;