----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2024 09:13:51 PM
-- Design Name: 
-- Module Name: testbench_control - Behavioral
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

entity testbench_control is
--  Port ( );
end testbench_control;

architecture Behavioral of testbench_control is

component control is
    Port ( clk : in std_logic;
           pc : in std_logic_vector(6 downto 0);
           instr_in : in STD_LOGIC_VECTOR (8 downto 0);
           wr_en : in STD_LOGIC;
           reset : in std_logic;
           result : out STD_LOGIC_VECTOR (63 downto 0));
end component;

signal clk_tb : std_logic;
signal pc_tb : std_logic_vector(6 downto 0);
signal instr_in_tb : STD_LOGIC_VECTOR (8 downto 0);
signal wr_en_tb : STD_LOGIC;
signal reset_tb : std_logic;
signal result_tb : STD_LOGIC_VECTOR (63 downto 0) := x"0000000000000000";

constant period : time := 10ns ;

begin

test: control port map (clk_tb, pc_tb, instr_in_tb, wr_en_tb, reset_tb, result_tb);

process
begin

 -- Test case 1 
    clk_tb <= '1';
    pc_tb <= "0000000";
    instr_in_tb <= "000000001";
    wr_en_tb <= '1';
    reset_tb <= '0';
    wait for period;
    
    -- Test case 2
    clk_tb <= '1'; 
    pc_tb <= pc_tb + 1;
    instr_in_tb <= "001100001";
    wr_en_tb <= '1';
    reset_tb <= '0';
    wait for period;

wait;
end process;

end Behavioral;
