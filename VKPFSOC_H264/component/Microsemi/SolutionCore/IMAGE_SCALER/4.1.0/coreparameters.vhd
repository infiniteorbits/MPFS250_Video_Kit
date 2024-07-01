----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Wed May 22 10:31:33 2024
-- Parameters for IMAGE_SCALER
----------------------------------------------------------------------


LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

package coreparameters is
    constant FAMILY : integer := 26;
    constant G_CONFIG : integer := 0;
    constant G_DATA_WIDTH : integer := 8;
    constant G_FORMAT : integer := 0;
    constant G_INPUT_FIFO_AWIDTH : integer := 11;
    constant G_OUTPUT_FIFO_AWIDTH : integer := 11;
    constant HDL_license : string( 1 to 1 ) := "O";
    constant TGIGEN_DISPLAY_SYMBOL : integer := 1;
end coreparameters;