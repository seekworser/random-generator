library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package common is
    type std_logic_vector_array is array (3 downto 0) of std_logic_vector(31 downto 0);
end package common;