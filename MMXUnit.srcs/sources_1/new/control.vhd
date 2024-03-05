----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2023 07:54:42 PM
-- Design Name: 
-- Module Name: control - Behavioral
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

entity control is
    Port ( clk : in std_logic;
           pc : in std_logic_vector(6 downto 0);
           instr_in : in STD_LOGIC_VECTOR (8 downto 0);
           wr_en : in STD_LOGIC;
           reset : in std_logic;
           result : out STD_LOGIC_VECTOR (63 downto 0));
end control;

architecture Behavioral of control is

component instrMem is
    Port ( clk : in STD_LOGIC;
           instr_in : in STD_LOGIC_VECTOR (8 downto 0);
           wr_en : in STD_LOGIC;
           pc : in std_logic_vector(6 downto 0); -- max 127
           reset : in std_logic;
           instr_out : out STD_LOGIC_VECTOR (8 downto 0));
end component;

component regFile is
  Port ( clk : in std_logic;
         ra1 : in std_logic_vector(2 downto 0); -- adresa din instr 
         ra2 : in std_logic_vector(2 downto 0); -- adresa din instr
         w_en : in std_logic; -- activ cand se genereaza rez op
         reg_write : in std_logic_vector (2 downto 0); -- adresa pt stocarea rez
         wd : in std_logic_vector(63 downto 0); -- rez final
         rd1 : out std_logic_vector(63 downto 0); -- operand 1 din reg
         rd2 : out std_logic_vector(63 downto 0) -- operand 2 din reg
   );
end component;

component UMMX is
  Port (  op1 : in std_logic_vector(63 downto 0);
          op2 : in std_logic_vector(63 downto 0);
          instr : in std_logic_vector(8 downto 0);
          res : out std_logic_vector(63 downto 0);
          wr_en : out std_logic
   );
end component;

signal instrOut : std_logic_vector(8 downto 0);
signal Rd1, Rd2, resOut : std_logic_vector(63 downto 0);
signal wrEn : std_logic;
signal count : std_logic_vector(6 downto 0) := "0000000";

begin

InstructionMem: instrMem port map (clk, instr_in, wr_en, count, reset, instrOut);
RegisterFile : regFile port map (clk, instrOut(2 downto 0), instrOut(5 downto 3), wrEn, "111", resOut, Rd1, Rd2);
MMXUnit : UMMX port map (Rd1, Rd2, instrOut, resOut, wrEn);

count <= pc;
process(reset)
begin
if reset = '0' then
    count <= "0000000";
else
    count <= count + 1;
end if;
end process;
result <= resOut;
end Behavioral;
