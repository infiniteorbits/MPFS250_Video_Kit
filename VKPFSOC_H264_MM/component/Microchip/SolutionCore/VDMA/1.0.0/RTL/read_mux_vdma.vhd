--=================================================================================================
-- File Name                           : read_mux_vdma.vhd
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
library IEEE;
use IEEE.STD_LOGIC_1164.all;
--USE IEEE.NUMERIC_STD.ALL;
--USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--=================================================================================================
-- read_mux_vdma entity declaration
--=================================================================================================
entity read_mux_vdma is
  generic(
    --Address width
    g_ADDR_WIDTH : in integer range 0 to 64 := 32;

    --Burst size width
    g_BURST_SIZE_WIDTH : in integer range 0 to 8 := 8
    );
  port (
--Port list
    --Mux selection output for channel selection
    mux_sel_i : in std_logic_vector(2 downto 0);

    --R0 burst size
    r0_burst_size_i  : in std_logic_vector(g_BURST_SIZE_WIDTH-1 downto 0);
    --R0 write start address
    r0_rstart_addr_i : in std_logic_vector(g_ADDR_WIDTH-1 downto 0);

    --R1 burst size
    r1_burst_size_i  : in std_logic_vector(g_BURST_SIZE_WIDTH-1 downto 0);
    --R1 write start address
    r1_rstart_addr_i : in std_logic_vector(g_ADDR_WIDTH-1 downto 0);

    --R2 burst size
    r2_burst_size_i  : in std_logic_vector(g_BURST_SIZE_WIDTH-1 downto 0);
    --R2 write start address
    r2_rstart_addr_i : in std_logic_vector(g_ADDR_WIDTH-1 downto 0);

    --R3 burst size
    r3_burst_size_i  : in std_logic_vector(g_BURST_SIZE_WIDTH-1 downto 0);
    --R3 write start address
    r3_rstart_addr_i : in std_logic_vector(g_ADDR_WIDTH-1 downto 0);

    --R4 burst size
    r4_burst_size_i  : in std_logic_vector(g_BURST_SIZE_WIDTH-1 downto 0);
    --R4 write start address
    r4_rstart_addr_i : in std_logic_vector(g_ADDR_WIDTH-1 downto 0);

    --R5 burst size
    r5_burst_size_i  : in std_logic_vector(g_BURST_SIZE_WIDTH-1 downto 0);
    --R5 write start address
    r5_rstart_addr_i : in std_logic_vector(g_ADDR_WIDTH-1 downto 0);

    --R6 burst size
    r6_burst_size_i  : in std_logic_vector(g_BURST_SIZE_WIDTH-1 downto 0);
    --R6 write start address
    r6_rstart_addr_i : in std_logic_vector(g_ADDR_WIDTH-1 downto 0);

    --R7 burst size
    r7_burst_size_i  : in std_logic_vector(g_BURST_SIZE_WIDTH-1 downto 0);
    --R7 write start address
    r7_rstart_addr_i : in std_logic_vector(g_ADDR_WIDTH-1 downto 0);

    --Burst size
    burst_size_o  : out std_logic_vector(g_BURST_SIZE_WIDTH-1 downto 0);
    --Read start address
    rstart_addr_o : out std_logic_vector(g_ADDR_WIDTH-1 downto 0)



    );
end read_mux_vdma;


--=================================================================================================
-- read_mux_vdma architecture body
--=================================================================================================
architecture read_mux_vdma of read_mux_vdma is

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


begin
--=================================================================================================
-- Top level output port assignments
--=================================================================================================

  burst_size_o <= r0_burst_size_i when mux_sel_i = "000" else
                  r1_burst_size_i when mux_sel_i = "001" else
                  r2_burst_size_i when mux_sel_i = "010" else
                  r3_burst_size_i when mux_sel_i = "011" else
                  r4_burst_size_i when mux_sel_i = "100" else
                  r5_burst_size_i when mux_sel_i = "101" else
                  r6_burst_size_i when mux_sel_i = "110" else
                  r7_burst_size_i;

  rstart_addr_o <= r0_rstart_addr_i when mux_sel_i = "000" else
                   r1_rstart_addr_i when mux_sel_i = "001" else
                   r2_rstart_addr_i when mux_sel_i = "010" else
                   r3_rstart_addr_i when mux_sel_i = "011" else
                   r4_rstart_addr_i when mux_sel_i = "100" else
                   r5_rstart_addr_i when mux_sel_i = "101" else
                   r6_rstart_addr_i when mux_sel_i = "110" else
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
end read_mux_vdma;
