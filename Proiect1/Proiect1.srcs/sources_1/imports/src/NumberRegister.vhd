library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NumberRegister is
port(
	moveUpDown : in STD_LOGIC;
	updown : in STD_LOGIC;
	reset : in STD_LOGIC;
	nextDigit : in STD_LOGIC;
	number : out STD_LOGIC_VECTOR(15 downto 0);
	decimalPointMover : in STD_LOGIC;
	decimalPointLocation : out STD_LOGIC_VECTOR(2 downto 0);
	currentDigit : out STD_LOGIC_VECTOR(1 downto 0)
	);
end NumberRegister;

architecture Behavioral of NumberRegister is

	signal sel, updown_signal, d0, d1, d2, d3 : STD_LOGIC_VECTOR(1 downto 0);

begin
	updown_signal(0) <= updown;
	updown_signal(1) <= moveUpDown;
--folosit pentru a introduce urmatoarea cifra,a inainta pe cele 4 cifre posibile de afisat pe placuta	
nextD: entity WORK.CounterModulo_4 port map(moveUp => nextDigit,reset => reset,Q => sel);		 
DMUX: entity WORK.dmux_2to1_2bits port map(input => updown_signal,sel => sel,d0 => d0,d1 => d1,d2 => d2,d3 => d3);
cifra1: entity WORK.CounterModulo_10 port map(moveUpDown => d0(1),updown => d0(0),reset => reset,Q => number(15 downto 12)); 
cifra2: entity WORK.CounterModulo_10 port map(moveUpDown => d1(1),updown => d1(0),reset => reset,Q => number(11 downto 8));
cifra3: entity WORK.CounterModulo_10 port map(moveUpDown => d2(1),updown => d2(0),reset => reset,Q => number(7 downto 4));
cifra4: entity WORK.CounterModulo_10 port map(moveUpDown => d3(1),updown => d3(0),reset => reset,Q => number(3 downto 0));
decimalP: entity WORK.CounterModulo_5 port map(moveUp => decimalPointMover,reset => reset,Q => decimalPointLocation);
	
currentDigit <= sel;
	
end Behavioral;