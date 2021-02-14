library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sevensegment is
port(
        VALUE : in unsigned(3 downto 0);
        BCD : in std_logic;
        SEGMENTS : out std_logic_vector(6 downto 0);
        clk : in std_logic
    );
end entity;

architecture v1 of sevensegment is
    type rom_type is array(0 to 9) of std_logic_vector(6 downto 0);
    signal rom: rom_type :=("1111110","0110000","1101101","1111001","0110011","1011011","1011111","1110000","1111111","1111011");
-- Positionen im Siebensegment

--  ----6----
--  |       |
--  1       5
--  |       |
--  ----0----
--  |       |
--  2       4
--  |       |
--  ----3----
--
-- Somit 0: 1111110
--       9: 1111011
begin
  process(clk, bcd)
  begin
    -- Frage: als ich mir dies in GTKWave angeschaut habe, war die zuweisung von value immer erst ein Takt später im Rom-Array bei rising_edge(1/2 bei falling_edge): Warum ist dies so?
    if (rising_edge(clk) and bcd='1') then
      segments <= rom(to_integer(VALUE));
    end if;
  end process;
-- Tipp: Die Funktion to_integer könnte in dieser Aufgabe nützlich sein.
end architecture;
