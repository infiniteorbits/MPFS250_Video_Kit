//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Wed May 22 10:33:48 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// Video_Pipeline
module Video_Pipeline(
    // Inputs
    CAM1_RXD,
    CAM1_RXD_N,
    CAM1_RX_CLK_N,
    CAM1_RX_CLK_P,
    CLK_125MHz_i,
    CLK_50MHz_i,
    INIT_DONE,
    LPDDR4_RDY_i,
    RESETN_125MHz_i,
    RESETN_50MHz_i,
    arready,
    awready,
    bid,
    bresp,
    bvalid,
    paddr_i,
    penable_i,
    psel_i,
    pwdata_i,
    pwrite_i,
    rdata,
    rid,
    rlast,
    rresp,
    rvalid,
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
    frm_interrupt_o,
    prdata_o,
    pready_o,
    pslverr_o,
    rready,
    wdata,
    wlast,
    wstrb,
    wvalid
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [3:0]  CAM1_RXD;
input  [3:0]  CAM1_RXD_N;
input         CAM1_RX_CLK_N;
input         CAM1_RX_CLK_P;
input         CLK_125MHz_i;
input         CLK_50MHz_i;
input         INIT_DONE;
input         LPDDR4_RDY_i;
input         RESETN_125MHz_i;
input         RESETN_50MHz_i;
input         arready;
input         awready;
input  [3:0]  bid;
input  [1:0]  bresp;
input         bvalid;
input  [31:0] paddr_i;
input         penable_i;
input         psel_i;
input  [31:0] pwdata_i;
input         pwrite_i;
input  [63:0] rdata;
input  [3:0]  rid;
input         rlast;
input  [1:0]  rresp;
input         rvalid;
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
output        frm_interrupt_o;
output [31:0] prdata_o;
output        pready_o;
output        pslverr_o;
output        rready;
output [63:0] wdata;
output        wlast;
output [63:0] wstrb;
output        wvalid;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [9:0]   apb3_if_0_bconst_o;
wire   [11:0]  apb3_if_0_disp_digits_o;
wire   [9:0]   apb3_if_0_gconst_o;
wire           apb3_if_0_h264_clr_intr_o;
wire   [31:22] apb3_if_0_h264_ddrlsb_addr_o31to22;
wire           apb3_if_0_h264_en_o;
wire   [15:0]  apb3_if_0_horiz_resl_o;
wire           apb3_if_0_osd_en_o;
wire   [5:0]   apb3_if_0_quality_o5to0;
wire   [9:0]   apb3_if_0_rconst_o;
wire   [19:0]  apb3_if_0_second_const_o;
wire   [23:0]  apb3_if_0_text_color_o;
wire   [31:0]  apb3_if_0_text_coordinates_o;
wire   [15:0]  apb3_if_0_vert_resl_o;
wire   [31:0]  paddr_i;
wire           penable_i;
wire   [31:0]  APBslave_PRDATA;
wire           APBslave_PREADY;
wire           psel_i;
wire           APBslave_PSLVERR;
wire   [31:0]  pwdata_i;
wire           pwrite_i;
wire   [31:0]  BIF_1_ARADDR;
wire   [1:0]   BIF_1_ARBURST;
wire   [3:0]   BIF_1_ARCACHE;
wire   [3:0]   BIF_1_ARID;
wire   [7:0]   BIF_1_ARLEN;
wire   [1:0]   BIF_1_ARLOCK;
wire   [2:0]   BIF_1_ARPROT;
wire           arready;
wire   [2:0]   BIF_1_ARSIZE;
wire           BIF_1_ARVALID;
wire   [31:0]  BIF_1_AWADDR;
wire   [1:0]   BIF_1_AWBURST;
wire   [3:0]   BIF_1_AWCACHE;
wire   [3:0]   BIF_1_AWID;
wire   [7:0]   BIF_1_AWLEN;
wire   [1:0]   BIF_1_AWLOCK;
wire   [2:0]   BIF_1_AWPROT;
wire           awready;
wire   [2:0]   BIF_1_AWSIZE;
wire           BIF_1_AWVALID;
wire   [3:0]   bid;
wire           BIF_1_BREADY;
wire   [1:0]   bresp;
wire           bvalid;
wire   [63:0]  rdata;
wire   [3:0]   rid;
wire           rlast;
wire           BIF_1_RREADY;
wire   [1:0]   rresp;
wire           rvalid;
wire   [63:0]  BIF_1_WDATA;
wire           BIF_1_WLAST;
wire           wready;
wire   [63:0]  BIF_1_WSTRB;
wire           BIF_1_WVALID;
wire           CAM1_RX_CLK_N;
wire           CAM1_RX_CLK_P;
wire   [3:0]   CAM1_RXD;
wire   [3:0]   CAM1_RXD_N;
wire           CLK_50MHz_i;
wire           CLK_125MHz_i;
wire           frm_interrupt_o_net_0;
wire   [31:0]  h264_top_0_frame_bytes_o;
wire   [1:0]   h264_top_0_frame_index_o;
wire   [7:0]   IMX334_IF_TOP_0_c1_data_out_o;
wire           IMX334_IF_TOP_0_c1_frame_start_o;
wire           IMX334_IF_TOP_0_c1_frame_valid_o;
wire           IMX334_IF_TOP_0_c1_line_valid_o;
wire           IMX334_IF_TOP_0_CAMCLK_RESET_N;
wire           IMX334_IF_TOP_0_PARALLEL_CLOCK;
wire           INIT_DONE;
wire           LPDDR4_RDY_i;
wire           RESETN_50MHz_i;
wire           RESETN_125MHz_i;
wire   [7:0]   RGBtoYCbCr_C0_0_C_OUT;
wire           RGBtoYCbCr_C0_0_DATA_VALID_O;
wire   [7:0]   RGBtoYCbCr_C0_0_Y_OUT;
wire   [7:0]   video_processing_0_DATA_B_O;
wire   [7:0]   video_processing_0_DATA_G_O;
wire   [7:0]   video_processing_0_DATA_R_O;
wire           video_processing_0_DATA_VALID_O;
wire           video_processing_0_encoder_en_o;
wire           video_processing_0_eof_encoder_o;
wire           video_processing_0_frame_start_encoder_o;
wire   [31:0]  video_processing_0_y_o;
wire           BIF_1_ARVALID_net_0;
wire           BIF_1_AWVALID_net_0;
wire           BIF_1_BREADY_net_0;
wire           frm_interrupt_o_net_1;
wire           APBslave_PREADY_net_0;
wire           APBslave_PSLVERR_net_0;
wire           BIF_1_RREADY_net_0;
wire           BIF_1_WLAST_net_0;
wire           BIF_1_WVALID_net_0;
wire   [31:0]  BIF_1_ARADDR_net_0;
wire   [1:0]   BIF_1_ARBURST_net_0;
wire   [3:0]   BIF_1_ARCACHE_net_0;
wire   [3:0]   BIF_1_ARID_net_0;
wire   [7:0]   BIF_1_ARLEN_net_0;
wire   [1:0]   BIF_1_ARLOCK_net_0;
wire   [2:0]   BIF_1_ARPROT_net_0;
wire   [2:0]   BIF_1_ARSIZE_net_0;
wire   [31:0]  BIF_1_AWADDR_net_0;
wire   [1:0]   BIF_1_AWBURST_net_0;
wire   [3:0]   BIF_1_AWCACHE_net_0;
wire   [3:0]   BIF_1_AWID_net_0;
wire   [7:0]   BIF_1_AWLEN_net_0;
wire   [1:0]   BIF_1_AWLOCK_net_0;
wire   [2:0]   BIF_1_AWPROT_net_0;
wire   [2:0]   BIF_1_AWSIZE_net_0;
wire   [31:0]  APBslave_PRDATA_net_0;
wire   [63:0]  BIF_1_WDATA_net_0;
wire   [63:0]  BIF_1_WSTRB_net_0;
wire   [7:6]   quality_o_slice_0;
wire   [21:0]  h264_ddrlsb_addr_o_slice_0;
wire   [7:0]   quality_o_net_0;
wire   [31:0]  h264_ddrlsb_addr_o_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [7:0]   r_gain_i_const_net_0;
wire   [7:0]   g_gain_i_const_net_0;
wire   [7:0]   b_gain_i_const_net_0;
wire   [7:0]   brightness_i_const_net_0;
wire   [7:0]   contrast_i_const_net_0;
wire   [7:0]   quality_i_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign r_gain_i_const_net_0     = 8'h00;
assign g_gain_i_const_net_0     = 8'h00;
assign b_gain_i_const_net_0     = 8'h00;
assign brightness_i_const_net_0 = 8'h00;
assign contrast_i_const_net_0   = 8'h00;
assign quality_i_const_net_0    = 8'h00;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign BIF_1_ARVALID_net_0    = BIF_1_ARVALID;
assign arvalid                = BIF_1_ARVALID_net_0;
assign BIF_1_AWVALID_net_0    = BIF_1_AWVALID;
assign awvalid                = BIF_1_AWVALID_net_0;
assign BIF_1_BREADY_net_0     = BIF_1_BREADY;
assign bready                 = BIF_1_BREADY_net_0;
assign frm_interrupt_o_net_1  = frm_interrupt_o_net_0;
assign frm_interrupt_o        = frm_interrupt_o_net_1;
assign APBslave_PREADY_net_0  = APBslave_PREADY;
assign pready_o               = APBslave_PREADY_net_0;
assign APBslave_PSLVERR_net_0 = APBslave_PSLVERR;
assign pslverr_o              = APBslave_PSLVERR_net_0;
assign BIF_1_RREADY_net_0     = BIF_1_RREADY;
assign rready                 = BIF_1_RREADY_net_0;
assign BIF_1_WLAST_net_0      = BIF_1_WLAST;
assign wlast                  = BIF_1_WLAST_net_0;
assign BIF_1_WVALID_net_0     = BIF_1_WVALID;
assign wvalid                 = BIF_1_WVALID_net_0;
assign BIF_1_ARADDR_net_0     = BIF_1_ARADDR;
assign araddr[31:0]           = BIF_1_ARADDR_net_0;
assign BIF_1_ARBURST_net_0    = BIF_1_ARBURST;
assign arburst[1:0]           = BIF_1_ARBURST_net_0;
assign BIF_1_ARCACHE_net_0    = BIF_1_ARCACHE;
assign arcache[3:0]           = BIF_1_ARCACHE_net_0;
assign BIF_1_ARID_net_0       = BIF_1_ARID;
assign arid[3:0]              = BIF_1_ARID_net_0;
assign BIF_1_ARLEN_net_0      = BIF_1_ARLEN;
assign arlen[7:0]             = BIF_1_ARLEN_net_0;
assign BIF_1_ARLOCK_net_0     = BIF_1_ARLOCK;
assign arlock[1:0]            = BIF_1_ARLOCK_net_0;
assign BIF_1_ARPROT_net_0     = BIF_1_ARPROT;
assign arprot[2:0]            = BIF_1_ARPROT_net_0;
assign BIF_1_ARSIZE_net_0     = BIF_1_ARSIZE;
assign arsize[2:0]            = BIF_1_ARSIZE_net_0;
assign BIF_1_AWADDR_net_0     = BIF_1_AWADDR;
assign awaddr[31:0]           = BIF_1_AWADDR_net_0;
assign BIF_1_AWBURST_net_0    = BIF_1_AWBURST;
assign awburst[1:0]           = BIF_1_AWBURST_net_0;
assign BIF_1_AWCACHE_net_0    = BIF_1_AWCACHE;
assign awcache[3:0]           = BIF_1_AWCACHE_net_0;
assign BIF_1_AWID_net_0       = BIF_1_AWID;
assign awid[3:0]              = BIF_1_AWID_net_0;
assign BIF_1_AWLEN_net_0      = BIF_1_AWLEN;
assign awlen[7:0]             = BIF_1_AWLEN_net_0;
assign BIF_1_AWLOCK_net_0     = BIF_1_AWLOCK;
assign awlock[1:0]            = BIF_1_AWLOCK_net_0;
assign BIF_1_AWPROT_net_0     = BIF_1_AWPROT;
assign awprot[2:0]            = BIF_1_AWPROT_net_0;
assign BIF_1_AWSIZE_net_0     = BIF_1_AWSIZE;
assign awsize[2:0]            = BIF_1_AWSIZE_net_0;
assign APBslave_PRDATA_net_0  = APBslave_PRDATA;
assign prdata_o[31:0]         = APBslave_PRDATA_net_0;
assign BIF_1_WDATA_net_0      = BIF_1_WDATA;
assign wdata[63:0]            = BIF_1_WDATA_net_0;
assign BIF_1_WSTRB_net_0      = BIF_1_WSTRB;
assign wstrb[63:0]            = BIF_1_WSTRB_net_0;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign apb3_if_0_h264_ddrlsb_addr_o31to22 = h264_ddrlsb_addr_o_net_0[31:22];
assign apb3_if_0_quality_o5to0            = quality_o_net_0[5:0];
assign quality_o_slice_0                  = quality_o_net_0[7:6];
assign h264_ddrlsb_addr_o_slice_0         = h264_ddrlsb_addr_o_net_0[21:0];
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------apb3_if
apb3_if #( 
        .g_APB3_IF_DATA_WIDTH ( 32 ),
        .g_CONST_WIDTH        ( 12 ) )
apb3_if_0(
        // Inputs
        .preset_i           ( RESETN_50MHz_i ),
        .pclk_i             ( CLK_50MHz_i ),
        .psel_i             ( psel_i ),
        .pwrite_i           ( pwrite_i ),
        .penable_i          ( penable_i ),
        .paddr_i            ( paddr_i ),
        .pwdata_i           ( pwdata_i ),
        .frame_valid_i      ( IMX334_IF_TOP_0_c1_frame_valid_o ),
        .r_gain_i           ( r_gain_i_const_net_0 ),
        .g_gain_i           ( g_gain_i_const_net_0 ),
        .b_gain_i           ( b_gain_i_const_net_0 ),
        .brightness_i       ( brightness_i_const_net_0 ),
        .contrast_i         ( contrast_i_const_net_0 ),
        .quality_i          ( quality_i_const_net_0 ),
        .RGB_SUM_i          ( video_processing_0_y_o ),
        .frame_index_i      ( h264_top_0_frame_index_o ),
        .frame_bytes_i      ( h264_top_0_frame_bytes_o ),
        // Outputs
        .pready_o           ( APBslave_PREADY ),
        .pslverr_o          ( APBslave_PSLVERR ),
        .prdata_o           ( APBslave_PRDATA ),
        .mode_o             (  ),
        .alpha_o            (  ),
        .step_o             (  ),
        .rconst_o           ( apb3_if_0_rconst_o ),
        .gconst_o           ( apb3_if_0_gconst_o ),
        .bconst_o           ( apb3_if_0_bconst_o ),
        .second_const_o     ( apb3_if_0_second_const_o ),
        .horiz_resl_o       ( apb3_if_0_horiz_resl_o ),
        .vert_resl_o        ( apb3_if_0_vert_resl_o ),
        .quality_o          ( quality_o_net_0 ),
        .frame_tcount_o     (  ),
        .h264_en_o          ( apb3_if_0_h264_en_o ),
        .h264_ddrlsb_addr_o ( h264_ddrlsb_addr_o_net_0 ),
        .h264_clr_intr_o    ( apb3_if_0_h264_clr_intr_o ),
        .osd_en_o           ( apb3_if_0_osd_en_o ),
        .text_color_o       ( apb3_if_0_text_color_o ),
        .text_coordinates_o ( apb3_if_0_text_coordinates_o ),
        .disp_digits_o      ( apb3_if_0_disp_digits_o ) 
        );

//--------h264_top
h264_top h264_top_0(
        // Inputs
        .arready          ( arready ),
        .awready          ( awready ),
        .bvalid           ( bvalid ),
        .clr_intr_i       ( apb3_if_0_h264_clr_intr_o ),
        .data_valid_i     ( RGBtoYCbCr_C0_0_DATA_VALID_O ),
        .ddr_ctrl_ready_i ( LPDDR4_RDY_i ),
        .eof_i            ( video_processing_0_eof_encoder_o ),
        .fic_clk          ( CLK_125MHz_i ),
        .frame_valid_i    ( video_processing_0_frame_start_encoder_o ),
        .h264_encoder_en  ( video_processing_0_encoder_en_o ),
        .pclk_i           ( CLK_50MHz_i ),
        .read_reset_i     ( RESETN_125MHz_i ),
        .resetn_i         ( IMX334_IF_TOP_0_CAMCLK_RESET_N ),
        .rlast            ( rlast ),
        .rvalid           ( rvalid ),
        .sys_clk_i        ( IMX334_IF_TOP_0_PARALLEL_CLOCK ),
        .wready           ( wready ),
        .bid              ( bid ),
        .bresp            ( bresp ),
        .data_c_i         ( RGBtoYCbCr_C0_0_C_OUT ),
        .data_y_i         ( RGBtoYCbCr_C0_0_Y_OUT ),
        .frame_ddr_addr_i ( apb3_if_0_h264_ddrlsb_addr_o31to22 ),
        .hres_i           ( apb3_if_0_horiz_resl_o ),
        .qp_i             ( apb3_if_0_quality_o5to0 ),
        .rdata            ( rdata ),
        .rid              ( rid ),
        .rresp            ( rresp ),
        .vres_i           ( apb3_if_0_vert_resl_o ),
        // Outputs
        .arvalid          ( BIF_1_ARVALID ),
        .awvalid          ( BIF_1_AWVALID ),
        .bready           ( BIF_1_BREADY ),
        .frm_interrupt_o  ( frm_interrupt_o_net_0 ),
        .rready           ( BIF_1_RREADY ),
        .wlast            ( BIF_1_WLAST ),
        .wvalid           ( BIF_1_WVALID ),
        .araddr           ( BIF_1_ARADDR ),
        .arburst          ( BIF_1_ARBURST ),
        .arcache          ( BIF_1_ARCACHE ),
        .arid             ( BIF_1_ARID ),
        .arlen            ( BIF_1_ARLEN ),
        .arlock           ( BIF_1_ARLOCK ),
        .arprot           ( BIF_1_ARPROT ),
        .arsize           ( BIF_1_ARSIZE ),
        .awaddr           ( BIF_1_AWADDR ),
        .awburst          ( BIF_1_AWBURST ),
        .awcache          ( BIF_1_AWCACHE ),
        .awid             ( BIF_1_AWID ),
        .awlen            ( BIF_1_AWLEN ),
        .awlock           ( BIF_1_AWLOCK ),
        .awprot           ( BIF_1_AWPROT ),
        .awsize           ( BIF_1_AWSIZE ),
        .frame_bytes_o    ( h264_top_0_frame_bytes_o ),
        .frame_index_o    ( h264_top_0_frame_index_o ),
        .wdata            ( BIF_1_WDATA ),
        .wstrb            ( BIF_1_WSTRB ) 
        );

//--------IMX334_IF_TOP
IMX334_IF_TOP IMX334_IF_TOP_0(
        // Inputs
        .ARST_N           ( INIT_DONE ),
        .CAM1_RX_CLK_N    ( CAM1_RX_CLK_N ),
        .CAM1_RX_CLK_P    ( CAM1_RX_CLK_P ),
        .INIT_DONE        ( INIT_DONE ),
        .TRNG_RST_N       ( LPDDR4_RDY_i ),
        .CAM1_RXD_N       ( CAM1_RXD_N ),
        .CAM1_RXD         ( CAM1_RXD ),
        // Outputs
        .CAMCLK_RESET_N   ( IMX334_IF_TOP_0_CAMCLK_RESET_N ),
        .CAMERA_CLK       (  ),
        .PARALLEL_CLOCK   ( IMX334_IF_TOP_0_PARALLEL_CLOCK ),
        .c1_frame_start_o ( IMX334_IF_TOP_0_c1_frame_start_o ),
        .c1_frame_valid_o ( IMX334_IF_TOP_0_c1_frame_valid_o ),
        .c1_line_valid_o  ( IMX334_IF_TOP_0_c1_line_valid_o ),
        .c1_data_out_o    ( IMX334_IF_TOP_0_c1_data_out_o ) 
        );

//--------RGBtoYCbCr_C0
RGBtoYCbCr_C0 RGBtoYCbCr_C0_0(
        // Inputs
        .RESET_N_I    ( IMX334_IF_TOP_0_CAMCLK_RESET_N ),
        .CLOCK_I      ( IMX334_IF_TOP_0_PARALLEL_CLOCK ),
        .DATA_VALID_I ( video_processing_0_DATA_VALID_O ),
        .RED_I        ( video_processing_0_DATA_R_O ),
        .GREEN_I      ( video_processing_0_DATA_G_O ),
        .BLUE_I       ( video_processing_0_DATA_B_O ),
        // Outputs
        .DATA_VALID_O ( RGBtoYCbCr_C0_0_DATA_VALID_O ),
        .Y_OUT        ( RGBtoYCbCr_C0_0_Y_OUT ),
        .C_OUT        ( RGBtoYCbCr_C0_0_C_OUT ) 
        );

//--------video_processing
video_processing video_processing_0(
        // Inputs
        .DATA_VALID_I          ( IMX334_IF_TOP_0_c1_line_valid_o ),
        .OSD_EN_I              ( apb3_if_0_osd_en_o ),
        .RESETN_I              ( IMX334_IF_TOP_0_CAMCLK_RESET_N ),
        .SYS_CLK_I             ( IMX334_IF_TOP_0_PARALLEL_CLOCK ),
        .encoder_en_i          ( apb3_if_0_h264_en_o ),
        .frame_start_i         ( IMX334_IF_TOP_0_c1_frame_start_o ),
        .B_CONST_I             ( apb3_if_0_bconst_o ),
        .COMMON_CONST_I        ( apb3_if_0_second_const_o ),
        .DATA_I                ( IMX334_IF_TOP_0_c1_data_out_o ),
        .G_CONST_I             ( apb3_if_0_gconst_o ),
        .R_CONST_I             ( apb3_if_0_rconst_o ),
        .coordinate_i          ( apb3_if_0_text_coordinates_o ),
        .digits_i              ( apb3_if_0_disp_digits_o ),
        .hres_i                ( apb3_if_0_horiz_resl_o ),
        .text_color_rgb_i      ( apb3_if_0_text_color_o ),
        .vres_i                ( apb3_if_0_vert_resl_o ),
        // Outputs
        .DATA_VALID_O          ( video_processing_0_DATA_VALID_O ),
        .encoder_en_o          ( video_processing_0_encoder_en_o ),
        .eof_encoder_o         ( video_processing_0_eof_encoder_o ),
        .frame_start_encoder_o ( video_processing_0_frame_start_encoder_o ),
        .DATA_B_O              ( video_processing_0_DATA_B_O ),
        .DATA_G_O              ( video_processing_0_DATA_G_O ),
        .DATA_R_O              ( video_processing_0_DATA_R_O ),
        .y_o                   ( video_processing_0_y_o ) 
        );


endmodule
