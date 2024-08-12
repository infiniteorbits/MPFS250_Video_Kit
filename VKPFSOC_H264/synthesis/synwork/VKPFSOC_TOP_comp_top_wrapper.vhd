--
-- Synopsys
-- Vhdl wrapper for top level design, written on Mon Aug 12 21:32:09 2024
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity wrapper_for_read_demux is
   port (
      reset_i : in std_logic;
      mux_sel_i : in std_logic_vector(2 downto 0);
      ack_i : in std_logic;
      done_i : in std_logic;
      data_valid_i : in std_logic;
      r0_ack_o : out std_logic;
      r0_done_o : out std_logic;
      r0_data_valid_o : out std_logic;
      r1_ack_o : out std_logic;
      r1_done_o : out std_logic;
      r1_data_valid_o : out std_logic;
      r2_ack_o : out std_logic;
      r2_done_o : out std_logic;
      r2_data_valid_o : out std_logic;
      r3_ack_o : out std_logic;
      r3_done_o : out std_logic;
      r3_data_valid_o : out std_logic;
      r4_ack_o : out std_logic;
      r4_done_o : out std_logic;
      r4_data_valid_o : out std_logic;
      r5_ack_o : out std_logic;
      r5_done_o : out std_logic;
      r5_data_valid_o : out std_logic;
      r6_ack_o : out std_logic;
      r6_done_o : out std_logic;
      r6_data_valid_o : out std_logic;
      r7_ack_o : out std_logic;
      r7_done_o : out std_logic;
      r7_data_valid_o : out std_logic
   );
end wrapper_for_read_demux;

architecture read_demux of wrapper_for_read_demux is

component read_demux
 port (
   reset_i : in std_logic;
   mux_sel_i : in std_logic_vector (2 downto 0);
   ack_i : in std_logic;
   done_i : in std_logic;
   data_valid_i : in std_logic;
   r0_ack_o : out std_logic;
   r0_done_o : out std_logic;
   r0_data_valid_o : out std_logic;
   r1_ack_o : out std_logic;
   r1_done_o : out std_logic;
   r1_data_valid_o : out std_logic;
   r2_ack_o : out std_logic;
   r2_done_o : out std_logic;
   r2_data_valid_o : out std_logic;
   r3_ack_o : out std_logic;
   r3_done_o : out std_logic;
   r3_data_valid_o : out std_logic;
   r4_ack_o : out std_logic;
   r4_done_o : out std_logic;
   r4_data_valid_o : out std_logic;
   r5_ack_o : out std_logic;
   r5_done_o : out std_logic;
   r5_data_valid_o : out std_logic;
   r6_ack_o : out std_logic;
   r6_done_o : out std_logic;
   r6_data_valid_o : out std_logic;
   r7_ack_o : out std_logic;
   r7_done_o : out std_logic;
   r7_data_valid_o : out std_logic
 );
end component;

signal tmp_reset_i : std_logic;
signal tmp_mux_sel_i : std_logic_vector (2 downto 0);
signal tmp_ack_i : std_logic;
signal tmp_done_i : std_logic;
signal tmp_data_valid_i : std_logic;
signal tmp_r0_ack_o : std_logic;
signal tmp_r0_done_o : std_logic;
signal tmp_r0_data_valid_o : std_logic;
signal tmp_r1_ack_o : std_logic;
signal tmp_r1_done_o : std_logic;
signal tmp_r1_data_valid_o : std_logic;
signal tmp_r2_ack_o : std_logic;
signal tmp_r2_done_o : std_logic;
signal tmp_r2_data_valid_o : std_logic;
signal tmp_r3_ack_o : std_logic;
signal tmp_r3_done_o : std_logic;
signal tmp_r3_data_valid_o : std_logic;
signal tmp_r4_ack_o : std_logic;
signal tmp_r4_done_o : std_logic;
signal tmp_r4_data_valid_o : std_logic;
signal tmp_r5_ack_o : std_logic;
signal tmp_r5_done_o : std_logic;
signal tmp_r5_data_valid_o : std_logic;
signal tmp_r6_ack_o : std_logic;
signal tmp_r6_done_o : std_logic;
signal tmp_r6_data_valid_o : std_logic;
signal tmp_r7_ack_o : std_logic;
signal tmp_r7_done_o : std_logic;
signal tmp_r7_data_valid_o : std_logic;

begin

tmp_reset_i <= reset_i;

tmp_mux_sel_i <= mux_sel_i;

tmp_ack_i <= ack_i;

tmp_done_i <= done_i;

tmp_data_valid_i <= data_valid_i;

r0_ack_o <= tmp_r0_ack_o;

r0_done_o <= tmp_r0_done_o;

r0_data_valid_o <= tmp_r0_data_valid_o;

r1_ack_o <= tmp_r1_ack_o;

r1_done_o <= tmp_r1_done_o;

r1_data_valid_o <= tmp_r1_data_valid_o;

r2_ack_o <= tmp_r2_ack_o;

r2_done_o <= tmp_r2_done_o;

r2_data_valid_o <= tmp_r2_data_valid_o;

r3_ack_o <= tmp_r3_ack_o;

r3_done_o <= tmp_r3_done_o;

r3_data_valid_o <= tmp_r3_data_valid_o;

r4_ack_o <= tmp_r4_ack_o;

r4_done_o <= tmp_r4_done_o;

r4_data_valid_o <= tmp_r4_data_valid_o;

r5_ack_o <= tmp_r5_ack_o;

r5_done_o <= tmp_r5_done_o;

r5_data_valid_o <= tmp_r5_data_valid_o;

r6_ack_o <= tmp_r6_ack_o;

r6_done_o <= tmp_r6_done_o;

r6_data_valid_o <= tmp_r6_data_valid_o;

r7_ack_o <= tmp_r7_ack_o;

r7_done_o <= tmp_r7_done_o;

r7_data_valid_o <= tmp_r7_data_valid_o;



u1:   read_demux port map (
		reset_i => tmp_reset_i,
		mux_sel_i => tmp_mux_sel_i,
		ack_i => tmp_ack_i,
		done_i => tmp_done_i,
		data_valid_i => tmp_data_valid_i,
		r0_ack_o => tmp_r0_ack_o,
		r0_done_o => tmp_r0_done_o,
		r0_data_valid_o => tmp_r0_data_valid_o,
		r1_ack_o => tmp_r1_ack_o,
		r1_done_o => tmp_r1_done_o,
		r1_data_valid_o => tmp_r1_data_valid_o,
		r2_ack_o => tmp_r2_ack_o,
		r2_done_o => tmp_r2_done_o,
		r2_data_valid_o => tmp_r2_data_valid_o,
		r3_ack_o => tmp_r3_ack_o,
		r3_done_o => tmp_r3_done_o,
		r3_data_valid_o => tmp_r3_data_valid_o,
		r4_ack_o => tmp_r4_ack_o,
		r4_done_o => tmp_r4_done_o,
		r4_data_valid_o => tmp_r4_data_valid_o,
		r5_ack_o => tmp_r5_ack_o,
		r5_done_o => tmp_r5_done_o,
		r5_data_valid_o => tmp_r5_data_valid_o,
		r6_ack_o => tmp_r6_ack_o,
		r6_done_o => tmp_r6_done_o,
		r6_data_valid_o => tmp_r6_data_valid_o,
		r7_ack_o => tmp_r7_ack_o,
		r7_done_o => tmp_r7_done_o,
		r7_data_valid_o => tmp_r7_data_valid_o
       );
end read_demux;
