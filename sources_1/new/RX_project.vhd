LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

--Band width : 9600

ENTITY UART_RX IS
    GENERIC (
        g_CLKS_PER_BIT : INTEGER := 651
    );
    PORT (
        i_Clk : IN STD_LOGIC;
        i_RX_Serial : IN STD_LOGIC;
        o_RX_DV : OUT STD_LOGIC;
        o_RX_Byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END UART_RX;
ARCHITECTURE RTL OF UART_RX IS

    TYPE t_SM_Main IS (s_Idle, s_RX_Start_Bit, s_RX_Data_Bits,
        s_RX_Stop_Bit, s_Cleanup_DV, s_Cleanup);
    SIGNAL r_SM_Main : t_SM_Main := s_Idle;

    SIGNAL r_RX_Data_R : STD_LOGIC := '0';
    SIGNAL r_RX_Data : STD_LOGIC := '0';

    SIGNAL r_Clk_Count : INTEGER RANGE 0 TO g_CLKS_PER_BIT - 1 := 0;
    SIGNAL r_Bit_Index : INTEGER RANGE 0 TO 7 := 0; -- 8 Bits in total
    SIGNAL r_RX_Byte : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL r_RX_DV : STD_LOGIC := '0';

BEGIN

    -- Purpose: Double-register the incoming data.
    -- This allows it to be used in the UART RX Clock Domain.
    -- (It removes problems caused by metastabiliy)
    p_SAMPLE : PROCESS (i_Clk)
    BEGIN
        REPORT("p_SAMPLE DANS RX");
        IF rising_edge(i_Clk) THEN
            r_RX_Data_R <= i_RX_Serial;
            r_RX_Data <= r_RX_Data_R;
        END IF;
        REPORT("FIN p_SAMPLE DANS RX");
    END PROCESS p_SAMPLE;

    -- Purpose: Control RX state machine
    p_UART_RX : PROCESS (i_Clk)
    BEGIN
        REPORT("p_UART_RX DANS RX");
        IF rising_edge(i_Clk) THEN

            CASE r_SM_Main IS

                WHEN s_Idle =>
                    r_RX_DV <= '0';
                    r_Clk_Count <= 0;
                    r_Bit_Index <= 0;

                    IF r_RX_Data = '0' THEN
                        r_SM_Main <= s_RX_Start_Bit;
                    ELSE
                        r_SM_Main <= s_Idle;
                    END IF;

                    -- Check middle of start bit to make sure it is still low
                WHEN s_RX_Start_Bit =>
                    IF r_Clk_Count = (g_CLKS_PER_BIT - 1)/2 THEN

                        IF r_RX_Data = '0' THEN
                            r_Clk_Count <= 0;
                            r_SM_Main <= s_RX_Data_Bits;

                        ELSE
                            r_SM_Main <= s_Idle;
                        END IF;

                    ELSE
                        r_Clk_Count <= r_Clk_Count + 1;
                        r_SM_Main <= s_RX_Start_Bit;
                    END IF;

                WHEN s_RX_Data_Bits =>
                    IF r_Clk_Count < g_CLKS_PER_BIT - 1 THEN
                        r_Clk_Count <= r_Clk_Count + 1;
                        r_SM_Main <= s_RX_Data_Bits;
                    ELSE
                        r_Clk_Count <= 0;
                        r_RX_Byte(r_Bit_Index) <= r_RX_Data;
                        IF r_Bit_Index < 7 THEN
                            r_Bit_Index <= r_Bit_Index + 1;
                            r_SM_Main <= s_RX_Data_Bits;
                        ELSE
                            r_Bit_Index <= 0;
                            r_SM_Main <= s_RX_Stop_Bit;
                        END IF;
                    END IF;
                    -- Receive Stop bit.  Stop bit = 1
                WHEN s_RX_Stop_Bit =>
                    -- Check middle of stop bit to make sure it is still high
                    IF r_Clk_Count < (g_CLKS_PER_BIT - 1) THEN
                        r_Clk_Count <= r_Clk_Count + 1;
                        r_SM_Main <= s_RX_Stop_Bit;

                    ELSE
                        IF r_RX_Data = '1' THEN
                            r_SM_Main <= s_Cleanup_DV;

                        ELSE
                            r_SM_Main <= s_Cleanup;

                        END IF;

                        r_Clk_Count <= 0;

                    END IF;
                WHEN s_Cleanup_DV =>
                    r_RX_DV <= '1';
                    r_SM_Main <= s_Cleanup;

                WHEN s_Cleanup =>
                    r_RX_DV <= '0';
                    IF r_Clk_Count < (g_CLKS_PER_BIT - 1)/2 THEN
                        r_Clk_Count <= r_Clk_Count + 1;
                        r_SM_Main <= s_Cleanup;
                    ELSE
                        r_Clk_Count <= 0;
                        r_SM_Main <= s_Idle;
                    END IF;

                WHEN OTHERS =>
                    r_SM_Main <= s_Idle;

            END CASE;
        END IF;
        REPORT("FIN p_UART_RX DANS RX");
    END PROCESS p_UART_RX;

    o_RX_DV <= r_RX_DV;
    o_RX_Byte <= r_RX_Byte;

END ARCHITECTURE RTL;