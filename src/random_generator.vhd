library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.common.all;


entity random_generator is
    generic(
        initial_seed: std_logic_vector_array := (X"0cca24d8", X"11ba5ad5", X"f2dad045", X"d95dd7b2");
        mat1: std_logic_vector(31 downto 0) := X"8f7011ee";
        mat2: std_logic_vector(31 downto 0) := X"fc78ff1f";
        tmat: std_logic_vector(31 downto 0) := X"3793fdff"
    );
    port (
        clock: in std_logic;
        random: out std_logic_vector(15 downto 0)
    );
end random_generator;

architecture behavior of random_generator is
    component tinymt32 is
        generic (
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
    signal random_32: std_logic_vector(31 downto 0);
begin
    u1: tinymt32
        generic map(
            initial_seed => initial_seed,
            mat1 => mat1,
            mat2 => mat2,
            tmat => tmat
        )
        port map(
            clock => clock,
            random => random_32
        );
    random(15 downto 0) <= random_32(31 downto 16);
end behavior;