library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity papilio_wrapper is
    port (
        clk: in std_logic;
        a: out std_logic_vector(3 downto 0)
    );
end papilio_wrapper;

architecture behavior of papilio_wrapper is
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
    component random_generator is
        port (
            clock: in std_logic;
            random: out std_logic_vector(15 downto 0)
        );
    end component;
    component pmodda3_controller is
        port (
            clock: in std_logic;
            random: in std_logic_vector(15 downto 0);
            sclk: out std_logic;
            cs: out std_logic;
            din: out std_logic;
            ldac: out std_logic
        );
    end component;
    signal slow_clock: std_logic;
    signal random: std_logic_vector(15 downto 0);
begin
    u1: clock_divider
        generic map(
            clock_frequency => 32000000,
            slow_clock_frequency => 320000000
        )
        port map(
            clock => clk,
            slow_clock => slow_clock
        );
    u2: random_generator
        port map(
            clock => clk,
            random => random
        );
    u3: pmodda3_controller
        port map(
            clock => slow_clock,
            random => random,
            sclk => a(3),
            cs => a(0),
            din => a(1),
            ldac => a(2)
        );
end behavior;
