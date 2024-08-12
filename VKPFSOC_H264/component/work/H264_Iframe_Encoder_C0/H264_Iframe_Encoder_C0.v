//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Aug 12 21:24:55 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of H264_Iframe_Encoder_C0 to TCL
# Family: PolarFireSoC
# Part Number: MPFS250TS-1FCG1152I
# Create and Configure the core component H264_Iframe_Encoder_C0
create_and_configure_core -core_vlnv {Microchip:SolutionCore:H264_Iframe_Encoder:1.4.0} -component_name {H264_Iframe_Encoder_C0} -params {\
"G_16x16_INTRA_PRED:1"  \
"G_C_TYPE:1"  \
"G_DW:8"   }
# Exporting Component Description of H264_Iframe_Encoder_C0 to TCL done
*/

// H264_Iframe_Encoder_C0
module H264_Iframe_Encoder_C0(
    // Inputs
    DATA_C_I,
    DATA_VALID_I,
    DATA_Y_I,
    FRAME_END_I,
    FRAME_START_I,
    HRES_I,
    PIX_CLK,
    QP_I,
    RESET_N,
    VRES_I,
    // Outputs
    DATA_O,
    DATA_VALID_O
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [7:0]  DATA_C_I;
input         DATA_VALID_I;
input  [7:0]  DATA_Y_I;
input         FRAME_END_I;
input         FRAME_START_I;
input  [15:0] HRES_I;
input         PIX_CLK;
input  [5:0]  QP_I;
input         RESET_N;
input  [15:0] VRES_I;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [15:0] DATA_O;
output        DATA_VALID_O;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [7:0]  DATA_C_I;
wire   [15:0] DATA_O_net_0;
wire          DATA_VALID_I;
wire          DATA_VALID_O_net_0;
wire   [7:0]  DATA_Y_I;
wire          FRAME_END_I;
wire          FRAME_START_I;
wire   [15:0] HRES_I;
wire          PIX_CLK;
wire   [5:0]  QP_I;
wire          RESET_N;
wire   [15:0] VRES_I;
wire          DATA_VALID_O_net_1;
wire   [15:0] DATA_O_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign DATA_VALID_O_net_1 = DATA_VALID_O_net_0;
assign DATA_VALID_O       = DATA_VALID_O_net_1;
assign DATA_O_net_1       = DATA_O_net_0;
assign DATA_O[15:0]       = DATA_O_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------H264_Iframe_Encoder   -   Microchip:SolutionCore:H264_Iframe_Encoder:1.4.0
H264_Iframe_Encoder #( 
        .G_16x16_INTRA_PRED ( 1 ),
        .G_C_TYPE           ( 1 ),
        .G_DW               ( 8 ) )
H264_Iframe_Encoder_C0_0(
        // Inputs
        .RESET_N       ( RESET_N ),
        .PIX_CLK       ( PIX_CLK ),
        .VRES_I        ( VRES_I ),
        .HRES_I        ( HRES_I ),
        .QP_I          ( QP_I ),
        .FRAME_START_I ( FRAME_START_I ),
        .FRAME_END_I   ( FRAME_END_I ),
        .DATA_VALID_I  ( DATA_VALID_I ),
        .DATA_Y_I      ( DATA_Y_I ),
        .DATA_C_I      ( DATA_C_I ),
        // Outputs
        .DATA_VALID_O  ( DATA_VALID_O_net_0 ),
        .DATA_O        ( DATA_O_net_0 ) 
        );


endmodule
