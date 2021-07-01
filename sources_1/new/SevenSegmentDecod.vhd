LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
ENTITY SevenSegmentDecod IS
      PORT (
            disp0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            disp1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            disp2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            disp3 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            dout0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            dout1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            dout2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            dout3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));

END SevenSegmentDecod;

ARCHITECTURE Behavioral OF SevenSegmentDecod IS
      SIGNAL sdout0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
      SIGNAL sdout1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
      SIGNAL sdout2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
      SIGNAL sdout3 : STD_LOGIC_VECTOR(6 DOWNTO 0);

      TYPE matrix IS ARRAY (0 TO 3) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
      SIGNAL s_matrix : matrix;

      TYPE matrix_out IS ARRAY (0 TO 3) OF STD_LOGIC_VECTOR(6 DOWNTO 0);
      SIGNAL s_matrix_out : matrix_out;
BEGIN

      s_matrix(0) <= disp0;
      s_matrix(1) <= disp1;
      s_matrix(2) <= disp2;
      s_matrix(3) <= disp3;

      sdout0 <= s_matrix_out(0);
      sdout1 <= s_matrix_out(1);
      sdout2 <= s_matrix_out(2);
      sdout3 <= s_matrix_out(3);

      MyAffichage : PROCESS (s_matrix, s_matrix_out)

      BEGIN

            FOR i IN 0 TO 3 LOOP

                  CASE (s_matrix(i)) IS

                        WHEN "0000" =>
                              s_matrix_out(i) <= "1111110";
                        WHEN "0001" =>
                              s_matrix_out(i) <= "0110000";
                        WHEN "0010" =>
                              s_matrix_out(i) <= "1101101";
                        WHEN "0011" =>
                              s_matrix_out(i) <= "1111001";
                        WHEN "0100" =>
                              s_matrix_out(i) <= "0110011";
                        WHEN "0101" =>
                              s_matrix_out(i) <= "1011011";
                        WHEN "0110" =>
                              s_matrix_out(i) <= "1011111";
                        WHEN "0111" =>
                              s_matrix_out(i) <= "1110000";
                        WHEN "1000" =>
                              s_matrix_out(i) <= "1111111";
                        WHEN OTHERS => s_matrix_out(i) <= "1111011";
                  END CASE;

            END LOOP;
      END PROCESS;
      dout0 <= sdout0;
      dout1 <= sdout1;
      dout2 <= sdout2;
      dout3 <= sdout3;
END Behavioral;