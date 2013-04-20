LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

entity led_clock2 is
  port ( clk : in STD_LOGIC;
			 reset_n : in STD_LOGIC;
			 seg_out : OUT std_logic_vector(6 downto 0);
			 seg_out2 : OUT std_logic_vector(6 downto 0);
			 clk_out : out STD_LOGIC);
end entity led_clock2;

architecture Behavioral of led_clock2 is
signal clk_sig : std_logic;
signal num : integer;
signal num2 : integer;
type bcd_num is array (0 to 9) of std_logic_vector(6 downto 0);
signal seg_nums : bcd_num := ("1000000", --0
										"1111001", --1
										"0100100", --2
										"0110000", --3
										"0011001", --4
										"0010010", --5
										"0000011", --6
										"1111000", --7
										"0000000", --8
										"0011000"); --9

begin
process(reset_n,clk)
variable cnt : integer range 0 to 25000000;
--variable num : integer;
begin
	if (reset_n='0') then
		clk_sig<='0';
		cnt:=0;
		num<=0;
		num2<=0;
	elsif rising_edge(clk) then
		if (cnt=24999999) then
			clk_sig<=NOT(clk_sig);
			cnt:=0;
			if (num=9) then
				num<=0;
				if (num2=9) then
					num2<=0;
				else
					num2<=num2+1;
				end if;
			else
				num<=num +1;
			end if;
		else
			cnt:=cnt+1;
		end if;
	end if;
end process;

seg_out2<=seg_nums(num2);
seg_out<=seg_nums(num);
clk_out <= clk_sig;

end Behavioral;
