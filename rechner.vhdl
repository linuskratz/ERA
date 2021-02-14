--Libraries
library ieee;
use ieee.std_logic_1164.all;


entity rechner is

	port (
        A 	            :	in	std_logic_vector(2 downto 0);
        B 	            :	in	std_logic_vector(2 downto 0);
        SEL             :   in  std_logic;
        SEGMENTS_0  	:	out	std_logic_vector(6 downto 0);
        SEGMENTS_1      :   out std_logic_vector(6 downto 0)
	    );

end entity;

architecture structure of rechner is


	component display is
	port(
			VALUE 	        :	in	std_logic_vector(4 downto 0);
			SEGMENTS_0  	:	out	std_logic_vector(6 downto 0);
			SEGMENTS_1      :   out std_logic_vector(6 downto 0)
		);
	end component;

	component addierer is
		port(
				A, B	:	in	std_logic_vector(2 downto 0);
				SUM    	:	out	std_logic_vector(3 downto 0)
		);
	end component;

	component muldiv is
	port (
				INPUT  	:	in	std_logic_vector(3 downto 0);
				SEL     :   in  std_logic;
		OUTPUT  :	out	std_logic_vector(4 downto 0)
			);
	end component;

	-- startwerte den signalen zuweisen
	signal SUM:	std_logic_vector(3 downto 0):="0000";
	signal OUTPUT: std_logic_vector(4 downto 0) := "00000";

	begin
		-- sum auf input und output auf value mapping
	add: addierer port map (A => A, B => B, SUM => SUM);
	mul: muldiv port map (INPUT=>SUM, SEL=>SEL, OUTPUT =>OUTPUT);
	dis: display port map (VALUE=>OUTPUT, SEGMENTS_0 =>SEGMENTS_0 ,SEGMENTS_1=>SEGMENTS_1);

end architecture;
