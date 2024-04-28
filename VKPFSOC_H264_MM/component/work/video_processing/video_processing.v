//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Apr 28 14:51:57 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// video_processing
module video_processing(
    // Inputs
    ACLK_I,
    ARESETN_I,
    AXI4L_H264_araddr,
    AXI4L_H264_arvalid,
    AXI4L_H264_awaddr,
    AXI4L_H264_awvalid,
    AXI4L_H264_bready,
    AXI4L_H264_rready,
    AXI4L_H264_wdata,
    AXI4L_H264_wvalid,
    AXI4L_IE_araddr,
    AXI4L_IE_arvalid,
    AXI4L_IE_awaddr,
    AXI4L_IE_awvalid,
    AXI4L_IE_bready,
    AXI4L_IE_rready,
    AXI4L_IE_wdata,
    AXI4L_IE_wvalid,
    AXI4L_OSD_araddr,
    AXI4L_OSD_arvalid,
    AXI4L_OSD_awaddr,
    AXI4L_OSD_awvalid,
    AXI4L_OSD_bready,
    AXI4L_OSD_rready,
    AXI4L_OSD_wdata,
    AXI4L_OSD_wvalid,
    AXI4L_SCALER_araddr,
    AXI4L_SCALER_arvalid,
    AXI4L_SCALER_awaddr,
    AXI4L_SCALER_awvalid,
    AXI4L_SCALER_bready,
    AXI4L_SCALER_rready,
    AXI4L_SCALER_wdata,
    AXI4L_SCALER_wvalid,
    DATA_I,
    DATA_VALID_I,
    FRAME_START_I,
    RESETN_I,
    SYS_CLK_I,
    // Outputs
    AXI4L_H264_arready,
    AXI4L_H264_awready,
    AXI4L_H264_bresp,
    AXI4L_H264_bvalid,
    AXI4L_H264_rdata,
    AXI4L_H264_rresp,
    AXI4L_H264_rvalid,
    AXI4L_H264_wready,
    AXI4L_IE_arready,
    AXI4L_IE_awready,
    AXI4L_IE_bresp,
    AXI4L_IE_bvalid,
    AXI4L_IE_rdata,
    AXI4L_IE_rresp,
    AXI4L_IE_rvalid,
    AXI4L_IE_wready,
    AXI4L_OSD_arready,
    AXI4L_OSD_awready,
    AXI4L_OSD_bresp,
    AXI4L_OSD_bvalid,
    AXI4L_OSD_rdata,
    AXI4L_OSD_rresp,
    AXI4L_OSD_rvalid,
    AXI4L_OSD_wready,
    AXI4L_SCALER_arready,
    AXI4L_SCALER_awready,
    AXI4L_SCALER_bresp,
    AXI4L_SCALER_bvalid,
    AXI4L_SCALER_rdata,
    AXI4L_SCALER_rresp,
    AXI4L_SCALER_rvalid,
    AXI4L_SCALER_wready,
    DATA_O,
    DATA_VALID_O,
    FRAME_START_O
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         ACLK_I;
input         ARESETN_I;
input  [31:0] AXI4L_H264_araddr;
input         AXI4L_H264_arvalid;
input  [31:0] AXI4L_H264_awaddr;
input         AXI4L_H264_awvalid;
input         AXI4L_H264_bready;
input         AXI4L_H264_rready;
input  [31:0] AXI4L_H264_wdata;
input         AXI4L_H264_wvalid;
input  [31:0] AXI4L_IE_araddr;
input         AXI4L_IE_arvalid;
input  [31:0] AXI4L_IE_awaddr;
input         AXI4L_IE_awvalid;
input         AXI4L_IE_bready;
input         AXI4L_IE_rready;
input  [31:0] AXI4L_IE_wdata;
input         AXI4L_IE_wvalid;
input  [31:0] AXI4L_OSD_araddr;
input         AXI4L_OSD_arvalid;
input  [31:0] AXI4L_OSD_awaddr;
input         AXI4L_OSD_awvalid;
input         AXI4L_OSD_bready;
input         AXI4L_OSD_rready;
input  [31:0] AXI4L_OSD_wdata;
input         AXI4L_OSD_wvalid;
input  [31:0] AXI4L_SCALER_araddr;
input         AXI4L_SCALER_arvalid;
input  [31:0] AXI4L_SCALER_awaddr;
input         AXI4L_SCALER_awvalid;
input         AXI4L_SCALER_bready;
input         AXI4L_SCALER_rready;
input  [31:0] AXI4L_SCALER_wdata;
input         AXI4L_SCALER_wvalid;
input  [7:0]  DATA_I;
input         DATA_VALID_I;
input         FRAME_START_I;
input         RESETN_I;
input         SYS_CLK_I;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        AXI4L_H264_arready;
output        AXI4L_H264_awready;
output [1:0]  AXI4L_H264_bresp;
output        AXI4L_H264_bvalid;
output [31:0] AXI4L_H264_rdata;
output [1:0]  AXI4L_H264_rresp;
output        AXI4L_H264_rvalid;
output        AXI4L_H264_wready;
output        AXI4L_IE_arready;
output        AXI4L_IE_awready;
output [1:0]  AXI4L_IE_bresp;
output        AXI4L_IE_bvalid;
output [31:0] AXI4L_IE_rdata;
output [1:0]  AXI4L_IE_rresp;
output        AXI4L_IE_rvalid;
output        AXI4L_IE_wready;
output        AXI4L_OSD_arready;
output        AXI4L_OSD_awready;
output [1:0]  AXI4L_OSD_bresp;
output        AXI4L_OSD_bvalid;
output [31:0] AXI4L_OSD_rdata;
output [1:0]  AXI4L_OSD_rresp;
output        AXI4L_OSD_rvalid;
output        AXI4L_OSD_wready;
output        AXI4L_SCALER_arready;
output        AXI4L_SCALER_awready;
output [1:0]  AXI4L_SCALER_bresp;
output        AXI4L_SCALER_bvalid;
output [31:0] AXI4L_SCALER_rdata;
output [1:0]  AXI4L_SCALER_rresp;
output        AXI4L_SCALER_rvalid;
output        AXI4L_SCALER_wready;
output [15:0] DATA_O;
output        DATA_VALID_O;
output        FRAME_START_O;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          ACLK_I;
wire          ARESETN_I;
wire   [31:0] AXI4L_H264_araddr;
wire          AXI4L_H264_ARREADY_net_0;
wire          AXI4L_H264_arvalid;
wire   [31:0] AXI4L_H264_awaddr;
wire          AXI4L_H264_AWREADY_net_0;
wire          AXI4L_H264_awvalid;
wire          AXI4L_H264_bready;
wire   [1:0]  AXI4L_H264_BRESP_net_0;
wire          AXI4L_H264_BVALID_net_0;
wire   [31:0] AXI4L_H264_RDATA_net_0;
wire          AXI4L_H264_rready;
wire   [1:0]  AXI4L_H264_RRESP_net_0;
wire          AXI4L_H264_RVALID_net_0;
wire   [31:0] AXI4L_H264_wdata;
wire          AXI4L_H264_WREADY_net_0;
wire          AXI4L_H264_wvalid;
wire   [31:0] AXI4L_IE_araddr;
wire          AXI4L_IE_ARREADY_net_0;
wire          AXI4L_IE_arvalid;
wire   [31:0] AXI4L_IE_awaddr;
wire          AXI4L_IE_AWREADY_net_0;
wire          AXI4L_IE_awvalid;
wire          AXI4L_IE_bready;
wire   [1:0]  AXI4L_IE_BRESP_net_0;
wire          AXI4L_IE_BVALID_net_0;
wire   [31:0] AXI4L_IE_RDATA_net_0;
wire          AXI4L_IE_rready;
wire   [1:0]  AXI4L_IE_RRESP_net_0;
wire          AXI4L_IE_RVALID_net_0;
wire   [31:0] AXI4L_IE_wdata;
wire          AXI4L_IE_WREADY_net_0;
wire          AXI4L_IE_wvalid;
wire   [31:0] AXI4L_OSD_araddr;
wire          AXI4L_OSD_ARREADY_net_0;
wire          AXI4L_OSD_arvalid;
wire   [31:0] AXI4L_OSD_awaddr;
wire          AXI4L_OSD_AWREADY_net_0;
wire          AXI4L_OSD_awvalid;
wire          AXI4L_OSD_bready;
wire   [1:0]  AXI4L_OSD_BRESP_net_0;
wire          AXI4L_OSD_BVALID_net_0;
wire   [31:0] AXI4L_OSD_RDATA_net_0;
wire          AXI4L_OSD_rready;
wire   [1:0]  AXI4L_OSD_RRESP_net_0;
wire          AXI4L_OSD_RVALID_net_0;
wire   [31:0] AXI4L_OSD_wdata;
wire          AXI4L_OSD_WREADY_net_0;
wire          AXI4L_OSD_wvalid;
wire   [31:0] AXI4L_SCALER_araddr;
wire          AXI4L_SCALER_ARREADY_net_0;
wire          AXI4L_SCALER_arvalid;
wire   [31:0] AXI4L_SCALER_awaddr;
wire          AXI4L_SCALER_AWREADY_net_0;
wire          AXI4L_SCALER_awvalid;
wire          AXI4L_SCALER_bready;
wire   [1:0]  AXI4L_SCALER_BRESP_net_0;
wire          AXI4L_SCALER_BVALID_net_0;
wire   [31:0] AXI4L_SCALER_RDATA_net_0;
wire          AXI4L_SCALER_rready;
wire   [1:0]  AXI4L_SCALER_RRESP_net_0;
wire          AXI4L_SCALER_RVALID_net_0;
wire   [31:0] AXI4L_SCALER_wdata;
wire          AXI4L_SCALER_WREADY_net_0;
wire          AXI4L_SCALER_wvalid;
wire   [7:0]  Bayer_Interpolation_C0_0_B_O;
wire   [7:0]  Bayer_Interpolation_C0_0_G_O;
wire   [7:0]  Bayer_Interpolation_C0_0_R_O;
wire          Bayer_Interpolation_C0_0_RGB_VALID_O;
wire   [7:0]  DATA_I;
wire   [15:0] DATA_O_net_0;
wire          DATA_VALID_I;
wire          DATA_VALID_O_net_0;
wire          FRAME_START_I;
wire          FRAME_START_O_net_0;
wire   [7:0]  Gamma_Correction_C0_0_BLUE_O;
wire          Gamma_Correction_C0_0_DATA_VALID_O;
wire   [7:0]  Gamma_Correction_C0_0_GREEN_O;
wire   [7:0]  Gamma_Correction_C0_0_RED_O;
wire   [7:0]  Image_Enhancement_C0_0_B_O;
wire          Image_Enhancement_C0_0_DATA_VALID_O;
wire   [7:0]  Image_Enhancement_C0_0_G_O;
wire   [7:0]  Image_Enhancement_C0_0_R_O;
wire   [7:0]  Image_Scaler_top_0_DATA_B_O;
wire   [7:0]  Image_Scaler_top_0_DATA_G_O;
wire   [7:0]  Image_Scaler_top_0_DATA_R_O;
wire          Image_Scaler_top_0_DATA_VALID_O;
wire   [7:0]  osd_top_0_b_o;
wire          osd_top_0_data_valid_o;
wire   [7:0]  osd_top_0_g_o;
wire   [7:0]  osd_top_0_r_o;
wire          RESETN_I;
wire   [7:0]  RGBtoYCbCr_C0_0_C_OUT;
wire          RGBtoYCbCr_C0_0_DATA_VALID_O;
wire   [7:0]  RGBtoYCbCr_C0_0_Y_OUT;
wire          SYS_CLK_I;
wire          AXI4L_H264_ARREADY_net_1;
wire          AXI4L_H264_AWREADY_net_1;
wire          AXI4L_H264_BVALID_net_1;
wire          AXI4L_H264_RVALID_net_1;
wire          AXI4L_H264_WREADY_net_1;
wire          AXI4L_IE_ARREADY_net_1;
wire          AXI4L_IE_AWREADY_net_1;
wire          AXI4L_IE_BVALID_net_1;
wire          AXI4L_IE_RVALID_net_1;
wire          AXI4L_IE_WREADY_net_1;
wire          AXI4L_OSD_ARREADY_net_1;
wire          AXI4L_OSD_AWREADY_net_1;
wire          AXI4L_OSD_BVALID_net_1;
wire          AXI4L_OSD_RVALID_net_1;
wire          AXI4L_OSD_WREADY_net_1;
wire          AXI4L_SCALER_ARREADY_net_1;
wire          AXI4L_SCALER_AWREADY_net_1;
wire          AXI4L_SCALER_BVALID_net_1;
wire          AXI4L_SCALER_RVALID_net_1;
wire          AXI4L_SCALER_WREADY_net_1;
wire          DATA_VALID_O_net_1;
wire          FRAME_START_O_net_1;
wire   [1:0]  AXI4L_H264_BRESP_net_1;
wire   [31:0] AXI4L_H264_RDATA_net_1;
wire   [1:0]  AXI4L_H264_RRESP_net_1;
wire   [1:0]  AXI4L_IE_BRESP_net_1;
wire   [31:0] AXI4L_IE_RDATA_net_1;
wire   [1:0]  AXI4L_IE_RRESP_net_1;
wire   [1:0]  AXI4L_OSD_BRESP_net_1;
wire   [31:0] AXI4L_OSD_RDATA_net_1;
wire   [1:0]  AXI4L_OSD_RRESP_net_1;
wire   [1:0]  AXI4L_SCALER_BRESP_net_1;
wire   [31:0] AXI4L_SCALER_RDATA_net_1;
wire   [1:0]  AXI4L_SCALER_RRESP_net_1;
wire   [15:0] DATA_O_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [1:0]  BAYER_FORMAT_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign BAYER_FORMAT_const_net_0 = 2'h0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign AXI4L_H264_ARREADY_net_1   = AXI4L_H264_ARREADY_net_0;
assign AXI4L_H264_arready         = AXI4L_H264_ARREADY_net_1;
assign AXI4L_H264_AWREADY_net_1   = AXI4L_H264_AWREADY_net_0;
assign AXI4L_H264_awready         = AXI4L_H264_AWREADY_net_1;
assign AXI4L_H264_BVALID_net_1    = AXI4L_H264_BVALID_net_0;
assign AXI4L_H264_bvalid          = AXI4L_H264_BVALID_net_1;
assign AXI4L_H264_RVALID_net_1    = AXI4L_H264_RVALID_net_0;
assign AXI4L_H264_rvalid          = AXI4L_H264_RVALID_net_1;
assign AXI4L_H264_WREADY_net_1    = AXI4L_H264_WREADY_net_0;
assign AXI4L_H264_wready          = AXI4L_H264_WREADY_net_1;
assign AXI4L_IE_ARREADY_net_1     = AXI4L_IE_ARREADY_net_0;
assign AXI4L_IE_arready           = AXI4L_IE_ARREADY_net_1;
assign AXI4L_IE_AWREADY_net_1     = AXI4L_IE_AWREADY_net_0;
assign AXI4L_IE_awready           = AXI4L_IE_AWREADY_net_1;
assign AXI4L_IE_BVALID_net_1      = AXI4L_IE_BVALID_net_0;
assign AXI4L_IE_bvalid            = AXI4L_IE_BVALID_net_1;
assign AXI4L_IE_RVALID_net_1      = AXI4L_IE_RVALID_net_0;
assign AXI4L_IE_rvalid            = AXI4L_IE_RVALID_net_1;
assign AXI4L_IE_WREADY_net_1      = AXI4L_IE_WREADY_net_0;
assign AXI4L_IE_wready            = AXI4L_IE_WREADY_net_1;
assign AXI4L_OSD_ARREADY_net_1    = AXI4L_OSD_ARREADY_net_0;
assign AXI4L_OSD_arready          = AXI4L_OSD_ARREADY_net_1;
assign AXI4L_OSD_AWREADY_net_1    = AXI4L_OSD_AWREADY_net_0;
assign AXI4L_OSD_awready          = AXI4L_OSD_AWREADY_net_1;
assign AXI4L_OSD_BVALID_net_1     = AXI4L_OSD_BVALID_net_0;
assign AXI4L_OSD_bvalid           = AXI4L_OSD_BVALID_net_1;
assign AXI4L_OSD_RVALID_net_1     = AXI4L_OSD_RVALID_net_0;
assign AXI4L_OSD_rvalid           = AXI4L_OSD_RVALID_net_1;
assign AXI4L_OSD_WREADY_net_1     = AXI4L_OSD_WREADY_net_0;
assign AXI4L_OSD_wready           = AXI4L_OSD_WREADY_net_1;
assign AXI4L_SCALER_ARREADY_net_1 = AXI4L_SCALER_ARREADY_net_0;
assign AXI4L_SCALER_arready       = AXI4L_SCALER_ARREADY_net_1;
assign AXI4L_SCALER_AWREADY_net_1 = AXI4L_SCALER_AWREADY_net_0;
assign AXI4L_SCALER_awready       = AXI4L_SCALER_AWREADY_net_1;
assign AXI4L_SCALER_BVALID_net_1  = AXI4L_SCALER_BVALID_net_0;
assign AXI4L_SCALER_bvalid        = AXI4L_SCALER_BVALID_net_1;
assign AXI4L_SCALER_RVALID_net_1  = AXI4L_SCALER_RVALID_net_0;
assign AXI4L_SCALER_rvalid        = AXI4L_SCALER_RVALID_net_1;
assign AXI4L_SCALER_WREADY_net_1  = AXI4L_SCALER_WREADY_net_0;
assign AXI4L_SCALER_wready        = AXI4L_SCALER_WREADY_net_1;
assign DATA_VALID_O_net_1         = DATA_VALID_O_net_0;
assign DATA_VALID_O               = DATA_VALID_O_net_1;
assign FRAME_START_O_net_1        = FRAME_START_O_net_0;
assign FRAME_START_O              = FRAME_START_O_net_1;
assign AXI4L_H264_BRESP_net_1     = AXI4L_H264_BRESP_net_0;
assign AXI4L_H264_bresp[1:0]      = AXI4L_H264_BRESP_net_1;
assign AXI4L_H264_RDATA_net_1     = AXI4L_H264_RDATA_net_0;
assign AXI4L_H264_rdata[31:0]     = AXI4L_H264_RDATA_net_1;
assign AXI4L_H264_RRESP_net_1     = AXI4L_H264_RRESP_net_0;
assign AXI4L_H264_rresp[1:0]      = AXI4L_H264_RRESP_net_1;
assign AXI4L_IE_BRESP_net_1       = AXI4L_IE_BRESP_net_0;
assign AXI4L_IE_bresp[1:0]        = AXI4L_IE_BRESP_net_1;
assign AXI4L_IE_RDATA_net_1       = AXI4L_IE_RDATA_net_0;
assign AXI4L_IE_rdata[31:0]       = AXI4L_IE_RDATA_net_1;
assign AXI4L_IE_RRESP_net_1       = AXI4L_IE_RRESP_net_0;
assign AXI4L_IE_rresp[1:0]        = AXI4L_IE_RRESP_net_1;
assign AXI4L_OSD_BRESP_net_1      = AXI4L_OSD_BRESP_net_0;
assign AXI4L_OSD_bresp[1:0]       = AXI4L_OSD_BRESP_net_1;
assign AXI4L_OSD_RDATA_net_1      = AXI4L_OSD_RDATA_net_0;
assign AXI4L_OSD_rdata[31:0]      = AXI4L_OSD_RDATA_net_1;
assign AXI4L_OSD_RRESP_net_1      = AXI4L_OSD_RRESP_net_0;
assign AXI4L_OSD_rresp[1:0]       = AXI4L_OSD_RRESP_net_1;
assign AXI4L_SCALER_BRESP_net_1   = AXI4L_SCALER_BRESP_net_0;
assign AXI4L_SCALER_bresp[1:0]    = AXI4L_SCALER_BRESP_net_1;
assign AXI4L_SCALER_RDATA_net_1   = AXI4L_SCALER_RDATA_net_0;
assign AXI4L_SCALER_rdata[31:0]   = AXI4L_SCALER_RDATA_net_1;
assign AXI4L_SCALER_RRESP_net_1   = AXI4L_SCALER_RRESP_net_0;
assign AXI4L_SCALER_rresp[1:0]    = AXI4L_SCALER_RRESP_net_1;
assign DATA_O_net_1               = DATA_O_net_0;
assign DATA_O[15:0]               = DATA_O_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------Bayer_Interpolation_C0
Bayer_Interpolation_C0 Bayer_Interpolation_C0_0(
        // Inputs
        .RESETN_I     ( RESETN_I ),
        .SYS_CLK_I    ( SYS_CLK_I ),
        .DATA_VALID_I ( DATA_VALID_I ),
        .DATA_I       ( DATA_I ),
        .EOF_I        ( FRAME_START_I ),
        .BAYER_FORMAT ( BAYER_FORMAT_const_net_0 ),
        // Outputs
        .RGB_VALID_O  ( Bayer_Interpolation_C0_0_RGB_VALID_O ),
        .R_O          ( Bayer_Interpolation_C0_0_R_O ),
        .G_O          ( Bayer_Interpolation_C0_0_G_O ),
        .B_O          ( Bayer_Interpolation_C0_0_B_O ),
        .EOF_O        (  ) 
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

//--------H264_Iframe_Encoder_C0
H264_Iframe_Encoder_C0 H264_Iframe_Encoder_C0_0(
        // Inputs
        .RESETN_I      ( RESETN_I ),
        .PIX_CLK_I     ( SYS_CLK_I ),
        .FRAME_START_I ( FRAME_START_I ),
        .DATA_VALID_I  ( RGBtoYCbCr_C0_0_DATA_VALID_O ),
        .DATA_Y_I      ( RGBtoYCbCr_C0_0_Y_OUT ),
        .DATA_C_I      ( RGBtoYCbCr_C0_0_C_OUT ),
        .ACLK_I        ( ACLK_I ),
        .ARESETN_I     ( ARESETN_I ),
        .awaddr        ( AXI4L_H264_awaddr ),
        .awvalid       ( AXI4L_H264_awvalid ),
        .wdata         ( AXI4L_H264_wdata ),
        .wvalid        ( AXI4L_H264_wvalid ),
        .bready        ( AXI4L_H264_bready ),
        .araddr        ( AXI4L_H264_araddr ),
        .arvalid       ( AXI4L_H264_arvalid ),
        .rready        ( AXI4L_H264_rready ),
        // Outputs
        .FRAME_START_O ( FRAME_START_O_net_0 ),
        .DATA_VALID_O  ( DATA_VALID_O_net_0 ),
        .DATA_O        ( DATA_O_net_0 ),
        .awready       ( AXI4L_H264_AWREADY_net_0 ),
        .wready        ( AXI4L_H264_WREADY_net_0 ),
        .bresp         ( AXI4L_H264_BRESP_net_0 ),
        .bvalid        ( AXI4L_H264_BVALID_net_0 ),
        .arready       ( AXI4L_H264_ARREADY_net_0 ),
        .rdata         ( AXI4L_H264_RDATA_net_0 ),
        .rresp         ( AXI4L_H264_RRESP_net_0 ),
        .rvalid        ( AXI4L_H264_RVALID_net_0 ) 
        );

//--------Image_Enhancement_C0
Image_Enhancement_C0 Image_Enhancement_C0_0(
        // Inputs
        .RESETN_I      ( RESETN_I ),
        .SYS_CLK_I     ( SYS_CLK_I ),
        .FRAME_START_I ( FRAME_START_I ),
        .DATA_VALID_I  ( Gamma_Correction_C0_0_DATA_VALID_O ),
        .R_I           ( Gamma_Correction_C0_0_RED_O ),
        .G_I           ( Gamma_Correction_C0_0_GREEN_O ),
        .B_I           ( Gamma_Correction_C0_0_BLUE_O ),
        .ACLK_I        ( ACLK_I ),
        .ARESETN_I     ( ARESETN_I ),
        .awaddr        ( AXI4L_IE_awaddr ),
        .awvalid       ( AXI4L_IE_awvalid ),
        .wdata         ( AXI4L_IE_wdata ),
        .wvalid        ( AXI4L_IE_wvalid ),
        .bready        ( AXI4L_IE_bready ),
        .araddr        ( AXI4L_IE_araddr ),
        .arvalid       ( AXI4L_IE_arvalid ),
        .rready        ( AXI4L_IE_rready ),
        // Outputs
        .Y_AVG_O       (  ),
        .DATA_VALID_O  ( Image_Enhancement_C0_0_DATA_VALID_O ),
        .R_O           ( Image_Enhancement_C0_0_R_O ),
        .G_O           ( Image_Enhancement_C0_0_G_O ),
        .B_O           ( Image_Enhancement_C0_0_B_O ),
        .awready       ( AXI4L_IE_AWREADY_net_0 ),
        .wready        ( AXI4L_IE_WREADY_net_0 ),
        .bresp         ( AXI4L_IE_BRESP_net_0 ),
        .bvalid        ( AXI4L_IE_BVALID_net_0 ),
        .arready       ( AXI4L_IE_ARREADY_net_0 ),
        .rdata         ( AXI4L_IE_RDATA_net_0 ),
        .rresp         ( AXI4L_IE_RRESP_net_0 ),
        .rvalid        ( AXI4L_IE_RVALID_net_0 ) 
        );

//--------IMAGE_SCALER_C0
IMAGE_SCALER_C0 Image_Scaler_top_0(
        // Inputs
        .RESETN_I        ( RESETN_I ),
        .IN_VIDEO_CLK_I  ( SYS_CLK_I ),
        .OUT_VIDEO_CLK_I ( SYS_CLK_I ),
        .FRAME_START_I   ( FRAME_START_I ),
        .DATA_VALID_I    ( Image_Enhancement_C0_0_DATA_VALID_O ),
        .DATA_R_I        ( Image_Enhancement_C0_0_R_O ),
        .DATA_G_I        ( Image_Enhancement_C0_0_G_O ),
        .DATA_B_I        ( Image_Enhancement_C0_0_B_O ),
        .ACLK_I          ( ACLK_I ),
        .ARESETN_I       ( ARESETN_I ),
        .awaddr          ( AXI4L_SCALER_awaddr ),
        .awvalid         ( AXI4L_SCALER_awvalid ),
        .wdata           ( AXI4L_SCALER_wdata ),
        .wvalid          ( AXI4L_SCALER_wvalid ),
        .bready          ( AXI4L_SCALER_bready ),
        .araddr          ( AXI4L_SCALER_araddr ),
        .arvalid         ( AXI4L_SCALER_arvalid ),
        .rready          ( AXI4L_SCALER_rready ),
        // Outputs
        .DATA_VALID_O    ( Image_Scaler_top_0_DATA_VALID_O ),
        .DATA_R_O        ( Image_Scaler_top_0_DATA_R_O ),
        .DATA_G_O        ( Image_Scaler_top_0_DATA_G_O ),
        .DATA_B_O        ( Image_Scaler_top_0_DATA_B_O ),
        .awready         ( AXI4L_SCALER_AWREADY_net_0 ),
        .wready          ( AXI4L_SCALER_WREADY_net_0 ),
        .bresp           ( AXI4L_SCALER_BRESP_net_0 ),
        .bvalid          ( AXI4L_SCALER_BVALID_net_0 ),
        .arready         ( AXI4L_SCALER_ARREADY_net_0 ),
        .rdata           ( AXI4L_SCALER_RDATA_net_0 ),
        .rresp           ( AXI4L_SCALER_RRESP_net_0 ),
        .rvalid          ( AXI4L_SCALER_RVALID_net_0 ) 
        );

//--------CR_OSD
CR_OSD osd_top_0(
        // Inputs
        .aclk         ( ACLK_I ),
        .aresetn      ( ARESETN_I ),
        .awvalid      ( AXI4L_OSD_awvalid ),
        .awaddr       ( AXI4L_OSD_awaddr ),
        .wdata        ( AXI4L_OSD_wdata ),
        .wvalid       ( AXI4L_OSD_wvalid ),
        .bready       ( AXI4L_OSD_bready ),
        .araddr       ( AXI4L_OSD_araddr ),
        .arvalid      ( AXI4L_OSD_arvalid ),
        .rready       ( AXI4L_OSD_rready ),
        .DATA_VALID_I ( Image_Scaler_top_0_DATA_VALID_O ),
        .FRAME_END_I  ( FRAME_START_I ),
        .RESETN_I     ( RESETN_I ),
        .SYS_CLK_I    ( SYS_CLK_I ),
        .r_i          ( Image_Scaler_top_0_DATA_R_O ),
        .g_i          ( Image_Scaler_top_0_DATA_G_O ),
        .b_i          ( Image_Scaler_top_0_DATA_B_O ),
        // Outputs
        .awready      ( AXI4L_OSD_AWREADY_net_0 ),
        .wready       ( AXI4L_OSD_WREADY_net_0 ),
        .bresp        ( AXI4L_OSD_BRESP_net_0 ),
        .bvalid       ( AXI4L_OSD_BVALID_net_0 ),
        .arready      ( AXI4L_OSD_ARREADY_net_0 ),
        .rdata        ( AXI4L_OSD_RDATA_net_0 ),
        .rresp        ( AXI4L_OSD_RRESP_net_0 ),
        .rvalid       ( AXI4L_OSD_RVALID_net_0 ),
        .data_valid_o ( osd_top_0_data_valid_o ),
        .r_o          ( osd_top_0_r_o ),
        .g_o          ( osd_top_0_g_o ),
        .b_o          ( osd_top_0_b_o ) 
        );

//--------RGBtoYCbCr_C0
RGBtoYCbCr_C0 RGBtoYCbCr_C0_0(
        // Inputs
        .RESET_N_I    ( RESETN_I ),
        .CLOCK_I      ( SYS_CLK_I ),
        .DATA_VALID_I ( osd_top_0_data_valid_o ),
        .RED_I        ( osd_top_0_r_o ),
        .GREEN_I      ( osd_top_0_g_o ),
        .BLUE_I       ( osd_top_0_b_o ),
        // Outputs
        .DATA_VALID_O ( RGBtoYCbCr_C0_0_DATA_VALID_O ),
        .Y_OUT        ( RGBtoYCbCr_C0_0_Y_OUT ),
        .C_OUT        ( RGBtoYCbCr_C0_0_C_OUT ) 
        );


endmodule
