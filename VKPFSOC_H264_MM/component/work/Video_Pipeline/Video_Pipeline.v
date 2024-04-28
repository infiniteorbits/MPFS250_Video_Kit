//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Apr 28 14:52:13 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// Video_Pipeline
module Video_Pipeline(
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
    AXI4L_MIPI_araddr,
    AXI4L_MIPI_arvalid,
    AXI4L_MIPI_awaddr,
    AXI4L_MIPI_awvalid,
    AXI4L_MIPI_bready,
    AXI4L_MIPI_rready,
    AXI4L_MIPI_wdata,
    AXI4L_MIPI_wvalid,
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
    AXI4L_VDMA_araddr,
    AXI4L_VDMA_arvalid,
    AXI4L_VDMA_awaddr,
    AXI4L_VDMA_awvalid,
    AXI4L_VDMA_bready,
    AXI4L_VDMA_rready,
    AXI4L_VDMA_wdata,
    AXI4L_VDMA_wvalid,
    CAM1_RXD,
    CAM1_RXD_N,
    CAM1_RX_CLK_N,
    CAM1_RX_CLK_P,
    CLK_125MHz_i,
    INIT_DONE,
    LPDDR4_RDY_i,
    RESETN_125MHz_i,
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
    AXI4L_MIPI_arready,
    AXI4L_MIPI_awready,
    AXI4L_MIPI_bresp,
    AXI4L_MIPI_bvalid,
    AXI4L_MIPI_rdata,
    AXI4L_MIPI_rresp,
    AXI4L_MIPI_rvalid,
    AXI4L_MIPI_wready,
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
    AXI4L_VDMA_arready,
    AXI4L_VDMA_awready,
    AXI4L_VDMA_bresp,
    AXI4L_VDMA_bvalid,
    AXI4L_VDMA_rdata,
    AXI4L_VDMA_rresp,
    AXI4L_VDMA_rvalid,
    AXI4L_VDMA_wready,
    INT_DMA_O,
    MIPI_INTERRUPT_O,
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
input  [31:0] AXI4L_MIPI_araddr;
input         AXI4L_MIPI_arvalid;
input  [31:0] AXI4L_MIPI_awaddr;
input         AXI4L_MIPI_awvalid;
input         AXI4L_MIPI_bready;
input         AXI4L_MIPI_rready;
input  [31:0] AXI4L_MIPI_wdata;
input         AXI4L_MIPI_wvalid;
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
input  [31:0] AXI4L_VDMA_araddr;
input         AXI4L_VDMA_arvalid;
input  [31:0] AXI4L_VDMA_awaddr;
input         AXI4L_VDMA_awvalid;
input         AXI4L_VDMA_bready;
input         AXI4L_VDMA_rready;
input  [31:0] AXI4L_VDMA_wdata;
input         AXI4L_VDMA_wvalid;
input  [3:0]  CAM1_RXD;
input  [3:0]  CAM1_RXD_N;
input         CAM1_RX_CLK_N;
input         CAM1_RX_CLK_P;
input         CLK_125MHz_i;
input         INIT_DONE;
input         LPDDR4_RDY_i;
input         RESETN_125MHz_i;
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
output        AXI4L_MIPI_arready;
output        AXI4L_MIPI_awready;
output [1:0]  AXI4L_MIPI_bresp;
output        AXI4L_MIPI_bvalid;
output [31:0] AXI4L_MIPI_rdata;
output [1:0]  AXI4L_MIPI_rresp;
output        AXI4L_MIPI_rvalid;
output        AXI4L_MIPI_wready;
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
output        AXI4L_VDMA_arready;
output        AXI4L_VDMA_awready;
output [1:0]  AXI4L_VDMA_bresp;
output        AXI4L_VDMA_bvalid;
output [31:0] AXI4L_VDMA_rdata;
output [1:0]  AXI4L_VDMA_rresp;
output        AXI4L_VDMA_rvalid;
output        AXI4L_VDMA_wready;
output        INT_DMA_O;
output        MIPI_INTERRUPT_O;
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
wire   [31:0] AXI4L_MIPI_araddr;
wire          AXI4L_MIPI_ARREADY_net_0;
wire          AXI4L_MIPI_arvalid;
wire   [31:0] AXI4L_MIPI_awaddr;
wire          AXI4L_MIPI_AWREADY_net_0;
wire          AXI4L_MIPI_awvalid;
wire          AXI4L_MIPI_bready;
wire   [1:0]  AXI4L_MIPI_BRESP_net_0;
wire          AXI4L_MIPI_BVALID_net_0;
wire   [31:0] AXI4L_MIPI_RDATA_net_0;
wire          AXI4L_MIPI_rready;
wire   [1:0]  AXI4L_MIPI_RRESP_net_0;
wire          AXI4L_MIPI_RVALID_net_0;
wire   [31:0] AXI4L_MIPI_wdata;
wire          AXI4L_MIPI_WREADY_net_0;
wire          AXI4L_MIPI_wvalid;
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
wire          CAM1_RX_CLK_N;
wire          CAM1_RX_CLK_P;
wire   [3:0]  CAM1_RXD;
wire   [3:0]  CAM1_RXD_N;
wire          CLK_125MHz_i;
wire   [7:0]  IMX334_IF_TOP_0_c1_data_out_o;
wire          IMX334_IF_TOP_0_c1_frame_start_o;
wire          IMX334_IF_TOP_0_c1_line_valid_o;
wire          IMX334_IF_TOP_0_PARALLEL_CLK;
wire          IMX334_IF_TOP_0_PARALLEL_CLK_RESET_N;
wire          INIT_DONE;
wire          INT_DMA_O_net_0;
wire          LPDDR4_RDY_i;
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
wire          MIPI_INTERRUPT_O_net_0;
wire          RESETN_125MHz_i;
wire   [15:0] video_processing_0_DATA_O;
wire          video_processing_0_DATA_VALID_O;
wire          video_processing_0_FRAME_START_O;
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
wire          AXI4L_MIPI_ARREADY_net_1;
wire          AXI4L_MIPI_AWREADY_net_1;
wire          AXI4L_MIPI_BVALID_net_1;
wire          AXI4L_MIPI_RVALID_net_1;
wire          AXI4L_MIPI_WREADY_net_1;
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
wire          AXI4L_VDMA_ARREADY_net_1;
wire          AXI4L_VDMA_AWREADY_net_1;
wire          AXI4L_VDMA_BVALID_net_1;
wire          AXI4L_VDMA_RVALID_net_1;
wire          AXI4L_VDMA_WREADY_net_1;
wire          INT_DMA_O_net_1;
wire          MIPI_INTERRUPT_O_net_1;
wire          mAXI4_SLAVE_ARVALID_net_1;
wire          mAXI4_SLAVE_AWVALID_net_1;
wire          mAXI4_SLAVE_BREADY_net_1;
wire          mAXI4_SLAVE_RREADY_net_1;
wire          mAXI4_SLAVE_WLAST_net_1;
wire          mAXI4_SLAVE_WVALID_net_1;
wire   [1:0]  AXI4L_H264_BRESP_net_1;
wire   [31:0] AXI4L_H264_RDATA_net_1;
wire   [1:0]  AXI4L_H264_RRESP_net_1;
wire   [1:0]  AXI4L_IE_BRESP_net_1;
wire   [31:0] AXI4L_IE_RDATA_net_1;
wire   [1:0]  AXI4L_IE_RRESP_net_1;
wire   [1:0]  AXI4L_MIPI_BRESP_net_1;
wire   [31:0] AXI4L_MIPI_RDATA_net_1;
wire   [1:0]  AXI4L_MIPI_RRESP_net_1;
wire   [1:0]  AXI4L_OSD_BRESP_net_1;
wire   [31:0] AXI4L_OSD_RDATA_net_1;
wire   [1:0]  AXI4L_OSD_RRESP_net_1;
wire   [1:0]  AXI4L_SCALER_BRESP_net_1;
wire   [31:0] AXI4L_SCALER_RDATA_net_1;
wire   [1:0]  AXI4L_SCALER_RRESP_net_1;
wire   [1:0]  AXI4L_VDMA_BRESP_net_1;
wire   [31:0] AXI4L_VDMA_RDATA_net_1;
wire   [1:0]  AXI4L_VDMA_RRESP_net_1;
wire   [37:0] mAXI4_SLAVE_ARADDR_net_1;
wire   [1:0]  mAXI4_SLAVE_ARBURST_net_1;
wire   [3:0]  mAXI4_SLAVE_ARCACHE_net_1;
wire   [3:0]  mAXI4_SLAVE_ARID_net_1;
wire   [7:0]  mAXI4_SLAVE_ARLEN_net_1;
wire   [1:0]  mAXI4_SLAVE_ARLOCK_net_1;
wire   [2:0]  mAXI4_SLAVE_ARPROT_net_1;
wire   [2:0]  mAXI4_SLAVE_ARSIZE_net_1;
wire   [37:0] mAXI4_SLAVE_AWADDR_net_1;
wire   [1:0]  mAXI4_SLAVE_AWBURST_net_1;
wire   [3:0]  mAXI4_SLAVE_AWCACHE_net_1;
wire   [3:0]  mAXI4_SLAVE_AWID_net_1;
wire   [7:0]  mAXI4_SLAVE_AWLEN_net_1;
wire   [1:0]  mAXI4_SLAVE_AWLOCK_net_1;
wire   [2:0]  mAXI4_SLAVE_AWPROT_net_1;
wire   [2:0]  mAXI4_SLAVE_AWSIZE_net_1;
wire   [63:0] mAXI4_SLAVE_WDATA_net_1;
wire   [7:0]  mAXI4_SLAVE_WSTRB_net_1;
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
assign AXI4L_MIPI_ARREADY_net_1   = AXI4L_MIPI_ARREADY_net_0;
assign AXI4L_MIPI_arready         = AXI4L_MIPI_ARREADY_net_1;
assign AXI4L_MIPI_AWREADY_net_1   = AXI4L_MIPI_AWREADY_net_0;
assign AXI4L_MIPI_awready         = AXI4L_MIPI_AWREADY_net_1;
assign AXI4L_MIPI_BVALID_net_1    = AXI4L_MIPI_BVALID_net_0;
assign AXI4L_MIPI_bvalid          = AXI4L_MIPI_BVALID_net_1;
assign AXI4L_MIPI_RVALID_net_1    = AXI4L_MIPI_RVALID_net_0;
assign AXI4L_MIPI_rvalid          = AXI4L_MIPI_RVALID_net_1;
assign AXI4L_MIPI_WREADY_net_1    = AXI4L_MIPI_WREADY_net_0;
assign AXI4L_MIPI_wready          = AXI4L_MIPI_WREADY_net_1;
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
assign AXI4L_VDMA_ARREADY_net_1   = AXI4L_VDMA_ARREADY_net_0;
assign AXI4L_VDMA_arready         = AXI4L_VDMA_ARREADY_net_1;
assign AXI4L_VDMA_AWREADY_net_1   = AXI4L_VDMA_AWREADY_net_0;
assign AXI4L_VDMA_awready         = AXI4L_VDMA_AWREADY_net_1;
assign AXI4L_VDMA_BVALID_net_1    = AXI4L_VDMA_BVALID_net_0;
assign AXI4L_VDMA_bvalid          = AXI4L_VDMA_BVALID_net_1;
assign AXI4L_VDMA_RVALID_net_1    = AXI4L_VDMA_RVALID_net_0;
assign AXI4L_VDMA_rvalid          = AXI4L_VDMA_RVALID_net_1;
assign AXI4L_VDMA_WREADY_net_1    = AXI4L_VDMA_WREADY_net_0;
assign AXI4L_VDMA_wready          = AXI4L_VDMA_WREADY_net_1;
assign INT_DMA_O_net_1            = INT_DMA_O_net_0;
assign INT_DMA_O                  = INT_DMA_O_net_1;
assign MIPI_INTERRUPT_O_net_1     = MIPI_INTERRUPT_O_net_0;
assign MIPI_INTERRUPT_O           = MIPI_INTERRUPT_O_net_1;
assign mAXI4_SLAVE_ARVALID_net_1  = mAXI4_SLAVE_ARVALID_net_0;
assign mAXI4_SLAVE_arvalid        = mAXI4_SLAVE_ARVALID_net_1;
assign mAXI4_SLAVE_AWVALID_net_1  = mAXI4_SLAVE_AWVALID_net_0;
assign mAXI4_SLAVE_awvalid        = mAXI4_SLAVE_AWVALID_net_1;
assign mAXI4_SLAVE_BREADY_net_1   = mAXI4_SLAVE_BREADY_net_0;
assign mAXI4_SLAVE_bready         = mAXI4_SLAVE_BREADY_net_1;
assign mAXI4_SLAVE_RREADY_net_1   = mAXI4_SLAVE_RREADY_net_0;
assign mAXI4_SLAVE_rready         = mAXI4_SLAVE_RREADY_net_1;
assign mAXI4_SLAVE_WLAST_net_1    = mAXI4_SLAVE_WLAST_net_0;
assign mAXI4_SLAVE_wlast          = mAXI4_SLAVE_WLAST_net_1;
assign mAXI4_SLAVE_WVALID_net_1   = mAXI4_SLAVE_WVALID_net_0;
assign mAXI4_SLAVE_wvalid         = mAXI4_SLAVE_WVALID_net_1;
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
assign AXI4L_MIPI_BRESP_net_1     = AXI4L_MIPI_BRESP_net_0;
assign AXI4L_MIPI_bresp[1:0]      = AXI4L_MIPI_BRESP_net_1;
assign AXI4L_MIPI_RDATA_net_1     = AXI4L_MIPI_RDATA_net_0;
assign AXI4L_MIPI_rdata[31:0]     = AXI4L_MIPI_RDATA_net_1;
assign AXI4L_MIPI_RRESP_net_1     = AXI4L_MIPI_RRESP_net_0;
assign AXI4L_MIPI_rresp[1:0]      = AXI4L_MIPI_RRESP_net_1;
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
assign AXI4L_VDMA_BRESP_net_1     = AXI4L_VDMA_BRESP_net_0;
assign AXI4L_VDMA_bresp[1:0]      = AXI4L_VDMA_BRESP_net_1;
assign AXI4L_VDMA_RDATA_net_1     = AXI4L_VDMA_RDATA_net_0;
assign AXI4L_VDMA_rdata[31:0]     = AXI4L_VDMA_RDATA_net_1;
assign AXI4L_VDMA_RRESP_net_1     = AXI4L_VDMA_RRESP_net_0;
assign AXI4L_VDMA_rresp[1:0]      = AXI4L_VDMA_RRESP_net_1;
assign mAXI4_SLAVE_ARADDR_net_1   = mAXI4_SLAVE_ARADDR_net_0;
assign mAXI4_SLAVE_araddr[37:0]   = mAXI4_SLAVE_ARADDR_net_1;
assign mAXI4_SLAVE_ARBURST_net_1  = mAXI4_SLAVE_ARBURST_net_0;
assign mAXI4_SLAVE_arburst[1:0]   = mAXI4_SLAVE_ARBURST_net_1;
assign mAXI4_SLAVE_ARCACHE_net_1  = mAXI4_SLAVE_ARCACHE_net_0;
assign mAXI4_SLAVE_arcache[3:0]   = mAXI4_SLAVE_ARCACHE_net_1;
assign mAXI4_SLAVE_ARID_net_1     = mAXI4_SLAVE_ARID_net_0;
assign mAXI4_SLAVE_arid[3:0]      = mAXI4_SLAVE_ARID_net_1;
assign mAXI4_SLAVE_ARLEN_net_1    = mAXI4_SLAVE_ARLEN_net_0;
assign mAXI4_SLAVE_arlen[7:0]     = mAXI4_SLAVE_ARLEN_net_1;
assign mAXI4_SLAVE_ARLOCK_net_1   = mAXI4_SLAVE_ARLOCK_net_0;
assign mAXI4_SLAVE_arlock[1:0]    = mAXI4_SLAVE_ARLOCK_net_1;
assign mAXI4_SLAVE_ARPROT_net_1   = mAXI4_SLAVE_ARPROT_net_0;
assign mAXI4_SLAVE_arprot[2:0]    = mAXI4_SLAVE_ARPROT_net_1;
assign mAXI4_SLAVE_ARSIZE_net_1   = mAXI4_SLAVE_ARSIZE_net_0;
assign mAXI4_SLAVE_arsize[2:0]    = mAXI4_SLAVE_ARSIZE_net_1;
assign mAXI4_SLAVE_AWADDR_net_1   = mAXI4_SLAVE_AWADDR_net_0;
assign mAXI4_SLAVE_awaddr[37:0]   = mAXI4_SLAVE_AWADDR_net_1;
assign mAXI4_SLAVE_AWBURST_net_1  = mAXI4_SLAVE_AWBURST_net_0;
assign mAXI4_SLAVE_awburst[1:0]   = mAXI4_SLAVE_AWBURST_net_1;
assign mAXI4_SLAVE_AWCACHE_net_1  = mAXI4_SLAVE_AWCACHE_net_0;
assign mAXI4_SLAVE_awcache[3:0]   = mAXI4_SLAVE_AWCACHE_net_1;
assign mAXI4_SLAVE_AWID_net_1     = mAXI4_SLAVE_AWID_net_0;
assign mAXI4_SLAVE_awid[3:0]      = mAXI4_SLAVE_AWID_net_1;
assign mAXI4_SLAVE_AWLEN_net_1    = mAXI4_SLAVE_AWLEN_net_0;
assign mAXI4_SLAVE_awlen[7:0]     = mAXI4_SLAVE_AWLEN_net_1;
assign mAXI4_SLAVE_AWLOCK_net_1   = mAXI4_SLAVE_AWLOCK_net_0;
assign mAXI4_SLAVE_awlock[1:0]    = mAXI4_SLAVE_AWLOCK_net_1;
assign mAXI4_SLAVE_AWPROT_net_1   = mAXI4_SLAVE_AWPROT_net_0;
assign mAXI4_SLAVE_awprot[2:0]    = mAXI4_SLAVE_AWPROT_net_1;
assign mAXI4_SLAVE_AWSIZE_net_1   = mAXI4_SLAVE_AWSIZE_net_0;
assign mAXI4_SLAVE_awsize[2:0]    = mAXI4_SLAVE_AWSIZE_net_1;
assign mAXI4_SLAVE_WDATA_net_1    = mAXI4_SLAVE_WDATA_net_0;
assign mAXI4_SLAVE_wdata[63:0]    = mAXI4_SLAVE_WDATA_net_1;
assign mAXI4_SLAVE_WSTRB_net_1    = mAXI4_SLAVE_WSTRB_net_0;
assign mAXI4_SLAVE_wstrb[7:0]     = mAXI4_SLAVE_WSTRB_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------IMX334_IF_TOP
IMX334_IF_TOP IMX334_IF_TOP_0(
        // Inputs
        .ACLK_I               ( ACLK_I ),
        .ARESETN_I            ( ARESETN_I ),
        .ARST_N               ( INIT_DONE ),
        .AXI4L_MIPI_arvalid   ( AXI4L_MIPI_arvalid ),
        .AXI4L_MIPI_awvalid   ( AXI4L_MIPI_awvalid ),
        .AXI4L_MIPI_bready    ( AXI4L_MIPI_bready ),
        .AXI4L_MIPI_rready    ( AXI4L_MIPI_rready ),
        .AXI4L_MIPI_wvalid    ( AXI4L_MIPI_wvalid ),
        .CAM1_RX_CLK_N        ( CAM1_RX_CLK_N ),
        .CAM1_RX_CLK_P        ( CAM1_RX_CLK_P ),
        .INIT_DONE            ( INIT_DONE ),
        .TRNG_RST_N           ( LPDDR4_RDY_i ),
        .AXI4L_MIPI_araddr    ( AXI4L_MIPI_araddr ),
        .AXI4L_MIPI_awaddr    ( AXI4L_MIPI_awaddr ),
        .AXI4L_MIPI_wdata     ( AXI4L_MIPI_wdata ),
        .CAM1_RXD_N           ( CAM1_RXD_N ),
        .CAM1_RXD             ( CAM1_RXD ),
        // Outputs
        .AXI4L_MIPI_arready   ( AXI4L_MIPI_ARREADY_net_0 ),
        .AXI4L_MIPI_awready   ( AXI4L_MIPI_AWREADY_net_0 ),
        .AXI4L_MIPI_bvalid    ( AXI4L_MIPI_BVALID_net_0 ),
        .AXI4L_MIPI_rvalid    ( AXI4L_MIPI_RVALID_net_0 ),
        .AXI4L_MIPI_wready    ( AXI4L_MIPI_WREADY_net_0 ),
        .MIPI_INTERRUPT_O     ( MIPI_INTERRUPT_O_net_0 ),
        .PARALLEL_CLK_RESET_N ( IMX334_IF_TOP_0_PARALLEL_CLK_RESET_N ),
        .PARALLEL_CLK         ( IMX334_IF_TOP_0_PARALLEL_CLK ),
        .c1_frame_start_o     ( IMX334_IF_TOP_0_c1_frame_start_o ),
        .c1_line_valid_o      ( IMX334_IF_TOP_0_c1_line_valid_o ),
        .AXI4L_MIPI_bresp     ( AXI4L_MIPI_BRESP_net_0 ),
        .AXI4L_MIPI_rdata     ( AXI4L_MIPI_RDATA_net_0 ),
        .AXI4L_MIPI_rresp     ( AXI4L_MIPI_RRESP_net_0 ),
        .c1_data_out_o        ( IMX334_IF_TOP_0_c1_data_out_o ) 
        );

//--------VDMA_C0
VDMA_C0 VDMA_C0_0(
        // Inputs
        .ACLK_I              ( ACLK_I ),
        .ARESETN_I           ( ARESETN_I ),
        .DDR_CLK_RSTN_I      ( RESETN_125MHz_i ),
        .DDR_CLK_I           ( CLK_125MHz_i ),
        .VIDEO_CLK_RSTN_I    ( IMX334_IF_TOP_0_PARALLEL_CLK_RESET_N ),
        .VIDEO_CLK_I         ( IMX334_IF_TOP_0_PARALLEL_CLK ),
        .FRAME_START_I       ( video_processing_0_FRAME_START_O ),
        .DDR_CTRL_READY_I    ( LPDDR4_RDY_i ),
        .DATA_VALID_I        ( video_processing_0_DATA_VALID_O ),
        .DATA_I              ( video_processing_0_DATA_O ),
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
        .INT_DMA_O           ( INT_DMA_O_net_0 ),
        .AXI4L_VDMA_awready  ( AXI4L_VDMA_AWREADY_net_0 ),
        .AXI4L_VDMA_wready   ( AXI4L_VDMA_WREADY_net_0 ),
        .AXI4L_VDMA_bresp    ( AXI4L_VDMA_BRESP_net_0 ),
        .AXI4L_VDMA_bvalid   ( AXI4L_VDMA_BVALID_net_0 ),
        .AXI4L_VDMA_arready  ( AXI4L_VDMA_ARREADY_net_0 ),
        .AXI4L_VDMA_rdata    ( AXI4L_VDMA_RDATA_net_0 ),
        .AXI4L_VDMA_rresp    ( AXI4L_VDMA_RRESP_net_0 ),
        .AXI4L_VDMA_rvalid   ( AXI4L_VDMA_RVALID_net_0 ),
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

//--------video_processing
video_processing video_processing_0(
        // Inputs
        .ACLK_I               ( ACLK_I ),
        .ARESETN_I            ( ARESETN_I ),
        .AXI4L_H264_arvalid   ( AXI4L_H264_arvalid ),
        .AXI4L_H264_awvalid   ( AXI4L_H264_awvalid ),
        .AXI4L_H264_bready    ( AXI4L_H264_bready ),
        .AXI4L_H264_rready    ( AXI4L_H264_rready ),
        .AXI4L_H264_wvalid    ( AXI4L_H264_wvalid ),
        .AXI4L_IE_arvalid     ( AXI4L_IE_arvalid ),
        .AXI4L_IE_awvalid     ( AXI4L_IE_awvalid ),
        .AXI4L_IE_bready      ( AXI4L_IE_bready ),
        .AXI4L_IE_rready      ( AXI4L_IE_rready ),
        .AXI4L_IE_wvalid      ( AXI4L_IE_wvalid ),
        .AXI4L_OSD_arvalid    ( AXI4L_OSD_arvalid ),
        .AXI4L_OSD_awvalid    ( AXI4L_OSD_awvalid ),
        .AXI4L_OSD_bready     ( AXI4L_OSD_bready ),
        .AXI4L_OSD_rready     ( AXI4L_OSD_rready ),
        .AXI4L_OSD_wvalid     ( AXI4L_OSD_wvalid ),
        .AXI4L_SCALER_arvalid ( AXI4L_SCALER_arvalid ),
        .AXI4L_SCALER_awvalid ( AXI4L_SCALER_awvalid ),
        .AXI4L_SCALER_bready  ( AXI4L_SCALER_bready ),
        .AXI4L_SCALER_rready  ( AXI4L_SCALER_rready ),
        .AXI4L_SCALER_wvalid  ( AXI4L_SCALER_wvalid ),
        .DATA_VALID_I         ( IMX334_IF_TOP_0_c1_line_valid_o ),
        .FRAME_START_I        ( IMX334_IF_TOP_0_c1_frame_start_o ),
        .RESETN_I             ( IMX334_IF_TOP_0_PARALLEL_CLK_RESET_N ),
        .SYS_CLK_I            ( IMX334_IF_TOP_0_PARALLEL_CLK ),
        .AXI4L_H264_araddr    ( AXI4L_H264_araddr ),
        .AXI4L_H264_awaddr    ( AXI4L_H264_awaddr ),
        .AXI4L_H264_wdata     ( AXI4L_H264_wdata ),
        .AXI4L_IE_araddr      ( AXI4L_IE_araddr ),
        .AXI4L_IE_awaddr      ( AXI4L_IE_awaddr ),
        .AXI4L_IE_wdata       ( AXI4L_IE_wdata ),
        .AXI4L_OSD_araddr     ( AXI4L_OSD_araddr ),
        .AXI4L_OSD_awaddr     ( AXI4L_OSD_awaddr ),
        .AXI4L_OSD_wdata      ( AXI4L_OSD_wdata ),
        .AXI4L_SCALER_araddr  ( AXI4L_SCALER_araddr ),
        .AXI4L_SCALER_awaddr  ( AXI4L_SCALER_awaddr ),
        .AXI4L_SCALER_wdata   ( AXI4L_SCALER_wdata ),
        .DATA_I               ( IMX334_IF_TOP_0_c1_data_out_o ),
        // Outputs
        .AXI4L_H264_arready   ( AXI4L_H264_ARREADY_net_0 ),
        .AXI4L_H264_awready   ( AXI4L_H264_AWREADY_net_0 ),
        .AXI4L_H264_bvalid    ( AXI4L_H264_BVALID_net_0 ),
        .AXI4L_H264_rvalid    ( AXI4L_H264_RVALID_net_0 ),
        .AXI4L_H264_wready    ( AXI4L_H264_WREADY_net_0 ),
        .AXI4L_IE_arready     ( AXI4L_IE_ARREADY_net_0 ),
        .AXI4L_IE_awready     ( AXI4L_IE_AWREADY_net_0 ),
        .AXI4L_IE_bvalid      ( AXI4L_IE_BVALID_net_0 ),
        .AXI4L_IE_rvalid      ( AXI4L_IE_RVALID_net_0 ),
        .AXI4L_IE_wready      ( AXI4L_IE_WREADY_net_0 ),
        .AXI4L_OSD_arready    ( AXI4L_OSD_ARREADY_net_0 ),
        .AXI4L_OSD_awready    ( AXI4L_OSD_AWREADY_net_0 ),
        .AXI4L_OSD_bvalid     ( AXI4L_OSD_BVALID_net_0 ),
        .AXI4L_OSD_rvalid     ( AXI4L_OSD_RVALID_net_0 ),
        .AXI4L_OSD_wready     ( AXI4L_OSD_WREADY_net_0 ),
        .AXI4L_SCALER_arready ( AXI4L_SCALER_ARREADY_net_0 ),
        .AXI4L_SCALER_awready ( AXI4L_SCALER_AWREADY_net_0 ),
        .AXI4L_SCALER_bvalid  ( AXI4L_SCALER_BVALID_net_0 ),
        .AXI4L_SCALER_rvalid  ( AXI4L_SCALER_RVALID_net_0 ),
        .AXI4L_SCALER_wready  ( AXI4L_SCALER_WREADY_net_0 ),
        .DATA_VALID_O         ( video_processing_0_DATA_VALID_O ),
        .FRAME_START_O        ( video_processing_0_FRAME_START_O ),
        .AXI4L_H264_bresp     ( AXI4L_H264_BRESP_net_0 ),
        .AXI4L_H264_rdata     ( AXI4L_H264_RDATA_net_0 ),
        .AXI4L_H264_rresp     ( AXI4L_H264_RRESP_net_0 ),
        .AXI4L_IE_bresp       ( AXI4L_IE_BRESP_net_0 ),
        .AXI4L_IE_rdata       ( AXI4L_IE_RDATA_net_0 ),
        .AXI4L_IE_rresp       ( AXI4L_IE_RRESP_net_0 ),
        .AXI4L_OSD_bresp      ( AXI4L_OSD_BRESP_net_0 ),
        .AXI4L_OSD_rdata      ( AXI4L_OSD_RDATA_net_0 ),
        .AXI4L_OSD_rresp      ( AXI4L_OSD_RRESP_net_0 ),
        .AXI4L_SCALER_bresp   ( AXI4L_SCALER_BRESP_net_0 ),
        .AXI4L_SCALER_rdata   ( AXI4L_SCALER_RDATA_net_0 ),
        .AXI4L_SCALER_rresp   ( AXI4L_SCALER_RRESP_net_0 ),
        .DATA_O               ( video_processing_0_DATA_O ) 
        );


endmodule
