----------------------------------------------------------------------
-- Created by SmartDesign Sun Apr 28 14:51:37 2024
-- Version: 2023.2 2023.2.0.8
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Component Description (Tcl) 
----------------------------------------------------------------------
--# Exporting Component Description of Image_Enhancement_C0 to TCL
--# Family: PolarFireSoC
--# Part Number: MPFS250TS-1FCG1152I
--# Create and Configure the core component Image_Enhancement_C0
--create_and_configure_core -core_vlnv {Microchip:SolutionCore:Image_Enhancement:4.5.0} -component_name {Image_Enhancement_C0} -params {\
--"G_BCONST:165"  \
--"G_COMMON_CONSTANT:1046528"  \
--"G_FORMAT:0"  \
--"G_GCONST:122"  \
--"G_PIXEL_WIDTH:8"  \
--"G_PIXELS:1"  \
--"G_RCONST:146"   }
--# Exporting Component Description of Image_Enhancement_C0 to TCL done

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library polarfire;
use polarfire.all;
----------------------------------------------------------------------
-- Image_Enhancement_C0 entity declaration
----------------------------------------------------------------------
entity Image_Enhancement_C0 is
    -- Port list
    port(
        -- Inputs
        ACLK_I        : in  std_logic;
        ARESETN_I     : in  std_logic;
        B_I           : in  std_logic_vector(7 downto 0);
        DATA_VALID_I  : in  std_logic;
        FRAME_START_I : in  std_logic;
        G_I           : in  std_logic_vector(7 downto 0);
        RESETN_I      : in  std_logic;
        R_I           : in  std_logic_vector(7 downto 0);
        SYS_CLK_I     : in  std_logic;
        araddr        : in  std_logic_vector(31 downto 0);
        arvalid       : in  std_logic;
        awaddr        : in  std_logic_vector(31 downto 0);
        awvalid       : in  std_logic;
        bready        : in  std_logic;
        rready        : in  std_logic;
        wdata         : in  std_logic_vector(31 downto 0);
        wvalid        : in  std_logic;
        -- Outputs
        B_O           : out std_logic_vector(7 downto 0);
        DATA_VALID_O  : out std_logic;
        G_O           : out std_logic_vector(7 downto 0);
        R_O           : out std_logic_vector(7 downto 0);
        Y_AVG_O       : out std_logic_vector(31 downto 0);
        arready       : out std_logic;
        awready       : out std_logic;
        bresp         : out std_logic_vector(1 downto 0);
        bvalid        : out std_logic;
        rdata         : out std_logic_vector(31 downto 0);
        rresp         : out std_logic_vector(1 downto 0);
        rvalid        : out std_logic;
        wready        : out std_logic
        );
end Image_Enhancement_C0;
----------------------------------------------------------------------
-- Image_Enhancement_C0 architecture body
----------------------------------------------------------------------
architecture RTL of Image_Enhancement_C0 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- Image_Enhancement   -   Microchip:SolutionCore:Image_Enhancement:4.5.0
component Image_Enhancement
    generic( 
        G_BCONST          : integer := 165 ;
        G_COMMON_CONSTANT : integer := 1046528 ;
        G_FORMAT          : integer := 0 ;
        G_GCONST          : integer := 122 ;
        G_PIXEL_WIDTH     : integer := 8 ;
        G_PIXELS          : integer := 1 ;
        G_RCONST          : integer := 146 
        );
    -- Port list
    port(
        -- Inputs
        ACLK_I        : in  std_logic;
        ARESETN_I     : in  std_logic;
        B_I           : in  std_logic_vector(7 downto 0);
        DATA_VALID_I  : in  std_logic;
        FRAME_START_I : in  std_logic;
        G_I           : in  std_logic_vector(7 downto 0);
        RESETN_I      : in  std_logic;
        R_I           : in  std_logic_vector(7 downto 0);
        SYS_CLK_I     : in  std_logic;
        TDATA_I       : in  std_logic_vector(23 downto 0);
        TUSER_I       : in  std_logic_vector(3 downto 0);
        TVALID_I      : in  std_logic;
        araddr        : in  std_logic_vector(31 downto 0);
        arvalid       : in  std_logic;
        awaddr        : in  std_logic_vector(31 downto 0);
        awvalid       : in  std_logic;
        bready        : in  std_logic;
        rready        : in  std_logic;
        wdata         : in  std_logic_vector(31 downto 0);
        wvalid        : in  std_logic;
        -- Outputs
        B_O           : out std_logic_vector(7 downto 0);
        DATA_VALID_O  : out std_logic;
        G_O           : out std_logic_vector(7 downto 0);
        R_O           : out std_logic_vector(7 downto 0);
        TDATA_O       : out std_logic_vector(23 downto 0);
        TKEEP_O       : out std_logic_vector(0 to 0);
        TLAST_O       : out std_logic;
        TREADY_O      : out std_logic;
        TSTRB_O       : out std_logic_vector(0 to 0);
        TUSER_O       : out std_logic_vector(3 downto 0);
        TVALID_O      : out std_logic;
        Y_AVG_O       : out std_logic_vector(31 downto 0);
        arready       : out std_logic;
        awready       : out std_logic;
        bresp         : out std_logic_vector(1 downto 0);
        bvalid        : out std_logic;
        rdata         : out std_logic_vector(31 downto 0);
        rresp         : out std_logic_vector(1 downto 0);
        rvalid        : out std_logic;
        wready        : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal AXI4L_IE_ARREADY       : std_logic;
signal AXI4L_IE_AWREADY       : std_logic;
signal AXI4L_IE_BRESP         : std_logic_vector(1 downto 0);
signal AXI4L_IE_BVALID        : std_logic;
signal AXI4L_IE_RDATA         : std_logic_vector(31 downto 0);
signal AXI4L_IE_RRESP         : std_logic_vector(1 downto 0);
signal AXI4L_IE_RVALID        : std_logic;
signal AXI4L_IE_WREADY        : std_logic;
signal B_O_net_0              : std_logic_vector(7 downto 0);
signal DATA_VALID_O_net_0     : std_logic;
signal G_O_net_0              : std_logic_vector(7 downto 0);
signal R_O_net_0              : std_logic_vector(7 downto 0);
signal Y_AVG_O_net_0          : std_logic_vector(31 downto 0);
signal Y_AVG_O_net_1          : std_logic_vector(31 downto 0);
signal DATA_VALID_O_net_1     : std_logic;
signal R_O_net_1              : std_logic_vector(7 downto 0);
signal G_O_net_1              : std_logic_vector(7 downto 0);
signal B_O_net_1              : std_logic_vector(7 downto 0);
signal AXI4L_IE_AWREADY_net_0 : std_logic;
signal AXI4L_IE_WREADY_net_0  : std_logic;
signal AXI4L_IE_BRESP_net_0   : std_logic_vector(1 downto 0);
signal AXI4L_IE_BVALID_net_0  : std_logic;
signal AXI4L_IE_ARREADY_net_0 : std_logic;
signal AXI4L_IE_RDATA_net_0   : std_logic_vector(31 downto 0);
signal AXI4L_IE_RRESP_net_0   : std_logic_vector(1 downto 0);
signal AXI4L_IE_RVALID_net_0  : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal TDATA_I_const_net_0    : std_logic_vector(23 downto 0);
signal TUSER_I_const_net_0    : std_logic_vector(3 downto 0);
signal GND_net                : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 TDATA_I_const_net_0 <= B"000000000000000000000000";
 TUSER_I_const_net_0 <= B"0000";
 GND_net             <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 Y_AVG_O_net_1          <= Y_AVG_O_net_0;
 Y_AVG_O(31 downto 0)   <= Y_AVG_O_net_1;
 DATA_VALID_O_net_1     <= DATA_VALID_O_net_0;
 DATA_VALID_O           <= DATA_VALID_O_net_1;
 R_O_net_1              <= R_O_net_0;
 R_O(7 downto 0)        <= R_O_net_1;
 G_O_net_1              <= G_O_net_0;
 G_O(7 downto 0)        <= G_O_net_1;
 B_O_net_1              <= B_O_net_0;
 B_O(7 downto 0)        <= B_O_net_1;
 AXI4L_IE_AWREADY_net_0 <= AXI4L_IE_AWREADY;
 awready                <= AXI4L_IE_AWREADY_net_0;
 AXI4L_IE_WREADY_net_0  <= AXI4L_IE_WREADY;
 wready                 <= AXI4L_IE_WREADY_net_0;
 AXI4L_IE_BRESP_net_0   <= AXI4L_IE_BRESP;
 bresp(1 downto 0)      <= AXI4L_IE_BRESP_net_0;
 AXI4L_IE_BVALID_net_0  <= AXI4L_IE_BVALID;
 bvalid                 <= AXI4L_IE_BVALID_net_0;
 AXI4L_IE_ARREADY_net_0 <= AXI4L_IE_ARREADY;
 arready                <= AXI4L_IE_ARREADY_net_0;
 AXI4L_IE_RDATA_net_0   <= AXI4L_IE_RDATA;
 rdata(31 downto 0)     <= AXI4L_IE_RDATA_net_0;
 AXI4L_IE_RRESP_net_0   <= AXI4L_IE_RRESP;
 rresp(1 downto 0)      <= AXI4L_IE_RRESP_net_0;
 AXI4L_IE_RVALID_net_0  <= AXI4L_IE_RVALID;
 rvalid                 <= AXI4L_IE_RVALID_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- Image_Enhancement_C0_0   -   Microchip:SolutionCore:Image_Enhancement:4.5.0
Image_Enhancement_C0_0 : Image_Enhancement
    generic map( 
        G_BCONST          => ( 165 ),
        G_COMMON_CONSTANT => ( 1046528 ),
        G_FORMAT          => ( 0 ),
        G_GCONST          => ( 122 ),
        G_PIXEL_WIDTH     => ( 8 ),
        G_PIXELS          => ( 1 ),
        G_RCONST          => ( 146 )
        )
    port map( 
        -- Inputs
        RESETN_I      => RESETN_I,
        SYS_CLK_I     => SYS_CLK_I,
        FRAME_START_I => FRAME_START_I,
        DATA_VALID_I  => DATA_VALID_I,
        TDATA_I       => TDATA_I_const_net_0, -- tied to X"0" from definition
        TUSER_I       => TUSER_I_const_net_0, -- tied to X"0" from definition
        TVALID_I      => GND_net, -- tied to '0' from definition
        R_I           => R_I,
        G_I           => G_I,
        B_I           => B_I,
        ACLK_I        => ACLK_I,
        ARESETN_I     => ARESETN_I,
        awvalid       => awvalid,
        awaddr        => awaddr,
        wdata         => wdata,
        wvalid        => wvalid,
        bready        => bready,
        araddr        => araddr,
        arvalid       => arvalid,
        rready        => rready,
        -- Outputs
        TREADY_O      => OPEN,
        awready       => AXI4L_IE_AWREADY,
        wready        => AXI4L_IE_WREADY,
        bresp         => AXI4L_IE_BRESP,
        bvalid        => AXI4L_IE_BVALID,
        arready       => AXI4L_IE_ARREADY,
        rdata         => AXI4L_IE_RDATA,
        rresp         => AXI4L_IE_RRESP,
        rvalid        => AXI4L_IE_RVALID,
        Y_AVG_O       => Y_AVG_O_net_0,
        DATA_VALID_O  => DATA_VALID_O_net_0,
        R_O           => R_O_net_0,
        G_O           => G_O_net_0,
        B_O           => B_O_net_0,
        TDATA_O       => OPEN,
        TUSER_O       => OPEN,
        TVALID_O      => OPEN,
        TLAST_O       => OPEN,
        TSTRB_O       => OPEN,
        TKEEP_O       => OPEN 
        );

end RTL;
