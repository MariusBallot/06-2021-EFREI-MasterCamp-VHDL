-- Code your design here
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Check IS
  PORT (
    checkE : IN STD_LOGIC;
    day : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    month : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    year : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    totalDayNumber : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
    ok : OUT STD_LOGIC
  );
END Check;

ARCHITECTURE Behavioral OF Check IS
  SIGNAL mycheckE : STD_LOGIC := '0';
  SIGNAL mytotalDayNumber : STD_LOGIC_VECTOR (2 DOWNTO 0) := "000";
  SIGNAL myok : STD_LOGIC := '0';

  SIGNAL myday_0 : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
  SIGNAL myday_1 : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";

  SIGNAL mymonth_0 : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
  SIGNAL mymonth_1 : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";

  SIGNAL myyear_0 : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
  SIGNAL myyear_1 : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
  SIGNAL myyear_2 : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
  SIGNAL myyear_3 : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
BEGIN

  mycheckE <= checkE;
  myday_0 <= day(3 DOWNTO 0);
  myday_1 <= day(7 DOWNTO 4);
  mymonth_0 <= month(3 DOWNTO 0);
  mymonth_1 <= month(7 DOWNTO 4);
  myyear_0 <= year(3 DOWNTO 0);
  myyear_1 <= year(7 DOWNTO 4);
  myyear_2 <= year(11 DOWNTO 8);
  myyear_3 <= year(15 DOWNTO 12);

  myprocess : PROCESS (mycheckE, mytotalDayNumber, myOK, myday_0, myday_1, mymonth_0, mymonth_1, myyear_0, myyear_1, myyear_2, myyear_3)

    VARIABLE myday_i : INTEGER := 0;
    VARIABLE mymonth_i : INTEGER := 0;
    VARIABLE myyear_i : INTEGER := 0;

    VARIABLE myday_0_i : INTEGER := 0;
    VARIABLE myday_1_i : INTEGER := 0;

    VARIABLE mymonth_0_i : INTEGER := 0;
    VARIABLE mymonth_1_i : INTEGER := 0;

    VARIABLE myyear_0_i : INTEGER := 0;
    VARIABLE myyear_1_i : INTEGER := 0;
    VARIABLE myyear_2_i : INTEGER := 0;
    VARIABLE myyear_3_i : INTEGER := 0;

    VARIABLE count : INTEGER := 0;
  BEGIN

    IF (mycheckE = '1') THEN
      ---------On a appuie sur le bouton--------
      count := 0;
      myday_0_i := to_integer(unsigned(myday_0));
      myday_1_i := to_integer(unsigned(myday_1));
      mymonth_0_i := to_integer(unsigned(mymonth_0));
      mymonth_1_i := to_integer(unsigned(mymonth_1));
      myyear_0_i := to_integer(unsigned(myyear_0));
      myyear_1_i := to_integer(unsigned(myyear_1));
      myyear_2_i := to_integer(unsigned(myyear_2));
      myyear_3_i := to_integer(unsigned(myyear_3));

      ---------------DAY------------------

      -- On verifie les unite avec max 9
      IF (myday_0_i < 10) THEN
        -- Calcul du jour en ajoutant le nombre de dizaines
        CASE(myday_1_i) IS
          WHEN 0 =>
          myday_i := myday_0_i;
          WHEN 1 =>
          myday_i := myday_0_i + 10;
          WHEN 2 =>
          myday_i := myday_0_i + 20;
          WHEN 3 =>
          myday_i := myday_0_i + 30;
          WHEN OTHERS =>
          myok <= '1';
        END CASE;

        ---------------MONTH-----------------

        IF (myday_i > 0 AND myday_i < 32 AND mymonth_0_i < 10) THEN
          -- On verifie que jour sup a 0 et jour inf a 32 et unite inf a 10

          CASE(mymonth_1_i) IS
            WHEN 1 => mymonth_i := mymonth_0_i + 10;
            WHEN 0 => mymonth_i := mymonth_0_i + 0;
            WHEN OTHERS => myok <= '1';
          END CASE;

          ---------------YEAR-----------------            

          IF ((mymonth_i > 0) AND (mymonth_i < 13) AND (myyear_0_i < 10)) THEN
            --milliers--
            CASE(myyear_3_i) IS
              WHEN 1 => myyear_i := 1000;
              WHEN 2 => myyear_i := 2000;
              WHEN OTHERS => myok <= '1';
            END CASE;

            --centaines
            CASE(myyear_2_i) IS
              WHEN 0 => myyear_i := 0 + myyear_i;
              WHEN 9 => myyear_i := 900 + myyear_i;
              WHEN OTHERS => myOK <= '1';
            END CASE;

            --dizaines
            CASE(myyear_1_i) IS
              WHEN 0 =>
              myyear_i := 0 + myyear_i + myyear_0_i;--0
              WHEN 1 =>
              myyear_i := 10 + myyear_i + myyear_0_i;--10
              WHEN 2 =>
              myyear_i := 20 + myyear_i + myyear_0_i;--20
              WHEN 5 =>
              myyear_i := 50 + myyear_i + myyear_0_i;--50
              WHEN 6 =>
              myyear_i := 60 + myyear_i + myyear_0_i;--60
              WHEN 7 =>
              myyear_i := 70 + myyear_i + myyear_0_i;--70
              WHEN 8 =>
              myyear_i := 80 + myyear_i + myyear_0_i;--80
              WHEN 9 =>
              myyear_i := 90 + myyear_i + myyear_0_i;--90
              WHEN OTHERS =>
              myOK <= '1';
            END CASE;
            -- On a maintenant le jour, le mois et l'annee

            IF ((myyear_i > 1949) AND (myyear_i < 2022)) THEN
              count := (((myyear_i - 1) - 1951) * 365);

              --Ajout des annees bissextiles
              IF ((myyear_i > 1949) AND (myyear_i <= 1951)) THEN
                count := count + 0;
              ELSIF ((myyear_i > 1952) AND (myyear_i <= 1956)) THEN
                count := count + 1;
              ELSIF ((myyear_i > 1956) AND (myyear_i <= 1960)) THEN
                count := count + 2;
              ELSIF ((myyear_i > 1960) AND (myyear_i <= 1964)) THEN
                count := count + 3;
              ELSIF ((myyear_i > 1964) AND (myyear_i <= 1968)) THEN
                count := count + 4;
              ELSIF ((myyear_i > 1968) AND (myyear_i <= 1972)) THEN
                count := count + 5;
              ELSIF ((myyear_i > 1972) AND (myyear_i <= 1976)) THEN
                count := count + 6;
              ELSIF ((myyear_i > 1976) AND (myyear_i <= 1980)) THEN
                count := count + 7;
              ELSIF ((myyear_i > 1980) AND (myyear_i <= 1984)) THEN
                count := count + 8;
              ELSIF ((myyear_i > 1984) AND (myyear_i <= 1988)) THEN
                count := count + 9;
              ELSIF ((myyear_i > 1988) AND (myyear_i <= 1992)) THEN
                count := count + 10;
              ELSIF ((myyear_i > 1992) AND (myyear_i <= 1996)) THEN
                count := count + 11;
              ELSIF ((myyear_i > 1996) AND (myyear_i <= 2000)) THEN
                count := count + 12;
              ELSIF ((myyear_i > 2000) AND (myyear_i <= 2004)) THEN
                count := count + 13;
              ELSIF ((myyear_i > 2004) AND (myyear_i <= 2008)) THEN
                count := count + 14;
              ELSIF ((myyear_i > 2008) AND (myyear_i <= 2012)) THEN
                count := count + 15;
              ELSIF ((myyear_i > 2012) AND (myyear_i <= 2016)) THEN
                count := count + 16;
              ELSIF ((myyear_i > 2016) AND (myyear_i <= 2020)) THEN
                count := count + 17;
              ELSIF ((myyear_i > 2020) AND (myyear_i <= 2021)) THEN
                count := count + 18;
              ELSE
                myok <= '1';
              END IF;

              IF ((mymonth_i > 2) AND ((myyear_i MOD 4) = 0)) THEN
                count := count + 2;
              ELSE
                count := count + 1;
              END IF;

              --FEVRIER--
              IF (mymonth_i = 2) THEN
                --bissextile
                IF ((myyear_i MOD 4) = 0) THEN
                  IF (myday_i < 30) THEN
                    count := ((count + 31 + myday_i - 1) MOD 7);
                    mytotalDayNumber <= STD_LOGIC_VECTOR(to_unsigned(count, 3));
                  ELSE
                    myok <= '1';
                  END IF;
                ELSE
                  IF (myday_i < 29) THEN

                    count := ((count + 31 + myday_i - 1) MOD 7);
                    mytotalDayNumber <= STD_LOGIC_VECTOR(to_unsigned(count, 3));
                  ELSE
                    myok <= '1';
                  END IF;
                END IF;

                --JANVIER--
              ELSIF ((mymonth_i = 1)
                --MARS--
                OR (mymonth_i = 3)
                --MAI--
                OR (mymonth_i = 5)
                --JUILLET--
                OR (mymonth_i = 7)
                --AOUT--
                OR (mymonth_i = 8)
                --OCTOBRE--
                OR (mymonth_i = 10)
                --DECEMBRE--
                OR (mymonth_i = 12)) THEN
                IF (myday_i < 32) THEN
                  CASE (mymonth_i) IS
                    WHEN 1 =>
                      count := count + myday_i;
                    WHEN 3 =>
                      count := count + 31 + 28 + myday_i;
                    WHEN 5 =>
                      count := count + 31 + 28 + 31 + 30 + myday_i;
                    WHEN 7 =>
                      count := count + 31 + 28 + 31 + 30 + 31 + 30 + myday_i;
                    WHEN 8 =>
                      count := count + 31 + 28 + 31 + 30 + 31 + 30 + 31 + myday_i;
                    WHEN 10 =>
                      count := count + 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + myday_i;
                    WHEN 12 =>
                      count := count + 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31 + 30 + myday_i;
                    WHEN OTHERS =>
                      count := count + 0;
                  END CASE;
                  count := ((count - 1) MOD 7);
                  mytotalDayNumber <= STD_LOGIC_VECTOR(to_unsigned(count, 3));

                ELSE
                  myok <= '1';

                END IF;
                --AVRIL--
              ELSIF ((mymonth_i = 4)
                --JUIN--
                OR (mymonth_i = 6)
                --SEPTEMBRE--
                OR (mymonth_i = 9)
                --NOVEMBRE--
                OR (mymonth_i = 11)) THEN
                IF (myday_i < 31) THEN
                  CASE (mymonth_i) IS
                    WHEN 4 =>
                      count := count + (31) + 28 + 31 + myday_i;
                    WHEN 6 =>
                      count := count + (31) + 28 + 31 + 30 + 31 + myday_i;
                    WHEN 9 =>
                      count := count + (31) + 28 + 31 + 30 + 31 + 30 + 31 + 31 + myday_i;
                    WHEN 11 =>
                      count := count + (31) + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31 + myday_i;
                    WHEN OTHERS =>
                      count := count + 0;
                  END CASE;
                  count := ((count - 1) MOD 7);
                  mytotalDayNumber <= STD_LOGIC_VECTOR(to_unsigned(count, 3));
                ELSE
                  myok <= '1';
                END IF;
              END IF;
            ELSE
              myok <= '1';
            END IF;
          ELSE
            myok <= '1';
          END IF;
        ELSE
          myok <= '1';
        END IF;
      ELSE
        myok <= '1';
      END IF;
    END IF; --Fin du checkE
  END PROCESS;

  ok <= myok;
  totalDayNumber <= mytotalDayNumber;
END Behavioral;