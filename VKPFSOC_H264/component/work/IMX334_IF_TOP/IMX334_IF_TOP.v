//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Aug 12 21:24:54 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// IMX334_IF_TOP
module IMX334_IF_TOP(
    // Inputs
    ARST_N,
    CAM1_RXD,
    CAM1_RXD_N,
    CAM1_RX_CLK_N,
    CAM1_RX_CLK_P,
    INIT_DONE,
    TRNG_RST_N,
    // Outputs
    CAMCLK_RESET_N,
    CAMERA_CLK,
    PARALLEL_CLOCK,
    c1_data_out_o,
    c1_frame_start_o,
    c1_frame_valid_o,
    c1_line_valid_o
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input        ARST_N;
input  [3:0] CAM1_RXD;
input  [3:0] CAM1_RXD_N;
input        CAM1_RX_CLK_N;
input        CAM1_RX_CLK_P;
input        INIT_DONE;
input        TRNG_RST_N;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output       CAMCLK_RESET_N;
output       CAMERA_CLK;
output       PARALLEL_CLOCK;
output [7:0] c1_data_out_o;
output       c1_frame_start_o;
output       c1_frame_valid_o;
output       c1_line_valid_o;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire         AND2_0_Y;
wire         ARST_N;
wire   [9:2] c1_data_out_o_net_0;
wire         c1_frame_start_o_net_0;
wire         c1_frame_valid_o_net_0;
wire         c1_line_valid_o_net_0;
wire         CAM1_RX_CLK_N;
wire         CAM1_RX_CLK_P;
wire   [3:0] CAM1_RXD;
wire   [3:0] CAM1_RXD_N;
wire         CAMCLK_RESET_N_net_0;
wire         CAMERA_CLK_net_0;
wire         CORERESET_PF_C2_0_FABRIC_RESET_N;
wire         INIT_DONE;
wire         PARALLEL_CLOCK_net_0;
wire         PF_CCC_C2_0_PLL_LOCK_0;
wire         PF_IOD_GENERIC_RX_C0_0_L0_LP_DATA;
wire         PF_IOD_GENERIC_RX_C0_0_L0_LP_DATA_N;
wire   [7:0] PF_IOD_GENERIC_RX_C0_0_L0_RXD_DATA;
wire         PF_IOD_GENERIC_RX_C0_0_L1_LP_DATA;
wire         PF_IOD_GENERIC_RX_C0_0_L1_LP_DATA_N;
wire   [7:0] PF_IOD_GENERIC_RX_C0_0_L1_RXD_DATA;
wire         PF_IOD_GENERIC_RX_C0_0_L2_LP_DATA;
wire         PF_IOD_GENERIC_RX_C0_0_L2_LP_DATA_N;
wire   [7:0] PF_IOD_GENERIC_RX_C0_0_L2_RXD_DATA;
wire         PF_IOD_GENERIC_RX_C0_0_L3_LP_DATA;
wire         PF_IOD_GENERIC_RX_C0_0_L3_LP_DATA_N;
wire   [7:0] PF_IOD_GENERIC_RX_C0_0_L3_RXD_DATA;
wire         PF_IOD_GENERIC_RX_C0_0_training_done_o;
wire         TRNG_RST_N;
wire         CAMCLK_RESET_N_net_1;
wire         CAMERA_CLK_net_1;
wire         PARALLEL_CLOCK_net_1;
wire         c1_frame_start_o_net_1;
wire         c1_frame_valid_o_net_1;
wire         c1_line_valid_o_net_1;
wire   [7:0] c1_data_out_o_net_1;
wire   [9:0] DATA_O_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire         VCC_net;
wire         GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net = 1'b1;
assign GND_net = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign CAMCLK_RESET_N_net_1   = CAMCLK_RESET_N_net_0;
assign CAMCLK_RESET_N         = CAMCLK_RESET_N_net_1;
assign CAMERA_CLK_net_1       = CAMERA_CLK_net_0;
assign CAMERA_CLK             = CAMERA_CLK_net_1;
assign PARALLEL_CLOCK_net_1   = PARALLEL_CLOCK_net_0;
assign PARALLEL_CLOCK         = PARALLEL_CLOCK_net_1;
assign c1_frame_start_o_net_1 = c1_frame_start_o_net_0;
assign c1_frame_start_o       = c1_frame_start_o_net_1;
assign c1_frame_valid_o_net_1 = c1_frame_valid_o_net_0;
assign c1_frame_valid_o       = c1_frame_valid_o_net_1;
assign c1_line_valid_o_net_1  = c1_line_valid_o_net_0;
assign c1_line_valid_o        = c1_line_valid_o_net_1;
assign c1_data_out_o_net_1    = c1_data_out_o_net_0;
assign c1_data_out_o[7:0]     = c1_data_out_o_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign c1_data_out_o_net_0 = DATA_O_net_0[9:2];
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_0(
        // Inputs
        .A ( TRNG_RST_N ),
        .B ( PF_CCC_C2_0_PLL_LOCK_0 ),
        // Outputs
        .Y ( AND2_0_Y ) 
        );

//--------CORERESET_PF_C1
CORERESET_PF_C1 CORERESET_PF_C1_0(
        // Inputs
        .CLK                ( PARALLEL_CLOCK_net_0 ),
        .EXT_RST_N          ( PF_IOD_GENERIC_RX_C0_0_training_done_o ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( PF_CCC_C2_0_PLL_LOCK_0 ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( INIT_DONE ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( VCC_net ),
        // Outputs
        .PLL_POWERDOWN_B    (  ),
        .FABRIC_RESET_N     ( CAMCLK_RESET_N_net_0 ) 
        );

//--------CORERESET_PF_C2
CORERESET_PF_C2 CORERESET_PF_C2_0(
        // Inputs
        .CLK                ( CAMERA_CLK_net_0 ),
        .EXT_RST_N          ( PF_IOD_GENERIC_RX_C0_0_training_done_o ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( PF_CCC_C2_0_PLL_LOCK_0 ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( INIT_DONE ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( VCC_net ),
        // Outputs
        .PLL_POWERDOWN_B    (  ),
        .FABRIC_RESET_N     ( CORERESET_PF_C2_0_FABRIC_RESET_N ) 
        );

//--------mipicsi2rxdecoderPF_C0
mipicsi2rxdecoderPF_C0 CSI2_RXDecoder_0(
        // Inputs
        .CAM_CLOCK_I       ( CAMERA_CLK_net_0 ),
        .PARALLEL_CLOCK_I  ( PARALLEL_CLOCK_net_0 ),
        .RESET_N_I         ( CORERESET_PF_C2_0_FABRIC_RESET_N ),
        .L0_HS_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L0_RXD_DATA ),
        .L1_HS_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L1_RXD_DATA ),
        .L2_HS_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L2_RXD_DATA ),
        .L3_HS_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L3_RXD_DATA ),
        .L0_LP_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L0_LP_DATA ),
        .L0_LP_DATA_N_I    ( PF_IOD_GENERIC_RX_C0_0_L0_LP_DATA_N ),
        .L1_LP_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L1_LP_DATA ),
        .L1_LP_DATA_N_I    ( PF_IOD_GENERIC_RX_C0_0_L1_LP_DATA_N ),
        .L2_LP_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L2_LP_DATA ),
        .L2_LP_DATA_N_I    ( PF_IOD_GENERIC_RX_C0_0_L2_LP_DATA_N ),
        .L3_LP_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L3_LP_DATA ),
        .L3_LP_DATA_N_I    ( PF_IOD_GENERIC_RX_C0_0_L3_LP_DATA_N ),
        // Outputs
        .FRAME_VALID_O     ( c1_frame_valid_o_net_0 ),
        .FRAME_START_O     ( c1_frame_start_o_net_0 ),
        .FRAME_END_O       (  ),
        .LINE_VALID_O      ( c1_line_valid_o_net_0 ),
        .LINE_START_O      (  ),
        .LINE_END_O        (  ),
        .DATA_O            ( DATA_O_net_0 ),
        .VIRTUAL_CHANNEL_O (  ),
        .DATA_TYPE_O       (  ),
        .ECC_ERROR_O       (  ),
        .CRC_ERROR_O       (  ),
        .WORD_COUNT_O      (  ),
        .EBD_VALID_O       (  ) 
        );

//--------PF_CCC_C2
PF_CCC_C2 PF_CCC_C2_0(
        // Inputs
        .REF_CLK_0     ( CAMERA_CLK_net_0 ),
        // Outputs
        .OUT0_FABCLK_0 ( PARALLEL_CLOCK_net_0 ),
        .PLL_LOCK_0    ( PF_CCC_C2_0_PLL_LOCK_0 ) 
        );

//--------CAM_IOD_TIP_TOP
CAM_IOD_TIP_TOP PF_IOD_GENERIC_RX_C0_0(
        // Inputs
        .ARST_N          ( ARST_N ),
        .HS_IO_CLK_PAUSE ( GND_net ),
        .HS_SEL          ( VCC_net ),
        .PLL_LOCK        ( PF_CCC_C2_0_PLL_LOCK_0 ),
        .RESTART_TRNG    ( GND_net ),
        .RX_CLK_N        ( CAM1_RX_CLK_N ),
        .RX_CLK_P        ( CAM1_RX_CLK_P ),
        .SKIP_TRNG       ( GND_net ),
        .TRAINING_RESETN ( AND2_0_Y ),
        .RXD_N           ( CAM1_RXD_N ),
        .RXD             ( CAM1_RXD ),
        // Outputs
        .CLK_TRAIN_DONE  (  ),
        .CLK_TRAIN_ERROR (  ),
        .L0_LP_DATA_N    ( PF_IOD_GENERIC_RX_C0_0_L0_LP_DATA_N ),
        .L0_LP_DATA      ( PF_IOD_GENERIC_RX_C0_0_L0_LP_DATA ),
        .L1_LP_DATA_N    ( PF_IOD_GENERIC_RX_C0_0_L1_LP_DATA_N ),
        .L1_LP_DATA      ( PF_IOD_GENERIC_RX_C0_0_L1_LP_DATA ),
        .L2_LP_DATA_N    ( PF_IOD_GENERIC_RX_C0_0_L2_LP_DATA_N ),
        .L2_LP_DATA      ( PF_IOD_GENERIC_RX_C0_0_L2_LP_DATA ),
        .L3_LP_DATA_N    ( PF_IOD_GENERIC_RX_C0_0_L3_LP_DATA_N ),
        .L3_LP_DATA      ( PF_IOD_GENERIC_RX_C0_0_L3_LP_DATA ),
        .RX_CLK_G        ( CAMERA_CLK_net_0 ),
        .training_done_o ( PF_IOD_GENERIC_RX_C0_0_training_done_o ),
        .L0_RXD_DATA     ( PF_IOD_GENERIC_RX_C0_0_L0_RXD_DATA ),
        .L1_RXD_DATA     ( PF_IOD_GENERIC_RX_C0_0_L1_RXD_DATA ),
        .L2_RXD_DATA     ( PF_IOD_GENERIC_RX_C0_0_L2_RXD_DATA ),
        .L3_RXD_DATA     ( PF_IOD_GENERIC_RX_C0_0_L3_RXD_DATA ) 
        );


endmodule
