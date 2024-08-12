----------------------------------------------------------------------
-- Created by SmartDesign Mon Aug 12 21:23:55 2024
-- Version: 2023.2 2023.2.0.8
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Component Description (Tcl) 
----------------------------------------------------------------------
--# Exporting Component Description of IMAGE_SCALER_C0 to TCL
--# Family: PolarFireSoC
--# Part Number: MPFS250TS-1FCG1152I
--# Create and Configure the core component IMAGE_SCALER_C0
--create_and_configure_core -core_vlnv {Microsemi:SolutionCore:IMAGE_SCALER:4.1.0} -component_name {IMAGE_SCALER_C0} -params {\
--"G_CONFIG:0"  \
--"G_DATA_WIDTH:8"  \
--"G_FORMAT:0"  \
--"G_INPUT_FIFO_AWIDTH:11"  \
--"G_OUTPUT_FIFO_AWIDTH:11"   }
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
        DATA_B_I            : in  std_logic_vector(7 downto 0);
        DATA_G_I            : in  std_logic_vector(7 downto 0);
        DATA_R_I            : in  std_logic_vector(7 downto 0);
        DATA_VALID_I        : in  std_logic;
        HORZ_RES_IN_I       : in  std_logic_vector(12 downto 0);
        HORZ_RES_OUT_I      : in  std_logic_vector(12 downto 0);
        IP_CLK_I            : in  std_logic;
        RESETN_I            : in  std_logic;
        SCALE_FACTOR_HORZ_I : in  std_logic_vector(15 downto 0);
        SCALE_FACTOR_VERT_I : in  std_logic_vector(15 downto 0);
        SYS_CLK_I           : in  std_logic;
        VERT_RES_IN_I       : in  std_logic_vector(12 downto 0);
        VERT_RES_OUT_I      : in  std_logic_vector(12 downto 0);
        -- Outputs
        DATA_B_O            : out std_logic_vector(7 downto 0);
        DATA_G_O            : out std_logic_vector(7 downto 0);
        DATA_R_O            : out std_logic_vector(7 downto 0);
        DATA_VALID_O        : out std_logic
        );
end IMAGE_SCALER_C0;
----------------------------------------------------------------------
-- IMAGE_SCALER_C0 architecture body
----------------------------------------------------------------------
architecture RTL of IMAGE_SCALER_C0 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- IMAGE_SCALER   -   Microsemi:SolutionCore:IMAGE_SCALER:4.1.0
component IMAGE_SCALER
    generic( 
        G_CONFIG              : integer := 0 ;
        G_DATA_WIDTH          : integer := 8 ;
        G_FORMAT              : integer := 0 ;
        G_INPUT_FIFO_AWIDTH   : integer := 11 ;
        G_OUTPUT_FIFO_AWIDTH  : integer := 11 ;
        TGIGEN_DISPLAY_SYMBOL : integer := 1 
        );
    -- Port list
    port(
        -- Inputs
        AXI_ARADDR_I        : in  std_logic_vector(31 downto 0);
        AXI_ARBURST_I       : in  std_logic_vector(1 downto 0);
        AXI_ARCACHE_I       : in  std_logic_vector(3 downto 0);
        AXI_ARID_I          : in  std_logic_vector(1 downto 0);
        AXI_ARLEN_I         : in  std_logic_vector(7 downto 0);
        AXI_ARLOCK_I        : in  std_logic_vector(1 downto 0);
        AXI_ARPROT_I        : in  std_logic_vector(2 downto 0);
        AXI_ARQOS_I         : in  std_logic_vector(3 downto 0);
        AXI_ARREGION_I      : in  std_logic_vector(3 downto 0);
        AXI_ARSIZE_I        : in  std_logic_vector(2 downto 0);
        AXI_ARUSER_I        : in  std_logic;
        AXI_ARVALID_I       : in  std_logic;
        AXI_AWADDR_I        : in  std_logic_vector(31 downto 0);
        AXI_AWBURST_I       : in  std_logic_vector(1 downto 0);
        AXI_AWCACHE_I       : in  std_logic_vector(3 downto 0);
        AXI_AWID_I          : in  std_logic_vector(1 downto 0);
        AXI_AWLEN_I         : in  std_logic_vector(7 downto 0);
        AXI_AWLOCK_I        : in  std_logic_vector(1 downto 0);
        AXI_AWPROT_I        : in  std_logic_vector(2 downto 0);
        AXI_AWQOS_I         : in  std_logic_vector(3 downto 0);
        AXI_AWREGION_I      : in  std_logic_vector(3 downto 0);
        AXI_AWSIZE_I        : in  std_logic_vector(2 downto 0);
        AXI_AWUSER_I        : in  std_logic;
        AXI_AWVALID_I       : in  std_logic;
        AXI_BREADY_I        : in  std_logic;
        AXI_CLK_I           : in  std_logic;
        AXI_RESETN_I        : in  std_logic;
        AXI_RREADY_I        : in  std_logic;
        AXI_WDATA_I         : in  std_logic_vector(31 downto 0);
        AXI_WLAST_I         : in  std_logic;
        AXI_WSTRB_I         : in  std_logic_vector(3 downto 0);
        AXI_WUSER_I         : in  std_logic;
        AXI_WVALID_I        : in  std_logic;
        DATA_B_I            : in  std_logic_vector(7 downto 0);
        DATA_G_I            : in  std_logic_vector(7 downto 0);
        DATA_R_I            : in  std_logic_vector(7 downto 0);
        DATA_VALID_I        : in  std_logic;
        HORZ_RES_IN_I       : in  std_logic_vector(12 downto 0);
        HORZ_RES_OUT_I      : in  std_logic_vector(12 downto 0);
        IP_CLK_I            : in  std_logic;
        RESETN_I            : in  std_logic;
        SCALE_FACTOR_HORZ_I : in  std_logic_vector(15 downto 0);
        SCALE_FACTOR_VERT_I : in  std_logic_vector(15 downto 0);
        SYS_CLK_I           : in  std_logic;
        TDATA_I             : in  std_logic_vector(23 downto 0);
        TUSER_I             : in  std_logic_vector(3 downto 0);
        TVALID_I            : in  std_logic;
        VERT_RES_IN_I       : in  std_logic_vector(12 downto 0);
        VERT_RES_OUT_I      : in  std_logic_vector(12 downto 0);
        -- Outputs
        AXI_ARREADY_O       : out std_logic;
        AXI_AWREADY_O       : out std_logic;
        AXI_BID_O           : out std_logic_vector(1 downto 0);
        AXI_BRESP_O         : out std_logic_vector(1 downto 0);
        AXI_BUSER_O         : out std_logic;
        AXI_BVALID_O        : out std_logic;
        AXI_RDATA_O         : out std_logic_vector(31 downto 0);
        AXI_RID_O           : out std_logic_vector(1 downto 0);
        AXI_RLAST_O         : out std_logic;
        AXI_RRESP_O         : out std_logic_vector(1 downto 0);
        AXI_RUSER_O         : out std_logic;
        AXI_RVALID_O        : out std_logic;
        AXI_WREADY_O        : out std_logic;
        DATA_B_O            : out std_logic_vector(7 downto 0);
        DATA_G_O            : out std_logic_vector(7 downto 0);
        DATA_R_O            : out std_logic_vector(7 downto 0);
        DATA_VALID_O        : out std_logic;
        TDATA_O             : out std_logic_vector(23 downto 0);
        TKEEP_O             : out std_logic_vector(0 to 0);
        TLAST_O             : out std_logic;
        TREADY_O            : out std_logic;
        TSTRB_O             : out std_logic_vector(0 to 0);
        TUSER_O             : out std_logic_vector(3 downto 0);
        TVALID_O            : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal DATA_B_O_net_0     : std_logic_vector(7 downto 0);
signal DATA_G_O_net_0     : std_logic_vector(7 downto 0);
signal DATA_R_O_net_0     : std_logic_vector(7 downto 0);
signal DATA_VALID_O_net_0 : std_logic;
signal DATA_VALID_O_net_1 : std_logic;
signal DATA_R_O_net_1     : std_logic_vector(7 downto 0);
signal DATA_G_O_net_1     : std_logic_vector(7 downto 0);
signal DATA_B_O_net_1     : std_logic_vector(7 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal TDATA_I_const_net_0: std_logic_vector(23 downto 0);
signal GND_net            : std_logic;
signal TUSER_I_const_net_0: std_logic_vector(3 downto 0);
signal AXI_AWADDR_I_const_net_0: std_logic_vector(31 downto 0);
signal AXI_AWPROT_I_const_net_0: std_logic_vector(2 downto 0);
signal AXI_AWBURST_I_const_net_0: std_logic_vector(1 downto 0);
signal AXI_WDATA_I_const_net_0: std_logic_vector(31 downto 0);
signal AXI_WSTRB_I_const_net_0: std_logic_vector(3 downto 0);
signal AXI_ARADDR_I_const_net_0: std_logic_vector(31 downto 0);
signal AXI_ARPROT_I_const_net_0: std_logic_vector(2 downto 0);
signal AXI_ARBURST_I_const_net_0: std_logic_vector(1 downto 0);
signal AXI_AWID_I_const_net_0: std_logic_vector(1 downto 0);
signal AXI_AWLEN_I_const_net_0: std_logic_vector(7 downto 0);
signal AXI_AWSIZE_I_const_net_0: std_logic_vector(2 downto 0);
signal AXI_AWLOCK_I_const_net_0: std_logic_vector(1 downto 0);
signal AXI_AWCACHE_I_const_net_0: std_logic_vector(3 downto 0);
signal AXI_AWQOS_I_const_net_0: std_logic_vector(3 downto 0);
signal AXI_AWREGION_I_const_net_0: std_logic_vector(3 downto 0);
signal AXI_ARID_I_const_net_0: std_logic_vector(1 downto 0);
signal AXI_ARLEN_I_const_net_0: std_logic_vector(7 downto 0);
signal AXI_ARSIZE_I_const_net_0: std_logic_vector(2 downto 0);
signal AXI_ARLOCK_I_const_net_0: std_logic_vector(1 downto 0);
signal AXI_ARCACHE_I_const_net_0: std_logic_vector(3 downto 0);
signal AXI_ARQOS_I_const_net_0: std_logic_vector(3 downto 0);
signal AXI_ARREGION_I_const_net_0: std_logic_vector(3 downto 0);

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 TDATA_I_const_net_0        <= B"000000000000000000000000";
 GND_net                    <= '0';
 TUSER_I_const_net_0        <= B"0000";
 AXI_AWADDR_I_const_net_0   <= B"00000000000000000000000000000000";
 AXI_AWPROT_I_const_net_0   <= B"000";
 AXI_AWBURST_I_const_net_0  <= B"00";
 AXI_WDATA_I_const_net_0    <= B"00000000000000000000000000000000";
 AXI_WSTRB_I_const_net_0    <= B"0000";
 AXI_ARADDR_I_const_net_0   <= B"00000000000000000000000000000000";
 AXI_ARPROT_I_const_net_0   <= B"000";
 AXI_ARBURST_I_const_net_0  <= B"00";
 AXI_AWID_I_const_net_0     <= B"00";
 AXI_AWLEN_I_const_net_0    <= B"00000000";
 AXI_AWSIZE_I_const_net_0   <= B"000";
 AXI_AWLOCK_I_const_net_0   <= B"00";
 AXI_AWCACHE_I_const_net_0  <= B"0000";
 AXI_AWQOS_I_const_net_0    <= B"0000";
 AXI_AWREGION_I_const_net_0 <= B"0000";
 AXI_ARID_I_const_net_0     <= B"00";
 AXI_ARLEN_I_const_net_0    <= B"00000000";
 AXI_ARSIZE_I_const_net_0   <= B"000";
 AXI_ARLOCK_I_const_net_0   <= B"00";
 AXI_ARCACHE_I_const_net_0  <= B"0000";
 AXI_ARQOS_I_const_net_0    <= B"0000";
 AXI_ARREGION_I_const_net_0 <= B"0000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 DATA_VALID_O_net_1   <= DATA_VALID_O_net_0;
 DATA_VALID_O         <= DATA_VALID_O_net_1;
 DATA_R_O_net_1       <= DATA_R_O_net_0;
 DATA_R_O(7 downto 0) <= DATA_R_O_net_1;
 DATA_G_O_net_1       <= DATA_G_O_net_0;
 DATA_G_O(7 downto 0) <= DATA_G_O_net_1;
 DATA_B_O_net_1       <= DATA_B_O_net_0;
 DATA_B_O(7 downto 0) <= DATA_B_O_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- IMAGE_SCALER_C0_0   -   Microsemi:SolutionCore:IMAGE_SCALER:4.1.0
IMAGE_SCALER_C0_0 : IMAGE_SCALER
    generic map( 
        G_CONFIG              => ( 0 ),
        G_DATA_WIDTH          => ( 8 ),
        G_FORMAT              => ( 0 ),
        G_INPUT_FIFO_AWIDTH   => ( 11 ),
        G_OUTPUT_FIFO_AWIDTH  => ( 11 ),
        TGIGEN_DISPLAY_SYMBOL => ( 1 )
        )
    port map( 
        -- Inputs
        RESETN_I            => RESETN_I,
        SYS_CLK_I           => SYS_CLK_I,
        IP_CLK_I            => IP_CLK_I,
        DATA_VALID_I        => DATA_VALID_I,
        TDATA_I             => TDATA_I_const_net_0, -- tied to X"0" from definition
        TVALID_I            => GND_net, -- tied to '0' from definition
        TUSER_I             => TUSER_I_const_net_0, -- tied to X"0" from definition
        DATA_R_I            => DATA_R_I,
        DATA_G_I            => DATA_G_I,
        DATA_B_I            => DATA_B_I,
        HORZ_RES_IN_I       => HORZ_RES_IN_I,
        VERT_RES_IN_I       => VERT_RES_IN_I,
        HORZ_RES_OUT_I      => HORZ_RES_OUT_I,
        VERT_RES_OUT_I      => VERT_RES_OUT_I,
        SCALE_FACTOR_HORZ_I => SCALE_FACTOR_HORZ_I,
        SCALE_FACTOR_VERT_I => SCALE_FACTOR_VERT_I,
        AXI_RESETN_I        => GND_net, -- tied to '0' from definition
        AXI_CLK_I           => GND_net, -- tied to '0' from definition
        AXI_AWVALID_I       => GND_net, -- tied to '0' from definition
        AXI_AWADDR_I        => AXI_AWADDR_I_const_net_0, -- tied to X"0" from definition
        AXI_AWPROT_I        => AXI_AWPROT_I_const_net_0, -- tied to X"0" from definition
        AXI_AWBURST_I       => AXI_AWBURST_I_const_net_0, -- tied to X"0" from definition
        AXI_WDATA_I         => AXI_WDATA_I_const_net_0, -- tied to X"0" from definition
        AXI_WVALID_I        => GND_net, -- tied to '0' from definition
        AXI_WSTRB_I         => AXI_WSTRB_I_const_net_0, -- tied to X"0" from definition
        AXI_BREADY_I        => GND_net, -- tied to '0' from definition
        AXI_ARVALID_I       => GND_net, -- tied to '0' from definition
        AXI_ARADDR_I        => AXI_ARADDR_I_const_net_0, -- tied to X"0" from definition
        AXI_ARPROT_I        => AXI_ARPROT_I_const_net_0, -- tied to X"0" from definition
        AXI_ARBURST_I       => AXI_ARBURST_I_const_net_0, -- tied to X"0" from definition
        AXI_RREADY_I        => GND_net, -- tied to '0' from definition
        AXI_AWID_I          => AXI_AWID_I_const_net_0, -- tied to X"0" from definition
        AXI_AWLEN_I         => AXI_AWLEN_I_const_net_0, -- tied to X"0" from definition
        AXI_AWSIZE_I        => AXI_AWSIZE_I_const_net_0, -- tied to X"0" from definition
        AXI_AWLOCK_I        => AXI_AWLOCK_I_const_net_0, -- tied to X"0" from definition
        AXI_AWCACHE_I       => AXI_AWCACHE_I_const_net_0, -- tied to X"0" from definition
        AXI_AWUSER_I        => GND_net, -- tied to '0' from definition
        AXI_AWQOS_I         => AXI_AWQOS_I_const_net_0, -- tied to X"0" from definition
        AXI_AWREGION_I      => AXI_AWREGION_I_const_net_0, -- tied to X"0" from definition
        AXI_WLAST_I         => GND_net, -- tied to '0' from definition
        AXI_WUSER_I         => GND_net, -- tied to '0' from definition
        AXI_ARUSER_I        => GND_net, -- tied to '0' from definition
        AXI_ARID_I          => AXI_ARID_I_const_net_0, -- tied to X"0" from definition
        AXI_ARLEN_I         => AXI_ARLEN_I_const_net_0, -- tied to X"0" from definition
        AXI_ARSIZE_I        => AXI_ARSIZE_I_const_net_0, -- tied to X"0" from definition
        AXI_ARLOCK_I        => AXI_ARLOCK_I_const_net_0, -- tied to X"0" from definition
        AXI_ARCACHE_I       => AXI_ARCACHE_I_const_net_0, -- tied to X"0" from definition
        AXI_ARQOS_I         => AXI_ARQOS_I_const_net_0, -- tied to X"0" from definition
        AXI_ARREGION_I      => AXI_ARREGION_I_const_net_0, -- tied to X"0" from definition
        -- Outputs
        TREADY_O            => OPEN,
        AXI_AWREADY_O       => OPEN,
        AXI_WREADY_O        => OPEN,
        AXI_BVALID_O        => OPEN,
        AXI_BRESP_O         => OPEN,
        AXI_ARREADY_O       => OPEN,
        AXI_RDATA_O         => OPEN,
        AXI_RVALID_O        => OPEN,
        AXI_RRESP_O         => OPEN,
        AXI_BUSER_O         => OPEN,
        AXI_RUSER_O         => OPEN,
        AXI_RID_O           => OPEN,
        AXI_RLAST_O         => OPEN,
        AXI_BID_O           => OPEN,
        DATA_VALID_O        => DATA_VALID_O_net_0,
        DATA_R_O            => DATA_R_O_net_0,
        DATA_G_O            => DATA_G_O_net_0,
        DATA_B_O            => DATA_B_O_net_0,
        TDATA_O             => OPEN,
        TSTRB_O             => OPEN,
        TKEEP_O             => OPEN,
        TUSER_O             => OPEN,
        TLAST_O             => OPEN,
        TVALID_O            => OPEN 
        );

end RTL;
