library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity random_generator is
    port (
        clock: in std_logic;
        random: out std_logic_vector(15 downto 0)
    );
end random_generator;

architecture behavior of random_generator is
    constant a: integer := 48271;
    constant b: integer := 400;
    constant m: integer := 65535;
    signal r: integer range 0 to 65535 := 1;
begin
    random <= std_logic_vector(to_unsigned(r, 16));
    count: process(clock) begin
        if rising_edge(clock) then
            r <= (a * r + b) mod m;
        end if;
    end process;
end behavior;