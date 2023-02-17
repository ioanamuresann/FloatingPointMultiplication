library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Control is
port(
	load : in STD_LOGIC; --'1' va introduce numerele date de utilizator,'0' va afisa rezultatul
	reset, clr : in STD_LOGIC;
	sign1, sign2 : in STD_LOGIC;
	number1 : in STD_LOGIC; --'1' va introduce number1, '0'va introduce number 2				   
	updown : in STD_LOGIC; --'1' creste, '0' scade, pentru selectarea cifrei
	moveUpDown : in STD_LOGIC; 
	nextDigit : in STD_LOGIC; --trece la urmatoarea cifra (rising edge)
	decimalPointMover : in STD_LOGIC; --va misca virgula la stanga( rising edge)
	flag : in STD_LOGIC; 
	clk : in STD_LOGIC; --internal clock 
	done : out STD_LOGIC; --'1' cand operatia de inmultire este finalizata
	currentDigit : out STD_LOGIC_VECTOR(3 downto 0);					   					   
	sign : out STD_LOGIC;
	--pentru partea de afisare pe cele 7 segmente		
	a_to_g : out STD_LOGIC_VECTOR(6 downto 0);
	dp : out STD_LOGIC;
	an : out STD_LOGIC_VECTOR(3 downto 0)
	);
end Control;

architecture Behavioral of Control is

--toate semnalele de care am nevoie
	signal moveUpDown_signal, moveUpDown1_signal, moveUpDown2_signal : STD_LOGIC;
	signal nextDigit_signal, nextDigit1_signal, nextDigit2_signal : STD_LOGIC;
	signal decimalPointMover_signal, decimalPointMover1_signal, decimalPointMover2_signal : STD_LOGIC;
	signal decimalPointLocation1, decimalPointLocation2, decimalPointLocationOutput, dp_location : STD_LOGIC_VECTOR(2 downto 0);
	signal input1_BCD, input2_BCD, output_BCD, to_display : STD_LOGIC_VECTOR(15 downto 0);
	signal input1_IEEE, input2_IEEE, output_IEEE : STD_LOGIC_VECTOR(31 downto 0);
	signal load_bcd1, load_bcd2, load_main, load_finalConv : STD_LOGIC;
	signal done_ieee1, done_ieee2, done_main : STD_LOGIC;
	signal main_loaded, finalConv_loaded : STD_LOGIC;
	signal currentDigit1, currentDigit2 : STD_LOGIC_VECTOR(1 downto 0);	
	signal sign_signal, signsignal : STD_LOGIC;

begin
--mapez toate componentele de care am nevoie
Debouncer1: entity WORK.Debouncer port map(moveUpDown, clk, moveUpDown_signal);
Debouncer2: entity WORK.Debouncer port map(nextDigit, clk, nextDigit_signal);
Debouncer3: entity WORK.Debouncer port map(decimalPointMover, clk, decimalPointMover_signal);													 													  						 	  
Number1_comp: entity WORK.NumberRegister port map(moveUpDown1_signal, updown, reset, nextDigit1_signal, input1_BCD, decimalPointMover1_signal, decimalPointLocation1, currentDigit1);
Number2_comp: entity WORK.NumberRegister port map(moveUpDown2_signal, updown, reset, nextDigit2_signal, input2_BCD, decimalPointMover2_signal, decimalPointLocation2, currentDigit2);	
transformBCDtoIEEE1: entity WORK.BCDtoIEEE port map(input1_BCD, decimalPointLocation1, load_bcd1, sign1, clk, input1_IEEE, done_ieee1);
transformBCDtoIEEE2: entity WORK.BCDtoIEEE port map(input2_BCD, decimalPointLocation2, load_bcd2, sign2, clk, input2_IEEE, done_ieee2);	
Main_component: entity WORK.Main port map(input1_IEEE, input2_IEEE, clk, load_main, flag, output_IEEE, done_main);
transformIEEEtoBCD_component: entity WORK.IEEEtoBCD port map(output_IEEE, load_finalConv, clk, sign_signal, output_BCD, decimalPointLocationOutput, done);
SSD: entity WORK.x7seg port map(clk, clr, a_to_g, dp, an, to_display, dp_location);
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(load = '1') then
				load_main <= '0';
				main_loaded <= '0';
				load_finalConv <= '0';
				finalConv_loaded <= '0';
				signsignal <= '0';
				if(number1 = '1') then
					load_bcd1 <= '1';
					load_bcd2 <= '0';
					moveUpDown1_signal <= moveUpDown_signal;
					moveUpDown2_signal <= '0';
					nextDigit1_signal <= nextDigit_signal;
					nextDigit2_signal <= '0';
					decimalPointMover1_signal <= decimalPointMover_signal;
					decimalPointMover2_signal <= '0';
					to_display <= input1_bcd;
					dp_location <= decimalPointLocation1;
					case currentDigit1 is
						when "00" => currentDigit <= "1000";
						when "01" => currentDigit <= "0100";
						when "10" => currentDigit <= "0010";
						when others => currentDigit <= "0001";
					end case;
				else
					load_bcd2 <= '1';
					load_bcd1 <= '0';
					moveUpDown2_signal <= moveUpDown_signal;
					moveUpDown1_signal <= '0';
					nextDigit2_signal <= nextDigit_signal;
					nextDigit1_signal <= '0';
					decimalPointMover2_signal <= decimalPointMover_signal;
					decimalPointMover1_signal <= '0';
					to_display <= input2_bcd;
					dp_location <= decimalPointLocation2;
					case currentDigit2 is
						when "00" => currentDigit <= "1000";
						when "01" => currentDigit <= "0100";
						when "10" => currentDigit <= "0010";
						when others => currentDigit <= "0001";
					end case;
				end if;
			else
				load_bcd2 <= '0';
				load_bcd1 <= '0';
				to_display <= output_bcd;
				dp_location <= decimalPointLocationOutput;
				currentDigit <= "0000";	
				signsignal <= sign1 xor sign2;
				if(done_ieee1 = '1' and done_ieee2 = '1') then
					if(main_loaded = '0') then
						load_main <= '1';	 
						main_loaded <= '1';
					else
						load_main <= '0';
						if(done_main = '1') then
							if(finalConv_loaded = '0') then
								load_finalConv <= '1';
								finalConv_loaded <= '1';
							else
								load_finalConv <= '0';
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	sign <= signsignal;

end Behavioral;