//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Apr 28 14:51:34 2024
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
create_and_configure_core -core_vlnv {Microchip:SolutionCore:H264_Iframe_Encoder:1.5.0} -component_name {H264_Iframe_Encoder_C0} -params {\
"G_16x16_INTRA_PRED:1"  \
"G_C_TYPE:1"  \
"G_DW:8"  \
"G_HRES:1920"  \
"G_QFACTOR:30"  \
"G_VRES:1072"   }
# Exporting Component Description of H264_Iframe_Encoder_C0 to TCL done
*/

// H264_Iframe_Encoder_C0
module H264_Iframe_Encoder_C0(
    // Inputs
    ACLK_I,
    ARESETN_I,
    DATA_C_I,
    DATA_VALID_I,
    DATA_Y_I,
    FRAME_START_I,
    PIX_CLK_I,
    RESETN_I,
    araddr,
    arvalid,
    awaddr,
    awvalid,
    bready,
    rready,
    wdata,
    wvalid,
    // Outputs
    DATA_O,
    DATA_VALID_O,
    FRAME_START_O,
    arready,
    awready,
    bresp,
    bvalid,
    rdata,
    rresp,
    rvalid,
    wready
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         ACLK_I;
input         ARESETN_I;
input  [7:0]  DATA_C_I;
input         DATA_VALID_I;
input  [7:0]  DATA_Y_I;
input         FRAME_START_I;
input         PIX_CLK_I;
input         RESETN_I;
input  [31:0] araddr;
input         arvalid;
input  [31:0] awaddr;
input         awvalid;
input         bready;
input         rready;
input  [31:0] wdata;
input         wvalid;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [15:0] DATA_O;
output        DATA_VALID_O;
output        FRAME_START_O;
output        arready;
output        awready;
output [1:0]  bresp;
output        bvalid;
output [31:0] rdata;
output [1:0]  rresp;
output        rvalid;
output        wready;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          ACLK_I;
wire          ARESETN_I;
wire   [31:0] araddr;
wire          AXI4L_H264_ARREADY;
wire          arvalid;
wire   [31:0] awaddr;
wire          AXI4L_H264_AWREADY;
wire          awvalid;
wire          bready;
wire   [1:0]  AXI4L_H264_BRESP;
wire          AXI4L_H264_BVALID;
wire   [31:0] AXI4L_H264_RDATA;
wire          rready;
wire   [1:0]  AXI4L_H264_RRESP;
wire          AXI4L_H264_RVALID;
wire   [31:0] wdata;
wire          AXI4L_H264_WREADY;
wire          wvalid;
wire   [7:0]  DATA_C_I;
wire   [15:0] DATA_O_net_0;
wire          DATA_VALID_I;
wire          DATA_VALID_O_net_0;
wire   [7:0]  DATA_Y_I;
wire          FRAME_START_I;
wire          FRAME_START_O_net_0;
wire          PIX_CLK_I;
wire          RESETN_I;
wire          FRAME_START_O_net_1;
wire          DATA_VALID_O_net_1;
wire   [15:0] DATA_O_net_1;
wire          AXI4L_H264_AWREADY_net_0;
wire          AXI4L_H264_WREADY_net_0;
wire   [1:0]  AXI4L_H264_BRESP_net_0;
wire          AXI4L_H264_BVALID_net_0;
wire          AXI4L_H264_ARREADY_net_0;
wire   [31:0] AXI4L_H264_RDATA_net_0;
wire   [1:0]  AXI4L_H264_RRESP_net_0;
wire          AXI4L_H264_RVALID_net_0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign FRAME_START_O_net_1      = FRAME_START_O_net_0;
assign FRAME_START_O            = FRAME_START_O_net_1;
assign DATA_VALID_O_net_1       = DATA_VALID_O_net_0;
assign DATA_VALID_O             = DATA_VALID_O_net_1;
assign DATA_O_net_1             = DATA_O_net_0;
assign DATA_O[15:0]             = DATA_O_net_1;
assign AXI4L_H264_AWREADY_net_0 = AXI4L_H264_AWREADY;
assign awready                  = AXI4L_H264_AWREADY_net_0;
assign AXI4L_H264_WREADY_net_0  = AXI4L_H264_WREADY;
assign wready                   = AXI4L_H264_WREADY_net_0;
assign AXI4L_H264_BRESP_net_0   = AXI4L_H264_BRESP;
assign bresp[1:0]               = AXI4L_H264_BRESP_net_0;
assign AXI4L_H264_BVALID_net_0  = AXI4L_H264_BVALID;
assign bvalid                   = AXI4L_H264_BVALID_net_0;
assign AXI4L_H264_ARREADY_net_0 = AXI4L_H264_ARREADY;
assign arready                  = AXI4L_H264_ARREADY_net_0;
assign AXI4L_H264_RDATA_net_0   = AXI4L_H264_RDATA;
assign rdata[31:0]              = AXI4L_H264_RDATA_net_0;
assign AXI4L_H264_RRESP_net_0   = AXI4L_H264_RRESP;
assign rresp[1:0]               = AXI4L_H264_RRESP_net_0;
assign AXI4L_H264_RVALID_net_0  = AXI4L_H264_RVALID;
assign rvalid                   = AXI4L_H264_RVALID_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------H264_Iframe_Encoder   -   Microchip:SolutionCore:H264_Iframe_Encoder:1.5.0
H264_Iframe_Encoder #( 
        .G_16x16_INTRA_PRED ( 1 ),
        .G_C_TYPE           ( 1 ),
        .G_DW               ( 8 ),
        .G_HRES             ( 1920 ),
        .G_QFACTOR          ( 30 ),
        .G_VRES             ( 1072 ) )
H264_Iframe_Encoder_C0_0(
        // Inputs
        .RESETN_I      ( RESETN_I ),
        .PIX_CLK_I     ( PIX_CLK_I ),
        .FRAME_START_I ( FRAME_START_I ),
        .DATA_VALID_I  ( DATA_VALID_I ),
        .DATA_Y_I      ( DATA_Y_I ),
        .DATA_C_I      ( DATA_C_I ),
        .ACLK_I        ( ACLK_I ),
        .ARESETN_I     ( ARESETN_I ),
        .awvalid       ( awvalid ),
        .awaddr        ( awaddr ),
        .wdata         ( wdata ),
        .wvalid        ( wvalid ),
        .bready        ( bready ),
        .araddr        ( araddr ),
        .arvalid       ( arvalid ),
        .rready        ( rready ),
        // Outputs
        .awready       ( AXI4L_H264_AWREADY ),
        .wready        ( AXI4L_H264_WREADY ),
        .bresp         ( AXI4L_H264_BRESP ),
        .bvalid        ( AXI4L_H264_BVALID ),
        .arready       ( AXI4L_H264_ARREADY ),
        .rdata         ( AXI4L_H264_RDATA ),
        .rresp         ( AXI4L_H264_RRESP ),
        .rvalid        ( AXI4L_H264_RVALID ),
        .FRAME_START_O ( FRAME_START_O_net_0 ),
        .DATA_VALID_O  ( DATA_VALID_O_net_0 ),
        .DATA_O        ( DATA_O_net_0 ) 
        );


endmodule
