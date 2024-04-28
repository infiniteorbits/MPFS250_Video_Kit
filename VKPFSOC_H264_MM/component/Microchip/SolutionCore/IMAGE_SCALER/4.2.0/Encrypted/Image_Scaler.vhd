--=================================================================================================
-- File Name                           : Image_Scaler.vhd
-- Description                         : Supporting both Native mode and AXI4 Stream mode
-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
-- COPYRIGHT 2022 BY MICROCHIP
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROCHIP
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROCHIP FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--=================================================================================================

--=================================================================================================
-- Libraries
--=================================================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

--=================================================================================================
-- Image_Scaler entity declaration
--=================================================================================================                                                                                                         
entity Image_Scaler is
    generic(
    G_DATA_WIDTH         : integer range 8 to 16    := 8;  -- Specifies the data width
    -- Specified size of FIFOs for storing one row of input and output image
    G_INPUT_FIFO_AWIDTH  : integer range 1 to 13    := 13;
    G_OUTPUT_FIFO_AWIDTH : integer range 1 to 13    := 13;
    G_FORMAT             : integer                  := 0;  --  0= Native and 1= AXI4 Stream
    G_HRES_IN            : integer range 0 to 8191  := 1920;
    G_VRES_IN            : integer range 0 to 8191  := 1080;
    G_HRES_OUT           : integer range 0 to 8191  := 1920;
    G_VRES_OUT           : integer range 0 to 8191  := 1072;
    G_HRES_SCALE         : integer range 0 to 65535 := 1023;
    G_VRES_SCALE         : integer range 0 to 65535 := 1030
    );
  port (

    RESETN_I      : in std_logic;       -- System reset    
    IN_VIDEO_CLK_I     : in std_logic;       -- System clock    
    OUT_VIDEO_CLK_I      : in std_logic;       -- IP clock ~200MHz    
    FRAME_START_I : in std_logic;

    TDATA_I  : in  std_logic_vector(3*G_DATA_WIDTH-1 downto 0);  -- Data input to SLAVE    
    TVALID_I : in  std_logic;  -- Specifies the valid control signal to SLAVE
    TUSER_I  : in  std_logic_vector(3 downto 0);
    TREADY_O : out std_logic;

    DATA_VALID_I : in std_logic;  -- Specifies the input data is valid or not        
    DATA_R_I     : in std_logic_vector (G_DATA_WIDTH - 1 downto 0);  -- data input
    DATA_G_I     : in std_logic_vector (G_DATA_WIDTH - 1 downto 0);
    DATA_B_I     : in std_logic_vector (G_DATA_WIDTH - 1 downto 0);

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

    -- Specifies the valid RGB data
    DATA_VALID_O : out std_logic;
    DATA_R_O     : out std_logic_vector(G_DATA_WIDTH-1 downto 0);  -- Filtered Output 
    DATA_G_O     : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
    DATA_B_O     : out std_logic_vector(G_DATA_WIDTH-1 downto 0);

    -- Data output from MASTER
    TDATA_O  : out std_logic_vector(3*G_DATA_WIDTH-1 downto 0);
    TSTRB_O  : out std_logic_vector(G_DATA_WIDTH/8-1 downto 0);
    TKEEP_O  : out std_logic_vector(G_DATA_WIDTH/8-1 downto 0);
    TUSER_O  : out std_logic_vector(3 downto 0);
    TLAST_O  : out std_logic;
    TVALID_O : out std_logic  -- Specifies the valid control signal from MASTER

    );
end Image_Scaler;

--=================================================================================================
-- Image_Scaler architecture body
--=================================================================================================
architecture image_scaler_arch of Image_Scaler is

--=================================================================================================
-- Component declarations
--=================================================================================================

  component Image_Scaler_top
    generic(
      G_DATA_WIDTH         : integer range 8 to 16 := 8;
      G_INPUT_FIFO_AWIDTH  : integer range 1 to 13 := 13;
      G_OUTPUT_FIFO_AWIDTH : integer range 1 to 13 := 13;
      G_FORMAT             : integer               := 0  --  0= Native and 1= AXI4 Stream   
      );
    port (
      RESETN_I     : in std_logic;
      IN_VIDEO_CLK_I    : in std_logic;
      OUT_VIDEO_CLK_I     : in std_logic;
      DATA_VALID_I : in std_logic;

      TDATA_I  : in  std_logic_vector(3*G_DATA_WIDTH-1 downto 0);
      TVALID_I : in  std_logic;
      TUSER_I  : in  std_logic_vector(3 downto 0);
      TREADY_O : out std_logic;

      DATA_R_I : in std_logic_vector (G_DATA_WIDTH - 1 downto 0);
      DATA_G_I : in std_logic_vector (G_DATA_WIDTH - 1 downto 0);
      DATA_B_I : in std_logic_vector (G_DATA_WIDTH - 1 downto 0);

      HORZ_RES_IN_I       : in std_logic_vector(12 downto 0);
      VERT_RES_IN_I       : in std_logic_vector(12 downto 0);
      HORZ_RES_OUT_I      : in std_logic_vector(12 downto 0);
      VERT_RES_OUT_I      : in std_logic_vector(12 downto 0);
      SCALE_FACTOR_HORZ_I : in std_logic_vector(15 downto 0);
      SCALE_FACTOR_VERT_I : in std_logic_vector(15 downto 0);

      DATA_VALID_O : out std_logic;
      DATA_R_O     : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
      DATA_G_O     : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
      DATA_B_O     : out std_logic_vector(G_DATA_WIDTH-1 downto 0);

      -- Data output from MASTER
      TDATA_O  : out std_logic_vector(3*G_DATA_WIDTH-1 downto 0);
      TSTRB_O  : out std_logic_vector(G_DATA_WIDTH/8-1 downto 0);
      TKEEP_O  : out std_logic_vector(G_DATA_WIDTH/8-1 downto 0);
      TUSER_O  : out std_logic_vector(3 downto 0);
      TLAST_O  : out std_logic;
      TVALID_O : out std_logic
      );
  end component Image_Scaler_top;


  component axi4lite_if_image_scaler
      generic (
      G_HRES_IN    : integer range 0 to 8191  := 1920;
      G_VRES_IN    : integer range 0 to 8191  := 1080;
      G_HRES_OUT   : integer range 0 to 8191  := 1920;
      G_VRES_OUT   : integer range 0 to 8191  := 1072;
      G_HRES_SCALE : integer range 0 to 65535 := 1023;
      G_VRES_SCALE : integer range 0 to 65535 := 1030
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

      --Image Scaler input/output
      FRAME_START_I        : in  std_logic;
      image_scaler_ip_en   : out std_logic;
      image_scaler_ip_rstn : out std_logic;
      input_hres           : out std_logic_vector(12 downto 0);
      input_vres           : out std_logic_vector(12 downto 0);
      output_hres          : out std_logic_vector(12 downto 0);
      output_vres          : out std_logic_vector(12 downto 0);
      scale_factor_hres    : out std_logic_vector(15 downto 0);
      scale_factor_vres    : out std_logic_vector(15 downto 0)
      );

  end component axi4lite_if_image_scaler;

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

  signal s_resetn               : std_logic;
  signal s_data_valid           : std_logic;
  signal s_image_scaler_ip_en   : std_logic;
  signal s_image_scaler_ip_rstn : std_logic;
  signal s_horz_res_in          : std_logic_vector (12 downto 0);
  signal s_vert_res_in          : std_logic_vector (12 downto 0);
  signal s_horz_res_out         : std_logic_vector (12 downto 0);
  signal s_vert_res_out         : std_logic_vector (12 downto 0);
  signal s_scale_factor_horz    : std_logic_vector (15 downto 0);
  signal s_scale_factor_vert    : std_logic_vector (15 downto 0);

begin

  s_resetn     <= RESETN_I and (not s_image_scaler_ip_rstn) and (not FRAME_START_I);
  s_data_valid <= DATA_VALID_I and (s_image_scaler_ip_en);

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

  axi4lite_if_image_scaler_inst : axi4lite_if_image_scaler
      generic map (
      G_HRES_IN    => G_HRES_IN,
      G_VRES_IN    => G_VRES_IN,
      G_HRES_OUT   => G_HRES_OUT,
      G_VRES_OUT   => G_VRES_OUT,
      G_HRES_SCALE => G_HRES_SCALE,
      G_VRES_SCALE => G_VRES_SCALE)
    port map (
      ACLK_I               => ACLK_I,
      ARESETN_I            => ARESETN_I,
      awvalid              => awvalid,
      awready              => awready,
      awaddr               => awaddr,
      wdata                => wdata,
      wvalid               => wvalid,
      wready               => wready,
      bresp                => bresp,
      bvalid               => bvalid,
      bready               => bready,
      araddr               => araddr,
      arvalid              => arvalid,
      arready              => arready,
      rready               => rready,
      rdata                => rdata,
      rresp                => rresp,
      rvalid               => rvalid,
      FRAME_START_I        => FRAME_START_I,
      image_scaler_ip_en   => s_image_scaler_ip_en,
      image_scaler_ip_rstn => s_image_scaler_ip_rstn,
      input_hres           => s_horz_res_in,
      input_vres           => s_vert_res_in,
      output_hres          => s_horz_res_out,
      output_vres          => s_vert_res_out,
      scale_factor_hres    => s_scale_factor_horz,
      scale_factor_vres    => s_scale_factor_vert);


  image_scaler_top_inst : Image_Scaler_top
    generic map (
      G_DATA_WIDTH         => G_DATA_WIDTH,
      G_INPUT_FIFO_AWIDTH  => G_INPUT_FIFO_AWIDTH,
      G_OUTPUT_FIFO_AWIDTH => G_OUTPUT_FIFO_AWIDTH,
      G_FORMAT             => G_FORMAT)
    port map (
      RESETN_I            => s_resetn,
      IN_VIDEO_CLK_I           => IN_VIDEO_CLK_I,
      OUT_VIDEO_CLK_I            => OUT_VIDEO_CLK_I,
      DATA_VALID_I        => s_data_valid,
      TDATA_I             => TDATA_I,
      TVALID_I            => TVALID_I,
      TUSER_I             => TUSER_I,
      TREADY_O            => TREADY_O,
      DATA_R_I            => DATA_R_I,
      DATA_G_I            => DATA_G_I,
      DATA_B_I            => DATA_B_I,
      HORZ_RES_IN_I       => s_horz_res_in,
      VERT_RES_IN_I       => s_vert_res_in,
      HORZ_RES_OUT_I      => s_horz_res_out,
      VERT_RES_OUT_I      => s_vert_res_out,
      SCALE_FACTOR_HORZ_I => s_scale_factor_horz,
      SCALE_FACTOR_VERT_I => s_scale_factor_vert,
      DATA_VALID_O        => DATA_VALID_O,
      DATA_R_O            => DATA_R_O,
      DATA_G_O            => DATA_G_O,
      DATA_B_O            => DATA_B_O,
      TDATA_O             => TDATA_O,
      TSTRB_O             => TSTRB_O,
      TKEEP_O             => TKEEP_O,
      TUSER_O             => TUSER_O,
      TLAST_O             => TLAST_O,
      TVALID_O            => TVALID_O);

end image_scaler_arch;



--=================================================================================================
-- Libraries
--=================================================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


package memory_map_image_scaler is

  constant ADDR_DECODER_WIDTH  : natural                                         := 8;  --address values of the registers
  constant IP_VER              : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"00";
  constant C_CTRL_REG          : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"04";
  constant C_INPUT_HRES        : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"08";
  constant C_INPUT_VRES        : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"0c";
  constant C_OUTPUT_HRES       : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"10";
  constant C_OUTPUT_VRES       : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"14";
  constant C_SCALE_FACTOR_HRES : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"18";
  constant C_SCALE_FACTOR_VRES : std_logic_vector(ADDR_DECODER_WIDTH-1 downto 0) := x"1c";

end package memory_map_image_scaler;



-- *************************************************************************************************
-- File Name                           : axi4lite_if_image_scaler.vhd
-- Targeted device                     : Microsemi-SoC
-- Author                              : India Solutions Team
-- COPYRIGHT 2021 BY MICROSEMI
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--*************************************************************************************************

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use work.memory_map_image_scaler.all;


entity axi4lite_if_image_scaler is
  generic (
    G_HRES_IN    : integer range 0 to 8191  := 1920;
    G_VRES_IN    : integer range 0 to 8191  := 1080;
    G_HRES_OUT   : integer range 0 to 8191  := 1920;
    G_VRES_OUT   : integer range 0 to 8191  := 1072;
    G_HRES_SCALE : integer range 0 to 65535 := 1023;
    G_VRES_SCALE : integer range 0 to 65535 := 1030
    );
  port (
    --Clock and reset interface
    ACLK_I    : in  std_logic;
    ARESETN_I : in  std_logic;
    --write address channel
    awvalid : in  std_logic;
    awready : out std_logic;
    awaddr  : in  std_logic_vector(31 downto 0);
    --write data channel
    wdata   : in  std_logic_vector(31 downto 0);
    wvalid  : in  std_logic;
    wready  : out std_logic;
    -- write response channel
    bresp   : out std_logic_vector(1 downto 0);
    bvalid  : out std_logic;
    bready  : in  std_logic;
    -- Read address channel
    araddr  : in  std_logic_vector(31 downto 0);
    arvalid : in  std_logic;
    arready : out std_logic;
    -- Read data and response channel
    rready  : in  std_logic;
    rdata   : out std_logic_vector(31 downto 0);
    rresp   : out std_logic_vector(1 downto 0);
    rvalid  : out std_logic;

    --Image Scaler input/output
    FRAME_START_I        : in  std_logic;
    image_scaler_ip_en   : out std_logic;
    image_scaler_ip_rstn : out std_logic;
    input_hres           : out std_logic_vector(12 downto 0);
    input_vres           : out std_logic_vector(12 downto 0);
    output_hres          : out std_logic_vector(12 downto 0);
    output_vres          : out std_logic_vector(12 downto 0);
    scale_factor_hres    : out std_logic_vector(15 downto 0);
    scale_factor_vres    : out std_logic_vector(15 downto 0)

    );

end entity axi4lite_if_image_scaler;


architecture axi4lite_if_image_scaler_arc of axi4lite_if_image_scaler is

  component axi4lite_adapter_image_scaler is
    port (
      --Clock and reset interface
      ACLK_I         : in  std_logic;
      ARESETN_I      : in  std_logic;
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
  end component axi4lite_adapter_image_scaler;

  component write_reg_image_scaler is
     generic (
      G_HRES_IN    : integer range 0 to 8191  := 1920;
      G_VRES_IN    : integer range 0 to 8191  := 1080;
      G_HRES_OUT   : integer range 0 to 8191  := 1920;
      G_VRES_OUT   : integer range 0 to 8191  := 1072;
      G_HRES_SCALE : integer range 0 to 65535 := 1023;
      G_VRES_SCALE : integer range 0 to 65535 := 1030
      );
    port (
      ACLK_I                 : in  std_logic;
      ARESETN_I              : in  std_logic;
      mem_wr_valid         : in  std_logic;
      mem_wr_addr          : in  std_logic_vector(31 downto 0);
      mem_wr_data          : in  std_logic_vector(31 downto 0);
      FRAME_START_I        : in  std_logic;
      image_scaler_ip_en   : out std_logic;
      image_scaler_ip_rstn : out std_logic;
      input_hres           : out std_logic_vector(12 downto 0);
      input_vres           : out std_logic_vector(12 downto 0);
      output_hres          : out std_logic_vector(12 downto 0);
      output_vres          : out std_logic_vector(12 downto 0);
      scale_factor_hres    : out std_logic_vector(15 downto 0);
      scale_factor_vres    : out std_logic_vector(15 downto 0)
      );
  end component write_reg_image_scaler;


  component read_reg_image_scaler is
    port (
      mem_rd_addr : in  std_logic_vector(31 downto 0);
      mem_rd_data : out std_logic_vector(31 downto 0);
      ctrl_reg    : in  std_logic_vector(1 downto 0)
      );
  end component read_reg_image_scaler;

  signal s_mem_wr_valid : std_logic;
  signal s_mem_wr_addr  : std_logic_vector(31 downto 0);
  signal s_mem_wr_data  : std_logic_vector(31 downto 0);
  signal s_mem_rd_addr  : std_logic_vector(31 downto 0);
  signal s_mem_rd_data  : std_logic_vector(31 downto 0);
  signal s_ARESETN_I      : std_logic;
  signal s_ctrl_reg     : std_logic_vector(1 downto 0);

begin  -- architecture axi4lite_if_image_scaler_arc


  s_ctrl_reg(0) <= image_scaler_ip_en;
  s_ctrl_reg(1) <= not image_scaler_ip_rstn;
  s_ARESETN_I <= (not image_scaler_ip_rstn) and ARESETN_I;    
  
  axi4lite_adapter_image_scaler_inst : axi4lite_adapter_image_scaler
    port map (
       ACLK_I         => ACLK_I,
      ARESETN_I      => ARESETN_I,
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

  read_reg_image_scaler_inst : read_reg_image_scaler
    port map (
      mem_rd_addr => s_mem_rd_addr,
      mem_rd_data => s_mem_rd_data,
      ctrl_reg    => s_ctrl_reg);

  write_reg_image_scaler_inst : write_reg_image_scaler
     generic map (
      G_HRES_IN    => G_HRES_IN,
      G_VRES_IN    => G_VRES_IN,
      G_HRES_OUT   => G_HRES_OUT,
      G_VRES_OUT   => G_VRES_OUT,
      G_HRES_SCALE => G_HRES_SCALE,
      G_VRES_SCALE => G_VRES_SCALE)
    port map (
      ACLK_I                 => ACLK_I,
      ARESETN_I              => s_ARESETN_I,
      mem_wr_valid         => s_mem_wr_valid,
      mem_wr_addr          => s_mem_wr_addr,
      mem_wr_data          => s_mem_wr_data,
      FRAME_START_I        => FRAME_START_I,
      image_scaler_ip_en   => image_scaler_ip_en,
      image_scaler_ip_rstn => image_scaler_ip_rstn,
      input_hres           => input_hres,
      input_vres           => input_vres,
      output_hres          => output_hres,
      output_vres          => output_vres,
      scale_factor_hres    => scale_factor_hres,
      scale_factor_vres    => scale_factor_vres
      );

end architecture axi4lite_if_image_scaler_arc;



-- *************************************************************************************************
-- File Name                           : axi4lite_adapter_image_scaler.vhd
-- Targeted device                     : Microsemi-SoC
-- Author                              : India Solutions Team
-- COPYRIGHT 2021 BY MICROSEMI
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--*************************************************************************************************


library IEEE;
use IEEE.std_logic_1164.all;

entity axi4lite_adapter_image_scaler is
  port (
    --Clock and reset interface
    ACLK_I         : IN  STD_LOGIC;
    ARESETN_I      : IN  STD_LOGIC;
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

end entity axi4lite_adapter_image_scaler;

architecture axi4lite_adapter_image_scaler_arch of axi4lite_adapter_image_scaler is

  signal s_awaddr        : std_logic_vector(31 downto 0);
  signal s_araddr        : std_logic_vector(31 downto 0);
  signal s_raddr_phs_cmp : std_logic;


begin  -- architecture axi4lite_adapter_image_scaler_arch

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
    if ARESETN_I = '0' then                 -- asynchronous reset (active low)
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
    if ARESETN_I = '0' then                 -- asynchronous reset (active low)
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
    if ARESETN_I = '0' then                 -- asynchronous reset (active low)
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
    if ARESETN_I = '0' then                 -- asynchronous reset (active low)
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
    if ARESETN_I = '0' then                 -- asynchronous reset (active low)
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
    if ARESETN_I = '0' then                 -- asynchronous reset (active low)
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
    if ARESETN_I = '0' then                 -- asynchronous reset (active low)
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

end architecture axi4lite_adapter_image_scaler_arch;




--*************************************************************************************************
-- File Name                           : write_reg_image_scaler.vhd
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
use work.memory_map_image_scaler.all;
use ieee.numeric_std.all;


entity write_reg_image_scaler is
   generic (
    G_HRES_IN    : integer range 0 to 8191  := 1920;
    G_VRES_IN    : integer range 0 to 8191  := 1080;
    G_HRES_OUT   : integer range 0 to 8191  := 1920;
    G_VRES_OUT   : integer range 0 to 8191  := 1072;
    G_HRES_SCALE : integer range 0 to 65535 := 1023;
    G_VRES_SCALE : integer range 0 to 65535 := 1030
    );
  port (
    ACLK_I                 : in  std_logic;
    ARESETN_I              : in  std_logic;
    mem_wr_valid         : in  std_logic;
    mem_wr_addr          : in  std_logic_vector(31 downto 0);
    mem_wr_data          : in  std_logic_vector(31 downto 0);
    FRAME_START_I        : in  std_logic;
    image_scaler_ip_en   : out std_logic;
    image_scaler_ip_rstn : out std_logic;
    input_hres           : out std_logic_vector(12 downto 0);
    input_vres           : out std_logic_vector(12 downto 0);
    output_hres          : out std_logic_vector(12 downto 0);
    output_vres          : out std_logic_vector(12 downto 0);
    scale_factor_hres    : out std_logic_vector(15 downto 0);
    scale_factor_vres    : out std_logic_vector(15 downto 0)

    );

end entity write_reg_image_scaler;

architecture write_reg_image_scaler_arch of write_reg_image_scaler is

  signal s_input_hres        : std_logic_vector(12 downto 0);
  signal s_input_vres        : std_logic_vector(12 downto 0);
  signal s_output_hres       : std_logic_vector(12 downto 0);
  signal s_output_vres       : std_logic_vector(12 downto 0);
  signal s_scale_factor_hres : std_logic_vector(15 downto 0);
  signal s_scale_factor_vres : std_logic_vector(15 downto 0);

begin  -- architecture write_reg_image_scaler_arch

  image_scaler_ip_rstn <= mem_wr_data(1) when (mem_wr_addr(ADDR_DECODER_WIDTH-1 downto 0) = C_CTRL_REG and mem_wr_valid = '1') else
                          '0';


  -----------------------------------------------------------------------------
  -- Write signal registers
  -----------------------------------------------------------------------------
  -- purpose: Write registers
  -- type   : sequential
  -- inputs : ACLK_I, ARESETN_I, mem_wr_valid
  -- outputs: 
  write_tmp_p : process (ACLK_I, ARESETN_I) is
  begin  -- process write_p
    if ARESETN_I = '0' then                 -- asynchronous reset (active low)
         input_hres        <= std_logic_vector(to_unsigned(G_HRES_IN, 13));
      input_vres        <= std_logic_vector(to_unsigned(G_VRES_IN, 13));
      output_hres       <= std_logic_vector(to_unsigned(G_HRES_OUT, 13));
      output_vres       <= std_logic_vector(to_unsigned(G_VRES_OUT, 13));
      scale_factor_hres <= std_logic_vector(to_unsigned(G_HRES_SCALE, 16));
      scale_factor_vres <= std_logic_vector(to_unsigned(G_VRES_SCALE, 16));
    elsif ACLK_I'event and ACLK_I = '1' then  -- rising clock edge
      if FRAME_START_I = '1' then
        input_hres        <= s_input_hres;
        input_vres        <= s_input_vres;
        output_hres       <= s_output_hres;
        output_vres       <= s_output_vres;
        scale_factor_vres <= s_scale_factor_vres;
        scale_factor_hres <= s_scale_factor_hres;
      end if;

    end if;
  end process write_tmp_p;

  -----------------------------------------------------------------------------
  -- Write signal registers
  -----------------------------------------------------------------------------
  -- purpose: Write registers
  -- type   : sequential
  -- inputs : ACLK_I, ARESETN_I, mem_wr_valid
  -- outputs: 
  write_p : process (ACLK_I, ARESETN_I) is
  begin  -- process write_p
    if ARESETN_I = '0' then                 -- asynchronous reset (active low)
      image_scaler_ip_en  <= '1';
      s_input_hres        <= std_logic_vector(to_unsigned(G_HRES_IN, 13));
      s_input_vres        <= std_logic_vector(to_unsigned(G_VRES_IN, 13));
      s_output_hres       <= std_logic_vector(to_unsigned(G_HRES_OUT, 13));
      s_output_vres       <= std_logic_vector(to_unsigned(G_VRES_OUT, 13));
      s_scale_factor_hres <= std_logic_vector(to_unsigned(G_HRES_SCALE, 16));
      s_scale_factor_vres <= std_logic_vector(to_unsigned(G_VRES_SCALE, 16));
    elsif ACLK_I'event and ACLK_I = '1' then  -- rising clock edge
      if mem_wr_valid = '1' then

        case mem_wr_addr(ADDR_DECODER_WIDTH-1 downto 0) is

          when C_CTRL_REG =>
            image_scaler_ip_en <= mem_wr_data(0) and (not mem_wr_data(1));

          when C_INPUT_HRES =>
            s_input_hres <= mem_wr_data(12 downto 0);

          when C_INPUT_VRES =>
            s_input_vres <= mem_wr_data(12 downto 0);

          when C_OUTPUT_HRES =>
            s_output_hres <= mem_wr_data(12 downto 0);

          when C_OUTPUT_VRES =>
            s_output_vres <= mem_wr_data(12 downto 0);

          when C_SCALE_FACTOR_HRES =>
            s_scale_factor_hres <= mem_wr_data(15 downto 0);

          when C_SCALE_FACTOR_VRES =>
            s_scale_factor_vres <= mem_wr_data(15 downto 0);


          when others => null;
        end case;
      end if;
    end if;
  end process write_p;

end architecture write_reg_image_scaler_arch;



--*************************************************************************************************
-- File Name                           : read_reg_image_scaler.vhd
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
use work.memory_map_image_scaler.all;
use ieee.numeric_std.all;

entity read_reg_image_scaler is
  port (
    mem_rd_addr : in  std_logic_vector(31 downto 0);
    mem_rd_data : out std_logic_vector(31 downto 0);
    ctrl_reg    : in  std_logic_vector(1 downto 0)
    );

end entity read_reg_image_scaler;


architecture read_reg_image_scaler_arch of read_reg_image_scaler is

begin  -- architecture read_reg_image_scaler_arch

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
        mem_rd_data(15 downto 8)  <= x"02";
        mem_rd_data(7 downto 0)   <= x"00";

      when C_CTRL_REG =>
        mem_rd_data(31 downto 2) <= (others => '0');
        mem_rd_data(1 downto 0)  <= ctrl_reg;

      when others =>
        mem_rd_data <= (others => '0');

    end case;
  end process read_p;

end architecture read_reg_image_scaler_arch;





--=================================================================================================
-- File Name                           : Image_Scaler.vhd
-- Description                         : Supporting both Native mode and AXI4 Stream mode
-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
-- COPYRIGHT 2022 BY MICROCHIP
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROCHIP
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROCHIP FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--=================================================================================================
--=================================================================================================
-- Libraries
--=================================================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
--=================================================================================================
-- Image_Scaler entity declaration
--=================================================================================================

entity Image_Scaler_top is
  generic(
    G_DATA_WIDTH         : integer range 8 to 16 := 8;
    -- Specified size of FIFOs for storing one row of input and output image
    G_INPUT_FIFO_AWIDTH  : integer range 1 to 13 := 13;
    G_OUTPUT_FIFO_AWIDTH : integer range 1 to 13 := 13;
    G_FORMAT             : integer               := 0  --  0= Native and 1= AXI4 Stream   
    );
  port (
    -- System reset
    RESETN_I  : in std_logic;
    IN_VIDEO_CLK_I : in std_logic;
    OUT_VIDEO_CLK_I  : in std_logic;

    -- Data input to SLAVE
    TDATA_I  : in  std_logic_vector(3*G_DATA_WIDTH-1 downto 0);
    TVALID_I : in  std_logic;
    TUSER_I  : in  std_logic_vector(3 downto 0);
    TREADY_O : out std_logic;

    -- Specifies the input data is valid or not
    DATA_VALID_I : in std_logic;
    DATA_R_I     : in std_logic_vector (G_DATA_WIDTH - 1 downto 0);
    DATA_G_I     : in std_logic_vector (G_DATA_WIDTH - 1 downto 0);
    DATA_B_I     : in std_logic_vector (G_DATA_WIDTH - 1 downto 0);

    HORZ_RES_IN_I       : in  std_logic_vector(12 downto 0);
    VERT_RES_IN_I       : in  std_logic_vector(12 downto 0);
    HORZ_RES_OUT_I      : in  std_logic_vector(12 downto 0);
    VERT_RES_OUT_I      : in  std_logic_vector(12 downto 0);
    SCALE_FACTOR_HORZ_I : in  std_logic_vector(15 downto 0);
    SCALE_FACTOR_VERT_I : in  std_logic_vector(15 downto 0);
    -- Specifies the valid RGB data
    DATA_VALID_O        : out std_logic;
    -- Filtered Output 
    DATA_R_O            : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
    DATA_G_O            : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
    DATA_B_O            : out std_logic_vector(G_DATA_WIDTH-1 downto 0);

    -- Data output from MASTER
    TDATA_O : out std_logic_vector(3*G_DATA_WIDTH-1 downto 0);
    TSTRB_O : out std_logic_vector(G_DATA_WIDTH/8-1 downto 0);
    TKEEP_O : out std_logic_vector(G_DATA_WIDTH/8-1 downto 0);
    TUSER_O : out std_logic_vector(3 downto 0);
    TLAST_O : out std_logic;

    -- Specifies the valid control signal from MASTER
    TVALID_O : out std_logic
    );
end Image_Scaler_top;

--=================================================================================================
-- Image_Scaler architecture body
--=================================================================================================
architecture image_scaler_top_arch of Image_Scaler_top is

--=================================================================================================
-- Component declarations
--=================================================================================================
  component IMAGE_SCALER_Native
    generic(
      G_DATA_WIDTH         : integer range 8 to 16 := 8;
      G_INPUT_FIFO_AWIDTH  : integer range 1 to 16 := 11;
      G_OUTPUT_FIFO_AWIDTH : integer range 1 to 16 := 10
      );
    port (
      IN_VIDEO_CLK_I           : in  std_logic;
      RESETN_I            : in  std_logic;
      OUT_VIDEO_CLK_I            : in  std_logic;
      DATA_VALID_I        : in  std_logic;
      DATA_R_I            : in  std_logic_vector(G_DATA_WIDTH-1 downto 0);
      DATA_G_I            : in  std_logic_vector(G_DATA_WIDTH-1 downto 0);
      DATA_B_I            : in  std_logic_vector(G_DATA_WIDTH-1 downto 0);
      HORZ_RES_IN_I       : in  std_logic_vector(12 downto 0);
      VERT_RES_IN_I       : in  std_logic_vector(12 downto 0);
      HORZ_RES_OUT_I      : in  std_logic_vector(12 downto 0);
      VERT_RES_OUT_I      : in  std_logic_vector(12 downto 0);
      SCALE_FACTOR_HORZ_I : in  std_logic_vector(15 downto 0);
      SCALE_FACTOR_VERT_I : in  std_logic_vector(15 downto 0);
      DATA_R_O            : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
      DATA_G_O            : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
      DATA_B_O            : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
      DATA_VALID_O        : out std_logic
      );
  end component;

  component AXI4S_INITIATOR_SCALER
    generic(
      G_DATA_WIDTH : integer range 8 to 96 := 8
      );
    port (
      RESETN_I     : in  std_logic;
      IN_VIDEO_CLK_I    : in  std_logic;
      DATA_I       : in  std_logic_vector(3*G_DATA_WIDTH-1 downto 0);
      DATA_VALID_I : in  std_logic;
      EOF_I        : in  std_logic;
      TDATA_O      : out std_logic_vector(3*G_DATA_WIDTH-1 downto 0);
      TUSER_O      : out std_logic_vector(3 downto 0);
      TSTRB_O      : out std_logic_vector(G_DATA_WIDTH/8-1 downto 0);
      TKEEP_O      : out std_logic_vector(G_DATA_WIDTH/8-1 downto 0);
      TLAST_O      : out std_logic;
      TVALID_O     : out std_logic
      );
  end component;

  component AXI4S_TARGET_SCALER
    generic(
      G_DATA_WIDTH : integer range 8 to 96 := 8
      );
    port (
      TDATA_I      : in  std_logic_vector(3*G_DATA_WIDTH-1 downto 0);
      TVALID_I     : in  std_logic;
      TUSER_I      : in  std_logic_vector(3 downto 0);
      TREADY_O     : out std_logic;
      EOF_O        : out std_logic;
      DATA_O       : out std_logic_vector(3*G_DATA_WIDTH-1 downto 0);
      DATA_VALID_O : out std_logic
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
  signal s_dvalid_tar        : std_logic;
  signal s_dvalid_init       : std_logic;
  signal s_eof               : std_logic;
  signal s_data_o            : std_logic_vector (3*G_DATA_WIDTH - 1 downto 0);
  signal s_data_init         : std_logic_vector (3*G_DATA_WIDTH - 1 downto 0);
  signal s_horz_res_in       : std_logic_vector (12 downto 0);
  signal s_vert_res_in       : std_logic_vector (12 downto 0);
  signal s_horz_res_out      : std_logic_vector (12 downto 0);
  signal s_vert_res_out      : std_logic_vector (12 downto 0);
  signal s_scale_factor_horz : std_logic_vector (15 downto 0);
  signal s_scale_factor_vert : std_logic_vector (15 downto 0);
  signal s_red               : std_logic_vector (G_DATA_WIDTH - 1 downto 0);
  signal s_green             : std_logic_vector (G_DATA_WIDTH - 1 downto 0);
  signal s_blue              : std_logic_vector (G_DATA_WIDTH - 1 downto 0);

  signal s_red_axi   : std_logic_vector (G_DATA_WIDTH-1 downto 0);
  signal s_green_axi : std_logic_vector (G_DATA_WIDTH-1 downto 0);
  signal s_blue_axi  : std_logic_vector (G_DATA_WIDTH-1 downto 0);

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

  Image_Scaler_Native_AXI4L_FORMAT : if G_FORMAT = 0 generate
    IMAGE_SCALER_Native_AXI4L_INST : IMAGE_SCALER_Native
      generic map(
        G_DATA_WIDTH         => G_DATA_WIDTH,
        G_INPUT_FIFO_AWIDTH  => G_INPUT_FIFO_AWIDTH,
        G_OUTPUT_FIFO_AWIDTH => G_OUTPUT_FIFO_AWIDTH
        )
      port map(
        IN_VIDEO_CLK_I           => IN_VIDEO_CLK_I,
        RESETN_I            => RESETN_I,
        DATA_VALID_I        => DATA_VALID_I,
        OUT_VIDEO_CLK_I            => OUT_VIDEO_CLK_I,
        DATA_R_I            => DATA_R_I,
        DATA_G_I            => DATA_G_I,
        DATA_B_I            => DATA_B_I,
        HORZ_RES_IN_I       => HORZ_RES_IN_I,
        VERT_RES_IN_I       => VERT_RES_IN_I,
        HORZ_RES_OUT_I      => HORZ_RES_OUT_I,
        VERT_RES_OUT_I      => VERT_RES_OUT_I,
        SCALE_FACTOR_HORZ_I => SCALE_FACTOR_HORZ_I,
        SCALE_FACTOR_VERT_I => SCALE_FACTOR_VERT_I,
        DATA_R_O            => DATA_R_O,
        DATA_G_O            => DATA_G_O,
        DATA_B_O            => DATA_B_O,
        DATA_VALID_O        => DATA_VALID_O
        );
  end generate;


  Image_Scaler_AXI4S_AXI4L_FORMAT : if G_FORMAT = 1 generate

    IMAGE_SCALER_AXI4S_TAR_INST : AXI4S_TARGET_SCALER
      generic map(
        G_DATA_WIDTH => G_DATA_WIDTH
        )
      port map(
        TVALID_I     => TVALID_I,
        TDATA_I      => TDATA_I,
        TUSER_I      => TUSER_I,
        TREADY_O     => TREADY_O,
        EOF_O        => s_eof,
        DATA_VALID_O => s_dvalid_tar,
        DATA_O       => s_data_o
        );

    IMAGE_SCALER_AXI4S_AXI4L_INST : IMAGE_SCALER_Native
      generic map(
        G_DATA_WIDTH         => G_DATA_WIDTH,
        G_INPUT_FIFO_AWIDTH  => G_INPUT_FIFO_AWIDTH,
        G_OUTPUT_FIFO_AWIDTH => G_OUTPUT_FIFO_AWIDTH
        )
      port map(
        IN_VIDEO_CLK_I           => IN_VIDEO_CLK_I,
        RESETN_I            => RESETN_I,
        DATA_VALID_I        => s_dvalid_tar,
        OUT_VIDEO_CLK_I            => OUT_VIDEO_CLK_I,
        DATA_R_I            => s_red,
        DATA_G_I            => s_green,
        DATA_B_I            => s_blue,
        HORZ_RES_IN_I       => HORZ_RES_IN_I,
        VERT_RES_IN_I       => VERT_RES_IN_I,
        HORZ_RES_OUT_I      => HORZ_RES_OUT_I,
        VERT_RES_OUT_I      => VERT_RES_OUT_I,
        SCALE_FACTOR_HORZ_I => SCALE_FACTOR_HORZ_I,
        SCALE_FACTOR_VERT_I => SCALE_FACTOR_VERT_I,
        DATA_R_O            => s_red_axi,
        DATA_G_O            => s_green_axi,
        DATA_B_O            => s_blue_axi,
        DATA_VALID_O        => s_dvalid_init
        );


    IMAGE_SCALER_AXI4_INIT_INST : AXI4S_INITIATOR_SCALER
      generic map(
        G_DATA_WIDTH => G_DATA_WIDTH
        )
      port map(
        IN_VIDEO_CLK_I    => IN_VIDEO_CLK_I,
        RESETN_I     => RESETN_I,
        DATA_VALID_I => s_dvalid_init,
        DATA_I       => s_data_init,
        EOF_I        => s_eof,
        TUSER_O      => TUSER_O,
        TLAST_O      => TLAST_O,
        TSTRB_O      => TSTRB_O,
        TKEEP_O      => TKEEP_O,
        TVALID_O     => TVALID_O,
        TDATA_O      => TDATA_O
        );
  end generate;

  -----------------------------------------------------------------------------
  -- Separating R G and B signals from AXI4 Stream interface
  -----------------------------------------------------------------------------
  s_red   <= s_data_o ((3*G_DATA_WIDTH - 1) downto (3*G_DATA_WIDTH - 1)- (G_DATA_WIDTH-1));
  s_green <= s_data_o (((3*G_DATA_WIDTH - 1) - G_DATA_WIDTH) downto G_DATA_WIDTH);
  s_blue  <= s_data_o (G_DATA_WIDTH - 1 downto 0);

  ---------------------------------------------------------------------------
  -- Combining R G and B signals for AXI4 Stream transmission
  ---------------------------------------------------------------------------
  s_data_init <= s_red_axi & s_green_axi & s_blue_axi;

end image_scaler_top_arch;

-- ********************************************************************/ 
-- Microchip Corporation Proprietary and Confidential 
-- Copyright 2022 Microchip Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE MICROCHIP LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
-- Revision Information:        2.2
-- Date:                                    7/13/2020 
-- Description:  Bilinear Image & Video Scaler
-- Limitations:
--              4K resolution is 3840x2160 or 4096x2160
--              Image width  (input and output) [8,4096]  2^12 (12-bit pixel index)
--              Image height (input and output) [8,4096]  2^12 (12-bit pixel index)
--              Scale factor (x and y)          [1/64,64] 2^6 * 2^10 (10-bit shift for down scale factors)
--              Pixel values are fixed at 8, 10, 12, 14 or 16-bit (only 8-bit is tested)
--              Output Image Dimensions must be a multiple of 4
--              PolarFire Math Block supports up to 17x17 unsigned multiplier
-- Recommendations:
--              Bilinear scaling works best when scale factors are between [0.5,2.0]
--              Crop original image to the output width:height before scaling
-- Notation:
--              XYZ13LS indicates a variable holding 13-bit left shifted value of XYZ
-- Update History:
--              09/19 - Initial release includes BILINEAR_INTERP                                
--              10/02 - Planned support for variable pixel bit width [8 10 12 16], min & max saturation of output
--              10/14 - Passing RGB image, implementing feedback control signal between SCALE_FACTOR_GEN, BILINEAR_INTERP 
--              10/15 - Separated calculations that are common to all color pixels in to SCALE_FACTOR_GEN
--              10/17 - Downscaling 640x480 to 320x240 RTL simulation passes
--      10/30 - Updated design to receive and process R, G & B pixels concurrently
--              11/22 - Updated design to store and transmit entire row of output image
--              03/02 - Support wider scaling range [1/64,64]
--      03/02 - Switch to using input ports in place of generics for image res, scale factors
--              03/05 - Resize resolution input ports to 16 bits
--              03/11 - Revert 03/05 change - input ports are back to 13 bits
--      03/19 - Input and Output FIFO size available as top level generics
--              03/20 - Reduce Input RAM usage with shift register
--              03/21 - X3_ENGINE can compute up to 3 output pixels belonging to the same row
--              04/11 - Parameterized design using if loop, generate
--      04/27 - Integrated VIDEO_FIFO_INTF to generate 4 pixels of data for store & forward VIDEO_FIFO
--              05/11 - 3 Instances of X3_ENGINE to support parallel computation of up to 3 rows
--              05/19 - Upscaler 2X RTL Simulation passes
--              06/23 - Reduced bit precision of scale factor to reduce DSP count
--              07/31 - Switch to time multiplexing architecture
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
-- IMAGE_SCALER_Native entity declaration
--=================================================================================================
entity IMAGE_SCALER_Native is
  generic(
-- Generic List
    -- Specifies the data width !! Only 8-bit support is tested !!
    G_DATA_WIDTH : integer range 8 to 16 := 8;

    -- Specified size of FIFOs for storing one row of input and output image
    G_INPUT_FIFO_AWIDTH  : integer range 1 to 16 := 11;
    G_OUTPUT_FIFO_AWIDTH : integer range 1 to 16 := 10
    );
  port (
-- Port List
    -- System reset
    RESETN_I : in std_logic;

    -- System / Pixel clock
    IN_VIDEO_CLK_I : in std_logic;

    -- IP clock ~200MHz
    OUT_VIDEO_CLK_I : in std_logic;

    -- Specifies the input data is valid or not
    DATA_VALID_I : in std_logic;

    -- Data input
    DATA_R_I : in std_logic_vector(G_DATA_WIDTH-1 downto 0);
    DATA_G_I : in std_logic_vector(G_DATA_WIDTH-1 downto 0);
    DATA_B_I : in std_logic_vector(G_DATA_WIDTH-1 downto 0);

    HORZ_RES_IN_I  : in std_logic_vector(12 downto 0);
    VERT_RES_IN_I  : in std_logic_vector(12 downto 0);
    HORZ_RES_OUT_I : in std_logic_vector(12 downto 0);
    VERT_RES_OUT_I : in std_logic_vector(12 downto 0);

    -- Scale factors
    SCALE_FACTOR_HORZ_I : in std_logic_vector(15 downto 0);
    SCALE_FACTOR_VERT_I : in std_logic_vector(15 downto 0);

    -- Specifies the valid control signal for scaled data
    DATA_VALID_O : out std_logic;

    -- Scaled data output
    DATA_R_O : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
    DATA_G_O : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
    DATA_B_O : out std_logic_vector(G_DATA_WIDTH-1 downto 0)
    );
end IMAGE_SCALER_Native;

`protect begin_protected
`protect version=1
`protect author="author-a", author_info="author-a-details"
`protect encrypt_agent="encryptP1735.pl", encrypt_agent_info="Synplify encryption scripts"

`protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=256)
`protect key_block
hPKMWw6wBVAOx/HJgA6U0WU4JsTpCRrbAXvYAiw9eyUqlV6JQ/rrle/GWZga+7HqPQzLkKnrEwdc
8LqIwqu7l1ofjjwMSIEjP4b/C8pozW7Ps6sIkcYwwyXcE96RZvvGEN8m8E1Xr4XT+ShfODq6p1uZ
B57Op5K8xyC8LMieXD9TPUVuXYPOsnun8/Z5ndCouOoUvdOOFy1j5LhzqBuzb6E60wQa7Qj4DUkC
41mkfjEWJj5iX7RGKlt8lihKo21GhN/pql/t5DpwVMUcSZHPDMfpbz2kPmZ9SZunkd6b/F8afmSJ
rkmTsoRVmgcbwvjQ9AYchDnPp3xzFozDRDZz3A==

`protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=128)
`protect key_block
dClrAV9ETX1Tf7DTh4STSXemN2TVNhFZcU0xGC6DN6MANUL8FGpCh6uxjxrjzA/FmRF6/f/e5CGo
VAlicSHbROGY+FZWLO3EggWmpYzoGHw4d4QjTB7pROYEghFKDoyj6ZFV5+GiahYA6zTlwNg3PqMv
1XE2dJgHF1nKgc4xBH4=

`protect key_keyowner="Microsemi Corporation", key_keyname="MSC-IP-KEY-RSA", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=960)
`protect key_block
GVCPZkvAJNVrG8iLjiF0byOdUV3mBy2Q0kX8QUM0mBME6sbWFr/9nRpgV1YyZnQbQm4bQmyfYkOl
vyUOq5Jn0LhfASoC0+Z4Uu1RX3NsGzI6OieVkFL/JsQmJbk4iIVmbSGiCl9PcHqHjF2qaTVsU9jC
5pz9I1PSguF/la9HTooyvYkGLRqiOd14HXvpTJ4AsOrLTP8fqMx5+C6ha0QZzJcKrVVytZzts9/a
lxT4oQ0tr/DtHLhF9r3WgPPs9hbqvPj3mg582Tvcmi0cnhRqKq99wYskau/6KUevghNy4IaVxfDS
nSGlQgQH567WqzQ+kBR1yZN6UwXoSUjkRwyxXkwn/9Sf7VBv/xrpvUQhElJ+oeRKSzymK/iT/CaW
FNJcC56aqQ64EW8EJWxOiseZM2UawETV0zjk8fhKd0OfmvEr5/gD6FuIIpl4Et/jRbqwzt6/A613
3XLxGR3NpJN3P8tm+wEhC1niUvvNvnsUPJtqI9mFJ10BlAtrnttctG/9LtKWcni3bF4E3t7i5FA3
n6wGboyZX1sAuzcOq9J17TNLuJsguT4T743Vh5o22zesAbzYzisrNy+pcLO6wbwUMyXSP1ixQ0pK
smZGt57g6hB10N98HUlfAAJWsUgiTMkiEyBg8VQd/wYMlXSGaTkYfV8e985ySTdtSrCJDvJb1ZFU
AxxNJnnW15zBUoXKWKLlzHA7LdTEoQGkhqm57vpvCIlTOycgkP4biw8JAhvWoJlwQqfzyU3vPy/N
tqEwEKrDnPmk7LeYco9Uy+ENnz9MXAWCPdx+vtQ/YnQNCrolV3U9eB1ob42otNQliipvBYGoSD/7
k0WWz2nnwqbj9e/qjNqcf/3cWlMnBoJBLtnozrOtxpFXqcy5vXlZT4FxUnU0prOKx9wZ3BQkibn9
foNM4mSorcWJS97XE6t3DbS9wtxefFS5v6CmBrNlxOaXzZBBGn3UlfwHAXlpCD8br4sjdAAKFMmh
2BlmEtuDDuo2Uz8ueVO22b4bS4ATOp0Aihgrp6loB+lhneWOEdg4q0vj6iF0BmLQTjIwCLI7YbMm
/uW4wh2OcnJrH4X+Hxw4j16GFkGFIn7WQv6XA27lOQji7KGFcSY8f11kI88qRy7Ye4VkMntGqHnN
PqlZd531qGTuZ41Ka/ofF5zJMdDt17Bsa8DFXtqnwG1ePqp2I0oqsN5usbmETMnJsEPnK5OTBqQH
KpH3jJ2qbViSMHkhVlakWT4cjFUxiFH+vYdtxTeh1ibwzy65BFM4vA2TbIsLY5Qj

`protect data_keyowner="ip-vendor-a", data_keyname="fpga-ip", data_method="aes128-cbc"
`protect encoding=(enctype="base64", line_length=76, bytes=79088)
`protect data_block
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
Dg7Yhv5oVj/4AHiNGyvpC/VkSHc2dQRRcUAMIfQ=

`protect end_protected

-- ********************************************************************/ 
-- Microchip Corporation Proprietary and Confidential 
-- Copyright 2022 Microchip Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE MICROCHIP LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
-- Revision Information:        1.0
-- Date:                                    01/22/2022 
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
-- AXI4S_MSTR entity declaration
--=================================================================================================
-- Takes native video interface data and converts to AXI4S
entity AXI4S_INITIATOR_SCALER is
  generic(
-- Generic List
    -- Specifies the R, G, B pixel data width
    G_DATA_WIDTH : integer range 8 to 96 := 8
    );
  port (
-- Port List
    -- System reset
    RESETN_I : in std_logic;

    -- System clock
    IN_VIDEO_CLK_I : in std_logic;
    -- R, G, B Data Input
    DATA_I    : in std_logic_vector(3*G_DATA_WIDTH-1 downto 0);

    -- Specifies the input data is valid or not
    DATA_VALID_I : in std_logic;

    EOF_I : in std_logic;

    TUSER_O : out std_logic_vector(3 downto 0);

    TSTRB_O : out std_logic_vector(G_DATA_WIDTH/8-1 downto 0);

    TKEEP_O : out std_logic_vector(G_DATA_WIDTH/8-1 downto 0);

    -- Data input
    TDATA_O : out std_logic_vector(3*G_DATA_WIDTH-1 downto 0);

    TLAST_O : out std_logic;

    -- Specifies the valid control signal
    TVALID_O : out std_logic

    );
end AXI4S_INITIATOR_SCALER;
--=================================================================================================
-- Architecture body
--=================================================================================================
architecture AXI4S_INITIATOR_SCALER of AXI4S_INITIATOR_SCALER is
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
  signal s_data_dly1       : std_logic_vector(3*G_DATA_WIDTH-1 downto 0);
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
  process(IN_VIDEO_CLK_I, RESETN_I)
  begin
    if (RESETN_I = '0') then
      s_eof_dly1        <= '0';
      s_data_valid_dly1 <= '0';
      s_data_dly1       <= (others => '0');
    elsif rising_edge(IN_VIDEO_CLK_I) then
      s_data_dly1       <= DATA_I;
      s_data_valid_dly1 <= DATA_VALID_I;
      s_eof_dly1        <= EOF_I;
    end if;
  end process;
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
end AXI4S_INITIATOR_SCALER;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
--=================================================================================================
-- AXI4S_SLAVE entity declaration
--=================================================================================================
-- Takes AXI4S and converts to native video interface data
entity AXI4S_TARGET_SCALER is
  generic(
-- Generic List
    -- Specifies the R, G, B pixel data width
    G_DATA_WIDTH : integer range 8 to 96 := 8
    );
  port (
-- Port List 
    -- Data input
    TDATA_I : in std_logic_vector(3*G_DATA_WIDTH-1 downto 0);

    -- Specifies the valid control signal
    TVALID_I : in std_logic;

    TUSER_I : in std_logic_vector(3 downto 0);

    TREADY_O : out std_logic;

    EOF_O : out std_logic;

    -- R, G, B Data Output
    DATA_O : out std_logic_vector(3*G_DATA_WIDTH-1 downto 0);

    -- Specifies the output data is valid or not
    DATA_VALID_O : out std_logic

    );
end AXI4S_TARGET_SCALER;
--=================================================================================================
-- Architecture body
--=================================================================================================
architecture AXI4S_TARGET_SCALER of AXI4S_TARGET_SCALER is
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
end AXI4S_TARGET_SCALER;
