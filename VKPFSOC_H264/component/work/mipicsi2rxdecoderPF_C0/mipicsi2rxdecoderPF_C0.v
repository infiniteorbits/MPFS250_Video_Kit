//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Aug 12 21:23:58 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of mipicsi2rxdecoderPF_C0 to TCL
# Family: PolarFireSoC
# Part Number: MPFS250TS-1FCG1152I
# Create and Configure the core component mipicsi2rxdecoderPF_C0
create_and_configure_core -core_vlnv {Microchip:SolutionCore:mipicsi2rxdecoderPF:4.7.0} -component_name {mipicsi2rxdecoderPF_C0} -params {\
"g_DATAWIDTH:10"  \
"g_FIFO_SIZE:12"  \
"g_FORMAT:0"  \
"g_INPUT_DATA_INVERT:0"  \
"g_LANE_WIDTH:4"  \
"g_NO_OF_VC:1"  \
"g_NUM_OF_PIXELS:1"   }
# Exporting Component Description of mipicsi2rxdecoderPF_C0 to TCL done
*/

// mipicsi2rxdecoderPF_C0
module mipicsi2rxdecoderPF_C0(
    // Inputs
    CAM_CLOCK_I,
    L0_HS_DATA_I,
    L0_LP_DATA_I,
    L0_LP_DATA_N_I,
    L1_HS_DATA_I,
    L1_LP_DATA_I,
    L1_LP_DATA_N_I,
    L2_HS_DATA_I,
    L2_LP_DATA_I,
    L2_LP_DATA_N_I,
    L3_HS_DATA_I,
    L3_LP_DATA_I,
    L3_LP_DATA_N_I,
    PARALLEL_CLOCK_I,
    RESET_N_I,
    // Outputs
    CRC_ERROR_O,
    DATA_O,
    DATA_TYPE_O,
    EBD_VALID_O,
    ECC_ERROR_O,
    FRAME_END_O,
    FRAME_START_O,
    FRAME_VALID_O,
    LINE_END_O,
    LINE_START_O,
    LINE_VALID_O,
    VIRTUAL_CHANNEL_O,
    WORD_COUNT_O
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         CAM_CLOCK_I;
input  [7:0]  L0_HS_DATA_I;
input         L0_LP_DATA_I;
input         L0_LP_DATA_N_I;
input  [7:0]  L1_HS_DATA_I;
input         L1_LP_DATA_I;
input         L1_LP_DATA_N_I;
input  [7:0]  L2_HS_DATA_I;
input         L2_LP_DATA_I;
input         L2_LP_DATA_N_I;
input  [7:0]  L3_HS_DATA_I;
input         L3_LP_DATA_I;
input         L3_LP_DATA_N_I;
input         PARALLEL_CLOCK_I;
input         RESET_N_I;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        CRC_ERROR_O;
output [9:0]  DATA_O;
output [7:0]  DATA_TYPE_O;
output        EBD_VALID_O;
output        ECC_ERROR_O;
output        FRAME_END_O;
output        FRAME_START_O;
output        FRAME_VALID_O;
output        LINE_END_O;
output        LINE_START_O;
output        LINE_VALID_O;
output [1:0]  VIRTUAL_CHANNEL_O;
output [15:0] WORD_COUNT_O;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          CAM_CLOCK_I;
wire          CRC_ERROR_O_net_0;
wire   [9:0]  DATA_O_net_0;
wire   [7:0]  DATA_TYPE_O_net_0;
wire          EBD_VALID_O_net_0;
wire          ECC_ERROR_O_net_0;
wire          FRAME_END_O_net_0;
wire          FRAME_START_O_net_0;
wire          FRAME_VALID_O_net_0;
wire   [7:0]  L0_HS_DATA_I;
wire          L0_LP_DATA_I;
wire          L0_LP_DATA_N_I;
wire   [7:0]  L1_HS_DATA_I;
wire          L1_LP_DATA_I;
wire          L1_LP_DATA_N_I;
wire   [7:0]  L2_HS_DATA_I;
wire          L2_LP_DATA_I;
wire          L2_LP_DATA_N_I;
wire   [7:0]  L3_HS_DATA_I;
wire          L3_LP_DATA_I;
wire          L3_LP_DATA_N_I;
wire          LINE_END_O_net_0;
wire          LINE_START_O_net_0;
wire          LINE_VALID_O_net_0;
wire          PARALLEL_CLOCK_I;
wire          RESET_N_I;
wire   [1:0]  VIRTUAL_CHANNEL_O_net_0;
wire   [15:0] WORD_COUNT_O_net_0;
wire          FRAME_VALID_O_net_1;
wire          FRAME_START_O_net_1;
wire          FRAME_END_O_net_1;
wire          LINE_VALID_O_net_1;
wire          LINE_START_O_net_1;
wire          LINE_END_O_net_1;
wire   [9:0]  DATA_O_net_1;
wire   [1:0]  VIRTUAL_CHANNEL_O_net_1;
wire   [7:0]  DATA_TYPE_O_net_1;
wire          ECC_ERROR_O_net_1;
wire          CRC_ERROR_O_net_1;
wire   [15:0] WORD_COUNT_O_net_1;
wire          EBD_VALID_O_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [7:0]  L4_HS_DATA_I_const_net_0;
wire   [7:0]  L5_HS_DATA_I_const_net_0;
wire   [7:0]  L6_HS_DATA_I_const_net_0;
wire   [7:0]  L7_HS_DATA_I_const_net_0;
wire          GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign L4_HS_DATA_I_const_net_0 = 8'h00;
assign L5_HS_DATA_I_const_net_0 = 8'h00;
assign L6_HS_DATA_I_const_net_0 = 8'h00;
assign L7_HS_DATA_I_const_net_0 = 8'h00;
assign GND_net                  = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign FRAME_VALID_O_net_1     = FRAME_VALID_O_net_0;
assign FRAME_VALID_O           = FRAME_VALID_O_net_1;
assign FRAME_START_O_net_1     = FRAME_START_O_net_0;
assign FRAME_START_O           = FRAME_START_O_net_1;
assign FRAME_END_O_net_1       = FRAME_END_O_net_0;
assign FRAME_END_O             = FRAME_END_O_net_1;
assign LINE_VALID_O_net_1      = LINE_VALID_O_net_0;
assign LINE_VALID_O            = LINE_VALID_O_net_1;
assign LINE_START_O_net_1      = LINE_START_O_net_0;
assign LINE_START_O            = LINE_START_O_net_1;
assign LINE_END_O_net_1        = LINE_END_O_net_0;
assign LINE_END_O              = LINE_END_O_net_1;
assign DATA_O_net_1            = DATA_O_net_0;
assign DATA_O[9:0]             = DATA_O_net_1;
assign VIRTUAL_CHANNEL_O_net_1 = VIRTUAL_CHANNEL_O_net_0;
assign VIRTUAL_CHANNEL_O[1:0]  = VIRTUAL_CHANNEL_O_net_1;
assign DATA_TYPE_O_net_1       = DATA_TYPE_O_net_0;
assign DATA_TYPE_O[7:0]        = DATA_TYPE_O_net_1;
assign ECC_ERROR_O_net_1       = ECC_ERROR_O_net_0;
assign ECC_ERROR_O             = ECC_ERROR_O_net_1;
assign CRC_ERROR_O_net_1       = CRC_ERROR_O_net_0;
assign CRC_ERROR_O             = CRC_ERROR_O_net_1;
assign WORD_COUNT_O_net_1      = WORD_COUNT_O_net_0;
assign WORD_COUNT_O[15:0]      = WORD_COUNT_O_net_1;
assign EBD_VALID_O_net_1       = EBD_VALID_O_net_0;
assign EBD_VALID_O             = EBD_VALID_O_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------mipicsi2rxdecoderPF   -   Microchip:SolutionCore:mipicsi2rxdecoderPF:4.7.0
mipicsi2rxdecoderPF #( 
        .g_DATAWIDTH         ( 10 ),
        .g_FIFO_SIZE         ( 12 ),
        .g_FORMAT            ( 0 ),
        .g_INPUT_DATA_INVERT ( 0 ),
        .g_LANE_WIDTH        ( 4 ),
        .g_NO_OF_VC          ( 1 ),
        .g_NUM_OF_PIXELS     ( 1 ) )
mipicsi2rxdecoderPF_C0_0(
        // Inputs
        .CAM_CLOCK_I       ( CAM_CLOCK_I ),
        .PARALLEL_CLOCK_I  ( PARALLEL_CLOCK_I ),
        .RESET_N_I         ( RESET_N_I ),
        .L0_HS_DATA_I      ( L0_HS_DATA_I ),
        .L1_HS_DATA_I      ( L1_HS_DATA_I ),
        .L2_HS_DATA_I      ( L2_HS_DATA_I ),
        .L3_HS_DATA_I      ( L3_HS_DATA_I ),
        .L4_HS_DATA_I      ( L4_HS_DATA_I_const_net_0 ), // tied to 8'h00 from definition
        .L5_HS_DATA_I      ( L5_HS_DATA_I_const_net_0 ), // tied to 8'h00 from definition
        .L6_HS_DATA_I      ( L6_HS_DATA_I_const_net_0 ), // tied to 8'h00 from definition
        .L7_HS_DATA_I      ( L7_HS_DATA_I_const_net_0 ), // tied to 8'h00 from definition
        .L0_LP_DATA_I      ( L0_LP_DATA_I ),
        .L0_LP_DATA_N_I    ( L0_LP_DATA_N_I ),
        .L1_LP_DATA_I      ( L1_LP_DATA_I ),
        .L1_LP_DATA_N_I    ( L1_LP_DATA_N_I ),
        .L2_LP_DATA_I      ( L2_LP_DATA_I ),
        .L2_LP_DATA_N_I    ( L2_LP_DATA_N_I ),
        .L3_LP_DATA_I      ( L3_LP_DATA_I ),
        .L3_LP_DATA_N_I    ( L3_LP_DATA_N_I ),
        .L4_LP_DATA_I      ( GND_net ), // tied to 1'b0 from definition
        .L4_LP_DATA_N_I    ( GND_net ), // tied to 1'b0 from definition
        .L5_LP_DATA_I      ( GND_net ), // tied to 1'b0 from definition
        .L5_LP_DATA_N_I    ( GND_net ), // tied to 1'b0 from definition
        .L6_LP_DATA_I      ( GND_net ), // tied to 1'b0 from definition
        .L6_LP_DATA_N_I    ( GND_net ), // tied to 1'b0 from definition
        .L7_LP_DATA_I      ( GND_net ), // tied to 1'b0 from definition
        .L7_LP_DATA_N_I    ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .FRAME_VALID_O     ( FRAME_VALID_O_net_0 ),
        .FRAME_START_O     ( FRAME_START_O_net_0 ),
        .FRAME_END_O       ( FRAME_END_O_net_0 ),
        .LINE_VALID_O      ( LINE_VALID_O_net_0 ),
        .LINE_START_O      ( LINE_START_O_net_0 ),
        .LINE_END_O        ( LINE_END_O_net_0 ),
        .DATA_O            ( DATA_O_net_0 ),
        .VIRTUAL_CHANNEL_O ( VIRTUAL_CHANNEL_O_net_0 ),
        .DATA_TYPE_O       ( DATA_TYPE_O_net_0 ),
        .ECC_ERROR_O       ( ECC_ERROR_O_net_0 ),
        .CRC_ERROR_O       ( CRC_ERROR_O_net_0 ),
        .WORD_COUNT_O      ( WORD_COUNT_O_net_0 ),
        .EBD_VALID_O       ( EBD_VALID_O_net_0 ),
        .TDATA_O           (  ),
        .TSTRB_O           (  ),
        .TKEEP_O           (  ),
        .TVALID_O          (  ),
        .TLAST_O           (  ),
        .TUSER_O           (  ) 
        );


endmodule
