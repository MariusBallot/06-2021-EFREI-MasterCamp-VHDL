LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE IEEE.STD_LOGIC_UNSIGNED.ALL;


 ENTITY ModuloFourTest IS
 END ModuloFourTest;

 ARCHITECTURE Behavioral OF ModuloFourTest IS

     COMPONENT ModuloFour IS

         PORT (
             clock : IN STD_LOGIC;
             reset : IN STD_LOGIC;
             clockEnableDisplay : IN STD_LOGIC;
             AN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
             mod4 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
         );
     END COMPONENT;

     SIGNAL myClk : STD_LOGIC;
     SIGNAL myReset : STD_LOGIC;
     SIGNAL myclockEnableDisplay : STD_LOGIC;

     SIGNAL myAN : STD_LOGIC_VECTOR (3 DOWNTO 0);
     SIGNAL myMod4: STD_LOGIC_VECTOR (1 DOWNTO 0);
 

 BEGIN

     Instmodulo : ModuloFour

     PORT MAP(
             clock => myClk,
             reset => myReset,
             clockEnableDisplay => myclockEnableDisplay,
          AN => myAN,
          mod4 => myMod4
     );

     myclock : PROCESS

     BEGIN
        
         myClk <= '0';
         WAIT FOR 5 ns;
         myClk <= '1';
         WAIT FOR 5 ns;

     END PROCESS;
     myclockEnableprocess : PROCESS

     BEGIN
         -- 200 Hz : 5 ms
         WAIT FOR 5 ns;
         myclockEnableDisplay<= '1';
         WAIT FOR 2.5 ms;
         WAIT FOR 5 ns;
         myclockEnableDisplay<= '0';
         WAIT FOR 2.5 ms;

     END PROCESS;

     myrst : PROCESS

     BEGIN

         myreset <= '1';
         WAIT FOR 2 ns;
         myreset <= '0';
         WAIT;

     END PROCESS;

end behavioral;