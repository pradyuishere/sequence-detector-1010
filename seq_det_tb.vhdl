Library IEEE;

use 	IEEE.std_logic_1164.all;

Entity seq_det_tb is
end seq_det_tb;

Architecture test of seq_det_tb is

Component seq_detec is
	port(clk 		: in std_logic;
		 data_in 	: in std_logic;
		 rst 		: in std_logic;
		 seq_det 	: out std_logic);
end Component seq_detec;

signal  clk 		: std_logic;
signal  data_in 	: std_logic;
signal  rst 		: std_logic;
signal  seq_det 	: std_logic;
signal  test_seq	: std_logic_vector(31 downto 0) := "11111010010111011010110011101001";
signal  i 			: integer range 0 to 31;

begin 
	SQD : seq_detec port map (clk, data_in, rst, seq_det);
tb_process : process
begin
	clk <= '0';
	wait for 5 ns;
  
	clk <= '1';
	if(i = 31) then
		i <= 0;
	else
		i <= i + 1;
	end if;
	data_in <= test_seq(i);
	wait for 5 ns;
  
end process;
end test;

configuration config_tb of seq_det_tb is
	for test
		for SQD : seq_detec
			use entity work.seq_detec(sequence_detector);
		end for;
	end for;
end config_tb;