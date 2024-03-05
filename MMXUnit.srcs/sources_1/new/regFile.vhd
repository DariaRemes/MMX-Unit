----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2023 11:27:38 PM
-- Design Name: 
-- Module Name: regFile - Behavioral
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

entity regFile is
  Port ( clk : in std_logic;
         ra1 : in std_logic_vector(2 downto 0); -- adresa din instr 
         ra2 : in std_logic_vector(2 downto 0); -- adresa din instr
         w_en : in std_logic; -- activ cand se genereaza rez op
         reg_write : in std_logic_vector (2 downto 0); -- adresa pt stocarea rez
         wd : in std_logic_vector(63 downto 0); -- rez final
         rd1 : out std_logic_vector(63 downto 0); -- operand 1 din reg
         rd2 : out std_logic_vector(63 downto 0) -- operand 2 din reg
   );
end regFile;

architecture Behavioral of regFile is

-- memorie de registri MM0 -> MM7 (registrii MMX)
type regMemory is array (0 to 7) of std_logic_vector(63 downto 0);
signal myReg : regMemory := (x"0000000000000001",
                             x"0000000000000002", 
                             x"0000000000000003", 
                             x"0000000000000004", 
                             x"0000000000000005", 
                             x"0000000000000006",
                             x"0000000000000007",
                             x"0000000000000000");

begin
-- citesc valorile pentru operanzi 
process(ra1, ra2)
begin
    rd1 <= myReg(conv_integer(ra1));
    rd2 <= myReg(conv_integer(ra2));
end process; 

-- scriu rezultatul final in ultimul reg 
process(clk, w_en, wd)
begin
if falling_edge(clk) then
    if w_en = '1' then
        myReg(conv_integer(reg_write)) <= wd;
    end if;
end if;
end process;


end Behavioral;
