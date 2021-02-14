--Libraries
library ieee;
use ieee.std_logic_1164.all;


entity muldiv is

	port (
        INPUT  	:	in	std_logic_vector(3 downto 0);
        SEL     :   in  std_logic;
		OUTPUT  :	out	std_logic_vector(4 downto 0)
	    );

end entity;

architecture behavior of muldiv is
begin
-- sel = '0' -> *2 d.h. shift nach links; sonst shift nach rechts
OUTPUT <= Input(3 downto 0) & '0' when SEL = '0' else
					"00" & Input(3 downto 1);
end architecture;
