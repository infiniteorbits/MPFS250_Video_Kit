----------------------------------------------------------------------
-- Created by SmartDesign Wed May 22 10:31:48 2024
-- Version: 2023.2 2023.2.0.8
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Component Description (Tcl) 
----------------------------------------------------------------------
--# Exporting Component Description of RGBtoYCbCr_C0 to TCL
--# Family: PolarFireSoC
--# Part Number: MPFS250TS-1FCG1152I
--# Create and Configure the core component RGBtoYCbCr_C0
--create_and_configure_core -core_vlnv {Microsemi:SolutionCore:RGBtoYCbCr:4.4.0} -component_name {RGBtoYCbCr_C0} -params {\
--"G_FORMAT:0"  \
--"G_RGB_DATA_BIT_WIDTH:8"  \
--"G_YCbCr_DATA_BIT_WIDTH:8"  \
--"G_YCbCr_FORMAT:2"   }
--# Exporting Component Description of RGBtoYCbCr_C0 to TCL done

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library polarfire;
use polarfire.all;
----------------------------------------------------------------------
-- RGBtoYCbCr_C0 entity declaration
----------------------------------------------------------------------
entity RGBtoYCbCr_C0 is
    -- Port list
    port(
        -- Inputs
        BLUE_I       : in  std_logic_vector(7 downto 0);
        CLOCK_I      : in  std_logic;
        DATA_VALID_I : in  std_logic;
        GREEN_I      : in  std_logic_vector(7 downto 0);
        RED_I        : in  std_logic_vector(7 downto 0);
        RESET_N_I    : in  std_logic;
        -- Outputs
        C_OUT        : out std_logic_vector(7 downto 0);
        DATA_VALID_O : out std_logic;
        Y_OUT        : out std_logic_vector(7 downto 0)
        );
end RGBtoYCbCr_C0;
----------------------------------------------------------------------
-- RGBtoYCbCr_C0 architecture body
----------------------------------------------------------------------
architecture RTL of RGBtoYCbCr_C0 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- RGBtoYCbCr   -   Microsemi:SolutionCore:RGBtoYCbCr:4.4.0
component RGBtoYCbCr
    generic( 
        G_FORMAT               : integer := 0 ;
        G_RGB_DATA_BIT_WIDTH   : integer := 8 ;
        G_YCbCr_DATA_BIT_WIDTH : integer := 8 ;
        G_YCbCr_FORMAT         : integer := 2 ;
        TGIGEN_DISPLAY_SYMBOL  : integer := 1 
        );
    -- Port list
    port(
        -- Inputs
        BLUE_I       : in  std_logic_vector(7 downto 0);
        CLOCK_I      : in  std_logic;
        DATA_VALID_I : in  std_logic;
        GREEN_I      : in  std_logic_vector(7 downto 0);
        RED_I        : in  std_logic_vector(7 downto 0);
        RESET_N_I    : in  std_logic;
        TDATA_I      : in  std_logic_vector(23 downto 0);
        TUSER_I      : in  std_logic_vector(3 downto 0);
        TVALID_I     : in  std_logic;
        -- Outputs
        C_OUT        : out std_logic_vector(7 downto 0);
        Cb_OUT_O     : out std_logic_vector(7 downto 0);
        Cr_OUT_O     : out std_logic_vector(7 downto 0);
        DATA_VALID_O : out std_logic;
        TDATA_O      : out std_logic_vector(15 downto 0);
        TKEEP_O      : out std_logic_vector(0 to 0);
        TLAST_O      : out std_logic;
        TREADY_O     : out std_logic;
        TSTRB_O      : out std_logic_vector(0 to 0);
        TUSER_O      : out std_logic_vector(3 downto 0);
        TVALID_O     : out std_logic;
        Y_OUT        : out std_logic_vector(7 downto 0);
        Y_OUT_O      : out std_logic_vector(7 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal C_OUT_net_0        : std_logic_vector(7 downto 0);
signal DATA_VALID_O_net_0 : std_logic;
signal Y_OUT_net_0        : std_logic_vector(7 downto 0);
signal DATA_VALID_O_net_1 : std_logic;
signal Y_OUT_net_1        : std_logic_vector(7 downto 0);
signal C_OUT_net_1        : std_logic_vector(7 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal TDATA_I_const_net_0: std_logic_vector(23 downto 0);
signal TUSER_I_const_net_0: std_logic_vector(3 downto 0);
signal GND_net            : std_logic;

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
 DATA_VALID_O_net_1 <= DATA_VALID_O_net_0;
 DATA_VALID_O       <= DATA_VALID_O_net_1;
 Y_OUT_net_1        <= Y_OUT_net_0;
 Y_OUT(7 downto 0)  <= Y_OUT_net_1;
 C_OUT_net_1        <= C_OUT_net_0;
 C_OUT(7 downto 0)  <= C_OUT_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- RGBtoYCbCr_C0_0   -   Microsemi:SolutionCore:RGBtoYCbCr:4.4.0
RGBtoYCbCr_C0_0 : RGBtoYCbCr
    generic map( 
        G_FORMAT               => ( 0 ),
        G_RGB_DATA_BIT_WIDTH   => ( 8 ),
        G_YCbCr_DATA_BIT_WIDTH => ( 8 ),
        G_YCbCr_FORMAT         => ( 2 ),
        TGIGEN_DISPLAY_SYMBOL  => ( 1 )
        )
    port map( 
        -- Inputs
        RESET_N_I    => RESET_N_I,
        CLOCK_I      => CLOCK_I,
        DATA_VALID_I => DATA_VALID_I,
        TDATA_I      => TDATA_I_const_net_0, -- tied to X"0" from definition
        TUSER_I      => TUSER_I_const_net_0, -- tied to X"0" from definition
        TVALID_I     => GND_net, -- tied to '0' from definition
        RED_I        => RED_I,
        GREEN_I      => GREEN_I,
        BLUE_I       => BLUE_I,
        -- Outputs
        TREADY_O     => OPEN,
        DATA_VALID_O => DATA_VALID_O_net_0,
        Y_OUT_O      => OPEN,
        Cb_OUT_O     => OPEN,
        Cr_OUT_O     => OPEN,
        Y_OUT        => Y_OUT_net_0,
        C_OUT        => C_OUT_net_0,
        TDATA_O      => OPEN,
        TVALID_O     => OPEN,
        TLAST_O      => OPEN,
        TSTRB_O      => OPEN,
        TKEEP_O      => OPEN,
        TUSER_O      => OPEN 
        );

end RTL;
