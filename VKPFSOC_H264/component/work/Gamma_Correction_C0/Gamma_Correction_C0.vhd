----------------------------------------------------------------------
-- Created by SmartDesign Wed May 22 10:31:30 2024
-- Version: 2023.2 2023.2.0.8
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Component Description (Tcl) 
----------------------------------------------------------------------
--# Exporting Component Description of Gamma_Correction_C0 to TCL
--# Family: PolarFireSoC
--# Part Number: MPFS250TS-1FCG1152I
--# Create and Configure the core component Gamma_Correction_C0
--create_and_configure_core -core_vlnv {Microsemi:SolutionCore:Gamma_Correction:4.3.0} -component_name {Gamma_Correction_C0} -params {\
--"G_DATA_WIDTH:8"  \
--"G_FORMAT:0"  \
--"G_PIXELS:1"   }
--# Exporting Component Description of Gamma_Correction_C0 to TCL done

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library polarfire;
use polarfire.all;
----------------------------------------------------------------------
-- Gamma_Correction_C0 entity declaration
----------------------------------------------------------------------
entity Gamma_Correction_C0 is
    -- Port list
    port(
        -- Inputs
        BLUE_I       : in  std_logic_vector(7 downto 0);
        DATA_VALID_I : in  std_logic;
        GREEN_I      : in  std_logic_vector(7 downto 0);
        RED_I        : in  std_logic_vector(7 downto 0);
        RESETN_I     : in  std_logic;
        SYS_CLK_I    : in  std_logic;
        -- Outputs
        BLUE_O       : out std_logic_vector(7 downto 0);
        DATA_VALID_O : out std_logic;
        GREEN_O      : out std_logic_vector(7 downto 0);
        RED_O        : out std_logic_vector(7 downto 0)
        );
end Gamma_Correction_C0;
----------------------------------------------------------------------
-- Gamma_Correction_C0 architecture body
----------------------------------------------------------------------
architecture RTL of Gamma_Correction_C0 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- Gamma_Correction   -   Microsemi:SolutionCore:Gamma_Correction:4.3.0
component Gamma_Correction
    generic( 
        G_DATA_WIDTH : integer := 8 ;
        G_FORMAT     : integer := 0 ;
        G_PIXELS     : integer := 1 
        );
    -- Port list
    port(
        -- Inputs
        BLUE_I       : in  std_logic_vector(7 downto 0);
        DATA_VALID_I : in  std_logic;
        GREEN_I      : in  std_logic_vector(7 downto 0);
        RED_I        : in  std_logic_vector(7 downto 0);
        RESETN_I     : in  std_logic;
        SYS_CLK_I    : in  std_logic;
        TDATA_I      : in  std_logic_vector(23 downto 0);
        TUSER_I      : in  std_logic_vector(3 downto 0);
        TVALID_I     : in  std_logic;
        -- Outputs
        BLUE_O       : out std_logic_vector(7 downto 0);
        DATA_VALID_O : out std_logic;
        GREEN_O      : out std_logic_vector(7 downto 0);
        RED_O        : out std_logic_vector(7 downto 0);
        TDATA_O      : out std_logic_vector(23 downto 0);
        TKEEP_O      : out std_logic_vector(0 to 0);
        TLAST_O      : out std_logic;
        TREADY_O     : out std_logic;
        TSTRB_O      : out std_logic_vector(0 to 0);
        TUSER_O      : out std_logic_vector(3 downto 0);
        TVALID_O     : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal BLUE_O_net_0       : std_logic_vector(7 downto 0);
signal DATA_VALID_O_net_0 : std_logic;
signal GREEN_O_net_0      : std_logic_vector(7 downto 0);
signal RED_O_net_0        : std_logic_vector(7 downto 0);
signal DATA_VALID_O_net_1 : std_logic;
signal RED_O_net_1        : std_logic_vector(7 downto 0);
signal GREEN_O_net_1      : std_logic_vector(7 downto 0);
signal BLUE_O_net_1       : std_logic_vector(7 downto 0);
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
 DATA_VALID_O_net_1  <= DATA_VALID_O_net_0;
 DATA_VALID_O        <= DATA_VALID_O_net_1;
 RED_O_net_1         <= RED_O_net_0;
 RED_O(7 downto 0)   <= RED_O_net_1;
 GREEN_O_net_1       <= GREEN_O_net_0;
 GREEN_O(7 downto 0) <= GREEN_O_net_1;
 BLUE_O_net_1        <= BLUE_O_net_0;
 BLUE_O(7 downto 0)  <= BLUE_O_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- Gamma_Correction_C0_0   -   Microsemi:SolutionCore:Gamma_Correction:4.3.0
Gamma_Correction_C0_0 : Gamma_Correction
    generic map( 
        G_DATA_WIDTH => ( 8 ),
        G_FORMAT     => ( 0 ),
        G_PIXELS     => ( 1 )
        )
    port map( 
        -- Inputs
        RESETN_I     => RESETN_I,
        SYS_CLK_I    => SYS_CLK_I,
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
        RED_O        => RED_O_net_0,
        GREEN_O      => GREEN_O_net_0,
        BLUE_O       => BLUE_O_net_0,
        TDATA_O      => OPEN,
        TUSER_O      => OPEN,
        TSTRB_O      => OPEN,
        TKEEP_O      => OPEN,
        TLAST_O      => OPEN,
        TVALID_O     => OPEN 
        );

end RTL;
