--Libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- this may be useful, have a look at conversions in vhdl

entity display is

	port (
				VALUE 	        :	in	std_logic_vector(4 downto 0);
        SEGMENTS_0  	:	out	std_logic_vector(6 downto 0);
        SEGMENTS_1      :   out std_logic_vector(6 downto 0)
	    );

end entity;

architecture behaviour of display is
type rom_type is array(0 to 9) of std_logic_vector(6 downto 0);
--code from homework 11
signal rom: rom_type :=("1111110","0110000","1101101","1111001","0110011","1011011","1011111","1110000","1111111","1111011");
begin

			SEGMENTS_0 <= rom(to_integer(unsigned(Value) mod 10));
			SEGMENTS_1 <= rom(0) when unsigned(VALUE)<10 else
										rom(to_integer(unsigned(Value)/10));
end architecture;
