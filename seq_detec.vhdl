Library IEEE;
use     IEEE.std_logic_1164.all;


Entity seq_detec is
	port(clk 		: in std_logic;
		 data_in 	: in std_logic;
		 rst 		: in std_logic;
		 seq_det 	: out std_logic);
end entity seq_detec;

architecture sequence_detector of seq_detec is
	type state_types is( S1, S2, S3, S4);
	signal state : state_types := S1;
begin
	seq_det <= '0';
	process (clk)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				state <= S1;
			else
				case state is
					when S1 =>
						if data_in = '1' then
							state <= S2;
							seq_det <= '0';
						elsif data_in = '0' then
							state <= S1;
							seq_det <= '0';
						end if;
					when S2=>
						if data_in = '0' then
							state <= S3;
							seq_det <= '0';
						elsif data_in = '1' then
							state <= S2;
							seq_det <= '0';
						end if;
					when S3 =>
						if data_in = '0' then
							state <= S1;
							seq_det <= '0';
						elsif data_in = '1' then
							state <= S4;
							seq_det <= '0';
						end if;
					when S4 =>
						if data_in = '1' then
							state <= S2;
							seq_det <= '0';
						elsif data_in = '0' then
							state <= S3;
							seq_det <= '1';
						end if;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process;
end architecture sequence_detector;