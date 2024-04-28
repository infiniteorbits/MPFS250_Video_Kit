//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Jan  9 17:00:58 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// vdma_dma_top
module vdma_dma_top #(parameter g_IP_DW = 16,
		      parameter g_OP_DW = 64)
(
    // Inputs
    araddr,
    arvalid,
    awaddr,
    awvalid,
    bready,
    rready,
    wdata,
    wvalid,
    aclk,
    aclk_rstn,
    data_i,
    data_valid_i,
    ddr_clk_i,
    ddr_clk_rstn_i,
    frame_start_i,
    video_clk_i,
    video_clk_rstn_i,
    write_ackn_i,
    write_done_i,
    // Outputs
    arready,
    awready,
    bresp,
    bvalid,
    rdata,
    rresp,
    rvalid,
    wready,
    int_dma,
    rdata_o,
    rdata_rdy_o,
    write_length_o,
    write_req_o,
    write_start_addr_o
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] araddr;
input         arvalid;
input  [31:0] awaddr;
input         awvalid;
input         bready;
input         rready;
input  [31:0] wdata;
input         wvalid;
input         aclk;
input         aclk_rstn;
input  [15:0] data_i;
input         data_valid_i;
input         ddr_clk_i;
input         ddr_clk_rstn_i;
input         frame_start_i;
input         video_clk_i;
input         video_clk_rstn_i;
input         write_ackn_i;
input         write_done_i;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        arready;
output        awready;
output [1:0]  bresp;
output        bvalid;
output [31:0] rdata;
output [1:0]  rresp;
output        rvalid;
output        wready;
output        int_dma;
output [63:0] rdata_o;
output        rdata_rdy_o;
output [7:0]  write_length_o;
output        write_req_o;
output [37:0] write_start_addr_o;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          aclk;
wire          aclk_rstn;
wire   [31:0] araddr;
wire          ARREADY_net_0;
wire          arvalid;
wire   [31:0] awaddr;
wire          AWREADY_net_0;
wire          awvalid;
wire          bready;
wire   [1:0]  BRESP_net_0;
wire          BVALID_net_0;
wire   [31:0] RDATA_net_0;
wire          rready;
wire   [1:0]  RRESP_net_0;
wire          RVALID_net_0;
wire   [31:0] wdata;
wire          WREADY_net_0;
wire          wvalid;
wire   [31:0] axi4lite_regmap_dma_0_buff_addr_fifo_data;
wire          axi4lite_regmap_dma_0_buff_addr_fifo_wen;
wire          axi4lite_regmap_dma_0_fifo_rstn;
wire          axi4lite_regmap_dma_0_frame_size_fifo_ren;
wire          axi4lite_regmap_dma_0_glbl_int_en;
wire   [4:0]  axi4lite_regmap_dma_0_interrupt_en;
wire   [4:0]  axi4lite_regmap_dma_0_interrupt_status_clr;
wire          axi4lite_regmap_dma_0_ip_en;
wire          axi4lite_regmap_dma_0_ip_rstn;
wire   [15:0] data_i;
wire          data_valid_i;
wire          ddr_clk_i;
wire          ddr_clk_rstn_i;
wire          frame_start_i;
wire          int_dma_0;
wire   [4:0]  interrupt_controller_vdma_0_status_reg_o;
wire   [63:0] rdata_o_0;
wire          rdata_rdy_o_0;
wire          vdma_ip_reset_0_aclk_rstn_o;
wire          vdma_ip_reset_0_ddr_clk_rstn_o;
wire          vdma_ip_reset_0_fifo_rstn_o;
wire          vdma_ip_reset_0_video_source_clk_rstn_o;
wire          vdma_write_0_buff_addr_fifo_empty_o;
wire          vdma_write_0_buff_addr_fifo_full_o;
wire          vdma_write_0_frame_size_fifo_empty_o;
wire          vdma_write_0_frame_size_fifo_full_o;
wire   [31:0] vdma_write_0_frame_size_o;
wire          vdma_write_0_int_dma_o;
wire          video_clk_i;
wire          video_clk_rstn_i;
wire          write_ackn_i;
wire          write_done_i;
wire   [7:0]  write_length_o_0;
wire          write_req_o_0;
wire   [37:0] write_start_addr_o_0;
wire          rdata_rdy_o_0_net_0;
wire          write_req_o_0_net_0;
wire          int_dma_0_net_0;
wire   [7:0]  write_length_o_0_net_0;
wire   [63:0] rdata_o_0_net_0;
wire   [37:0] write_start_addr_o_0_net_0;
wire          AWREADY_net_1;
wire          WREADY_net_1;
wire   [1:0]  BRESP_net_1;
wire          BVALID_net_1;
wire          ARREADY_net_1;
wire   [31:0] RDATA_net_1;
wire   [1:0]  RRESP_net_1;
wire          RVALID_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign rdata_rdy_o_0_net_0        = rdata_rdy_o_0;
assign rdata_rdy_o                = rdata_rdy_o_0_net_0;
assign write_req_o_0_net_0        = write_req_o_0;
assign write_req_o                = write_req_o_0_net_0;
assign int_dma_0_net_0            = int_dma_0;
assign int_dma                    = int_dma_0_net_0;
assign write_length_o_0_net_0     = write_length_o_0;
assign write_length_o[7:0]        = write_length_o_0_net_0;
assign rdata_o_0_net_0            = rdata_o_0;
assign rdata_o[63:0]              = rdata_o_0_net_0;
assign write_start_addr_o_0_net_0 = write_start_addr_o_0;
assign write_start_addr_o[37:0]   = write_start_addr_o_0_net_0;
assign AWREADY_net_1    = AWREADY_net_0;
assign awready          = AWREADY_net_1;
assign WREADY_net_1     = WREADY_net_0;
assign wready           = WREADY_net_1;
assign BRESP_net_1      = BRESP_net_0;
assign bresp[1:0]       = BRESP_net_1;
assign BVALID_net_1     = BVALID_net_0;
assign bvalid           = BVALID_net_1;
assign ARREADY_net_1    = ARREADY_net_0;
assign arready          = ARREADY_net_1;
assign RDATA_net_1      = RDATA_net_0;
assign rdata[31:0]      = RDATA_net_1;
assign RRESP_net_1      = RRESP_net_0;
assign rresp[1:0]       = RRESP_net_1;
assign RVALID_net_1     = RVALID_net_0;
assign rvalid           = RVALID_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------axi4lite_if_dma
axi4lite_if_vdma axi4lite_regmap_vdma_0(
        // Inputs
        .aclk                  ( aclk ),
        .aresetn               ( aclk_rstn  ),
        .soft_aresetn (vdma_ip_reset_0_aclk_rstn_o),
        .awvalid               ( awvalid ),
        .awaddr                ( awaddr ),
        .wdata                 ( wdata ),
        .wvalid                ( wvalid ),
        .bready                ( bready ),
        .araddr                ( araddr ),
        .arvalid               ( arvalid ),
        .rready                ( rready ),
        .frame_size_fifo_empty ( vdma_write_0_frame_size_fifo_empty_o ),
        .frame_size_fifo       ( vdma_write_0_frame_size_o ),
        .interrupt_status      ( interrupt_controller_vdma_0_status_reg_o ),
        // Outputs
        .awready               ( awready ),
        .wready                ( wready ),
        .bresp                 ( bresp ),
        .bvalid                ( bvalid ),
        .arready               ( arready ),
        .rdata                 ( rdata ),
        .rresp                 ( rresp ),
        .rvalid                ( rvalid ),
        .frame_size_fifo_ren   ( axi4lite_regmap_dma_0_frame_size_fifo_ren ),
        .buff_addr_fifo_wen    ( axi4lite_regmap_dma_0_buff_addr_fifo_wen ),
        .buff_addr_fifo_data   ( axi4lite_regmap_dma_0_buff_addr_fifo_data ),
        .interrupt_status_clr  ( axi4lite_regmap_dma_0_interrupt_status_clr ),
        .interrupt_en          ( axi4lite_regmap_dma_0_interrupt_en ),
        .glbl_int_en           ( axi4lite_regmap_dma_0_glbl_int_en ),
        .fifo_rstn             ( axi4lite_regmap_dma_0_fifo_rstn ),
        .ip_rstn               ( axi4lite_regmap_dma_0_ip_rstn ),
        .ip_en                 ( axi4lite_regmap_dma_0_ip_en ) 
        );

//--------interrupt_controller_vdma
interrupt_controller_vdma interrupt_controller_vdma_0(
        // Inputs
        .rstn_i                  ( vdma_ip_reset_0_aclk_rstn_o ),
        .sys_clk_i               ( aclk ),
        .frame_end_interrupt_i   ( vdma_write_0_int_dma_o ),
        .buff_addr_fifo_full_i   ( vdma_write_0_buff_addr_fifo_full_o ),
        .buff_addr_fifo_empty_i  ( vdma_write_0_buff_addr_fifo_empty_o ),
        .frame_size_fifo_full_i  ( vdma_write_0_frame_size_fifo_full_o ),
        .frame_size_fifo_empty_i ( vdma_write_0_frame_size_fifo_empty_o ),
        .global_interrupt_en_i   ( axi4lite_regmap_dma_0_glbl_int_en ),
        .vdma_ip_en_i            ( axi4lite_regmap_dma_0_ip_en ),
        .interrupt_en_i          ( axi4lite_regmap_dma_0_interrupt_en ),
        .interrupt_clear_i       ( axi4lite_regmap_dma_0_interrupt_status_clr ),
        // Outputs
        .interrupt_o             ( int_dma_0 ),
        .status_reg_o            ( interrupt_controller_vdma_0_status_reg_o ),
        .interrupt_overflow_o    (  ) 
        );

//--------vdma_ip_reset
vdma_ip_reset vdma_ip_reset_0(
        // Inputs
        .video_source_clk_rstn_i ( video_clk_rstn_i ),
        .video_source_clk_i      ( video_clk_i ),
        .ddr_clk_rstn_i          ( ddr_clk_rstn_i ),
        .ddr_clk_i               ( ddr_clk_i ),
        .aclk_i                  ( aclk ),
        .aclk_rstn_i             ( aclk_rstn ),
        .fifo_rstn_i             ( axi4lite_regmap_dma_0_fifo_rstn ),
        .vdma_ip_rstn_i          ( axi4lite_regmap_dma_0_ip_rstn ),
        // Outputs
        .aclk_rstn_o             ( vdma_ip_reset_0_aclk_rstn_o ),
        .ddr_clk_rstn_o          ( vdma_ip_reset_0_ddr_clk_rstn_o ),
        .fifo_rstn_o             ( vdma_ip_reset_0_fifo_rstn_o ),
        .video_source_clk_rstn_o ( vdma_ip_reset_0_video_source_clk_rstn_o ) 
        );

//--------vdma_write
vdma_write #( 
        .g_IP_DW ( g_IP_DW ),
        .g_OP_DW ( g_OP_DW ) )
vdma_write_0(
        // Inputs
        .video_source_clk_rstn_i ( vdma_ip_reset_0_video_source_clk_rstn_o ),
        .video_source_clk_i      ( video_clk_i ),
        .ddr_clk_rstn_i          ( vdma_ip_reset_0_ddr_clk_rstn_o ),
        .ddr_clk_i               ( ddr_clk_i ),
        .aclk_i                  ( aclk ),
        .aclk_rstn_i             ( vdma_ip_reset_0_aclk_rstn_o ),
        .fifo_rstn_i             ( vdma_ip_reset_0_fifo_rstn_o ),
        .vdma_ip_en_i            ( axi4lite_regmap_dma_0_ip_en ),
        .frame_start_i           ( frame_start_i ),
        .frame_size_fifo_rd_i    ( axi4lite_regmap_dma_0_frame_size_fifo_ren ),
        .write_done_i            ( write_done_i ),
        .write_ackn_i            ( write_ackn_i ),
        .buff_addr_fifo_wr_i     ( axi4lite_regmap_dma_0_buff_addr_fifo_wen ),
        .data_valid_i            ( data_valid_i ),
        .buff_addr_fifo_data_i   ( axi4lite_regmap_dma_0_buff_addr_fifo_data ),
        .data_i                  ( data_i ),
        // Outputs
        .frame_size_fifo_empty_o ( vdma_write_0_frame_size_fifo_empty_o ),
        .frame_size_fifo_full_o  ( vdma_write_0_frame_size_fifo_full_o ),
        .buff_addr_fifo_empty_o  ( vdma_write_0_buff_addr_fifo_empty_o ),
        .buff_addr_fifo_full_o   ( vdma_write_0_buff_addr_fifo_full_o ),
        .write_req_o             ( write_req_o_0 ),
        .int_dma_o               ( vdma_write_0_int_dma_o ),
        .data_valid_o            ( rdata_rdy_o_0 ),
        .write_length_o          ( write_length_o_0 ),
        .frame_size_o            ( vdma_write_0_frame_size_o ),
        .data_o                  ( rdata_o_0 ),
        .write_start_addr_o      ( write_start_addr_o_0 ) 
        );


endmodule
