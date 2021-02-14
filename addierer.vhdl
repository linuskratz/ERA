--Libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addierer is

	port (
		A, B	:	in	std_logic_vector(2 downto 0);
		SUM    	:	out	std_logic_vector(3 downto 0)
	    );
end entity;

architecture behavior of addierer is

		-- overflow abfangen dh. 111+1 = 1000
		-- falls die letzten drei ziffern kleiner sind als zuvor ist ein overflow da
		begin
		SUM <= '1' & std_logic_vector(unsigned(A) + unsigned(B)) when ((unsigned(A) + unsigned(B) < unsigned(A)) or (unsigned(A) + unsigned(B) < unsigned(B))) else
					 '0' & std_logic_vector(unsigned(A) + unsigned(B));
end architecture;
