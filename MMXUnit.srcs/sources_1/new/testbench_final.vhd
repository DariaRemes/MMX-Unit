----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/13/2024 09:46:38 PM
-- Design Name: 
-- Module Name: testbench_final - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench_final is
--  Port ( );
end testbench_final;

architecture Behavioral of testbench_final is

component control is
    Port ( clk : in std_logic;
           pc : in std_logic_vector(6 downto 0);
           instr_in : in STD_LOGIC_VECTOR (8 downto 0);
           wr_en : in STD_LOGIC;
           reset : in std_logic;
           result : out STD_LOGIC_VECTOR (63 downto 0));
end component;

signal clk_tb : std_logic := '0';
signal pc_tb : std_logic_vector(6 downto 0) := "0000000";
signal instr_in_tb : std_logic_vector(8 downto 0) := "000000000";
signal wr_en_tb : std_logic := '0';
signal reset_tb : std_logic := '0';
signal result_tb : std_logic_vector(63 downto 0) := x"0000000000000000";
signal counter : std_logic_vector(6 downto 0) := "0000000";

constant period : time := 10ns;

begin

ummx_control : control port map(clk_tb, pc_tb, instr_in_tb, wr_en_tb, reset_tb, result_tb);

process
begin 

    --Test case 1 : PADDD
    clk_tb <= '1';
    pc_tb <= counter;
    instr_in_tb <= "000000001"; --1+2=3
    wr_en_tb <= '1';
    reset_tb <= '0';
    counter <= counter+1;
    wait for period;  
    
    --Test case 2 : PSUBB
     clk_tb <= '1';
     pc_tb <= counter;
     instr_in_tb <= "001100001"; --5-2=3
     wr_en_tb <= '1';
     reset_tb <= '0';
     counter <= counter+1;
     wait for period;
    
    --Test case 3 : PSUBD 
     clk_tb <= '1';
     pc_tb <= counter;
     instr_in_tb <= "010111010"; --7-3=5
     wr_en_tb <= '1';
     reset_tb <= '0';
     counter <= counter+1;
     wait for period;
    
    --Test case 4 : PCMPEQD 
     clk_tb <= '1';
     pc_tb <= counter;
     instr_in_tb <= "011100100"; --5=5 => x"1111111111111111"
     wr_en_tb <= '1';
     reset_tb <= '0';
     counter <= counter+1;
     wait for period;
    
    --Test case 5 : PCMPGTD 
     clk_tb <= '1';
     pc_tb <= counter;
     instr_in_tb <= "100110010"; --7>3 => x"1111111111111111"
     wr_en_tb <= '1';
     reset_tb <= '0';
     counter <= counter+1;
     wait for period;
    
    --Test case 6 : PAND 
     clk_tb <= '1';
     pc_tb <= counter+1;
     instr_in_tb <= "101010010"; --3&3=3 
     wr_en_tb <= '1';
     reset_tb <= '0';
     counter<=counter+1;
     wait for period;
    
    --Test case 7 : PMADDWD 
     clk_tb <= '1';
     pc_tb <= counter;
     instr_in_tb <= "110010011"; --3*4=12
     wr_en_tb <= '1';
     reset_tb <= '0';
     wait for period;

wait;
end process;
end Behavioral;
