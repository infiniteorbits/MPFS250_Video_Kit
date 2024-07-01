//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Wed May 22 10:33:18 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// h264_top
module h264_top(
    // Inputs
    arready,
    awready,
    bid,
    bresp,
    bvalid,
    clr_intr_i,
    data_c_i,
    data_valid_i,
    data_y_i,
    ddr_ctrl_ready_i,
    eof_i,
    fic_clk,
    frame_ddr_addr_i,
    frame_valid_i,
    h264_encoder_en,
    hres_i,
    pclk_i,
    qp_i,
    rdata,
    read_reset_i,
    resetn_i,
    rid,
    rlast,
    rresp,
    rvalid,
    sys_clk_i,
    vres_i,
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
    frame_bytes_o,
    frame_index_o,
    frm_interrupt_o,
    rready,
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
input         clr_intr_i;
input  [7:0]  data_c_i;
input         data_valid_i;
input  [7:0]  data_y_i;
input         ddr_ctrl_ready_i;
input         eof_i;
input         fic_clk;
input  [9:0]  frame_ddr_addr_i;
input         frame_valid_i;
input         h264_encoder_en;
input  [15:0] hres_i;
input         pclk_i;
input  [5:0]  qp_i;
input  [63:0] rdata;
input         read_reset_i;
input         resetn_i;
input  [3:0]  rid;
input         rlast;
input  [1:0]  rresp;
input         rvalid;
input         sys_clk_i;
input  [15:0] vres_i;
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
output [31:0] frame_bytes_o;
output [1:0]  frame_index_o;
output        frm_interrupt_o;
output        rready;
output [63:0] wdata;
output        wlast;
output [63:0] wstrb;
output        wvalid;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          AND2_0_Y;
wire   [31:0] BIF_1_ARADDR;
wire   [1:0]  BIF_1_ARBURST;
wire   [3:0]  BIF_1_ARCACHE;
wire   [3:0]  BIF_1_ARID;
wire   [7:0]  BIF_1_ARLEN;
wire   [1:0]  BIF_1_ARLOCK;
wire   [2:0]  BIF_1_ARPROT;
wire          arready;
wire   [2:0]  BIF_1_ARSIZE;
wire          BIF_1_ARVALID;
wire   [31:0] BIF_1_AWADDR;
wire   [1:0]  BIF_1_AWBURST;
wire   [3:0]  BIF_1_AWCACHE;
wire   [3:0]  BIF_1_AWID;
wire   [7:0]  BIF_1_AWLEN;
wire   [1:0]  BIF_1_AWLOCK;
wire   [2:0]  BIF_1_AWPROT;
wire          awready;
wire   [2:0]  BIF_1_AWSIZE;
wire          BIF_1_AWVALID;
wire   [3:0]  bid;
wire          BIF_1_BREADY;
wire   [1:0]  bresp;
wire          bvalid;
wire   [63:0] rdata;
wire   [3:0]  rid;
wire          rlast;
wire          BIF_1_RREADY;
wire   [1:0]  rresp;
wire          rvalid;
wire   [63:0] BIF_1_WDATA;
wire          BIF_1_WLAST;
wire          wready;
wire   [7:0]  BIF_1_WSTRB;
wire          BIF_1_WVALID;
wire          clr_intr_i;
wire   [7:0]  data_c_i;
wire          data_valid_i;
wire   [7:0]  data_y_i;
wire          DDR_AXI4_ARBITER_PF_C0_0_w0_ack_o;
wire          DDR_AXI4_ARBITER_PF_C0_0_w0_done_o;
wire          ddr_ctrl_ready_i;
wire          eof_i;
wire          fic_clk;
wire   [31:0] frame_bytes_o_net_0;
wire   [9:0]  frame_ddr_addr_i;
wire   [1:0]  frame_index_o_net_0;
wire          frame_valid_i;
wire          frm_interrupt_o_net_0;
wire   [63:0] H264_DDR_WRITE_64_rdata_o;
wire          H264_DDR_WRITE_64_rdata_rdy_o;
wire   [7:0]  H264_DDR_WRITE_64_write_length_o;
wire          H264_DDR_WRITE_64_write_req_o;
wire   [31:0] H264_DDR_WRITE_64_write_start_addr_o;
wire          h264_encoder_en;
wire   [15:0] H264_Iframe_Encoder_C0_0_DATA_O;
wire          H264_Iframe_Encoder_C0_0_DATA_VALID_O;
wire   [15:0] hres_i;
wire          pclk_i;
wire   [5:0]  qp_i;
wire          read_reset_i;
wire          resetn_i;
wire          sys_clk_i;
wire   [15:0] vres_i;
wire          BIF_1_ARVALID_net_0;
wire          BIF_1_AWVALID_net_0;
wire          BIF_1_BREADY_net_0;
wire          frm_interrupt_o_net_1;
wire          BIF_1_RREADY_net_0;
wire          BIF_1_WLAST_net_0;
wire          BIF_1_WVALID_net_0;
wire   [31:0] BIF_1_ARADDR_net_0;
wire   [1:0]  BIF_1_ARBURST_net_0;
wire   [3:0]  BIF_1_ARCACHE_net_0;
wire   [3:0]  BIF_1_ARID_net_0;
wire   [7:0]  BIF_1_ARLEN_net_0;
wire   [1:0]  BIF_1_ARLOCK_net_0;
wire   [2:0]  BIF_1_ARPROT_net_0;
wire   [2:0]  BIF_1_ARSIZE_net_0;
wire   [31:0] BIF_1_AWADDR_net_0;
wire   [1:0]  BIF_1_AWBURST_net_0;
wire   [3:0]  BIF_1_AWCACHE_net_0;
wire   [3:0]  BIF_1_AWID_net_0;
wire   [7:0]  BIF_1_AWLEN_net_0;
wire   [1:0]  BIF_1_AWLOCK_net_0;
wire   [2:0]  BIF_1_AWPROT_net_0;
wire   [2:0]  BIF_1_AWSIZE_net_0;
wire   [31:0] frame_bytes_o_net_1;
wire   [1:0]  frame_index_o_net_1;
wire   [63:0] BIF_1_WDATA_net_0;
wire   [63:0] BIF_1_WSTRB_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [7:0]  r0_burst_size_i_const_net_0;
wire          GND_net;
wire   [31:0] r0_rstart_addr_i_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign r0_burst_size_i_const_net_0  = 8'h00;
assign GND_net                      = 1'b0;
assign r0_rstart_addr_i_const_net_0 = 32'h00000000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign BIF_1_ARVALID_net_0   = BIF_1_ARVALID;
assign arvalid               = BIF_1_ARVALID_net_0;
assign BIF_1_AWVALID_net_0   = BIF_1_AWVALID;
assign awvalid               = BIF_1_AWVALID_net_0;
assign BIF_1_BREADY_net_0    = BIF_1_BREADY;
assign bready                = BIF_1_BREADY_net_0;
assign frm_interrupt_o_net_1 = frm_interrupt_o_net_0;
assign frm_interrupt_o       = frm_interrupt_o_net_1;
assign BIF_1_RREADY_net_0    = BIF_1_RREADY;
assign rready                = BIF_1_RREADY_net_0;
assign BIF_1_WLAST_net_0     = BIF_1_WLAST;
assign wlast                 = BIF_1_WLAST_net_0;
assign BIF_1_WVALID_net_0    = BIF_1_WVALID;
assign wvalid                = BIF_1_WVALID_net_0;
assign BIF_1_ARADDR_net_0    = BIF_1_ARADDR;
assign araddr[31:0]          = BIF_1_ARADDR_net_0;
assign BIF_1_ARBURST_net_0   = BIF_1_ARBURST;
assign arburst[1:0]          = BIF_1_ARBURST_net_0;
assign BIF_1_ARCACHE_net_0   = BIF_1_ARCACHE;
assign arcache[3:0]          = BIF_1_ARCACHE_net_0;
assign BIF_1_ARID_net_0      = BIF_1_ARID;
assign arid[3:0]             = BIF_1_ARID_net_0;
assign BIF_1_ARLEN_net_0     = BIF_1_ARLEN;
assign arlen[7:0]            = BIF_1_ARLEN_net_0;
assign BIF_1_ARLOCK_net_0    = BIF_1_ARLOCK;
assign arlock[1:0]           = BIF_1_ARLOCK_net_0;
assign BIF_1_ARPROT_net_0    = BIF_1_ARPROT;
assign arprot[2:0]           = BIF_1_ARPROT_net_0;
assign BIF_1_ARSIZE_net_0    = BIF_1_ARSIZE;
assign arsize[2:0]           = BIF_1_ARSIZE_net_0;
assign BIF_1_AWADDR_net_0    = BIF_1_AWADDR;
assign awaddr[31:0]          = BIF_1_AWADDR_net_0;
assign BIF_1_AWBURST_net_0   = BIF_1_AWBURST;
assign awburst[1:0]          = BIF_1_AWBURST_net_0;
assign BIF_1_AWCACHE_net_0   = BIF_1_AWCACHE;
assign awcache[3:0]          = BIF_1_AWCACHE_net_0;
assign BIF_1_AWID_net_0      = BIF_1_AWID;
assign awid[3:0]             = BIF_1_AWID_net_0;
assign BIF_1_AWLEN_net_0     = BIF_1_AWLEN;
assign awlen[7:0]            = BIF_1_AWLEN_net_0;
assign BIF_1_AWLOCK_net_0    = BIF_1_AWLOCK;
assign awlock[1:0]           = BIF_1_AWLOCK_net_0;
assign BIF_1_AWPROT_net_0    = BIF_1_AWPROT;
assign awprot[2:0]           = BIF_1_AWPROT_net_0;
assign BIF_1_AWSIZE_net_0    = BIF_1_AWSIZE;
assign awsize[2:0]           = BIF_1_AWSIZE_net_0;
assign frame_bytes_o_net_1   = frame_bytes_o_net_0;
assign frame_bytes_o[31:0]   = frame_bytes_o_net_1;
assign frame_index_o_net_1   = frame_index_o_net_0;
assign frame_index_o[1:0]    = frame_index_o_net_1;
assign BIF_1_WDATA_net_0     = BIF_1_WDATA;
assign wdata[63:0]           = BIF_1_WDATA_net_0;
assign BIF_1_WSTRB_net_0     = BIF_1_WSTRB;
assign wstrb[63:0]           = BIF_1_WSTRB_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_0(
        // Inputs
        .A ( resetn_i ),
        .B ( h264_encoder_en ),
        // Outputs
        .Y ( AND2_0_Y ) 
        );

//--------DDR_AXI4_ARBITER_PF_C0
DDR_AXI4_ARBITER_PF_C0 DDR_AXI4_ARBITER_PF_C0_0(
        // Inputs
        .reset_i          ( read_reset_i ),
        .sys_clk_i        ( fic_clk ),
        .ddr_ctrl_ready_i ( ddr_ctrl_ready_i ),
        .r0_burst_size_i  ( r0_burst_size_i_const_net_0 ),
        .r0_req_i         ( GND_net ),
        .r0_rstart_addr_i ( r0_rstart_addr_i_const_net_0 ),
        .w0_burst_size_i  ( H264_DDR_WRITE_64_write_length_o ),
        .w0_data_i        ( H264_DDR_WRITE_64_rdata_o ),
        .w0_data_valid_i  ( H264_DDR_WRITE_64_rdata_rdy_o ),
        .w0_req_i         ( H264_DDR_WRITE_64_write_req_o ),
        .w0_wstart_addr_i ( H264_DDR_WRITE_64_write_start_addr_o ),
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
        // Outputs
        .r0_ack_o         (  ),
        .r0_data_valid_o  (  ),
        .r0_done_o        (  ),
        .rdata_o          (  ),
        .w0_ack_o         ( DDR_AXI4_ARBITER_PF_C0_0_w0_ack_o ),
        .w0_done_o        ( DDR_AXI4_ARBITER_PF_C0_0_w0_done_o ),
        .awid             ( BIF_1_AWID ),
        .awaddr           ( BIF_1_AWADDR ),
        .awlen            ( BIF_1_AWLEN ),
        .awsize           ( BIF_1_AWSIZE ),
        .awburst          ( BIF_1_AWBURST ),
        .awlock           ( BIF_1_AWLOCK ),
        .awcache          ( BIF_1_AWCACHE ),
        .awprot           ( BIF_1_AWPROT ),
        .awvalid          ( BIF_1_AWVALID ),
        .wdata            ( BIF_1_WDATA ),
        .wstrb            ( BIF_1_WSTRB ),
        .wlast            ( BIF_1_WLAST ),
        .wvalid           ( BIF_1_WVALID ),
        .bready           ( BIF_1_BREADY ),
        .arid             ( BIF_1_ARID ),
        .araddr           ( BIF_1_ARADDR ),
        .arlen            ( BIF_1_ARLEN ),
        .arsize           ( BIF_1_ARSIZE ),
        .arburst          ( BIF_1_ARBURST ),
        .arlock           ( BIF_1_ARLOCK ),
        .arcache          ( BIF_1_ARCACHE ),
        .arprot           ( BIF_1_ARPROT ),
        .arvalid          ( BIF_1_ARVALID ),
        .rready           ( BIF_1_RREADY ) 
        );

//--------H264_DDR_WRITE
H264_DDR_WRITE H264_DDR_WRITE_64(
        // Inputs
        .clr_intr_i         ( clr_intr_i ),
        .data_valid_i       ( H264_Iframe_Encoder_C0_0_DATA_VALID_O ),
        .ddr_clk_i          ( fic_clk ),
        .frame_end_i        ( eof_i ),
        .h264_clk_i         ( sys_clk_i ),
        .h264_encoder_en_i  ( h264_encoder_en ),
        .pclk_i             ( pclk_i ),
        .reset_i            ( read_reset_i ),
        .write_ackn_i       ( DDR_AXI4_ARBITER_PF_C0_0_w0_ack_o ),
        .write_done_i       ( DDR_AXI4_ARBITER_PF_C0_0_w0_done_o ),
        .data_i             ( H264_Iframe_Encoder_C0_0_DATA_O ),
        .frame_ddr_addr_i   ( frame_ddr_addr_i ),
        // Outputs
        .frm_interrupt_o    ( frm_interrupt_o_net_0 ),
        .rdata_rdy_o        ( H264_DDR_WRITE_64_rdata_rdy_o ),
        .write_req_o        ( H264_DDR_WRITE_64_write_req_o ),
        .frame_bytes_o      ( frame_bytes_o_net_0 ),
        .frame_index_o      ( frame_index_o_net_0 ),
        .rdata_o            ( H264_DDR_WRITE_64_rdata_o ),
        .write_length_o     ( H264_DDR_WRITE_64_write_length_o ),
        .write_start_addr_o ( H264_DDR_WRITE_64_write_start_addr_o ) 
        );

//--------H264_Iframe_Encoder_C0
H264_Iframe_Encoder_C0 H264_Iframe_Encoder_C0_0(
        // Inputs
        .RESET_N       ( AND2_0_Y ),
        .PIX_CLK       ( sys_clk_i ),
        .VRES_I        ( vres_i ),
        .HRES_I        ( hres_i ),
        .QP_I          ( qp_i ),
        .FRAME_START_I ( frame_valid_i ),
        .FRAME_END_I   ( eof_i ),
        .DATA_VALID_I  ( data_valid_i ),
        .DATA_Y_I      ( data_y_i ),
        .DATA_C_I      ( data_c_i ),
        // Outputs
        .DATA_VALID_O  ( H264_Iframe_Encoder_C0_0_DATA_VALID_O ),
        .DATA_O        ( H264_Iframe_Encoder_C0_0_DATA_O ) 
        );


endmodule
