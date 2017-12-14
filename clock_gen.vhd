
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity HUDREDHZ_CLOCK_GENERATOR is
    Port ( MCLK : in  STD_LOGIC;
				SECONDCLK : out STD_LOGIC;
           HUNDREDHZCLOCK : out  STD_LOGIC);
			  
end HUDREDHZ_CLOCK_GENERATOR;

architecture Behavioral of HUDREDHZ_CLOCK_GENERATOR is
SIGNAL COUNTER : integer := 0;
SIGNAL COUNTERS : integer := 0;
signal temp : std_logic := '0';
signal temps: std_logic := '0';
begin

CLK_PROCESS: PROCESS(MCLK)

BEGIN
	--INCREMENT COUNTER
--	IF(MCLK'EVENT AND MCLK = '1') THEN
--		
--		IF(COUNTER < 50000) THEN
--			COUNTER <= COUNTER + 1;			
--		ELSE
--			COUNTER <= 0;
--		END IF;
--		
--		COUNTERS <= COUNTERS + 1 ;
----		IF(COUNTERS < 200000000) then
----			COUNTERS <= 0 ;
----		END IF;
--	End IF;
if rising_edge(mclk) then 
counter <= counter + 1;
if counter<50000 then 
temp <= '1';
else 
temp <= '0';
counter <= 0; 
end if ;
end if;

if rising_edge(mclk) then
counters <= counters + 1;
if counters<100000000 then 
temps <= '1';
else 
temps <= '0';
counters <= 0; 
end if; 
end if;
	
END PROCESS;
--END OF CLOCK PROCESS
												  
--HUNDREDHZCLOCK <= '1' WHEN COUNTER < 25000 ELSE '0';
--SECONDCLK <= '1' WHEN COUNTERS < 100000000 ELSE '0'; 
hundredhzclock <= temp;
secondclk <= temps ;
end Behavioral;

