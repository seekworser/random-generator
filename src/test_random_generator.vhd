library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_random_generator is
end test_random_generator;

architecture behavior of test_random_generator is
    component random_generator is
        port (
            clock: in std_logic;
            random: out std_logic_vector(15 downto 0)
        );
    end component;
    signal clock: std_logic;
    signal random: std_logic_vector(15 downto 0);
begin
    u1: random_generator
        port map(
            clock => clock,
            random => random
        );
    process
    begin
        for i in 0 to 1000 loop
            clock <= '1';
            wait for 16.25 ns;
            clock <= '0';
            wait for 16.25 ns;
        end loop;
        wait;
    end process;
end behavior;
