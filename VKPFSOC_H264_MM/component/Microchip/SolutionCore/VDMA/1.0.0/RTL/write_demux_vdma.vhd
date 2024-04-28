--=================================================================================================
-- File Name                           : write_demux_vdma.vhd
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
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
--=================================================================================================
-- write_demux_vdma entity declaration
--=================================================================================================
entity write_demux_vdma is
  port (
--Port list
    -- system reset
    reset_i : in std_logic;

    --Mux selection output for channel selection
    mux_sel_i : in std_logic_vector(2 downto 0);

    --Acknowledge input from Write Master
    ack_i : in std_logic;

    --Done input from Write Master
    done_i : in std_logic;

    --W0 acknowledge to DDR Write controller
    w0_ack_o  : out std_logic;
    --W0 done to DDR Write controller
    w0_done_o : out std_logic;
    --W1 acknowledge to DDR Write controller
    w1_ack_o  : out std_logic;
    --W1 done to DDR Write controller
    w1_done_o : out std_logic;
    --W2 acknowledge to DDR Write controller    
    w2_ack_o  : out std_logic;
    --W2 done to DDR Write controller
    w2_done_o : out std_logic;
    --W3 acknowledge to DDR Write controller    
    w3_ack_o  : out std_logic;
    --W3 done to DDR Write controller
    w3_done_o : out std_logic;
    --W4 acknowledge to DDR Write controller    
    w4_ack_o  : out std_logic;
    --W4 done to DDR Write controller
    w4_done_o : out std_logic;
    --W5 acknowledge to DDR Write controller    
    w5_ack_o  : out std_logic;
    --W5 done to DDR Write controller
    w5_done_o : out std_logic;
    --W6 acknowledge to DDR Write controller    
    w6_ack_o  : out std_logic;
    --W6 done to DDR Write controller
    w6_done_o : out std_logic;
    --W7 acknowledge to DDR Write controller    
    w7_ack_o  : out std_logic;
    --W7 done to DDR Write controller
    w7_done_o : out std_logic


    );
end write_demux_vdma;


--=================================================================================================
-- write_demux_vdma architecture body
--=================================================================================================
architecture write_demux_vdma of write_demux_vdma is

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


--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : DEMUX_PROC
-- Description: Process to generate Iout based on enable signal
--------------------------------------------------------------------------
  DEMUX_PROC :
  process(reset_i, ack_i, done_i, mux_sel_i)
  begin
    if(reset_i = '0') then
      w0_ack_o  <= '0';
      w0_done_o <= '0';
      w1_ack_o  <= '0';
      w1_done_o <= '0';
      w2_ack_o  <= '0';
      w2_done_o <= '0';
      w3_ack_o  <= '0';
      w3_done_o <= '0';
      w4_ack_o  <= '0';
      w4_done_o <= '0';
      w5_ack_o  <= '0';
      w5_done_o <= '0';
      w6_ack_o  <= '0';
      w6_done_o <= '0';
      w7_ack_o  <= '0';
      w7_done_o <= '0';
    else
      case mux_sel_i is
        when "000" =>
          w0_ack_o  <= ack_i;
          w0_done_o <= done_i;
          w1_ack_o  <= '0';
          w1_done_o <= '0';
          w2_ack_o  <= '0';
          w2_done_o <= '0';
          w3_ack_o  <= '0';
          w3_done_o <= '0';
          w4_ack_o  <= '0';
          w4_done_o <= '0';
          w5_ack_o  <= '0';
          w5_done_o <= '0';
          w6_ack_o  <= '0';
          w6_done_o <= '0';
          w7_ack_o  <= '0';
          w7_done_o <= '0';
        when "001" =>
          w0_ack_o  <= '0';
          w0_done_o <= '0';
          w1_ack_o  <= ack_i;
          w1_done_o <= done_i;
          w2_ack_o  <= '0';
          w2_done_o <= '0';
          w3_ack_o  <= '0';
          w3_done_o <= '0';
          w4_ack_o  <= '0';
          w4_done_o <= '0';
          w5_ack_o  <= '0';
          w5_done_o <= '0';
          w6_ack_o  <= '0';
          w6_done_o <= '0';
          w7_ack_o  <= '0';
          w7_done_o <= '0';
        when "010" =>
          w0_ack_o  <= '0';
          w0_done_o <= '0';
          w1_ack_o  <= '0';
          w1_done_o <= '0';
          w2_ack_o  <= ack_i;
          w2_done_o <= done_i;
          w3_ack_o  <= '0';
          w3_done_o <= '0';
          w4_ack_o  <= '0';
          w4_done_o <= '0';
          w5_ack_o  <= '0';
          w5_done_o <= '0';
          w6_ack_o  <= '0';
          w6_done_o <= '0';
          w7_ack_o  <= '0';
          w7_done_o <= '0';
        when "011" =>
          w0_ack_o  <= '0';
          w0_done_o <= '0';
          w1_ack_o  <= '0';
          w1_done_o <= '0';
          w2_ack_o  <= '0';
          w2_done_o <= '0';
          w3_ack_o  <= ack_i;
          w3_done_o <= done_i;
          w4_ack_o  <= '0';
          w4_done_o <= '0';
          w5_ack_o  <= '0';
          w5_done_o <= '0';
          w6_ack_o  <= '0';
          w6_done_o <= '0';
          w7_ack_o  <= '0';
          w7_done_o <= '0';
        when "100" =>
          w0_ack_o  <= '0';
          w0_done_o <= '0';
          w1_ack_o  <= '0';
          w1_done_o <= '0';
          w2_ack_o  <= '0';
          w2_done_o <= '0';
          w3_ack_o  <= '0';
          w3_done_o <= '0';
          w4_ack_o  <= ack_i;
          w4_done_o <= done_i;
          w5_ack_o  <= '0';
          w5_done_o <= '0';
          w6_ack_o  <= '0';
          w6_done_o <= '0';
          w7_ack_o  <= '0';
          w7_done_o <= '0';
        when "101" =>
          w0_ack_o  <= '0';
          w0_done_o <= '0';
          w1_ack_o  <= '0';
          w1_done_o <= '0';
          w2_ack_o  <= '0';
          w2_done_o <= '0';
          w3_ack_o  <= '0';
          w3_done_o <= '0';
          w4_ack_o  <= '0';
          w4_done_o <= '0';
          w5_ack_o  <= ack_i;
          w5_done_o <= done_i;
          w6_ack_o  <= '0';
          w6_done_o <= '0';
          w7_ack_o  <= '0';
          w7_done_o <= '0';
        when "110" =>
          w0_ack_o  <= '0';
          w0_done_o <= '0';
          w1_ack_o  <= '0';
          w1_done_o <= '0';
          w2_ack_o  <= '0';
          w2_done_o <= '0';
          w3_ack_o  <= '0';
          w3_done_o <= '0';
          w4_ack_o  <= '0';
          w4_done_o <= '0';
          w5_ack_o  <= '0';
          w5_done_o <= '0';
          w6_ack_o  <= ack_i;
          w6_done_o <= done_i;
          w7_ack_o  <= '0';
          w7_done_o <= '0';
        when others =>
          w0_ack_o  <= '0';
          w0_done_o <= '0';
          w1_ack_o  <= '0';
          w1_done_o <= '0';
          w2_ack_o  <= '0';
          w2_done_o <= '0';
          w3_ack_o  <= '0';
          w3_done_o <= '0';
          w4_ack_o  <= '0';
          w4_done_o <= '0';
          w5_ack_o  <= '0';
          w5_done_o <= '0';
          w6_ack_o  <= '0';
          w6_done_o <= '0';
          w7_ack_o  <= ack_i;
          w7_done_o <= done_i;
      end case;
    end if;
  end process;
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA
end write_demux_vdma;
