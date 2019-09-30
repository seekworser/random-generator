library ieee;
use ieee.std_logic_1164.all;
-- use ieee.std_logic_arith.all;
-- use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity clock_divider is
    generic (
        clock_frequency: integer := 32000000;
        slow_clock_frequency: integer := 32000000
    );
    port (
        clock: in std_logic;
        slow_clock: out std_logic
    );
end clock_divider;

architecture behavior of clock_divider is
    constant div_rate: integer := clock_frequency / slow_clock_frequency - 1;
    signal counter: integer := 0;
    signal temporal: std_logic := '0';
begin
    slow_clock <= temporal;
    count: process(clock) begin
        if rising_edge(clock) or falling_edge(clock) then
            if counter >= div_rate then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    assign_clock: process(clock) begin
        if (counter = 0) and (temporal = '0') then
            temporal <= '1';
        elsif (counter = 0) and (temporal = '1') then
            temporal <= '0';
        end if;
    end process;
end behavior;