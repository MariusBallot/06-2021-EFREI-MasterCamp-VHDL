library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity codeRAM is
    Port (
        clock : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        address : in std_logic_vector (3 downto 0); -- envoyé par MCU, rentré dans RCREG (3 to 0)
        data : in std_logic_vector (3 downto 0); -- envoyé par MCU 4 bit par 4 bit 
        data_out : out std_logic_vector (51 downto 0) -- en sortie le code en entier
     );
end codeRAM;

architecture Behavioral of codeRAM is
    type tab is array (0 to 12) of std_logic_vector (3 downto 0); --13 caractères
    signal my_ram_code : tab;
    signal my_data_out : std_logic_vector (51 downto 0);
    
begin

    process (clock, reset) is 
    begin 
    
    if reset = '1' then 
        my_ram_code <= (others => "0000");
    elsif rising_edge(clock) then 
        if enable = '1' then 
            my_ram_code(conv_integer(address)) <= data;
        end if;
     end if;
        
    end process;
 
    process (my_ram_code) is
    
    variable count : natural range 0 to 13;
    begin 
    
   --if reset = '1' then 
    --    my_ram_code <= (others => "0000");
        
    --elsif rising_edge(clock) then 
    count :=0;
    
        for i in 0 to 12 loop 
            my_data_out(51-4*count downto 48-4*count) <= my_ram_code(count); -- pr décaler de 4 durant l'ensemble de la chaine
            count := count +1;
        end loop;
    --end if;
    end process;
    
data_out <= my_data_out;

end Behavioral;
