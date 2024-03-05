----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/28/2023 06:12:29 PM
-- Design Name: 
-- Module Name: testbench_ummx - Behavioral
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

entity testbench_ummx is
--  Port ( );
end testbench_ummx;

architecture Behavioral of testbench_ummx is

component UMMX is
  Port (  op1 : in std_logic_vector(63 downto 0);
          op2 : in std_logic_vector(63 downto 0);
          instr : in std_logic_vector(8 downto 0);
          res : out std_logic_vector(63 downto 0);
          wr_en : out std_logic
   );
end component;

signal clk_tb : std_logic := '0';
signal op1_tb, op2_tb : std_logic_vector(63 downto 0);
signal instr_tb : std_logic_vector(8 downto 0);
signal res_tb : std_logic_vector(63 downto 0);
signal wr_en_tb : std_logic;

constant period : time := 10ns ;

begin
unit : UMMX port map (op1_tb, op2_tb, instr_tb, res_tb, wr_en_tb);

process

begin

    -- Test case1: PADDD 
    op1_tb <= x"0000000000000001";
    op2_tb <= x"0000000000000002";
    instr_tb <= "000000001";
    
    wait for period;
    
    -- Test case2: PSUBB 
    op1_tb <= x"0000000000000005";
    op2_tb <= x"0000000000000002";
    instr_tb <= "001100001";
    
    wait for period;
    
    -- Test case 3: PSUBD
      op1_tb <= x"0000000000000007";
      op2_tb <= x"0000000000000003";
      instr_tb <= "010111010";

      wait for period;
      
      -- Test case 4: PCMPEQD
      op1_tb <= x"0000000000000005";
      op2_tb <= x"0000000000000005";
      instr_tb <= "011100100";

      wait for period;
      
      -- Test case 5: PCMPGTD
      op1_tb <= x"0000000000000007";
      op2_tb <= x"0000000000000003";
      instr_tb <= "100110010";

      wait for period;

      -- Test case 6: PAND
      op1_tb <= x"0000000000000003";
      op2_tb <= x"0000000000000004";
      instr_tb <= "101010011";

      wait for period;

      -- Test case 7: PMADDWD
      op1_tb <= x"0000000000000003";
      op2_tb <= x"0000000000000004";
      instr_tb <= "110010011";

      wait for period;

wait;
end process;

end Behavioral;
