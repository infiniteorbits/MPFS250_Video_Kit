--=================================================================================================
-- File Name                           : read_mux.vhd


-- Targeted device                     : Microsemi-SoC
-- Author                              : India Solutions Team
--

-- COPYRIGHT 2019 BY MICROSEMI
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--
--=================================================================================================

--=================================================================================================
-- Libraries
--=================================================================================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.NUMERIC_STD.ALL;
--USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--=================================================================================================
-- read_mux entity declaration
--=================================================================================================
ENTITY read_mux IS
GENERIC(     
        --Address width
		g_ADDR_WIDTH					: IN INTEGER RANGE 0 TO 64	:= 32;
        
        --Burst size width
        g_BURST_SIZE_WIDTH              : IN INTEGER RANGE 0 TO 8  := 8
   );
PORT (
--Port list
	--Mux selection output for channel selection
	mux_sel_i							: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	
	--R0 burst size
    r0_burst_size_i	                    : IN STD_LOGIC_VECTOR(g_BURST_SIZE_WIDTH-1 DOWNTO 0);
	--R0 write start address
    r0_rstart_addr_i	                : IN STD_LOGIC_VECTOR(g_ADDR_WIDTH-1 DOWNTO 0);

	--R1 burst size
    r1_burst_size_i	                    : IN STD_LOGIC_VECTOR(g_BURST_SIZE_WIDTH-1 DOWNTO 0);
	--R1 write start address
    r1_rstart_addr_i	                : IN STD_LOGIC_VECTOR(g_ADDR_WIDTH-1 DOWNTO 0);

	--R2 burst size
    r2_burst_size_i	                    : IN STD_LOGIC_VECTOR(g_BURST_SIZE_WIDTH-1 DOWNTO 0);
	--R2 write start address
    r2_rstart_addr_i	                : IN STD_LOGIC_VECTOR(g_ADDR_WIDTH-1 DOWNTO 0);

	--R3 burst size
    r3_burst_size_i	                    : IN STD_LOGIC_VECTOR(g_BURST_SIZE_WIDTH-1 DOWNTO 0);
	--R3 write start address
    r3_rstart_addr_i	                : IN STD_LOGIC_VECTOR(g_ADDR_WIDTH-1 DOWNTO 0);

	--R4 burst size
    r4_burst_size_i	                    : IN STD_LOGIC_VECTOR(g_BURST_SIZE_WIDTH-1 DOWNTO 0);
	--R4 write start address
    r4_rstart_addr_i	                : IN STD_LOGIC_VECTOR(g_ADDR_WIDTH-1 DOWNTO 0);

	--R5 burst size
    r5_burst_size_i	                    : IN STD_LOGIC_VECTOR(g_BURST_SIZE_WIDTH-1 DOWNTO 0);
	--R5 write start address
    r5_rstart_addr_i	                : IN STD_LOGIC_VECTOR(g_ADDR_WIDTH-1 DOWNTO 0);

	--R6 burst size
    r6_burst_size_i	                    : IN STD_LOGIC_VECTOR(g_BURST_SIZE_WIDTH-1 DOWNTO 0);
	--R6 write start address
    r6_rstart_addr_i	                : IN STD_LOGIC_VECTOR(g_ADDR_WIDTH-1 DOWNTO 0);

	--R7 burst size
    r7_burst_size_i	                    : IN STD_LOGIC_VECTOR(g_BURST_SIZE_WIDTH-1 DOWNTO 0);
	--R7 write start address
    r7_rstart_addr_i	                : IN STD_LOGIC_VECTOR(g_ADDR_WIDTH-1 DOWNTO 0);

	--Burst size
    burst_size_o	                    : OUT STD_LOGIC_VECTOR(g_BURST_SIZE_WIDTH-1 DOWNTO 0);
	--Read start address
    rstart_addr_o	                	: OUT STD_LOGIC_VECTOR(g_ADDR_WIDTH-1 DOWNTO 0)

		

);
END read_mux;


--=================================================================================================
-- read_mux architecture body
--=================================================================================================
ARCHITECTURE read_mux OF read_mux IS

--=================================================================================================
-- Component declarations
--=================================================================================================

--=================================================================================================
-- Synthesis Attributes
--=================================================================================================
--NA--
--=================================================================================================
-- Signal declarations
--=================================================================================================


BEGIN
--=================================================================================================
-- Top level output port assignments
--=================================================================================================

burst_size_o	<= 	r0_burst_size_i	WHEN mux_sel_i = "000" ELSE
					r1_burst_size_i	WHEN mux_sel_i = "001" ELSE
					r2_burst_size_i	WHEN mux_sel_i = "010" ELSE
					r3_burst_size_i	WHEN mux_sel_i = "011" ELSE
					r4_burst_size_i	WHEN mux_sel_i = "100" ELSE
					r5_burst_size_i WHEN mux_sel_i = "101" ELSE
					r6_burst_size_i WHEN mux_sel_i = "110" ELSE
					r7_burst_size_i;
					
rstart_addr_o	<= 	r0_rstart_addr_i	WHEN mux_sel_i = "000" ELSE
					r1_rstart_addr_i	WHEN mux_sel_i = "001" ELSE
					r2_rstart_addr_i	WHEN mux_sel_i = "010" ELSE
					r3_rstart_addr_i	WHEN mux_sel_i = "011" ELSE
					r4_rstart_addr_i	WHEN mux_sel_i = "100" ELSE
					r5_rstart_addr_i    WHEN mux_sel_i = "101" ELSE
					r6_rstart_addr_i    WHEN mux_sel_i = "110" ELSE
					r7_rstart_addr_i;
					
--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
--NA
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA
END read_mux;