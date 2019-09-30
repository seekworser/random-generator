library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_papilio_wrapper is
end test_papilio_wrapper;

architecture behavior of test_papilio_wrapper is
    component papilio_wrapper is
        port (
            clk: in std_logic;
            a: out std_logic_vector(3 downto 0)
        );
    end component;
    signal clk: std_logic;
    signal a: std_logic_vector(3 downto 0);
begin
    u1: papilio_wrapper
        port map(
            clk => clk,
            a => a
        );
    process
    begin
        for i in 0 to 10000 loop
            clk <= '1';
            wait for 16.25 ns;
            clk <= '0';
            wait for 16.25 ns;
        end loop;
        wait;
    end process;
end behavior;
