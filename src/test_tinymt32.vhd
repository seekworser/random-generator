library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.common.all;

entity test_tinymt32 is
end test_tinymt32;

architecture behavior of test_tinymt32 is
    component tinymt32 is
        generic(
            initial_seed: std_logic_vector_array;
            mat1: std_logic_vector(31 downto 0);
            mat2: std_logic_vector(31 downto 0);
            tmat: std_logic_vector(31 downto 0)
        );
        port (
            clock: in std_logic;
            random: out std_logic_vector(31 downto 0)
        );
    end component;
    signal clock: std_logic;
    signal random: std_logic_vector(31 downto 0);
begin
    u1: tinymt32
        generic map(
            initial_seed => (X"0cca24d8", X"11ba5ad5", X"f2dad045", X"d95dd7b2"),
            mat1 => X"8f7011ee",
            mat2 => X"fc78ff1f",
            tmat => X"3793fdff"
        )
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
