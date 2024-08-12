//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Aug 12 21:25:04 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// H264_DDR_WRITE
module H264_DDR_WRITE(
    // Inputs
    clr_intr_i,
    data_i,
    data_valid_i,
    ddr_clk_i,
    frame_ddr_addr_i,
    frame_end_i,
    h264_clk_i,
    h264_encoder_en_i,
    pclk_i,
    reset_i,
    write_ackn_i,
    write_done_i,
    // Outputs
    frame_bytes_o,
    frame_index_o,
    frm_interrupt_o,
    rdata_o,
    rdata_rdy_o,
    write_length_o,
    write_req_o,
    write_start_addr_o
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         clr_intr_i;
input  [15:0] data_i;
input         data_valid_i;
input         ddr_clk_i;
input  [9:0]  frame_ddr_addr_i;
input         frame_end_i;
input         h264_clk_i;
input         h264_encoder_en_i;
input         pclk_i;
input         reset_i;
input         write_ackn_i;
input         write_done_i;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] frame_bytes_o;
output [1:0]  frame_index_o;
output        frm_interrupt_o;
output [63:0] rdata_o;
output        rdata_rdy_o;
output [7:0]  write_length_o;
output        write_req_o;
output [31:0] write_start_addr_o;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          AND2_1_Y;
wire          clr_intr_i;
wire   [15:8] data_i_slice_0;
wire   [7:0]  data_i_slice_1;
wire   [63:0] data_packer_h264_0_data_o;
wire          data_packer_h264_0_data_valid_o;
wire          data_packer_h264_0_frame_end_o;
wire          data_valid_i;
wire          ddr_clk_i;
wire          ddr_write_controller_enc_0_fifo_reset_o;
wire          ddr_write_controller_enc_0_read_fifo_o;
wire   [31:0] frame_bytes_o_net_0;
wire   [9:0]  frame_ddr_addr_i;
wire          frame_end_i;
wire   [1:0]  frame_index_o_net_0;
wire          frm_interrupt_o_net_0;
wire          h264_clk_i;
wire          h264_encoder_en_i;
wire          pclk_i;
wire   [63:0] rdata_o_net_0;
wire          rdata_rdy_o_net_0;
wire          reset_i;
wire   [11:0] video_fifo_0_rdata_count_o;
wire          write_ackn_i;
wire          write_done_i;
wire   [7:0]  write_length_o_net_0;
wire          write_req_o_net_0;
wire   [31:0] write_start_addr_o_net_0;
wire          frm_interrupt_o_net_1;
wire          rdata_rdy_o_net_1;
wire          write_req_o_net_1;
wire   [31:0] frame_bytes_o_net_1;
wire   [1:0]  frame_index_o_net_1;
wire   [63:0] rdata_o_net_1;
wire   [7:0]  write_length_o_net_1;
wire   [31:0] write_start_addr_o_net_1;
wire   [15:0] data_i;
wire   [15:0] data_i_net_0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign frm_interrupt_o_net_1    = frm_interrupt_o_net_0;
assign frm_interrupt_o          = frm_interrupt_o_net_1;
assign rdata_rdy_o_net_1        = rdata_rdy_o_net_0;
assign rdata_rdy_o              = rdata_rdy_o_net_1;
assign write_req_o_net_1        = write_req_o_net_0;
assign write_req_o              = write_req_o_net_1;
assign frame_bytes_o_net_1      = frame_bytes_o_net_0;
assign frame_bytes_o[31:0]      = frame_bytes_o_net_1;
assign frame_index_o_net_1      = frame_index_o_net_0;
assign frame_index_o[1:0]       = frame_index_o_net_1;
assign rdata_o_net_1            = rdata_o_net_0;
assign rdata_o[63:0]            = rdata_o_net_1;
assign write_length_o_net_1     = write_length_o_net_0;
assign write_length_o[7:0]      = write_length_o_net_1;
assign write_start_addr_o_net_1 = write_start_addr_o_net_0;
assign write_start_addr_o[31:0] = write_start_addr_o_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign data_i_slice_0 = data_i[15:8];
assign data_i_slice_1 = data_i[7:0];
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign data_i_net_0 = { data_i_slice_1 , data_i_slice_0 };
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_1(
        // Inputs
        .A ( reset_i ),
        .B ( ddr_write_controller_enc_0_fifo_reset_o ),
        // Outputs
        .Y ( AND2_1_Y ) 
        );

//--------data_packer_h264
data_packer_h264 #( 
        .g_IP_DW ( 16 ),
        .g_OP_DW ( 64 ) )
data_packer_h264_0(
        // Inputs
        .reset_i      ( h264_encoder_en_i ),
        .sys_clk_i    ( h264_clk_i ),
        .data_valid_i ( data_valid_i ),
        .frame_end_i  ( frame_end_i ),
        .data_i       ( data_i_net_0 ),
        // Outputs
        .data_valid_o ( data_packer_h264_0_data_valid_o ),
        .frame_end_o  ( data_packer_h264_0_frame_end_o ),
        .data_o       ( data_packer_h264_0_data_o ) 
        );

//--------ddr_write_controller_enc
ddr_write_controller_enc ddr_write_controller_enc_0(
        // Inputs
        .reset_i            ( reset_i ),
        .sys_clk_i          ( ddr_clk_i ),
        .wrclk_reset_i      ( reset_i ),
        .wrclk_i            ( h264_clk_i ),
        .pclk_i             ( pclk_i ),
        .fifo_count_i       ( video_fifo_0_rdata_count_o ),
        .eof_i              ( data_packer_h264_0_frame_end_o ),
        .encoder_en_i       ( h264_encoder_en_i ),
        .clr_intr_i         ( clr_intr_i ),
        .write_ackn_i       ( write_ackn_i ),
        .write_done_i       ( write_done_i ),
        .frame_ddr_addr_i   ( frame_ddr_addr_i ),
        // Outputs
        .fifo_reset_o       ( ddr_write_controller_enc_0_fifo_reset_o ),
        .read_fifo_o        ( ddr_write_controller_enc_0_read_fifo_o ),
        .frm_interrupt_o    ( frm_interrupt_o_net_0 ),
        .frame_idx_o        ( frame_index_o_net_0 ),
        .frame_size_o       ( frame_bytes_o_net_0 ),
        .write_req_o        ( write_req_o_net_0 ),
        .write_start_addr_o ( write_start_addr_o_net_0 ),
        .write_length_o     ( write_length_o_net_0 ) 
        );

//--------video_fifo
video_fifo #( 
        .g_HALF_EMPTY_THRESHOLD       ( 1280 ),
        .g_INPUT_VIDEO_DATA_BIT_WIDTH ( 64 ),
        .g_VIDEO_FIFO_AWIDTH          ( 12 ) )
video_fifo_0(
        // Inputs
        .wclock_i      ( h264_clk_i ),
        .wresetn_i     ( AND2_1_Y ),
        .wen_i         ( data_packer_h264_0_data_valid_o ),
        .wdata_i       ( data_packer_h264_0_data_o ),
        .rclock_i      ( ddr_clk_i ),
        .rresetn_i     ( AND2_1_Y ),
        .ren_i         ( ddr_write_controller_enc_0_read_fifo_o ),
        // Outputs
        .wfull_o       (  ),
        .wafull_o      (  ),
        .wdata_count_o (  ),
        .rdata_o       ( rdata_o_net_0 ),
        .rdata_rdy_o   ( rdata_rdy_o_net_0 ),
        .rempty_o      (  ),
        .raempty_o     (  ),
        .rhempty_o     (  ),
        .rdata_count_o ( video_fifo_0_rdata_count_o ) 
        );


endmodule
