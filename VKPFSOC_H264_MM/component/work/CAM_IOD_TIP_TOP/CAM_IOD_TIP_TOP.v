//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Apr 28 14:51:14 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// CAM_IOD_TIP_TOP
module CAM_IOD_TIP_TOP(
    // Inputs
    ARST_N,
    HS_IO_CLK_PAUSE,
    HS_SEL,
    PLL_LOCK,
    RESTART_TRNG,
    RXD,
    RXD_N,
    RX_CLK_N,
    RX_CLK_P,
    SKIP_TRNG,
    TRAINING_RESETN,
    // Outputs
    CLK_TRAIN_DONE,
    CLK_TRAIN_ERROR,
    L0_LP_DATA,
    L0_LP_DATA_N,
    L0_RXD_DATA,
    L1_LP_DATA,
    L1_LP_DATA_N,
    L1_RXD_DATA,
    L2_LP_DATA,
    L2_LP_DATA_N,
    L2_RXD_DATA,
    L3_LP_DATA,
    L3_LP_DATA_N,
    L3_RXD_DATA,
    RX_CLK_G,
    training_done_o
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input        ARST_N;
input        HS_IO_CLK_PAUSE;
input        HS_SEL;
input        PLL_LOCK;
input        RESTART_TRNG;
input  [3:0] RXD;
input  [3:0] RXD_N;
input        RX_CLK_N;
input        RX_CLK_P;
input        SKIP_TRNG;
input        TRAINING_RESETN;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output       CLK_TRAIN_DONE;
output       CLK_TRAIN_ERROR;
output       L0_LP_DATA;
output       L0_LP_DATA_N;
output [7:0] L0_RXD_DATA;
output       L1_LP_DATA;
output       L1_LP_DATA_N;
output [7:0] L1_RXD_DATA;
output       L2_LP_DATA;
output       L2_LP_DATA_N;
output [7:0] L2_RXD_DATA;
output       L3_LP_DATA;
output       L3_LP_DATA_N;
output [7:0] L3_RXD_DATA;
output       RX_CLK_G;
output       training_done_o;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire         AND2_0_Y;
wire         ARST_N;
wire         CLK_TRAIN_DONE_net_0;
wire         CLK_TRAIN_ERROR_net_0;
wire         CORERESET_PF_C1_0_FABRIC_RESET_N;
wire         CORERXIODBITALIGN_C1_L0_BIT_ALGN_CLR_FLGS;
wire         CORERXIODBITALIGN_C1_L0_BIT_ALGN_DIR;
wire         CORERXIODBITALIGN_C1_L0_BIT_ALGN_DONE;
wire         CORERXIODBITALIGN_C1_L0_BIT_ALGN_LOAD;
wire         CORERXIODBITALIGN_C1_L0_BIT_ALGN_MOVE;
wire         CORERXIODBITALIGN_C1_L1_BIT_ALGN_CLR_FLGS;
wire         CORERXIODBITALIGN_C1_L1_BIT_ALGN_DIR;
wire         CORERXIODBITALIGN_C1_L1_BIT_ALGN_DONE;
wire         CORERXIODBITALIGN_C1_L1_BIT_ALGN_LOAD;
wire         CORERXIODBITALIGN_C1_L1_BIT_ALGN_MOVE;
wire         CORERXIODBITALIGN_C1_L2_BIT_ALGN_CLR_FLGS;
wire         CORERXIODBITALIGN_C1_L2_BIT_ALGN_DIR;
wire         CORERXIODBITALIGN_C1_L2_BIT_ALGN_DONE;
wire         CORERXIODBITALIGN_C1_L2_BIT_ALGN_LOAD;
wire         CORERXIODBITALIGN_C1_L2_BIT_ALGN_MOVE;
wire         CORERXIODBITALIGN_C1_L3_BIT_ALGN_CLR_FLGS;
wire         CORERXIODBITALIGN_C1_L3_BIT_ALGN_DIR;
wire         CORERXIODBITALIGN_C1_L3_BIT_ALGN_DONE;
wire         CORERXIODBITALIGN_C1_L3_BIT_ALGN_LOAD;
wire         CORERXIODBITALIGN_C1_L3_BIT_ALGN_MOVE;
wire         HS_IO_CLK_PAUSE;
wire         HS_SEL;
wire         L0_LP_DATA_net_0;
wire         L0_LP_DATA_N_net_0;
wire   [7:0] L0_RXD_DATA_net_0;
wire         L1_LP_DATA_net_0;
wire         L1_LP_DATA_N_net_0;
wire   [7:0] L1_RXD_DATA_net_0;
wire         L2_LP_DATA_net_0;
wire         L2_LP_DATA_N_net_0;
wire   [7:0] L2_RXD_DATA_net_0;
wire         L3_LP_DATA_net_0;
wire         L3_LP_DATA_N_net_0;
wire   [7:0] L3_RXD_DATA_net_0;
wire   [0:0] PF_IOD_0_DELAY_LINE_OUT_OF_RANGE0to0;
wire   [1:1] PF_IOD_0_DELAY_LINE_OUT_OF_RANGE1to1;
wire   [2:2] PF_IOD_0_DELAY_LINE_OUT_OF_RANGE2to2;
wire   [3:3] PF_IOD_0_DELAY_LINE_OUT_OF_RANGE3to3;
wire   [0:0] PF_IOD_0_EYE_MONITOR_EARLY0to0;
wire   [1:1] PF_IOD_0_EYE_MONITOR_EARLY1to1;
wire   [2:2] PF_IOD_0_EYE_MONITOR_EARLY2to2;
wire   [3:3] PF_IOD_0_EYE_MONITOR_EARLY3to3;
wire   [0:0] PF_IOD_0_EYE_MONITOR_LATE0to0;
wire   [1:1] PF_IOD_0_EYE_MONITOR_LATE1to1;
wire   [2:2] PF_IOD_0_EYE_MONITOR_LATE2to2;
wire   [3:3] PF_IOD_0_EYE_MONITOR_LATE3to3;
wire         PLL_LOCK;
wire         RESTART_TRNG;
wire         RX_CLK_G_net_0;
wire         RX_CLK_N;
wire         RX_CLK_P;
wire   [3:0] RXD;
wire   [3:0] RXD_N;
wire         SKIP_TRNG;
wire         training_done_o_net_0;
wire         TRAINING_RESETN;
wire         CLK_TRAIN_DONE_net_1;
wire         CLK_TRAIN_ERROR_net_1;
wire         L0_LP_DATA_N_net_1;
wire         L0_LP_DATA_net_1;
wire         L1_LP_DATA_N_net_1;
wire         L1_LP_DATA_net_1;
wire         L2_LP_DATA_N_net_1;
wire         L2_LP_DATA_net_1;
wire         L3_LP_DATA_N_net_1;
wire         L3_LP_DATA_net_1;
wire         RX_CLK_G_net_1;
wire         training_done_o_net_1;
wire   [7:0] L0_RXD_DATA_net_1;
wire   [7:0] L1_RXD_DATA_net_1;
wire   [7:0] L2_RXD_DATA_net_1;
wire   [7:0] L3_RXD_DATA_net_1;
wire   [3:0] EYE_MONITOR_CLEAR_FLAGS_net_0;
wire   [3:0] EYE_MONITOR_EARLY_net_0;
wire   [3:0] EYE_MONITOR_LATE_net_0;
wire   [3:0] DELAY_LINE_MOVE_net_0;
wire   [3:0] DELAY_LINE_DIRECTION_net_0;
wire   [3:0] DELAY_LINE_LOAD_net_0;
wire   [3:0] DELAY_LINE_OUT_OF_RANGE_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire         VCC_net;
wire         GND_net;
wire   [2:0] BIT_ALGN_EYE_IN_const_net_0;
wire   [2:0] BIT_ALGN_EYE_IN_const_net_1;
wire   [2:0] BIT_ALGN_EYE_IN_const_net_2;
wire   [2:0] BIT_ALGN_EYE_IN_const_net_3;
wire   [2:0] EYE_MONITOR_WIDTH_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net                       = 1'b1;
assign GND_net                       = 1'b0;
assign BIT_ALGN_EYE_IN_const_net_0   = 3'h3;
assign BIT_ALGN_EYE_IN_const_net_1   = 3'h3;
assign BIT_ALGN_EYE_IN_const_net_2   = 3'h3;
assign BIT_ALGN_EYE_IN_const_net_3   = 3'h3;
assign EYE_MONITOR_WIDTH_const_net_0 = 3'h3;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign CLK_TRAIN_DONE_net_1  = CLK_TRAIN_DONE_net_0;
assign CLK_TRAIN_DONE        = CLK_TRAIN_DONE_net_1;
assign CLK_TRAIN_ERROR_net_1 = CLK_TRAIN_ERROR_net_0;
assign CLK_TRAIN_ERROR       = CLK_TRAIN_ERROR_net_1;
assign L0_LP_DATA_N_net_1    = L0_LP_DATA_N_net_0;
assign L0_LP_DATA_N          = L0_LP_DATA_N_net_1;
assign L0_LP_DATA_net_1      = L0_LP_DATA_net_0;
assign L0_LP_DATA            = L0_LP_DATA_net_1;
assign L1_LP_DATA_N_net_1    = L1_LP_DATA_N_net_0;
assign L1_LP_DATA_N          = L1_LP_DATA_N_net_1;
assign L1_LP_DATA_net_1      = L1_LP_DATA_net_0;
assign L1_LP_DATA            = L1_LP_DATA_net_1;
assign L2_LP_DATA_N_net_1    = L2_LP_DATA_N_net_0;
assign L2_LP_DATA_N          = L2_LP_DATA_N_net_1;
assign L2_LP_DATA_net_1      = L2_LP_DATA_net_0;
assign L2_LP_DATA            = L2_LP_DATA_net_1;
assign L3_LP_DATA_N_net_1    = L3_LP_DATA_N_net_0;
assign L3_LP_DATA_N          = L3_LP_DATA_N_net_1;
assign L3_LP_DATA_net_1      = L3_LP_DATA_net_0;
assign L3_LP_DATA            = L3_LP_DATA_net_1;
assign RX_CLK_G_net_1        = RX_CLK_G_net_0;
assign RX_CLK_G              = RX_CLK_G_net_1;
assign training_done_o_net_1 = training_done_o_net_0;
assign training_done_o       = training_done_o_net_1;
assign L0_RXD_DATA_net_1     = L0_RXD_DATA_net_0;
assign L0_RXD_DATA[7:0]      = L0_RXD_DATA_net_1;
assign L1_RXD_DATA_net_1     = L1_RXD_DATA_net_0;
assign L1_RXD_DATA[7:0]      = L1_RXD_DATA_net_1;
assign L2_RXD_DATA_net_1     = L2_RXD_DATA_net_0;
assign L2_RXD_DATA[7:0]      = L2_RXD_DATA_net_1;
assign L3_RXD_DATA_net_1     = L3_RXD_DATA_net_0;
assign L3_RXD_DATA[7:0]      = L3_RXD_DATA_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign PF_IOD_0_DELAY_LINE_OUT_OF_RANGE0to0[0] = DELAY_LINE_OUT_OF_RANGE_net_0[0:0];
assign PF_IOD_0_DELAY_LINE_OUT_OF_RANGE1to1[1] = DELAY_LINE_OUT_OF_RANGE_net_0[1:1];
assign PF_IOD_0_DELAY_LINE_OUT_OF_RANGE2to2[2] = DELAY_LINE_OUT_OF_RANGE_net_0[2:2];
assign PF_IOD_0_DELAY_LINE_OUT_OF_RANGE3to3[3] = DELAY_LINE_OUT_OF_RANGE_net_0[3:3];
assign PF_IOD_0_EYE_MONITOR_EARLY0to0[0]       = EYE_MONITOR_EARLY_net_0[0:0];
assign PF_IOD_0_EYE_MONITOR_EARLY1to1[1]       = EYE_MONITOR_EARLY_net_0[1:1];
assign PF_IOD_0_EYE_MONITOR_EARLY2to2[2]       = EYE_MONITOR_EARLY_net_0[2:2];
assign PF_IOD_0_EYE_MONITOR_EARLY3to3[3]       = EYE_MONITOR_EARLY_net_0[3:3];
assign PF_IOD_0_EYE_MONITOR_LATE0to0[0]        = EYE_MONITOR_LATE_net_0[0:0];
assign PF_IOD_0_EYE_MONITOR_LATE1to1[1]        = EYE_MONITOR_LATE_net_0[1:1];
assign PF_IOD_0_EYE_MONITOR_LATE2to2[2]        = EYE_MONITOR_LATE_net_0[2:2];
assign PF_IOD_0_EYE_MONITOR_LATE3to3[3]        = EYE_MONITOR_LATE_net_0[3:3];
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign EYE_MONITOR_CLEAR_FLAGS_net_0 = { CORERXIODBITALIGN_C1_L3_BIT_ALGN_CLR_FLGS , CORERXIODBITALIGN_C1_L2_BIT_ALGN_CLR_FLGS , CORERXIODBITALIGN_C1_L1_BIT_ALGN_CLR_FLGS , CORERXIODBITALIGN_C1_L0_BIT_ALGN_CLR_FLGS };
assign DELAY_LINE_MOVE_net_0         = { CORERXIODBITALIGN_C1_L3_BIT_ALGN_MOVE , CORERXIODBITALIGN_C1_L2_BIT_ALGN_MOVE , CORERXIODBITALIGN_C1_L1_BIT_ALGN_MOVE , CORERXIODBITALIGN_C1_L0_BIT_ALGN_MOVE };
assign DELAY_LINE_DIRECTION_net_0    = { CORERXIODBITALIGN_C1_L3_BIT_ALGN_DIR , CORERXIODBITALIGN_C1_L2_BIT_ALGN_DIR , CORERXIODBITALIGN_C1_L1_BIT_ALGN_DIR , CORERXIODBITALIGN_C1_L0_BIT_ALGN_DIR };
assign DELAY_LINE_LOAD_net_0         = { CORERXIODBITALIGN_C1_L3_BIT_ALGN_LOAD , CORERXIODBITALIGN_C1_L2_BIT_ALGN_LOAD , CORERXIODBITALIGN_C1_L1_BIT_ALGN_LOAD , CORERXIODBITALIGN_C1_L0_BIT_ALGN_LOAD };
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_0(
        // Inputs
        .A ( CORERESET_PF_C1_0_FABRIC_RESET_N ),
        .B ( CLK_TRAIN_DONE_net_0 ),
        // Outputs
        .Y ( AND2_0_Y ) 
        );

//--------AND4
AND4 AND4_0(
        // Inputs
        .A ( CORERXIODBITALIGN_C1_L0_BIT_ALGN_DONE ),
        .B ( CORERXIODBITALIGN_C1_L1_BIT_ALGN_DONE ),
        .C ( CORERXIODBITALIGN_C1_L2_BIT_ALGN_DONE ),
        .D ( CORERXIODBITALIGN_C1_L3_BIT_ALGN_DONE ),
        // Outputs
        .Y ( training_done_o_net_0 ) 
        );

//--------CORERESET_PF_C1
CORERESET_PF_C1 CORERESET_PF_C1_0(
        // Inputs
        .CLK                ( RX_CLK_G_net_0 ),
        .EXT_RST_N          ( TRAINING_RESETN ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( VCC_net ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( VCC_net ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( VCC_net ),
        // Outputs
        .PLL_POWERDOWN_B    (  ),
        .FABRIC_RESET_N     ( CORERESET_PF_C1_0_FABRIC_RESET_N ) 
        );

//--------CORERXIODBITALIGN_C1
CORERXIODBITALIGN_C1 CORERXIODBITALIGN_C1_L0(
        // Inputs
        .SCLK                  ( RX_CLK_G_net_0 ),
        .RESETN                ( AND2_0_Y ),
        .PLL_LOCK              ( PLL_LOCK ),
        .IOD_EARLY             ( PF_IOD_0_EYE_MONITOR_EARLY0to0 ),
        .IOD_LATE              ( PF_IOD_0_EYE_MONITOR_LATE0to0 ),
        .IOD_OOR               ( PF_IOD_0_DELAY_LINE_OUT_OF_RANGE0to0 ),
        .BIT_ALGN_RSTRT        ( RESTART_TRNG ),
        .BIT_ALGN_HOLD         ( GND_net ),
        .BIT_ALGN_EYE_IN       ( BIT_ALGN_EYE_IN_const_net_0 ),
        .LP_IN                 ( L0_LP_DATA_N_net_0 ),
        .BIT_ALGN_SKIP         ( SKIP_TRNG ),
        // Outputs
        .BIT_ALGN_START        (  ),
        .BIT_ALGN_DONE         ( CORERXIODBITALIGN_C1_L0_BIT_ALGN_DONE ),
        .BIT_ALGN_OOR          (  ),
        .BIT_ALGN_CLR_FLGS     ( CORERXIODBITALIGN_C1_L0_BIT_ALGN_CLR_FLGS ),
        .BIT_ALGN_LOAD         ( CORERXIODBITALIGN_C1_L0_BIT_ALGN_LOAD ),
        .BIT_ALGN_DIR          ( CORERXIODBITALIGN_C1_L0_BIT_ALGN_DIR ),
        .BIT_ALGN_MOVE         ( CORERXIODBITALIGN_C1_L0_BIT_ALGN_MOVE ),
        .BIT_ALGN_ERR          (  ),
        .DEM_BIT_ALGN_TAPDLY   (  ),
        .RX_BIT_ALIGN_LEFT_WIN (  ),
        .RX_BIT_ALIGN_RGHT_WIN (  ) 
        );

//--------CORERXIODBITALIGN_C1
CORERXIODBITALIGN_C1 CORERXIODBITALIGN_C1_L1(
        // Inputs
        .SCLK                  ( RX_CLK_G_net_0 ),
        .RESETN                ( AND2_0_Y ),
        .PLL_LOCK              ( PLL_LOCK ),
        .IOD_EARLY             ( PF_IOD_0_EYE_MONITOR_EARLY1to1 ),
        .IOD_LATE              ( PF_IOD_0_EYE_MONITOR_LATE1to1 ),
        .IOD_OOR               ( PF_IOD_0_DELAY_LINE_OUT_OF_RANGE1to1 ),
        .BIT_ALGN_RSTRT        ( RESTART_TRNG ),
        .BIT_ALGN_HOLD         ( GND_net ),
        .BIT_ALGN_EYE_IN       ( BIT_ALGN_EYE_IN_const_net_1 ),
        .LP_IN                 ( L1_LP_DATA_N_net_0 ),
        .BIT_ALGN_SKIP         ( SKIP_TRNG ),
        // Outputs
        .BIT_ALGN_START        (  ),
        .BIT_ALGN_DONE         ( CORERXIODBITALIGN_C1_L1_BIT_ALGN_DONE ),
        .BIT_ALGN_OOR          (  ),
        .BIT_ALGN_CLR_FLGS     ( CORERXIODBITALIGN_C1_L1_BIT_ALGN_CLR_FLGS ),
        .BIT_ALGN_LOAD         ( CORERXIODBITALIGN_C1_L1_BIT_ALGN_LOAD ),
        .BIT_ALGN_DIR          ( CORERXIODBITALIGN_C1_L1_BIT_ALGN_DIR ),
        .BIT_ALGN_MOVE         ( CORERXIODBITALIGN_C1_L1_BIT_ALGN_MOVE ),
        .BIT_ALGN_ERR          (  ),
        .DEM_BIT_ALGN_TAPDLY   (  ),
        .RX_BIT_ALIGN_LEFT_WIN (  ),
        .RX_BIT_ALIGN_RGHT_WIN (  ) 
        );

//--------CORERXIODBITALIGN_C1
CORERXIODBITALIGN_C1 CORERXIODBITALIGN_C1_L2(
        // Inputs
        .SCLK                  ( RX_CLK_G_net_0 ),
        .RESETN                ( AND2_0_Y ),
        .PLL_LOCK              ( PLL_LOCK ),
        .IOD_EARLY             ( PF_IOD_0_EYE_MONITOR_EARLY2to2 ),
        .IOD_LATE              ( PF_IOD_0_EYE_MONITOR_LATE2to2 ),
        .IOD_OOR               ( PF_IOD_0_DELAY_LINE_OUT_OF_RANGE2to2 ),
        .BIT_ALGN_RSTRT        ( RESTART_TRNG ),
        .BIT_ALGN_HOLD         ( GND_net ),
        .BIT_ALGN_EYE_IN       ( BIT_ALGN_EYE_IN_const_net_2 ),
        .LP_IN                 ( L2_LP_DATA_N_net_0 ),
        .BIT_ALGN_SKIP         ( SKIP_TRNG ),
        // Outputs
        .BIT_ALGN_START        (  ),
        .BIT_ALGN_DONE         ( CORERXIODBITALIGN_C1_L2_BIT_ALGN_DONE ),
        .BIT_ALGN_OOR          (  ),
        .BIT_ALGN_CLR_FLGS     ( CORERXIODBITALIGN_C1_L2_BIT_ALGN_CLR_FLGS ),
        .BIT_ALGN_LOAD         ( CORERXIODBITALIGN_C1_L2_BIT_ALGN_LOAD ),
        .BIT_ALGN_DIR          ( CORERXIODBITALIGN_C1_L2_BIT_ALGN_DIR ),
        .BIT_ALGN_MOVE         ( CORERXIODBITALIGN_C1_L2_BIT_ALGN_MOVE ),
        .BIT_ALGN_ERR          (  ),
        .DEM_BIT_ALGN_TAPDLY   (  ),
        .RX_BIT_ALIGN_LEFT_WIN (  ),
        .RX_BIT_ALIGN_RGHT_WIN (  ) 
        );

//--------CORERXIODBITALIGN_C1
CORERXIODBITALIGN_C1 CORERXIODBITALIGN_C1_L3(
        // Inputs
        .SCLK                  ( RX_CLK_G_net_0 ),
        .RESETN                ( AND2_0_Y ),
        .PLL_LOCK              ( PLL_LOCK ),
        .IOD_EARLY             ( PF_IOD_0_EYE_MONITOR_EARLY3to3 ),
        .IOD_LATE              ( PF_IOD_0_EYE_MONITOR_LATE3to3 ),
        .IOD_OOR               ( PF_IOD_0_DELAY_LINE_OUT_OF_RANGE3to3 ),
        .BIT_ALGN_RSTRT        ( RESTART_TRNG ),
        .BIT_ALGN_HOLD         ( GND_net ),
        .BIT_ALGN_EYE_IN       ( BIT_ALGN_EYE_IN_const_net_3 ),
        .LP_IN                 ( L3_LP_DATA_N_net_0 ),
        .BIT_ALGN_SKIP         ( SKIP_TRNG ),
        // Outputs
        .BIT_ALGN_START        (  ),
        .BIT_ALGN_DONE         ( CORERXIODBITALIGN_C1_L3_BIT_ALGN_DONE ),
        .BIT_ALGN_OOR          (  ),
        .BIT_ALGN_CLR_FLGS     ( CORERXIODBITALIGN_C1_L3_BIT_ALGN_CLR_FLGS ),
        .BIT_ALGN_LOAD         ( CORERXIODBITALIGN_C1_L3_BIT_ALGN_LOAD ),
        .BIT_ALGN_DIR          ( CORERXIODBITALIGN_C1_L3_BIT_ALGN_DIR ),
        .BIT_ALGN_MOVE         ( CORERXIODBITALIGN_C1_L3_BIT_ALGN_MOVE ),
        .BIT_ALGN_ERR          (  ),
        .DEM_BIT_ALGN_TAPDLY   (  ),
        .RX_BIT_ALIGN_LEFT_WIN (  ),
        .RX_BIT_ALIGN_RGHT_WIN (  ) 
        );

//--------PF_IOD_GENERIC_RX_C0
PF_IOD_GENERIC_RX_C0 PF_IOD_0(
        // Inputs
        .RX_CLK_P                ( RX_CLK_P ),
        .RX_CLK_N                ( RX_CLK_N ),
        .RXD                     ( RXD ),
        .RXD_N                   ( RXD_N ),
        .HS_SEL                  ( HS_SEL ),
        .EYE_MONITOR_CLEAR_FLAGS ( EYE_MONITOR_CLEAR_FLAGS_net_0 ),
        .DELAY_LINE_MOVE         ( DELAY_LINE_MOVE_net_0 ),
        .DELAY_LINE_DIRECTION    ( DELAY_LINE_DIRECTION_net_0 ),
        .DELAY_LINE_LOAD         ( DELAY_LINE_LOAD_net_0 ),
        .ARST_N                  ( ARST_N ),
        .HS_IO_CLK_PAUSE         ( HS_IO_CLK_PAUSE ),
        .EYE_MONITOR_WIDTH       ( EYE_MONITOR_WIDTH_const_net_0 ),
        // Outputs
        .L0_RXD_DATA             ( L0_RXD_DATA_net_0 ),
        .L1_RXD_DATA             ( L1_RXD_DATA_net_0 ),
        .L2_RXD_DATA             ( L2_RXD_DATA_net_0 ),
        .L3_RXD_DATA             ( L3_RXD_DATA_net_0 ),
        .L0_LP_DATA              ( L0_LP_DATA_net_0 ),
        .L0_LP_DATA_N            ( L0_LP_DATA_N_net_0 ),
        .L1_LP_DATA              ( L1_LP_DATA_net_0 ),
        .L1_LP_DATA_N            ( L1_LP_DATA_N_net_0 ),
        .L2_LP_DATA              ( L2_LP_DATA_net_0 ),
        .L2_LP_DATA_N            ( L2_LP_DATA_N_net_0 ),
        .L3_LP_DATA              ( L3_LP_DATA_net_0 ),
        .L3_LP_DATA_N            ( L3_LP_DATA_N_net_0 ),
        .RX_CLK_G                ( RX_CLK_G_net_0 ),
        .EYE_MONITOR_EARLY       ( EYE_MONITOR_EARLY_net_0 ),
        .EYE_MONITOR_LATE        ( EYE_MONITOR_LATE_net_0 ),
        .DELAY_LINE_OUT_OF_RANGE ( DELAY_LINE_OUT_OF_RANGE_net_0 ),
        .CLK_TRAIN_DONE          ( CLK_TRAIN_DONE_net_0 ),
        .CLK_TRAIN_ERROR         ( CLK_TRAIN_ERROR_net_0 ) 
        );


endmodule
