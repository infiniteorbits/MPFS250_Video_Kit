--*****************************************************************************************************************************
--
--    File Name    : RGBtoYCbCr_tb.v 

--    Description  : This module provides the test environment for RGBtoYCbCr IP.
--					 For more details visit Microsemi Video Web Page. 

-- Targeted device : Microsemi-SoC                     
-- Author          : India Solutions Team

-- SVN Revision Information:
-- SVN $Revision: TBD
-- SVN $Date: TBD
--
--
--
-- COPYRIGHT 2020 BY MICROSEMI 
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS 
-- FROM MICROSEMI CORP.  IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM 
-- MICROSEMI FOR USE OF THIS FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND 
-- NO BACK-UP OF THE FILE SHOULD BE MADE. 
-- 

--****************************************************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;  

entity RGBtoYCbCr_tb is
end RGBtoYCbCr_tb;

architecture behavioral of RGBtoYCbCr_tb is

    constant SYSCLK_PERIOD : time := 10 ns; -- 10MHZ
-----------------------------------------------------------
-- Core parameters
-----------------------------------------------------------
	constant G_RGB_DATA_BIT_WIDTH : INTEGER := 8;
    constant G_YCbCr_DATA_BIT_WIDTH : INTEGER := 8;
	
	signal SYSCLK         : STD_LOGIC := '0';
	signal NSYSRESET      : STD_LOGIC := '0';
	signal s_r_counter	  : STD_LOGIC_VECTOR (7 DOWNTO 0);
	signal s_g_counter   : STD_LOGIC_VECTOR (7 DOWNTO 0);
	signal s_b_counter   : STD_LOGIC_VECTOR (7 DOWNTO 0);
	signal DATA_VALID_O	  : STD_LOGIC;
	signal Y_OUT_O		  : STD_LOGIC_VECTOR ((G_YCbCr_DATA_BIT_WIDTH - 1) DOWNTO 0);
	signal Cb_OUT_O		  : STD_LOGIC_VECTOR ((G_YCbCr_DATA_BIT_WIDTH - 1) DOWNTO 0);
	signal Cr_OUT_O		  : STD_LOGIC_VECTOR ((G_YCbCr_DATA_BIT_WIDTH - 1) DOWNTO 0);
	signal DATA_VALID_I	  : STD_LOGIC;
	signal RED_I		  : STD_LOGIC_VECTOR ((G_RGB_DATA_BIT_WIDTH - 1) DOWNTO 0):=x"00";
	signal GREEN_I		  : STD_LOGIC_VECTOR ((G_RGB_DATA_BIT_WIDTH - 1) DOWNTO 0):=x"0A";
	signal BLUE_I		  : STD_LOGIC_VECTOR ((G_RGB_DATA_BIT_WIDTH - 1) DOWNTO 0):=x"14";
	
	    COMPONENT RGB2YCbCr 
	GENERIC(
		G_RGB_DATA_BIT_WIDTH : INTEGER := 8;                                                                        
		G_YCbCr_DATA_BIT_WIDTH : INTEGER := 8                                                                         
		);
		PORT (                                                                                                        
			CLOCK_I         				: IN STD_LOGIC;
			RESET_N_I       				: IN STD_LOGIC;
			DATA_VALID_I   					: IN STD_LOGIC;
			RED_I           				: IN STD_LOGIC_VECTOR ((G_RGB_DATA_BIT_WIDTH - 1) DOWNTO 0);  
			GREEN_I         				: IN STD_LOGIC_VECTOR ((G_RGB_DATA_BIT_WIDTH - 1) DOWNTO 0);   
			BLUE_I          				: IN STD_LOGIC_VECTOR ((G_RGB_DATA_BIT_WIDTH - 1) DOWNTO 0); 
			Y_OUT_O							: OUT STD_LOGIC_VECTOR ((G_YCbCr_DATA_BIT_WIDTH - 1) DOWNTO 0);
			Cb_OUT_O						: OUT STD_LOGIC_VECTOR ((G_YCbCr_DATA_BIT_WIDTH - 1) DOWNTO 0);  
            Cr_OUT_O						: OUT STD_LOGIC_VECTOR  ((G_YCbCr_DATA_BIT_WIDTH - 1) DOWNTO 0);    
			DATA_VALID_O 					: OUT STD_LOGIC
		);
		END COMPONENT;
	
begin
	-- clock driver
	SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );
PROCESS
BEGIN
	NSYSRESET <= '0';
	WAIT FOR(SYSCLK_PERIOD * 9);
	NSYSRESET <= '1';
	WAIT;
END PROCESS;

-----------------------------------------------------------
-- Input data from counters
-----------------------------------------------------------
R_COUNTER:
	PROCESS(SYSCLK,NSYSRESET)
	BEGIN
		IF NSYSRESET = '0' THEN
			s_r_counter <= (OTHERS=>'0');
		ELSIF rising_edge(SYSCLK) THEN
			IF(NSYSRESET = '1') THEN
				s_r_counter <= s_r_counter + '1';
			ELSE
				s_r_counter <= (OTHERS=>'0');
			END IF;
		END IF;
	END PROCESS;
	
G_COUNTER:
	PROCESS(SYSCLK,NSYSRESET)
	BEGIN
		IF NSYSRESET = '0' THEN
			s_g_counter <= x"0A";
		ELSIF rising_edge(SYSCLK) THEN
			IF(NSYSRESET = '1') THEN
				s_g_counter <= s_g_counter + '1';
			ELSE
				s_g_counter <= (OTHERS=>'0');
			END IF;
		END IF;
	END PROCESS;
	
B_COUNTER:
	PROCESS(SYSCLK,NSYSRESET)
	BEGIN
		IF NSYSRESET = '0' THEN
			s_b_counter <= x"14";
		ELSIF rising_edge(SYSCLK) THEN
			IF(NSYSRESET = '1') THEN
				s_b_counter <= s_b_counter + '1';
			ELSE
				s_b_counter <= (OTHERS=>'0');
			END IF;
		END IF;
	END PROCESS;
	
PROCESS
BEGIN
	DATA_VALID_I <= '0';
	WAIT FOR(SYSCLK_PERIOD * 10);
	DATA_VALID_I <= '1';
	WAIT FOR(SYSCLK_PERIOD * 40);
	DATA_VALID_I <= '0';
	WAIT;
END PROCESS;

-- Instantiate Unit Under Test:  test
test_RGBtoYCbCr : RGB2YCbCr
	generic map(G_RGB_DATA_BIT_WIDTH 	=> G_RGB_DATA_BIT_WIDTH,
			    G_YCbCr_DATA_BIT_WIDTH 	=> G_YCbCr_DATA_BIT_WIDTH
				)
	port map(
			CLOCK_I     	=> SYSCLK,
            RESET_N_I   	=> NSYSRESET,
            RED_I			=> s_r_counter,			
            GREEN_I			=> s_g_counter,
			BLUE_I			=> s_b_counter,
            DATA_VALID_I	=> DATA_VALID_I,
			Y_OUT_O			=> Y_OUT_O,
			Cb_OUT_O		=> Cb_OUT_O,
			Cr_OUT_O		=> Cr_OUT_O,
            DATA_VALID_O	=> DATA_VALID_O
			);
			
end behavioral;