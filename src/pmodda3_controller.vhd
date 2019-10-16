library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.common.all;

entity pmodda3_controller is
    port (
        clock: in std_logic;
        random: in std_logic_vector(15 downto 0);
        sclk: out std_logic;
        cs: out std_logic;
        din: out std_logic;
        ldac: out std_logic
    );
end pmodda3_controller;

architecture behavior of pmodda3_controller is
    signal counter: integer range 0 to 16;
    signal data_bit: std_logic_vector(15 downto 0) := (others => '0');
begin
    sclk <= clock;
    count: process(clock) begin
        if rising_edge(clock) then
            if counter = 16 then
                counter <= 0;
                cs <= '1';
                din <= '0';
                ldac <= '0';
                data_bit <= random;
            else
                counter <= counter + 1;
                cs <= '0';
                din <= data_bit(counter);
                ldac <= '1';
            end if;
        end if;
    end process;
end behavior;