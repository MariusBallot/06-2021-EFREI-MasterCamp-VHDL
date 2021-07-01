-- Code your testbench here
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
--use ieee.std_logic_unsigned.all;
--USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY UART_SCOMtest IS

END UART_SCOMtest;

ARCHITECTURE Behavioral OF UART_SCOMtest IS

    COMPONENT UART_SCOM IS

        PORT (
            CLOCK : IN STD_LOGIC;
            TX_pin : OUT STD_LOGIC;
            RX_pin : IN STD_LOGIC;
            SW_pins : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            id_pins : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            code_pins : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );

    END COMPONENT;
    SIGNAL test_Clk : STD_LOGIC := '0';
    SIGNAL test_RX_pin : STD_LOGIC := '0';
    SIGNAL test_SW_pins : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
    SIGNAL test_TX_pin : STD_LOGIC := '0';
    SIGNAL test_id_pins : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL test_code_pins : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";

BEGIN

    InstUART_SCOM : UART_SCOM

    PORT MAP(

        CLOCK => test_Clk,
        TX_pin => test_TX_pin,
        RX_pin => test_RX_pin,
        SW_pins => test_SW_pins,
        id_pins => test_id_pins,
        code_pins => test_code_pins
    );

    test_clk_process : PROCESS
    BEGIN
        -- 100 Hz => T= 2 ms
        test_Clk <= '0';
        WAIT FOR 5 ns;
        test_Clk <= '1';
        WAIT FOR 5 ns;
    END PROCESS;

    test_RX_process : PROCESS
    BEGIN
        -- test_RX_pin <= test_TX_pin;
        -- WAIT;
        test_RX_pin <= '0';
        WAIT FOR 104.16 us;
        test_RX_pin <= '1';
        WAIT FOR 104.16 us;
        test_RX_pin <= '0';
        WAIT FOR 104.16 us;
        test_RX_pin <= '1';
        WAIT FOR 104.16 us;
        test_RX_pin <= '0';
        WAIT FOR 104.16 us;
        test_RX_pin <= '1';
        WAIT FOR 104.16 us;
        test_RX_pin <= '0';
        WAIT FOR 104.16 us;
        test_RX_pin <= '1';
        WAIT FOR 104.16 us;
        test_RX_pin <= '0';
        WAIT FOR 104.16 us;
        test_RX_pin <= '1';
        WAIT FOR 104.16 us;

    END PROCESS;

    SW_pins_process : PROCESS
    BEGIN
        test_SW_pins <= "11101101";
        WAIT;
    END PROCESS;
END Behavioral;