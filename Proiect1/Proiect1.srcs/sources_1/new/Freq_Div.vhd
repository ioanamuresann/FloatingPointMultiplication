----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/27/2022 05:34:54 PM
-- Design Name: 
-- Module Name: Freq_Div - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Freq_div is
port(
	 CLK : in std_logic;
     CLK0 : out std_logic
	 );
end Freq_div;

architecture Behavioral of Freq_div is
	signal count : INTEGER range 0 to 499999 := 0;
begin
	Divide : process (CLK)
	begin
		if (CLK' event and CLK = '1') then
			if ( count = 499999 ) then
				CLK0 <= '1';
				count <= 0;		  
			else
				count <= count + 1;
				CLK0 <= '0';		  
			end if;
		end if;
	end process Divide;
end Behavioral;
