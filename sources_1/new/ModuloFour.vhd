LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE IEEE.STD_LOGIC_UNSIGNED.ALL;

 ENTITY ModuloFour IS
     PORT (
         clock : IN STD_LOGIC;
         reset : IN STD_LOGIC;
         clockEnableDisplay : IN STD_LOGIC;
         AN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
         mod4 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
     );
 END ModuloFour;

 ARCHITECTURE Behavioral OF ModuloFour IS
 
     SIGNAL myAN : STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
     SIGNAL mymod4 : STD_LOGIC_VECTOR(1 DOWNTO 0):="00";


 BEGIN
     myprocess : PROCESS (clockEnableDisplay, clock, reset)
     BEGIN
         IF (reset = '1') THEN
             myAN <= "0000";
             mymod4 <= "00";

         ELSIF rising_edge(clockEnableDisplay) THEN
                 If clock = '1' then
                     mymod4 <= mymod4 + 1;
                  else mymod4<= "11";
                 end if;
         END IF;

         CASE mymod4 IS
             WHEN "00" =>
                myAN <= "0001";
             WHEN "01" =>
                 myAN <= "0010";
             WHEN "10" =>
                myAN <= "0100";
             WHEN "11" =>
                 myAN <= "1000";
             WHEN others =>
                  myAN <= "0000";
         END CASE;
     END PROCESS;
     AN <= myAN;
     mod4 <= mymod4;
 
 END Behavioral;