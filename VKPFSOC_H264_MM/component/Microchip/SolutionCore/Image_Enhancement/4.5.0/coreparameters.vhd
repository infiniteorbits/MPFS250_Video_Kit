----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Sun Apr 28 14:51:37 2024
-- Parameters for Image_Enhancement
----------------------------------------------------------------------


LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

package coreparameters is
    constant FAMILY : integer := 26;
    constant G_BCONST : integer := 165;
    constant G_COMMON_CONSTANT : integer := 1046528;
    constant G_FORMAT : integer := 0;
    constant G_GCONST : integer := 122;
    constant G_PIXEL_WIDTH : integer := 8;
    constant G_PIXELS : integer := 1;
    constant G_RCONST : integer := 146;
    constant HDL_license : string( 1 to 1 ) := "E";
    constant Testbench : string( 1 to 4 ) := "User";
    constant TGIGEN_DISPLAY_SYMBOL : integer := 1;
end coreparameters;
