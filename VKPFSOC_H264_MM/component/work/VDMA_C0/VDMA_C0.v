//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Apr 28 14:51:40 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of VDMA_C0 to TCL
# Family: PolarFireSoC
# Part Number: MPFS250TS-1FCG1152I
# Create and Configure the core component VDMA_C0
create_and_configure_core -core_vlnv {Microchip:SolutionCore:VDMA:1.0.0} -component_name {VDMA_C0} -params {\
"g_IP_DW:16"   }
# Exporting Component Description of VDMA_C0 to TCL done
*/

// VDMA_C0
module VDMA_C0(
    // Inputs
    ACLK_I,
    ARESETN_I,
    AXI4L_VDMA_araddr,
    AXI4L_VDMA_arvalid,
    AXI4L_VDMA_awaddr,
    AXI4L_VDMA_awvalid,
    AXI4L_VDMA_bready,
    AXI4L_VDMA_rready,
    AXI4L_VDMA_wdata,
    AXI4L_VDMA_wvalid,
    DATA_I,
    DATA_VALID_I,
    DDR_CLK_I,
    DDR_CLK_RSTN_I,
    DDR_CTRL_READY_I,
    FRAME_START_I,
    VIDEO_CLK_I,
    VIDEO_CLK_RSTN_I,
    mAXI4_SLAVE_arready,
    mAXI4_SLAVE_awready,
    mAXI4_SLAVE_bid,
    mAXI4_SLAVE_bresp,
    mAXI4_SLAVE_bvalid,
    mAXI4_SLAVE_rdata,
    mAXI4_SLAVE_rid,
    mAXI4_SLAVE_rlast,
    mAXI4_SLAVE_rresp,
    mAXI4_SLAVE_rvalid,
    mAXI4_SLAVE_wready,
    // Outputs
    AXI4L_VDMA_arready,
    AXI4L_VDMA_awready,
    AXI4L_VDMA_bresp,
    AXI4L_VDMA_bvalid,
    AXI4L_VDMA_rdata,
    AXI4L_VDMA_rresp,
    AXI4L_VDMA_rvalid,
    AXI4L_VDMA_wready,
    INT_DMA_O,
    mAXI4_SLAVE_araddr,
    mAXI4_SLAVE_arburst,
    mAXI4_SLAVE_arcache,
    mAXI4_SLAVE_arid,
    mAXI4_SLAVE_arlen,
    mAXI4_SLAVE_arlock,
    mAXI4_SLAVE_arprot,
    mAXI4_SLAVE_arsize,
    mAXI4_SLAVE_arvalid,
    mAXI4_SLAVE_awaddr,
    mAXI4_SLAVE_awburst,
    mAXI4_SLAVE_awcache,
    mAXI4_SLAVE_awid,
    mAXI4_SLAVE_awlen,
    mAXI4_SLAVE_awlock,
    mAXI4_SLAVE_awprot,
    mAXI4_SLAVE_awsize,
    mAXI4_SLAVE_awvalid,
    mAXI4_SLAVE_bready,
    mAXI4_SLAVE_rready,
    mAXI4_SLAVE_wdata,
    mAXI4_SLAVE_wlast,
    mAXI4_SLAVE_wstrb,
    mAXI4_SLAVE_wvalid
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         ACLK_I;
input         ARESETN_I;
input  [31:0] AXI4L_VDMA_araddr;
input         AXI4L_VDMA_arvalid;
input  [31:0] AXI4L_VDMA_awaddr;
input         AXI4L_VDMA_awvalid;
input         AXI4L_VDMA_bready;
input         AXI4L_VDMA_rready;
input  [31:0] AXI4L_VDMA_wdata;
input         AXI4L_VDMA_wvalid;
input  [15:0] DATA_I;
input         DATA_VALID_I;
input         DDR_CLK_I;
input         DDR_CLK_RSTN_I;
input         DDR_CTRL_READY_I;
input         FRAME_START_I;
input         VIDEO_CLK_I;
input         VIDEO_CLK_RSTN_I;
input         mAXI4_SLAVE_arready;
input         mAXI4_SLAVE_awready;
input  [3:0]  mAXI4_SLAVE_bid;
input  [1:0]  mAXI4_SLAVE_bresp;
input         mAXI4_SLAVE_bvalid;
input  [63:0] mAXI4_SLAVE_rdata;
input  [3:0]  mAXI4_SLAVE_rid;
input         mAXI4_SLAVE_rlast;
input  [1:0]  mAXI4_SLAVE_rresp;
input         mAXI4_SLAVE_rvalid;
input         mAXI4_SLAVE_wready;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        AXI4L_VDMA_arready;
output        AXI4L_VDMA_awready;
output [1:0]  AXI4L_VDMA_bresp;
output        AXI4L_VDMA_bvalid;
output [31:0] AXI4L_VDMA_rdata;
output [1:0]  AXI4L_VDMA_rresp;
output        AXI4L_VDMA_rvalid;
output        AXI4L_VDMA_wready;
output        INT_DMA_O;
output [37:0] mAXI4_SLAVE_araddr;
output [1:0]  mAXI4_SLAVE_arburst;
output [3:0]  mAXI4_SLAVE_arcache;
output [3:0]  mAXI4_SLAVE_arid;
output [7:0]  mAXI4_SLAVE_arlen;
output [1:0]  mAXI4_SLAVE_arlock;
output [2:0]  mAXI4_SLAVE_arprot;
output [2:0]  mAXI4_SLAVE_arsize;
output        mAXI4_SLAVE_arvalid;
output [37:0] mAXI4_SLAVE_awaddr;
output [1:0]  mAXI4_SLAVE_awburst;
output [3:0]  mAXI4_SLAVE_awcache;
output [3:0]  mAXI4_SLAVE_awid;
output [7:0]  mAXI4_SLAVE_awlen;
output [1:0]  mAXI4_SLAVE_awlock;
output [2:0]  mAXI4_SLAVE_awprot;
output [2:0]  mAXI4_SLAVE_awsize;
output        mAXI4_SLAVE_awvalid;
output        mAXI4_SLAVE_bready;
output        mAXI4_SLAVE_rready;
output [63:0] mAXI4_SLAVE_wdata;
output        mAXI4_SLAVE_wlast;
output [7:0]  mAXI4_SLAVE_wstrb;
output        mAXI4_SLAVE_wvalid;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          ACLK_I;
wire          ARESETN_I;
wire   [31:0] AXI4L_VDMA_araddr;
wire          AXI4L_VDMA_ARREADY_net_0;
wire          AXI4L_VDMA_arvalid;
wire   [31:0] AXI4L_VDMA_awaddr;
wire          AXI4L_VDMA_AWREADY_net_0;
wire          AXI4L_VDMA_awvalid;
wire          AXI4L_VDMA_bready;
wire   [1:0]  AXI4L_VDMA_BRESP_net_0;
wire          AXI4L_VDMA_BVALID_net_0;
wire   [31:0] AXI4L_VDMA_RDATA_net_0;
wire          AXI4L_VDMA_rready;
wire   [1:0]  AXI4L_VDMA_RRESP_net_0;
wire          AXI4L_VDMA_RVALID_net_0;
wire   [31:0] AXI4L_VDMA_wdata;
wire          AXI4L_VDMA_WREADY_net_0;
wire          AXI4L_VDMA_wvalid;
wire   [15:0] DATA_I;
wire          DATA_VALID_I;
wire          DDR_CLK_I;
wire          DDR_CLK_RSTN_I;
wire          DDR_CTRL_READY_I;
wire          FRAME_START_I;
wire          INT_DMA_O_net_0;
wire   [37:0] mAXI4_SLAVE_ARADDR_net_0;
wire   [1:0]  mAXI4_SLAVE_ARBURST_net_0;
wire   [3:0]  mAXI4_SLAVE_ARCACHE_net_0;
wire   [3:0]  mAXI4_SLAVE_ARID_net_0;
wire   [7:0]  mAXI4_SLAVE_ARLEN_net_0;
wire   [1:0]  mAXI4_SLAVE_ARLOCK_net_0;
wire   [2:0]  mAXI4_SLAVE_ARPROT_net_0;
wire          mAXI4_SLAVE_arready;
wire   [2:0]  mAXI4_SLAVE_ARSIZE_net_0;
wire          mAXI4_SLAVE_ARVALID_net_0;
wire   [37:0] mAXI4_SLAVE_AWADDR_net_0;
wire   [1:0]  mAXI4_SLAVE_AWBURST_net_0;
wire   [3:0]  mAXI4_SLAVE_AWCACHE_net_0;
wire   [3:0]  mAXI4_SLAVE_AWID_net_0;
wire   [7:0]  mAXI4_SLAVE_AWLEN_net_0;
wire   [1:0]  mAXI4_SLAVE_AWLOCK_net_0;
wire   [2:0]  mAXI4_SLAVE_AWPROT_net_0;
wire          mAXI4_SLAVE_awready;
wire   [2:0]  mAXI4_SLAVE_AWSIZE_net_0;
wire          mAXI4_SLAVE_AWVALID_net_0;
wire   [3:0]  mAXI4_SLAVE_bid;
wire          mAXI4_SLAVE_BREADY_net_0;
wire   [1:0]  mAXI4_SLAVE_bresp;
wire          mAXI4_SLAVE_bvalid;
wire   [63:0] mAXI4_SLAVE_rdata;
wire   [3:0]  mAXI4_SLAVE_rid;
wire          mAXI4_SLAVE_rlast;
wire          mAXI4_SLAVE_RREADY_net_0;
wire   [1:0]  mAXI4_SLAVE_rresp;
wire          mAXI4_SLAVE_rvalid;
wire   [63:0] mAXI4_SLAVE_WDATA_net_0;
wire          mAXI4_SLAVE_WLAST_net_0;
wire          mAXI4_SLAVE_wready;
wire   [7:0]  mAXI4_SLAVE_WSTRB_net_0;
wire          mAXI4_SLAVE_WVALID_net_0;
wire          VIDEO_CLK_I;
wire          VIDEO_CLK_RSTN_I;
wire          INT_DMA_O_net_1;
wire          AXI4L_VDMA_AWREADY_net_1;
wire          AXI4L_VDMA_WREADY_net_1;
wire   [1:0]  AXI4L_VDMA_BRESP_net_1;
wire          AXI4L_VDMA_BVALID_net_1;
wire          AXI4L_VDMA_ARREADY_net_1;
wire   [31:0] AXI4L_VDMA_RDATA_net_1;
wire   [1:0]  AXI4L_VDMA_RRESP_net_1;
wire          AXI4L_VDMA_RVALID_net_1;
wire          mAXI4_SLAVE_AWVALID_net_1;
wire   [37:0] mAXI4_SLAVE_AWADDR_net_1;
wire   [2:0]  mAXI4_SLAVE_AWPROT_net_1;
wire   [63:0] mAXI4_SLAVE_WDATA_net_1;
wire   [7:0]  mAXI4_SLAVE_WSTRB_net_1;
wire          mAXI4_SLAVE_WVALID_net_1;
wire          mAXI4_SLAVE_BREADY_net_1;
wire   [37:0] mAXI4_SLAVE_ARADDR_net_1;
wire   [2:0]  mAXI4_SLAVE_ARPROT_net_1;
wire          mAXI4_SLAVE_ARVALID_net_1;
wire          mAXI4_SLAVE_RREADY_net_1;
wire   [1:0]  mAXI4_SLAVE_ARBURST_net_1;
wire   [3:0]  mAXI4_SLAVE_ARCACHE_net_1;
wire   [3:0]  mAXI4_SLAVE_ARID_net_1;
wire   [7:0]  mAXI4_SLAVE_ARLEN_net_1;
wire   [1:0]  mAXI4_SLAVE_ARLOCK_net_1;
wire   [2:0]  mAXI4_SLAVE_ARSIZE_net_1;
wire   [1:0]  mAXI4_SLAVE_AWBURST_net_1;
wire   [3:0]  mAXI4_SLAVE_AWCACHE_net_1;
wire   [3:0]  mAXI4_SLAVE_AWID_net_1;
wire   [7:0]  mAXI4_SLAVE_AWLEN_net_1;
wire   [1:0]  mAXI4_SLAVE_AWLOCK_net_1;
wire   [2:0]  mAXI4_SLAVE_AWSIZE_net_1;
wire          mAXI4_SLAVE_WLAST_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign INT_DMA_O_net_1           = INT_DMA_O_net_0;
assign INT_DMA_O                 = INT_DMA_O_net_1;
assign AXI4L_VDMA_AWREADY_net_1  = AXI4L_VDMA_AWREADY_net_0;
assign AXI4L_VDMA_awready        = AXI4L_VDMA_AWREADY_net_1;
assign AXI4L_VDMA_WREADY_net_1   = AXI4L_VDMA_WREADY_net_0;
assign AXI4L_VDMA_wready         = AXI4L_VDMA_WREADY_net_1;
assign AXI4L_VDMA_BRESP_net_1    = AXI4L_VDMA_BRESP_net_0;
assign AXI4L_VDMA_bresp[1:0]     = AXI4L_VDMA_BRESP_net_1;
assign AXI4L_VDMA_BVALID_net_1   = AXI4L_VDMA_BVALID_net_0;
assign AXI4L_VDMA_bvalid         = AXI4L_VDMA_BVALID_net_1;
assign AXI4L_VDMA_ARREADY_net_1  = AXI4L_VDMA_ARREADY_net_0;
assign AXI4L_VDMA_arready        = AXI4L_VDMA_ARREADY_net_1;
assign AXI4L_VDMA_RDATA_net_1    = AXI4L_VDMA_RDATA_net_0;
assign AXI4L_VDMA_rdata[31:0]    = AXI4L_VDMA_RDATA_net_1;
assign AXI4L_VDMA_RRESP_net_1    = AXI4L_VDMA_RRESP_net_0;
assign AXI4L_VDMA_rresp[1:0]     = AXI4L_VDMA_RRESP_net_1;
assign AXI4L_VDMA_RVALID_net_1   = AXI4L_VDMA_RVALID_net_0;
assign AXI4L_VDMA_rvalid         = AXI4L_VDMA_RVALID_net_1;
assign mAXI4_SLAVE_AWVALID_net_1 = mAXI4_SLAVE_AWVALID_net_0;
assign mAXI4_SLAVE_awvalid       = mAXI4_SLAVE_AWVALID_net_1;
assign mAXI4_SLAVE_AWADDR_net_1  = mAXI4_SLAVE_AWADDR_net_0;
assign mAXI4_SLAVE_awaddr[37:0]  = mAXI4_SLAVE_AWADDR_net_1;
assign mAXI4_SLAVE_AWPROT_net_1  = mAXI4_SLAVE_AWPROT_net_0;
assign mAXI4_SLAVE_awprot[2:0]   = mAXI4_SLAVE_AWPROT_net_1;
assign mAXI4_SLAVE_WDATA_net_1   = mAXI4_SLAVE_WDATA_net_0;
assign mAXI4_SLAVE_wdata[63:0]   = mAXI4_SLAVE_WDATA_net_1;
assign mAXI4_SLAVE_WSTRB_net_1   = mAXI4_SLAVE_WSTRB_net_0;
assign mAXI4_SLAVE_wstrb[7:0]    = mAXI4_SLAVE_WSTRB_net_1;
assign mAXI4_SLAVE_WVALID_net_1  = mAXI4_SLAVE_WVALID_net_0;
assign mAXI4_SLAVE_wvalid        = mAXI4_SLAVE_WVALID_net_1;
assign mAXI4_SLAVE_BREADY_net_1  = mAXI4_SLAVE_BREADY_net_0;
assign mAXI4_SLAVE_bready        = mAXI4_SLAVE_BREADY_net_1;
assign mAXI4_SLAVE_ARADDR_net_1  = mAXI4_SLAVE_ARADDR_net_0;
assign mAXI4_SLAVE_araddr[37:0]  = mAXI4_SLAVE_ARADDR_net_1;
assign mAXI4_SLAVE_ARPROT_net_1  = mAXI4_SLAVE_ARPROT_net_0;
assign mAXI4_SLAVE_arprot[2:0]   = mAXI4_SLAVE_ARPROT_net_1;
assign mAXI4_SLAVE_ARVALID_net_1 = mAXI4_SLAVE_ARVALID_net_0;
assign mAXI4_SLAVE_arvalid       = mAXI4_SLAVE_ARVALID_net_1;
assign mAXI4_SLAVE_RREADY_net_1  = mAXI4_SLAVE_RREADY_net_0;
assign mAXI4_SLAVE_rready        = mAXI4_SLAVE_RREADY_net_1;
assign mAXI4_SLAVE_ARBURST_net_1 = mAXI4_SLAVE_ARBURST_net_0;
assign mAXI4_SLAVE_arburst[1:0]  = mAXI4_SLAVE_ARBURST_net_1;
assign mAXI4_SLAVE_ARCACHE_net_1 = mAXI4_SLAVE_ARCACHE_net_0;
assign mAXI4_SLAVE_arcache[3:0]  = mAXI4_SLAVE_ARCACHE_net_1;
assign mAXI4_SLAVE_ARID_net_1    = mAXI4_SLAVE_ARID_net_0;
assign mAXI4_SLAVE_arid[3:0]     = mAXI4_SLAVE_ARID_net_1;
assign mAXI4_SLAVE_ARLEN_net_1   = mAXI4_SLAVE_ARLEN_net_0;
assign mAXI4_SLAVE_arlen[7:0]    = mAXI4_SLAVE_ARLEN_net_1;
assign mAXI4_SLAVE_ARLOCK_net_1  = mAXI4_SLAVE_ARLOCK_net_0;
assign mAXI4_SLAVE_arlock[1:0]   = mAXI4_SLAVE_ARLOCK_net_1;
assign mAXI4_SLAVE_ARSIZE_net_1  = mAXI4_SLAVE_ARSIZE_net_0;
assign mAXI4_SLAVE_arsize[2:0]   = mAXI4_SLAVE_ARSIZE_net_1;
assign mAXI4_SLAVE_AWBURST_net_1 = mAXI4_SLAVE_AWBURST_net_0;
assign mAXI4_SLAVE_awburst[1:0]  = mAXI4_SLAVE_AWBURST_net_1;
assign mAXI4_SLAVE_AWCACHE_net_1 = mAXI4_SLAVE_AWCACHE_net_0;
assign mAXI4_SLAVE_awcache[3:0]  = mAXI4_SLAVE_AWCACHE_net_1;
assign mAXI4_SLAVE_AWID_net_1    = mAXI4_SLAVE_AWID_net_0;
assign mAXI4_SLAVE_awid[3:0]     = mAXI4_SLAVE_AWID_net_1;
assign mAXI4_SLAVE_AWLEN_net_1   = mAXI4_SLAVE_AWLEN_net_0;
assign mAXI4_SLAVE_awlen[7:0]    = mAXI4_SLAVE_AWLEN_net_1;
assign mAXI4_SLAVE_AWLOCK_net_1  = mAXI4_SLAVE_AWLOCK_net_0;
assign mAXI4_SLAVE_awlock[1:0]   = mAXI4_SLAVE_AWLOCK_net_1;
assign mAXI4_SLAVE_AWSIZE_net_1  = mAXI4_SLAVE_AWSIZE_net_0;
assign mAXI4_SLAVE_awsize[2:0]   = mAXI4_SLAVE_AWSIZE_net_1;
assign mAXI4_SLAVE_WLAST_net_1   = mAXI4_SLAVE_WLAST_net_0;
assign mAXI4_SLAVE_wlast         = mAXI4_SLAVE_WLAST_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------VDMA   -   Microchip:SolutionCore:VDMA:1.0.0
VDMA #( 
        .g_IP_DW ( 16 ) )
VDMA_C0_0(
        // Inputs
        .ACLK_I              ( ACLK_I ),
        .ARESETN_I           ( ARESETN_I ),
        .DDR_CLK_RSTN_I      ( DDR_CLK_RSTN_I ),
        .DDR_CLK_I           ( DDR_CLK_I ),
        .VIDEO_CLK_RSTN_I    ( VIDEO_CLK_RSTN_I ),
        .VIDEO_CLK_I         ( VIDEO_CLK_I ),
        .FRAME_START_I       ( FRAME_START_I ),
        .DDR_CTRL_READY_I    ( DDR_CTRL_READY_I ),
        .DATA_VALID_I        ( DATA_VALID_I ),
        .DATA_I              ( DATA_I ),
        .AXI4L_VDMA_awaddr   ( AXI4L_VDMA_awaddr ),
        .AXI4L_VDMA_awvalid  ( AXI4L_VDMA_awvalid ),
        .AXI4L_VDMA_wdata    ( AXI4L_VDMA_wdata ),
        .AXI4L_VDMA_wvalid   ( AXI4L_VDMA_wvalid ),
        .AXI4L_VDMA_bready   ( AXI4L_VDMA_bready ),
        .AXI4L_VDMA_araddr   ( AXI4L_VDMA_araddr ),
        .AXI4L_VDMA_arvalid  ( AXI4L_VDMA_arvalid ),
        .AXI4L_VDMA_rready   ( AXI4L_VDMA_rready ),
        .mAXI4_SLAVE_awready ( mAXI4_SLAVE_awready ),
        .mAXI4_SLAVE_wready  ( mAXI4_SLAVE_wready ),
        .mAXI4_SLAVE_bresp   ( mAXI4_SLAVE_bresp ),
        .mAXI4_SLAVE_bvalid  ( mAXI4_SLAVE_bvalid ),
        .mAXI4_SLAVE_arready ( mAXI4_SLAVE_arready ),
        .mAXI4_SLAVE_rdata   ( mAXI4_SLAVE_rdata ),
        .mAXI4_SLAVE_rresp   ( mAXI4_SLAVE_rresp ),
        .mAXI4_SLAVE_rvalid  ( mAXI4_SLAVE_rvalid ),
        .mAXI4_SLAVE_bid     ( mAXI4_SLAVE_bid ),
        .mAXI4_SLAVE_rid     ( mAXI4_SLAVE_rid ),
        .mAXI4_SLAVE_rlast   ( mAXI4_SLAVE_rlast ),
        // Outputs
        .AXI4L_VDMA_awready  ( AXI4L_VDMA_AWREADY_net_0 ),
        .AXI4L_VDMA_wready   ( AXI4L_VDMA_WREADY_net_0 ),
        .AXI4L_VDMA_bresp    ( AXI4L_VDMA_BRESP_net_0 ),
        .AXI4L_VDMA_bvalid   ( AXI4L_VDMA_BVALID_net_0 ),
        .AXI4L_VDMA_arready  ( AXI4L_VDMA_ARREADY_net_0 ),
        .AXI4L_VDMA_rdata    ( AXI4L_VDMA_RDATA_net_0 ),
        .AXI4L_VDMA_rresp    ( AXI4L_VDMA_RRESP_net_0 ),
        .AXI4L_VDMA_rvalid   ( AXI4L_VDMA_RVALID_net_0 ),
        .INT_DMA_O           ( INT_DMA_O_net_0 ),
        .mAXI4_SLAVE_awvalid ( mAXI4_SLAVE_AWVALID_net_0 ),
        .mAXI4_SLAVE_awaddr  ( mAXI4_SLAVE_AWADDR_net_0 ),
        .mAXI4_SLAVE_awprot  ( mAXI4_SLAVE_AWPROT_net_0 ),
        .mAXI4_SLAVE_wdata   ( mAXI4_SLAVE_WDATA_net_0 ),
        .mAXI4_SLAVE_wstrb   ( mAXI4_SLAVE_WSTRB_net_0 ),
        .mAXI4_SLAVE_wvalid  ( mAXI4_SLAVE_WVALID_net_0 ),
        .mAXI4_SLAVE_bready  ( mAXI4_SLAVE_BREADY_net_0 ),
        .mAXI4_SLAVE_araddr  ( mAXI4_SLAVE_ARADDR_net_0 ),
        .mAXI4_SLAVE_arprot  ( mAXI4_SLAVE_ARPROT_net_0 ),
        .mAXI4_SLAVE_arvalid ( mAXI4_SLAVE_ARVALID_net_0 ),
        .mAXI4_SLAVE_rready  ( mAXI4_SLAVE_RREADY_net_0 ),
        .mAXI4_SLAVE_arburst ( mAXI4_SLAVE_ARBURST_net_0 ),
        .mAXI4_SLAVE_arcache ( mAXI4_SLAVE_ARCACHE_net_0 ),
        .mAXI4_SLAVE_arid    ( mAXI4_SLAVE_ARID_net_0 ),
        .mAXI4_SLAVE_arlen   ( mAXI4_SLAVE_ARLEN_net_0 ),
        .mAXI4_SLAVE_arlock  ( mAXI4_SLAVE_ARLOCK_net_0 ),
        .mAXI4_SLAVE_arsize  ( mAXI4_SLAVE_ARSIZE_net_0 ),
        .mAXI4_SLAVE_awburst ( mAXI4_SLAVE_AWBURST_net_0 ),
        .mAXI4_SLAVE_awcache ( mAXI4_SLAVE_AWCACHE_net_0 ),
        .mAXI4_SLAVE_awid    ( mAXI4_SLAVE_AWID_net_0 ),
        .mAXI4_SLAVE_awlen   ( mAXI4_SLAVE_AWLEN_net_0 ),
        .mAXI4_SLAVE_awlock  ( mAXI4_SLAVE_AWLOCK_net_0 ),
        .mAXI4_SLAVE_awsize  ( mAXI4_SLAVE_AWSIZE_net_0 ),
        .mAXI4_SLAVE_wlast   ( mAXI4_SLAVE_WLAST_net_0 ) 
        );


endmodule
