library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RAMTest is
end RAMTest;

architecture Behavioral of RAMTest is

component codeRAM
    Port (
    clock : in std_logic;
    reset : in std_logic;
    enable : in std_logic;
    address : in std_logic_vector (3 downto 0); 
    data : in std_logic_vector (3 downto 0);
    data_out : out std_logic_vector (51 downto 0)
 );
end component;

    signal testclk : std_logic := '0';
    signal test_rst : std_logic := '0';
    signal test_enable : std_logic := '0';
    signal test_address : std_logic_vector(3 downto 0);
    signal test_data : std_logic_vector (3 downto 0);
    signal test_dataout : std_logic_vector (51 downto 0);
    
begin

    InstRAM : codeRAM
    
port map(
    clock => testclk,
    reset => test_rst,
    enable => test_enable,
    address => test_address,
    data => test_data,
    data_out=> test_dataout
);

myclkpro : process
    begin
    testclk <= '0';
    WAIT FOR 5 ns;
    testclk <= '1';
    WAIT FOR 5 ns;
end process;

myrstpro : process
    begin 
    test_rst <= '1';
    WAIT FOR 2 ns;
    test_rst <= '0';
    WAIT;
end process;

myenablepro : process
    begin 
    test_enable <= '1';
    WAIT FOR 200 ns;
    test_enable <= '0';
    WAIT;
end process;

myaddresspro : process
    begin 
    test_address <= "0000";
    WAIT FOR 15 ns;
    test_address <= "0001";
    WAIT FOR 15 ns;
    test_address <= "0010";
    WAIT FOR 15 ns;
    test_address <= "0011";
    WAIT FOR 15 ns;
    test_address <= "0100";
    WAIT FOR 15 ns;
    test_address <= "0101";
    WAIT FOR 15 ns;
    test_address <= "0110";
    WAIT FOR 15 ns;
    test_address <= "0111";
    WAIT FOR 15 ns;
    test_address <= "1000";
    WAIT FOR 15 ns;
    test_address <= "1001";
    WAIT FOR 15 ns;
    test_address <= "1010";
    WAIT FOR 15 ns;
    test_address <= "1011";
    WAIT FOR 15 ns;
    test_address <= "1100";
    WAIT;
end process;

myDatapro : process
    begin 
    test_data <= "0011";
    WAIT FOR 15 ns;
    test_data <= "0100";
    WAIT FOR 15 ns;
    test_data <= "0101";
    WAIT FOR 15 ns;
    test_data <= "1111";
    WAIT FOR 15 ns;
    test_data <= "1101";
    WAIT FOR 15 ns;
    test_data <= "0100";
    WAIT FOR 15 ns;
    test_data <= "0000";
    WAIT FOR 15 ns;
    test_data <= "1101";
    WAIT FOR 15 ns;
    test_data <= "0110";
    WAIT FOR 15 ns;
    test_data <= "1001";
    WAIT FOR 15 ns;
    test_data <= "0101";
    WAIT FOR 15 ns;
    test_data <= "1001";
    WAIT FOR 15 ns;
    test_data <= "1111";  
    WAIT;
end process;

end Behavioral;
