LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY topLevel_test IS

END topLevel_test;

ARCHITECTURE behavioral OF topLevel_test IS

	--d�claration d'un component

	COMPONENT topLevel

		PORT (
			clock : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			-- push-buttons 
			buttonMore : IN STD_LOGIC;
			buttonChoice : IN STD_LOGIC;
			buttonCheck : IN STD_LOGIC;
			-- ou button 

			led : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
			sevenSeg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)

		);

	END COMPONENT;

	SIGNAL clock100Mhz : STD_LOGIC := '0'; --valeur initiale par d�faut
	SIGNAL myrst : STD_LOGIC := '0';
	SIGNAL mybuttonMore : STD_LOGIC := '0';
	SIGNAL mybuttonChoice : STD_LOGIC := '0';
	SIGNAL mybuttonCheck : STD_LOGIC := '0';
	SIGNAL myled : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL mysevenSeg : STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN

	InstMytopLevel : topLevel

	PORT MAP(

		clock => clock100Mhz,
		reset => myrst,

		buttonMore => mybuttonMore,
		buttonChoice => mybuttonChoice,
		buttonCheck => mybuttonCheck,
		led => myled,
		sevenSeg => mysevenSeg

	);

	-- description des stimulis des signaux d'entr�e

	myclkproc : PROCESS
	BEGIN
		clock100Mhz <= '0';
		WAIT FOR 5 ns;
		clock100Mhz <= '1';
		WAIT FOR 5 ns;
	END PROCESS;

	myrstpro : PROCESS
	BEGIN
		myrst <= '1';
		WAIT FOR 15 ns;
		myrst <= '0';
		WAIT;
	END PROCESS;

	mybuttonChoicepro : PROCESS
	BEGIN
		mybuttonChoice <= '0'; --modDay de base 
		WAIT FOR 25 ms;
		mybuttonChoice <= '1'; -- modMonth 
		WAIT FOR 5 ms;
		mybuttonChoice <= '0';
		WAIT FOR 20 ms;
		mybuttonChoice <= '1'; --modYear
		WAIT FOR 5 ms;
		mybuttonChoice <= '0';
		WAIT FOR 5 ms;
		mybuttonChoice <= '1';
		WAIT FOR 300 ms;
		mybuttonChoice <= '0';
		WAIT;
	END PROCESS;

	mybuttonMorepro : PROCESS
	BEGIN
		mybuttonMore <= '1'; --incr�mente les jours
		WAIT FOR 20 ms;
		mybuttonMore <= '0';
		WAIT FOR 10 ms;
		mybuttonMore <= '1'; -- incr�mente month
		WAIT FOR 15 ms;
		mybuttonMore <= '0';
		WAIT FOR 10 ms;
		mybuttonMore <= '1'; --incr�mente years
		WAIT FOR 10 ms;
		mybuttonMore <= '0';
		WAIT FOR 10 ms;
		mybuttonMore <= '1';
		WAIT FOR 400 ms;
		mybuttonMore <= '0';
		WAIT;
	END PROCESS;

	mybuttonCheckpro : PROCESS
	BEGIN
		mybuttonCheck <= '0';
		WAIT FOR 5 ms;
		mybuttonCheck <= '1';
		WAIT FOR 500 ms;
		mybuttonCheck <= '0';
		WAIT;
	END PROCESS;

END behavioral;