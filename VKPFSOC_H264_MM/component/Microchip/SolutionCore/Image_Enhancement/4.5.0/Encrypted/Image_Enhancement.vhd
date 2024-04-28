--=================================================================================================
-- File Name                           : Image_Enhancement.vhd
-- Description                         : Supporting both Native mode and AXI4 Stream mode
-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2022 BY MICROSEMI
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROCHIP
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROCHIP FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--
--=================================================================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

package memory_map_image_enhancement is

  constant ADDR_DECODER_WIDTH : natural range 8 to 32                           := 8;
  constant IP_VER             : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"00";  --Read only
  constant C_CTRL_REG         : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"04";  --Read write
  constant C_R_CONSTANT       : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"08";  --Write only
  constant C_G_CONSTANT       : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"0c";  --Write only
  constant C_B_CONSTANT       : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"10";  --Write only
  constant C_SECOND_CONSTANT  : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"14";  --Write only
  constant C_RGB_AVG          : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"18";  --Read only

end package memory_map_image_enhancement;



--=================================================================================================
-- Libraries
--=================================================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use work.memory_map_image_enhancement.all;

--=================================================================================================
-- Image_Enhancement entity declaration
--=================================================================================================

entity Image_Enhancement is
  generic(
-- Generic List
    -- Specifies the data width
    G_PIXEL_WIDTH     : integer range 8 to 16      := 8;
    G_PIXELS          : integer                    := 1;  --  1= one pixel and 4= 4pixels (4k)
    G_FORMAT          : integer range 0 to 1       := 0;  --  0= Native and 1= Image_Enhancement with AXI Stream
    G_RCONST          : natural range 0 to 1023    := 146;
    G_GCONST          : natural range 0 to 1023    := 122;
    G_BCONST          : natural range 0 to 1023    := 165;
    G_COMMON_CONSTANT : natural range 0 to 1048575 := 1046528
    );
  port (
-- Port List
    RESETN_I      : in std_logic;       -- System reset
    SYS_CLK_I     : in std_logic;       -- System clock
    DATA_VALID_I  : in std_logic;  -- Specifies the input data is valid or not
    FRAME_START_I : in std_logic;
    R_I           : in std_logic_vector (G_PIXELS*G_PIXEL_WIDTH - 1 downto 0);  -- data input
    G_I           : in std_logic_vector (G_PIXELS*G_PIXEL_WIDTH - 1 downto 0);
    B_I           : in std_logic_vector (G_PIXELS*G_PIXEL_WIDTH - 1 downto 0);

    ACLK_I    : in  std_logic;
    ARESETN_I : in  std_logic;
    awvalid   : in  std_logic;
    awready   : out std_logic;
    awaddr    : in  std_logic_vector(31 downto 0);
    wdata     : in  std_logic_vector(31 downto 0);
    wvalid    : in  std_logic;
    wready    : out std_logic;
    bresp     : out std_logic_vector(1 downto 0);
    bvalid    : out std_logic;
    bready    : in  std_logic;
    araddr    : in  std_logic_vector(31 downto 0);
    arvalid   : in  std_logic;
    arready   : out std_logic;
    rready    : in  std_logic;
    rdata     : out std_logic_vector(31 downto 0);
    rresp     : out std_logic_vector(1 downto 0);
    rvalid    : out std_logic;

    -- Filtered Output 
    --DATA_O : out std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
    DATA_VALID_O : out std_logic;       -- Specifies the valid RGB data
    Y_AVG_O      : out std_logic_vector(31 downto 0);
    R_O          : out std_logic_vector(G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
    G_O          : out std_logic_vector(G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
    B_O          : out std_logic_vector(G_PIXELS*G_PIXEL_WIDTH-1 downto 0);

    TDATA_I  : in  std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
    TVALID_I : in  std_logic;
    TREADY_O : out std_logic;
    TUSER_I  : in  std_logic_vector(3 downto 0);
    -- Data output from MASTER1
    TDATA_O  : out std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
    TLAST_O  : out std_logic;
    TUSER_O  : out std_logic_vector(3 downto 0);
    -- Specifies the valid control signal from MASTER1
    TVALID_O : out std_logic;
    TSTRB_O  : out std_logic_vector(G_PIXEL_WIDTH/8 - 1 downto 0);
    TKEEP_O  : out std_logic_vector(G_PIXEL_WIDTH/8 - 1 downto 0)
    );
end Image_Enhancement;

--=================================================================================================
-- Image_Enhancement architecture body
--=================================================================================================
architecture Image_Enhancement_arch of Image_Enhancement is
--=================================================================================================
-- Component declarations
--=================================================================================================
  component Image_Enhancement_Native
    generic(
      G_PIXEL_WIDTH : integer range 8 to 16 := 8
      );
    port (
      SYS_CLK_I      : in  std_logic;
      RESETN_I       : in  std_logic;
      DATA_VALID_I   : in  std_logic;
      ENABLE_I       : in  std_logic;
      DATA_I         : in  std_logic_vector ((3*G_PIXEL_WIDTH - 1) downto 0);
      R_CONST_I      : in  std_logic_vector(9 downto 0);
      G_CONST_I      : in  std_logic_vector(9 downto 0);
      B_CONST_I      : in  std_logic_vector(9 downto 0);
      COMMON_CONST_I : in  std_logic_vector(19 downto 0);
      DATA_O         : out std_logic_vector ((3*G_PIXEL_WIDTH - 1) downto 0);
      DATA_VALID_O   : out std_logic
      );
  end component;

  component Image_Enhancement_4k
    generic(
      G_PIXEL_WIDTH : integer range 8 to 16 := 8;
      G_PIXELS      : integer               := 4
      );
    port (
      SYS_CLK_I      : in  std_logic;
      RESETN_I       : in  std_logic;
      DATA_VALID_I   : in  std_logic;
      ENABLE_I       : in  std_logic;
      DATA_I         : in  std_logic_vector ((3*G_PIXELS*G_PIXEL_WIDTH - 1) downto 0);
      R_CONST_I      : in  std_logic_vector(9 downto 0);
      G_CONST_I      : in  std_logic_vector(9 downto 0);
      B_CONST_I      : in  std_logic_vector(9 downto 0);
      COMMON_CONST_I : in  std_logic_vector(19 downto 0);
      DATA_O         : out std_logic_vector ((3*G_PIXELS*G_PIXEL_WIDTH - 1) downto 0);
      DATA_VALID_O   : out std_logic
      );
  end component;

  component AXI4S_INITIATOR_IE
    generic(
      G_PIXEL_WIDTH : integer range 8 to 96 := 8;
      G_PIXELS      : integer               := 1
      );
    port (
      RESETN_I     : in  std_logic;
      SYS_CLK_I    : in  std_logic;
      DATA_I       : in  std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
      DATA_VALID_I : in  std_logic;
      EOF_I        : in  std_logic;
      TDATA_O      : out std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
      TSTRB_O      : out std_logic_vector(G_PIXEL_WIDTH/8 - 1 downto 0);
      TKEEP_O      : out std_logic_vector(G_PIXEL_WIDTH/8 - 1 downto 0);
      TLAST_O      : out std_logic;
      TUSER_O      : out std_logic_vector(3 downto 0);
      TVALID_O     : out std_logic
      );
  end component;

  component AXI4S_TARGET_IE
    generic(
      G_PIXEL_WIDTH : integer range 8 to 96 := 8;
      G_PIXELS      : integer               := 1
      );
    port (
      TDATA_I      : in  std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
      TUSER_I      : in  std_logic_vector(3 downto 0);
      TREADY_O     : out std_logic;
      TVALID_I     : in  std_logic;
      EOF_O        : out std_logic;
      DATA_O       : out std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
      DATA_VALID_O : out std_logic
      );
  end component;


  component axi4lite_if_ie is
    generic (
      G_RCONST          : natural;
      G_GCONST          : natural;
      G_BCONST          : natural;
      G_COMMON_CONSTANT : natural
      );
    port (
      --Clock and reset interface
      ACLK_I    : in  std_logic;
      ARESETN_I : in  std_logic;
      --write address channel
      awvalid   : in  std_logic;
      awready   : out std_logic;
      awaddr    : in  std_logic_vector(31 downto 0);
      --write data channel
      wdata     : in  std_logic_vector(31 downto 0);
      wvalid    : in  std_logic;
      wready    : out std_logic;
      -- write response channel
      bresp     : out std_logic_vector(1 downto 0);
      bvalid    : out std_logic;
      bready    : in  std_logic;
      -- Read address channel
      araddr    : in  std_logic_vector(31 downto 0);
      arvalid   : in  std_logic;
      arready   : out std_logic;
      -- Read data and response channel
      rready    : in  std_logic;
      rdata     : out std_logic_vector(31 downto 0);
      rresp     : out std_logic_vector(1 downto 0);
      rvalid    : out std_logic;

      --Image Enhancement input/output
      rgb_avg                   : in  std_logic_vector(31 downto 0);
      image_enhancement_ip_en   : out std_logic;
      image_enhancement_ip_rstn : out std_logic;
      r_constant                : out std_logic_vector(9 downto 0);
      g_constant                : out std_logic_vector(9 downto 0);
      b_constant                : out std_logic_vector(9 downto 0);
      second_constant           : out std_logic_vector(19 downto 0)
      );

  end component axi4lite_if_ie;


  component intensity_average is
    generic(
      G_PIXEL_WIDTH : integer range 8 to 16 := 8;
      G_PIXELS      : integer range 1 to 4  := 1
      );
    port (
      RESETN_I      : in  std_logic;
      SYS_CLK_I     : in  std_logic;
      data_valid_i  : in  std_logic;
      frame_start_i : in  std_logic;
      r_i           : in  std_logic_vector (G_PIXELS*G_PIXEL_WIDTH - 1 downto 0);  -- data input
      g_i           : in  std_logic_vector (G_PIXELS*G_PIXEL_WIDTH - 1 downto 0);
      b_i           : in  std_logic_vector (G_PIXELS*G_PIXEL_WIDTH - 1 downto 0);
      y_avg         : out std_logic_vector(31 downto 0)
      );
  end component intensity_average;


--=================================================================================================
-- Synthesis Attributes
--=================================================================================================
--NA--
--=================================================================================================
-- Constant declarations
--=================================================================================================
--NA--
--=================================================================================================
-- Signal declarations
--=================================================================================================
  signal s_eof                       : std_logic;
  signal s_dvalid_slv                : std_logic;
  signal s_dvalid_mstr               : std_logic;
  signal s_data_in                   : std_logic_vector (3*G_PIXELS*G_PIXEL_WIDTH - 1 downto 0);
  signal s_data_i_4k                 : std_logic_vector (3*G_PIXELS*G_PIXEL_WIDTH - 1 downto 0);
  signal s_data_axi                  : std_logic_vector (3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
  signal s_data_4k_axi               : std_logic_vector (3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
  signal s_data_i                    : std_logic_vector (3*G_PIXELS*G_PIXEL_WIDTH - 1 downto 0);
  signal s_data_o                    : std_logic_vector (3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
  signal s_image_enhancement_ip_en   : std_logic;
  signal s_image_enhancement_ip_rstn : std_logic;
  signal s_r_constant                : std_logic_vector(9 downto 0);
  signal s_g_constant                : std_logic_vector(9 downto 0);
  signal s_b_constant                : std_logic_vector(9 downto 0);
  signal s_second_constant           : std_logic_vector(19 downto 0);
  signal s_resetn                    : std_logic;
  signal s_rgb_avg                   : std_logic_vector(31 downto 0);

begin
--=================================================================================================
-- Top level output port assignments
--=================================================================================================
  R_O      <= s_data_o((3*G_PIXELS*G_PIXEL_WIDTH - 1) downto (2*G_PIXELS*G_PIXEL_WIDTH));
  G_O      <= s_data_o((2*G_PIXELS*G_PIXEL_WIDTH - 1) downto (G_PIXELS*G_PIXEL_WIDTH));
  B_O      <= s_data_o((G_PIXELS*G_PIXEL_WIDTH - 1) downto 0);
  Y_AVG_O  <= s_rgb_avg;
--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
  s_data_i <= R_I & G_I & B_I;
  s_resetn <= (not s_image_enhancement_ip_rstn) and RESETN_I;
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--NA--  
--=================================================================================================
-- Component Instantiations
--=================================================================================================

  intensity_average_inst : intensity_average
    generic map (
      G_PIXEL_WIDTH => G_PIXEL_WIDTH,
      G_PIXELS      => G_PIXELS
      )
    port map (
      RESETN_I      => RESETN_I,
      SYS_CLK_I     => SYS_CLK_I,
      DATA_VALID_I  => DATA_VALID_I,
      FRAME_START_I => FRAME_START_I,
      R_I           => R_I,
      G_I           => G_I,
      B_I           => B_I,
      Y_AVG         => s_rgb_avg);


  axi4lite_if_ie_inst : axi4lite_if_ie
    generic map (
      G_RCONST          => G_RCONST,
      G_GCONST          => G_GCONST,
      G_BCONST          => G_BCONST,
      G_COMMON_CONSTANT => G_COMMON_CONSTANT)
    port map (
      ACLK_I                    => ACLK_I,
      ARESETN_I                 => ARESETN_I,
      awvalid                   => awvalid,
      awready                   => awready,
      awaddr                    => awaddr,
      wdata                     => wdata,
      wvalid                    => wvalid,
      wready                    => wready,
      bresp                     => bresp,
      bvalid                    => bvalid,
      bready                    => bready,
      araddr                    => araddr,
      arvalid                   => arvalid,
      arready                   => arready,
      rready                    => rready,
      rdata                     => rdata,
      rresp                     => rresp,
      rvalid                    => rvalid,
      rgb_avg                   => s_rgb_avg,
      image_enhancement_ip_en   => s_image_enhancement_ip_en,
      image_enhancement_ip_rstn => s_image_enhancement_ip_rstn,
      r_constant                => s_r_constant,
      g_constant                => s_g_constant,
      b_constant                => s_b_constant,
      second_constant           => s_second_constant);

  IE_1p_AXI4S_AXI4L_FORMAT : if G_PIXELS = 1 and G_FORMAT = 1 generate
    Image_Enhancement_AXI4S_AXI4L_INST : Image_Enhancement_Native
      generic map(
        G_PIXEL_WIDTH => G_PIXEL_WIDTH
        )
      port map(
        SYS_CLK_I      => SYS_CLK_I,
        RESETN_I       => s_resetn,
        DATA_VALID_I   => s_dvalid_slv,
        ENABLE_I       => s_image_enhancement_ip_en,
        DATA_I         => s_data_in,
        R_CONST_I      => s_r_constant,
        G_CONST_I      => s_g_constant,
        B_CONST_I      => s_b_constant,
        COMMON_CONST_I => s_second_constant,
        DATA_O         => s_data_axi,
        DATA_VALID_O   => s_dvalid_mstr
        );

    Image_Enhancement_AXI4S_TAR_INST : AXI4S_TARGET_IE
      generic map(
        G_PIXEL_WIDTH => G_PIXEL_WIDTH,
        G_PIXELS      => G_PIXELS
        )
      port map(
        TVALID_I     => TVALID_I,
        TDATA_I      => TDATA_I,
        TUSER_I      => TUSER_I,
        TREADY_O     => TREADY_O,
        EOF_O        => s_eof,
        DATA_VALID_O => s_dvalid_slv,
        DATA_O       => s_data_in
        );

    Image_Enhancement_AXI4S_INIT_INST : AXI4S_INITIATOR_IE
      generic map(
        G_PIXEL_WIDTH => G_PIXEL_WIDTH,
        G_PIXELS      => G_PIXELS
        )
      port map(
        SYS_CLK_I    => SYS_CLK_I,
        RESETN_I     => RESETN_I,
        EOF_I        => s_eof,
        DATA_VALID_I => s_dvalid_mstr,
        DATA_I       => s_data_axi,
        TUSER_O      => TUSER_O,
        TLAST_O      => TLAST_O,
        TSTRB_O      => TSTRB_O,
        TKEEP_O      => TKEEP_O,
        TVALID_O     => TVALID_O,
        TDATA_O      => TDATA_O
        );

  end generate;

  IE_1p_AXI4L_Native_FORMAT : if G_PIXELS = 1 and G_FORMAT = 0 generate
    Image_Enhancement_AXI4L_Native_INST : Image_Enhancement_Native
      generic map(
        G_PIXEL_WIDTH => G_PIXEL_WIDTH
        )
      port map(
        SYS_CLK_I      => SYS_CLK_I,
        RESETN_I       => s_resetn,
        DATA_VALID_I   => DATA_VALID_I,
        ENABLE_I       => s_image_enhancement_ip_en,
        DATA_I         => s_data_i,
        R_CONST_I      => s_r_constant,
        G_CONST_I      => s_g_constant,
        B_CONST_I      => s_b_constant,
        COMMON_CONST_I => s_second_constant,
        DATA_O         => s_data_o,
        DATA_VALID_O   => DATA_VALID_O
        );
  end generate;


  IE_4k_AXI4S_AXI4L_FORMAT : if G_PIXELS = 4 and G_FORMAT = 1 generate
    Image_Enhancement_4p_AXI4S_AXI4L_INST : Image_Enhancement_4k
      generic map(
        G_PIXEL_WIDTH => G_PIXEL_WIDTH,
        G_PIXELS      => G_PIXELS
        )
      port map(
        SYS_CLK_I      => SYS_CLK_I,
        RESETN_I       => RESETN_I,
        DATA_VALID_I   => s_dvalid_slv,
        ENABLE_I       => s_image_enhancement_ip_en,
        DATA_I         => s_data_i_4k,
        R_CONST_I      => s_r_constant,
        G_CONST_I      => s_g_constant,
        B_CONST_I      => s_b_constant,
        COMMON_CONST_I => s_second_constant,
        DATA_O         => s_data_4k_axi,
        DATA_VALID_O   => s_dvalid_mstr
        );

    Image_Enhancement_AXI4S_TAR_4k_INST : AXI4S_TARGET_IE
      generic map(
        G_PIXEL_WIDTH => G_PIXEL_WIDTH,
        G_PIXELS      => G_PIXELS
        )
      port map(
        TVALID_I     => TVALID_I,
        TDATA_I      => TDATA_I,
        TUSER_I      => TUSER_I,
        TREADY_O     => TREADY_O,
        EOF_O        => s_eof,
        DATA_VALID_O => s_dvalid_slv,
        DATA_O       => s_data_i_4k
        );

    Image_Enhancement_AXI4S_INIT_4k_INST : AXI4S_INITIATOR_IE
      generic map(
        G_PIXEL_WIDTH => G_PIXEL_WIDTH,
        G_PIXELS      => G_PIXELS
        )
      port map(
        SYS_CLK_I    => SYS_CLK_I,
        RESETN_I     => RESETN_I,
        EOF_I        => s_eof,
        DATA_VALID_I => s_dvalid_mstr,
        DATA_I       => s_data_4k_axi,
        TUSER_O      => TUSER_O,
        TLAST_O      => TLAST_O,
        TSTRB_O      => TSTRB_O,
        TKEEP_O      => TKEEP_O,
        TVALID_O     => TVALID_O,
        TDATA_O      => TDATA_O
        );

  end generate;

  IE_4k_Native_AXI4L_FORMAT : if G_PIXELS = 4 and G_FORMAT = 0 generate
    Image_Enhancement_4p_Native_AXI4L_INST : Image_Enhancement_4k
      generic map(
        G_PIXEL_WIDTH => G_PIXEL_WIDTH,
        G_PIXELS      => G_PIXELS
        )
      port map(
        SYS_CLK_I      => SYS_CLK_I,
        RESETN_I       => RESETN_I,
        DATA_VALID_I   => DATA_VALID_I,
        ENABLE_I       => s_image_enhancement_ip_en,
        DATA_I         => s_data_i,
        R_CONST_I      => s_r_constant,
        G_CONST_I      => s_g_constant,
        B_CONST_I      => s_b_constant,
        COMMON_CONST_I => s_second_constant,
        DATA_O         => s_data_o,
        DATA_VALID_O   => DATA_VALID_O
        );
  end generate;

end Image_Enhancement_arch;

--=================================================================================================
-- File Name                           : Image_Enhancement_Native.vhd
-- Description                         : This module implements brightness, contrast and colour balance.
-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2018 BY MICROCHIP
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROCHIP
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROCHIP FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--
--=================================================================================================

--=================================================================================================
-- Libraries
--=================================================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_SIGNED.all;

--=================================================================================================
-- Image_Enhancement_Native entity declaration
--=================================================================================================
entity Image_Enhancement_Native is
  generic(
-- Generic List
    -- Specifies the bit width of each pixel
    G_PIXEL_WIDTH : integer := 8
    );
  port(
-- Port list
    -- System reset
    RESETN_I : in std_logic;

    -- System clock
    SYS_CLK_I : in std_logic;

    --Data valid        
    DATA_VALID_I : in std_logic;

    --Enable input
    ENABLE_I : in std_logic;

    -- Channel 1 data
    DATA_I : in std_logic_vector(3*G_PIXEL_WIDTH-1 downto 0);

    --R-constant input
    R_CONST_I : in std_logic_vector(9 downto 0);

    --G-constant input
    G_CONST_I : in std_logic_vector(9 downto 0);

    --B-constant input
    B_CONST_I : in std_logic_vector(9 downto 0);


    --Second constant input
    COMMON_CONST_I : in std_logic_vector(19 downto 0);

    --Output valid
    DATA_VALID_O : out std_logic;

    -- Alpha blended output
    DATA_O : out std_logic_vector(3*G_PIXEL_WIDTH-1 downto 0)

    );
end Image_Enhancement_Native;

`protect begin_protected
`protect version=1
`protect author="author-a", author_info="author-a-details"
`protect encrypt_agent="encryptP1735.pl", encrypt_agent_info="Synplify encryption scripts"

`protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=256)
`protect key_block
ZUBwJfGxWusIl+fp7Rp9ewkGhCDjdsDtiiph0NpIQQcFAAyqlPjGbem9TF5TP6cpmzdsPCnV7Vbz
Ljm79TkPwZSoipj68C+TuTqShJ3JMI8Qe1/J/icJwEAn16rrw16qibq4xRXI1zWZm+iukP9xYxeV
5XbEIzN0nXTW6iUo849PJp7NfZ8DRA6Y80LIuGa1/crwhdKVfF5RdldzvYBUWH/sT2HCuzqUYF6j
4yFI3EIx1PfDWvLW5FHPjAYhyAWQeLF7GEvI5b1iwbjT/ef6rWT90cz/Hq/YuCx62ZWQaMjM+323
eTkeIXuQYa6DOB+b7TmbzgCjtqz3ZpFTXhDg8A==

`protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=128)
`protect key_block
Ih0b23Cfi1VI5K08GILxUCn2nkFGbpiV31nO30N8myesHSpBPc+NrKq6TTFLV9ei34bZsdUz/Ra7
OAcDCgkJSwUrxiQRk8s30mZfli919V2cKqDsXvyVSLHn2zcDi3Lv03JgsAItE1KWqiV+dxE8U5nd
ZimkjsPccvG9aCZHSDI=

`protect key_keyowner="Microsemi Corporation", key_keyname="MSC-IP-KEY-RSA", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=960)
`protect key_block
SK+79J04WQLEB0hcsBiKyodjK3xjJ6ZowCyNSv+9OVixJFTvKfiKMb7syHhUuKe3IA+ptOUVnD4l
lL4hS2hIzR0lN3/b1OeCQXDHtZTQ+Y45VgnESmMnjjKzuNswpqUyCW2BqZoD71t3JQLQD0adT1KO
/zkAOlxXvFqLMD5rQdB+qSjryj0xGWEHT3KAzjIYVw0N/gmSRMuGz8bnYQwraejoP5/kZv0jCcsp
fOilLXrWgjALp/8p8tN3GqEVO4mQQT6cEAPVGhY3RAKB4PzNVTch6xAAStBcOElqWmLahg5CK5l8
Mg04RCFkdPpOVRk5Rpsw18bHsOd17R88qiLzIa+1s6fRwHHwGEVDSGX5iP3eNvAiP208hEaR5av5
r/w4WE5bMu9A26bHX2kOqUVTEF7d94VBoO17k4XTVnOiuNzsYqoNrNxD+0WsQkwDZUBYKKkI3fvL
3l59NwQXuu7EQJYF9E6n9Yd9ltfQNCzXnR/jB1NQsGdPwvjqya7vo6mcvZCangVKptxAi11fhAQK
B3HJmmqdUKk/3V6zGEq2zaMzGIFhtRFG2fB3TcYhU9DtViYlp+itbNFVK8W7NCqmf63cc2t1RjA0
Nr4+LEFstPEI2jetROyZZ/6qyZVCkflMuKzEJzBe8qbhu8v/FerssDEIA7teB57IDg2URD+PLtSW
DIRT+1lXdk3YoVky5S/foI8rgld7dmqfZxIAN71PeK/G4iP5C8abP2KfqyKuzydv/EKyliYaUQe5
j3BqiDJ0MdBTtejMXGah8sITaEywfLTTOOsw5ZC8nobbrV2WNCPywKIG6t9tTzZaFDPe48pBVfog
Nxe6oDvouOzcsgr3h4/kO7CBfVpL1gSv9wYcVYmNAHKsjUQqeo/mafrEYdX5hHM3MSop1fDXn6Y6
tm09Muli9v+oFNM2kQrhwEnNpi66RAEPPxiBjanHbMuEE4gU5X6WvvpmYtz8vzG+YLxxnYPRAx/y
UQ//AMLKJPYPwqekEDBG6xC+4RThtXCqvJ1U4I60B30FBNGVvVyZtI1SCGV0NYxRIojeBveWoXso
fXkh82cU06iqMs1ZisKdVApK3EQ+ByTSsfdq78tqX5p3HDHtUXIuj7H+pgaktkIGCFcKjxgvQKWE
1rlZeup6VjY4w2rdnpI/7jK9WYujPnMnbZaULOtidBTjEc9CnJg5tSU9QbN4wMSaFzUHRBpUJdaq
v2isBNBL3mzCyvfT4VBATbXm+H7MTN73KagcQZVybDFILx8lmBaDW4KAY33dcNan

`protect data_keyowner="ip-vendor-a", data_keyname="fpga-ip", data_method="aes128-cbc"
`protect encoding=(enctype="base64", line_length=76, bytes=24624)
`protect data_block
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

`protect end_protected

-- ********************************************************************/ 
-- Microchip Corporation Proprietary and Confidential 
-- Copyright 2020 Microchip Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE MICROCHIP LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
-- Revision Information:        1.0
-- Date:                                    01/22/2020
-- Description:  AXI4 Streaming Template for synchronous operation
-- This template assume entire system and AXI4 Streaming Bus use the same clock
-- Cross-clock domain handling or back pressure features are NOT supported
--      ** AXI4 Streaming Interface **
--      ACLK_I            All signals are synchronous to this clock
--      ARESETN_I         Asynchronous active low reset
--      TDATA           Frame data is transmitted on this bus
--      TVALID          Indicates that the source is ready to send data
--      TREADY          Indicates that the sink is ready to accept data
--      TLAST           Indicates End-of-Frame
--      TID             Needed for switch
--      TDEST           Needed for switch
--      TUSER           Reserved for SOF etc
--
--      ** AXI4 Lite Interface (Configuration) **
--      ** Not Defined ** 
--      
--      Questions / Open Action Items:
--      AXI4 Lite interface needs to be defined for control signals
--
-- Limitations:
--  TID, TDEST, TKEEP, TSTRB not supported              
--
-- Recommendations:
--              
-- Update History:
--              12/07 - Interface defined
--              12/10 - Initial version
--              01/04 - Update for sync interface
--      01/22 - Update for TUSER support                                
-- SVN Revision Information:
-- SVN $Revision: $
-- SVN $Date: $
-- Resolved SARs
-- SAR      Date     Who   Description
-- *********************************************************************/ 

--=================================================================================================
-- Libraries
--=================================================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
--=================================================================================================
-- AXI4S_MSTR entity declaration
--=================================================================================================
-- Takes native video interface data and converts to AXI4S
entity AXI4S_INITIATOR_IE is
  generic(
-- Generic List
    -- Specifies the R, G, B pixel data width
    G_PIXEL_WIDTH : integer range 8 to 96 := 8;

    G_PIXELS : integer := 1
    );
  port (
-- Port List   
    RESETN_I : in std_logic;

    SYS_CLK_I : in std_logic;
    -- R, G, B Data Input
    DATA_I    : in std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);

    EOF_I : in std_logic;

    -- Specifies the input data is valid or not
    DATA_VALID_I : in std_logic;

    TUSER_O : out std_logic_vector(3 downto 0);

    TLAST_O : out std_logic;

    -- Data input
    TDATA_O : out std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);

    TSTRB_O : out std_logic_vector(G_PIXEL_WIDTH/8 - 1 downto 0);

    TKEEP_O  : out std_logic_vector(G_PIXEL_WIDTH/8 - 1 downto 0);
    -- Specifies the valid control signal
    TVALID_O : out std_logic

    );
end AXI4S_INITIATOR_IE;
--=================================================================================================
-- Architecture body
--=================================================================================================
architecture AXI4S_INITIATOR_IE of AXI4S_INITIATOR_IE is
--=================================================================================================
-- Component declarations
--=================================================================================================
--NA--
--=================================================================================================
-- Signal declarations
--=================================================================================================     
  signal s_tvalid_fe       : std_logic;
  signal s_data_valid_dly1 : std_logic;
  signal s_eof_dly1        : std_logic;
  signal s_data_dly1       : std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
begin
--=================================================================================================
-- Top level port assignments
--=================================================================================================
  TDATA_O             <= s_data_dly1;
  TVALID_O            <= s_data_valid_dly1;
  TLAST_O             <= s_tvalid_fe;
  TUSER_O(0)          <= s_eof_dly1;
  TUSER_O(3 downto 1) <= (others => '0');
  TSTRB_O             <= (others => '1');
  TKEEP_O             <= (others => '1');
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
  s_tvalid_fe         <= s_data_valid_dly1 and not(DATA_VALID_I);
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : SIGNAL_DELAY
-- Description: Process to delay signal and find rising edge
--------------------------------------------------------------------------
  SIGNAL_DELAY :
  process(SYS_CLK_I, RESETN_I)
  begin
    if (RESETN_I = '0') then
      s_eof_dly1        <= '0';
      s_data_valid_dly1 <= '0';
      s_data_dly1       <= (others => '0');
    elsif rising_edge(SYS_CLK_I) then
      s_data_dly1       <= DATA_I;
      s_data_valid_dly1 <= DATA_VALID_I;
      s_eof_dly1        <= EOF_I;
    end if;
  end process;
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
end AXI4S_INITIATOR_IE;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
--=================================================================================================
-- AXI4S_SLAVE entity declaration
--=================================================================================================
-- Takes AXI4S and converts to native video interface data
entity AXI4S_TARGET_IE is
  generic(
-- Generic List
    -- Specifies the R, G, B pixel data width
    G_PIXEL_WIDTH : integer range 8 to 96 := 8;

    G_PIXELS : integer := 1
    );
  port (
-- Port List 
    -- Data input
    TDATA_I : in std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);

    -- Specifies the valid control signal
    TVALID_I : in std_logic;

    TUSER_I : in std_logic_vector(3 downto 0);

    TREADY_O : out std_logic;

    EOF_O : out std_logic;

    -- R, G, B Data Output
    DATA_O : out std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);

    -- Specifies the output data is valid or not
    DATA_VALID_O : out std_logic

    );
end AXI4S_TARGET_IE;
--=================================================================================================
-- Architecture body
--=================================================================================================
architecture AXI4S_TARGET_IE of AXI4S_TARGET_IE is
--=================================================================================================
-- Component declarations
--=================================================================================================
--NA--
--=================================================================================================
-- Signal declarations
--=================================================================================================     
--NA--
begin
--=================================================================================================
-- Top level port assignments
--=================================================================================================
  DATA_O       <= TDATA_I;
  DATA_VALID_O <= TVALID_I;
  EOF_O        <= TUSER_I(0);
  TREADY_O     <= '1';
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
end AXI4S_TARGET_IE;



-- *************************************************************************************************
-- File Name                           : axi4lite_adapter_image_enhancement.vhd
-- Targeted device                     : Microsemi-SoC
-- Author                              : India Solutions Team
-- COPYRIGHT 2021 BY MICROSEMI
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--*************************************************************************************************

library IEEE;
use IEEE.std_logic_1164.all;

entity axi4lite_adapter_image_enhancement is
  port (
    --Clock and reset interface
    ACLK_I       : in  std_logic;
    ARESETN_I    : in  std_logic;
    --write address channel
    awvalid      : in  std_logic;
    awready      : out std_logic;
    awaddr       : in  std_logic_vector(31 downto 0);
    --write data channel
    wdata        : in  std_logic_vector(31 downto 0);
    wvalid       : in  std_logic;
    wready       : out std_logic;
    -- write response channel
    bresp        : out std_logic_vector(1 downto 0);
    bvalid       : out std_logic;
    bready       : in  std_logic;
    -- Read address channel
    araddr       : in  std_logic_vector(31 downto 0);
    arvalid      : in  std_logic;
    arready      : out std_logic;
    -- Read data and response channel
    rready       : in  std_logic;
    rdata        : out std_logic_vector(31 downto 0);
    rresp        : out std_logic_vector(1 downto 0);
    rvalid       : out std_logic;
    --Memory interface
    mem_wr_valid : out std_logic;
    mem_wr_addr  : out std_logic_vector(31 downto 0);
    mem_wr_data  : out std_logic_vector(31 downto 0);
    mem_rd_addr  : out std_logic_vector(31 downto 0);
    mem_rd_data  : in  std_logic_vector(31 downto 0));

end entity axi4lite_adapter_image_enhancement;

architecture axi4lite_adapter_image_enhancement_arch of axi4lite_adapter_image_enhancement is

  signal s_awaddr        : std_logic_vector(31 downto 0);
  signal s_araddr        : std_logic_vector(31 downto 0);
  signal s_raddr_phs_cmp : std_logic;


begin  -- architecture axi4lite_adapter_image_enhancement_arch

-------------------------------------------------------------------------------
-- AXI4 Lite Address Channel
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- AWREADY generation
-------------------------------------------------------------------------------
  -- purpose: Generating AWREADY signal
  -- type   : sequential
  -- inputs : ACLK_I, ARESETN_I, bvalid, bready, awvalid, awready
  -- outputs: awready
  awrdy_p : process (ACLK_I, ARESETN_I) is
  begin  -- process awrdy_p
    if ARESETN_I = '0' then             -- asynchronous reset (active low)
      awready <= '1';
    elsif ACLK_I'event and ACLK_I = '1' then  -- rising clock edge
      if bvalid = '1' and bready = '1' then
        awready <= '1';
      elsif awvalid = '1' and awready = '1' then
        awready <= '0';
      end if;
    end if;
  end process awrdy_p;


  -- purpose: AWADDR generation
  -- type   : sequential
  -- inputs : ACLK_I, ARESETN_I, awvalid
  -- outputs: s_awaddr
  awaddr_p : process (ACLK_I, ARESETN_I) is
  begin  -- process awaddr_p
    if ARESETN_I = '0' then             -- asynchronous reset (active low)
      s_awaddr <= (others => '0');
    elsif ACLK_I'event and ACLK_I = '1' then  -- rising clock edge
      if awvalid = '1' and awready = '1' then
        s_awaddr <= awaddr;
      end if;
    end if;
  end process awaddr_p;

-------------------------------------------------------------------------------
-- AXI4 Lite Write Data Channel
-------------------------------------------------------------------------------

-- purpose: WREADY generation
-- type   : sequential
-- inputs : ACLK_I, ARESETN_I, wvalid, wready, awvalid, awready
-- outputs: wready
  wready_p : process (ACLK_I, ARESETN_I) is
  begin  -- process wready_p
    if ARESETN_I = '0' then             -- asynchronous reset (active low)
      wready <= '0';
    elsif ACLK_I'event and ACLK_I = '1' then  -- rising clock edge
      if wvalid = '1' and wready = '1' then
        wready <= '0';
      elsif awvalid = '1' and awready = '1' then
        wready <= '1';
      end if;
    end if;
  end process wready_p;



-------------------------------------------------------------------------------
-- Writing the memory with valid data
-------------------------------------------------------------------------------
  mem_wr_addr  <= s_awaddr;
  mem_wr_data  <= wdata;
  mem_wr_valid <= '1' when (wvalid = '1' and wready = '1') else
                  '0';


  -----------------------------------------------------------------------------
  -- AXI4 Lite Write Response Channel
  -----------------------------------------------------------------------------

  -- purpose: BVALID generation
  -- type   : sequential
  -- inputs : ACLK_I, ARESETN_I, wvalid, wready, bready
  -- outputs: bvalid
  process_p : process (ACLK_I, ARESETN_I) is
  begin  -- process process_p
    if ARESETN_I = '0' then             -- asynchronous reset (active low)
      bvalid <= '0';
    elsif ACLK_I'event and ACLK_I = '1' then  -- rising clock edge
      if bvalid = '1' and bready = '1' then
        bvalid <= '0';
      elsif wvalid = '1'and wready = '1' then
        bvalid <= '1';
      end if;
    end if;
  end process process_p;


  -----------------------------------------------------------------------------
  -- Giving OK response for all strobe and protection conditions
  -----------------------------------------------------------------------------
  bresp <= (others => '0');

-------------------------------------------------------------------------------
-- AXI4 Lite Read address channel
-------------------------------------------------------------------------------

  -- purpose: arready
  -- type   : sequential
  -- inputs : ACLK_I, ARESETN_I, rvalid, rready, s_raddr_phs_cmp
  -- outputs: arready
  arready_p : process (ACLK_I, ARESETN_I) is
  begin  -- process arready_p
    if ARESETN_I = '0' then             -- asynchronous reset (active low)
      arready <= '1';
    elsif ACLK_I'event and ACLK_I = '1' then  -- rising clock edge
      if rvalid = '1' and rready = '1' then
        arready <= '1';
      elsif s_raddr_phs_cmp = '1' then
        arready <= '0';
      end if;
    end if;
  end process arready_p;

  -----------------------------------------------------------------------------
  -- RADDR_PHS_CMP generation
  -----------------------------------------------------------------------------
  s_raddr_phs_cmp <= arvalid and arready;


  -----------------------------------------------------------------------------
  -- Registering valid read address
  -----------------------------------------------------------------------------
  -- purpose: Registering valid read address
  -- type   : sequential
  -- inputs : ACLK_I, ARESETN_I, arvalid, arready
  -- outputs: s_araddr
  araddr_p : process (ACLK_I, ARESETN_I) is
  begin  -- process araddr_p
    if ARESETN_I = '0' then             -- asynchronous reset (active low)
      s_araddr <= (others => '0');
    elsif ACLK_I'event and ACLK_I = '1' then  -- rising clock edge
      if arvalid = '1' and arready = '1' then
        s_araddr <= araddr;
      end if;
    end if;
  end process araddr_p;

  mem_rd_addr <= s_araddr;


  -----------------------------------------------------------------------------
  -- AXI4 Lite Read Data Channel
  -----------------------------------------------------------------------------

  -- purpose: RVALID generation
  -- type   : sequential
  -- inputs : ACLK_I, ARESETN_I, arvalid, arready, rvalid, rready
  -- outputs: rvalid
  rvalid_p : process (ACLK_I, ARESETN_I) is
  begin  -- process rvalid_p
    if ARESETN_I = '0' then             -- asynchronous reset (active low)
      rvalid <= '0';
    elsif ACLK_I'event and ACLK_I = '1' then  -- rising clock edge
      if arvalid = '1' and arready = '1' then
        rvalid <= '1';
      elsif rvalid = '1' and rready = '1' then
        rvalid <= '0';
      end if;
    end if;
  end process rvalid_p;

  rdata <= mem_rd_data;  --connecting the mem data directly to the axi4 lite bus
  rresp <= (others => '0');

end architecture axi4lite_adapter_image_enhancement_arch;


--*************************************************************************************************
-- File Name                           : write_reg_image_enhancement.vhd
-- Targeted device                     : Microsemi-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2021 BY MICROSEMI
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--
--*************************************************************************************************
library ieee;
use ieee.std_logic_1164.all;
use work.memory_map_image_enhancement.all;
use ieee.numeric_std.all;


entity write_reg_image_enhancement is
  generic (
    G_RCONST          : natural range 0 to 1023    := 146;
    G_GCONST          : natural range 0 to 1023    := 122;
    G_BCONST          : natural range 0 to 1023    := 165;
    G_COMMON_CONSTANT : natural range 0 to 1048575 := 1046528
    );
  port (
    ACLK_I                    : in  std_logic;
    ARESETN_I                 : in  std_logic;
    mem_wr_valid              : in  std_logic;
    mem_wr_addr               : in  std_logic_vector(31 downto 0);
    mem_wr_data               : in  std_logic_vector(31 downto 0);
    image_enhancement_ip_en   : out std_logic;
    image_enhancement_ip_rstn : out std_logic;
    r_constant                : out std_logic_vector(9 downto 0);
    g_constant                : out std_logic_vector(9 downto 0);
    b_constant                : out std_logic_vector(9 downto 0);
    second_constant           : out std_logic_vector(19 downto 0)
    );

end entity write_reg_image_enhancement;

architecture write_reg_image_enhancement_arch of write_reg_image_enhancement is

begin  -- architecture write_reg_image_enhancement_arch

  image_enhancement_ip_rstn <= mem_wr_data(1)
                               when (mem_wr_addr(ADDR_DECODER_WIDTH-1 downto 0) = C_CTRL_REG and mem_wr_valid = '1') else
                               '0';

  -----------------------------------------------------------------------------
  -- Write registers
  -----------------------------------------------------------------------------

  -- purpose: Write registers
  -- type   : sequential
  -- inputs : ACLK_I, ARESETN_I, mem_wr_valid
  -- outputs: 
  write_p : process (ACLK_I, ARESETN_I) is
  begin  -- process write_p
    if ARESETN_I = '0' then             -- asynchronous reset (active low)
      image_enhancement_ip_en <= '1';
      r_constant              <= std_logic_vector(to_unsigned(G_RCONST, 10));
      g_constant              <= std_logic_vector(to_unsigned(G_GCONST, 10));
      b_constant              <= std_logic_vector(to_unsigned(G_BCONST, 10));
      second_constant         <= std_logic_vector(to_unsigned(G_COMMON_CONSTANT, 20));
    elsif ACLK_I'event and ACLK_I = '1' then  -- rising clock edge
      if mem_wr_valid = '1' then

        case mem_wr_addr(ADDR_DECODER_WIDTH-1 downto 0) is

          when C_CTRL_REG =>
            image_enhancement_ip_en <= mem_wr_data(0) and (not mem_wr_data(1));

          when C_R_CONSTANT =>
            r_constant <= mem_wr_data(9 downto 0);

          when C_G_CONSTANT =>
            g_constant <= mem_wr_data(9 downto 0);

          when C_B_CONSTANT =>
            b_constant <= mem_wr_data(9 downto 0);

          when C_SECOND_CONSTANT =>
            second_constant <= mem_wr_data(19 downto 0);

          when others => null;
        end case;
      end if;
    end if;
  end process write_p;

end architecture write_reg_image_enhancement_arch;


--*************************************************************************************************
-- File Name                           : read_reg_image_enhancement.vhd
-- Targeted device                     : Microsemi-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2021 BY MICROSEMI
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--
--*************************************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use work.memory_map_image_enhancement.all;
use ieee.numeric_std.all;

entity read_reg_image_enhancement is
  port (
    mem_rd_addr : in  std_logic_vector(31 downto 0);
    mem_rd_data : out std_logic_vector(31 downto 0);
    ctrl_reg    : in  std_logic_vector(1 downto 0);
    rgb_avg     : in  std_logic_vector(31 downto 0)
    );

end entity read_reg_image_enhancement;


architecture read_reg_image_enhancement_arch of read_reg_image_enhancement is

begin  -- architecture read_reg_image_enhancement_arch

  -----------------------------------------------------------------------------
  -- Read registers
  -----------------------------------------------------------------------------

-- purpose: Reading the registers
-- type   : combinational
-- inputs : mem_rd_addr[ADDR_DECODER_WIDTH-1:0]
-- outputs: mem_rd_data
  read_p : process (mem_rd_addr(ADDR_DECODER_WIDTH-1 downto 0)) is
  begin  -- process read_p
    case mem_rd_addr(ADDR_DECODER_WIDTH-1 downto 0) is

      when IP_VER =>
        mem_rd_data(31 downto 24) <= x"00";
        mem_rd_data(23 downto 16) <= x"04";
        mem_rd_data(15 downto 8)  <= x"05";
        mem_rd_data(7 downto 0)   <= x"00";

      when C_CTRL_REG =>
        mem_rd_data(31 downto 2) <= (others => '0');
        mem_rd_data(1 downto 0)  <= ctrl_reg;

      when C_RGB_AVG =>
        mem_rd_data <= RGB_AVG;

      when others =>
        mem_rd_data <= (others => '0');

    end case;
  end process read_p;

end architecture read_reg_image_enhancement_arch;




library IEEE;
use IEEE.std_logic_1164.all;
use work.memory_map_image_enhancement.all;


entity axi4lite_if_ie is
  generic (
    G_RCONST          : natural range 0 to 1023    := 146;
    G_GCONST          : natural range 0 to 1023    := 122;
    G_BCONST          : natural range 0 to 1023    := 165;
    G_COMMON_CONSTANT : natural range 0 to 1048575 := 1046528
    );
  port (
    --Clock and reset interface
    ACLK_I    : in  std_logic;
    ARESETN_I : in  std_logic;
    --write address channel
    awvalid   : in  std_logic;
    awready   : out std_logic;
    awaddr    : in  std_logic_vector(31 downto 0);
    --write data channel
    wdata     : in  std_logic_vector(31 downto 0);
    wvalid    : in  std_logic;
    wready    : out std_logic;
    -- write response channel
    bresp     : out std_logic_vector(1 downto 0);
    bvalid    : out std_logic;
    bready    : in  std_logic;
    -- Read address channel
    araddr    : in  std_logic_vector(31 downto 0);
    arvalid   : in  std_logic;
    arready   : out std_logic;
    -- Read data and response channel
    rready    : in  std_logic;
    rdata     : out std_logic_vector(31 downto 0);
    rresp     : out std_logic_vector(1 downto 0);
    rvalid    : out std_logic;

    --Image Enhancement input/output
    rgb_avg                   : in  std_logic_vector(31 downto 0);
    image_enhancement_ip_en   : out std_logic;
    image_enhancement_ip_rstn : out std_logic;
    r_constant                : out std_logic_vector(9 downto 0);
    g_constant                : out std_logic_vector(9 downto 0);
    b_constant                : out std_logic_vector(9 downto 0);
    second_constant           : out std_logic_vector(19 downto 0)
    );

end entity axi4lite_if_ie;


architecture axi4lite_if_ie_arc of axi4lite_if_ie is

  component axi4lite_adapter_image_enhancement is
    port (
      --Clock and reset interface
      ACLK_I       : in  std_logic;
      ARESETN_I    : in  std_logic;
      --write address channel
      awvalid      : in  std_logic;
      awready      : out std_logic;
      awaddr       : in  std_logic_vector(31 downto 0);
      --write data channel
      wdata        : in  std_logic_vector(31 downto 0);
      wvalid       : in  std_logic;
      wready       : out std_logic;
      -- write response channel
      bresp        : out std_logic_vector(1 downto 0);
      bvalid       : out std_logic;
      bready       : in  std_logic;
      -- Read address channel
      araddr       : in  std_logic_vector(31 downto 0);
      arvalid      : in  std_logic;
      arready      : out std_logic;
                                        -- Read data and response channel
      rready       : in  std_logic;
      rdata        : out std_logic_vector(31 downto 0);
      rresp        : out std_logic_vector(1 downto 0);
      rvalid       : out std_logic;
                                        --Memory interface
      mem_wr_valid : out std_logic;
      mem_wr_addr  : out std_logic_vector(31 downto 0);
      mem_wr_data  : out std_logic_vector(31 downto 0);
      mem_rd_addr  : out std_logic_vector(31 downto 0);
      mem_rd_data  : in  std_logic_vector(31 downto 0));
  end component axi4lite_adapter_image_enhancement;

  component write_reg_image_enhancement is
    generic (
      G_RCONST          : natural range 0 to 1023    := 146;
      G_GCONST          : natural range 0 to 1023    := 122;
      G_BCONST          : natural range 0 to 1023    := 165;
      G_COMMON_CONSTANT : natural range 0 to 1048575 := 1046528
      );
    port (
      ACLK_I                    : in  std_logic;
      ARESETN_I                 : in  std_logic;
      mem_wr_valid              : in  std_logic;
      mem_wr_addr               : in  std_logic_vector(31 downto 0);
      mem_wr_data               : in  std_logic_vector(31 downto 0);
      image_enhancement_ip_en   : out std_logic;
      image_enhancement_ip_rstn : out std_logic;
      r_constant                : out std_logic_vector(9 downto 0);
      g_constant                : out std_logic_vector(9 downto 0);
      b_constant                : out std_logic_vector(9 downto 0);
      second_constant           : out std_logic_vector(19 downto 0)
      );
  end component write_reg_image_enhancement;


  component read_reg_image_enhancement is
    port (
      mem_rd_addr : in  std_logic_vector(31 downto 0);
      mem_rd_data : out std_logic_vector(31 downto 0);
      ctrl_reg    : in  std_logic_vector(1 downto 0);
      rgb_avg     : in  std_logic_vector(31 downto 0)
      );
  end component read_reg_image_enhancement;

  signal s_mem_wr_valid : std_logic;
  signal s_mem_wr_addr  : std_logic_vector(31 downto 0);
  signal s_mem_wr_data  : std_logic_vector(31 downto 0);
  signal s_mem_rd_addr  : std_logic_vector(31 downto 0);
  signal s_mem_rd_data  : std_logic_vector(31 downto 0);
  signal s_aresetn      : std_logic;
  signal s_ctrl_reg     : std_logic_vector(1 downto 0);

begin  -- architecture axi4lite_if_ie_arc

  s_aresetn     <= ARESETN_I and (not image_enhancement_ip_rstn);
  s_ctrl_reg(0) <= image_enhancement_ip_en;
  s_ctrl_reg(1) <= image_enhancement_ip_rstn;

  axi4lite_adapter_image_enhancement_inst : axi4lite_adapter_image_enhancement
    port map (
      ACLK_I       => ACLK_I,
      ARESETN_I    => ARESETN_I,
      awvalid      => awvalid,
      awready      => awready,
      awaddr       => awaddr,
      wdata        => wdata,
      wvalid       => wvalid,
      wready       => wready,
      bresp        => bresp,
      bvalid       => bvalid,
      bready       => bready,
      araddr       => araddr,
      arvalid      => arvalid,
      arready      => arready,
      rready       => rready,
      rdata        => rdata,
      rresp        => rresp,
      rvalid       => rvalid,
      mem_wr_valid => s_mem_wr_valid,
      mem_wr_addr  => s_mem_wr_addr,
      mem_wr_data  => s_mem_wr_data,
      mem_rd_addr  => s_mem_rd_addr,
      mem_rd_data  => s_mem_rd_data);


  read_reg_image_enhancement_inst : read_reg_image_enhancement
    port map (
      mem_rd_addr => s_mem_rd_addr,
      mem_rd_data => s_mem_rd_data,
      ctrl_reg    => s_ctrl_reg,
      rgb_avg     => rgb_avg);

  write_reg_image_enhancement_inst : write_reg_image_enhancement
    generic map (
      G_RCONST          => G_RCONST,
      G_GCONST          => G_GCONST,
      G_BCONST          => G_BCONST,
      G_COMMON_CONSTANT => G_COMMON_CONSTANT)
    port map (
      ACLK_I                    => ACLK_I,
      ARESETN_I                 => s_aresetn,
      mem_wr_valid              => s_mem_wr_valid,
      mem_wr_addr               => s_mem_wr_addr,
      mem_wr_data               => s_mem_wr_data,
      image_enhancement_ip_en   => image_enhancement_ip_en,
      image_enhancement_ip_rstn => image_enhancement_ip_rstn,
      r_constant                => r_constant,
      g_constant                => g_constant,
      b_constant                => b_constant,
      second_constant           => second_constant);

end architecture axi4lite_if_ie_arc;

