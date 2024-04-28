//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Jan 11 12:12:23 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// VDMA
module VDMA #(parameter g_IP_DW = 16)
(
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
wire          DDR_AXI4_ARBITER_PF_0_w0_ack_o;
wire          DDR_AXI4_ARBITER_PF_0_w0_done_o;
wire          DDR_CLK_I;
wire          DDR_CLK_RSTN_I;
wire          DDR_CTRL_READY_I;
wire   [63:0] dma_top_0_rdata_o;
wire          dma_top_0_rdata_rdy_o;
wire   [7:0]  dma_top_0_write_length_o;
wire          dma_top_0_write_req_o;
wire   [37:0] dma_top_0_write_start_addr_o;
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
wire          mAXI4_SLAVE_AWVALID_net_1;
wire          mAXI4_SLAVE_WLAST_net_1;
wire          mAXI4_SLAVE_WVALID_net_1;
wire          mAXI4_SLAVE_BREADY_net_1;
wire          mAXI4_SLAVE_ARVALID_net_1;
wire          mAXI4_SLAVE_RREADY_net_1;
wire          AXI4L_VDMA_AWREADY_net_1;
wire          AXI4L_VDMA_WREADY_net_1;
wire          AXI4L_VDMA_BVALID_net_1;
wire          AXI4L_VDMA_ARREADY_net_1;
wire          AXI4L_VDMA_RVALID_net_1;
wire   [3:0]  mAXI4_SLAVE_AWID_net_1;
wire   [37:0] mAXI4_SLAVE_AWADDR_net_1;
wire   [7:0]  mAXI4_SLAVE_AWLEN_net_1;
wire   [2:0]  mAXI4_SLAVE_AWSIZE_net_1;
wire   [1:0]  mAXI4_SLAVE_AWBURST_net_1;
wire   [1:0]  mAXI4_SLAVE_AWLOCK_net_1;
wire   [3:0]  mAXI4_SLAVE_AWCACHE_net_1;
wire   [2:0]  mAXI4_SLAVE_AWPROT_net_1;
wire   [63:0] mAXI4_SLAVE_WDATA_net_1;
wire   [7:0]  mAXI4_SLAVE_WSTRB_net_1;
wire   [3:0]  mAXI4_SLAVE_ARID_net_1;
wire   [37:0] mAXI4_SLAVE_ARADDR_net_1;
wire   [7:0]  mAXI4_SLAVE_ARLEN_net_1;
wire   [2:0]  mAXI4_SLAVE_ARSIZE_net_1;
wire   [1:0]  mAXI4_SLAVE_ARBURST_net_1;
wire   [1:0]  mAXI4_SLAVE_ARLOCK_net_1;
wire   [3:0]  mAXI4_SLAVE_ARCACHE_net_1;
wire   [2:0]  mAXI4_SLAVE_ARPROT_net_1;
wire   [1:0]  AXI4L_VDMA_BRESP_net_1;
wire   [31:0] AXI4L_VDMA_RDATA_net_1;
wire   [1:0]  AXI4L_VDMA_RRESP_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire   [7:0]  r0_burst_size_i_const_net_0;
wire   [37:0] r0_rstart_addr_i_const_net_0;
wire   [7:0]  r1_burst_size_i_const_net_0;
wire   [37:0] r1_rstart_addr_i_const_net_0;
wire   [7:0]  r2_burst_size_i_const_net_0;
wire   [37:0] r2_rstart_addr_i_const_net_0;
wire   [7:0]  r3_burst_size_i_const_net_0;
wire   [37:0] r3_rstart_addr_i_const_net_0;
wire   [7:0]  r4_burst_size_i_const_net_0;
wire   [37:0] r4_rstart_addr_i_const_net_0;
wire   [7:0]  r5_burst_size_i_const_net_0;
wire   [37:0] r5_rstart_addr_i_const_net_0;
wire   [7:0]  r6_burst_size_i_const_net_0;
wire   [37:0] r6_rstart_addr_i_const_net_0;
wire   [7:0]  r7_burst_size_i_const_net_0;
wire   [37:0] r7_rstart_addr_i_const_net_0;
wire   [7:0]  w1_burst_size_i_const_net_0;
wire   [63:0] w1_data_i_const_net_0;
wire   [37:0] w1_wstart_addr_i_const_net_0;
wire   [7:0]  w2_burst_size_i_const_net_0;
wire   [63:0] w2_data_i_const_net_0;
wire   [37:0] w2_wstart_addr_i_const_net_0;
wire   [7:0]  w3_burst_size_i_const_net_0;
wire   [63:0] w3_data_i_const_net_0;
wire   [37:0] w3_wstart_addr_i_const_net_0;
wire   [7:0]  w4_burst_size_i_const_net_0;
wire   [63:0] w4_data_i_const_net_0;
wire   [37:0] w4_wstart_addr_i_const_net_0;
wire   [7:0]  w5_burst_size_i_const_net_0;
wire   [63:0] w5_data_i_const_net_0;
wire   [37:0] w5_wstart_addr_i_const_net_0;
wire   [7:0]  w6_burst_size_i_const_net_0;
wire   [63:0] w6_data_i_const_net_0;
wire   [37:0] w6_wstart_addr_i_const_net_0;
wire   [7:0]  w7_burst_size_i_const_net_0;
wire   [63:0] w7_data_i_const_net_0;
wire   [37:0] w7_wstart_addr_i_const_net_0;
wire   [63:0] WDATA_I_0_const_net_0;
wire   [37:0] AWADDR_I_0_const_net_0;
wire   [7:0]  AWSIZE_I_0_const_net_0;
wire   [63:0] WDATA_I_1_const_net_0;
wire   [37:0] AWADDR_I_1_const_net_0;
wire   [7:0]  AWSIZE_I_1_const_net_0;
wire   [63:0] WDATA_I_2_const_net_0;
wire   [37:0] AWADDR_I_2_const_net_0;
wire   [7:0]  AWSIZE_I_2_const_net_0;
wire   [63:0] WDATA_I_3_const_net_0;
wire   [37:0] AWADDR_I_3_const_net_0;
wire   [7:0]  AWSIZE_I_3_const_net_0;
wire   [63:0] WDATA_I_4_const_net_0;
wire   [37:0] AWADDR_I_4_const_net_0;
wire   [7:0]  AWSIZE_I_4_const_net_0;
wire   [63:0] WDATA_I_5_const_net_0;
wire   [37:0] AWADDR_I_5_const_net_0;
wire   [7:0]  AWSIZE_I_5_const_net_0;
wire   [63:0] WDATA_I_6_const_net_0;
wire   [37:0] AWADDR_I_6_const_net_0;
wire   [7:0]  AWSIZE_I_6_const_net_0;
wire   [63:0] WDATA_I_7_const_net_0;
wire   [37:0] AWADDR_I_7_const_net_0;
wire   [7:0]  AWSIZE_I_7_const_net_0;
wire   [37:0] ARADDR_I_0_const_net_0;
wire   [7:0]  ARSIZE_I_0_const_net_0;
wire   [37:0] ARADDR_I_1_const_net_0;
wire   [7:0]  ARSIZE_I_1_const_net_0;
wire   [37:0] ARADDR_I_2_const_net_0;
wire   [7:0]  ARSIZE_I_2_const_net_0;
wire   [37:0] ARADDR_I_3_const_net_0;
wire   [7:0]  ARSIZE_I_3_const_net_0;
wire   [37:0] ARADDR_I_4_const_net_0;
wire   [7:0]  ARSIZE_I_4_const_net_0;
wire   [37:0] ARADDR_I_5_const_net_0;
wire   [7:0]  ARSIZE_I_5_const_net_0;
wire   [37:0] ARADDR_I_6_const_net_0;
wire   [7:0]  ARSIZE_I_6_const_net_0;
wire   [37:0] ARADDR_I_7_const_net_0;
wire   [7:0]  ARSIZE_I_7_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net                      = 1'b0;
assign r0_burst_size_i_const_net_0  = 8'h00;
assign r0_rstart_addr_i_const_net_0 = 38'h0000000000;
assign r1_burst_size_i_const_net_0  = 8'h00;
assign r1_rstart_addr_i_const_net_0 = 38'h0000000000;
assign r2_burst_size_i_const_net_0  = 8'h00;
assign r2_rstart_addr_i_const_net_0 = 38'h0000000000;
assign r3_burst_size_i_const_net_0  = 8'h00;
assign r3_rstart_addr_i_const_net_0 = 38'h0000000000;
assign r4_burst_size_i_const_net_0  = 8'h00;
assign r4_rstart_addr_i_const_net_0 = 38'h0000000000;
assign r5_burst_size_i_const_net_0  = 8'h00;
assign r5_rstart_addr_i_const_net_0 = 38'h0000000000;
assign r6_burst_size_i_const_net_0  = 8'h00;
assign r6_rstart_addr_i_const_net_0 = 38'h0000000000;
assign r7_burst_size_i_const_net_0  = 8'h00;
assign r7_rstart_addr_i_const_net_0 = 38'h0000000000;
assign w1_burst_size_i_const_net_0  = 8'h00;
assign w1_data_i_const_net_0        = 64'h0000000000000000;
assign w1_wstart_addr_i_const_net_0 = 38'h0000000000;
assign w2_burst_size_i_const_net_0  = 8'h00;
assign w2_data_i_const_net_0        = 64'h0000000000000000;
assign w2_wstart_addr_i_const_net_0 = 38'h0000000000;
assign w3_burst_size_i_const_net_0  = 8'h00;
assign w3_data_i_const_net_0        = 64'h0000000000000000;
assign w3_wstart_addr_i_const_net_0 = 38'h0000000000;
assign w4_burst_size_i_const_net_0  = 8'h00;
assign w4_data_i_const_net_0        = 64'h0000000000000000;
assign w4_wstart_addr_i_const_net_0 = 38'h0000000000;
assign w5_burst_size_i_const_net_0  = 8'h00;
assign w5_data_i_const_net_0        = 64'h0000000000000000;
assign w5_wstart_addr_i_const_net_0 = 38'h0000000000;
assign w6_burst_size_i_const_net_0  = 8'h00;
assign w6_data_i_const_net_0        = 64'h0000000000000000;
assign w6_wstart_addr_i_const_net_0 = 38'h0000000000;
assign w7_burst_size_i_const_net_0  = 8'h00;
assign w7_data_i_const_net_0        = 64'h0000000000000000;
assign w7_wstart_addr_i_const_net_0 = 38'h0000000000;
assign WDATA_I_0_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_0_const_net_0       = 38'h0000000000;
assign AWSIZE_I_0_const_net_0       = 8'h00;
assign WDATA_I_1_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_1_const_net_0       = 38'h0000000000;
assign AWSIZE_I_1_const_net_0       = 8'h00;
assign WDATA_I_2_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_2_const_net_0       = 38'h0000000000;
assign AWSIZE_I_2_const_net_0       = 8'h00;
assign WDATA_I_3_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_3_const_net_0       = 38'h0000000000;
assign AWSIZE_I_3_const_net_0       = 8'h00;
assign WDATA_I_4_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_4_const_net_0       = 38'h0000000000;
assign AWSIZE_I_4_const_net_0       = 8'h00;
assign WDATA_I_5_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_5_const_net_0       = 38'h0000000000;
assign AWSIZE_I_5_const_net_0       = 8'h00;
assign WDATA_I_6_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_6_const_net_0       = 38'h0000000000;
assign AWSIZE_I_6_const_net_0       = 8'h00;
assign WDATA_I_7_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_7_const_net_0       = 38'h0000000000;
assign AWSIZE_I_7_const_net_0       = 8'h00;
assign ARADDR_I_0_const_net_0       = 38'h0000000000;
assign ARSIZE_I_0_const_net_0       = 8'h00;
assign ARADDR_I_1_const_net_0       = 38'h0000000000;
assign ARSIZE_I_1_const_net_0       = 8'h00;
assign ARADDR_I_2_const_net_0       = 38'h0000000000;
assign ARSIZE_I_2_const_net_0       = 8'h00;
assign ARADDR_I_3_const_net_0       = 38'h0000000000;
assign ARSIZE_I_3_const_net_0       = 8'h00;
assign ARADDR_I_4_const_net_0       = 38'h0000000000;
assign ARSIZE_I_4_const_net_0       = 8'h00;
assign ARADDR_I_5_const_net_0       = 38'h0000000000;
assign ARSIZE_I_5_const_net_0       = 8'h00;
assign ARADDR_I_6_const_net_0       = 38'h0000000000;
assign ARSIZE_I_6_const_net_0       = 8'h00;
assign ARADDR_I_7_const_net_0       = 38'h0000000000;
assign ARSIZE_I_7_const_net_0       = 8'h00;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign INT_DMA_O_net_1           = INT_DMA_O_net_0;
assign INT_DMA_O                 = INT_DMA_O_net_1;
assign mAXI4_SLAVE_AWVALID_net_1 = mAXI4_SLAVE_AWVALID_net_0;
assign mAXI4_SLAVE_awvalid       = mAXI4_SLAVE_AWVALID_net_1;
assign mAXI4_SLAVE_WLAST_net_1   = mAXI4_SLAVE_WLAST_net_0;
assign mAXI4_SLAVE_wlast         = mAXI4_SLAVE_WLAST_net_1;
assign mAXI4_SLAVE_WVALID_net_1  = mAXI4_SLAVE_WVALID_net_0;
assign mAXI4_SLAVE_wvalid        = mAXI4_SLAVE_WVALID_net_1;
assign mAXI4_SLAVE_BREADY_net_1  = mAXI4_SLAVE_BREADY_net_0;
assign mAXI4_SLAVE_bready        = mAXI4_SLAVE_BREADY_net_1;
assign mAXI4_SLAVE_ARVALID_net_1 = mAXI4_SLAVE_ARVALID_net_0;
assign mAXI4_SLAVE_arvalid       = mAXI4_SLAVE_ARVALID_net_1;
assign mAXI4_SLAVE_RREADY_net_1  = mAXI4_SLAVE_RREADY_net_0;
assign mAXI4_SLAVE_rready        = mAXI4_SLAVE_RREADY_net_1;
assign AXI4L_VDMA_AWREADY_net_1  = AXI4L_VDMA_AWREADY_net_0;
assign AXI4L_VDMA_awready        = AXI4L_VDMA_AWREADY_net_1;
assign AXI4L_VDMA_WREADY_net_1   = AXI4L_VDMA_WREADY_net_0;
assign AXI4L_VDMA_wready         = AXI4L_VDMA_WREADY_net_1;
assign AXI4L_VDMA_BVALID_net_1   = AXI4L_VDMA_BVALID_net_0;
assign AXI4L_VDMA_bvalid         = AXI4L_VDMA_BVALID_net_1;
assign AXI4L_VDMA_ARREADY_net_1  = AXI4L_VDMA_ARREADY_net_0;
assign AXI4L_VDMA_arready        = AXI4L_VDMA_ARREADY_net_1;
assign AXI4L_VDMA_RVALID_net_1   = AXI4L_VDMA_RVALID_net_0;
assign AXI4L_VDMA_rvalid         = AXI4L_VDMA_RVALID_net_1;
assign mAXI4_SLAVE_AWID_net_1    = mAXI4_SLAVE_AWID_net_0;
assign mAXI4_SLAVE_awid[3:0]     = mAXI4_SLAVE_AWID_net_1;
assign mAXI4_SLAVE_AWADDR_net_1  = mAXI4_SLAVE_AWADDR_net_0;
assign mAXI4_SLAVE_awaddr[37:0]  = mAXI4_SLAVE_AWADDR_net_1;
assign mAXI4_SLAVE_AWLEN_net_1   = mAXI4_SLAVE_AWLEN_net_0;
assign mAXI4_SLAVE_awlen[7:0]    = mAXI4_SLAVE_AWLEN_net_1;
assign mAXI4_SLAVE_AWSIZE_net_1  = mAXI4_SLAVE_AWSIZE_net_0;
assign mAXI4_SLAVE_awsize[2:0]   = mAXI4_SLAVE_AWSIZE_net_1;
assign mAXI4_SLAVE_AWBURST_net_1 = mAXI4_SLAVE_AWBURST_net_0;
assign mAXI4_SLAVE_awburst[1:0]  = mAXI4_SLAVE_AWBURST_net_1;
assign mAXI4_SLAVE_AWLOCK_net_1  = mAXI4_SLAVE_AWLOCK_net_0;
assign mAXI4_SLAVE_awlock[1:0]   = mAXI4_SLAVE_AWLOCK_net_1;
assign mAXI4_SLAVE_AWCACHE_net_1 = mAXI4_SLAVE_AWCACHE_net_0;
assign mAXI4_SLAVE_awcache[3:0]  = mAXI4_SLAVE_AWCACHE_net_1;
assign mAXI4_SLAVE_AWPROT_net_1  = mAXI4_SLAVE_AWPROT_net_0;
assign mAXI4_SLAVE_awprot[2:0]   = mAXI4_SLAVE_AWPROT_net_1;
assign mAXI4_SLAVE_WDATA_net_1   = mAXI4_SLAVE_WDATA_net_0;
assign mAXI4_SLAVE_wdata[63:0]   = mAXI4_SLAVE_WDATA_net_1;
assign mAXI4_SLAVE_WSTRB_net_1   = mAXI4_SLAVE_WSTRB_net_0;
assign mAXI4_SLAVE_wstrb[7:0]    = mAXI4_SLAVE_WSTRB_net_1;
assign mAXI4_SLAVE_ARID_net_1    = mAXI4_SLAVE_ARID_net_0;
assign mAXI4_SLAVE_arid[3:0]     = mAXI4_SLAVE_ARID_net_1;
assign mAXI4_SLAVE_ARADDR_net_1  = mAXI4_SLAVE_ARADDR_net_0;
assign mAXI4_SLAVE_araddr[37:0]  = mAXI4_SLAVE_ARADDR_net_1;
assign mAXI4_SLAVE_ARLEN_net_1   = mAXI4_SLAVE_ARLEN_net_0;
assign mAXI4_SLAVE_arlen[7:0]    = mAXI4_SLAVE_ARLEN_net_1;
assign mAXI4_SLAVE_ARSIZE_net_1  = mAXI4_SLAVE_ARSIZE_net_0;
assign mAXI4_SLAVE_arsize[2:0]   = mAXI4_SLAVE_ARSIZE_net_1;
assign mAXI4_SLAVE_ARBURST_net_1 = mAXI4_SLAVE_ARBURST_net_0;
assign mAXI4_SLAVE_arburst[1:0]  = mAXI4_SLAVE_ARBURST_net_1;
assign mAXI4_SLAVE_ARLOCK_net_1  = mAXI4_SLAVE_ARLOCK_net_0;
assign mAXI4_SLAVE_arlock[1:0]   = mAXI4_SLAVE_ARLOCK_net_1;
assign mAXI4_SLAVE_ARCACHE_net_1 = mAXI4_SLAVE_ARCACHE_net_0;
assign mAXI4_SLAVE_arcache[3:0]  = mAXI4_SLAVE_ARCACHE_net_1;
assign mAXI4_SLAVE_ARPROT_net_1  = mAXI4_SLAVE_ARPROT_net_0;
assign mAXI4_SLAVE_arprot[2:0]   = mAXI4_SLAVE_ARPROT_net_1;
assign AXI4L_VDMA_BRESP_net_1    = AXI4L_VDMA_BRESP_net_0;
assign AXI4L_VDMA_bresp[1:0]     = AXI4L_VDMA_BRESP_net_1;
assign AXI4L_VDMA_RDATA_net_1    = AXI4L_VDMA_RDATA_net_0;
assign AXI4L_VDMA_rdata[31:0]    = AXI4L_VDMA_RDATA_net_1;
assign AXI4L_VDMA_RRESP_net_1    = AXI4L_VDMA_RRESP_net_0;
assign AXI4L_VDMA_rresp[1:0]     = AXI4L_VDMA_RRESP_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------DDR_AXI4_ARBITER_PF
ddr_axi4_arbiter_vdma #( 
        .AXI4_SELECTION       ( 2 ),
        .AXI_ADDR_WIDTH       ( 38 ),
        .AXI_DATA_WIDTH       ( 64 ),
        .AXI_ID_WIDTH         ( 4 ),
        .FORMAT               ( 0 ),
        .NO_OF_READ_CHANNELS  ( 0 ),
        .NO_OF_WRITE_CHANNELS ( 1 ) )
ddr_axi4_arbiter_vdma_0(
        // Inputs
        .arready          ( mAXI4_SLAVE_arready ),
        .awready          ( mAXI4_SLAVE_awready ),
        .bvalid           ( mAXI4_SLAVE_bvalid ),
        .ddr_ctrl_ready_i ( DDR_CTRL_READY_I ),
        .r0_req_i         ( GND_net ),
        .r1_req_i         ( GND_net ),
        .r2_req_i         ( GND_net ),
        .r3_req_i         ( GND_net ),
        .r4_req_i         ( GND_net ),
        .r5_req_i         ( GND_net ),
        .r6_req_i         ( GND_net ),
        .r7_req_i         ( GND_net ),
        .reset_i          ( DDR_CLK_RSTN_I ),
        .rlast            ( mAXI4_SLAVE_rlast ),
        .rvalid           ( mAXI4_SLAVE_rvalid ),
        .sys_clk_i        ( DDR_CLK_I ),
        .w0_data_valid_i  ( dma_top_0_rdata_rdy_o ),
        .w0_req_i         ( dma_top_0_write_req_o ),
        .w1_data_valid_i  ( GND_net ),
        .w1_req_i         ( GND_net ),
        .w2_data_valid_i  ( GND_net ),
        .w2_req_i         ( GND_net ),
        .w3_data_valid_i  ( GND_net ),
        .w3_req_i         ( GND_net ),
        .w4_data_valid_i  ( GND_net ),
        .w4_req_i         ( GND_net ),
        .w5_data_valid_i  ( GND_net ),
        .w5_req_i         ( GND_net ),
        .w6_data_valid_i  ( GND_net ),
        .w6_req_i         ( GND_net ),
        .w7_data_valid_i  ( GND_net ),
        .w7_req_i         ( GND_net ),
        .wready           ( mAXI4_SLAVE_wready ),
        .WVALID_I_0       ( GND_net ),
        .AWVALID_I_0      ( GND_net ),
        .WVALID_I_1       ( GND_net ),
        .AWVALID_I_1      ( GND_net ),
        .WVALID_I_2       ( GND_net ),
        .AWVALID_I_2      ( GND_net ),
        .WVALID_I_3       ( GND_net ),
        .AWVALID_I_3      ( GND_net ),
        .WVALID_I_4       ( GND_net ),
        .AWVALID_I_4      ( GND_net ),
        .WVALID_I_5       ( GND_net ),
        .AWVALID_I_5      ( GND_net ),
        .WVALID_I_6       ( GND_net ),
        .AWVALID_I_6      ( GND_net ),
        .WVALID_I_7       ( GND_net ),
        .AWVALID_I_7      ( GND_net ),
        .ARVALID_I_0      ( GND_net ),
        .ARVALID_I_1      ( GND_net ),
        .ARVALID_I_2      ( GND_net ),
        .ARVALID_I_3      ( GND_net ),
        .ARVALID_I_4      ( GND_net ),
        .ARVALID_I_5      ( GND_net ),
        .ARVALID_I_6      ( GND_net ),
        .ARVALID_I_7      ( GND_net ),
        .bid              ( mAXI4_SLAVE_bid ),
        .bresp            ( mAXI4_SLAVE_bresp ),
        .r0_burst_size_i  ( r0_burst_size_i_const_net_0 ),
        .r0_rstart_addr_i ( r0_rstart_addr_i_const_net_0 ),
        .r1_burst_size_i  ( r1_burst_size_i_const_net_0 ),
        .r1_rstart_addr_i ( r1_rstart_addr_i_const_net_0 ),
        .r2_burst_size_i  ( r2_burst_size_i_const_net_0 ),
        .r2_rstart_addr_i ( r2_rstart_addr_i_const_net_0 ),
        .r3_burst_size_i  ( r3_burst_size_i_const_net_0 ),
        .r3_rstart_addr_i ( r3_rstart_addr_i_const_net_0 ),
        .r4_burst_size_i  ( r4_burst_size_i_const_net_0 ),
        .r4_rstart_addr_i ( r4_rstart_addr_i_const_net_0 ),
        .r5_burst_size_i  ( r5_burst_size_i_const_net_0 ),
        .r5_rstart_addr_i ( r5_rstart_addr_i_const_net_0 ),
        .r6_burst_size_i  ( r6_burst_size_i_const_net_0 ),
        .r6_rstart_addr_i ( r6_rstart_addr_i_const_net_0 ),
        .r7_burst_size_i  ( r7_burst_size_i_const_net_0 ),
        .r7_rstart_addr_i ( r7_rstart_addr_i_const_net_0 ),
        .rdata            ( mAXI4_SLAVE_rdata ),
        .rid              ( mAXI4_SLAVE_rid ),
        .rresp            ( mAXI4_SLAVE_rresp ),
        .w0_burst_size_i  ( dma_top_0_write_length_o ),
        .w0_data_i        ( dma_top_0_rdata_o ),
        .w0_wstart_addr_i ( dma_top_0_write_start_addr_o ),
        .w1_burst_size_i  ( w1_burst_size_i_const_net_0 ),
        .w1_data_i        ( w1_data_i_const_net_0 ),
        .w1_wstart_addr_i ( w1_wstart_addr_i_const_net_0 ),
        .w2_burst_size_i  ( w2_burst_size_i_const_net_0 ),
        .w2_data_i        ( w2_data_i_const_net_0 ),
        .w2_wstart_addr_i ( w2_wstart_addr_i_const_net_0 ),
        .w3_burst_size_i  ( w3_burst_size_i_const_net_0 ),
        .w3_data_i        ( w3_data_i_const_net_0 ),
        .w3_wstart_addr_i ( w3_wstart_addr_i_const_net_0 ),
        .w4_burst_size_i  ( w4_burst_size_i_const_net_0 ),
        .w4_data_i        ( w4_data_i_const_net_0 ),
        .w4_wstart_addr_i ( w4_wstart_addr_i_const_net_0 ),
        .w5_burst_size_i  ( w5_burst_size_i_const_net_0 ),
        .w5_data_i        ( w5_data_i_const_net_0 ),
        .w5_wstart_addr_i ( w5_wstart_addr_i_const_net_0 ),
        .w6_burst_size_i  ( w6_burst_size_i_const_net_0 ),
        .w6_data_i        ( w6_data_i_const_net_0 ),
        .w6_wstart_addr_i ( w6_wstart_addr_i_const_net_0 ),
        .w7_burst_size_i  ( w7_burst_size_i_const_net_0 ),
        .w7_data_i        ( w7_data_i_const_net_0 ),
        .w7_wstart_addr_i ( w7_wstart_addr_i_const_net_0 ),
        .WDATA_I_0        ( WDATA_I_0_const_net_0 ),
        .AWADDR_I_0       ( AWADDR_I_0_const_net_0 ),
        .AWSIZE_I_0       ( AWSIZE_I_0_const_net_0 ),
        .WDATA_I_1        ( WDATA_I_1_const_net_0 ),
        .AWADDR_I_1       ( AWADDR_I_1_const_net_0 ),
        .AWSIZE_I_1       ( AWSIZE_I_1_const_net_0 ),
        .WDATA_I_2        ( WDATA_I_2_const_net_0 ),
        .AWADDR_I_2       ( AWADDR_I_2_const_net_0 ),
        .AWSIZE_I_2       ( AWSIZE_I_2_const_net_0 ),
        .WDATA_I_3        ( WDATA_I_3_const_net_0 ),
        .AWADDR_I_3       ( AWADDR_I_3_const_net_0 ),
        .AWSIZE_I_3       ( AWSIZE_I_3_const_net_0 ),
        .WDATA_I_4        ( WDATA_I_4_const_net_0 ),
        .AWADDR_I_4       ( AWADDR_I_4_const_net_0 ),
        .AWSIZE_I_4       ( AWSIZE_I_4_const_net_0 ),
        .WDATA_I_5        ( WDATA_I_5_const_net_0 ),
        .AWADDR_I_5       ( AWADDR_I_5_const_net_0 ),
        .AWSIZE_I_5       ( AWSIZE_I_5_const_net_0 ),
        .WDATA_I_6        ( WDATA_I_6_const_net_0 ),
        .AWADDR_I_6       ( AWADDR_I_6_const_net_0 ),
        .AWSIZE_I_6       ( AWSIZE_I_6_const_net_0 ),
        .WDATA_I_7        ( WDATA_I_7_const_net_0 ),
        .AWADDR_I_7       ( AWADDR_I_7_const_net_0 ),
        .AWSIZE_I_7       ( AWSIZE_I_7_const_net_0 ),
        .ARADDR_I_0       ( ARADDR_I_0_const_net_0 ),
        .ARSIZE_I_0       ( ARSIZE_I_0_const_net_0 ),
        .ARADDR_I_1       ( ARADDR_I_1_const_net_0 ),
        .ARSIZE_I_1       ( ARSIZE_I_1_const_net_0 ),
        .ARADDR_I_2       ( ARADDR_I_2_const_net_0 ),
        .ARSIZE_I_2       ( ARSIZE_I_2_const_net_0 ),
        .ARADDR_I_3       ( ARADDR_I_3_const_net_0 ),
        .ARSIZE_I_3       ( ARSIZE_I_3_const_net_0 ),
        .ARADDR_I_4       ( ARADDR_I_4_const_net_0 ),
        .ARSIZE_I_4       ( ARSIZE_I_4_const_net_0 ),
        .ARADDR_I_5       ( ARADDR_I_5_const_net_0 ),
        .ARSIZE_I_5       ( ARSIZE_I_5_const_net_0 ),
        .ARADDR_I_6       ( ARADDR_I_6_const_net_0 ),
        .ARSIZE_I_6       ( ARSIZE_I_6_const_net_0 ),
        .ARADDR_I_7       ( ARADDR_I_7_const_net_0 ),
        .ARSIZE_I_7       ( ARSIZE_I_7_const_net_0 ),
        // Outputs
        .BUSER_O_0        (  ),
        .AWREADY_O_0      (  ),
        .BUSER_O_1        (  ),
        .AWREADY_O_1      (  ),
        .BUSER_O_2        (  ),
        .AWREADY_O_2      (  ),
        .BUSER_O_3        (  ),
        .AWREADY_O_3      (  ),
        .BUSER_O_4        (  ),
        .AWREADY_O_4      (  ),
        .BUSER_O_5        (  ),
        .AWREADY_O_5      (  ),
        .BUSER_O_6        (  ),
        .AWREADY_O_6      (  ),
        .BUSER_O_7        (  ),
        .AWREADY_O_7      (  ),
        .BUSER_O_r0       (  ),
        .ARREADY_O_0      (  ),
        .RVALID_O_0       (  ),
        .RLAST_O_0        (  ),
        .BUSER_O_r1       (  ),
        .ARREADY_O_1      (  ),
        .RVALID_O_1       (  ),
        .RLAST_O_1        (  ),
        .BUSER_O_r2       (  ),
        .ARREADY_O_2      (  ),
        .RVALID_O_2       (  ),
        .RLAST_O_2        (  ),
        .BUSER_O_r3       (  ),
        .ARREADY_O_3      (  ),
        .RVALID_O_3       (  ),
        .RLAST_O_3        (  ),
        .BUSER_O_r4       (  ),
        .ARREADY_O_4      (  ),
        .RVALID_O_4       (  ),
        .RLAST_O_4        (  ),
        .BUSER_O_r5       (  ),
        .ARREADY_O_5      (  ),
        .RVALID_O_5       (  ),
        .RLAST_O_5        (  ),
        .BUSER_O_r6       (  ),
        .ARREADY_O_6      (  ),
        .RVALID_O_6       (  ),
        .RLAST_O_6        (  ),
        .BUSER_O_r7       (  ),
        .ARREADY_O_7      (  ),
        .RVALID_O_7       (  ),
        .RLAST_O_7        (  ),
        .arvalid          ( mAXI4_SLAVE_ARVALID_net_0 ),
        .awvalid          ( mAXI4_SLAVE_AWVALID_net_0 ),
        .bready           ( mAXI4_SLAVE_BREADY_net_0 ),
        .r0_ack_o         (  ),
        .r0_data_valid_o  (  ),
        .r0_done_o        (  ),
        .r1_ack_o         (  ),
        .r1_data_valid_o  (  ),
        .r1_done_o        (  ),
        .r2_ack_o         (  ),
        .r2_data_valid_o  (  ),
        .r2_done_o        (  ),
        .r3_ack_o         (  ),
        .r3_data_valid_o  (  ),
        .r3_done_o        (  ),
        .r4_ack_o         (  ),
        .r4_data_valid_o  (  ),
        .r4_done_o        (  ),
        .r5_ack_o         (  ),
        .r5_data_valid_o  (  ),
        .r5_done_o        (  ),
        .r6_ack_o         (  ),
        .r6_data_valid_o  (  ),
        .r6_done_o        (  ),
        .r7_ack_o         (  ),
        .r7_data_valid_o  (  ),
        .r7_done_o        (  ),
        .rready           ( mAXI4_SLAVE_RREADY_net_0 ),
        .w0_ack_o         ( DDR_AXI4_ARBITER_PF_0_w0_ack_o ),
        .w0_done_o        ( DDR_AXI4_ARBITER_PF_0_w0_done_o ),
        .w1_ack_o         (  ),
        .w1_done_o        (  ),
        .w2_ack_o         (  ),
        .w2_done_o        (  ),
        .w3_ack_o         (  ),
        .w3_done_o        (  ),
        .w4_ack_o         (  ),
        .w4_done_o        (  ),
        .w5_ack_o         (  ),
        .w5_done_o        (  ),
        .w6_ack_o         (  ),
        .w6_done_o        (  ),
        .w7_ack_o         (  ),
        .w7_done_o        (  ),
        .wlast            ( mAXI4_SLAVE_WLAST_net_0 ),
        .wvalid           ( mAXI4_SLAVE_WVALID_net_0 ),
        .RDATA_O_0        (  ),
        .RDATA_O_1        (  ),
        .RDATA_O_2        (  ),
        .RDATA_O_3        (  ),
        .RDATA_O_4        (  ),
        .RDATA_O_5        (  ),
        .RDATA_O_6        (  ),
        .RDATA_O_7        (  ),
        .araddr           ( mAXI4_SLAVE_ARADDR_net_0 ),
        .arburst          ( mAXI4_SLAVE_ARBURST_net_0 ),
        .arcache          ( mAXI4_SLAVE_ARCACHE_net_0 ),
        .arid             ( mAXI4_SLAVE_ARID_net_0 ),
        .arlen            ( mAXI4_SLAVE_ARLEN_net_0 ),
        .arlock           ( mAXI4_SLAVE_ARLOCK_net_0 ),
        .arprot           ( mAXI4_SLAVE_ARPROT_net_0 ),
        .arsize           ( mAXI4_SLAVE_ARSIZE_net_0 ),
        .awaddr           ( mAXI4_SLAVE_AWADDR_net_0 ),
        .awburst          ( mAXI4_SLAVE_AWBURST_net_0 ),
        .awcache          ( mAXI4_SLAVE_AWCACHE_net_0 ),
        .awid             ( mAXI4_SLAVE_AWID_net_0 ),
        .awlen            ( mAXI4_SLAVE_AWLEN_net_0 ),
        .awlock           ( mAXI4_SLAVE_AWLOCK_net_0 ),
        .awprot           ( mAXI4_SLAVE_AWPROT_net_0 ),
        .awsize           ( mAXI4_SLAVE_AWSIZE_net_0 ),
        .rdata_o          (  ),
        .wdata            ( mAXI4_SLAVE_WDATA_net_0 ),
        .wstrb            ( mAXI4_SLAVE_WSTRB_net_0 ) 
        );

//--------vdma_dma_top
   vdma_dma_top #(.g_IP_DW(g_IP_DW),
		  .g_OP_DW(64))
 dma_top_0(
        // Inputs
        .arvalid            ( AXI4L_VDMA_arvalid ),
        .awvalid            ( AXI4L_VDMA_awvalid ),
        .bready             ( AXI4L_VDMA_bready ),
        .rready             ( AXI4L_VDMA_rready ),
        .wvalid             ( AXI4L_VDMA_wvalid ),
        .aclk               ( ACLK_I ),
        .aclk_rstn          ( ARESETN_I ),
        .data_valid_i       ( DATA_VALID_I ),
        .ddr_clk_i          ( DDR_CLK_I ),
        .ddr_clk_rstn_i     ( DDR_CLK_RSTN_I ),
        .frame_start_i      ( FRAME_START_I ),
        .video_clk_i        ( VIDEO_CLK_I ),
        .video_clk_rstn_i   ( VIDEO_CLK_RSTN_I ),
        .write_ackn_i       ( DDR_AXI4_ARBITER_PF_0_w0_ack_o ),
        .write_done_i       ( DDR_AXI4_ARBITER_PF_0_w0_done_o ),
        .araddr             ( AXI4L_VDMA_araddr ),
        .awaddr             ( AXI4L_VDMA_awaddr ),
        .wdata              ( AXI4L_VDMA_wdata ),
        .data_i             ( DATA_I ),
        // Outputs
        .arready            ( AXI4L_VDMA_ARREADY_net_0 ),
        .awready            ( AXI4L_VDMA_AWREADY_net_0 ),
        .bvalid             ( AXI4L_VDMA_BVALID_net_0 ),
        .rvalid             ( AXI4L_VDMA_RVALID_net_0 ),
        .wready             ( AXI4L_VDMA_WREADY_net_0 ),
        .int_dma            ( INT_DMA_O_net_0 ),
        .rdata_rdy_o        ( dma_top_0_rdata_rdy_o ),
        .write_req_o        ( dma_top_0_write_req_o ),
        .bresp              ( AXI4L_VDMA_BRESP_net_0 ),
        .rdata              ( AXI4L_VDMA_RDATA_net_0 ),
        .rresp              ( AXI4L_VDMA_RRESP_net_0 ),
        .rdata_o            ( dma_top_0_rdata_o ),
        .write_length_o     ( dma_top_0_write_length_o ),
        .write_start_addr_o ( dma_top_0_write_start_addr_o ) 
        );


endmodule
