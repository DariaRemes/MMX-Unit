----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2023 11:59:53 PM
-- Design Name: 
-- Module Name: UMMX - Behavioral
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

entity UMMX is
  Port (  op1 : in std_logic_vector(63 downto 0);
          op2 : in std_logic_vector(63 downto 0);
          instr : in std_logic_vector(8 downto 0);
          res : out std_logic_vector(63 downto 0);
          wr_en : out std_logic
   );
end UMMX;

architecture Behavioral of UMMX is

-- PADDD
function paddd(a, b: std_logic_vector(63 downto 0)) return std_logic_vector is
variable result : std_logic_vector(63 downto 0);
begin

    result(31 downto 0)  := a(31 downto 0) + b(31 downto 0);
	result(63 downto 32) := a(63 downto 32) + b(63 downto 32); 

return result;

end function paddd;

-- PSUBB 
function psubb(a, b: std_logic_vector(63 downto 0)) return std_logic_vector is
variable result : std_logic_vector(63 downto 0);
begin

    result(7 downto 0) := a(7 downto 0) - b(7 downto 0);
    result(15 downto 8) := a(15 downto 8) - b(15 downto 8);
    result(23 downto 16) := a(23 downto 16) - b(23 downto 16);
    result(31 downto 24) := a(31 downto 24) - b(31 downto 24);
    result(39 downto 32) := a(39 downto 32) - b(39 downto 32);
    result(47 downto 40) := a(47 downto 40) - b(47 downto 40);
    result(55 downto 48) := a(55 downto 48) - b(55 downto 48);
    result(63 downto 56) := a(63 downto 56) - b(63 downto 56);

return result;

end function psubb;

-- PSUBD
function psubd(a, b: std_logic_vector(63 downto 0)) return std_logic_vector is
variable result : std_logic_vector(63 downto 0);
begin

    result(31 downto 0)  := a(31 downto 0) - b(31 downto 0);
	result(63 downto 32) := a(63 downto 32) - b(63 downto 32);

return result;

end function psubd;

-- PCMPEQD 
function pcmpeqd(a, b: std_logic_vector(63 downto 0)) return std_logic_vector is
variable result : std_logic_vector(63 downto 0);
begin

    if a(31 downto 0) = b(31 downto 0) then result(31 downto 0) := x"11111111"; else result(31 downto 0) := x"00000000"; end if;
    if a(63 downto 32) = b(63 downto 32) then result(63 downto 32) := x"11111111"; else result(63 downto 32) := x"00000000"; end if;

return result;

end function pcmpeqd;

-- PCMPGTD 
function pcmpgtd(a, b: std_logic_vector(63 downto 0)) return std_logic_vector is
variable result : std_logic_vector(63 downto 0);
begin

    if b(31 downto 0) >= a(31 downto 0) then result(31 downto 0) := x"11111111"; else result(31 downto 0) := x"00000000"; end if;
    if b(63 downto 32) >= a(63 downto 32) then result(63 downto 32) := x"11111111"; else result(63 downto 32) := x"00000000"; end if;
    
return result;

end function pcmpgtd;

-- PAND
function pand(a, b: std_logic_vector(63 downto 0)) return std_logic_vector is
variable result : std_logic_vector(63 downto 0);
begin

    result(63 downto 0) := a(63 downto 0) and b(63 downto 0);

return result;

end function pand;

-- PMADDWD
function pmaddwd(a, b: std_logic_vector(63 downto 0)) return std_logic_vector is
variable result : std_logic_vector(63 downto 0);
begin

    result(31 downto 0)  := (a(15 downto 0) * b(15 downto 0)) + (a(31 downto 16) * b(31 downto 16));
	result(63 downto 32) := (a(47 downto 32) * b(47 downto 32)) + (a(63 downto 48) * b(63 downto 48));

return result;

end function pmaddwd;

signal result : std_logic_vector(63 downto 0) := x"0000000000000000";

begin
process(op1, op2, instr, result)
begin
case instr(8 downto 6) is 
    when "000" => result <= paddd(op1, op2); -- PADDD
    when "001" => result <= psubb(op1, op2); -- PSUBB
    when "010" => result <= psubd(op1, op2); -- PSUBD 
    when "011" => result <= pcmpeqd(op1, op2);-- PCMPEQD 
    when "100" => result <= pcmpgtd(op1, op2);-- PCMPGTD 
    when "101" => result <= pand(op1, op2);-- PAND 
    when "110" => result <= pmaddwd(op1, op2);-- PMADDWD 
    when others => result <= x"0000000000000000";
end case;
res <= result;
wr_en <= '1';
end process;

end Behavioral;
