--//////////////////////////////////////////////////////////////////////////////
-- Copyright (c) 2022, Microchip Corporation
-- All rights reserved.
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
--     * Redistributions of source code must retain the above copyright
--       notice, this list of conditions and the following disclaimer.
--     * Redistributions in binary form must reproduce the above copyright
--       notice, this list of conditions and the following disclaimer in the
--       documentation and/or other materials provided with the distribution.
--     * Neither the name of the <organization> nor the
--       names of its contributors may be used to endorse or promote products
--       derived from this software without specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
-- DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-- APACHE LICENSE
-- Copyright (c) 2022, Microchip Corporation 
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--//////////////////////////////////////////////////////////////////////////////

--=================================================================================================
-- Libraries
--=================================================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";
--=================================================================================================
-- data_packer_vdma entity declaration
--=================================================================================================
entity data_packer_vdma is
  generic(
-- Generic list
    g_IP_DW : integer := 16;  -- input data width should be powers of 2
    g_OP_DW : integer := 64             -- output data width 
    );
  port(
-- Port list
    -- System reset
    video_source_clk_rstn_i : in std_logic;

    -- System clock
    video_source_clk_i : in std_logic;

    -- enable
    data_valid_i : in std_logic;

    --Frame end input
    frame_start_i : in std_logic;

    -- Data Input
    data_i : in std_logic_vector(g_IP_DW-1 downto 0);

    -- Data Enable
    data_valid_o : out std_logic;
    -- Frame end output
    frame_end_o  : out std_logic;

    -- Data output
    data_o : out std_logic_vector(g_OP_DW-1 downto 0)

    );
end data_packer_vdma;

--=================================================================================================
-- data_packer_vdma  architecture body
--=================================================================================================

architecture data_packer_vdma of data_packer_vdma is

--=================================================================================================
-- Component declarations
--=================================================================================================
--NA--
--=================================================================================================
-- Synthesis Attributes
--=================================================================================================
--NA--
--=================================================================================================
-- Signal declarations
--=================================================================================================
  constant C_MC                  : integer := g_OP_DW / g_IP_DW;  --max count
  constant C_CW                  : integer := integer(ceil(log2(real(C_MC))));  --counter width
  constant C_MAX_WLEN            : integer := 32;  --max burst length/ number of data valids
  type DATA_ARRAY is array (0 to C_MC-1) of std_logic_vector(g_IP_DW-1 downto 0);
  signal s_data_arr              : DATA_ARRAY;
  signal s_counter               : std_logic_vector(C_CW-1 downto 0);  -- input data count
  signal s_data_pack             : std_logic_vector(g_OP_DW-1 downto 0);
  signal s_frame_start_sr        : std_logic_vector(15 downto 0);
  signal s_frame_start_re        : std_logic;
  signal s_frame_start_re_dly    : std_logic;
  signal s_buf_wr_done_dly1      : std_logic;
  signal s_buf_wr_done_dly2      : std_logic;
  signal s_data_valid_out        : std_logic;
  signal s_ones                  : std_logic_vector(C_CW-1 downto 0);
  signal s_frame_start_stretcher : std_logic_vector(3 downto 0);

begin

--=================================================================================================
-- Top level output port assignments
--=================================================================================================
  data_o       <= s_data_pack;
  data_valid_o <= s_data_valid_out;
  
--=================================================================================================
-- Generate blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : GENERATE_DATA_PACK
-- Description: data packing
--------------------------------------------------------------------------  
  GENERATE_DATA_PACK : for I in 0 to C_MC-1 generate
    s_data_pack(g_IP_DW*(I+1)-1 downto g_IP_DW*I) <= s_data_arr(I);
    DATA_PACK_PROC :
    process(VIDEO_SOURCE_CLK_I, VIDEO_SOURCE_CLK_RSTN_I)
    begin
      if (VIDEO_SOURCE_CLK_RSTN_I = '0') then
        s_data_arr(I) <= (others => '0');
      elsif rising_edge(VIDEO_SOURCE_CLK_I) then
        if(data_valid_i = '1' and s_counter = 0) then
          if (I > 0) then
            s_data_arr(I) <= (others => '0');
          else
            s_data_arr(I) <= data_i;
          end if;
        elsif(data_valid_i = '1' and s_counter = I) then
          s_data_arr(I) <= data_i;
        end if;
      end if;
    end process;
  end generate GENERATE_DATA_PACK;
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
  s_frame_start_re <= s_frame_start_sr(14) and not(s_frame_start_sr(15));
  s_ones           <= (others => '1');
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : DELAY
-- Description: Process delays input signals
--------------------------------------------------------------------------
  DELAY :
  process(VIDEO_SOURCE_CLK_I, VIDEO_SOURCE_CLK_RSTN_I)
  begin
    if VIDEO_SOURCE_CLK_RSTN_I = '0' then
      s_frame_start_sr     <= (others => '0');
      s_frame_start_re_dly <= '0';
      frame_end_o <= '0';
    elsif rising_edge(VIDEO_SOURCE_CLK_I) then
      s_frame_start_sr     <= s_frame_start_sr(14 downto 0) & frame_start_i;
      s_frame_start_re_dly <= s_frame_start_re;
      frame_end_o  <= s_frame_start_stretcher(0) or s_frame_start_stretcher(1) or
                 s_frame_start_stretcher(2) or s_frame_start_stretcher(3);
    end if;
  end process;

--------------------------------------------------------------------------
-- Name       : DATA_COUNTER
-- Description: Counter to count data
--------------------------------------------------------------------------
  DATA_COUNTER :
  process(VIDEO_SOURCE_CLK_I, VIDEO_SOURCE_CLK_RSTN_I)
  begin
    if VIDEO_SOURCE_CLK_RSTN_I = '0' then
      s_counter <= (others => '0');
    elsif rising_edge(VIDEO_SOURCE_CLK_I) then
      if(data_valid_i = '1')then
        s_counter <= s_counter + '1';
      elsif (s_frame_start_re = '1') then
        s_counter <= (others => '0');
      end if;
    end if;
  end process;

--------------------------------------------------------------------------
-- Name       : DATA_VALID
-- Description: Process to generate data valid output
--------------------------------------------------------------------------
  DATA_VALID :
  process(VIDEO_SOURCE_CLK_I, VIDEO_SOURCE_CLK_RSTN_I)
  begin
    if VIDEO_SOURCE_CLK_RSTN_I = '0' then
      s_data_valid_out <= '0';
    elsif rising_edge(VIDEO_SOURCE_CLK_I) then
      if ((data_valid_i = '1' and s_counter = s_ones) or
          (s_frame_start_re = '1' and s_counter /= 0)) then
        s_data_valid_out <= '1';
      else
        s_data_valid_out <= '0';
      end if;
    end if;
  end process;

--------------------------------------------------------------------------
-- Name       : Frame End pulse stretcher
-- Description: Stretching the frame end pulse to 4 cycles
--------------------------------------------------------------------------
  pulse_stretcher_fe_p :
  process(VIDEO_SOURCE_CLK_I, VIDEO_SOURCE_CLK_RSTN_I)
  begin
    if VIDEO_SOURCE_CLK_RSTN_I = '0' then
      s_frame_start_stretcher <= (others => '0');
    elsif rising_edge(VIDEO_SOURCE_CLK_I) then
      s_frame_start_stretcher(0) <= s_frame_start_re_dly;
      s_frame_start_stretcher(1) <= s_frame_start_stretcher(0);
      s_frame_start_stretcher(2) <= s_frame_start_stretcher(1);
      s_frame_start_stretcher(3) <= s_frame_start_stretcher(2);
    end if;
  end process;



--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
end data_packer_vdma;
