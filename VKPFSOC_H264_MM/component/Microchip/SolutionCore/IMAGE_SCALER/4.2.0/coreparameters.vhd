----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Sun Apr 28 14:51:35 2024
-- Parameters for IMAGE_SCALER
----------------------------------------------------------------------


LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

package coreparameters is
    constant FAMILY : integer := 26;
    constant G_DATA_WIDTH : integer := 8;
    constant G_FORMAT : integer := 0;
    constant G_HRES_IN : integer := 1920;
    constant G_HRES_OUT : integer := 1920;
    constant G_HRES_SCALE : integer := 1023;
    constant G_INPUT_FIFO_AWIDTH : integer := 13;
    constant G_OUTPUT_FIFO_AWIDTH : integer := 13;
    constant G_VRES_IN : integer := 1080;
    constant G_VRES_OUT : integer := 1072;
    constant G_VRES_SCALE : integer := 1030;
    constant HDL_license : string( 1 to 1 ) := "O";
    constant TGIGEN_DISPLAY_SYMBOL : integer := 1;
end coreparameters;
