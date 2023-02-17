----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2023 05:17:12 PM
-- Design Name: 
-- Module Name: Multiplication_tb - Behavioral
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

entity Multiplication_tb is
--  Port ( );
end Multiplication_tb;

architecture Behavioral of Multiplication_tb is

component IEEE_Multiplication is
port(
	input1 : in STD_LOGIC_VECTOR(31 downto 0);
	input2 : in STD_LOGIC_VECTOR(31 downto 0);
	load : in STD_LOGIC;
	 clk : in STD_LOGIC;
	output : out STD_LOGIC_VECTOR(31 downto 0);
	done : out STD_LOGIC
	);
end component;

signal clk_signal: STD_LOGIC := '0';
signal input1_signal: STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
signal input2_signal: STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
signal load_signal: STD_LOGIC := '0';

signal output_signal: STD_LOGIC_VECTOR(31 downto 0);
signal done_flag_signal: STD_LOGIC;

begin

comp: IEEE_Multiplication port map(
  
        input1 => input1_signal,
        input2 => input2_signal,
        load => load_signal,
        clk => clk_signal,
        output => output_signal,
        done => done_flag_signal    
        );

process_clk: process
    begin
        clk_signal <= '1';
        wait for 5 ns;
        clk_signal <= '0';
        wait for 5 ns;
    end process;
    
process_load: process
    begin
        load_signal <= '1';
        wait for 10 ns;
        load_signal <= '0';
        wait for 390 ns;
    end process;

process_input: process
    begin
        input1_signal <= x"4123ae14"; --10.23
        input2_signal <= x"401e147b"; -- 2.47
        wait for 400 ns;
        input1_signal <= x"c123ae14"; -- -10.23
        input2_signal <= x"c01e147b"; -- -2.47
        wait for 400 ns;
        input1_signal <= x"c123ae14"; -- -10.23
        input2_signal <= x"401e147b"; -- 2.47
        wait for 400 ns;
        input1_signal <= x"4123ae14"; --10.23
        input2_signal <= x"c01e147b"; -- -2.47
        wait for 400 ns;
    end process;    


end Behavioral;
