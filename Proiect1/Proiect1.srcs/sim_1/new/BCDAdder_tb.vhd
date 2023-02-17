----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2022 02:18:02 PM
-- Design Name: 
-- Module Name: BCDAdder_tb - Behavioral
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

entity BCDAdder_tb is
--  Port ( );
end BCDAdder_tb;

architecture Behavioral of BCDAdder_tb is
-- Declaratiile semnalelor de intrare 
signal A : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000"; 
signal B : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";  
-- Declaratiile semnalelor de iesire 
signal Sum : STD_LOGIC_VECTOR(15 downto 0); 
signal CarryOut : STD_LOGIC; 

begin
-- Instantierea entitatii proiectului testat (DUT) 
DUT: entity WORK.BCDAdder port map (A => A,B => B,Sum => Sum,CarryOut => CarryOut); 

test: process

begin
     A<="0000000000000001";
     B<="0000000000000010";
     wait;
end process test;
end Behavioral;
