LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


 ENTITY MemoryTest IS
 END MemoryTest;

  ARCHITECTURE Behavioral OF MemoryTest IS

      COMPONENT Memory IS

          PORT (
          clock : IN STD_LOGIC;
         reset : IN STD_LOGIC;
         --read : IN STD_LOGIC;
         
         enable : OUT STD_LOGIC;
         rom_mem : OUT std_logic_vector(51 downto 0)
         );
          
      END COMPONENT;

      SIGNAL myClk : STD_LOGIC;
      SIGNAL myReset : STD_LOGIC;
      SIGNAL myEnable : STD_LOGIC;
      SIGNAL my_rom_mem : STD_LOGIC_VECTOR (51 DOWNTO 0);

  

  BEGIN

      InstMemory : Memory

      PORT MAP(
              clock => myClk,
              reset => myReset,
              enable => myEnable,
              rom_mem => my_rom_mem     
      );

      myclock : PROCESS

      BEGIN
          
          myClk <= '0';
          WAIT FOR 5 ns;
          myClk <= '1';
          WAIT FOR 5 ns;

      END PROCESS;
      
      myResetprocess : PROCESS

      BEGIN
        
          myReset<= '1';
          WAIT FOR 5 ns;
          myReset<= '0';

          WAIT;

      END PROCESS;
      
 end behavioral;
