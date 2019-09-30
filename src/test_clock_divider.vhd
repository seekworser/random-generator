library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_clock_divider is
end test_clock_divider;

architecture behavior of test_clock_divider is
    component clock_divider is
        generic (
            clock_frequency: integer;
            slow_clock_frequency: integer
        );
        port (
            clock: in std_logic;
            slow_clock: out std_logic
        );
    end component;
    signal clock: std_logic;
    signal slow_clock: std_logic;
begin
    u1: clock_divider
        generic map(
            clock_frequency => 32000000,
            slow_clock_frequency => 10000000
        )
        port map(
            clock => clock,
            slow_clock => slow_clock
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
