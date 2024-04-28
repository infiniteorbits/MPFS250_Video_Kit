--=================================================================================================
-- File Name                           : Bayer_Interpolation.vhd
-- Description                         : Supporting both Native mode and AXI4 Stream mode

-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2022 BY MICROCHIP
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
-- Bayer_Interpolation entity declaration
--=================================================================================================                                                          
entity Bayer_Interpolation is
  generic(
-- Generic List
    -- Number of input pixels
    G_PIXELS : integer := 1;

    -- Specifies the data width
    G_DATA_WIDTH : integer range 0 to 12 := 8;

    -- Specifies the ram size
    G_RAM_SIZE : integer range 0 to 4096 := 2048;

    G_CONFIG : integer range 0 to 1 := 0;  --  0=Native and 1= AXI4 Lite

    G_FORMAT : integer range 0 to 1 := 0  --  0=Native and 1= AXI4 Streaming   
    );
  port (
-- Port List
    -- System reset     
    RESETN_I : in std_logic;

    -- System clock
    SYS_CLK_I : in std_logic;

    -- Specifies the input data is valid or not
    DATA_VALID_I : in std_logic;

    -- Data input
    TDATA_I : in std_logic_vector(G_PIXELS*G_DATA_WIDTH-1 downto 0);

    -- Specifies the valid control signal
    TVALID_I : in std_logic;

    TREADY_O : out std_logic;

    TUSER_I : in std_logic_vector(3 downto 0);

    -- Red data input     
    DATA_I : in std_logic_vector (G_PIXELS*G_DATA_WIDTH - 1 downto 0);

    -- Specifies the end of the frame
    EOF_I : in std_logic;

    -- Specifies the bayer format
    BAYER_FORMAT : in std_logic_vector(1 downto 0);

    -- AXI4 reset
    AXI_RESETN_I : in std_logic;
    -- axi clk
    AXI_CLK_I    : in std_logic;

    -- axi write adrs channel
    AXI_AWVALID_I : in std_logic;

    AXI_AWREADY_O : out std_logic;

    AXI_AWADDR_I : in std_logic_vector (31 downto 0);

    AXI_AWPROT_I : in std_logic_vector(2 downto 0);

    AXI_AWBURST_I : in std_logic_vector(1 downto 0);
    -- axi write data channel
    AXI_WDATA_I   : in std_logic_vector (31 downto 0);

    AXI_WVALID_I : in std_logic;

    AXI_WREADY_O : out std_logic;

    AXI_WSTRB_I  : in  std_logic_vector(3 downto 0);
    -- axi write response channel
    AXI_BVALID_O : out std_logic;

    AXI_BREADY_I : in std_logic;

    AXI_BRESP_O   : out std_logic_vector(1 downto 0);
    -- axi read adrs channel
    AXI_ARVALID_I : in  std_logic;

    AXI_ARREADY_O : out std_logic;

    AXI_ARADDR_I : in std_logic_vector (31 downto 0);

    AXI_ARPROT_I : in std_logic_vector(2 downto 0);

    AXI_ARBURST_I : in  std_logic_vector(1 downto 0);
    -- axi read data channel
    AXI_RDATA_O   : out std_logic_vector (31 downto 0);

    AXI_RVALID_O : out std_logic;

    AXI_RREADY_I : in std_logic;

    AXI_RRESP_O : out std_logic_vector(1 downto 0);
    -- axi full signals
    AXI_AWID_I  : in  std_logic_vector(1 downto 0);

    AXI_AWLEN_I : in std_logic_vector(7 downto 0);

    AXI_AWSIZE_I : in std_logic_vector(2 downto 0);

    AXI_AWLOCK_I : in std_logic_vector(1 downto 0);

    AXI_AWCACHE_I : in std_logic_vector(3 downto 0);

    AXI_AWUSER_I : in std_logic;

    AXI_AWQOS_I : in std_logic_vector(3 downto 0);

    AXI_AWREGION_I : in std_logic_vector(3 downto 0);

    AXI_WLAST_I : in std_logic;

    AXI_WUSER_I : in std_logic;

    AXI_BUSER_O : out std_logic;

    AXI_ARUSER_I : in std_logic;

    AXI_RUSER_O : out std_logic;

    AXI_RID_O : out std_logic_vector(1 downto 0);

    AXI_RLAST_O : out std_logic;

    AXI_BID_O : out std_logic_vector(1 downto 0);

    AXI_ARID_I : in std_logic_vector(1 downto 0);

    AXI_ARLEN_I : in std_logic_vector(7 downto 0);

    AXI_ARSIZE_I : in std_logic_vector(2 downto 0);

    AXI_ARLOCK_I : in std_logic_vector(1 downto 0);

    AXI_ARCACHE_I : in std_logic_vector(3 downto 0);

    AXI_ARQOS_I : in std_logic_vector(3 downto 0);

    AXI_ARREGION_I : in std_logic_vector(3 downto 0);

    -- Specifies the valid RGB data
    RGB_VALID_O : out std_logic;

    -- Output red colour
    R_O : out std_logic_vector(G_PIXELS*G_DATA_WIDTH-1 downto 0);

    -- Output green colour
    G_O : out std_logic_vector(G_PIXELS*G_DATA_WIDTH-1 downto 0);

    -- Output Blue colour
    B_O : out std_logic_vector(G_PIXELS*G_DATA_WIDTH-1 downto 0);

    DATA_O : out std_logic_vector(3*G_PIXELS*G_DATA_WIDTH-1 downto 0);

    -- Specifies the end of the frame
    EOF_O : out std_logic;

    TUSER_O : out std_logic_vector(3 downto 0);
    -- Data input
    TDATA_O : out std_logic_vector(3*G_PIXELS*G_DATA_WIDTH-1 downto 0);

    TSTRB_O : out std_logic_vector(G_DATA_WIDTH/8 - 1 downto 0);

    TKEEP_O : out std_logic_vector(G_DATA_WIDTH/8 - 1 downto 0);

    TLAST_O  : out std_logic;
    -- Specifies the valid control signal
    TVALID_O : out std_logic

    );
end Bayer_Interpolation;
--=================================================================================================
-- Bayer_Interpolation architecture body
--=================================================================================================
architecture rtl of Bayer_Interpolation is
--=================================================================================================
-- Component declarations
--=================================================================================================
  component Bayer_Native
    generic(
      G_PIXELS     : integer := 1;
      G_DATA_WIDTH : integer range 0 to 12 := 8;
      G_RAM_SIZE   : integer range 0 to 4096 := 2048
      );
    port (
      SYS_CLK_I    : in  std_logic;
      RESETN_I     : in  std_logic;
      DATA_VALID_I : in  std_logic;
      EOF_I        : in  std_logic;
      BAYER_FORMAT : in  std_logic_vector(1 downto 0);
      DATA_I       : in  std_logic_vector(G_PIXELS*G_DATA_WIDTH-1 downto 0);
      RGB_VALID_O  : out std_logic;
      R_O          : out std_logic_vector(G_PIXELS*G_DATA_WIDTH-1 downto 0);
      G_O          : out std_logic_vector(G_PIXELS*G_DATA_WIDTH-1 downto 0);
      B_O          : out std_logic_vector(G_PIXELS*G_DATA_WIDTH-1 downto 0);
      EOF_O        : out std_logic
      );
  end component;

  component AXI4S_INITIATOR_BAYER
    generic(
      G_PIXELS     : integer               := 1;
      G_DATA_WIDTH : integer range 8 to 64 := 8
      );
    port (
      RESETN_I     : in  std_logic;
      SYS_CLK_I    : in  std_logic;
      DATA_I       : in  std_logic_vector(3*G_PIXELS*G_DATA_WIDTH-1 downto 0);
      EOF_I        : in  std_logic;
      DATA_VALID_I : in  std_logic;
      TLAST_O      : out std_logic;
      TUSER_O      : out std_logic_vector(3 downto 0);
      TDATA_O      : out std_logic_vector(3*G_PIXELS*G_DATA_WIDTH-1 downto 0);
      TSTRB_O      : out std_logic_vector(G_DATA_WIDTH/8 - 1 downto 0);
      TKEEP_O      : out std_logic_vector(G_DATA_WIDTH/8 - 1 downto 0);
      TVALID_O     : out std_logic
      );
  end component;

  component AXI4S_TARGET_BAYER
    generic(
      G_PIXELS     : integer               := 1;
      G_DATA_WIDTH : integer range 8 to 64 := 8
      );
    port (
      TDATA_I      : in  std_logic_vector(G_PIXELS*G_DATA_WIDTH-1 downto 0);
      TVALID_I     : in  std_logic;
      TUSER_I      : in  std_logic_vector(3 downto 0);
      TREADY_O     : out std_logic;
      DATA_O       : out std_logic_vector(G_PIXELS*G_DATA_WIDTH-1 downto 0);
      DATA_VALID_O : out std_logic;
      EOF_O        : out std_logic
      );
  end component;

  component AXI4Lite_IF_BI
    port (
      AXI_RESETN_I   : in  std_logic;
      AXI_CLK_I      : in  std_logic;
      AXI_AWVALID_I  : in  std_logic;
      AXI_AWREADY_O  : out std_logic;
      AXI_AWADDR_I   : in  std_logic_vector (31 downto 0);
      AXI_AWPROT_I   : in  std_logic_vector(2 downto 0);
      AXI_AWBURST_I  : in  std_logic_vector(1 downto 0);
      AXI_WDATA_I    : in  std_logic_vector (31 downto 0);
      AXI_WVALID_I   : in  std_logic;
      AXI_WREADY_O   : out std_logic;
      AXI_WSTRB_I    : in  std_logic_vector(3 downto 0);
      AXI_BVALID_O   : out std_logic;
      AXI_BREADY_I   : in  std_logic;
      AXI_BRESP_O    : out std_logic_vector(1 downto 0);
      AXI_ARVALID_I  : in  std_logic;
      AXI_ARREADY_O  : out std_logic;
      AXI_ARADDR_I   : in  std_logic_vector (31 downto 0);
      AXI_ARPROT_I   : in  std_logic_vector(2 downto 0);
      AXI_ARBURST_I  : in  std_logic_vector(1 downto 0);
      AXI_RDATA_O    : out std_logic_vector (31 downto 0);
      AXI_RVALID_O   : out std_logic;
      AXI_RREADY_I   : in  std_logic;
      AXI_RRESP_O    : out std_logic_vector(1 downto 0);
      AXI_AWID_I     : in  std_logic_vector(1 downto 0);
      AXI_AWLEN_I    : in  std_logic_vector(7 downto 0);
      AXI_AWSIZE_I   : in  std_logic_vector(2 downto 0);
      AXI_AWLOCK_I   : in  std_logic_vector(1 downto 0);
      AXI_AWCACHE_I  : in  std_logic_vector(3 downto 0);
      AXI_AWUSER_I   : in  std_logic;
      AXI_AWQOS_I    : in  std_logic_vector(3 downto 0);
      AXI_AWREGION_I : in  std_logic_vector(3 downto 0);
      AXI_WLAST_I    : in  std_logic;
      AXI_WUSER_I    : in  std_logic;
      AXI_BUSER_O    : out std_logic;
      AXI_ARUSER_I   : in  std_logic;
      AXI_RUSER_O    : out std_logic;
      AXI_RID_O      : out std_logic_vector(1 downto 0);
      AXI_RLAST_O    : out std_logic;
      AXI_BID_O      : out std_logic_vector(1 downto 0);
      AXI_ARID_I     : in  std_logic_vector(1 downto 0);
      AXI_ARLEN_I    : in  std_logic_vector(7 downto 0);
      AXI_ARSIZE_I   : in  std_logic_vector(2 downto 0);
      AXI_ARLOCK_I   : in  std_logic_vector(1 downto 0);
      AXI_ARCACHE_I  : in  std_logic_vector(3 downto 0);
      AXI_ARQOS_I    : in  std_logic_vector(3 downto 0);
      AXI_ARREGION_I : in  std_logic_vector(3 downto 0);
      bayer_format_o : out std_logic_vector(1 downto 0)
      );
  end component;
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
  signal s_eof_slv            : std_logic;
  signal s_eof_mstr           : std_logic;
  signal s_bayer_format_axi4L : std_logic_vector (1 downto 0);
  signal s_data_slv           : std_logic_vector ((G_PIXELS*G_DATA_WIDTH - 1) downto 0);
  signal s_dvalid_slv         : std_logic;
  signal s_dvalid_mstr        : std_logic;
  signal s_bayer_red_o        : std_logic_vector (G_PIXELS*G_DATA_WIDTH-1 downto 0);
  signal s_bayer_green_o      : std_logic_vector (G_PIXELS*G_DATA_WIDTH-1 downto 0);
  signal s_bayer_blue_o       : std_logic_vector (G_PIXELS*G_DATA_WIDTH-1 downto 0);

  signal s_data_axi_init : std_logic_vector (3*G_PIXELS*G_DATA_WIDTH-1 downto 0);

  signal s_red_axi   : std_logic_vector (G_PIXELS*G_DATA_WIDTH-1 downto 0);
  signal s_green_axi : std_logic_vector (G_PIXELS*G_DATA_WIDTH-1 downto 0);
  signal s_blue_axi  : std_logic_vector (G_PIXELS*G_DATA_WIDTH-1 downto 0);

  signal s_data_o_axi : std_logic_vector (3*G_PIXELS*G_DATA_WIDTH-1 downto 0);

begin
  s_data_axi_init <= s_red_axi & s_green_axi & s_blue_axi;
--=================================================================================================
-- Top level output port assignments
--=================================================================================================
--NA--
--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--NA--  
--=================================================================================================
-- Component Instantiations
--=================================================================================================
  Bayer_Native_FORMAT : if G_PIXELS = 1 and G_FORMAT = 0 and G_CONFIG = 0 generate
    Bayer_Native_INST_0 : Bayer_Native
      generic map(
        G_DATA_WIDTH => G_DATA_WIDTH,
        G_PIXELS     => G_PIXELS,
        G_RAM_SIZE   => G_RAM_SIZE
        )
      port map(
        SYS_CLK_I    => SYS_CLK_I,
        RESETN_I     => RESETN_I,
        BAYER_FORMAT => BAYER_FORMAT,
        EOF_I        => EOF_I,
        DATA_VALID_I => DATA_VALID_I,
        DATA_I       => DATA_I,
        R_O          => R_O,
        G_O          => G_O,
        B_O          => B_O,
        EOF_O        => EOF_O,
        RGB_VALID_O  => RGB_VALID_O
        );
  end generate;

  Bayer_AXI4S_AXI4L_Native_FORMAT : if G_PIXELS = 1 and G_FORMAT = 1 and G_CONFIG = 0 generate
    Bayer_AXI4S_AXI4L_Native_INST_1 : Bayer_Native
      generic map(
        G_DATA_WIDTH => G_DATA_WIDTH,
        G_PIXELS     => G_PIXELS,
        G_RAM_SIZE   => G_RAM_SIZE
        )
      port map(
        SYS_CLK_I    => SYS_CLK_I,
        RESETN_I     => RESETN_I,
        BAYER_FORMAT => BAYER_FORMAT,
        EOF_I        => s_eof_slv,
        DATA_VALID_I => s_dvalid_slv,
        DATA_I       => s_data_slv,
        R_O          => s_red_axi,
        G_O          => s_green_axi,
        B_O          => s_blue_axi,
        EOF_O        => s_eof_mstr,
        RGB_VALID_O  => s_dvalid_mstr
        );
  end generate;
--
  Bayer_AXI4S_Native_AXI4L_FORMAT : if G_PIXELS = 1 and G_FORMAT = 0 and G_CONFIG = 1 generate
    Bayer_AXI4S_Native_AXI4L_INST_2 : Bayer_Native
      generic map(
        G_DATA_WIDTH => G_DATA_WIDTH,
        G_PIXELS     => G_PIXELS,
        G_RAM_SIZE   => G_RAM_SIZE
        )
      port map(
        SYS_CLK_I    => SYS_CLK_I,
        RESETN_I     => RESETN_I,
        BAYER_FORMAT => s_bayer_format_axi4L,
        EOF_I        => EOF_I,
        DATA_VALID_I => DATA_VALID_I,
        DATA_I       => DATA_I,
        R_O          => R_O,
        G_O          => G_O,
        B_O          => B_O,
        EOF_O        => EOF_O,
        RGB_VALID_O  => RGB_VALID_O
        );
  end generate;
--
  Bayer_AXI4S_AXI4L_FORMAT : if G_PIXELS = 1 and G_FORMAT = 1 and G_CONFIG = 1 generate
    Bayer_AXI4S_AXI4L_INST_3 : Bayer_Native
      generic map(
        G_DATA_WIDTH => G_DATA_WIDTH,
        G_PIXELS     => G_PIXELS,
        G_RAM_SIZE   => G_RAM_SIZE
        )
      port map(
        SYS_CLK_I    => SYS_CLK_I,
        RESETN_I     => RESETN_I,
        BAYER_FORMAT => s_bayer_format_axi4L,
        EOF_I        => s_eof_slv,
        DATA_VALID_I => s_dvalid_slv,
        DATA_I       => s_data_slv,
        R_O          => s_red_axi,
        G_O          => s_green_axi,
        B_O          => s_blue_axi,
        EOF_O        => s_eof_mstr,
        RGB_VALID_O  => s_dvalid_mstr
        );
  end generate;

  Bayer_tar_FORMAT : if G_FORMAT = 1 generate
    Bayer_Interpolation_AXI_TAR_INST : AXI4S_TARGET_BAYER
      generic map(
        G_DATA_WIDTH => G_DATA_WIDTH,
        G_PIXELS     => G_PIXELS
        )
      port map(
        TVALID_I     => TVALID_I,
        TDATA_I      => TDATA_I,
        TUSER_I      => TUSER_I,
        TREADY_O     => TREADY_O,
        DATA_VALID_O => s_dvalid_slv,
        EOF_O        => s_eof_slv,
        DATA_O       => s_data_slv
        );
  end generate;

  BI_axi4lite_FORMAT : if G_CONFIG = 1 generate
    Bayer_Interpolation_AXI_LITE_INST : AXI4Lite_IF_BI
      port map(
        AXI_RESETN_I   => AXI_RESETN_I,
        AXI_CLK_I      => AXI_CLK_I,
        AXI_AWVALID_I  => AXI_AWVALID_I,
        AXI_AWREADY_O  => AXI_AWREADY_O,
        AXI_AWADDR_I   => AXI_AWADDR_I,
        AXI_AWPROT_I   => AXI_AWPROT_I,
        AXI_AWBURST_I  => AXI_AWBURST_I,
        AXI_WDATA_I    => AXI_WDATA_I,
        AXI_WVALID_I   => AXI_WVALID_I,
        AXI_WREADY_O   => AXI_WREADY_O,
        AXI_WSTRB_I    => AXI_WSTRB_I,
        AXI_BVALID_O   => AXI_BVALID_O,
        AXI_BREADY_I   => AXI_BREADY_I,
        AXI_BRESP_O    => AXI_BRESP_O,
        AXI_ARVALID_I  => AXI_ARVALID_I,
        AXI_ARREADY_O  => AXI_ARREADY_O,
        AXI_ARADDR_I   => AXI_ARADDR_I,
        AXI_ARPROT_I   => AXI_ARPROT_I,
        AXI_ARBURST_I  => AXI_ARBURST_I,
        AXI_RDATA_O    => AXI_RDATA_O,
        AXI_RVALID_O   => AXI_RVALID_O,
        AXI_RREADY_I   => AXI_RREADY_I,
        AXI_RRESP_O    => AXI_RRESP_O,
        AXI_AWID_I     => AXI_AWID_I,
        AXI_AWLEN_I    => AXI_AWLEN_I,
        AXI_AWSIZE_I   => AXI_AWSIZE_I,
        AXI_AWLOCK_I   => AXI_AWLOCK_I,
        AXI_AWCACHE_I  => AXI_AWCACHE_I,
        AXI_AWUSER_I   => AXI_AWUSER_I,
        AXI_AWQOS_I    => AXI_AWQOS_I,
        AXI_AWREGION_I => AXI_AWREGION_I,
        AXI_WLAST_I    => AXI_WLAST_I,
        AXI_WUSER_I    => AXI_WUSER_I,
        AXI_BUSER_O    => AXI_BUSER_O,
        AXI_ARUSER_I   => AXI_ARUSER_I,
        AXI_RUSER_O    => AXI_RUSER_O,
        AXI_RID_O      => AXI_RID_O,
        AXI_RLAST_O    => AXI_RLAST_O,
        AXI_BID_O      => AXI_BID_O,
        AXI_ARID_I     => AXI_ARID_I,
        AXI_ARLEN_I    => AXI_ARLEN_I,
        AXI_ARSIZE_I   => AXI_ARSIZE_I,
        AXI_ARLOCK_I   => AXI_ARLOCK_I,
        AXI_ARCACHE_I  => AXI_ARCACHE_I,
        AXI_ARQOS_I    => AXI_ARQOS_I,
        AXI_ARREGION_I => AXI_ARREGION_I,
        bayer_format_o => s_bayer_format_axi4L
        );
  end generate;

  Bayer_4p_Native_FORMAT : if G_PIXELS = 4 and G_FORMAT = 0 and G_CONFIG = 0 generate
    Bayer_4P_Native_INST : Bayer_Native
      generic map(
        G_DATA_WIDTH => G_DATA_WIDTH,
        G_PIXELS     => G_PIXELS,
        G_RAM_SIZE   => G_RAM_SIZE
        )
      port map(
        SYS_CLK_I    => SYS_CLK_I,
        RESETN_I     => RESETN_I,
        BAYER_FORMAT => BAYER_FORMAT,
        EOF_I        => EOF_I,
        DATA_VALID_I => DATA_VALID_I,
        DATA_I       => DATA_I,
        R_O          => R_O,
        G_O          => G_O,
        B_O          => B_O,
        EOF_O        => EOF_O,
        RGB_VALID_O  => RGB_VALID_O
        );
	--DATA_O       <= s_bayer_red_o & s_bayer_green_o & s_bayer_blue_o;
  end generate;

  Bayer_4p_Native_AXI4L_FORMAT : if G_PIXELS = 4 and G_FORMAT = 0 and G_CONFIG = 1 generate
    Bayer_4P_Native_AXI4L_INST : Bayer_Native
      generic map(
        G_DATA_WIDTH => G_DATA_WIDTH,
        G_PIXELS     => G_PIXELS,
        G_RAM_SIZE   => G_RAM_SIZE
        )
      port map(
        SYS_CLK_I    => SYS_CLK_I,
        RESETN_I     => RESETN_I,
        BAYER_FORMAT => s_bayer_format_axi4L,
        EOF_I        => EOF_I,
        DATA_VALID_I => DATA_VALID_I,
        DATA_I       => DATA_I,
        R_O          => R_O,
        G_O          => G_O,
        B_O          => B_O,
        EOF_O        => EOF_O,
        RGB_VALID_O  => RGB_VALID_O
        );
		--DATA_O       <= s_bayer_red_o & s_bayer_green_o & s_bayer_blue_o;
  end generate;

  Bayer_4p_AXI4S_Native_FORMAT : if G_PIXELS = 4 and G_FORMAT = 1 and G_CONFIG = 0 generate
    Bayer_4P_AXI4S_Native_INST : Bayer_Native
      generic map(
        G_DATA_WIDTH => G_DATA_WIDTH,
        G_PIXELS     => G_PIXELS,
        G_RAM_SIZE   => G_RAM_SIZE
        )
      port map(
        SYS_CLK_I    => SYS_CLK_I,
        RESETN_I     => RESETN_I,
        BAYER_FORMAT => BAYER_FORMAT,
        EOF_I        => s_eof_slv,
        DATA_VALID_I => s_dvalid_slv,
        DATA_I       => s_data_slv,
        R_O          => s_bayer_red_o,
        G_O          => s_bayer_green_o,
        B_O          => s_bayer_blue_o,
        EOF_O        => s_eof_mstr,
        RGB_VALID_O  => s_dvalid_mstr
        );
		s_data_o_axi <= s_bayer_red_o & s_bayer_green_o & s_bayer_blue_o;
  end generate;

  Bayer_4p_AXI4S_FORMAT : if G_PIXELS = 4 and G_FORMAT = 1 and G_CONFIG = 1 generate
    Bayer_4P_AXI4S_INST : Bayer_Native
      generic map(
        G_DATA_WIDTH => G_DATA_WIDTH,
        G_PIXELS     => G_PIXELS,
        G_RAM_SIZE   => G_RAM_SIZE
        )
      port map(
        SYS_CLK_I    => SYS_CLK_I,
        RESETN_I     => RESETN_I,
        BAYER_FORMAT => s_bayer_format_axi4L,
        EOF_I        => s_eof_slv,
        DATA_VALID_I => s_dvalid_slv,
        DATA_I       => s_data_slv,
        R_O          => s_bayer_red_o,
        G_O          => s_bayer_green_o,
        B_O          => s_bayer_blue_o,
        EOF_O        => s_eof_mstr,
        RGB_VALID_O  => s_dvalid_mstr
        );
		s_data_o_axi <= s_bayer_red_o & s_bayer_green_o &s_bayer_blue_o;
  end generate;

  Bayer_init1p_FORMAT : if G_FORMAT = 1 and G_PIXELS = 1 generate
    Bayer_Interpolation_AXI_INIT1P_INST : AXI4S_INITIATOR_BAYER
      generic map(
        G_PIXELS     => G_PIXELS,
        G_DATA_WIDTH => G_DATA_WIDTH
        )
      port map(
        RESETN_I     => RESETN_I,
        SYS_CLK_I    => SYS_CLK_I,
        DATA_VALID_I => s_dvalid_mstr,
        EOF_I        => s_eof_mstr,
        DATA_I       => s_data_axi_init,
        TLAST_O      => TLAST_O,
        TUSER_O      => TUSER_O,
        TSTRB_O      => TSTRB_O,
        TKEEP_O      => TKEEP_O,
        TVALID_O     => TVALID_O,
        TDATA_O      => TDATA_O
        );
  end generate;

  Bayer_init4p_FORMAT : if G_FORMAT = 1 and G_PIXELS = 4 generate
    Bayer_Interpolation_AXI_INIT4P_INST : AXI4S_INITIATOR_BAYER
      generic map(
        G_PIXELS     => G_PIXELS,
        G_DATA_WIDTH => G_DATA_WIDTH
        )
      port map(
        RESETN_I     => RESETN_I,
        SYS_CLK_I    => SYS_CLK_I,
        DATA_VALID_I => s_dvalid_mstr,
        EOF_I        => s_eof_mstr,
        DATA_I       => s_data_o_axi,
        TLAST_O      => TLAST_O,
        TUSER_O      => TUSER_O,
        TSTRB_O      => TSTRB_O,
        TKEEP_O      => TKEEP_O,
        TVALID_O     => TVALID_O,
        TDATA_O      => TDATA_O
        );
  end generate;
end rtl;
---- ********************************************************************/ 
-- Microsemi Corporation Proprietary and Confidential 
-- Copyright 2018 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
-- Description:  Writes data into LSRAM
--
-- Revision Information:
-- Date     Description
-- 07Mar18 Initial Release 
--
-- SVN Revision Information:
-- SVN $Revision: $
-- SVN $Date: $
--
-- Resolved SARs
-- SAR      Date     Who   Description
--
-- Notes: 
--        
-- *********************************************************************/ 

--=================================================================================================
-- Libraries
--=================================================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.NUMERIC_STD.all;


entity Bayer_Native is
  generic(
-- Generic List
    -- Number of input pixels
    G_PIXELS : integer := 1;

    -- Specifies the data width
    G_DATA_WIDTH : integer range 0 to 12 := 8;

    -- Specifies the ram size
    G_RAM_SIZE : integer range 0 to 4096 := 2048
    );
  port (
-- Port List
    -- System reset
    RESETN_I : in std_logic;

    -- System clock
    SYS_CLK_I : in std_logic;

    -- Specifies the input data is valid or not
    DATA_VALID_I : in std_logic;

    -- Specifies the end of the frame
    EOF_I : in std_logic;
	
	-- Specifies the bayer format
	BAYER_FORMAT : in std_logic_vector(1 downto 0);

    -- Data input
    DATA_I : in std_logic_vector(G_PIXELS * G_DATA_WIDTH - 1 downto 0);

    -- Specifies the valid RGB data
    RGB_VALID_O : out std_logic;

    -- Output red colour
    R_O : out std_logic_vector(G_PIXELS * G_DATA_WIDTH - 1 downto 0);

    -- Output green colour
    G_O : out std_logic_vector(G_PIXELS * G_DATA_WIDTH - 1 downto 0);

    -- Output Blue colour
    B_O : out std_logic_vector(G_PIXELS * G_DATA_WIDTH - 1 downto 0);

    -- Specifies the end of the frame
    EOF_O : out std_logic
    );

end entity Bayer_Native;
`protect begin_protected
`protect version=1
`protect author="author-a", author_info="author-a-details"
`protect encrypt_agent="encryptP1735.pl", encrypt_agent_info="Synplify encryption scripts"

`protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=256)
`protect key_block
ZgUJtwd5YEdngiCv8r4qC0iK7PkHp0FvUPuRiXoc09LfuFyVToIUeZbYoLoQqs5MGVrZmIu4M4fI
rlII0q4ggcRcfWoOJ4EHdBJ52nTIozWisYC+FOgSmG/Vn+elk5V+LmzjX19ctXOsNeSNrMIfykvC
vIvnxP9a5AlDmEKGUTVjpIDsqHgcaC7+pUa7e8QqChjlYNL1ZQTgJYGLJRqLFfqCNGq4OemWci3f
isfUgsgiDTzWySFp5hLhm1Z/rJ1q4QJreutlI2g02xyVFSGlspiHojg3I2IOk4c9cjEJGKVD86AN
Vkq6/8J2P9wX8Fo91iojecsW4iXRWgt6JxYYXw==

`protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=128)
`protect key_block
fSPYdkbb6uOSb4ulUzE3OY8nNiPm20M7olqRE57C4Sv9Z/cNuYWxvniOLQaET8i4BkgtaXmg/Lku
sl3k0X7XRodgRJU8Fo2Co7OwxVfN8SrrqboSHNzrcLvptZdTg/uElEe81pQmQ3O15GodGQqPEUT+
V6yFH/I/IwLY8eTGFew=

`protect key_keyowner="Microsemi Corporation", key_keyname="MSC-IP-KEY-RSA", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=960)
`protect key_block
p5JWKCLNbUzjry0nTPg6MToFU6m6tU1l5S2LZX1mC/30dA+BJF5dWUX+IXn3CTRMAqkl7d92wtFV
HiZIIf/3nzTWk6dcAF5nAgMban6pRcH5WCsBOk8kFF1/dgF7oN51SPaJGcUFUUAt0qSaXvMXJ5DI
BI0ZmGq5H0kNWcY94UZ5vzYG8+AB16GX7Fah7eMh1tiubxyjr1q+TQ4Kn4kGVQkPshVqQN+foDCL
O+nA8tTatZLtVJcS4Z9+X8EICphlHJt2a9wZDIBtt8SQZxovGyCkI5/KxayJQ9SfTzbVVifpPhgH
9fwt8eILVB/faIC7M8LC4wYgRV8MIsYbdyioAGvBjWTPAkYfBMjAt18o1vlYIbvWA+kula+k+p1b
hWju2jCP57aeBWR7ZahF/NdkIBhZ/qnGd9VjIR0nWf9yGBttJRUcE4okUb84PNax1J98dOqwxZ3K
rFU1JfoqkfaaDKFqyDXkx/nmVyMRHwrvMZ3YC5iceYb+ZvkfSA/arfoMaOlyGvIuv2CCFlMgwFdY
soZWWCkJ0tl4jm5wgaV5sjRz8IXctQyt5LV962DjL/UIja3drRZNeVt0/jF7s9IGXUIIcVBGTzJ8
Q6lfMPk6kL4f1REsxnam8Ir5oN8z3/Zka2AHlQDJdIkQ7hC7AO9DD3Ma8+t1FolfsLrp1eubo2ly
6sHhmO8NUtklKLCxgeu5Ge4wGkZ1jEuz976SJ7ri5U1gpRt6v6Z9y231O371eVQQUoUFb9VSL9GV
InofB+P54+fPuBckuo4Hsi6fVg9EKcvTpFce9jOcTd6NVTKiEz66obbBj+MmJHuvlRuzcXzldQJg
kCBbWWkh1RcEVuGXCTObyVy6Vhz9zUyTxLLpI6U7tRpHKdEp3we2pClgN71SF1gK+xe/LbWNqfDp
f48Hs1ZuHneAldSvhFNSIhjE67u9jUkayYVn9fPJAqZGSDTyKuu56t8TSn6x3c3fCa9p7DMMLcOm
vN+7up6O8lE/8R3KEVseRsRTbaLwKUHz+/B0hx8rnMZZ+H7LTd7ajtIbf3YqrEafXOMzfInUdIz0
hb9Fiw2i0wwXVp4nDRkpnqB7TJY76/0HRZvE6EZdXZNFrwmq4S36Cs+NXJ/y/W+a0pMSoSUYUVCc
CW00S7aw23Zjgu/YsuMZ4pybXqCadF5z/23e0qbDObAVv7EZqSjTqwP2zzgyXJkAFbOf2OINfkp1
qcPo5zJLXxZ31nk3RpnV7XtMEqJsIyN5OohLhyabm7ywS9C8xU4sLgiJpNbkTT3/

`protect data_keyowner="ip-vendor-a", data_keyname="fpga-ip", data_method="aes128-cbc"
`protect encoding=(enctype="base64", line_length=76, bytes=146624)
`protect data_block
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
9QMu8MMG4ERF7kNDrFRHWKlrdmI=

`protect end_protected

--=================================================================================================
-- File Name                           : AXI4Lite_IF_BI.vhd

-- Targeted device                     : Microsemi-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2021 BY MICROSEMI
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
--=================================================================================================
-- AXI4Lite_IF_BI entity declaration
--=================================================================================================
entity AXI4Lite_IF_BI is
  port (
-- Port list
    -- AXI4 reset
    AXI_RESETN_I : in std_logic;
    -- axi clk
    AXI_CLK_I    : in std_logic;

    -- axi write adrs channel
    AXI_AWVALID_I : in std_logic;

    AXI_AWREADY_O : out std_logic;

    AXI_AWADDR_I : in std_logic_vector (31 downto 0);

    AXI_AWPROT_I : in std_logic_vector(2 downto 0);

    AXI_AWBURST_I : in std_logic_vector(1 downto 0);
    -- axi write data channel
    AXI_WDATA_I   : in std_logic_vector (31 downto 0);

    AXI_WVALID_I : in std_logic;

    AXI_WREADY_O : out std_logic;

    AXI_WSTRB_I  : in  std_logic_vector(3 downto 0);
    -- axi write response channel
    AXI_BVALID_O : out std_logic;

    AXI_BREADY_I : in std_logic;

    AXI_BRESP_O   : out std_logic_vector(1 downto 0);
    -- axi read adrs channel
    AXI_ARVALID_I : in  std_logic;

    AXI_ARREADY_O : out std_logic;

    AXI_ARADDR_I : in std_logic_vector (31 downto 0);

    AXI_ARPROT_I : in std_logic_vector(2 downto 0);

    AXI_ARBURST_I : in  std_logic_vector(1 downto 0);
    -- axi read data channel
    AXI_RDATA_O   : out std_logic_vector (31 downto 0);

    AXI_RVALID_O : out std_logic;

    AXI_RREADY_I : in std_logic;

    AXI_RRESP_O : out std_logic_vector(1 downto 0);
    -- axi full signals
    AXI_AWID_I  : in  std_logic_vector(1 downto 0);

    AXI_AWLEN_I : in std_logic_vector(7 downto 0);

    AXI_AWSIZE_I : in std_logic_vector(2 downto 0);

    AXI_AWLOCK_I : in std_logic_vector(1 downto 0);

    AXI_AWCACHE_I : in std_logic_vector(3 downto 0);

    AXI_AWUSER_I : in std_logic;

    AXI_AWQOS_I : in std_logic_vector(3 downto 0);

    AXI_AWREGION_I : in std_logic_vector(3 downto 0);

    AXI_WLAST_I : in std_logic;

    AXI_WUSER_I : in std_logic;

    AXI_BUSER_O : out std_logic;

    AXI_ARUSER_I : in std_logic;

    AXI_RUSER_O : out std_logic;

    AXI_RID_O : out std_logic_vector(1 downto 0);

    AXI_RLAST_O : out std_logic;

    AXI_BID_O : out std_logic_vector(1 downto 0);

    AXI_ARID_I : in std_logic_vector(1 downto 0);

    AXI_ARLEN_I : in std_logic_vector(7 downto 0);

    AXI_ARSIZE_I : in std_logic_vector(2 downto 0);

    AXI_ARLOCK_I : in std_logic_vector(1 downto 0);

    AXI_ARCACHE_I : in std_logic_vector(3 downto 0);

    AXI_ARQOS_I : in std_logic_vector(3 downto 0);

    AXI_ARREGION_I : in std_logic_vector(3 downto 0);

    bayer_format_o : out std_logic_vector(1 downto 0)
    );
end AXI4Lite_IF_BI;
--=================================================================================================
-- AXI4Lite_IF_BI architecture body
--=================================================================================================
architecture AXI4Lite_IF_BI of AXI4Lite_IF_BI is
--=================================================================================================
-- Component declarations
--=================================================================================================
  component AXI4LITE_SUB_BLK_BI is
    port (
      RESETN_I          : in  std_logic;
      CLK_I             : in  std_logic;
      AWVALID_I         : in  std_logic;
      AWREADY_O         : out std_logic;
      AWADDR_I          : in  std_logic_vector (31 downto 0);
      AWPROT_I          : in  std_logic_vector(2 downto 0);
      AWBURST_I         : in  std_logic_vector(1 downto 0);
      AWSIZE_I          : in  std_logic_vector(2 downto 0);
      AWID_I            : in  std_logic_vector(1 downto 0);
      AWLEN_I           : in  std_logic_vector(7 downto 0);
      WDATA_I           : in  std_logic_vector (31 downto 0);
      WVALID_I          : in  std_logic;
      WREADY_O          : out std_logic;
      WSTRB_I           : in  std_logic_vector(3 downto 0);
      BVALID_O          : out std_logic;
      BREADY_I          : in  std_logic;
      BRESP_O           : out std_logic_vector(1 downto 0);
      BID_O             : out std_logic_vector(1 downto 0);
      AWREGION_I        : in  std_logic_vector(3 downto 0);
      ARVALID_I         : in  std_logic;
      ARREADY_O         : out std_logic;
      ARADDR_I          : in  std_logic_vector (31 downto 0);
      ARPROT_I          : in  std_logic_vector(2 downto 0);
      ARBURST_I         : in  std_logic_vector(1 downto 0);
      ARLOCK_I          : in  std_logic_vector(1 downto 0);
      ARCACHE_I         : in  std_logic_vector(3 downto 0);
      ARQOS_I           : in  std_logic_vector(3 downto 0);
      ARSIZE_I          : in  std_logic_vector(2 downto 0);
      ARLEN_I           : in  std_logic_vector(7 downto 0);
      ARID_I            : in  std_logic_vector(1 downto 0);
      RDATA_O           : out std_logic_vector (31 downto 0);
      RVALID_O          : out std_logic;
      RREADY_I          : in  std_logic;
      RRESP_O           : out std_logic_vector(1 downto 0);
      RID_O             : out std_logic_vector(1 downto 0);
      RLAST_O           : out std_logic;
      BUSER_O           : out std_logic;
      RUSER_O           : out std_logic;
      ARUSER_I          : in  std_logic;
      ARREGION_I        : in  std_logic_vector(3 downto 0);
      AWUSER_I          : in  std_logic;
      AWQOS_I           : in  std_logic_vector(3 downto 0);
      AWLOCK_I          : in  std_logic_vector(1 downto 0);
      AWCACHE_I         : in  std_logic_vector(3 downto 0);
      WUSER_I           : in  std_logic;
      WLAST_I           : in  std_logic;
      USER_DATA_VALID_O : out std_logic;
      USER_AWADDR_O     : out std_logic_vector(31 downto 0);
      USER_WDATA_O      : out std_logic_vector(31 downto 0);
      USER_ARADDR_O     : out std_logic_vector(31 downto 0);
      USER_RDATA_I      : in  std_logic_vector(31 downto 0)
      );
  end component;

  component AXI4LITE_USR_BLK_BI is
    port (
      RESETN_I          : in  std_logic;
      CLK_I             : in  std_logic;
      USER_DATA_VALID_I : in  std_logic;
      USER_AWADDR_I     : in  std_logic_vector(31 downto 0);
      USER_WDATA_I      : in  std_logic_vector(31 downto 0);
      USER_ARADDR_I     : in  std_logic_vector(31 downto 0);
      USER_RDATA_O      : out std_logic_vector(31 downto 0);
      BAYER_FORMAT_O    : out std_logic_vector(1 downto 0)
      );
  end component;
--=================================================================================================
-- Synthesis Attributes
--=================================================================================================
--NA--
--=================================================================================================
-- Signal declarations
--=================================================================================================
  signal s_user_data_valid : std_logic;
  signal s_user_awaddr     : std_logic_vector(31 downto 0);
  signal s_user_wdata      : std_logic_vector(31 downto 0);
  signal s_user_araddr     : std_logic_vector(31 downto 0);
  signal s_user_rdata      : std_logic_vector(31 downto 0);

begin
--=================================================================================================
-- Top level output port assignments
--=================================================================================================
--NA--
--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--NA--             
--=================================================================================================
-- Component Instantiations
--=================================================================================================
  AXI4LITE_SUB_BLK_BI_INST : AXI4LITE_SUB_BLK_BI
    port map(
      RESETN_I          => AXI_RESETN_I,
      CLK_I             => AXI_CLK_I,
      AWVALID_I         => AXI_AWVALID_I,
      AWREADY_O         => AXI_AWREADY_O,
      AWADDR_I          => AXI_AWADDR_I,
      AWPROT_I          => AXI_AWPROT_I,
      AWBURST_I         => AXI_AWBURST_I,
      AWSIZE_I          => AXI_AWSIZE_I,
      WDATA_I           => AXI_WDATA_I,
      WVALID_I          => AXI_WVALID_I,
      WREADY_O          => AXI_WREADY_O,
      WSTRB_I           => AXI_WSTRB_I,
      BVALID_O          => AXI_BVALID_O,
      BREADY_I          => AXI_BREADY_I,
      BRESP_O           => AXI_BRESP_O,
      RDATA_O           => AXI_RDATA_O,
      RVALID_O          => AXI_RVALID_O,
      RREADY_I          => AXI_RREADY_I,
      RRESP_O           => AXI_RRESP_O,
      AWREGION_I        => AXI_AWREGION_I,
      ARVALID_I         => AXI_ARVALID_I,
      ARREADY_O         => AXI_ARREADY_O,
      ARADDR_I          => AXI_ARADDR_I,
      ARPROT_I          => AXI_ARPROT_I,
      ARBURST_I         => AXI_ARBURST_I,
      ARREGION_I        => AXI_ARREGION_I,
      ARLOCK_I          => AXI_ARLOCK_I,
      ARCACHE_I         => AXI_ARCACHE_I,
      ARQOS_I           => AXI_ARQOS_I,
      ARSIZE_I          => AXI_ARSIZE_I,
      ARLEN_I           => AXI_ARLEN_I,
      ARID_I            => AXI_ARID_I,
      AWUSER_I          => AXI_AWUSER_I,
      AWQOS_I           => AXI_AWQOS_I,
      AWLOCK_I          => AXI_AWLOCK_I,
      AWCACHE_I         => AXI_AWCACHE_I,
      WUSER_I           => AXI_WUSER_I,
      WLAST_I           => AXI_WLAST_I,
      AWID_I            => AXI_AWID_I,
      AWLEN_I           => AXI_AWLEN_I,
      RLAST_O           => AXI_RLAST_O,
      BUSER_O           => AXI_BUSER_O,
      RUSER_O           => AXI_RUSER_O,
      ARUSER_I          => AXI_ARUSER_I,
      USER_DATA_VALID_O => s_user_data_valid,
      USER_AWADDR_O     => s_user_awaddr,
      USER_WDATA_O      => s_user_wdata,
      USER_ARADDR_O     => s_user_araddr,
      USER_RDATA_I      => s_user_rdata
      );

  AXI4LITE_USR_BLK_BI_INST : AXI4LITE_USR_BLK_BI
    port map(
      RESETN_I          => AXI_RESETN_I,
      CLK_I             => AXI_CLK_I,
      USER_DATA_VALID_I => s_user_data_valid,
      USER_AWADDR_I     => s_user_awaddr,
      USER_WDATA_I      => s_user_wdata,
      USER_ARADDR_I     => s_user_araddr,
      USER_RDATA_O      => s_user_rdata,
      BAYER_FORMAT_O    => BAYER_FORMAT_O

      );
end architecture AXI4Lite_IF_BI;
--=================================================================================================
-- File Name                           : AXI4LITE_SUB_BLK_BI.vhd

-- Targeted device                     : Microsemi-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2021 BY MICROSEMI
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
--=================================================================================================
-- AXI4LITE_SUB_BLK_BI entity declaration
--=================================================================================================
entity AXI4LITE_SUB_BLK_BI is
  port (
-- Port list
    -- AXI4 reset
    RESETN_I          : in  std_logic;
    -- axi clk                                  
    CLK_I             : in  std_logic;
    -- axi write adrs channel-awvalid           
    AWVALID_I         : in  std_logic;
    -- axi write adrs channel-awready           
    AWREADY_O         : out std_logic;
    -- axi write adrs channel-awaddr            
    AWADDR_I          : in  std_logic_vector (31 downto 0);
    -- axi write adrs channel-awprot            
    AWPROT_I          : in  std_logic_vector(2 downto 0);
    -- axi write adrs channel-burst type        
    AWBURST_I         : in  std_logic_vector(1 downto 0);
    -- axi write data channel-write data        
    WDATA_I           : in  std_logic_vector (31 downto 0);
    -- axi write data channel-wvalid            
    WVALID_I          : in  std_logic;
    -- axi write data channel-wready            
    WREADY_O          : out std_logic;
    -- axi write adrs channel strobe            
    WSTRB_I           : in  std_logic_vector(3 downto 0);
    -- axi write response channel valid         
    BVALID_O          : out std_logic;
    -- axi write response channel-ready         
    BREADY_I          : in  std_logic;
    -- axi write response                       
    BRESP_O           : out std_logic_vector(1 downto 0);
    -- axi read adrs channel arvalid            
    ARVALID_I         : in  std_logic;
    -- axi read adrs channel arready            
    ARREADY_O         : out std_logic;
    -- axi read adrs channel addr               
    ARADDR_I          : in  std_logic_vector (31 downto 0);
    -- axi read adrs channel arprot             
    ARPROT_I          : in  std_logic_vector(2 downto 0);
    -- axi read adrs channel arburst            
    ARBURST_I         : in  std_logic_vector(1 downto 0);
    -- axi read data channel data               
    RDATA_O           : out std_logic_vector (31 downto 0);
    -- axi read data channel valid              
    RVALID_O          : out std_logic;
    -- axi read data channel ready              
    RREADY_I          : in  std_logic;
    -- axi read data channel response           
    RRESP_O           : out std_logic_vector(1 downto 0);
    -- axi address write ID                     
    AWID_I            : in  std_logic_vector(1 downto 0);
    -- axi burst length                         
    AWLEN_I           : in  std_logic_vector(7 downto 0);
    -- axi burst size                           
    AWSIZE_I          : in  std_logic_vector(2 downto 0);
    -- axi lock                                 
    AWLOCK_I          : in  std_logic_vector(1 downto 0);
    -- axi cache                                
    AWCACHE_I         : in  std_logic_vector(3 downto 0);
    -- axi awuser                               
    AWUSER_I          : in  std_logic;
    -- axi qos                                  
    AWQOS_I           : in  std_logic_vector(3 downto 0);
    -- axi region                               
    AWREGION_I        : in  std_logic_vector(3 downto 0);
    -- axi last                                 
    WLAST_I           : in  std_logic;
    -- axi wuser                                
    WUSER_I           : in  std_logic;
    -- axi buser                                
    BUSER_O           : out std_logic;
    -- axi aruser                               
    ARUSER_I          : in  std_logic;
    -- axi ruser                                
    RUSER_O           : out std_logic;
    -- axi RID                                  
    RID_O             : out std_logic_vector(1 downto 0);
    -- axi read last                            
    RLAST_O           : out std_logic;
    -- axi BID                                  
    BID_O             : out std_logic_vector(1 downto 0);
    -- axi RID                                  
    ARID_I            : in  std_logic_vector(1 downto 0);
    -- axi read length                          
    ARLEN_I           : in  std_logic_vector(7 downto 0);
    -- axi read size                            
    ARSIZE_I          : in  std_logic_vector(2 downto 0);
    -- axi read lock                            
    ARLOCK_I          : in  std_logic_vector(1 downto 0);
    -- axi read cache                           
    ARCACHE_I         : in  std_logic_vector(3 downto 0);
    -- axi read qos                             
    ARQOS_I           : in  std_logic_vector(3 downto 0);
    -- axi read region                          
    ARREGION_I        : in  std_logic_vector(3 downto 0);
    -- user logic ports -  data valid
    USER_DATA_VALID_O : out std_logic;
    -- user logic ports - write address
    USER_AWADDR_O     : out std_logic_vector(31 downto 0);
    -- user logic ports -  write data
    USER_WDATA_O      : out std_logic_vector(31 downto 0);
    -- user logic ports - read address
    USER_ARADDR_O     : out std_logic_vector(31 downto 0);
    -- user logic ports - read data     
    USER_RDATA_I      : in  std_logic_vector(31 downto 0)

    );
end AXI4LITE_SUB_BLK_BI;
--=================================================================================================
-- AXI4LITE_SUB_BLK_BI architecture body
--=================================================================================================
architecture AXI4LITE_SUB_BLK_BI of AXI4LITE_SUB_BLK_BI is
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
  type state is (a, b, c, d);
  signal s_state   : state;
  signal s_wready  : std_logic;
  signal s_awready : std_logic;
  signal s_arready : std_logic;
  signal s_bvalid  : std_logic;
  signal s_rvalid  : std_logic;

begin
--=================================================================================================
-- Top level output port assignments
--=================================================================================================
  WREADY_O  <= s_wready;
  AWREADY_O <= s_awready;
  ARREADY_O <= s_arready;
  RDATA_O   <= USER_RDATA_I;
  RVALID_O  <= s_rvalid;
  RRESP_O   <= "00";
  BVALID_O  <= s_bvalid;
  BUSER_O   <= '0';
  RUSER_O   <= '0';
  RID_O     <= "00";
  RLAST_O   <= '0';
  BID_O     <= AWID_I;
--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : P_WRITE_DATA
-- Description: DECODE THE AXI DATA AND GENERATE USER DATA
--------------------------------------------------------------------------
  P_WRITE_DATA :
  process (RESETN_I, CLK_I)
  begin
    if RESETN_I = '0' then
      USER_AWADDR_O     <= (others => '0');
      USER_DATA_VALID_O <= '0';
      s_awready         <= '0';
      s_wready          <= '0';
      s_state           <= a;
      s_bvalid          <= '0';

    elsif (RISING_EDGE (CLK_I)) then
      case s_state is
        when a =>
          if (AWVALID_I = '1' and WVALID_I = '1') then
            USER_AWADDR_O     <= AWADDR_I;
            USER_DATA_VALID_O <= '1';
            USER_WDATA_O      <= WDATA_I;
            s_state           <= d;
            s_awready         <= '1';
            s_wready          <= '1';
            s_bvalid          <= '1';
          elsif (AWVALID_I = '1') then
            s_awready         <= '1';
            s_wready          <= '0';
            USER_AWADDR_O     <= AWADDR_I;
            s_state           <= b;
            USER_DATA_VALID_O <= '0';
          elsif (WVALID_I = '1') then
            s_awready         <= '0';
            s_wready          <= '1';
            USER_WDATA_O      <= WDATA_I;
            s_state           <= c;
            USER_DATA_VALID_O <= '0';
          end if;
        when b =>
          if (WVALID_I = '1') then
            USER_WDATA_O      <= WDATA_I;
            USER_DATA_VALID_O <= '1';
            s_state           <= d;
            s_wready          <= '1';
            s_bvalid          <= '1';
          end if;
          s_awready <= '0';
        when c =>
          if (AWVALID_I = '1') then
            USER_AWADDR_O     <= AWADDR_I;
            USER_DATA_VALID_O <= '1';
            s_state           <= d;
            s_bvalid          <= '1';
          end if;
          s_wready <= '0';
        when d =>
          USER_DATA_VALID_O <= '0';
          s_awready         <= '0';
          s_wready          <= '0';
          if (BREADY_I = '1') then
            s_state  <= a;
            s_bvalid <= '0';
          end if;
        when others => null;
      end case;
    end if;
  end process;
--------------------------------------------------------------------------
-- Name       : P_READ_DATA
-- Description: DECODE THE AXI DATA AND GENERATE USER DATA
--------------------------------------------------------------------------      
  P_READ_DATA :
  process (RESETN_I, CLK_I)
  begin
    if RESETN_I = '0' then
      s_rvalid <= '0';
    elsif (RISING_EDGE (CLK_I)) then
      if (ARVALID_I = '1' and s_arready = '1') then
        USER_ARADDR_O <= ARADDR_I;
      end if;
      if (ARVALID_I = '1' and s_arready = '1' and s_rvalid = '0') then
        s_rvalid <= '1';
      elsif (RREADY_I = '1' and s_rvalid = '1') then
        s_rvalid <= '0';
      end if;
    end if;
  end process;
--------------------------------------------------------------------------
-- Name       : P_RESPONSE
-- Description: OUTPUT ON RESPONSE CAHNNEL
--------------------------------------------------------------------------
  P_RESPONSE :
  process (RESETN_I, CLK_I)
  begin
    if RESETN_I = '0' then
      BRESP_O   <= "11";
      s_arready <= '0';
    elsif (RISING_EDGE (CLK_I)) then
      if (AWBURST_I = "01" and AWVALID_I = '1')then
        BRESP_O <= "00";
      else
        BRESP_O <= "10";
      end if;
      s_arready <= '1';
    end if;
  end process;
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
end architecture AXI4LITE_SUB_BLK_BI;
--=================================================================================================
-- File Name                           : AXI4LITE_USR_BLK_BI.vhd

-- Targeted device                     : Microsemi-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2021 BY MICROSEMI
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
--=================================================================================================
-- AXI4LITE_USR_BLK_BI entity declaration
--=================================================================================================
entity AXI4LITE_USR_BLK_BI is
  port (
-- Port list
    -- AXI4 reset
    RESETN_I          : in  std_logic;
    -- AXI4 clock       
    CLK_I             : in  std_logic;
    -- user logic ports -  data valid
    USER_DATA_VALID_I : in  std_logic;
    -- user logic ports - write address
    USER_AWADDR_I     : in  std_logic_vector(31 downto 0);
    -- user logic ports -  write data
    USER_WDATA_I      : in  std_logic_vector(31 downto 0);
    -- user logic ports - read address
    USER_ARADDR_I     : in  std_logic_vector(31 downto 0);
    -- user logic ports - read data     
    USER_RDATA_O      : out std_logic_vector(31 downto 0);

    BAYER_FORMAT_O : out std_logic_vector(1 downto 0)

    );
end AXI4LITE_USR_BLK_BI;
--=================================================================================================
-- AXI4LITE_USR_BLK_BI architecture body
--=================================================================================================
architecture AXI4LITE_USR_BLK_BI of AXI4LITE_USR_BLK_BI is
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
  constant C_BAYER_FORMAT_ADDR : std_logic_vector(11 downto 0) := x"000";
  constant C_USER_ADDR_0       : std_logic_vector(11 downto 0) := x"040";
  constant C_USER_ADDR_1       : std_logic_vector(11 downto 0) := x"044";
  signal s_bayer               : std_logic_vector(31 downto 0);
  signal s_user_data_0         : std_logic_vector(31 downto 0);
  signal s_user_data_1         : std_logic_vector(31 downto 0);
begin
--=================================================================================================
-- Top level output port assignments
--=================================================================================================
  BAYER_FORMAT_O(1 downto 0) <= s_bayer(1 downto 0);
--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
--NA--

--------------------------------------------------------------------------
-- Name       : READ_DECODE_PROC
-- Description: Process implements the AXI4 read operation
--------------------------------------------------------------------------
  WRITE_DECODE_PROC :
  process (RESETN_I, CLK_I)
  begin
    if(RESETN_I = '0')then
      s_bayer(1 downto 0) <= "11";
      s_user_data_0       <= x"01234567";
      s_user_data_1       <= x"89abcdef";

    elsif (CLK_I'event and CLK_I = '1') then
      if (USER_DATA_VALID_I = '1') then
        case USER_AWADDR_I(11 downto 0) is
--------------------
-- C_BAYER_FORMAT_ADDR
--------------------
          when C_BAYER_FORMAT_ADDR(11 downto 0) =>
            s_bayer <= USER_WDATA_I(31 downto 0);
--------------------
-- USER READ WRITE REGISTERS
--------------------
          when C_USER_ADDR_0(11 downto 0) =>
            s_user_data_0 <= USER_WDATA_I(31 downto 0);

          when C_USER_ADDR_1(11 downto 0) =>
            s_user_data_1 <= USER_WDATA_I(31 downto 0);
--------------------
-- OTHERS
--------------------
          when others =>
            null;
        end case;
      end if;
    end if;
  end process;
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : READ_DECODE_PROC
-- Description: Process implements the AXI4 write operation
--------------------------------------------------------------------------
  READ_DECODE_PROC :
  process (USER_ARADDR_I, s_user_data_0, s_user_data_1, s_bayer)
  begin
    case USER_ARADDR_I(11 downto 0) is
--------------------
-- C_RGB_SUM_ADDR
--------------------
      when C_BAYER_FORMAT_ADDR(11 downto 0) =>
        USER_RDATA_O <= s_bayer;
--------------------
-- USER READ WRITE REGISTERS
--------------------
      when C_USER_ADDR_0(11 downto 0) =>
        USER_RDATA_O <= s_user_data_0;

      when C_USER_ADDR_1(11 downto 0) =>
        USER_RDATA_O <= s_user_data_1;
--------------------
-- OTHERS
--------------------
      when others =>
        USER_RDATA_O <= (others => '0');
    end case;
  end process;
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
end architecture AXI4LITE_USR_BLK_BI;
-- ********************************************************************/ 
-- Microsemi Corporation Proprietary and Confidential 
-- Copyright 2020 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
-- Revision Information:        1.0
-- Date:                                    01/22/2021 
-- Description:  AXI4 Streaming Template for synchronous operation
-- This template assume entire system and AXI4 Streaming Bus use the same clock
-- Cross-clock domain handling or back pressure features are NOT supported
--      ** AXI4 Streaming Interface **
--      ACLK            All signals are synchronous to this clock
--      ARESETN         Asynchronous active low reset
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
-- AXI4S_INITIATOR entity declaration
--=================================================================================================
-- Takes native video interface data and converts to AXI4S
entity AXI4S_INITIATOR_BAYER is
  generic(
    G_PIXELS     : integer               := 1;
    -- Specifies the R, G, B pixel data width
    G_DATA_WIDTH : integer range 8 to 96 := 8
    );
  port (
-- Port List 
-- System reset 
    RESETN_I : in std_logic;

    -- System clock
    SYS_CLK_I : in std_logic;
    -- R, G, B Data Input
    DATA_I    : in std_logic_vector(3*G_PIXELS*G_DATA_WIDTH-1 downto 0);

    -- Specifies the input data is valid or not
    DATA_VALID_I : in std_logic;

    -- Specifies the EOF signal
    EOF_I : in std_logic;

    TUSER_O : out std_logic_vector(3 downto 0);

    -- Data input
    TDATA_O : out std_logic_vector(3*G_PIXELS*G_DATA_WIDTH-1 downto 0);

    TSTRB_O : out std_logic_vector(G_DATA_WIDTH/8 - 1 downto 0);

    TKEEP_O : out std_logic_vector(G_DATA_WIDTH/8 - 1 downto 0);

    TLAST_O  : out std_logic;
    -- Specifies the valid control signal
    TVALID_O : out std_logic

    );
end AXI4S_INITIATOR_BAYER;
--=================================================================================================
-- Architecture body
--=================================================================================================
architecture AXI4S_INITIATOR_BAYER of AXI4S_INITIATOR_BAYER is
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
  signal s_data_dly1       : std_logic_vector(3*G_PIXELS*G_DATA_WIDTH-1 downto 0);
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
  s_tvalid_fe <= s_data_valid_dly1 and not(DATA_VALID_I);
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
end AXI4S_INITIATOR_BAYER;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
--=================================================================================================
-- AXI4S_TARGET entity declaration
--=================================================================================================
-- Takes AXI4S and converts to native video interface data
entity AXI4S_TARGET_BAYER is
  generic(
-- Generic List
    G_PIXELS     : integer               := 1;
    -- Specifies the R, G, B pixel data width
    G_DATA_WIDTH : integer range 8 to 96 := 8
    );
  port (
-- Port List 
    -- Data input
    TDATA_I : in std_logic_vector(G_PIXELS*G_DATA_WIDTH-1 downto 0);

    -- Specifies the valid control signal
    TVALID_I : in std_logic;

    TREADY_O : out std_logic;

    TUSER_I : in std_logic_vector(3 downto 0);

    -- R, G, B Data Output
    DATA_O : out std_logic_vector(G_PIXELS*G_DATA_WIDTH-1 downto 0);

    -- Specifies the output data is valid or not
    DATA_VALID_O : out std_logic;

    -- Specifies the EOF signal
    EOF_O : out std_logic

    );
end AXI4S_TARGET_BAYER;
--=================================================================================================
-- Architecture body
--=================================================================================================
architecture AXI4S_TARGET_BAYER of AXI4S_TARGET_BAYER is
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
end AXI4S_TARGET_BAYER;
