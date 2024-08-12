----------------------------------------------------------------------
-- Created by SmartDesign Mon Aug 12 21:23:39 2024
-- Version: 2023.2 2023.2.0.8
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Component Description (Tcl) 
----------------------------------------------------------------------
--# Exporting Component Description of Bayer_Interpolation_C0 to TCL
--# Family: PolarFireSoC
--# Part Number: MPFS250TS-1FCG1152I
--# Create and Configure the core component Bayer_Interpolation_C0
--create_and_configure_core -core_vlnv {Microsemi:SolutionCore:Bayer_Interpolation:4.7.0} -component_name {Bayer_Interpolation_C0} -params {\
--"G_CONFIG:0"  \
--"G_DATA_WIDTH:8"  \
--"G_FORMAT:0"  \
--"G_PIXELS:1"  \
--"G_RAM_SIZE:2048"   }
--# Exporting Component Description of Bayer_Interpolation_C0 to TCL done

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library polarfire;
use polarfire.all;
----------------------------------------------------------------------
-- Bayer_Interpolation_C0 entity declaration
----------------------------------------------------------------------
entity Bayer_Interpolation_C0 is
    -- Port list
    port(
        -- Inputs
        BAYER_FORMAT : in  std_logic_vector(1 downto 0);
        DATA_I       : in  std_logic_vector(7 downto 0);
        DATA_VALID_I : in  std_logic;
        EOF_I        : in  std_logic;
        RESETN_I     : in  std_logic;
        SYS_CLK_I    : in  std_logic;
        -- Outputs
        B_O          : out std_logic_vector(7 downto 0);
        EOF_O        : out std_logic;
        G_O          : out std_logic_vector(7 downto 0);
        RGB_VALID_O  : out std_logic;
        R_O          : out std_logic_vector(7 downto 0)
        );
end Bayer_Interpolation_C0;
----------------------------------------------------------------------
-- Bayer_Interpolation_C0 architecture body
----------------------------------------------------------------------
architecture RTL of Bayer_Interpolation_C0 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- Bayer_Interpolation   -   Microsemi:SolutionCore:Bayer_Interpolation:4.7.0
component Bayer_Interpolation
    generic( 
        G_CONFIG     : integer := 0 ;
        G_DATA_WIDTH : integer := 8 ;
        G_FORMAT     : integer := 0 ;
        G_PIXELS     : integer := 1 ;
        G_RAM_SIZE   : integer := 2048 
        );
    -- Port list
    port(
        -- Inputs
        AXI_ARADDR_I   : in  std_logic_vector(31 downto 0);
        AXI_ARBURST_I  : in  std_logic_vector(1 downto 0);
        AXI_ARCACHE_I  : in  std_logic_vector(3 downto 0);
        AXI_ARID_I     : in  std_logic_vector(1 downto 0);
        AXI_ARLEN_I    : in  std_logic_vector(7 downto 0);
        AXI_ARLOCK_I   : in  std_logic_vector(1 downto 0);
        AXI_ARPROT_I   : in  std_logic_vector(2 downto 0);
        AXI_ARQOS_I    : in  std_logic_vector(3 downto 0);
        AXI_ARREGION_I : in  std_logic_vector(3 downto 0);
        AXI_ARSIZE_I   : in  std_logic_vector(2 downto 0);
        AXI_ARUSER_I   : in  std_logic;
        AXI_ARVALID_I  : in  std_logic;
        AXI_AWADDR_I   : in  std_logic_vector(31 downto 0);
        AXI_AWBURST_I  : in  std_logic_vector(1 downto 0);
        AXI_AWCACHE_I  : in  std_logic_vector(3 downto 0);
        AXI_AWID_I     : in  std_logic_vector(1 downto 0);
        AXI_AWLEN_I    : in  std_logic_vector(7 downto 0);
        AXI_AWLOCK_I   : in  std_logic_vector(1 downto 0);
        AXI_AWPROT_I   : in  std_logic_vector(2 downto 0);
        AXI_AWQOS_I    : in  std_logic_vector(3 downto 0);
        AXI_AWREGION_I : in  std_logic_vector(3 downto 0);
        AXI_AWSIZE_I   : in  std_logic_vector(2 downto 0);
        AXI_AWUSER_I   : in  std_logic;
        AXI_AWVALID_I  : in  std_logic;
        AXI_BREADY_I   : in  std_logic;
        AXI_CLK_I      : in  std_logic;
        AXI_RESETN_I   : in  std_logic;
        AXI_RREADY_I   : in  std_logic;
        AXI_WDATA_I    : in  std_logic_vector(31 downto 0);
        AXI_WLAST_I    : in  std_logic;
        AXI_WSTRB_I    : in  std_logic_vector(3 downto 0);
        AXI_WUSER_I    : in  std_logic;
        AXI_WVALID_I   : in  std_logic;
        BAYER_FORMAT   : in  std_logic_vector(1 downto 0);
        DATA_I         : in  std_logic_vector(7 downto 0);
        DATA_VALID_I   : in  std_logic;
        EOF_I          : in  std_logic;
        RESETN_I       : in  std_logic;
        SYS_CLK_I      : in  std_logic;
        TDATA_I        : in  std_logic_vector(7 downto 0);
        TUSER_I        : in  std_logic_vector(3 downto 0);
        TVALID_I       : in  std_logic;
        -- Outputs
        AXI_ARREADY_O  : out std_logic;
        AXI_AWREADY_O  : out std_logic;
        AXI_BID_O      : out std_logic_vector(1 downto 0);
        AXI_BRESP_O    : out std_logic_vector(1 downto 0);
        AXI_BUSER_O    : out std_logic;
        AXI_BVALID_O   : out std_logic;
        AXI_RDATA_O    : out std_logic_vector(31 downto 0);
        AXI_RID_O      : out std_logic_vector(1 downto 0);
        AXI_RLAST_O    : out std_logic;
        AXI_RRESP_O    : out std_logic_vector(1 downto 0);
        AXI_RUSER_O    : out std_logic;
        AXI_RVALID_O   : out std_logic;
        AXI_WREADY_O   : out std_logic;
        B_O            : out std_logic_vector(7 downto 0);
        EOF_O          : out std_logic;
        G_O            : out std_logic_vector(7 downto 0);
        RGB_VALID_O    : out std_logic;
        R_O            : out std_logic_vector(7 downto 0);
        TDATA_O        : out std_logic_vector(23 downto 0);
        TKEEP_O        : out std_logic_vector(0 to 0);
        TLAST_O        : out std_logic;
        TREADY_O       : out std_logic;
        TSTRB_O        : out std_logic_vector(0 to 0);
        TUSER_O        : out std_logic_vector(3 downto 0);
        TVALID_O       : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal B_O_net_0         : std_logic_vector(7 downto 0);
signal EOF_O_net_0       : std_logic;
signal G_O_net_0         : std_logic_vector(7 downto 0);
signal R_O_net_0         : std_logic_vector(7 downto 0);
signal RGB_VALID_O_net_0 : std_logic;
signal RGB_VALID_O_net_1 : std_logic;
signal R_O_net_1         : std_logic_vector(7 downto 0);
signal G_O_net_1         : std_logic_vector(7 downto 0);
signal B_O_net_1         : std_logic_vector(7 downto 0);
signal EOF_O_net_1       : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal TDATA_I_const_net_0: std_logic_vector(7 downto 0);
signal TUSER_I_const_net_0: std_logic_vector(3 downto 0);
signal GND_net           : std_logic;
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
 TDATA_I_const_net_0        <= B"00000000";
 TUSER_I_const_net_0        <= B"0000";
 GND_net                    <= '0';
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
 RGB_VALID_O_net_1 <= RGB_VALID_O_net_0;
 RGB_VALID_O       <= RGB_VALID_O_net_1;
 R_O_net_1         <= R_O_net_0;
 R_O(7 downto 0)   <= R_O_net_1;
 G_O_net_1         <= G_O_net_0;
 G_O(7 downto 0)   <= G_O_net_1;
 B_O_net_1         <= B_O_net_0;
 B_O(7 downto 0)   <= B_O_net_1;
 EOF_O_net_1       <= EOF_O_net_0;
 EOF_O             <= EOF_O_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- Bayer_Interpolation_C0_0   -   Microsemi:SolutionCore:Bayer_Interpolation:4.7.0
Bayer_Interpolation_C0_0 : Bayer_Interpolation
    generic map( 
        G_CONFIG     => ( 0 ),
        G_DATA_WIDTH => ( 8 ),
        G_FORMAT     => ( 0 ),
        G_PIXELS     => ( 1 ),
        G_RAM_SIZE   => ( 2048 )
        )
    port map( 
        -- Inputs
        RESETN_I       => RESETN_I,
        SYS_CLK_I      => SYS_CLK_I,
        DATA_VALID_I   => DATA_VALID_I,
        TDATA_I        => TDATA_I_const_net_0, -- tied to X"0" from definition
        TUSER_I        => TUSER_I_const_net_0, -- tied to X"0" from definition
        TVALID_I       => GND_net, -- tied to '0' from definition
        DATA_I         => DATA_I,
        EOF_I          => EOF_I,
        BAYER_FORMAT   => BAYER_FORMAT,
        AXI_RESETN_I   => GND_net, -- tied to '0' from definition
        AXI_CLK_I      => GND_net, -- tied to '0' from definition
        AXI_AWVALID_I  => GND_net, -- tied to '0' from definition
        AXI_AWADDR_I   => AXI_AWADDR_I_const_net_0, -- tied to X"0" from definition
        AXI_AWPROT_I   => AXI_AWPROT_I_const_net_0, -- tied to X"0" from definition
        AXI_AWBURST_I  => AXI_AWBURST_I_const_net_0, -- tied to X"0" from definition
        AXI_WDATA_I    => AXI_WDATA_I_const_net_0, -- tied to X"0" from definition
        AXI_WVALID_I   => GND_net, -- tied to '0' from definition
        AXI_WSTRB_I    => AXI_WSTRB_I_const_net_0, -- tied to X"0" from definition
        AXI_BREADY_I   => GND_net, -- tied to '0' from definition
        AXI_ARVALID_I  => GND_net, -- tied to '0' from definition
        AXI_ARADDR_I   => AXI_ARADDR_I_const_net_0, -- tied to X"0" from definition
        AXI_ARPROT_I   => AXI_ARPROT_I_const_net_0, -- tied to X"0" from definition
        AXI_ARBURST_I  => AXI_ARBURST_I_const_net_0, -- tied to X"0" from definition
        AXI_RREADY_I   => GND_net, -- tied to '0' from definition
        AXI_AWID_I     => AXI_AWID_I_const_net_0, -- tied to X"0" from definition
        AXI_AWLEN_I    => AXI_AWLEN_I_const_net_0, -- tied to X"0" from definition
        AXI_AWSIZE_I   => AXI_AWSIZE_I_const_net_0, -- tied to X"0" from definition
        AXI_AWLOCK_I   => AXI_AWLOCK_I_const_net_0, -- tied to X"0" from definition
        AXI_AWCACHE_I  => AXI_AWCACHE_I_const_net_0, -- tied to X"0" from definition
        AXI_AWUSER_I   => GND_net, -- tied to '0' from definition
        AXI_AWQOS_I    => AXI_AWQOS_I_const_net_0, -- tied to X"0" from definition
        AXI_AWREGION_I => AXI_AWREGION_I_const_net_0, -- tied to X"0" from definition
        AXI_WLAST_I    => GND_net, -- tied to '0' from definition
        AXI_WUSER_I    => GND_net, -- tied to '0' from definition
        AXI_ARUSER_I   => GND_net, -- tied to '0' from definition
        AXI_ARID_I     => AXI_ARID_I_const_net_0, -- tied to X"0" from definition
        AXI_ARLEN_I    => AXI_ARLEN_I_const_net_0, -- tied to X"0" from definition
        AXI_ARSIZE_I   => AXI_ARSIZE_I_const_net_0, -- tied to X"0" from definition
        AXI_ARLOCK_I   => AXI_ARLOCK_I_const_net_0, -- tied to X"0" from definition
        AXI_ARCACHE_I  => AXI_ARCACHE_I_const_net_0, -- tied to X"0" from definition
        AXI_ARQOS_I    => AXI_ARQOS_I_const_net_0, -- tied to X"0" from definition
        AXI_ARREGION_I => AXI_ARREGION_I_const_net_0, -- tied to X"0" from definition
        -- Outputs
        AXI_AWREADY_O  => OPEN,
        AXI_WREADY_O   => OPEN,
        AXI_BVALID_O   => OPEN,
        AXI_BRESP_O    => OPEN,
        AXI_ARREADY_O  => OPEN,
        AXI_RDATA_O    => OPEN,
        AXI_RVALID_O   => OPEN,
        AXI_RRESP_O    => OPEN,
        AXI_BUSER_O    => OPEN,
        AXI_RUSER_O    => OPEN,
        AXI_RID_O      => OPEN,
        AXI_RLAST_O    => OPEN,
        AXI_BID_O      => OPEN,
        RGB_VALID_O    => RGB_VALID_O_net_0,
        R_O            => R_O_net_0,
        G_O            => G_O_net_0,
        B_O            => B_O_net_0,
        EOF_O          => EOF_O_net_0,
        TDATA_O        => OPEN,
        TSTRB_O        => OPEN,
        TKEEP_O        => OPEN,
        TUSER_O        => OPEN,
        TREADY_O       => OPEN,
        TVALID_O       => OPEN,
        TLAST_O        => OPEN 
        );

end RTL;
