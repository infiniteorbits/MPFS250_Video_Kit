//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Wed May 22 10:33:31 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// video_processing
module video_processing(
    // Inputs
    B_CONST_I,
    COMMON_CONST_I,
    DATA_I,
    DATA_VALID_I,
    G_CONST_I,
    OSD_EN_I,
    RESETN_I,
    R_CONST_I,
    SYS_CLK_I,
    coordinate_i,
    digits_i,
    encoder_en_i,
    frame_start_i,
    hres_i,
    text_color_rgb_i,
    vres_i,
    // Outputs
    DATA_B_O,
    DATA_G_O,
    DATA_R_O,
    DATA_VALID_O,
    encoder_en_o,
    eof_encoder_o,
    frame_start_encoder_o,
    y_o
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [9:0]  B_CONST_I;
input  [19:0] COMMON_CONST_I;
input  [7:0]  DATA_I;
input         DATA_VALID_I;
input  [9:0]  G_CONST_I;
input         OSD_EN_I;
input         RESETN_I;
input  [9:0]  R_CONST_I;
input         SYS_CLK_I;
input  [31:0] coordinate_i;
input  [11:0] digits_i;
input         encoder_en_i;
input         frame_start_i;
input  [15:0] hres_i;
input  [23:0] text_color_rgb_i;
input  [15:0] vres_i;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [7:0]  DATA_B_O;
output [7:0]  DATA_G_O;
output [7:0]  DATA_R_O;
output        DATA_VALID_O;
output        encoder_en_o;
output        eof_encoder_o;
output        frame_start_encoder_o;
output [31:0] y_o;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          AND2_0_Y;
wire   [9:0]  B_CONST_I;
wire   [7:0]  Bayer_Interpolation_C0_0_B_O;
wire          Bayer_Interpolation_C0_0_EOF_O;
wire   [7:0]  Bayer_Interpolation_C0_0_G_O;
wire   [7:0]  Bayer_Interpolation_C0_0_R_O;
wire          Bayer_Interpolation_C0_0_RGB_VALID_O;
wire   [19:0] COMMON_CONST_I;
wire   [31:0] coordinate_i;
wire   [7:0]  DATA_B_O_net_0;
wire   [7:0]  DATA_G_O_net_0;
wire   [7:0]  DATA_I;
wire   [7:0]  DATA_R_O_net_0;
wire          DATA_VALID_I;
wire          DATA_VALID_O_net_0;
wire   [11:0] digits_i;
wire          encoder_en_i;
wire          encoder_en_o_net_0;
wire          eof_encoder_o_net_0;
wire   [7:0]  frame_controls_gen_0_data_b_r1_o;
wire   [7:0]  frame_controls_gen_0_data_g_r1_o;
wire   [7:0]  frame_controls_gen_0_data_r_r1_o;
wire          frame_controls_gen_0_data_valid_r1_o;
wire          frame_controls_gen_0_frame_start_r1_o;
wire   [15:0] frame_controls_gen_0_h_scale_factor_o;
wire   [15:0] frame_controls_gen_0_v_scale_factor_o;
wire          frame_start_encoder_o_net_0;
wire          frame_start_i;
wire   [9:0]  G_CONST_I;
wire   [7:0]  Gamma_Correction_C0_0_BLUE_O;
wire          Gamma_Correction_C0_0_DATA_VALID_O;
wire   [7:0]  Gamma_Correction_C0_0_GREEN_O;
wire   [7:0]  Gamma_Correction_C0_0_RED_O;
wire   [15:0] hres_i;
wire   [12:0] hres_i_slice_0;
wire   [7:0]  Image_Enhancement_C0_0_B_O;
wire          Image_Enhancement_C0_0_DATA_VALID_O;
wire   [7:0]  Image_Enhancement_C0_0_G_O;
wire   [7:0]  Image_Enhancement_C0_0_R_O;
wire   [7:0]  IMAGE_SCALER_C0_0_DATA_B_O;
wire   [7:0]  IMAGE_SCALER_C0_0_DATA_G_O;
wire   [7:0]  IMAGE_SCALER_C0_0_DATA_R_O;
wire          IMAGE_SCALER_C0_0_DATA_VALID_O;
wire          OSD_EN_I;
wire   [9:0]  R_CONST_I;
wire          RESETN_I;
wire          SYS_CLK_I;
wire   [23:0] text_color_rgb_i;
wire   [15:0] vres_i;
wire   [12:0] vres_i_slice_0;
wire   [31:0] y_o_net_0;
wire          DATA_VALID_O_net_1;
wire          encoder_en_o_net_1;
wire          eof_encoder_o_net_1;
wire          frame_start_encoder_o_net_1;
wire   [7:0]  DATA_B_O_net_1;
wire   [7:0]  DATA_G_O_net_1;
wire   [7:0]  DATA_R_O_net_1;
wire   [31:0] y_o_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [1:0]  BAYER_FORMAT_const_net_0;
wire          VCC_net;
wire   [12:0] HORZ_RES_IN_I_const_net_0;
wire   [12:0] VERT_RES_IN_I_const_net_0;
//--------------------------------------------------------------------
// Inverted Nets
//--------------------------------------------------------------------
wire          B_IN_POST_INV0_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign BAYER_FORMAT_const_net_0  = 2'h0;
assign VCC_net                   = 1'b1;
assign HORZ_RES_IN_I_const_net_0 = 13'h0780;
assign VERT_RES_IN_I_const_net_0 = 13'h0438;
//--------------------------------------------------------------------
// Inversions
//--------------------------------------------------------------------
assign B_IN_POST_INV0_0 = ~ frame_controls_gen_0_frame_start_r1_o;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign DATA_VALID_O_net_1          = DATA_VALID_O_net_0;
assign DATA_VALID_O                = DATA_VALID_O_net_1;
assign encoder_en_o_net_1          = encoder_en_o_net_0;
assign encoder_en_o                = encoder_en_o_net_1;
assign eof_encoder_o_net_1         = eof_encoder_o_net_0;
assign eof_encoder_o               = eof_encoder_o_net_1;
assign frame_start_encoder_o_net_1 = frame_start_encoder_o_net_0;
assign frame_start_encoder_o       = frame_start_encoder_o_net_1;
assign DATA_B_O_net_1              = DATA_B_O_net_0;
assign DATA_B_O[7:0]               = DATA_B_O_net_1;
assign DATA_G_O_net_1              = DATA_G_O_net_0;
assign DATA_G_O[7:0]               = DATA_G_O_net_1;
assign DATA_R_O_net_1              = DATA_R_O_net_0;
assign DATA_R_O[7:0]               = DATA_R_O_net_1;
assign y_o_net_1                   = y_o_net_0;
assign y_o[31:0]                   = y_o_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign hres_i_slice_0 = hres_i[12:0];
assign vres_i_slice_0 = vres_i[12:0];
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_0(
        // Inputs
        .A ( RESETN_I ),
        .B ( B_IN_POST_INV0_0 ),
        // Outputs
        .Y ( AND2_0_Y ) 
        );

//--------Bayer_Interpolation_C0
Bayer_Interpolation_C0 Bayer_Interpolation_C0_0(
        // Inputs
        .RESETN_I     ( RESETN_I ),
        .SYS_CLK_I    ( SYS_CLK_I ),
        .DATA_VALID_I ( DATA_VALID_I ),
        .DATA_I       ( DATA_I ),
        .EOF_I        ( frame_start_i ),
        .BAYER_FORMAT ( BAYER_FORMAT_const_net_0 ),
        // Outputs
        .RGB_VALID_O  ( Bayer_Interpolation_C0_0_RGB_VALID_O ),
        .R_O          ( Bayer_Interpolation_C0_0_R_O ),
        .G_O          ( Bayer_Interpolation_C0_0_G_O ),
        .B_O          ( Bayer_Interpolation_C0_0_B_O ),
        .EOF_O        ( Bayer_Interpolation_C0_0_EOF_O ) 
        );

//--------CR_OSD
CR_OSD CR_OSD_0(
        // Inputs
        .DATA_VALID_I     ( frame_controls_gen_0_data_valid_r1_o ),
        .FRAME_END_I      ( eof_encoder_o_net_0 ),
        .RESETN_I         ( RESETN_I ),
        .SYS_CLK_I        ( SYS_CLK_I ),
        .OSD_EN_I         ( OSD_EN_I ),
        .r_i              ( frame_controls_gen_0_data_r_r1_o ),
        .g_i              ( frame_controls_gen_0_data_g_r1_o ),
        .b_i              ( frame_controls_gen_0_data_b_r1_o ),
        .hres_i           ( hres_i ),
        .vres_i           ( vres_i ),
        .coordinate_i     ( coordinate_i ),
        .num_i            ( digits_i ),
        .text_color_rgb_i ( text_color_rgb_i ),
        // Outputs
        .data_valid_o     ( DATA_VALID_O_net_0 ),
        .b_o              ( DATA_B_O_net_0 ),
        .g_o              ( DATA_G_O_net_0 ),
        .r_o              ( DATA_R_O_net_0 ) 
        );

//--------frame_controls_gen
frame_controls_gen frame_controls_gen_0(
        // Inputs
        .sys_clk_i             ( SYS_CLK_I ),
        .resetn_i              ( RESETN_I ),
        .encoder_en_i          ( encoder_en_i ),
        .frame_start_i         ( frame_start_i ),
        .hres_i                ( hres_i ),
        .vres_i                ( vres_i ),
        .data_valid_i          ( IMAGE_SCALER_C0_0_DATA_VALID_O ),
        .data_r_i              ( IMAGE_SCALER_C0_0_DATA_R_O ),
        .data_g_i              ( IMAGE_SCALER_C0_0_DATA_G_O ),
        .data_b_i              ( IMAGE_SCALER_C0_0_DATA_B_O ),
        // Outputs
        .data_valid_r1_o       ( frame_controls_gen_0_data_valid_r1_o ),
        .data_r_r1_o           ( frame_controls_gen_0_data_r_r1_o ),
        .data_g_r1_o           ( frame_controls_gen_0_data_g_r1_o ),
        .data_b_r1_o           ( frame_controls_gen_0_data_b_r1_o ),
        .frame_start_r1_o      ( frame_controls_gen_0_frame_start_r1_o ),
        .h_scale_factor_o      ( frame_controls_gen_0_h_scale_factor_o ),
        .v_scale_factor_o      ( frame_controls_gen_0_v_scale_factor_o ),
        .encoder_en_o          ( encoder_en_o_net_0 ),
        .frame_start_encoder_o ( frame_start_encoder_o_net_0 ),
        .eof_encoder_o         ( eof_encoder_o_net_0 ) 
        );

//--------Gamma_Correction_C0
Gamma_Correction_C0 Gamma_Correction_C0_0(
        // Inputs
        .RESETN_I     ( RESETN_I ),
        .SYS_CLK_I    ( SYS_CLK_I ),
        .DATA_VALID_I ( Bayer_Interpolation_C0_0_RGB_VALID_O ),
        .RED_I        ( Bayer_Interpolation_C0_0_R_O ),
        .GREEN_I      ( Bayer_Interpolation_C0_0_G_O ),
        .BLUE_I       ( Bayer_Interpolation_C0_0_B_O ),
        // Outputs
        .DATA_VALID_O ( Gamma_Correction_C0_0_DATA_VALID_O ),
        .RED_O        ( Gamma_Correction_C0_0_RED_O ),
        .GREEN_O      ( Gamma_Correction_C0_0_GREEN_O ),
        .BLUE_O       ( Gamma_Correction_C0_0_BLUE_O ) 
        );

//--------Image_Enhancement_C0
Image_Enhancement_C0 Image_Enhancement_C0_0(
        // Inputs
        .RESETN_I       ( RESETN_I ),
        .SYS_CLK_I      ( SYS_CLK_I ),
        .DATA_VALID_I   ( Gamma_Correction_C0_0_DATA_VALID_O ),
        .ENABLE_I       ( VCC_net ),
        .R_I            ( Gamma_Correction_C0_0_RED_O ),
        .G_I            ( Gamma_Correction_C0_0_GREEN_O ),
        .B_I            ( Gamma_Correction_C0_0_BLUE_O ),
        .R_CONST_I      ( R_CONST_I ),
        .G_CONST_I      ( G_CONST_I ),
        .B_CONST_I      ( B_CONST_I ),
        .COMMON_CONST_I ( COMMON_CONST_I ),
        // Outputs
        .DATA_VALID_O   ( Image_Enhancement_C0_0_DATA_VALID_O ),
        .R_O            ( Image_Enhancement_C0_0_R_O ),
        .G_O            ( Image_Enhancement_C0_0_G_O ),
        .B_O            ( Image_Enhancement_C0_0_B_O ) 
        );

//--------IMAGE_SCALER_C0
IMAGE_SCALER_C0 IMAGE_SCALER_C0_0(
        // Inputs
        .RESETN_I            ( AND2_0_Y ),
        .SYS_CLK_I           ( SYS_CLK_I ),
        .IP_CLK_I            ( SYS_CLK_I ),
        .DATA_VALID_I        ( Image_Enhancement_C0_0_DATA_VALID_O ),
        .DATA_R_I            ( Image_Enhancement_C0_0_R_O ),
        .DATA_G_I            ( Image_Enhancement_C0_0_G_O ),
        .DATA_B_I            ( Image_Enhancement_C0_0_B_O ),
        .HORZ_RES_IN_I       ( HORZ_RES_IN_I_const_net_0 ),
        .VERT_RES_IN_I       ( VERT_RES_IN_I_const_net_0 ),
        .HORZ_RES_OUT_I      ( hres_i_slice_0 ),
        .VERT_RES_OUT_I      ( vres_i_slice_0 ),
        .SCALE_FACTOR_HORZ_I ( frame_controls_gen_0_h_scale_factor_o ),
        .SCALE_FACTOR_VERT_I ( frame_controls_gen_0_v_scale_factor_o ),
        // Outputs
        .DATA_VALID_O        ( IMAGE_SCALER_C0_0_DATA_VALID_O ),
        .DATA_R_O            ( IMAGE_SCALER_C0_0_DATA_R_O ),
        .DATA_G_O            ( IMAGE_SCALER_C0_0_DATA_G_O ),
        .DATA_B_O            ( IMAGE_SCALER_C0_0_DATA_B_O ) 
        );

//--------intensity_average
intensity_average intensity_average_0(
        // Inputs
        .RESETN_I     ( RESETN_I ),
        .SYS_CLK_I    ( SYS_CLK_I ),
        .data_valid_i ( Gamma_Correction_C0_0_DATA_VALID_O ),
        .frame_end_i  ( Bayer_Interpolation_C0_0_EOF_O ),
        .r_i          ( Gamma_Correction_C0_0_RED_O ),
        .g_i          ( Gamma_Correction_C0_0_GREEN_O ),
        .b_i          ( Gamma_Correction_C0_0_BLUE_O ),
        // Outputs
        .y_o          ( y_o_net_0 ) 
        );


endmodule
