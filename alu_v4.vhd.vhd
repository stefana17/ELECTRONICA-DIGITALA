
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ALU is
    Port (
    A, B     : in  STD_LOGIC_VECTOR(7 downto 0);  
    ALU_Out   : out  STD_LOGIC_VECTOR(8 downto 0); 
    Carryout : out std_logic;       -- Carryout flag
    btnC : in std_logic; --Reset
    btnU: in std_logic; --Addition
    btnD : in std_logic; --Subtraction 
    btnR: in std_logic; --Multiplication
    btnL : in std_logic --Division
    );
end ALU; 

architecture Behavioral of ALU is

signal ALU_Result : std_logic_vector (8 downto 0);
signal tmp: std_logic_vector (8 downto 0);

begin
    process(A,B, btnC, btnD, btnL, btnR, btnU)
    begin
    --Addition 
        if btnU='1' then 
            tmp <= std_logic_vector(to_unsigned((to_integer(unsigned(A)) + to_integer(unsigned(B))),9)) ;  
            ALU_Result <= tmp(8 downto 0);   
        end if;
     --Subtraction 
        if btnD='1' then
            if A>B then
                 tmp <= std_logic_vector(to_unsigned((to_integer(unsigned(A)) - to_integer(unsigned(B))),9)) ; 
                 ALU_Result <= tmp(8 downto 0); 
             else 
                 tmp <='0'& A;
                 ALU_Result <= tmp(8 downto 0); 
             end if;
        end if;
     --Multiplication 
        if btnR='1' then
            tmp <= std_logic_vector(to_unsigned((to_integer(unsigned(A)) * to_integer(unsigned(B))),9)) ;
            ALU_Result <= tmp(8 downto 0); 
        end if;
     --Division
        if btnL='1' then
            tmp <= std_logic_vector(to_unsigned(to_integer(unsigned(A)) / to_integer(unsigned(B)),9)) ;
            ALU_Result <= tmp(8 downto 0); 
         end if;
      --Reset 
        if btnC='1' then 
            tmp <= ('0' & A) + ('0' & B);
        end if;      
    end process;
    ALU_Out <= ALU_Result; -- ALU out
    Carryout <= tmp(8); -- Carryout flag
end behavioral;
