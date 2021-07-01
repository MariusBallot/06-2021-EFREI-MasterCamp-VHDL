LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Memory IS
    PORT (
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        enable : OUT STD_LOGIC;
        rom_mem : OUT STD_LOGIC_VECTOR(51 DOWNTO 0)
    );
END Memory;

ARCHITECTURE Behavioral OF Memory IS

    TYPE tab IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(51 DOWNTO 0);
    SIGNAL my_mem : tab;
    SIGNAL my_enable : STD_LOGIC;
    SIGNAL my_count : INTEGER := 0;
    SIGNAL my_rom_mem : STD_LOGIC_VECTOR (51 DOWNTO 0):= (OTHERS => '0');

    --31 01 01 2 _ 4821
    --0011 0001 0000 0001 0010 0000 0000 0001 0010 0100 1000 0010 0001 

    --30 11 99 1 _ 5932
    --0011 0000 0001 0001 0001 1001 1001 1001 0001 0101 1001 0011 0010

    --28 01 00 4_ 2976
    --0010 1000 0000 0001 0010 0000 0000 0000 0100 0010 1001 0111 0110 

    --06 02 00 6 _ 3185
    --0000 0110 0000 0010 0010 0000 0000 0000 0110 0011 0001 1000 0101
    
    --05 09 1970 5 2830
    --0000 0101 0000 1001 0001 1001 0111 0000 0101 0010 1000 0010 0000
    
    --14 07 2013 6 1092
    --0001 0100 0000 0111 0010 0000 0001 0011 0110 0001 0000 1001 0010
BEGIN

           

    myprocessRead : PROCESS (clock, reset, my_count)

    BEGIN
           my_mem(0) <= "0011000100000001001000000000000100100100100000100001";
           my_mem(1) <= "0011000000010001000110011001100100010101100100110010";
           my_mem(2) <= "0010100000000001001000000000000001000010100101110110";
           my_mem(3) <= "0000011000000010001000000000000001100011000110000101";
           my_mem(4) <= "0000010100001001000110010111000001010010100000100000";
           my_mem(5) <="0001010000000111001000000001001101100001000010010010";
       IF (reset = '1') THEN
            enable <= '0';


      ELSIF (rising_edge(clock)) THEN

           IF (my_count < 6) THEN
                my_rom_mem <= my_mem(my_count);
                enable <= '1'; 
                my_count <= my_count + 1;
                
            ELSE
                enable <= '0';

                my_rom_mem <= (OTHERS => '0');
            END IF;

        END IF;
    END PROCESS;

    rom_mem <= my_rom_mem;

END Behavioral;