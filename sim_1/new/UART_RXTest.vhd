LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY UART_RXTest IS
END UART_RXTest;

ARCHITECTURE Behavioral OF UART_RXTest IS
    COMPONENT UART_RX IS
        PORT (
            i_Clk : IN STD_LOGIC;
            i_RX_Serial : IN STD_LOGIC;
            o_RX_DV : OUT STD_LOGIC;
            o_RX_Byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL test_i_Clk : STD_LOGIC;
    SIGNAL test_i_RX_Serial : STD_LOGIC;
    SIGNAL test_o_RX_DV : STD_LOGIC;
    SIGNAL test_o_RX_Byte : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

    UART_RXTest : UART_RX

    PORT MAP(
        i_Clk => test_i_Clk,
        i_RX_Serial => test_i_RX_Serial,
        o_RX_DV => test_o_RX_DV,
        o_RX_Byte => test_o_RX_Byte
    );

    myclock : PROCESS

    BEGIN
        -- 100 Hz => T= 2 ms
        test_i_Clk <= '0';
        WAIT FOR 5 ns;
        test_i_Clk <= '1';
        WAIT FOR 5 ns;

    END PROCESS;

END Behavioral;