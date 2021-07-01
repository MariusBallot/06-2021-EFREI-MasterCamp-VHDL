-- Code your design here
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Mux4to1 IS
    PORT (
        disp0 : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
        disp1 : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
        disp2 : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
        disp3 : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
        mod4 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        sevenSeg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END Mux4to1;

ARCHITECTURE Behavioral OF Mux4to1 IS

    SIGNAL mydisp0 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
    SIGNAL mydisp1 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
    SIGNAL mydisp2 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
    SIGNAL mydisp3 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
    SIGNAL mysevenSeg : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
    SIGNAL mymod4 : STD_LOGIC_VECTOR (1 DOWNTO 0) := "00";

BEGIN
    mysevenSeg <= mydisp0 WHEN mod4 = "00" ELSE
        mydisp1 WHEN mod4 = "01" ELSE
        mydisp2 WHEN mod4 = "10" ELSE
        mydisp3;
    mydisp0 <= disp0;
    mydisp1 <= disp1;
    mydisp2 <= disp2;
    mydisp3 <= disp3; -- signal prend l'entr�e
    mymod4 <= mod4;
    sevenSeg <= mysevenSeg; -- sortie prend le signal 

END Behavioral;