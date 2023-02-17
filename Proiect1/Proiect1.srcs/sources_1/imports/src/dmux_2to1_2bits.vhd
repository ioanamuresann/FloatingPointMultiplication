library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dmux_2to1_2bits is
port(
	input : in STD_LOGIC_VECTOR(1 downto 0);
	sel : in STD_LOGIC_VECTOR(1 downto 0);
	d0 : out STD_LOGIC_VECTOR(1 downto 0);
	d1 : out STD_LOGIC_VECTOR(1 downto 0);
	d2 : out STD_LOGIC_VECTOR(1 downto 0);
	d3 : out STD_LOGIC_VECTOR(1 downto 0)
	);
end dmux_2to1_2bits;

architecture Behavioral of dmux_2to1_2bits is

begin
	process(input, sel)
		begin
			if(sel = "00") then
				d0 <= input;
				d1 <= "00";
				d2 <= "00";
				d3 <= "00";
			elsif(sel = "01") then
				d1 <= input;
				d0 <= "00";
				d2 <= "00";
				d3 <= "00";
			elsif(sel = "10") then
				d2 <= input;
				d0 <= "00";
				d1 <= "00";
				d3 <= "00";
			else
				d3 <= input;
				d0 <= "00";
				d1 <= "00";
				d2 <= "00";
			end if;
		end process;
end Behavioral;