----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/04/2023 01:44:29 PM
-- Design Name: 
-- Module Name: Main - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Main is
port(
	input1, input2 : in STD_LOGIC_VECTOR(31 downto 0);
	clk, load, flag : in STD_LOGIC; 
	output : out STD_LOGIC_VECTOR(31 downto 0);
	done : out STD_LOGIC
	);
end Main; 

architecture Behavioral of Main is
	--semnalele de care am nevoie
	signal load_mul, done_mul: STD_LOGIC;
	signal output_mul: STD_LOGIC_VECTOR(31 downto 0);

begin

IEEE_Mul: entity WORK.IEEE_Multiplication port map(input1, input2, load_mul, clk, output_mul, done_mul);
	
	load_mul <= not flag and load;
	
	output <= output_mul when flag = '0' else output_mul;
	done <= done_mul when flag = '0' else done_mul;

end Behavioral;
