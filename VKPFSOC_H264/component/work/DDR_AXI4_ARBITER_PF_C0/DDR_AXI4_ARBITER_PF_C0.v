//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Aug 12 21:23:50 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of DDR_AXI4_ARBITER_PF_C0 to TCL
# Family: PolarFireSoC
# Part Number: MPFS250TS-1FCG1152I
# Create and Configure the core component DDR_AXI4_ARBITER_PF_C0
create_and_configure_core -core_vlnv {Microsemi:SolutionCore:DDR_AXI4_ARBITER_PF:2.1.0} -component_name {DDR_AXI4_ARBITER_PF_C0} -params {\
"AXI4_SELECTION:2"  \
"AXI_ADDR_WIDTH:32"  \
"AXI_DATA_WIDTH:64"  \
"AXI_ID_WIDTH:4"  \
"FORMAT:0"  \
"NO_OF_READ_CHANNELS:1"  \
"NO_OF_WRITE_CHANNELS:1"   }
# Exporting Component Description of DDR_AXI4_ARBITER_PF_C0 to TCL done
*/

// DDR_AXI4_ARBITER_PF_C0
module DDR_AXI4_ARBITER_PF_C0(
    // Inputs
    arready,
    awready,
    bid,
    bresp,
    bvalid,
    ddr_ctrl_ready_i,
    r0_burst_size_i,
    r0_req_i,
    r0_rstart_addr_i,
    rdata,
    reset_i,
    rid,
    rlast,
    rresp,
    rvalid,
    sys_clk_i,
    w0_burst_size_i,
    w0_data_i,
    w0_data_valid_i,
    w0_req_i,
    w0_wstart_addr_i,
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
    rdata_o,
    rready,
    w0_ack_o,
    w0_done_o,
    wdata,
    wlast,
    wstrb,
    wvalid
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         arready;
input         awready;
input  [3:0]  bid;
input  [1:0]  bresp;
input         bvalid;
input         ddr_ctrl_ready_i;
input  [7:0]  r0_burst_size_i;
input         r0_req_i;
input  [31:0] r0_rstart_addr_i;
input  [63:0] rdata;
input         reset_i;
input  [3:0]  rid;
input         rlast;
input  [1:0]  rresp;
input         rvalid;
input         sys_clk_i;
input  [7:0]  w0_burst_size_i;
input  [63:0] w0_data_i;
input         w0_data_valid_i;
input         w0_req_i;
input  [31:0] w0_wstart_addr_i;
input         wready;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] araddr;
output [1:0]  arburst;
output [3:0]  arcache;
output [3:0]  arid;
output [7:0]  arlen;
output [1:0]  arlock;
output [2:0]  arprot;
output [2:0]  arsize;
output        arvalid;
output [31:0] awaddr;
output [1:0]  awburst;
output [3:0]  awcache;
output [3:0]  awid;
output [7:0]  awlen;
output [1:0]  awlock;
output [2:0]  awprot;
output [2:0]  awsize;
output        awvalid;
output        bready;
output        r0_ack_o;
output        r0_data_valid_o;
output        r0_done_o;
output [63:0] rdata_o;
output        rready;
output        w0_ack_o;
output        w0_done_o;
output [63:0] wdata;
output        wlast;
output [7:0]  wstrb;
output        wvalid;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          ddr_ctrl_ready_i;
wire   [31:0] MIRRORED_SLAVE_AXI4_ARADDR;
wire   [1:0]  MIRRORED_SLAVE_AXI4_ARBURST;
wire   [3:0]  MIRRORED_SLAVE_AXI4_ARCACHE;
wire   [3:0]  MIRRORED_SLAVE_AXI4_ARID;
wire   [7:0]  MIRRORED_SLAVE_AXI4_ARLEN;
wire   [1:0]  MIRRORED_SLAVE_AXI4_ARLOCK;
wire   [2:0]  MIRRORED_SLAVE_AXI4_ARPROT;
wire          arready;
wire   [2:0]  MIRRORED_SLAVE_AXI4_ARSIZE;
wire          MIRRORED_SLAVE_AXI4_ARVALID;
wire   [31:0] MIRRORED_SLAVE_AXI4_AWADDR;
wire   [1:0]  MIRRORED_SLAVE_AXI4_AWBURST;
wire   [3:0]  MIRRORED_SLAVE_AXI4_AWCACHE;
wire   [3:0]  MIRRORED_SLAVE_AXI4_AWID;
wire   [7:0]  MIRRORED_SLAVE_AXI4_AWLEN;
wire   [1:0]  MIRRORED_SLAVE_AXI4_AWLOCK;
wire   [2:0]  MIRRORED_SLAVE_AXI4_AWPROT;
wire          awready;
wire   [2:0]  MIRRORED_SLAVE_AXI4_AWSIZE;
wire          MIRRORED_SLAVE_AXI4_AWVALID;
wire   [3:0]  bid;
wire          MIRRORED_SLAVE_AXI4_BREADY;
wire   [1:0]  bresp;
wire          bvalid;
wire   [63:0] rdata;
wire   [3:0]  rid;
wire          rlast;
wire          MIRRORED_SLAVE_AXI4_RREADY;
wire   [1:0]  rresp;
wire          rvalid;
wire   [63:0] MIRRORED_SLAVE_AXI4_WDATA;
wire          MIRRORED_SLAVE_AXI4_WLAST;
wire          wready;
wire   [7:0]  MIRRORED_SLAVE_AXI4_WSTRB;
wire          MIRRORED_SLAVE_AXI4_WVALID;
wire          r0_ack_o_net_0;
wire   [7:0]  r0_burst_size_i;
wire          r0_data_valid_o_net_0;
wire          r0_done_o_net_0;
wire          r0_req_i;
wire   [31:0] r0_rstart_addr_i;
wire   [63:0] rdata_o_net_0;
wire          reset_i;
wire          sys_clk_i;
wire          w0_ack_o_net_0;
wire   [7:0]  w0_burst_size_i;
wire   [63:0] w0_data_i;
wire          w0_data_valid_i;
wire          w0_done_o_net_0;
wire          w0_req_i;
wire   [31:0] w0_wstart_addr_i;
wire          r0_ack_o_net_1;
wire          r0_data_valid_o_net_1;
wire          r0_done_o_net_1;
wire   [63:0] rdata_o_net_1;
wire          w0_ack_o_net_1;
wire          w0_done_o_net_1;
wire   [3:0]  MIRRORED_SLAVE_AXI4_AWID_net_0;
wire   [31:0] MIRRORED_SLAVE_AXI4_AWADDR_net_0;
wire   [7:0]  MIRRORED_SLAVE_AXI4_AWLEN_net_0;
wire   [2:0]  MIRRORED_SLAVE_AXI4_AWSIZE_net_0;
wire   [1:0]  MIRRORED_SLAVE_AXI4_AWBURST_net_0;
wire   [1:0]  MIRRORED_SLAVE_AXI4_AWLOCK_net_0;
wire   [3:0]  MIRRORED_SLAVE_AXI4_AWCACHE_net_0;
wire   [2:0]  MIRRORED_SLAVE_AXI4_AWPROT_net_0;
wire          MIRRORED_SLAVE_AXI4_AWVALID_net_0;
wire   [63:0] MIRRORED_SLAVE_AXI4_WDATA_net_0;
wire   [7:0]  MIRRORED_SLAVE_AXI4_WSTRB_net_0;
wire          MIRRORED_SLAVE_AXI4_WLAST_net_0;
wire          MIRRORED_SLAVE_AXI4_WVALID_net_0;
wire          MIRRORED_SLAVE_AXI4_BREADY_net_0;
wire   [3:0]  MIRRORED_SLAVE_AXI4_ARID_net_0;
wire   [31:0] MIRRORED_SLAVE_AXI4_ARADDR_net_0;
wire   [7:0]  MIRRORED_SLAVE_AXI4_ARLEN_net_0;
wire   [2:0]  MIRRORED_SLAVE_AXI4_ARSIZE_net_0;
wire   [1:0]  MIRRORED_SLAVE_AXI4_ARBURST_net_0;
wire   [1:0]  MIRRORED_SLAVE_AXI4_ARLOCK_net_0;
wire   [3:0]  MIRRORED_SLAVE_AXI4_ARCACHE_net_0;
wire   [2:0]  MIRRORED_SLAVE_AXI4_ARPROT_net_0;
wire          MIRRORED_SLAVE_AXI4_ARVALID_net_0;
wire          MIRRORED_SLAVE_AXI4_RREADY_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [7:0]  r1_burst_size_i_const_net_0;
wire          GND_net;
wire   [31:0] r1_rstart_addr_i_const_net_0;
wire   [7:0]  r2_burst_size_i_const_net_0;
wire   [31:0] r2_rstart_addr_i_const_net_0;
wire   [7:0]  r3_burst_size_i_const_net_0;
wire   [31:0] r3_rstart_addr_i_const_net_0;
wire   [7:0]  r4_burst_size_i_const_net_0;
wire   [31:0] r4_rstart_addr_i_const_net_0;
wire   [7:0]  r5_burst_size_i_const_net_0;
wire   [31:0] r5_rstart_addr_i_const_net_0;
wire   [7:0]  r6_burst_size_i_const_net_0;
wire   [31:0] r6_rstart_addr_i_const_net_0;
wire   [7:0]  r7_burst_size_i_const_net_0;
wire   [31:0] r7_rstart_addr_i_const_net_0;
wire   [7:0]  w1_burst_size_i_const_net_0;
wire   [63:0] w1_data_i_const_net_0;
wire   [31:0] w1_wstart_addr_i_const_net_0;
wire   [7:0]  w2_burst_size_i_const_net_0;
wire   [63:0] w2_data_i_const_net_0;
wire   [31:0] w2_wstart_addr_i_const_net_0;
wire   [7:0]  w3_burst_size_i_const_net_0;
wire   [63:0] w3_data_i_const_net_0;
wire   [31:0] w3_wstart_addr_i_const_net_0;
wire   [7:0]  w4_burst_size_i_const_net_0;
wire   [63:0] w4_data_i_const_net_0;
wire   [31:0] w4_wstart_addr_i_const_net_0;
wire   [7:0]  w5_burst_size_i_const_net_0;
wire   [63:0] w5_data_i_const_net_0;
wire   [31:0] w5_wstart_addr_i_const_net_0;
wire   [7:0]  w6_burst_size_i_const_net_0;
wire   [63:0] w6_data_i_const_net_0;
wire   [31:0] w6_wstart_addr_i_const_net_0;
wire   [7:0]  w7_burst_size_i_const_net_0;
wire   [63:0] w7_data_i_const_net_0;
wire   [31:0] w7_wstart_addr_i_const_net_0;
wire   [63:0] WDATA_I_0_const_net_0;
wire   [31:0] AWADDR_I_0_const_net_0;
wire   [7:0]  AWSIZE_I_0_const_net_0;
wire   [63:0] WDATA_I_1_const_net_0;
wire   [31:0] AWADDR_I_1_const_net_0;
wire   [7:0]  AWSIZE_I_1_const_net_0;
wire   [63:0] WDATA_I_2_const_net_0;
wire   [31:0] AWADDR_I_2_const_net_0;
wire   [7:0]  AWSIZE_I_2_const_net_0;
wire   [63:0] WDATA_I_3_const_net_0;
wire   [31:0] AWADDR_I_3_const_net_0;
wire   [7:0]  AWSIZE_I_3_const_net_0;
wire   [63:0] WDATA_I_4_const_net_0;
wire   [31:0] AWADDR_I_4_const_net_0;
wire   [7:0]  AWSIZE_I_4_const_net_0;
wire   [63:0] WDATA_I_5_const_net_0;
wire   [31:0] AWADDR_I_5_const_net_0;
wire   [7:0]  AWSIZE_I_5_const_net_0;
wire   [63:0] WDATA_I_6_const_net_0;
wire   [31:0] AWADDR_I_6_const_net_0;
wire   [7:0]  AWSIZE_I_6_const_net_0;
wire   [63:0] WDATA_I_7_const_net_0;
wire   [31:0] AWADDR_I_7_const_net_0;
wire   [7:0]  AWSIZE_I_7_const_net_0;
wire   [31:0] ARADDR_I_0_const_net_0;
wire   [7:0]  ARSIZE_I_0_const_net_0;
wire   [31:0] ARADDR_I_1_const_net_0;
wire   [7:0]  ARSIZE_I_1_const_net_0;
wire   [31:0] ARADDR_I_2_const_net_0;
wire   [7:0]  ARSIZE_I_2_const_net_0;
wire   [31:0] ARADDR_I_3_const_net_0;
wire   [7:0]  ARSIZE_I_3_const_net_0;
wire   [31:0] ARADDR_I_4_const_net_0;
wire   [7:0]  ARSIZE_I_4_const_net_0;
wire   [31:0] ARADDR_I_5_const_net_0;
wire   [7:0]  ARSIZE_I_5_const_net_0;
wire   [31:0] ARADDR_I_6_const_net_0;
wire   [7:0]  ARSIZE_I_6_const_net_0;
wire   [31:0] ARADDR_I_7_const_net_0;
wire   [7:0]  ARSIZE_I_7_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign r1_burst_size_i_const_net_0  = 8'h00;
assign GND_net                      = 1'b0;
assign r1_rstart_addr_i_const_net_0 = 32'h00000000;
assign r2_burst_size_i_const_net_0  = 8'h00;
assign r2_rstart_addr_i_const_net_0 = 32'h00000000;
assign r3_burst_size_i_const_net_0  = 8'h00;
assign r3_rstart_addr_i_const_net_0 = 32'h00000000;
assign r4_burst_size_i_const_net_0  = 8'h00;
assign r4_rstart_addr_i_const_net_0 = 32'h00000000;
assign r5_burst_size_i_const_net_0  = 8'h00;
assign r5_rstart_addr_i_const_net_0 = 32'h00000000;
assign r6_burst_size_i_const_net_0  = 8'h00;
assign r6_rstart_addr_i_const_net_0 = 32'h00000000;
assign r7_burst_size_i_const_net_0  = 8'h00;
assign r7_rstart_addr_i_const_net_0 = 32'h00000000;
assign w1_burst_size_i_const_net_0  = 8'h00;
assign w1_data_i_const_net_0        = 64'h0000000000000000;
assign w1_wstart_addr_i_const_net_0 = 32'h00000000;
assign w2_burst_size_i_const_net_0  = 8'h00;
assign w2_data_i_const_net_0        = 64'h0000000000000000;
assign w2_wstart_addr_i_const_net_0 = 32'h00000000;
assign w3_burst_size_i_const_net_0  = 8'h00;
assign w3_data_i_const_net_0        = 64'h0000000000000000;
assign w3_wstart_addr_i_const_net_0 = 32'h00000000;
assign w4_burst_size_i_const_net_0  = 8'h00;
assign w4_data_i_const_net_0        = 64'h0000000000000000;
assign w4_wstart_addr_i_const_net_0 = 32'h00000000;
assign w5_burst_size_i_const_net_0  = 8'h00;
assign w5_data_i_const_net_0        = 64'h0000000000000000;
assign w5_wstart_addr_i_const_net_0 = 32'h00000000;
assign w6_burst_size_i_const_net_0  = 8'h00;
assign w6_data_i_const_net_0        = 64'h0000000000000000;
assign w6_wstart_addr_i_const_net_0 = 32'h00000000;
assign w7_burst_size_i_const_net_0  = 8'h00;
assign w7_data_i_const_net_0        = 64'h0000000000000000;
assign w7_wstart_addr_i_const_net_0 = 32'h00000000;
assign WDATA_I_0_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_0_const_net_0       = 32'h00000000;
assign AWSIZE_I_0_const_net_0       = 8'h00;
assign WDATA_I_1_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_1_const_net_0       = 32'h00000000;
assign AWSIZE_I_1_const_net_0       = 8'h00;
assign WDATA_I_2_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_2_const_net_0       = 32'h00000000;
assign AWSIZE_I_2_const_net_0       = 8'h00;
assign WDATA_I_3_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_3_const_net_0       = 32'h00000000;
assign AWSIZE_I_3_const_net_0       = 8'h00;
assign WDATA_I_4_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_4_const_net_0       = 32'h00000000;
assign AWSIZE_I_4_const_net_0       = 8'h00;
assign WDATA_I_5_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_5_const_net_0       = 32'h00000000;
assign AWSIZE_I_5_const_net_0       = 8'h00;
assign WDATA_I_6_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_6_const_net_0       = 32'h00000000;
assign AWSIZE_I_6_const_net_0       = 8'h00;
assign WDATA_I_7_const_net_0        = 64'h0000000000000000;
assign AWADDR_I_7_const_net_0       = 32'h00000000;
assign AWSIZE_I_7_const_net_0       = 8'h00;
assign ARADDR_I_0_const_net_0       = 32'h00000000;
assign ARSIZE_I_0_const_net_0       = 8'h00;
assign ARADDR_I_1_const_net_0       = 32'h00000000;
assign ARSIZE_I_1_const_net_0       = 8'h00;
assign ARADDR_I_2_const_net_0       = 32'h00000000;
assign ARSIZE_I_2_const_net_0       = 8'h00;
assign ARADDR_I_3_const_net_0       = 32'h00000000;
assign ARSIZE_I_3_const_net_0       = 8'h00;
assign ARADDR_I_4_const_net_0       = 32'h00000000;
assign ARSIZE_I_4_const_net_0       = 8'h00;
assign ARADDR_I_5_const_net_0       = 32'h00000000;
assign ARSIZE_I_5_const_net_0       = 8'h00;
assign ARADDR_I_6_const_net_0       = 32'h00000000;
assign ARSIZE_I_6_const_net_0       = 8'h00;
assign ARADDR_I_7_const_net_0       = 32'h00000000;
assign ARSIZE_I_7_const_net_0       = 8'h00;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign r0_ack_o_net_1                    = r0_ack_o_net_0;
assign r0_ack_o                          = r0_ack_o_net_1;
assign r0_data_valid_o_net_1             = r0_data_valid_o_net_0;
assign r0_data_valid_o                   = r0_data_valid_o_net_1;
assign r0_done_o_net_1                   = r0_done_o_net_0;
assign r0_done_o                         = r0_done_o_net_1;
assign rdata_o_net_1                     = rdata_o_net_0;
assign rdata_o[63:0]                     = rdata_o_net_1;
assign w0_ack_o_net_1                    = w0_ack_o_net_0;
assign w0_ack_o                          = w0_ack_o_net_1;
assign w0_done_o_net_1                   = w0_done_o_net_0;
assign w0_done_o                         = w0_done_o_net_1;
assign MIRRORED_SLAVE_AXI4_AWID_net_0    = MIRRORED_SLAVE_AXI4_AWID;
assign awid[3:0]                         = MIRRORED_SLAVE_AXI4_AWID_net_0;
assign MIRRORED_SLAVE_AXI4_AWADDR_net_0  = MIRRORED_SLAVE_AXI4_AWADDR;
assign awaddr[31:0]                      = MIRRORED_SLAVE_AXI4_AWADDR_net_0;
assign MIRRORED_SLAVE_AXI4_AWLEN_net_0   = MIRRORED_SLAVE_AXI4_AWLEN;
assign awlen[7:0]                        = MIRRORED_SLAVE_AXI4_AWLEN_net_0;
assign MIRRORED_SLAVE_AXI4_AWSIZE_net_0  = MIRRORED_SLAVE_AXI4_AWSIZE;
assign awsize[2:0]                       = MIRRORED_SLAVE_AXI4_AWSIZE_net_0;
assign MIRRORED_SLAVE_AXI4_AWBURST_net_0 = MIRRORED_SLAVE_AXI4_AWBURST;
assign awburst[1:0]                      = MIRRORED_SLAVE_AXI4_AWBURST_net_0;
assign MIRRORED_SLAVE_AXI4_AWLOCK_net_0  = MIRRORED_SLAVE_AXI4_AWLOCK;
assign awlock[1:0]                       = MIRRORED_SLAVE_AXI4_AWLOCK_net_0;
assign MIRRORED_SLAVE_AXI4_AWCACHE_net_0 = MIRRORED_SLAVE_AXI4_AWCACHE;
assign awcache[3:0]                      = MIRRORED_SLAVE_AXI4_AWCACHE_net_0;
assign MIRRORED_SLAVE_AXI4_AWPROT_net_0  = MIRRORED_SLAVE_AXI4_AWPROT;
assign awprot[2:0]                       = MIRRORED_SLAVE_AXI4_AWPROT_net_0;
assign MIRRORED_SLAVE_AXI4_AWVALID_net_0 = MIRRORED_SLAVE_AXI4_AWVALID;
assign awvalid                           = MIRRORED_SLAVE_AXI4_AWVALID_net_0;
assign MIRRORED_SLAVE_AXI4_WDATA_net_0   = MIRRORED_SLAVE_AXI4_WDATA;
assign wdata[63:0]                       = MIRRORED_SLAVE_AXI4_WDATA_net_0;
assign MIRRORED_SLAVE_AXI4_WSTRB_net_0   = MIRRORED_SLAVE_AXI4_WSTRB;
assign wstrb[7:0]                        = MIRRORED_SLAVE_AXI4_WSTRB_net_0;
assign MIRRORED_SLAVE_AXI4_WLAST_net_0   = MIRRORED_SLAVE_AXI4_WLAST;
assign wlast                             = MIRRORED_SLAVE_AXI4_WLAST_net_0;
assign MIRRORED_SLAVE_AXI4_WVALID_net_0  = MIRRORED_SLAVE_AXI4_WVALID;
assign wvalid                            = MIRRORED_SLAVE_AXI4_WVALID_net_0;
assign MIRRORED_SLAVE_AXI4_BREADY_net_0  = MIRRORED_SLAVE_AXI4_BREADY;
assign bready                            = MIRRORED_SLAVE_AXI4_BREADY_net_0;
assign MIRRORED_SLAVE_AXI4_ARID_net_0    = MIRRORED_SLAVE_AXI4_ARID;
assign arid[3:0]                         = MIRRORED_SLAVE_AXI4_ARID_net_0;
assign MIRRORED_SLAVE_AXI4_ARADDR_net_0  = MIRRORED_SLAVE_AXI4_ARADDR;
assign araddr[31:0]                      = MIRRORED_SLAVE_AXI4_ARADDR_net_0;
assign MIRRORED_SLAVE_AXI4_ARLEN_net_0   = MIRRORED_SLAVE_AXI4_ARLEN;
assign arlen[7:0]                        = MIRRORED_SLAVE_AXI4_ARLEN_net_0;
assign MIRRORED_SLAVE_AXI4_ARSIZE_net_0  = MIRRORED_SLAVE_AXI4_ARSIZE;
assign arsize[2:0]                       = MIRRORED_SLAVE_AXI4_ARSIZE_net_0;
assign MIRRORED_SLAVE_AXI4_ARBURST_net_0 = MIRRORED_SLAVE_AXI4_ARBURST;
assign arburst[1:0]                      = MIRRORED_SLAVE_AXI4_ARBURST_net_0;
assign MIRRORED_SLAVE_AXI4_ARLOCK_net_0  = MIRRORED_SLAVE_AXI4_ARLOCK;
assign arlock[1:0]                       = MIRRORED_SLAVE_AXI4_ARLOCK_net_0;
assign MIRRORED_SLAVE_AXI4_ARCACHE_net_0 = MIRRORED_SLAVE_AXI4_ARCACHE;
assign arcache[3:0]                      = MIRRORED_SLAVE_AXI4_ARCACHE_net_0;
assign MIRRORED_SLAVE_AXI4_ARPROT_net_0  = MIRRORED_SLAVE_AXI4_ARPROT;
assign arprot[2:0]                       = MIRRORED_SLAVE_AXI4_ARPROT_net_0;
assign MIRRORED_SLAVE_AXI4_ARVALID_net_0 = MIRRORED_SLAVE_AXI4_ARVALID;
assign arvalid                           = MIRRORED_SLAVE_AXI4_ARVALID_net_0;
assign MIRRORED_SLAVE_AXI4_RREADY_net_0  = MIRRORED_SLAVE_AXI4_RREADY;
assign rready                            = MIRRORED_SLAVE_AXI4_RREADY_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------DDR_AXI4_ARBITER_PF   -   Microsemi:SolutionCore:DDR_AXI4_ARBITER_PF:2.1.0
DDR_AXI4_ARBITER_PF #( 
        .AXI4_SELECTION       ( 2 ),
        .AXI_ADDR_WIDTH       ( 32 ),
        .AXI_DATA_WIDTH       ( 64 ),
        .AXI_ID_WIDTH         ( 4 ),
        .FORMAT               ( 0 ),
        .NO_OF_READ_CHANNELS  ( 1 ),
        .NO_OF_WRITE_CHANNELS ( 1 ) )
DDR_AXI4_ARBITER_PF_C0_0(
        // Inputs
        .reset_i          ( reset_i ),
        .sys_clk_i        ( sys_clk_i ),
        .ddr_ctrl_ready_i ( ddr_ctrl_ready_i ),
        .arready          ( arready ),
        .awready          ( awready ),
        .bid              ( bid ),
        .bresp            ( bresp ),
        .bvalid           ( bvalid ),
        .r0_burst_size_i  ( r0_burst_size_i ),
        .r0_req_i         ( r0_req_i ),
        .r0_rstart_addr_i ( r0_rstart_addr_i ),
        .r1_burst_size_i  ( r1_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .r1_req_i         ( GND_net ), // tied to 1'b0 from definition
        .r1_rstart_addr_i ( r1_rstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .r2_burst_size_i  ( r2_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .r2_req_i         ( GND_net ), // tied to 1'b0 from definition
        .r2_rstart_addr_i ( r2_rstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .r3_burst_size_i  ( r3_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .r3_req_i         ( GND_net ), // tied to 1'b0 from definition
        .r3_rstart_addr_i ( r3_rstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .r4_burst_size_i  ( r4_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .r4_req_i         ( GND_net ), // tied to 1'b0 from definition
        .r4_rstart_addr_i ( r4_rstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .r5_burst_size_i  ( r5_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .r5_req_i         ( GND_net ), // tied to 1'b0 from definition
        .r5_rstart_addr_i ( r5_rstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .r6_burst_size_i  ( r6_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .r6_req_i         ( GND_net ), // tied to 1'b0 from definition
        .r6_rstart_addr_i ( r6_rstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .r7_burst_size_i  ( r7_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .r7_req_i         ( GND_net ), // tied to 1'b0 from definition
        .r7_rstart_addr_i ( r7_rstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .rdata            ( rdata ),
        .rid              ( rid ),
        .rlast            ( rlast ),
        .rresp            ( rresp ),
        .rvalid           ( rvalid ),
        .w0_burst_size_i  ( w0_burst_size_i ),
        .w0_data_i        ( w0_data_i ),
        .w0_data_valid_i  ( w0_data_valid_i ),
        .w0_req_i         ( w0_req_i ),
        .w0_wstart_addr_i ( w0_wstart_addr_i ),
        .w1_burst_size_i  ( w1_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .w1_data_i        ( w1_data_i_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .w1_data_valid_i  ( GND_net ), // tied to 1'b0 from definition
        .w1_req_i         ( GND_net ), // tied to 1'b0 from definition
        .w1_wstart_addr_i ( w1_wstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .w2_burst_size_i  ( w2_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .w2_data_i        ( w2_data_i_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .w2_data_valid_i  ( GND_net ), // tied to 1'b0 from definition
        .w2_req_i         ( GND_net ), // tied to 1'b0 from definition
        .w2_wstart_addr_i ( w2_wstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .w3_burst_size_i  ( w3_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .w3_data_i        ( w3_data_i_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .w3_data_valid_i  ( GND_net ), // tied to 1'b0 from definition
        .w3_req_i         ( GND_net ), // tied to 1'b0 from definition
        .w3_wstart_addr_i ( w3_wstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .w4_burst_size_i  ( w4_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .w4_data_i        ( w4_data_i_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .w4_data_valid_i  ( GND_net ), // tied to 1'b0 from definition
        .w4_req_i         ( GND_net ), // tied to 1'b0 from definition
        .w4_wstart_addr_i ( w4_wstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .w5_burst_size_i  ( w5_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .w5_data_i        ( w5_data_i_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .w5_data_valid_i  ( GND_net ), // tied to 1'b0 from definition
        .w5_req_i         ( GND_net ), // tied to 1'b0 from definition
        .w5_wstart_addr_i ( w5_wstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .w6_burst_size_i  ( w6_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .w6_data_i        ( w6_data_i_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .w6_data_valid_i  ( GND_net ), // tied to 1'b0 from definition
        .w6_req_i         ( GND_net ), // tied to 1'b0 from definition
        .w6_wstart_addr_i ( w6_wstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .w7_burst_size_i  ( w7_burst_size_i_const_net_0 ), // tied to 8'h00 from definition
        .w7_data_i        ( w7_data_i_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .w7_data_valid_i  ( GND_net ), // tied to 1'b0 from definition
        .w7_req_i         ( GND_net ), // tied to 1'b0 from definition
        .w7_wstart_addr_i ( w7_wstart_addr_i_const_net_0 ), // tied to 32'h00000000 from definition
        .wready           ( wready ),
        .WDATA_I_0        ( WDATA_I_0_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .WVALID_I_0       ( GND_net ), // tied to 1'b0 from definition
        .AWADDR_I_0       ( AWADDR_I_0_const_net_0 ), // tied to 32'h00000000 from definition
        .AWVALID_I_0      ( GND_net ), // tied to 1'b0 from definition
        .AWSIZE_I_0       ( AWSIZE_I_0_const_net_0 ), // tied to 8'h00 from definition
        .WDATA_I_1        ( WDATA_I_1_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .WVALID_I_1       ( GND_net ), // tied to 1'b0 from definition
        .AWADDR_I_1       ( AWADDR_I_1_const_net_0 ), // tied to 32'h00000000 from definition
        .AWVALID_I_1      ( GND_net ), // tied to 1'b0 from definition
        .AWSIZE_I_1       ( AWSIZE_I_1_const_net_0 ), // tied to 8'h00 from definition
        .WDATA_I_2        ( WDATA_I_2_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .WVALID_I_2       ( GND_net ), // tied to 1'b0 from definition
        .AWADDR_I_2       ( AWADDR_I_2_const_net_0 ), // tied to 32'h00000000 from definition
        .AWVALID_I_2      ( GND_net ), // tied to 1'b0 from definition
        .AWSIZE_I_2       ( AWSIZE_I_2_const_net_0 ), // tied to 8'h00 from definition
        .WDATA_I_3        ( WDATA_I_3_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .WVALID_I_3       ( GND_net ), // tied to 1'b0 from definition
        .AWADDR_I_3       ( AWADDR_I_3_const_net_0 ), // tied to 32'h00000000 from definition
        .AWVALID_I_3      ( GND_net ), // tied to 1'b0 from definition
        .AWSIZE_I_3       ( AWSIZE_I_3_const_net_0 ), // tied to 8'h00 from definition
        .WDATA_I_4        ( WDATA_I_4_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .WVALID_I_4       ( GND_net ), // tied to 1'b0 from definition
        .AWADDR_I_4       ( AWADDR_I_4_const_net_0 ), // tied to 32'h00000000 from definition
        .AWVALID_I_4      ( GND_net ), // tied to 1'b0 from definition
        .AWSIZE_I_4       ( AWSIZE_I_4_const_net_0 ), // tied to 8'h00 from definition
        .WDATA_I_5        ( WDATA_I_5_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .WVALID_I_5       ( GND_net ), // tied to 1'b0 from definition
        .AWADDR_I_5       ( AWADDR_I_5_const_net_0 ), // tied to 32'h00000000 from definition
        .AWVALID_I_5      ( GND_net ), // tied to 1'b0 from definition
        .AWSIZE_I_5       ( AWSIZE_I_5_const_net_0 ), // tied to 8'h00 from definition
        .WDATA_I_6        ( WDATA_I_6_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .WVALID_I_6       ( GND_net ), // tied to 1'b0 from definition
        .AWADDR_I_6       ( AWADDR_I_6_const_net_0 ), // tied to 32'h00000000 from definition
        .AWVALID_I_6      ( GND_net ), // tied to 1'b0 from definition
        .AWSIZE_I_6       ( AWSIZE_I_6_const_net_0 ), // tied to 8'h00 from definition
        .WDATA_I_7        ( WDATA_I_7_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .WVALID_I_7       ( GND_net ), // tied to 1'b0 from definition
        .AWADDR_I_7       ( AWADDR_I_7_const_net_0 ), // tied to 32'h00000000 from definition
        .AWVALID_I_7      ( GND_net ), // tied to 1'b0 from definition
        .AWSIZE_I_7       ( AWSIZE_I_7_const_net_0 ), // tied to 8'h00 from definition
        .ARADDR_I_0       ( ARADDR_I_0_const_net_0 ), // tied to 32'h00000000 from definition
        .ARVALID_I_0      ( GND_net ), // tied to 1'b0 from definition
        .ARSIZE_I_0       ( ARSIZE_I_0_const_net_0 ), // tied to 8'h00 from definition
        .ARADDR_I_1       ( ARADDR_I_1_const_net_0 ), // tied to 32'h00000000 from definition
        .ARVALID_I_1      ( GND_net ), // tied to 1'b0 from definition
        .ARSIZE_I_1       ( ARSIZE_I_1_const_net_0 ), // tied to 8'h00 from definition
        .ARADDR_I_2       ( ARADDR_I_2_const_net_0 ), // tied to 32'h00000000 from definition
        .ARVALID_I_2      ( GND_net ), // tied to 1'b0 from definition
        .ARSIZE_I_2       ( ARSIZE_I_2_const_net_0 ), // tied to 8'h00 from definition
        .ARADDR_I_3       ( ARADDR_I_3_const_net_0 ), // tied to 32'h00000000 from definition
        .ARVALID_I_3      ( GND_net ), // tied to 1'b0 from definition
        .ARSIZE_I_3       ( ARSIZE_I_3_const_net_0 ), // tied to 8'h00 from definition
        .ARADDR_I_4       ( ARADDR_I_4_const_net_0 ), // tied to 32'h00000000 from definition
        .ARVALID_I_4      ( GND_net ), // tied to 1'b0 from definition
        .ARSIZE_I_4       ( ARSIZE_I_4_const_net_0 ), // tied to 8'h00 from definition
        .ARADDR_I_5       ( ARADDR_I_5_const_net_0 ), // tied to 32'h00000000 from definition
        .ARVALID_I_5      ( GND_net ), // tied to 1'b0 from definition
        .ARSIZE_I_5       ( ARSIZE_I_5_const_net_0 ), // tied to 8'h00 from definition
        .ARADDR_I_6       ( ARADDR_I_6_const_net_0 ), // tied to 32'h00000000 from definition
        .ARVALID_I_6      ( GND_net ), // tied to 1'b0 from definition
        .ARSIZE_I_6       ( ARSIZE_I_6_const_net_0 ), // tied to 8'h00 from definition
        .ARADDR_I_7       ( ARADDR_I_7_const_net_0 ), // tied to 32'h00000000 from definition
        .ARVALID_I_7      ( GND_net ), // tied to 1'b0 from definition
        .ARSIZE_I_7       ( ARSIZE_I_7_const_net_0 ), // tied to 8'h00 from definition
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
        .RDATA_O_0        (  ),
        .RVALID_O_0       (  ),
        .RLAST_O_0        (  ),
        .BUSER_O_r1       (  ),
        .ARREADY_O_1      (  ),
        .RDATA_O_1        (  ),
        .RVALID_O_1       (  ),
        .RLAST_O_1        (  ),
        .BUSER_O_r2       (  ),
        .ARREADY_O_2      (  ),
        .RDATA_O_2        (  ),
        .RVALID_O_2       (  ),
        .RLAST_O_2        (  ),
        .BUSER_O_r3       (  ),
        .ARREADY_O_3      (  ),
        .RDATA_O_3        (  ),
        .RVALID_O_3       (  ),
        .RLAST_O_3        (  ),
        .BUSER_O_r4       (  ),
        .ARREADY_O_4      (  ),
        .RDATA_O_4        (  ),
        .RVALID_O_4       (  ),
        .RLAST_O_4        (  ),
        .BUSER_O_r5       (  ),
        .ARREADY_O_5      (  ),
        .RDATA_O_5        (  ),
        .RVALID_O_5       (  ),
        .RLAST_O_5        (  ),
        .BUSER_O_r6       (  ),
        .ARREADY_O_6      (  ),
        .RDATA_O_6        (  ),
        .RVALID_O_6       (  ),
        .RLAST_O_6        (  ),
        .BUSER_O_r7       (  ),
        .ARREADY_O_7      (  ),
        .RDATA_O_7        (  ),
        .RVALID_O_7       (  ),
        .RLAST_O_7        (  ),
        .araddr           ( MIRRORED_SLAVE_AXI4_ARADDR ),
        .arburst          ( MIRRORED_SLAVE_AXI4_ARBURST ),
        .arcache          ( MIRRORED_SLAVE_AXI4_ARCACHE ),
        .arid             ( MIRRORED_SLAVE_AXI4_ARID ),
        .arlen            ( MIRRORED_SLAVE_AXI4_ARLEN ),
        .arlock           ( MIRRORED_SLAVE_AXI4_ARLOCK ),
        .arprot           ( MIRRORED_SLAVE_AXI4_ARPROT ),
        .arsize           ( MIRRORED_SLAVE_AXI4_ARSIZE ),
        .arvalid          ( MIRRORED_SLAVE_AXI4_ARVALID ),
        .awaddr           ( MIRRORED_SLAVE_AXI4_AWADDR ),
        .awburst          ( MIRRORED_SLAVE_AXI4_AWBURST ),
        .awcache          ( MIRRORED_SLAVE_AXI4_AWCACHE ),
        .awid             ( MIRRORED_SLAVE_AXI4_AWID ),
        .awlen            ( MIRRORED_SLAVE_AXI4_AWLEN ),
        .awlock           ( MIRRORED_SLAVE_AXI4_AWLOCK ),
        .awprot           ( MIRRORED_SLAVE_AXI4_AWPROT ),
        .awsize           ( MIRRORED_SLAVE_AXI4_AWSIZE ),
        .awvalid          ( MIRRORED_SLAVE_AXI4_AWVALID ),
        .bready           ( MIRRORED_SLAVE_AXI4_BREADY ),
        .r0_ack_o         ( r0_ack_o_net_0 ),
        .r0_data_valid_o  ( r0_data_valid_o_net_0 ),
        .r0_done_o        ( r0_done_o_net_0 ),
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
        .rdata_o          ( rdata_o_net_0 ),
        .rready           ( MIRRORED_SLAVE_AXI4_RREADY ),
        .w0_ack_o         ( w0_ack_o_net_0 ),
        .w0_done_o        ( w0_done_o_net_0 ),
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
        .wdata            ( MIRRORED_SLAVE_AXI4_WDATA ),
        .wlast            ( MIRRORED_SLAVE_AXI4_WLAST ),
        .wstrb            ( MIRRORED_SLAVE_AXI4_WSTRB ),
        .wvalid           ( MIRRORED_SLAVE_AXI4_WVALID ) 
        );


endmodule
