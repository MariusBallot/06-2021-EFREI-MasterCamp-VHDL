--Code your testbench here
-- or browse Examples
library IEEE;


use IEEE.std_logic_1164.all;

entity Mux4to1test is

end Mux4to1test;

architecture Mux4to1_archTest of Mux4to1test is

component Mux4to1
Port ( 
    disp0 :    in std_logic_vector (6 downto 0);
    disp1 :    in std_logic_vector (6 downto 0);
    disp2 :    in std_logic_vector (6 downto 0);
    disp3 :    in std_logic_vector (6 downto 0);
    mod4:      in std_logic_vector (1 downto 0);
    sevenSeg : out std_logic_vector(6 downto 0)
);
end component;

signal 	testdisp0		: std_logic_vector(6 downto 0) := "1100010";
signal 	testdisp1		: std_logic_vector(6 downto 0) := "1010000";
signal 	testdisp2		: std_logic_vector(6 downto 0) := "0000111";
signal 	testdisp3		: std_logic_vector(6 downto 0) := "1100000";
signal 	testsevenSeg	: std_logic_vector(6 downto 0) := "0000000";
signal  testmod4		: std_logic_vector(1 downto 0) := "00";

begin 

InstMux4to1 : Mux4to1

port map(
	disp0 =>    testdisp0,
    disp1 =>    testdisp1,
    disp2 =>    testdisp2,
    disp3 =>    testdisp3,
    sevenSeg => testsevenSeg,
    mod4 =>     testmod4
);

    
mymod4proc : process
	begin
	testmod4 <= "00";
	WAIT FOR 10 ms;
	testmod4 <= "01";
    WAIT FOR 10 ms;
    testmod4 <= "10";
    WAIT FOR 10 ms;
    testmod4 <= "11";
    WAIT FOR 10 ms;
    testmod4 <= "01";
    WAIT FOR 10 ms;
    testmod4 <= "01";
	WAIT; 
    
END process;
end Mux4to1_archTest;
