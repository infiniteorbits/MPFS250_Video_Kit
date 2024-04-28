//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Nov  9 19:51:29 2020
// Version: v12.5 12.900.10.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// DDR_AXI4_ARBITER_PF
module ddr_axi4_arbiter_native_vdma #(

parameter   AXI_ID_WIDTH                = 4,
parameter   AXI_ADDR_WIDTH              = 32,
parameter   AXI_DATA_WIDTH              = 512,
parameter	NO_OF_READ_CHANNELS			= 8,
parameter	NO_OF_WRITE_CHANNELS		= 8,
parameter	AXI4_SELECTION				= 2
)
(
    // Inputs
	reset_i,
	sys_clk_i,
    arready,
    awready,
    bid,
    bresp,
    bvalid,
    ddr_ctrl_ready,
    r0_burst_size_i,
    r0_req_i,
    r0_rstart_addr_i,
    r1_burst_size_i,
    r1_req_i,
    r1_rstart_addr_i,
    r2_burst_size_i,
    r2_req_i,
    r2_rstart_addr_i,
    r3_burst_size_i,
    r3_req_i,
    r3_rstart_addr_i,
    r4_burst_size_i,
    r4_req_i,
    r4_rstart_addr_i,
    r5_burst_size_i,
    r5_req_i,
    r5_rstart_addr_i,
    r6_burst_size_i,
    r6_req_i,
    r6_rstart_addr_i,
    r7_burst_size_i,
    r7_req_i,
    r7_rstart_addr_i,
    rdata,
    rid,
    rlast,
    rresp,
    rvalid,
    w0_burst_size_i,
    w0_data_i,
    w0_data_valid_i,
    w0_req_i,
    w0_wstart_addr_i,
    w1_burst_size_i,
    w1_data_i,
    w1_data_valid_i,
    w1_req_i,
    w1_wstart_addr_i,
    w2_burst_size_i,
    w2_data_i,
    w2_data_valid_i,
    w2_req_i,
    w2_wstart_addr_i,
    w3_burst_size_i,
    w3_data_i,
    w3_data_valid_i,
    w3_req_i,
    w3_wstart_addr_i,
    w4_burst_size_i,
    w4_data_i,
    w4_data_valid_i,
    w4_req_i,
    w4_wstart_addr_i,
    w5_burst_size_i,
    w5_data_i,
    w5_data_valid_i,
    w5_req_i,
    w5_wstart_addr_i,
    w6_burst_size_i,
    w6_data_i,
    w6_data_valid_i,
    w6_req_i,
    w6_wstart_addr_i,
    w7_burst_size_i,
    w7_data_i,
    w7_data_valid_i,
    w7_req_i,
    w7_wstart_addr_i,
    wready,
    // Outputs
    araddr,
    arburst,
    arcache,
    arid,
    arlen,
    arlock,
    arprot,
    arsize,
    arvalid,
    awaddr,
    awburst,
    awcache,
    awid,
    awlen,
    awlock,
    awprot,
    awsize,
    awvalid,
    bready,
    r0_ack_o,
    r0_data_valid_o,
    r0_done_o,
    r1_ack_o,
    r1_data_valid_o,
    r1_done_o,
    r2_ack_o,
    r2_data_valid_o,
    r2_done_o,
    r3_ack_o,
    r3_data_valid_o,
    r3_done_o,
    r4_ack_o,
    r4_data_valid_o,
    r4_done_o,
    r5_ack_o,
    r5_data_valid_o,
    r5_done_o,
    r6_ack_o,
    r6_data_valid_o,
    r6_done_o,
    r7_ack_o,
    r7_data_valid_o,
    r7_done_o,
    rdata_o,
    rready,
    w0_ack_o,
    w0_done_o,
    w1_ack_o,
    w1_done_o,
    w2_ack_o,
    w2_done_o,
    w3_ack_o,
    w3_done_o,
    w4_ack_o,
    w4_done_o,
    w5_ack_o,
    w5_done_o,
    w6_ack_o,
    w6_done_o,
    w7_ack_o,
    w7_done_o,
    wdata,
    wlast,
    wstrb,
    wvalid
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input          arready;
input          awready;
input  [AXI_ID_WIDTH-1:0]   bid;
input  [1:0]   bresp;
input          bvalid;
input          ddr_ctrl_ready;
input  [7:0]   r0_burst_size_i;
input          r0_req_i;
input  [AXI_ADDR_WIDTH-1:0]  r0_rstart_addr_i;
input  [7:0]   r1_burst_size_i;
input          r1_req_i;
input  [AXI_ADDR_WIDTH-1:0]  r1_rstart_addr_i;
input  [7:0]   r2_burst_size_i;
input          r2_req_i;
input  [AXI_ADDR_WIDTH-1:0]  r2_rstart_addr_i;
input  [7:0]   r3_burst_size_i;
input          r3_req_i;
input  [AXI_ADDR_WIDTH-1:0]  r3_rstart_addr_i;
input  [7:0]   r4_burst_size_i;
input          r4_req_i;
input  [AXI_ADDR_WIDTH-1:0]  r4_rstart_addr_i;
input  [7:0]   r5_burst_size_i;
input          r5_req_i;
input  [AXI_ADDR_WIDTH-1:0]  r5_rstart_addr_i;
input  [7:0]   r6_burst_size_i;
input          r6_req_i;
input  [AXI_ADDR_WIDTH-1:0]  r6_rstart_addr_i;
input  [7:0]   r7_burst_size_i;
input          r7_req_i;
input  [AXI_ADDR_WIDTH-1:0]  r7_rstart_addr_i;
input  [AXI_DATA_WIDTH-1:0] rdata;
input          reset_i;
input  [AXI_ID_WIDTH-1:0]   rid;
input          rlast;
input  [1:0]   rresp;
input          rvalid;
input          sys_clk_i;
input  [7:0]   w0_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w0_data_i;
input          w0_data_valid_i;
input          w0_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w0_wstart_addr_i;
input  [7:0]   w1_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w1_data_i;
input          w1_data_valid_i;
input          w1_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w1_wstart_addr_i;
input  [7:0]   w2_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w2_data_i;
input          w2_data_valid_i;
input          w2_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w2_wstart_addr_i;
input  [7:0]   w3_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w3_data_i;
input          w3_data_valid_i;
input          w3_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w3_wstart_addr_i;
input  [7:0]   w4_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w4_data_i;
input          w4_data_valid_i;
input          w4_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w4_wstart_addr_i;
input  [7:0]   w5_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w5_data_i;
input          w5_data_valid_i;
input          w5_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w5_wstart_addr_i;
input  [7:0]   w6_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w6_data_i;
input          w6_data_valid_i;
input          w6_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w6_wstart_addr_i;
input  [7:0]   w7_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w7_data_i;
input          w7_data_valid_i;
input          w7_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w7_wstart_addr_i;
input          wready;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [AXI_ADDR_WIDTH-1:0]  araddr;
output [1:0]   arburst;
output [3:0]   arcache;
output [AXI_ID_WIDTH-1:0]   arid;
output [7:0]   arlen;
output [1:0]   arlock;
output [2:0]   arprot;
output [2:0]   arsize;
output         arvalid;
output [AXI_ADDR_WIDTH-1:0]  awaddr;
output [1:0]   awburst;
output [3:0]   awcache;
output [AXI_ID_WIDTH-1:0]   awid;
output [7:0]   awlen;
output [1:0]   awlock;
output [2:0]   awprot;
output [2:0]   awsize;
output         awvalid;
output         bready;
output         r0_ack_o;
output         r0_data_valid_o;
output         r0_done_o;
output         r1_ack_o;
output         r1_data_valid_o;
output         r1_done_o;
output         r2_ack_o;
output         r2_data_valid_o;
output         r2_done_o;
output         r3_ack_o;
output         r3_data_valid_o;
output         r3_done_o;
output         r4_ack_o;
output         r4_data_valid_o;
output         r4_done_o;
output         r5_ack_o;
output         r5_data_valid_o;
output         r5_done_o;
output         r6_ack_o;
output         r6_data_valid_o;
output         r6_done_o;
output         r7_ack_o;
output         r7_data_valid_o;
output         r7_done_o;
output [AXI_DATA_WIDTH-1:0] rdata_o;
output         rready;
output         w0_ack_o;
output         w0_done_o;
output         w1_ack_o;
output         w1_done_o;
output         w2_ack_o;
output         w2_done_o;
output         w3_ack_o;
output         w3_done_o;
output         w4_ack_o;
output         w4_done_o;
output         w5_ack_o;
output         w5_done_o;
output         w6_ack_o;
output         w6_done_o;
output         w7_ack_o;
output         w7_done_o;
output [AXI_DATA_WIDTH-1:0] wdata;
output         wlast;
output [(AXI_DATA_WIDTH/8)-1:0]  wstrb;
output         wvalid;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire           ddr_ctrl_ready;
wire           ddr_rw_arbiter_0_rack_o;
wire           ddr_rw_arbiter_0_rdata_valid_o;
wire           ddr_rw_arbiter_0_rdone_o;
wire           ddr_rw_arbiter_0_wack_o;
wire           ddr_rw_arbiter_0_wdone_o;
wire   [AXI_ADDR_WIDTH-1:0]  M_AXI_4_ARADDR;
wire   [1:0]   M_AXI_4_ARBURST;
wire   [3:0]   M_AXI_4_ARCACHE;
wire   [AXI_ID_WIDTH-1:0]   M_AXI_4_ARID;
wire   [7:0]   M_AXI_4_ARLEN;
wire   [1:0]   M_AXI_4_ARLOCK;
wire   [2:0]   M_AXI_4_ARPROT;
wire           arready;
wire   [2:0]   M_AXI_4_ARSIZE;
wire           M_AXI_4_ARVALID;
wire   [AXI_ADDR_WIDTH-1:0]  M_AXI_4_AWADDR;
wire   [1:0]   M_AXI_4_AWBURST;
wire   [3:0]   M_AXI_4_AWCACHE;
wire   [AXI_ID_WIDTH-1:0]   M_AXI_4_AWID;
wire   [7:0]   M_AXI_4_AWLEN;
wire   [1:0]   M_AXI_4_AWLOCK;
wire   [2:0]   M_AXI_4_AWPROT;
wire           awready;
wire   [2:0]   M_AXI_4_AWSIZE;
wire           M_AXI_4_AWVALID;
wire   [AXI_ID_WIDTH-1:0]   bid;
wire           M_AXI_4_BREADY;
wire   [1:0]   bresp;
wire           bvalid;
wire   [AXI_DATA_WIDTH-1:0] rdata;
wire   [AXI_ID_WIDTH-1:0]   rid;
wire           rlast;
wire           M_AXI_4_RREADY;
wire   [1:0]   rresp;
wire           rvalid;
wire   [AXI_DATA_WIDTH-1:0] M_AXI_4_WDATA;
wire           M_AXI_4_WLAST;
wire           wready;
wire   [(AXI_DATA_WIDTH/8)-1:0]  M_AXI_4_WSTRB;
wire           M_AXI_4_WVALID;
wire           r0_ack_o_net_0;
wire   [7:0]   r0_burst_size_i;
wire           r0_data_valid_o_net_0;
wire           r0_done_o_net_0;
wire           r0_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  r0_rstart_addr_i;
wire           r1_ack_o_net_0;
wire   [7:0]   r1_burst_size_i;
wire           r1_data_valid_o_net_0;
wire           r1_done_o_net_0;
wire           r1_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  r1_rstart_addr_i;
wire           r2_ack_o_net_0;
wire   [7:0]   r2_burst_size_i;
wire           r2_data_valid_o_net_0;
wire           r2_done_o_net_0;
wire           r2_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  r2_rstart_addr_i;
wire           r3_ack_o_net_0;
wire   [7:0]   r3_burst_size_i;
wire           r3_data_valid_o_net_0;
wire           r3_done_o_net_0;
wire           r3_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  r3_rstart_addr_i;
wire           r4_ack_o_net_0;
wire   [7:0]   r4_burst_size_i;
wire           r4_data_valid_o_net_0;
wire           r4_done_o_net_0;
wire           r4_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  r4_rstart_addr_i;
wire           r5_ack_o_net_0;
wire   [7:0]   r5_burst_size_i;
wire           r5_data_valid_o_net_0;
wire           r5_done_o_net_0;
wire           r5_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  r5_rstart_addr_i;
wire           r6_ack_o_net_0;
wire   [7:0]   r6_burst_size_i;
wire           r6_data_valid_o_net_0;
wire           r6_done_o_net_0;
wire           r6_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  r6_rstart_addr_i;
wire           r7_ack_o_net_0;
wire   [7:0]   r7_burst_size_i;
wire           r7_data_valid_o_net_0;
wire           r7_done_o_net_0;
wire           r7_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  r7_rstart_addr_i;
wire   [AXI_DATA_WIDTH-1:0] rdata_o_1;
wire   [7:0]   read_top_0_burst_size_o_0;
wire           read_top_0_req_o;
wire   [AXI_ADDR_WIDTH-1:0]  read_top_0_rstart_addr_o;
wire           reset_i;
wire           sys_clk_i;
wire           w0_ack_o_net_0;
wire   [7:0]   w0_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w0_data_i;
wire           w0_data_valid_i;
wire           w0_done_o_net_0;
wire           w0_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w0_wstart_addr_i;
wire           w1_ack_o_net_0;
wire   [7:0]   w1_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w1_data_i;
wire           w1_data_valid_i;
wire           w1_done_o_net_0;
wire           w1_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w1_wstart_addr_i;
wire           w2_ack_o_net_0;
wire   [7:0]   w2_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w2_data_i;
wire           w2_data_valid_i;
wire           w2_done_o_net_0;
wire           w2_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w2_wstart_addr_i;
wire           w3_ack_o_net_0;
wire   [7:0]   w3_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w3_data_i;
wire           w3_data_valid_i;
wire           w3_done_o_net_0;
wire           w3_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w3_wstart_addr_i;
wire           w4_ack_o_net_0;
wire   [7:0]   w4_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w4_data_i;
wire           w4_data_valid_i;
wire           w4_done_o_net_0;
wire           w4_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w4_wstart_addr_i;
wire           w5_ack_o_net_0;
wire   [7:0]   w5_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w5_data_i;
wire           w5_data_valid_i;
wire           w5_done_o_net_0;
wire           w5_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w5_wstart_addr_i;
wire           w6_ack_o_net_0;
wire   [7:0]   w6_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w6_data_i;
wire           w6_data_valid_i;
wire           w6_done_o_net_0;
wire           w6_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w6_wstart_addr_i;
wire           w7_ack_o_net_0;
wire   [7:0]   w7_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w7_data_i;
wire           w7_data_valid_i;
wire           w7_done_o_net_0;
wire           w7_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w7_wstart_addr_i;
wire   [7:0]   write_top_0_burst_size_o_0;
wire   [AXI_DATA_WIDTH-1:0] write_top_0_data_o_2;
wire           write_top_0_data_valid_o;
wire           write_top_0_req_o;
wire   [AXI_ADDR_WIDTH-1:0]  write_top_0_wstart_addr_o;
wire           w0_done_o_net_1;
wire           w0_ack_o_net_1;
wire           w1_done_o_net_1;
wire           w1_ack_o_net_1;
wire           w2_done_o_net_1;
wire           w2_ack_o_net_1;
wire           w3_done_o_net_1;
wire           w3_ack_o_net_1;
wire           r0_done_o_net_1;
wire           r0_ack_o_net_1;
wire           r0_data_valid_o_net_1;
wire           r1_data_valid_o_net_1;
wire           r1_ack_o_net_1;
wire           r1_done_o_net_1;
wire           r2_data_valid_o_net_1;
wire           r2_ack_o_net_1;
wire           r2_done_o_net_1;
wire           r3_data_valid_o_net_1;
wire           r3_ack_o_net_1;
wire           r3_done_o_net_1;
wire           w4_done_o_net_1;
wire           w4_ack_o_net_1;
wire           r5_done_o_net_1;
wire           r5_ack_o_net_1;
wire           r4_ack_o_net_1;
wire           r4_data_valid_o_net_1;
wire           r4_done_o_net_1;
wire           r5_data_valid_o_net_1;
wire           w7_ack_o_net_1;
wire           w6_done_o_net_1;
wire           w6_ack_o_net_1;
wire           w5_done_o_net_1;
wire           w5_ack_o_net_1;
wire           w7_done_o_net_1;
wire           r6_done_o_net_1;
wire           r6_data_valid_o_net_1;
wire           r7_data_valid_o_net_1;
wire           r7_done_o_net_1;
wire           r7_ack_o_net_1;
wire           r6_ack_o_net_1;
wire   [AXI_DATA_WIDTH-1:0] rdata_o_1_net_0;
wire   [AXI_ID_WIDTH-1:0]   M_AXI_4_AWID_net_0;
wire   [AXI_ADDR_WIDTH-1:0]  M_AXI_4_AWADDR_net_0;
wire   [7:0]   M_AXI_4_AWLEN_net_0;
wire   [2:0]   M_AXI_4_AWSIZE_net_0;
wire   [1:0]   M_AXI_4_AWBURST_net_0;
wire   [1:0]   M_AXI_4_AWLOCK_net_0;
wire   [3:0]   M_AXI_4_AWCACHE_net_0;
wire   [2:0]   M_AXI_4_AWPROT_net_0;
wire           M_AXI_4_AWVALID_net_0;
wire   [AXI_DATA_WIDTH-1:0] M_AXI_4_WDATA_net_0;
wire   [(AXI_DATA_WIDTH/8)-1:0]  M_AXI_4_WSTRB_net_0;
wire           M_AXI_4_WLAST_net_0;
wire           M_AXI_4_WVALID_net_0;
wire           M_AXI_4_BREADY_net_0;
wire   [AXI_ID_WIDTH-1:0]   M_AXI_4_ARID_net_0;
wire   [AXI_ADDR_WIDTH-1:0]  M_AXI_4_ARADDR_net_0;
wire   [7:0]   M_AXI_4_ARLEN_net_0;
wire   [2:0]   M_AXI_4_ARSIZE_net_0;
wire   [1:0]   M_AXI_4_ARBURST_net_0;
wire   [1:0]   M_AXI_4_ARLOCK_net_0;
wire   [3:0]   M_AXI_4_ARCACHE_net_0;
wire   [2:0]   M_AXI_4_ARPROT_net_0;
wire           M_AXI_4_ARVALID_net_0;
wire           M_AXI_4_RREADY_net_0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign w0_done_o_net_1       = w0_done_o_net_0;
assign w0_done_o             = w0_done_o_net_1;
assign w0_ack_o_net_1        = w0_ack_o_net_0;
assign w0_ack_o              = w0_ack_o_net_1;
assign w1_done_o_net_1       = w1_done_o_net_0;
assign w1_done_o             = w1_done_o_net_1;
assign w1_ack_o_net_1        = w1_ack_o_net_0;
assign w1_ack_o              = w1_ack_o_net_1;
assign w2_done_o_net_1       = w2_done_o_net_0;
assign w2_done_o             = w2_done_o_net_1;
assign w2_ack_o_net_1        = w2_ack_o_net_0;
assign w2_ack_o              = w2_ack_o_net_1;
assign w3_done_o_net_1       = w3_done_o_net_0;
assign w3_done_o             = w3_done_o_net_1;
assign w3_ack_o_net_1        = w3_ack_o_net_0;
assign w3_ack_o              = w3_ack_o_net_1;
assign r0_done_o_net_1       = r0_done_o_net_0;
assign r0_done_o             = r0_done_o_net_1;
assign r0_ack_o_net_1        = r0_ack_o_net_0;
assign r0_ack_o              = r0_ack_o_net_1;
assign r0_data_valid_o_net_1 = r0_data_valid_o_net_0;
assign r0_data_valid_o       = r0_data_valid_o_net_1;
assign r1_data_valid_o_net_1 = r1_data_valid_o_net_0;
assign r1_data_valid_o       = r1_data_valid_o_net_1;
assign r1_ack_o_net_1        = r1_ack_o_net_0;
assign r1_ack_o              = r1_ack_o_net_1;
assign r1_done_o_net_1       = r1_done_o_net_0;
assign r1_done_o             = r1_done_o_net_1;
assign r2_data_valid_o_net_1 = r2_data_valid_o_net_0;
assign r2_data_valid_o       = r2_data_valid_o_net_1;
assign r2_ack_o_net_1        = r2_ack_o_net_0;
assign r2_ack_o              = r2_ack_o_net_1;
assign r2_done_o_net_1       = r2_done_o_net_0;
assign r2_done_o             = r2_done_o_net_1;
assign r3_data_valid_o_net_1 = r3_data_valid_o_net_0;
assign r3_data_valid_o       = r3_data_valid_o_net_1;
assign r3_ack_o_net_1        = r3_ack_o_net_0;
assign r3_ack_o              = r3_ack_o_net_1;
assign r3_done_o_net_1       = r3_done_o_net_0;
assign r3_done_o             = r3_done_o_net_1;
assign w4_done_o_net_1       = w4_done_o_net_0;
assign w4_done_o             = w4_done_o_net_1;
assign w4_ack_o_net_1        = w4_ack_o_net_0;
assign w4_ack_o              = w4_ack_o_net_1;
assign r5_done_o_net_1       = r5_done_o_net_0;
assign r5_done_o             = r5_done_o_net_1;
assign r5_ack_o_net_1        = r5_ack_o_net_0;
assign r5_ack_o              = r5_ack_o_net_1;
assign r4_ack_o_net_1        = r4_ack_o_net_0;
assign r4_ack_o              = r4_ack_o_net_1;
assign r4_data_valid_o_net_1 = r4_data_valid_o_net_0;
assign r4_data_valid_o       = r4_data_valid_o_net_1;
assign r4_done_o_net_1       = r4_done_o_net_0;
assign r4_done_o             = r4_done_o_net_1;
assign r5_data_valid_o_net_1 = r5_data_valid_o_net_0;
assign r5_data_valid_o       = r5_data_valid_o_net_1;
assign w7_ack_o_net_1        = w7_ack_o_net_0;
assign w7_ack_o              = w7_ack_o_net_1;
assign w6_done_o_net_1       = w6_done_o_net_0;
assign w6_done_o             = w6_done_o_net_1;
assign w6_ack_o_net_1        = w6_ack_o_net_0;
assign w6_ack_o              = w6_ack_o_net_1;
assign w5_done_o_net_1       = w5_done_o_net_0;
assign w5_done_o             = w5_done_o_net_1;
assign w5_ack_o_net_1        = w5_ack_o_net_0;
assign w5_ack_o              = w5_ack_o_net_1;
assign w7_done_o_net_1       = w7_done_o_net_0;
assign w7_done_o             = w7_done_o_net_1;
assign r6_done_o_net_1       = r6_done_o_net_0;
assign r6_done_o             = r6_done_o_net_1;
assign r6_data_valid_o_net_1 = r6_data_valid_o_net_0;
assign r6_data_valid_o       = r6_data_valid_o_net_1;
assign r7_data_valid_o_net_1 = r7_data_valid_o_net_0;
assign r7_data_valid_o       = r7_data_valid_o_net_1;
assign r7_done_o_net_1       = r7_done_o_net_0;
assign r7_done_o             = r7_done_o_net_1;
assign r7_ack_o_net_1        = r7_ack_o_net_0;
assign r7_ack_o              = r7_ack_o_net_1;
assign r6_ack_o_net_1        = r6_ack_o_net_0;
assign r6_ack_o              = r6_ack_o_net_1;
assign rdata_o_1_net_0       = rdata_o_1;
assign rdata_o[AXI_DATA_WIDTH-1:0]        = rdata_o_1_net_0;
assign M_AXI_4_AWID_net_0    = M_AXI_4_AWID;
assign awid[AXI_ID_WIDTH-1:0]             = M_AXI_4_AWID_net_0;
assign M_AXI_4_AWADDR_net_0  = M_AXI_4_AWADDR;
assign awaddr[AXI_ADDR_WIDTH-1:0]          = M_AXI_4_AWADDR_net_0;
assign M_AXI_4_AWLEN_net_0   = M_AXI_4_AWLEN;
assign awlen[7:0]            = M_AXI_4_AWLEN_net_0;
assign M_AXI_4_AWSIZE_net_0  = M_AXI_4_AWSIZE;
assign awsize[2:0]           = M_AXI_4_AWSIZE_net_0;
assign M_AXI_4_AWBURST_net_0 = M_AXI_4_AWBURST;
assign awburst[1:0]          = M_AXI_4_AWBURST_net_0;
assign M_AXI_4_AWLOCK_net_0  = M_AXI_4_AWLOCK;
assign awlock[1:0]           = M_AXI_4_AWLOCK_net_0;
assign M_AXI_4_AWCACHE_net_0 = M_AXI_4_AWCACHE;
assign awcache[3:0]          = M_AXI_4_AWCACHE_net_0;
assign M_AXI_4_AWPROT_net_0  = M_AXI_4_AWPROT;
assign awprot[2:0]           = M_AXI_4_AWPROT_net_0;
assign M_AXI_4_AWVALID_net_0 = M_AXI_4_AWVALID;
assign awvalid               = M_AXI_4_AWVALID_net_0;
assign M_AXI_4_WDATA_net_0   = M_AXI_4_WDATA;
assign wdata[AXI_DATA_WIDTH-1:0]          = M_AXI_4_WDATA_net_0;
assign M_AXI_4_WSTRB_net_0   = M_AXI_4_WSTRB;
assign wstrb	             = M_AXI_4_WSTRB_net_0;
assign M_AXI_4_WLAST_net_0   = M_AXI_4_WLAST;
assign wlast                 = M_AXI_4_WLAST_net_0;
assign M_AXI_4_WVALID_net_0  = M_AXI_4_WVALID;
assign wvalid                = M_AXI_4_WVALID_net_0;
assign M_AXI_4_BREADY_net_0  = M_AXI_4_BREADY;
assign bready                = M_AXI_4_BREADY_net_0;
assign M_AXI_4_ARID_net_0    = M_AXI_4_ARID;
assign arid[AXI_ID_WIDTH-1:0]             = M_AXI_4_ARID_net_0;
assign M_AXI_4_ARADDR_net_0  = M_AXI_4_ARADDR;
assign araddr[AXI_ADDR_WIDTH-1:0]          = M_AXI_4_ARADDR_net_0;
assign M_AXI_4_ARLEN_net_0   = M_AXI_4_ARLEN;
assign arlen[7:0]            = M_AXI_4_ARLEN_net_0;
assign M_AXI_4_ARSIZE_net_0  = M_AXI_4_ARSIZE;
assign arsize[2:0]           = M_AXI_4_ARSIZE_net_0;
assign M_AXI_4_ARBURST_net_0 = M_AXI_4_ARBURST;
assign arburst[1:0]          = M_AXI_4_ARBURST_net_0;
assign M_AXI_4_ARLOCK_net_0  = M_AXI_4_ARLOCK;
assign arlock[1:0]           = M_AXI_4_ARLOCK_net_0;
assign M_AXI_4_ARCACHE_net_0 = M_AXI_4_ARCACHE;
assign arcache[3:0]          = M_AXI_4_ARCACHE_net_0;
assign M_AXI_4_ARPROT_net_0  = M_AXI_4_ARPROT;
assign arprot[2:0]           = M_AXI_4_ARPROT_net_0;
assign M_AXI_4_ARVALID_net_0 = M_AXI_4_ARVALID;
assign arvalid               = M_AXI_4_ARVALID_net_0;
assign M_AXI_4_RREADY_net_0  = M_AXI_4_RREADY;
assign rready                = M_AXI_4_RREADY_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------ddr_rw_arbiter
ddr_rw_arbiter_vdma #( 
        .AXI_ADDR_WIDTH  ( AXI_ADDR_WIDTH ),
        .AXI_DATA_WIDTH  ( AXI_DATA_WIDTH ),
        .AXI_ID_WIDTH    ( AXI_ID_WIDTH ),
        .AXI_LEN_WIDTH   ( 8 ),
        .VIDEO_BUS_DSIZE ( AXI_DATA_WIDTH ) )
ddr_rw_arbiter_vdma_0(
        // Inputs
        .ddr_clk_i        ( sys_clk_i ),
        .resetn_i         ( reset_i ),
        .ddr_ctrl_ready_i ( ddr_ctrl_ready ),
        .awready          ( awready ),
        .wready           ( wready ),
        .bid              ( bid ),
        .bresp            ( bresp ),
        .bvalid           ( bvalid ),
        .arready          ( arready ),
        .rid              ( rid ),
        .rdata            ( rdata ),
        .rresp            ( rresp ),
        .rlast            ( rlast ),
        .rvalid           ( rvalid ),
        .wreq_i           ( write_top_0_req_o ),
        .wstart_addr_i    ( write_top_0_wstart_addr_o ),
        .beats_to_w_i     ( write_top_0_burst_size_o_0 ),
        .wdata_i          ( write_top_0_data_o_2 ),
        .wdata_valid_i    ( write_top_0_data_valid_o ),
        .rreq_i           ( read_top_0_req_o ),
        .rstart_addr_i    ( read_top_0_rstart_addr_o ),
        .beats_to_r_i     ( read_top_0_burst_size_o_0 ),
        // Outputs
        .awid             ( M_AXI_4_AWID ),
        .awaddr           ( M_AXI_4_AWADDR ),
        .awlen            ( M_AXI_4_AWLEN ),
        .awsize           ( M_AXI_4_AWSIZE ),
        .awburst          ( M_AXI_4_AWBURST ),
        .awlock           ( M_AXI_4_AWLOCK ),
        .awcache          ( M_AXI_4_AWCACHE ),
        .awprot           ( M_AXI_4_AWPROT ),
        .awvalid          ( M_AXI_4_AWVALID ),
        .wdata            ( M_AXI_4_WDATA ),
        .wstrb            ( M_AXI_4_WSTRB ),
        .wlast            ( M_AXI_4_WLAST ),
        .wvalid           ( M_AXI_4_WVALID ),
        .bready           ( M_AXI_4_BREADY ),
        .arid             ( M_AXI_4_ARID ),
        .araddr           ( M_AXI_4_ARADDR ),
        .arlen            ( M_AXI_4_ARLEN ),
        .arsize           ( M_AXI_4_ARSIZE ),
        .arburst          ( M_AXI_4_ARBURST ),
        .arlock           ( M_AXI_4_ARLOCK ),
        .arcache          ( M_AXI_4_ARCACHE ),
        .arprot           ( M_AXI_4_ARPROT ),
        .arvalid          ( M_AXI_4_ARVALID ),
        .rready           ( M_AXI_4_RREADY ),
        .wack_o           ( ddr_rw_arbiter_0_wack_o ),
        .wdone_o          ( ddr_rw_arbiter_0_wdone_o ),
        .rack_o           ( ddr_rw_arbiter_0_rack_o ),
        .rdata_o          ( rdata_o_1 ),
        .rdata_valid_o    ( ddr_rw_arbiter_0_rdata_valid_o ),
        .rdone_o          ( ddr_rw_arbiter_0_rdone_o ) 
        );

//--------read_top
read_top_vdma  #( 
        .AXI_ADDR_WIDTH  ( AXI_ADDR_WIDTH ) )
    read_top_vdma_0(
        // Inputs
        .sys_clk_i        ( sys_clk_i ),
        .reset_i          ( reset_i ),
        .req3_i           ( r3_req_i ),
        .req0_i           ( r0_req_i ),
        .req1_i           ( r1_req_i ),
        .req2_i           ( r2_req_i ),
        .data_valid_i     ( ddr_rw_arbiter_0_rdata_valid_o ),
        .ack_i            ( ddr_rw_arbiter_0_rack_o ),
        .done_i           ( ddr_rw_arbiter_0_rdone_o ),
        .req5_i           ( r5_req_i ),
        .req4_i           ( r4_req_i ),
        .req6_i           ( r6_req_i ),
        .req7_i           ( r7_req_i ),
        .r0_rstart_addr_i ( r0_rstart_addr_i ),
        .r1_rstart_addr_i ( r1_rstart_addr_i ),
        .r2_rstart_addr_i ( r2_rstart_addr_i ),
        .r3_rstart_addr_i ( r3_rstart_addr_i ),
        .r3_burst_size_i  ( r3_burst_size_i ),
        .r0_burst_size_i  ( r0_burst_size_i ),
        .r1_burst_size_i  ( r1_burst_size_i ),
        .r2_burst_size_i  ( r2_burst_size_i ),
        .r4_burst_size_i  ( r4_burst_size_i ),
        .r5_rstart_addr_i ( r5_rstart_addr_i ),
        .r5_burst_size_i  ( r5_burst_size_i ),
        .r4_rstart_addr_i ( r4_rstart_addr_i ),
        .r7_rstart_addr_i ( r7_rstart_addr_i ),
        .r6_burst_size_i  ( r6_burst_size_i ),
        .r7_burst_size_i  ( r7_burst_size_i ),
        .r6_rstart_addr_i ( r6_rstart_addr_i ),
        // Outputs
        .r3_data_valid_o  ( r3_data_valid_o_net_0 ),
        .r0_ack_o         ( r0_ack_o_net_0 ),
        .r0_done_o        ( r0_done_o_net_0 ),
        .r0_data_valid_o  ( r0_data_valid_o_net_0 ),
        .r1_ack_o         ( r1_ack_o_net_0 ),
        .r1_done_o        ( r1_done_o_net_0 ),
        .r1_data_valid_o  ( r1_data_valid_o_net_0 ),
        .r2_ack_o         ( r2_ack_o_net_0 ),
        .r2_done_o        ( r2_done_o_net_0 ),
        .r2_data_valid_o  ( r2_data_valid_o_net_0 ),
        .r3_ack_o         ( r3_ack_o_net_0 ),
        .r3_done_o        ( r3_done_o_net_0 ),
        .req_o            ( read_top_0_req_o ),
        .r5_data_valid_o  ( r5_data_valid_o_net_0 ),
        .r4_done_o        ( r4_done_o_net_0 ),
        .r4_data_valid_o  ( r4_data_valid_o_net_0 ),
        .r4_ack_o         ( r4_ack_o_net_0 ),
        .r5_ack_o         ( r5_ack_o_net_0 ),
        .r5_done_o        ( r5_done_o_net_0 ),
        .r7_data_valid_o  ( r7_data_valid_o_net_0 ),
        .r6_data_valid_o  ( r6_data_valid_o_net_0 ),
        .r6_ack_o         ( r6_ack_o_net_0 ),
        .r7_ack_o         ( r7_ack_o_net_0 ),
        .r7_done_o        ( r7_done_o_net_0 ),
        .r6_done_o        ( r6_done_o_net_0 ),
        .rstart_addr_o    ( read_top_0_rstart_addr_o ),
        .burst_size_o     ( read_top_0_burst_size_o_0 ) 
        );

//--------write_top
write_top_vdma  #( 
        .AXI_ADDR_WIDTH  ( AXI_ADDR_WIDTH ),
        .AXI_DATA_WIDTH  ( AXI_DATA_WIDTH ) )
    write_top_vdma_0(
        // Inputs
        .reset_i          ( reset_i ),
        .sys_clk_i        ( sys_clk_i ),
        .w3_req_i         ( w3_req_i ),
        .w0_req_i         ( w0_req_i ),
        .w1_req_i         ( w1_req_i ),
        .w2_req_i         ( w2_req_i ),
        .w0_data_valid_i  ( w0_data_valid_i ),
        .w3_data_valid_i  ( w3_data_valid_i ),
        .w2_data_valid_i  ( w2_data_valid_i ),
        .w1_data_valid_i  ( w1_data_valid_i ),
        .ack_i            ( ddr_rw_arbiter_0_wack_o ),
        .done_i           ( ddr_rw_arbiter_0_wdone_o ),
        .w4_req_i         ( w4_req_i ),
        .w4_data_valid_i  ( w4_data_valid_i ),
        .w5_req_i         ( w5_req_i ),
        .w7_req_i         ( w7_req_i ),
        .w6_req_i         ( w6_req_i ),
        .w7_data_valid_i  ( w7_data_valid_i ),
        .w5_data_valid_i  ( w5_data_valid_i ),
        .w6_data_valid_i  ( w6_data_valid_i ),
        .w3_wstart_addr_i ( w3_wstart_addr_i ),
        .w2_wstart_addr_i ( w2_wstart_addr_i ),
        .w1_wstart_addr_i ( w1_wstart_addr_i ),
        .w0_wstart_addr_i ( w0_wstart_addr_i ),
        .w3_data_i        ( w3_data_i ),
        .w0_data_i        ( w0_data_i ),
        .w1_data_i        ( w1_data_i ),
        .w2_data_i        ( w2_data_i ),
        .w3_burst_size_i  ( w3_burst_size_i ),
        .w0_burst_size_i  ( w0_burst_size_i ),
        .w1_burst_size_i  ( w1_burst_size_i ),
        .w2_burst_size_i  ( w2_burst_size_i ),
        .w4_data_i        ( w4_data_i ),
        .w4_burst_size_i  ( w4_burst_size_i ),
        .w4_wstart_addr_i ( w4_wstart_addr_i ),
        .w7_data_i        ( w7_data_i ),
        .w6_wstart_addr_i ( w6_wstart_addr_i ),
        .w6_data_i        ( w6_data_i ),
        .w7_burst_size_i  ( w7_burst_size_i ),
        .w7_wstart_addr_i ( w7_wstart_addr_i ),
        .w5_burst_size_i  ( w5_burst_size_i ),
        .w5_wstart_addr_i ( w5_wstart_addr_i ),
        .w5_data_i        ( w5_data_i ),
        .w6_burst_size_i  ( w6_burst_size_i ),
        // Outputs
        .w0_ack_o         ( w0_ack_o_net_0 ),
        .w3_done_o        ( w3_done_o_net_0 ),
        .w3_ack_o         ( w3_ack_o_net_0 ),
        .w2_done_o        ( w2_done_o_net_0 ),
        .w2_ack_o         ( w2_ack_o_net_0 ),
        .w1_done_o        ( w1_done_o_net_0 ),
        .w1_ack_o         ( w1_ack_o_net_0 ),
        .w0_done_o        ( w0_done_o_net_0 ),
        .data_valid_o     ( write_top_0_data_valid_o ),
        .req_o            ( write_top_0_req_o ),
        .w4_ack_o         ( w4_ack_o_net_0 ),
        .w4_done_o        ( w4_done_o_net_0 ),
        .w7_done_o        ( w7_done_o_net_0 ),
        .w5_ack_o         ( w5_ack_o_net_0 ),
        .w5_done_o        ( w5_done_o_net_0 ),
        .w6_ack_o         ( w6_ack_o_net_0 ),
        .w6_done_o        ( w6_done_o_net_0 ),
        .w7_ack_o         ( w7_ack_o_net_0 ),
        .wstart_addr_o    ( write_top_0_wstart_addr_o ),
        .data_o           ( write_top_0_data_o_2 ),
        .burst_size_o     ( write_top_0_burst_size_o_0 ) 
        );


endmodule
