LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

ENTITY Check_Code IS
    PORT (
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        code : IN STD_LOGIC_VECTOR (51 DOWNTO 0);
        ok : OUT STD_LOGIC
    );
END Check_Code;

ARCHITECTURE Behavioral OF Check_Code IS

    COMPONENT Memory
        PORT (
            clock : IN STD_LOGIC;
            reset : IN STD_LOGIC;

            enable : OUT STD_LOGIC;
            rom_mem : OUT STD_LOGIC_VECTOR(51 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Check_Code_MCU
        PORT (
            reset : IN STD_LOGIC;
            checkEnable : IN STD_LOGIC;
            code : IN STD_LOGIC_VECTOR(51 DOWNTO 0);
            memoryCode : IN STD_LOGIC_VECTOR(51 DOWNTO 0);

            ok : OUT STD_LOGIC;
            res_enable : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL myrst : STD_LOGIC;
    SIGNAL my_clk : STD_LOGIC;

    SIGNAL myRom_mem : STD_LOGIC_VECTOR (51 DOWNTO 0) := (OTHERS => '0');
    SIGNAL myEnable : STD_LOGIC;
    SIGNAL mycode : STD_LOGIC_VECTOR (51 DOWNTO 0) := (OTHERS => '0');
    SIGNAL myOK : STD_LOGIC;
    SIGNAL myres_enable : STD_LOGIC;

BEGIN

    inst_Memory : Memory

    PORT MAP(
        clock => my_clk,
        reset => myrst,
        enable => myEnable,
        rom_mem => myRom_mem
    );

    Inst_checkCodeMcu : Check_Code_MCU
    PORT MAP(
        reset => myrst,
        checkEnable => myEnable,
        code => mycode,
        memoryCode => myRom_mem,
        ok => myok,
        res_enable => myres_enable
    );

    PROCESS (reset)
    BEGIN
        REPORT "la samarche";
        IF myrst = '1' THEN
            REPORT "la samarche poooooooooo";

        END IF;
    END PROCESS;
    ok <= myOK;
    mycode <= code;
    myrst <= reset;
    my_clk <= clock;
END Behavioral;