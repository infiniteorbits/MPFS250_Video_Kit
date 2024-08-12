----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Mon Aug 12 21:23:39 2024
-- Parameters for Bayer_Interpolation
----------------------------------------------------------------------


LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

package coreparameters is
    constant FAMILY : integer := 19;
    constant G_CONFIG : integer := 0;
    constant G_DATA_WIDTH : integer := 8;
    constant G_FORMAT : integer := 0;
    constant G_PIXELS : integer := 1;
    constant G_RAM_SIZE : integer := 2048;
    constant HDL_license : string( 1 to 1 ) := "E";
    constant testbench : string( 1 to 4 ) := "User";
    constant TGIGEN_DISPLAY_SYMBOL : integer := 1;
end coreparameters;
