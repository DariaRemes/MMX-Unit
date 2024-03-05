----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2023 08:27:23 PM
-- Design Name: 
-- Module Name: instrMem - Behavioral
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

entity instrMem is
    Port ( clk : in STD_LOGIC;
           instr_in : in STD_LOGIC_VECTOR (8 downto 0);
           wr_en : in STD_LOGIC;
           pc : in std_logic_vector(6 downto 0); -- max 127
           reset : in std_logic;
           instr_out : out STD_LOGIC_VECTOR (8 downto 0));
end instrMem;

architecture Behavioral of instrMem is

-- memorie Rom
type instrMemory is array (0 to 127) of std_logic_vector(8 downto 0); --127
-- initializre memorie 
signal myInstrMem : instrMemory := (others => "000000000");
begin

-- scriere instructiune noua 
process(clk, wr_en)
begin 
if clk = '1' then   
    if wr_en = '1' then 
        myInstrMem(conv_integer(pc)) <= instr_in;
    end if;
end if;
end process; 
--citire instructiune scrisa 
instr_out <= myInstrMem(conv_integer(pc));
end Behavioral;
