----------------------------------------------------------------------
-- Created by SmartDesign Sun Apr 28 14:51:35 2024
-- Version: 2023.2 2023.2.0.8
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Component Description (Tcl) 
----------------------------------------------------------------------
--# Exporting Component Description of IMAGE_SCALER_C0 to TCL
--# Family: PolarFireSoC
--# Part Number: MPFS250TS-1FCG1152I
--# Create and Configure the core component IMAGE_SCALER_C0
--create_and_configure_core -core_vlnv {Microchip:SolutionCore:IMAGE_SCALER:4.2.0} -component_name {IMAGE_SCALER_C0} -params {\
--"G_DATA_WIDTH:8"  \
--"G_FORMAT:0"  \
--"G_HRES_IN:1920"  \
--"G_HRES_OUT:1920"  \
--"G_HRES_SCALE:1023"  \
--"G_INPUT_FIFO_AWIDTH:13"  \
--"G_OUTPUT_FIFO_AWIDTH:13"  \
--"G_VRES_IN:1080"  \
--"G_VRES_OUT:1072"  \
--"G_VRES_SCALE:1030"   }
--# Exporting Component Description of IMAGE_SCALER_C0 to TCL done

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library polarfire;
use polarfire.all;
----------------------------------------------------------------------
-- IMAGE_SCALER_C0 entity declaration
----------------------------------------------------------------------
entity IMAGE_SCALER_C0 is
    -- Port list
    port(
        -- Inputs
        ACLK_I          : in  std_logic;
        ARESETN_I       : in  std_logic;
        DATA_B_I        : in  std_logic_vector(7 downto 0);
        DATA_G_I        : in  std_logic_vector(7 downto 0);
        DATA_R_I        : in  std_logic_vector(7 downto 0);
        DATA_VALID_I    : in  std_logic;
        FRAME_START_I   : in  std_logic;
        IN_VIDEO_CLK_I  : in  std_logic;
        OUT_VIDEO_CLK_I : in  std_logic;
        RESETN_I        : in  std_logic;
        araddr          : in  std_logic_vector(31 downto 0);
        arvalid         : in  std_logic;
        awaddr          : in  std_logic_vector(31 downto 0);
        awvalid         : in  std_logic;
        bready          : in  std_logic;
        rready          : in  std_logic;
        wdata           : in  std_logic_vector(31 downto 0);
        wvalid          : in  std_logic;
        -- Outputs
        DATA_B_O        : out std_logic_vector(7 downto 0);
        DATA_G_O        : out std_logic_vector(7 downto 0);
        DATA_R_O        : out std_logic_vector(7 downto 0);
        DATA_VALID_O    : out std_logic;
        arready         : out std_logic;
        awready         : out std_logic;
        bresp           : out std_logic_vector(1 downto 0);
        bvalid          : out std_logic;
        rdata           : out std_logic_vector(31 downto 0);
        rresp           : out std_logic_vector(1 downto 0);
        rvalid          : out std_logic;
        wready          : out std_logic
        );
end IMAGE_SCALER_C0;
----------------------------------------------------------------------
-- IMAGE_SCALER_C0 architecture body
----------------------------------------------------------------------
architecture RTL of IMAGE_SCALER_C0 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- IMAGE_SCALER   -   Microchip:SolutionCore:IMAGE_SCALER:4.2.0
component IMAGE_SCALER
    generic( 
        G_DATA_WIDTH          : integer := 8 ;
        G_FORMAT              : integer := 0 ;
        G_HRES_IN             : integer := 1920 ;
        G_HRES_OUT            : integer := 1920 ;
        G_HRES_SCALE          : integer := 1023 ;
        G_INPUT_FIFO_AWIDTH   : integer := 13 ;
        G_OUTPUT_FIFO_AWIDTH  : integer := 13 ;
        G_VRES_IN             : integer := 1080 ;
        G_VRES_OUT            : integer := 1072 ;
        G_VRES_SCALE          : integer := 1030 ;
        TGIGEN_DISPLAY_SYMBOL : integer := 1 
        );
    -- Port list
    port(
        -- Inputs
        ACLK_I          : in  std_logic;
        ARESETN_I       : in  std_logic;
        DATA_B_I        : in  std_logic_vector(7 downto 0);
        DATA_G_I        : in  std_logic_vector(7 downto 0);
        DATA_R_I        : in  std_logic_vector(7 downto 0);
        DATA_VALID_I    : in  std_logic;
        FRAME_START_I   : in  std_logic;
        IN_VIDEO_CLK_I  : in  std_logic;
        OUT_VIDEO_CLK_I : in  std_logic;
        RESETN_I        : in  std_logic;
        TDATA_I         : in  std_logic_vector(23 downto 0);
        TUSER_I         : in  std_logic_vector(3 downto 0);
        TVALID_I        : in  std_logic;
        araddr          : in  std_logic_vector(31 downto 0);
        arvalid         : in  std_logic;
        awaddr          : in  std_logic_vector(31 downto 0);
        awvalid         : in  std_logic;
        bready          : in  std_logic;
        rready          : in  std_logic;
        wdata           : in  std_logic_vector(31 downto 0);
        wvalid          : in  std_logic;
        -- Outputs
        DATA_B_O        : out std_logic_vector(7 downto 0);
        DATA_G_O        : out std_logic_vector(7 downto 0);
        DATA_R_O        : out std_logic_vector(7 downto 0);
        DATA_VALID_O    : out std_logic;
        TDATA_O         : out std_logic_vector(23 downto 0);
        TKEEP_O         : out std_logic_vector(0 to 0);
        TLAST_O         : out std_logic;
        TREADY_O        : out std_logic;
        TSTRB_O         : out std_logic_vector(0 to 0);
        TUSER_O         : out std_logic_vector(3 downto 0);
        TVALID_O        : out std_logic;
        arready         : out std_logic;
        awready         : out std_logic;
        bresp           : out std_logic_vector(1 downto 0);
        bvalid          : out std_logic;
        rdata           : out std_logic_vector(31 downto 0);
        rresp           : out std_logic_vector(1 downto 0);
        rvalid          : out std_logic;
        wready          : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal AXI4L_SCALER_ARREADY       : std_logic;
signal AXI4L_SCALER_AWREADY       : std_logic;
signal AXI4L_SCALER_BRESP         : std_logic_vector(1 downto 0);
signal AXI4L_SCALER_BVALID        : std_logic;
signal AXI4L_SCALER_RDATA         : std_logic_vector(31 downto 0);
signal AXI4L_SCALER_RRESP         : std_logic_vector(1 downto 0);
signal AXI4L_SCALER_RVALID        : std_logic;
signal AXI4L_SCALER_WREADY        : std_logic;
signal DATA_B_O_net_0             : std_logic_vector(7 downto 0);
signal DATA_G_O_net_0             : std_logic_vector(7 downto 0);
signal DATA_R_O_net_0             : std_logic_vector(7 downto 0);
signal DATA_VALID_O_net_0         : std_logic;
signal DATA_VALID_O_net_1         : std_logic;
signal DATA_R_O_net_1             : std_logic_vector(7 downto 0);
signal DATA_G_O_net_1             : std_logic_vector(7 downto 0);
signal DATA_B_O_net_1             : std_logic_vector(7 downto 0);
signal AXI4L_SCALER_AWREADY_net_0 : std_logic;
signal AXI4L_SCALER_WREADY_net_0  : std_logic;
signal AXI4L_SCALER_BRESP_net_0   : std_logic_vector(1 downto 0);
signal AXI4L_SCALER_BVALID_net_0  : std_logic;
signal AXI4L_SCALER_ARREADY_net_0 : std_logic;
signal AXI4L_SCALER_RDATA_net_0   : std_logic_vector(31 downto 0);
signal AXI4L_SCALER_RRESP_net_0   : std_logic_vector(1 downto 0);
signal AXI4L_SCALER_RVALID_net_0  : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal TDATA_I_const_net_0        : std_logic_vector(23 downto 0);
signal GND_net                    : std_logic;
signal TUSER_I_const_net_0        : std_logic_vector(3 downto 0);

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 TDATA_I_const_net_0 <= B"000000000000000000000000";
 GND_net             <= '0';
 TUSER_I_const_net_0 <= B"0000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 DATA_VALID_O_net_1         <= DATA_VALID_O_net_0;
 DATA_VALID_O               <= DATA_VALID_O_net_1;
 DATA_R_O_net_1             <= DATA_R_O_net_0;
 DATA_R_O(7 downto 0)       <= DATA_R_O_net_1;
 DATA_G_O_net_1             <= DATA_G_O_net_0;
 DATA_G_O(7 downto 0)       <= DATA_G_O_net_1;
 DATA_B_O_net_1             <= DATA_B_O_net_0;
 DATA_B_O(7 downto 0)       <= DATA_B_O_net_1;
 AXI4L_SCALER_AWREADY_net_0 <= AXI4L_SCALER_AWREADY;
 awready                    <= AXI4L_SCALER_AWREADY_net_0;
 AXI4L_SCALER_WREADY_net_0  <= AXI4L_SCALER_WREADY;
 wready                     <= AXI4L_SCALER_WREADY_net_0;
 AXI4L_SCALER_BRESP_net_0   <= AXI4L_SCALER_BRESP;
 bresp(1 downto 0)          <= AXI4L_SCALER_BRESP_net_0;
 AXI4L_SCALER_BVALID_net_0  <= AXI4L_SCALER_BVALID;
 bvalid                     <= AXI4L_SCALER_BVALID_net_0;
 AXI4L_SCALER_ARREADY_net_0 <= AXI4L_SCALER_ARREADY;
 arready                    <= AXI4L_SCALER_ARREADY_net_0;
 AXI4L_SCALER_RDATA_net_0   <= AXI4L_SCALER_RDATA;
 rdata(31 downto 0)         <= AXI4L_SCALER_RDATA_net_0;
 AXI4L_SCALER_RRESP_net_0   <= AXI4L_SCALER_RRESP;
 rresp(1 downto 0)          <= AXI4L_SCALER_RRESP_net_0;
 AXI4L_SCALER_RVALID_net_0  <= AXI4L_SCALER_RVALID;
 rvalid                     <= AXI4L_SCALER_RVALID_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- IMAGE_SCALER_C0_0   -   Microchip:SolutionCore:IMAGE_SCALER:4.2.0
IMAGE_SCALER_C0_0 : IMAGE_SCALER
    generic map( 
        G_DATA_WIDTH          => ( 8 ),
        G_FORMAT              => ( 0 ),
        G_HRES_IN             => ( 1920 ),
        G_HRES_OUT            => ( 1920 ),
        G_HRES_SCALE          => ( 1023 ),
        G_INPUT_FIFO_AWIDTH   => ( 13 ),
        G_OUTPUT_FIFO_AWIDTH  => ( 13 ),
        G_VRES_IN             => ( 1080 ),
        G_VRES_OUT            => ( 1072 ),
        G_VRES_SCALE          => ( 1030 ),
        TGIGEN_DISPLAY_SYMBOL => ( 1 )
        )
    port map( 
        -- Inputs
        RESETN_I        => RESETN_I,
        IN_VIDEO_CLK_I  => IN_VIDEO_CLK_I,
        OUT_VIDEO_CLK_I => OUT_VIDEO_CLK_I,
        FRAME_START_I   => FRAME_START_I,
        TDATA_I         => TDATA_I_const_net_0, -- tied to X"0" from definition
        TVALID_I        => GND_net, -- tied to '0' from definition
        TUSER_I         => TUSER_I_const_net_0, -- tied to X"0" from definition
        DATA_VALID_I    => DATA_VALID_I,
        DATA_R_I        => DATA_R_I,
        DATA_G_I        => DATA_G_I,
        DATA_B_I        => DATA_B_I,
        ACLK_I          => ACLK_I,
        ARESETN_I       => ARESETN_I,
        awvalid         => awvalid,
        awaddr          => awaddr,
        wdata           => wdata,
        wvalid          => wvalid,
        bready          => bready,
        araddr          => araddr,
        arvalid         => arvalid,
        rready          => rready,
        -- Outputs
        TREADY_O        => OPEN,
        awready         => AXI4L_SCALER_AWREADY,
        wready          => AXI4L_SCALER_WREADY,
        bresp           => AXI4L_SCALER_BRESP,
        bvalid          => AXI4L_SCALER_BVALID,
        arready         => AXI4L_SCALER_ARREADY,
        rdata           => AXI4L_SCALER_RDATA,
        rresp           => AXI4L_SCALER_RRESP,
        rvalid          => AXI4L_SCALER_RVALID,
        DATA_VALID_O    => DATA_VALID_O_net_0,
        DATA_R_O        => DATA_R_O_net_0,
        DATA_G_O        => DATA_G_O_net_0,
        DATA_B_O        => DATA_B_O_net_0,
        TDATA_O         => OPEN,
        TSTRB_O         => OPEN,
        TKEEP_O         => OPEN,
        TUSER_O         => OPEN,
        TLAST_O         => OPEN,
        TVALID_O        => OPEN 
        );

end RTL;
