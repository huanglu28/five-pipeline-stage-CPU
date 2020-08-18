---- 读写寄存器
--LIBRARY ieee;
--USE ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
--use STD.TEXTIO.ALL;
--use IEEE.STD_LOGIC_TEXTIO.ALL;
--use work.constants.all;
--
--entity ram_pc is
--port(clk:in std_logic;
--	  addr:in std_logic_vector(pcLength downto 0);
--	  data:in std_logic_vector(instrucLength downto 0);
--	  wr,rd:in std_logic; -- 0-read 1-write;
--	  q:out std_logic_vector(instrucLength downto 0));
--end ram_pc;
--
--architecture exp of ram_pc is
--type t_ram is array(pcLength downto 0) of std_logic_vector(instrucLength downto 0);
--begin
--process(clk,wr)
--file filein : text;
--variable buf : LINE;
--variable fstatus : FILE_OPEN_STATUS;
--
--variable ramdata:t_ram;
--variable temp_data:std_logic_vector(instrucLength downto 0);
--begin
--if rising_edge(clk) then
--	if rd='1' then  --read
--		temp_data:=ramdata(conv_integer(addr));
--		q<=temp_data;
--	elsif wr='1' then
--		temp_data:=data;
--		ramdata(conv_integer(addr)):=temp_data;
--	else
--		null;
--	end if;
--end if;
--end process;
--end architecture;

---- 读写寄存器
--LIBRARY ieee;
--USE ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
--use work.constants.all;
--
--use std.testio.all;
--use ieee.std_logic_textio
--
--entity ram is
--port(clk:in std_logic;
--	  addr:in std_logic_vector(addrLength downto 0);
--	  data:in std_logic_vector(wordLength downto 0);
--	  wr,rd:in std_logic; -- 0-read 1-write;
--	  q:out std_logic_vector(wordLength downto 0));
--end ram;
--
--architecture exp of ram is
--type t_ram is array(addrLength downto 0) of std_logic_vector(wordLength downto 0);
--begin
--process(clk,wr)
--variable ramdata:t_ram;
--variable temp_data:std_logic_vector(wordLength downto 0);
--begin
--if rising_edge(clk) then
--	if rd='1' then  --read
--		temp_data:=ramdata(conv_integer(addr));
--		q<=temp_data;
--	elsif wr='1' then
--		temp_data:=data;
--		ramdata(conv_integer(addr)):=temp_data;
--	else
--		null;
--	end if;
--end if;
--end process;
--end architecture;
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY ram_pc IS
	PORT
	(
		addr		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clk		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rd  	: IN STD_LOGIC  := '1';
		wr		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
END ram_pc;


ARCHITECTURE SYN OF ram_pc IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN
	q    <= sub_wire0(15 DOWNTO 0);

	altsyncram_component : altsyncram
	GENERIC MAP (
		clock_enable_input_a => "BYPASS",
		clock_enable_output_a => "BYPASS",
		init_file => "pcdata.mif",
		intended_device_family => "Cyclone IV E",
		lpm_hint => "ENABLE_RUNTIME_MOD=YES,INSTANCE_NAME=NONE",
		lpm_type => "altsyncram",
		numwords_a => 256,
		operation_mode => "SINGLE_PORT",
		outdata_aclr_a => "NONE",
		outdata_reg_a => "CLOCK0",
		power_up_uninitialized => "FALSE",
		read_during_write_mode_port_a => "NEW_DATA_NO_NBE_READ",
		widthad_a => 8,
		width_a => 16,
		width_byteena_a => 1
	)
	PORT MAP (
		address_a => addr,
		clock0 => clk,
		data_a => data,
		rden_a => rd,
		wren_a => wr,
		q_a => sub_wire0
	);



END SYN;