library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.common.all;


entity tinymt32 is
    generic(
        initial_seed: std_logic_vector_array := (X"0cca24d8", X"11ba5ad5", X"f2dad045", X"d95dd7b2");
        mat1: std_logic_vector(31 downto 0) := X"8f7011ee";
        mat2: std_logic_vector(31 downto 0) := X"fc78ff1f";
        tmat: std_logic_vector(31 downto 0) := X"3793fdff"
    );
    port (
        clock: in std_logic;
        random: out std_logic_vector(31 downto 0) := (others => '0')
    );
end tinymt32;

architecture behavior of tinymt32 is
    constant mask: std_logic_vector(31 downto 0) := X"7fffffff";
    signal status: std_logic_vector_array := initial_seed;
    signal t0: std_logic_vector(31 downto 0) := (others => '0');
    signal t1: std_logic_vector(31 downto 0) := (others => '0');
begin
process(clock)
    variable next_status: std_logic_vector_array := status;
    variable x: std_logic_vector(31 downto 0);
    variable y: std_logic_vector(31 downto 0);
    variable t0: std_logic_vector(31 downto 0);
    variable t1: std_logic_vector(31 downto 0);
    variable t2: unsigned(31 downto 0);
    variable t3: unsigned(31 downto 0);
begin
    if rising_edge(clock) then
        x := (status(3) and mask) xor status(2) xor status(1);
        x := x xor x(30 downto 0) & '0';
        y := status(0) xor (('0' & status(0)(31 downto 1))  xor x);
        next_status(3) := status(2);
        next_status(0) := y;
        if y(0) = '1' then
            next_status(2) := status(1) xor mat1;
            next_status(1) := x xor (y(21 downto 0) & "0000000000") xor mat2;
        else
            next_status(2) := status(1);
            next_status(1) := x xor (y(21 downto 0) & "0000000000");
        end if;

        -- tempering
        t0 := next_status(0);
        t2 := unsigned(next_status(3));
        t1 := "00000000" & next_status(1)(31 downto 8);
        t3 := unsigned(t1);
        t1 := std_logic_vector((t2 + t3));
        t0 := t0 xor t1;
        if t1(0) = '1' then
            t0 := t0 xor tmat;
        end if;
        random <= t0;
        status <= next_status;
    end if;
end process;
end behavior;