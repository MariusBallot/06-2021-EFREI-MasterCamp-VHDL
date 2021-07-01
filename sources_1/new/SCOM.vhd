LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;
LIBRARY work;
USE work.ALL;

ENTITY UART_SCOM IS
  PORT (
    CLOCK : IN STD_LOGIC;
    RX_pin : IN STD_LOGIC;
    SW_pins : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    TX_pin : OUT STD_LOGIC;
    id_pins : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    code_pins : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END ENTITY UART_SCOM;

ARCHITECTURE struct OF UART_SCOM IS

  COMPONENT freq_div IS
    PORT (
      clkin : IN STD_LOGIC;
      clkout : OUT STD_LOGIC
    );
  END COMPONENT freq_div;

  COMPONENT UART_TX IS
    GENERIC (
      g_CLKS_PER_BIT : INTEGER := 651
    );
    PORT (
      i_Clk : IN STD_LOGIC;
      i_TX_DV : IN STD_LOGIC;
      i_TX_Byte : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      o_TX_Active : OUT STD_LOGIC;
      o_TX_Serial : OUT STD_LOGIC;
      o_TX_Done : OUT STD_LOGIC
    );
  END COMPONENT UART_TX;

  COMPONENT UART_RX IS
    GENERIC (
      g_CLKS_PER_BIT : INTEGER := 651
    );
    PORT (
      i_Clk : IN STD_LOGIC;
      i_RX_Serial : IN STD_LOGIC;
      o_RX_DV : OUT STD_LOGIC;
      o_RX_Byte : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT UART_RX;

  COMPONENT byte_gen IS
    PORT (
      en : OUT STD_LOGIC;
      id_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      code_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      byte_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT byte_gen;

  COMPONENT id_code_gen IS
    PORT (
      done : IN STD_LOGIC;
      byte_i : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      id_o : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      code_o : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT id_code_gen;

  SIGNAL Tx_B, Rx_B : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL en_Tx, DV_Rx, clk_int : STD_LOGIC;
  SIGNAL transiTX : STD_LOGIC;

BEGIN

  U0 : freq_div PORT MAP(clkin => CLOCK, clkout => clk_int);

  U1 : byte_gen PORT MAP(
    en => en_Tx,
    id_i => SW_pins(7 DOWNTO 4),
    code_i => SW_pins(3 DOWNTO 0),
    byte_o => Tx_B
  );

  U2 : UART_TX GENERIC MAP(g_CLKS_PER_BIT => 651)
  PORT MAP(
    i_Clk => clk_int,
    i_TX_DV => en_Tx,
    i_TX_Byte => Tx_B,
    o_TX_Serial => TX_pin,
    o_TX_Active => OPEN,
    o_TX_Done => OPEN
  );
  U3 : UART_RX GENERIC MAP(g_CLKS_PER_BIT => 651)
  PORT MAP(
    i_Clk => clk_int,
    i_RX_Serial => RX_pin,
    o_RX_DV => DV_Rx,
    o_RX_Byte => Rx_B
  );

  U4 : id_code_gen PORT MAP(
    done => DV_Rx,
    byte_i => Rx_B,
    id_o => id_pins,
    code_o => code_pins
  );
END ARCHITECTURE struct;