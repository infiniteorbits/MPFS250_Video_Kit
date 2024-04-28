//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Apr 28 14:51:30 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// IMX334_IF_TOP
module IMX334_IF_TOP(
    // Inputs
    ACLK_I,
    ARESETN_I,
    ARST_N,
    AXI4L_MIPI_araddr,
    AXI4L_MIPI_arvalid,
    AXI4L_MIPI_awaddr,
    AXI4L_MIPI_awvalid,
    AXI4L_MIPI_bready,
    AXI4L_MIPI_rready,
    AXI4L_MIPI_wdata,
    AXI4L_MIPI_wvalid,
    CAM1_RXD,
    CAM1_RXD_N,
    CAM1_RX_CLK_N,
    CAM1_RX_CLK_P,
    INIT_DONE,
    TRNG_RST_N,
    // Outputs
    AXI4L_MIPI_arready,
    AXI4L_MIPI_awready,
    AXI4L_MIPI_bresp,
    AXI4L_MIPI_bvalid,
    AXI4L_MIPI_rdata,
    AXI4L_MIPI_rresp,
    AXI4L_MIPI_rvalid,
    AXI4L_MIPI_wready,
    MIPI_INTERRUPT_O,
    PARALLEL_CLK,
    PARALLEL_CLK_RESET_N,
    c1_data_out_o,
    c1_frame_start_o,
    c1_line_valid_o
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         ACLK_I;
input         ARESETN_I;
input         ARST_N;
input  [31:0] AXI4L_MIPI_araddr;
input         AXI4L_MIPI_arvalid;
input  [31:0] AXI4L_MIPI_awaddr;
input         AXI4L_MIPI_awvalid;
input         AXI4L_MIPI_bready;
input         AXI4L_MIPI_rready;
input  [31:0] AXI4L_MIPI_wdata;
input         AXI4L_MIPI_wvalid;
input  [3:0]  CAM1_RXD;
input  [3:0]  CAM1_RXD_N;
input         CAM1_RX_CLK_N;
input         CAM1_RX_CLK_P;
input         INIT_DONE;
input         TRNG_RST_N;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        AXI4L_MIPI_arready;
output        AXI4L_MIPI_awready;
output [1:0]  AXI4L_MIPI_bresp;
output        AXI4L_MIPI_bvalid;
output [31:0] AXI4L_MIPI_rdata;
output [1:0]  AXI4L_MIPI_rresp;
output        AXI4L_MIPI_rvalid;
output        AXI4L_MIPI_wready;
output        MIPI_INTERRUPT_O;
output        PARALLEL_CLK;
output        PARALLEL_CLK_RESET_N;
output [7:0]  c1_data_out_o;
output        c1_frame_start_o;
output        c1_line_valid_o;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          ACLK_I;
wire          AND2_0_Y;
wire          ARESETN_I;
wire          ARST_N;
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
wire   [9:2]  c1_data_out_o_net_0;
wire          c1_frame_start_o_net_0;
wire          c1_line_valid_o_net_0;
wire          CAM1_RX_CLK_N;
wire          CAM1_RX_CLK_P;
wire   [3:0]  CAM1_RXD;
wire   [3:0]  CAM1_RXD_N;
wire          CORERESET_PF_C2_0_FABRIC_RESET_N;
wire          DFN1_0_Q;
wire          DFN1_1_Q;
wire          DFN1_2_Q;
wire          INIT_DONE;
wire          MIPI_INTERRUPT_O_net_0;
wire          PARALLEL_CLK_net_0;
wire          PARALLEL_CLK_RESET_N_net_0;
wire          PF_CCC_C2_0_PLL_LOCK_0;
wire          PF_IOD_GENERIC_RX_C0_0_L0_LP_DATA;
wire          PF_IOD_GENERIC_RX_C0_0_L0_LP_DATA_N;
wire   [7:0]  PF_IOD_GENERIC_RX_C0_0_L0_RXD_DATA;
wire          PF_IOD_GENERIC_RX_C0_0_L1_LP_DATA;
wire          PF_IOD_GENERIC_RX_C0_0_L1_LP_DATA_N;
wire   [7:0]  PF_IOD_GENERIC_RX_C0_0_L1_RXD_DATA;
wire          PF_IOD_GENERIC_RX_C0_0_L2_LP_DATA;
wire          PF_IOD_GENERIC_RX_C0_0_L2_LP_DATA_N;
wire   [7:0]  PF_IOD_GENERIC_RX_C0_0_L2_RXD_DATA;
wire          PF_IOD_GENERIC_RX_C0_0_L3_LP_DATA;
wire          PF_IOD_GENERIC_RX_C0_0_L3_LP_DATA_N;
wire   [7:0]  PF_IOD_GENERIC_RX_C0_0_L3_RXD_DATA;
wire          PF_IOD_GENERIC_RX_C0_0_RX_CLK_G;
wire          PF_IOD_GENERIC_RX_C0_0_training_done_o;
wire          TRNG_RST_N;
wire          AXI4L_MIPI_ARREADY_net_1;
wire          AXI4L_MIPI_AWREADY_net_1;
wire          AXI4L_MIPI_BVALID_net_1;
wire          AXI4L_MIPI_RVALID_net_1;
wire          AXI4L_MIPI_WREADY_net_1;
wire          MIPI_INTERRUPT_O_net_1;
wire          PARALLEL_CLK_RESET_N_net_1;
wire          PARALLEL_CLK_net_1;
wire          c1_frame_start_o_net_1;
wire          c1_line_valid_o_net_1;
wire   [1:0]  AXI4L_MIPI_BRESP_net_1;
wire   [31:0] AXI4L_MIPI_RDATA_net_1;
wire   [1:0]  AXI4L_MIPI_RRESP_net_1;
wire   [7:0]  c1_data_out_o_net_1;
wire   [1:0]  DATA_O_slice_0;
wire   [9:0]  DATA_O_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
wire          GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net = 1'b1;
assign GND_net = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
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
assign MIPI_INTERRUPT_O_net_1     = MIPI_INTERRUPT_O_net_0;
assign MIPI_INTERRUPT_O           = MIPI_INTERRUPT_O_net_1;
assign PARALLEL_CLK_RESET_N_net_1 = PARALLEL_CLK_RESET_N_net_0;
assign PARALLEL_CLK_RESET_N       = PARALLEL_CLK_RESET_N_net_1;
assign PARALLEL_CLK_net_1         = PARALLEL_CLK_net_0;
assign PARALLEL_CLK               = PARALLEL_CLK_net_1;
assign c1_frame_start_o_net_1     = c1_frame_start_o_net_0;
assign c1_frame_start_o           = c1_frame_start_o_net_1;
assign c1_line_valid_o_net_1      = c1_line_valid_o_net_0;
assign c1_line_valid_o            = c1_line_valid_o_net_1;
assign AXI4L_MIPI_BRESP_net_1     = AXI4L_MIPI_BRESP_net_0;
assign AXI4L_MIPI_bresp[1:0]      = AXI4L_MIPI_BRESP_net_1;
assign AXI4L_MIPI_RDATA_net_1     = AXI4L_MIPI_RDATA_net_0;
assign AXI4L_MIPI_rdata[31:0]     = AXI4L_MIPI_RDATA_net_1;
assign AXI4L_MIPI_RRESP_net_1     = AXI4L_MIPI_RRESP_net_0;
assign AXI4L_MIPI_rresp[1:0]      = AXI4L_MIPI_RRESP_net_1;
assign c1_data_out_o_net_1        = c1_data_out_o_net_0;
assign c1_data_out_o[7:0]         = c1_data_out_o_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign c1_data_out_o_net_0 = DATA_O_net_0[9:2];
assign DATA_O_slice_0      = DATA_O_net_0[1:0];
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_0(
        // Inputs
        .A ( DFN1_0_Q ),
        .B ( DFN1_1_Q ),
        // Outputs
        .Y ( AND2_0_Y ) 
        );

//--------CORERESET_PF_C2
CORERESET_PF_C2 CORERESET_PF_C2_0(
        // Inputs
        .CLK                ( PF_IOD_GENERIC_RX_C0_0_RX_CLK_G ),
        .EXT_RST_N          ( DFN1_2_Q ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( DFN1_1_Q ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( INIT_DONE ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( VCC_net ),
        // Outputs
        .PLL_POWERDOWN_B    (  ),
        .FABRIC_RESET_N     ( CORERESET_PF_C2_0_FABRIC_RESET_N ) 
        );

//--------CORERESET_PF_C5
CORERESET_PF_C5 CORERESET_PF_C5_0(
        // Inputs
        .CLK                ( PARALLEL_CLK_net_0 ),
        .EXT_RST_N          ( DFN1_2_Q ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( DFN1_1_Q ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( INIT_DONE ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( VCC_net ),
        // Outputs
        .PLL_POWERDOWN_B    (  ),
        .FABRIC_RESET_N     ( PARALLEL_CLK_RESET_N_net_0 ) 
        );

//--------DFN1
DFN1 DFN1_0(
        // Inputs
        .D   ( TRNG_RST_N ),
        .CLK ( PARALLEL_CLK_net_0 ),
        // Outputs
        .Q   ( DFN1_0_Q ) 
        );

//--------DFN1
DFN1 DFN1_1(
        // Inputs
        .D   ( PF_CCC_C2_0_PLL_LOCK_0 ),
        .CLK ( PARALLEL_CLK_net_0 ),
        // Outputs
        .Q   ( DFN1_1_Q ) 
        );

//--------DFN1
DFN1 DFN1_2(
        // Inputs
        .D   ( PF_IOD_GENERIC_RX_C0_0_training_done_o ),
        .CLK ( PF_IOD_GENERIC_RX_C0_0_RX_CLK_G ),
        // Outputs
        .Q   ( DFN1_2_Q ) 
        );

//--------mipicsi2rxdecoderPF_C0
mipicsi2rxdecoderPF_C0 mipi_ip_0(
        // Inputs
        .CAM_CLOCK_I       ( PF_IOD_GENERIC_RX_C0_0_RX_CLK_G ),
        .PARALLEL_CLOCK_I  ( PARALLEL_CLK_net_0 ),
        .RESET_N_I         ( CORERESET_PF_C2_0_FABRIC_RESET_N ),
        .L0_HS_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L0_RXD_DATA ),
        .L1_HS_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L1_RXD_DATA ),
        .L2_HS_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L2_RXD_DATA ),
        .L3_HS_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L3_RXD_DATA ),
        .L0_LP_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L0_LP_DATA ),
        .L0_LP_DATA_N_I    ( PF_IOD_GENERIC_RX_C0_0_L0_LP_DATA_N ),
        .L1_LP_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L1_LP_DATA ),
        .L1_LP_DATA_N_I    ( PF_IOD_GENERIC_RX_C0_0_L1_LP_DATA_N ),
        .L2_LP_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L2_LP_DATA ),
        .L2_LP_DATA_N_I    ( PF_IOD_GENERIC_RX_C0_0_L2_LP_DATA_N ),
        .L3_LP_DATA_I      ( PF_IOD_GENERIC_RX_C0_0_L3_LP_DATA ),
        .L3_LP_DATA_N_I    ( PF_IOD_GENERIC_RX_C0_0_L3_LP_DATA_N ),
        .CAM_PLL_LOCK_I    ( DFN1_1_Q ),
        .TRAINING_DONE_I   ( DFN1_2_Q ),
        .ACLK_I            ( ACLK_I ),
        .ARESETN_I         ( ARESETN_I ),
        .AWVALID_I         ( AXI4L_MIPI_awvalid ),
        .AWADDR_I          ( AXI4L_MIPI_awaddr ),
        .WDATA_I           ( AXI4L_MIPI_wdata ),
        .WVALID_I          ( AXI4L_MIPI_wvalid ),
        .BREADY_I          ( AXI4L_MIPI_bready ),
        .ARADDR_I          ( AXI4L_MIPI_araddr ),
        .ARVALID_I         ( AXI4L_MIPI_arvalid ),
        .RREADY_I          ( AXI4L_MIPI_rready ),
        // Outputs
        .FRAME_VALID_O     (  ),
        .FRAME_START_O     ( c1_frame_start_o_net_0 ),
        .FRAME_END_O       (  ),
        .LINE_VALID_O      ( c1_line_valid_o_net_0 ),
        .LINE_START_O      (  ),
        .LINE_END_O        (  ),
        .DATA_O            ( DATA_O_net_0 ),
        .VIRTUAL_CHANNEL_O (  ),
        .DATA_TYPE_O       (  ),
        .ECC_ERROR_O       (  ),
        .CRC_ERROR_O       (  ),
        .WORD_COUNT_O      (  ),
        .EBD_VALID_O       (  ),
        .MIPI_INTERRUPT_O  ( MIPI_INTERRUPT_O_net_0 ),
        .AWREADY_O         ( AXI4L_MIPI_AWREADY_net_0 ),
        .WREADY_O          ( AXI4L_MIPI_WREADY_net_0 ),
        .BRESP_O           ( AXI4L_MIPI_BRESP_net_0 ),
        .BVALID_O          ( AXI4L_MIPI_BVALID_net_0 ),
        .ARREADY_O         ( AXI4L_MIPI_ARREADY_net_0 ),
        .RDATA_O           ( AXI4L_MIPI_RDATA_net_0 ),
        .RRESP_O           ( AXI4L_MIPI_RRESP_net_0 ),
        .RVALID_O          ( AXI4L_MIPI_RVALID_net_0 ) 
        );

//--------PF_CCC_C2
PF_CCC_C2 PF_CCC_C2_0(
        // Inputs
        .REF_CLK_0     ( PF_IOD_GENERIC_RX_C0_0_RX_CLK_G ),
        // Outputs
        .OUT0_FABCLK_0 ( PARALLEL_CLK_net_0 ),
        .PLL_LOCK_0    ( PF_CCC_C2_0_PLL_LOCK_0 ) 
        );

//--------CAM_IOD_TIP_TOP
CAM_IOD_TIP_TOP PF_IOD_GENERIC_RX_C0_0(
        // Inputs
        .ARST_N          ( ARST_N ),
        .HS_IO_CLK_PAUSE ( GND_net ),
        .HS_SEL          ( VCC_net ),
        .PLL_LOCK        ( DFN1_1_Q ),
        .RESTART_TRNG    ( GND_net ),
        .RX_CLK_N        ( CAM1_RX_CLK_N ),
        .RX_CLK_P        ( CAM1_RX_CLK_P ),
        .SKIP_TRNG       ( GND_net ),
        .TRAINING_RESETN ( AND2_0_Y ),
        .RXD_N           ( CAM1_RXD_N ),
        .RXD             ( CAM1_RXD ),
        // Outputs
        .CLK_TRAIN_DONE  (  ),
        .CLK_TRAIN_ERROR (  ),
        .L0_LP_DATA_N    ( PF_IOD_GENERIC_RX_C0_0_L0_LP_DATA_N ),
        .L0_LP_DATA      ( PF_IOD_GENERIC_RX_C0_0_L0_LP_DATA ),
        .L1_LP_DATA_N    ( PF_IOD_GENERIC_RX_C0_0_L1_LP_DATA_N ),
        .L1_LP_DATA      ( PF_IOD_GENERIC_RX_C0_0_L1_LP_DATA ),
        .L2_LP_DATA_N    ( PF_IOD_GENERIC_RX_C0_0_L2_LP_DATA_N ),
        .L2_LP_DATA      ( PF_IOD_GENERIC_RX_C0_0_L2_LP_DATA ),
        .L3_LP_DATA_N    ( PF_IOD_GENERIC_RX_C0_0_L3_LP_DATA_N ),
        .L3_LP_DATA      ( PF_IOD_GENERIC_RX_C0_0_L3_LP_DATA ),
        .RX_CLK_G        ( PF_IOD_GENERIC_RX_C0_0_RX_CLK_G ),
        .training_done_o ( PF_IOD_GENERIC_RX_C0_0_training_done_o ),
        .L0_RXD_DATA     ( PF_IOD_GENERIC_RX_C0_0_L0_RXD_DATA ),
        .L1_RXD_DATA     ( PF_IOD_GENERIC_RX_C0_0_L1_RXD_DATA ),
        .L2_RXD_DATA     ( PF_IOD_GENERIC_RX_C0_0_L2_RXD_DATA ),
        .L3_RXD_DATA     ( PF_IOD_GENERIC_RX_C0_0_L3_RXD_DATA ) 
        );


endmodule
