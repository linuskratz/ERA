--Libraries
library ieee;
use ieee.std_logic_1164.all;

--ghdl -r rechner_tb --vcd=rechner.vcd --stop-time=100ns

entity rechner_tb is
end entity;

architecture test of rechner_tb is
    signal A,B : std_logic_vector(2 downto 0) :="000";
    signal SEL : std_logic := '0';
    signal SEGMENTS_0, SEGMENTS_1 : std_logic_vector(6 downto 0);
    constant wait_period : time := 10 ns;

    component rechner is
    port(
     A,B : in std_logic_vector(2 downto 0);
     SEL : in std_logic;
     SEGMENTS_0, SEGMENTS_1 : out std_logic_vector(6 downto 0)
    );
    end component;


begin
    rec: rechner port map (A => A, B => B, SEL => SEL, SEGMENTS_0 => SEGMENTS_0, SEGMENTS_1 => SEGMENTS_1);
    process
      begin
        --(5+3) *2
        A <="101";
        B <= "011";
        SEL <= '0';
        wait for wait_period;
        --(7+0) / 2
        A <="111";
        B <= "000";
        SEL <= '1';
        wait for wait_period;
        --(7+7)*2
        A <="111";
        B <= "111";
        SEL <= '0';
        wait for wait_period;
        --(5+4)/2
        A <="101";
        B <= "100";
        SEL <= '1';
        wait for wait_period;
      end process;
end architecture;
