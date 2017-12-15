

 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
entity digi_Timer is
    Port (SCLK: IN std_logic;
			stop : IN STD_LOGIC;	
			 mode : IN STD_LOGIC;
			 RST : IN STD_LOGIC;
			 up : IN STD_LOGIC;
			 PLUSONE : IN STD_LOGIC;

    
    SET_SELECT : IN STD_LOGIC_VECTOR(1 downto 0);
   -- 6 outputs for decoder
    digitone : out std_logic_vector(3 downto 0) ;
    digittwo : out std_logic_vector(3 downto 0) ;
    digitthree : out std_logic_vector(3 downto 0);
    digitfour : out std_logic_vector(3 downto 0);
    digitfive: out std_logic_vector(3 downto 0);
    digitsix: out std_logic_vector(3 downto 0);
    digitseven: out std_logic_vector(3 downto 0);
    digiteight: out std_logic_vector(3 downto 0);
      
    
         Time_Display: out STD_LOGIC_Vector(3 downto 0)
     );
end digi_Timer;
 
architecture Behavioral of digi_Timer is
 --Clock Values
 SIGNAL s : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL s1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL m : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL m1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL h : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL h1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
  
 
 --Temporary Digits for displaying
 signal r1 : std_logic_vector(3 downto 0):= "0000";
 SIGNAL r2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL r3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL r4 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 signal r5 : std_logic_vector(3 downto 0):= "0000";
 SIGNAL r6 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL r7 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL r8 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL mode_select : integer := 0;
 SIGNAL SET : STD_LOGIC := '0';

begin
 
PROCESS_SCLK : PROCESS(SCLK, RST)
 
BEGIN
--Main Clock Code
if(rising_edge(SCLK))then
		if(SET = '0' and stop = '0') then 
			if(s < "1011") then
				s <= s + 1;
				if(s = "1001") then
					s<="0000";
					s1 <= s1 + 1;
					if(s1 = "0101") then
						m <= m + 1;
						s1 <= "0000";
						if(m = "1001") then
							m <= "0000";
							m1 <= m1 + 1;
							if(m1 =  "0101") then
								m1 <= "0000";
								h <= h + 1 ;
								if(h = "1001" ) then
									h <= "0000";
									h1 <= h1 + 1;
								elsif(h1 > "0001" and h > "0010" ) then
									h1 <= "0000";
									h <= "0000";

															
								end if;
							end if;
						end if;
					end if;
				end if;
			end if;
			elsif(SET = '1') then
			m<=r5 ;
			m1<=r6 ;
			h<=r7 ;
			h1<=r8 ;
			
			end if;
end if;
--Reset Clock
IF RST = '1' THEN
   h1<= "0000";
   h<="0000";
   m1<="0000";
   m<="0000";
   s1<="0000";
   s<="0000";
end if;
--Clock Mode
if (mode_select = 0 and SET = '0') then
 r1<="0000";
 r2<="0000";
 r3<=s;
 r4<=s1;
 r5<=m;
 r6<=m1;
 r7<=h;
 r8<=h1;
  
end if;
 
--when mode_select 0 show clock
--when mode_select 1 set clock

 
if (rising_edge(up)) then
 mode_select <= mode_select + 1 ;
end if ;
if mode_select = 2 then
   mode_select <= 0 ;
end if;
if mode_select = 1 and falling_edge(mode) then
   SET <= '1' ;
end if;
if mode_select = 0 then
   SET <= '0' ;
end if;
 
-- Set the Digit that will change in CLOCK SET Mode
if (mode_select /= 0 and mode = '1') then
    
   if (SET_SELECT = "00" and rising_edge(PLUSONE)) then
    r5 <= r5 + 1 ;
    if r5 = 9 then
     r5 <= "0000";
     end if;
   end if;
   if (SET_SELECT = "01" and rising_edge(PLUSONE)) then
    r6 <= r6 + 1 ;
    if r6 = 5 then
     r6 <= "0000";
     end if;
   end if;
   if (SET_SELECT = "10" and rising_edge(PLUSONE)) then
    r7 <= r7 + 1 ;
    if r7 = 9 OR (r8 = 2 and r7=3) then
     r7 <= "0000";
     end if;
   end if;
   if (SET_SELECT = "11" and rising_edge(PLUSONE)) then
    r8 <= r8 + 1 ;
    if r8 = 2 then
     r8 <= "0000";
     end if;
   end if;
   
  end if;
 
 
-- Showing Current Mode : Clock
if (mode_select = 1) then
  r4 <="1011"; --C
  r3 <="1101"; --l
  r2 <="1100"; --o
  r1 <="1011"; --c
end if;
 
 
END Process;
	
 Time_Display<= "0000";
  digitone <=r1 ;
  digittwo <=r2;
  digitthree <=r3 ;
  digitfour <=r4;
  digitfive <=r5;
  digitsix <=r6;
  digitseven<=r7 ;
  digiteight<=r8 ;
end Behavioral;
 
