library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_divider is
    generic (
        clock_frequency: integer := 32000000;
        slow_clock_frequency: integer := 8000000
    );
    port (
        clock: in std_logic;
        slow_clock: out std_logic
    );
end clock_divider;

architecture behavior of clock_divider is
    constant div_rate: integer := clock_frequency / slow_clock_frequency;
    signal counter: integer range -1 to div_rate := -1;
    signal temporal: std_logic := '0';
begin
    slow_clock <= temporal;
    count: process(clock) begin
        if counter >= div_rate then
            counter <= 0;
        else
            counter <= counter + 1;
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