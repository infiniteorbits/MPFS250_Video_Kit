//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Aug 12 21:30:44 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// VKPFSOC_TOP
module VKPFSOC_TOP(
    // Inputs
    CAM1_RXD,
    CAM1_RXD_N,
    CAM1_RX_CLK_N,
    CAM1_RX_CLK_P,
    LVDS_R0X,
    LVDS_R1X,
    MMUART_0_RXD_F2M,
    MMUART_1_RXD_F2M,
    REFCLK,
    REFCLK_N,
    REF_CLK_PAD_N,
    REF_CLK_PAD_P,
    SD_CD_EMMC_STRB,
    SD_WP_EMMC_RSTN,
    SGMII_RX0_N,
    SGMII_RX0_P,
    SGMII_RX1_N,
    SGMII_RX1_P,
    USB_CLK,
    USB_DIR,
    USB_NXT,
    // Outputs
    CA,
    CAM1_RST,
    CAM_CLK_EN,
    CK,
    CKE,
    CK_N,
    CS,
    DM,
    LED2,
    LED3,
    LVDS_T0X,
    LVDS_T1X,
    MAC_0_MDC,
    MMUART_0_TXD_M2F,
    MMUART_1_TXD_M2F,
    ODT,
    RESET_N,
    SDIO_SW_EN_N,
    SDIO_SW_SEL0,
    SDIO_SW_SEL1,
    SD_CLK_EMMC_CLK,
    SD_POW_EMMC_DATA4,
    SD_VOLT_CMD_DIR_EMMC_DATA7,
    SD_VOLT_DIR_0_EMMC_UNUSED,
    SD_VOLT_DIR_1_3_EMMC_UNUSED,
    SD_VOLT_EN_EMMC_DATA6,
    SD_VOLT_SEL_EMMC_DATA5,
    SGMII_TX0_N,
    SGMII_TX0_P,
    SGMII_TX1_N,
    SGMII_TX1_P,
    TEN,
    USB_STP,
    USB_ULPI_RESET_N,
    VSC_8662_CMODE3,
    VSC_8662_CMODE4,
    VSC_8662_CMODE5,
    VSC_8662_CMODE6,
    VSC_8662_CMODE7,
    VSC_8662_RESETN,
    VSC_8662_SRESET,
    cam1inck,
    cam1xmaster,
    // Inouts
    CAM1_SCL,
    CAM1_SDA,
    DQ,
    DQS,
    DQS_N,
    MAC_0_MDIO,
    SD_CMD_EMMC_CMD,
    SD_DATA0_EMMC_DATA0,
    SD_DATA1_EMMC_DATA1,
    SD_DATA2_EMMC_DATA2,
    SD_DATA3_EMMC_DATA3,
    USB_DATA0,
    USB_DATA1,
    USB_DATA2,
    USB_DATA3,
    USB_DATA4,
    USB_DATA5,
    USB_DATA6,
    USB_DATA7
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [3:0]  CAM1_RXD;
input  [3:0]  CAM1_RXD_N;
input         CAM1_RX_CLK_N;
input         CAM1_RX_CLK_P;
input         LVDS_R0X;
input         LVDS_R1X;
input         MMUART_0_RXD_F2M;
input         MMUART_1_RXD_F2M;
input         REFCLK;
input         REFCLK_N;
input         REF_CLK_PAD_N;
input         REF_CLK_PAD_P;
input         SD_CD_EMMC_STRB;
input         SD_WP_EMMC_RSTN;
input         SGMII_RX0_N;
input         SGMII_RX0_P;
input         SGMII_RX1_N;
input         SGMII_RX1_P;
input         USB_CLK;
input         USB_DIR;
input         USB_NXT;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [5:0]  CA;
output        CAM1_RST;
output        CAM_CLK_EN;
output        CK;
output        CKE;
output        CK_N;
output        CS;
output [3:0]  DM;
output        LED2;
output        LED3;
output        LVDS_T0X;
output        LVDS_T1X;
output        MAC_0_MDC;
output        MMUART_0_TXD_M2F;
output        MMUART_1_TXD_M2F;
output        ODT;
output        RESET_N;
output        SDIO_SW_EN_N;
output        SDIO_SW_SEL0;
output        SDIO_SW_SEL1;
output        SD_CLK_EMMC_CLK;
output        SD_POW_EMMC_DATA4;
output        SD_VOLT_CMD_DIR_EMMC_DATA7;
output        SD_VOLT_DIR_0_EMMC_UNUSED;
output        SD_VOLT_DIR_1_3_EMMC_UNUSED;
output        SD_VOLT_EN_EMMC_DATA6;
output        SD_VOLT_SEL_EMMC_DATA5;
output        SGMII_TX0_N;
output        SGMII_TX0_P;
output        SGMII_TX1_N;
output        SGMII_TX1_P;
output        TEN;
output        USB_STP;
output        USB_ULPI_RESET_N;
output        VSC_8662_CMODE3;
output        VSC_8662_CMODE4;
output        VSC_8662_CMODE5;
output        VSC_8662_CMODE6;
output        VSC_8662_CMODE7;
output        VSC_8662_RESETN;
output        VSC_8662_SRESET;
output        cam1inck;
output        cam1xmaster;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout         CAM1_SCL;
inout         CAM1_SDA;
inout  [31:0] DQ;
inout  [3:0]  DQS;
inout  [3:0]  DQS_N;
inout         MAC_0_MDIO;
inout         SD_CMD_EMMC_CMD;
inout         SD_DATA0_EMMC_DATA0;
inout         SD_DATA1_EMMC_DATA1;
inout         SD_DATA2_EMMC_DATA2;
inout         SD_DATA3_EMMC_DATA3;
inout         USB_DATA0;
inout         USB_DATA1;
inout         USB_DATA2;
inout         USB_DATA3;
inout         USB_DATA4;
inout         USB_DATA5;
inout         USB_DATA6;
inout         USB_DATA7;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          BIBUF_1_Y;
wire          BIBUF_2_Y;
wire   [5:0]  CA_net_0;
wire          CAM1_RST_net_0;
wire          CAM1_RX_CLK_N;
wire          CAM1_RX_CLK_P;
wire   [3:0]  CAM1_RXD;
wire   [3:0]  CAM1_RXD_N;
wire          CAM1_SCL;
wire          CAM1_SDA;
wire          CAM_CLK_EN_net_0;
wire          CK_net_0;
wire          CK_N_net_0;
wire          CKE_net_0;
wire          CLOCKS_AND_RESETS_CLK_50MHz;
wire          CLOCKS_AND_RESETS_CLK_125MHz;
wire          CLOCKS_AND_RESETS_DEVICE_INIT_DONE;
wire          CLOCKS_AND_RESETS_FABRIC_POR_N;
wire          CLOCKS_AND_RESETS_I2C_BCLK;
wire          CLOCKS_AND_RESETS_RESETN_50MHz;
wire          CS_net_0;
wire   [3:0]  DM_net_0;
wire   [31:0] DQ;
wire   [3:0]  DQS;
wire   [3:0]  DQS_N;
wire   [31:0] FIC_CONVERTER_0_APBmslave_PADDR;
wire          FIC_CONVERTER_0_APBmslave_PENABLE;
wire   [31:0] FIC_CONVERTER_0_APBmslave_PRDATA;
wire          FIC_CONVERTER_0_APBmslave_PREADY;
wire          FIC_CONVERTER_0_APBmslave_PSELx;
wire          FIC_CONVERTER_0_APBmslave_PSLVERR;
wire   [31:0] FIC_CONVERTER_0_APBmslave_PWDATA;
wire          FIC_CONVERTER_0_APBmslave_PWRITE;
wire          LED2_net_0;
wire          LED3_net_0;
wire          LVDS_R0X;
wire          LVDS_R1X;
wire          LVDS_T0X_net_0;
wire          LVDS_T1X_net_0;
wire          MAC_0_MDC_net_0;
wire          MAC_0_MDIO;
wire          MMUART_0_RXD_F2M;
wire          MMUART_0_TXD_M2F_net_0;
wire          MMUART_1_RXD_F2M;
wire          MMUART_1_TXD_M2F_net_0;
wire          MSS_FIC_1_DLL_LOCK_M2F;
wire   [31:0] MSS_FIC_3_APB_INITIATOR_PADDR;
wire          MSS_FIC_3_APB_INITIATOR_PENABLE;
wire   [31:0] MSS_FIC_3_APB_INITIATOR_PRDATA;
wire          MSS_FIC_3_APB_INITIATOR_PREADY;
wire          MSS_FIC_3_APB_INITIATOR_PSELx;
wire          MSS_FIC_3_APB_INITIATOR_PSLVERR;
wire   [31:0] MSS_FIC_3_APB_INITIATOR_PWDATA;
wire          MSS_FIC_3_APB_INITIATOR_PWRITE;
wire          MSS_GPIO_2_M2F_4;
wire          MSS_I2C_0_SCL_OE_M2F;
wire          MSS_I2C_0_SDA_OE_M2F;
wire          MSS_MSS_RESET_N_M2F;
wire          ODT_net_0;
wire          REF_CLK_PAD_N;
wire          REF_CLK_PAD_P;
wire          REFCLK;
wire          REFCLK_N;
wire          RESET_N_net_0;
wire          SD_CD_EMMC_STRB;
wire          SD_CLK_EMMC_CLK_net_0;
wire          SD_CMD_EMMC_CMD;
wire          SD_DATA0_EMMC_DATA0;
wire          SD_DATA1_EMMC_DATA1;
wire          SD_DATA2_EMMC_DATA2;
wire          SD_DATA3_EMMC_DATA3;
wire          SD_POW_EMMC_DATA4_net_0;
wire          SD_VOLT_CMD_DIR_EMMC_DATA7_net_0;
wire          SD_VOLT_DIR_0_EMMC_UNUSED_net_0;
wire          SD_VOLT_DIR_1_3_EMMC_UNUSED_net_0;
wire          SD_VOLT_EN_EMMC_DATA6_net_0;
wire          SD_VOLT_SEL_EMMC_DATA5_net_0;
wire          SD_WP_EMMC_RSTN;
wire          SDIO_SW_EN_N_net_0;
wire          SDIO_SW_SEL0_net_0;
wire          SDIO_SW_SEL1_net_0;
wire          SGMII_RX0_N;
wire          SGMII_RX0_P;
wire          SGMII_RX1_N;
wire          SGMII_RX1_P;
wire          SGMII_TX0_N_net_0;
wire          SGMII_TX0_P_net_0;
wire          SGMII_TX1_N_net_0;
wire          SGMII_TX1_P_net_0;
wire          USB_CLK;
wire          USB_DATA0;
wire          USB_DATA1;
wire          USB_DATA2;
wire          USB_DATA3;
wire          USB_DATA4;
wire          USB_DATA5;
wire          USB_DATA6;
wire          USB_DATA7;
wire          USB_DIR;
wire          USB_NXT;
wire          USB_STP_net_0;
wire          USB_ULPI_RESET_N_net_0;
wire   [1:0]  Video_Pipeline_0_BIF_1_ARBURST;
wire   [3:0]  Video_Pipeline_0_BIF_1_ARCACHE;
wire   [3:0]  Video_Pipeline_0_BIF_1_ARID;
wire   [7:0]  Video_Pipeline_0_BIF_1_ARLEN;
wire   [2:0]  Video_Pipeline_0_BIF_1_ARPROT;
wire          Video_Pipeline_0_BIF_1_ARREADY;
wire   [2:0]  Video_Pipeline_0_BIF_1_ARSIZE;
wire          Video_Pipeline_0_BIF_1_ARVALID;
wire   [1:0]  Video_Pipeline_0_BIF_1_AWBURST;
wire   [3:0]  Video_Pipeline_0_BIF_1_AWCACHE;
wire   [3:0]  Video_Pipeline_0_BIF_1_AWID;
wire   [7:0]  Video_Pipeline_0_BIF_1_AWLEN;
wire   [2:0]  Video_Pipeline_0_BIF_1_AWPROT;
wire          Video_Pipeline_0_BIF_1_AWREADY;
wire   [2:0]  Video_Pipeline_0_BIF_1_AWSIZE;
wire          Video_Pipeline_0_BIF_1_AWVALID;
wire   [3:0]  Video_Pipeline_0_BIF_1_BID;
wire          Video_Pipeline_0_BIF_1_BREADY;
wire   [1:0]  Video_Pipeline_0_BIF_1_BRESP;
wire          Video_Pipeline_0_BIF_1_BVALID;
wire   [63:0] Video_Pipeline_0_BIF_1_RDATA;
wire   [3:0]  Video_Pipeline_0_BIF_1_RID;
wire          Video_Pipeline_0_BIF_1_RLAST;
wire          Video_Pipeline_0_BIF_1_RREADY;
wire   [1:0]  Video_Pipeline_0_BIF_1_RRESP;
wire          Video_Pipeline_0_BIF_1_RVALID;
wire   [63:0] Video_Pipeline_0_BIF_1_WDATA;
wire          Video_Pipeline_0_BIF_1_WLAST;
wire          Video_Pipeline_0_BIF_1_WREADY;
wire          Video_Pipeline_0_BIF_1_WVALID;
wire          Video_Pipeline_0_frm_interrupt_o;
wire          VSC_8662_RESETN_net_0;
wire          CAM1_RST_net_1;
wire          CAM_CLK_EN_net_1;
wire          CKE_net_1;
wire          CK_N_net_1;
wire          CK_net_1;
wire          CS_net_1;
wire          LED2_net_1;
wire          LED3_net_1;
wire          MAC_0_MDC_net_1;
wire          MMUART_0_TXD_M2F_net_1;
wire          MMUART_1_TXD_M2F_net_1;
wire          ODT_net_1;
wire          RESET_N_net_1;
wire          SDIO_SW_EN_N_net_1;
wire          SDIO_SW_SEL0_net_1;
wire          SDIO_SW_SEL1_net_1;
wire          SD_CLK_EMMC_CLK_net_1;
wire          SD_POW_EMMC_DATA4_net_1;
wire          SD_VOLT_CMD_DIR_EMMC_DATA7_net_1;
wire          SD_VOLT_DIR_0_EMMC_UNUSED_net_1;
wire          SD_VOLT_DIR_1_3_EMMC_UNUSED_net_1;
wire          SD_VOLT_EN_EMMC_DATA6_net_1;
wire          SD_VOLT_SEL_EMMC_DATA5_net_1;
wire          SGMII_TX0_N_net_1;
wire          SGMII_TX0_P_net_1;
wire          SGMII_TX1_N_net_1;
wire          SGMII_TX1_P_net_1;
wire          USB_STP_net_1;
wire          USB_ULPI_RESET_N_net_1;
wire          VSC_8662_RESETN_net_1;
wire   [5:0]  CA_net_1;
wire   [3:0]  DM_net_1;
wire          LVDS_T1X_net_1;
wire          LVDS_T0X_net_1;
wire   [63:0] MSS_INT_F2M_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire          VCC_net;
wire   [63:1] MSS_INT_F2M_const_net_0;
wire   [3:0]  FIC_1_AXI4_S_AWQOS_const_net_0;
wire   [3:0]  FIC_1_AXI4_S_ARQOS_const_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [31:0] Video_Pipeline_0_BIF_1_ARADDR;
wire   [37:0] Video_Pipeline_0_BIF_1_ARADDR_0;
wire   [31:0] Video_Pipeline_0_BIF_1_ARADDR_0_31to0;
wire   [37:32]Video_Pipeline_0_BIF_1_ARADDR_0_37to32;
wire   [1:0]  Video_Pipeline_0_BIF_1_ARLOCK;
wire          Video_Pipeline_0_BIF_1_ARLOCK_0;
wire   [0:0]  Video_Pipeline_0_BIF_1_ARLOCK_0_0to0;
wire   [31:0] Video_Pipeline_0_BIF_1_AWADDR;
wire   [37:0] Video_Pipeline_0_BIF_1_AWADDR_0;
wire   [31:0] Video_Pipeline_0_BIF_1_AWADDR_0_31to0;
wire   [37:32]Video_Pipeline_0_BIF_1_AWADDR_0_37to32;
wire   [1:0]  Video_Pipeline_0_BIF_1_AWLOCK;
wire          Video_Pipeline_0_BIF_1_AWLOCK_0;
wire   [0:0]  Video_Pipeline_0_BIF_1_AWLOCK_0_0to0;
wire   [63:0] Video_Pipeline_0_BIF_1_WSTRB;
wire   [7:0]  Video_Pipeline_0_BIF_1_WSTRB_0;
wire   [7:0]  Video_Pipeline_0_BIF_1_WSTRB_0_7to0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net                        = 1'b0;
assign VCC_net                        = 1'b1;
assign MSS_INT_F2M_const_net_0        = 63'h0000000000000000;
assign FIC_1_AXI4_S_AWQOS_const_net_0 = 4'h0;
assign FIC_1_AXI4_S_ARQOS_const_net_0 = 4'h0;
//--------------------------------------------------------------------
// TieOff assignments
//--------------------------------------------------------------------
assign TEN                               = 1'b0;
assign VSC_8662_CMODE3                   = 1'b0;
assign VSC_8662_CMODE4                   = 1'b0;
assign VSC_8662_CMODE5                   = 1'b0;
assign VSC_8662_CMODE6                   = 1'b1;
assign VSC_8662_CMODE7                   = 1'b0;
assign VSC_8662_SRESET                   = 1'b1;
assign cam1inck                          = 1'b0;
assign cam1xmaster                       = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign CAM1_RST_net_1                    = CAM1_RST_net_0;
assign CAM1_RST                          = CAM1_RST_net_1;
assign CAM_CLK_EN_net_1                  = CAM_CLK_EN_net_0;
assign CAM_CLK_EN                        = CAM_CLK_EN_net_1;
assign CKE_net_1                         = CKE_net_0;
assign CKE                               = CKE_net_1;
assign CK_N_net_1                        = CK_N_net_0;
assign CK_N                              = CK_N_net_1;
assign CK_net_1                          = CK_net_0;
assign CK                                = CK_net_1;
assign CS_net_1                          = CS_net_0;
assign CS                                = CS_net_1;
assign LED2_net_1                        = LED2_net_0;
assign LED2                              = LED2_net_1;
assign LED3_net_1                        = LED3_net_0;
assign LED3                              = LED3_net_1;
assign MAC_0_MDC_net_1                   = MAC_0_MDC_net_0;
assign MAC_0_MDC                         = MAC_0_MDC_net_1;
assign MMUART_0_TXD_M2F_net_1            = MMUART_0_TXD_M2F_net_0;
assign MMUART_0_TXD_M2F                  = MMUART_0_TXD_M2F_net_1;
assign MMUART_1_TXD_M2F_net_1            = MMUART_1_TXD_M2F_net_0;
assign MMUART_1_TXD_M2F                  = MMUART_1_TXD_M2F_net_1;
assign ODT_net_1                         = ODT_net_0;
assign ODT                               = ODT_net_1;
assign RESET_N_net_1                     = RESET_N_net_0;
assign RESET_N                           = RESET_N_net_1;
assign SDIO_SW_EN_N_net_1                = SDIO_SW_EN_N_net_0;
assign SDIO_SW_EN_N                      = SDIO_SW_EN_N_net_1;
assign SDIO_SW_SEL0_net_1                = SDIO_SW_SEL0_net_0;
assign SDIO_SW_SEL0                      = SDIO_SW_SEL0_net_1;
assign SDIO_SW_SEL1_net_1                = SDIO_SW_SEL1_net_0;
assign SDIO_SW_SEL1                      = SDIO_SW_SEL1_net_1;
assign SD_CLK_EMMC_CLK_net_1             = SD_CLK_EMMC_CLK_net_0;
assign SD_CLK_EMMC_CLK                   = SD_CLK_EMMC_CLK_net_1;
assign SD_POW_EMMC_DATA4_net_1           = SD_POW_EMMC_DATA4_net_0;
assign SD_POW_EMMC_DATA4                 = SD_POW_EMMC_DATA4_net_1;
assign SD_VOLT_CMD_DIR_EMMC_DATA7_net_1  = SD_VOLT_CMD_DIR_EMMC_DATA7_net_0;
assign SD_VOLT_CMD_DIR_EMMC_DATA7        = SD_VOLT_CMD_DIR_EMMC_DATA7_net_1;
assign SD_VOLT_DIR_0_EMMC_UNUSED_net_1   = SD_VOLT_DIR_0_EMMC_UNUSED_net_0;
assign SD_VOLT_DIR_0_EMMC_UNUSED         = SD_VOLT_DIR_0_EMMC_UNUSED_net_1;
assign SD_VOLT_DIR_1_3_EMMC_UNUSED_net_1 = SD_VOLT_DIR_1_3_EMMC_UNUSED_net_0;
assign SD_VOLT_DIR_1_3_EMMC_UNUSED       = SD_VOLT_DIR_1_3_EMMC_UNUSED_net_1;
assign SD_VOLT_EN_EMMC_DATA6_net_1       = SD_VOLT_EN_EMMC_DATA6_net_0;
assign SD_VOLT_EN_EMMC_DATA6             = SD_VOLT_EN_EMMC_DATA6_net_1;
assign SD_VOLT_SEL_EMMC_DATA5_net_1      = SD_VOLT_SEL_EMMC_DATA5_net_0;
assign SD_VOLT_SEL_EMMC_DATA5            = SD_VOLT_SEL_EMMC_DATA5_net_1;
assign SGMII_TX0_N_net_1                 = SGMII_TX0_N_net_0;
assign SGMII_TX0_N                       = SGMII_TX0_N_net_1;
assign SGMII_TX0_P_net_1                 = SGMII_TX0_P_net_0;
assign SGMII_TX0_P                       = SGMII_TX0_P_net_1;
assign SGMII_TX1_N_net_1                 = SGMII_TX1_N_net_0;
assign SGMII_TX1_N                       = SGMII_TX1_N_net_1;
assign SGMII_TX1_P_net_1                 = SGMII_TX1_P_net_0;
assign SGMII_TX1_P                       = SGMII_TX1_P_net_1;
assign USB_STP_net_1                     = USB_STP_net_0;
assign USB_STP                           = USB_STP_net_1;
assign USB_ULPI_RESET_N_net_1            = USB_ULPI_RESET_N_net_0;
assign USB_ULPI_RESET_N                  = USB_ULPI_RESET_N_net_1;
assign VSC_8662_RESETN_net_1             = VSC_8662_RESETN_net_0;
assign VSC_8662_RESETN                   = VSC_8662_RESETN_net_1;
assign CA_net_1                          = CA_net_0;
assign CA[5:0]                           = CA_net_1;
assign DM_net_1                          = DM_net_0;
assign DM[3:0]                           = DM_net_1;
assign LVDS_T1X_net_1                    = LVDS_T1X_net_0;
assign LVDS_T1X                          = LVDS_T1X_net_1;
assign LVDS_T0X_net_1                    = LVDS_T0X_net_0;
assign LVDS_T0X                          = LVDS_T0X_net_1;
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign MSS_INT_F2M_net_0 = { 63'h0000000000000000 , Video_Pipeline_0_frm_interrupt_o };
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign Video_Pipeline_0_BIF_1_ARADDR_0 = { Video_Pipeline_0_BIF_1_ARADDR_0_37to32, Video_Pipeline_0_BIF_1_ARADDR_0_31to0 };
assign Video_Pipeline_0_BIF_1_ARADDR_0_31to0 = Video_Pipeline_0_BIF_1_ARADDR[31:0];
assign Video_Pipeline_0_BIF_1_ARADDR_0_37to32 = 6'h0;

assign Video_Pipeline_0_BIF_1_ARLOCK_0 = { Video_Pipeline_0_BIF_1_ARLOCK_0_0to0 };
assign Video_Pipeline_0_BIF_1_ARLOCK_0_0to0 = Video_Pipeline_0_BIF_1_ARLOCK[0:0];

assign Video_Pipeline_0_BIF_1_AWADDR_0 = { Video_Pipeline_0_BIF_1_AWADDR_0_37to32, Video_Pipeline_0_BIF_1_AWADDR_0_31to0 };
assign Video_Pipeline_0_BIF_1_AWADDR_0_31to0 = Video_Pipeline_0_BIF_1_AWADDR[31:0];
assign Video_Pipeline_0_BIF_1_AWADDR_0_37to32 = 6'h0;

assign Video_Pipeline_0_BIF_1_AWLOCK_0 = { Video_Pipeline_0_BIF_1_AWLOCK_0_0to0 };
assign Video_Pipeline_0_BIF_1_AWLOCK_0_0to0 = Video_Pipeline_0_BIF_1_AWLOCK[0:0];

assign Video_Pipeline_0_BIF_1_WSTRB_0 = { Video_Pipeline_0_BIF_1_WSTRB_0_7to0 };
assign Video_Pipeline_0_BIF_1_WSTRB_0_7to0 = Video_Pipeline_0_BIF_1_WSTRB[7:0];

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------BIBUF
BIBUF BIBUF_1(
        // Inputs
        .D   ( GND_net ),
        .E   ( MSS_I2C_0_SCL_OE_M2F ),
        // Outputs
        .Y   ( BIBUF_1_Y ),
        // Inouts
        .PAD ( CAM1_SCL ) 
        );

//--------BIBUF
BIBUF BIBUF_2(
        // Inputs
        .D   ( GND_net ),
        .E   ( MSS_I2C_0_SDA_OE_M2F ),
        // Outputs
        .Y   ( BIBUF_2_Y ),
        // Inouts
        .PAD ( CAM1_SDA ) 
        );

//--------CLOCKS_AND_RESETS
CLOCKS_AND_RESETS CLOCKS_AND_RESETS_inst_0(
        // Inputs
        .EXT_RST_N        ( MSS_MSS_RESET_N_M2F ),
        .MSS_PLL_LOCKS    ( MSS_FIC_1_DLL_LOCK_M2F ),
        .REF_CLK_PAD_N    ( REF_CLK_PAD_N ),
        .REF_CLK_PAD_P    ( REF_CLK_PAD_P ),
        // Outputs
        .CLK_125MHz       ( CLOCKS_AND_RESETS_CLK_125MHz ),
        .CLK_50MHz        ( CLOCKS_AND_RESETS_CLK_50MHz ),
        .DEVICE_INIT_DONE ( CLOCKS_AND_RESETS_DEVICE_INIT_DONE ),
        .FABRIC_POR_N     ( CLOCKS_AND_RESETS_FABRIC_POR_N ),
        .I2C_BCLK         ( CLOCKS_AND_RESETS_I2C_BCLK ),
        .RESETN_125MHz    ( VSC_8662_RESETN_net_0 ),
        .RESETN_50MHz     ( CLOCKS_AND_RESETS_RESETN_50MHz ) 
        );

//--------FIC_CONVERTER
FIC_CONVERTER FIC_CONVERTER_0(
        // Inputs
        .FIC3_APB3_master_PENABLE ( MSS_FIC_3_APB_INITIATOR_PENABLE ),
        .FIC3_APB3_master_PSEL    ( MSS_FIC_3_APB_INITIATOR_PSELx ),
        .FIC3_APB3_master_PWRITE  ( MSS_FIC_3_APB_INITIATOR_PWRITE ),
        .PREADYS1                 ( FIC_CONVERTER_0_APBmslave_PREADY ),
        .PSLVERRS1                ( FIC_CONVERTER_0_APBmslave_PSLVERR ),
        .FIC3_APB3_master_PADDR   ( MSS_FIC_3_APB_INITIATOR_PADDR ),
        .FIC3_APB3_master_PWDATA  ( MSS_FIC_3_APB_INITIATOR_PWDATA ),
        .PRDATAS1                 ( FIC_CONVERTER_0_APBmslave_PRDATA ),
        // Outputs
        .FIC3_APB3_master_PREADY  ( MSS_FIC_3_APB_INITIATOR_PREADY ),
        .FIC3_APB3_master_PSLVERR ( MSS_FIC_3_APB_INITIATOR_PSLVERR ),
        .PENABLES                 ( FIC_CONVERTER_0_APBmslave_PENABLE ),
        .PSELS1                   ( FIC_CONVERTER_0_APBmslave_PSELx ),
        .PWRITES                  ( FIC_CONVERTER_0_APBmslave_PWRITE ),
        .FIC3_APB3_master_PRDATA  ( MSS_FIC_3_APB_INITIATOR_PRDATA ),
        .PADDRS                   ( FIC_CONVERTER_0_APBmslave_PADDR ),
        .PWDATAS                  ( FIC_CONVERTER_0_APBmslave_PWDATA ) 
        );

//--------MSS_VIDEO_KIT_H264
MSS_VIDEO_KIT_H264 MSS(
        // Inputs
        .FIC_1_ACLK                  ( CLOCKS_AND_RESETS_CLK_125MHz ),
        .FIC_1_AXI4_S_AWID           ( Video_Pipeline_0_BIF_1_AWID ),
        .FIC_1_AXI4_S_AWADDR         ( Video_Pipeline_0_BIF_1_AWADDR_0 ),
        .FIC_1_AXI4_S_AWLEN          ( Video_Pipeline_0_BIF_1_AWLEN ),
        .FIC_1_AXI4_S_AWSIZE         ( Video_Pipeline_0_BIF_1_AWSIZE ),
        .FIC_1_AXI4_S_AWBURST        ( Video_Pipeline_0_BIF_1_AWBURST ),
        .FIC_1_AXI4_S_AWLOCK         ( Video_Pipeline_0_BIF_1_AWLOCK_0 ),
        .FIC_1_AXI4_S_AWCACHE        ( Video_Pipeline_0_BIF_1_AWCACHE ),
        .FIC_1_AXI4_S_AWQOS          ( FIC_1_AXI4_S_AWQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_S_AWPROT         ( Video_Pipeline_0_BIF_1_AWPROT ),
        .FIC_1_AXI4_S_AWVALID        ( Video_Pipeline_0_BIF_1_AWVALID ),
        .FIC_1_AXI4_S_WDATA          ( Video_Pipeline_0_BIF_1_WDATA ),
        .FIC_1_AXI4_S_WSTRB          ( Video_Pipeline_0_BIF_1_WSTRB_0 ),
        .FIC_1_AXI4_S_WLAST          ( Video_Pipeline_0_BIF_1_WLAST ),
        .FIC_1_AXI4_S_WVALID         ( Video_Pipeline_0_BIF_1_WVALID ),
        .FIC_1_AXI4_S_BREADY         ( Video_Pipeline_0_BIF_1_BREADY ),
        .FIC_1_AXI4_S_ARID           ( Video_Pipeline_0_BIF_1_ARID ),
        .FIC_1_AXI4_S_ARADDR         ( Video_Pipeline_0_BIF_1_ARADDR_0 ),
        .FIC_1_AXI4_S_ARLEN          ( Video_Pipeline_0_BIF_1_ARLEN ),
        .FIC_1_AXI4_S_ARSIZE         ( Video_Pipeline_0_BIF_1_ARSIZE ),
        .FIC_1_AXI4_S_ARBURST        ( Video_Pipeline_0_BIF_1_ARBURST ),
        .FIC_1_AXI4_S_ARQOS          ( FIC_1_AXI4_S_ARQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_S_ARLOCK         ( Video_Pipeline_0_BIF_1_ARLOCK_0 ),
        .FIC_1_AXI4_S_ARCACHE        ( Video_Pipeline_0_BIF_1_ARCACHE ),
        .FIC_1_AXI4_S_ARPROT         ( Video_Pipeline_0_BIF_1_ARPROT ),
        .FIC_1_AXI4_S_ARVALID        ( Video_Pipeline_0_BIF_1_ARVALID ),
        .FIC_1_AXI4_S_RREADY         ( Video_Pipeline_0_BIF_1_RREADY ),
        .FIC_3_PCLK                  ( CLOCKS_AND_RESETS_CLK_50MHz ),
        .FIC_3_APB_M_PRDATA          ( MSS_FIC_3_APB_INITIATOR_PRDATA ),
        .FIC_3_APB_M_PREADY          ( MSS_FIC_3_APB_INITIATOR_PREADY ),
        .FIC_3_APB_M_PSLVERR         ( MSS_FIC_3_APB_INITIATOR_PSLVERR ),
        .MMUART_0_RXD_F2M            ( MMUART_0_RXD_F2M ),
        .MMUART_1_RXD_F2M            ( MMUART_1_RXD_F2M ),
        .I2C_0_SCL_F2M               ( BIBUF_1_Y ),
        .I2C_0_SDA_F2M               ( BIBUF_2_Y ),
        .I2C_0_BCLK_F2M              ( CLOCKS_AND_RESETS_I2C_BCLK ),
        .GPIO_2_F2M_29               ( LVDS_R1X ),
        .GPIO_2_F2M_28               ( LVDS_R0X ),
        .GPIO_2_F2M_25               ( VCC_net ),
        .MSS_INT_F2M                 ( MSS_INT_F2M_net_0 ),
        .MSS_RESET_N_F2M             ( CLOCKS_AND_RESETS_FABRIC_POR_N ),
        .USB_CLK                     ( USB_CLK ),
        .USB_DIR                     ( USB_DIR ),
        .USB_NXT                     ( USB_NXT ),
        .SD_CD_EMMC_STRB             ( SD_CD_EMMC_STRB ),
        .SD_WP_EMMC_RSTN             ( SD_WP_EMMC_RSTN ),
        .SGMII_RX1_P                 ( SGMII_RX1_P ),
        .SGMII_RX1_N                 ( SGMII_RX1_N ),
        .SGMII_RX0_P                 ( SGMII_RX0_P ),
        .SGMII_RX0_N                 ( SGMII_RX0_N ),
        .REFCLK                      ( REFCLK ),
        .REFCLK_N                    ( REFCLK_N ),
        // Outputs
        .FIC_1_DLL_LOCK_M2F          ( MSS_FIC_1_DLL_LOCK_M2F ),
        .FIC_3_DLL_LOCK_M2F          (  ),
        .FIC_1_AXI4_S_AWREADY        ( Video_Pipeline_0_BIF_1_AWREADY ),
        .FIC_1_AXI4_S_WREADY         ( Video_Pipeline_0_BIF_1_WREADY ),
        .FIC_1_AXI4_S_BID            ( Video_Pipeline_0_BIF_1_BID ),
        .FIC_1_AXI4_S_BRESP          ( Video_Pipeline_0_BIF_1_BRESP ),
        .FIC_1_AXI4_S_BVALID         ( Video_Pipeline_0_BIF_1_BVALID ),
        .FIC_1_AXI4_S_ARREADY        ( Video_Pipeline_0_BIF_1_ARREADY ),
        .FIC_1_AXI4_S_RID            ( Video_Pipeline_0_BIF_1_RID ),
        .FIC_1_AXI4_S_RDATA          ( Video_Pipeline_0_BIF_1_RDATA ),
        .FIC_1_AXI4_S_RRESP          ( Video_Pipeline_0_BIF_1_RRESP ),
        .FIC_1_AXI4_S_RLAST          ( Video_Pipeline_0_BIF_1_RLAST ),
        .FIC_1_AXI4_S_RVALID         ( Video_Pipeline_0_BIF_1_RVALID ),
        .FIC_3_APB_M_PSEL            ( MSS_FIC_3_APB_INITIATOR_PSELx ),
        .FIC_3_APB_M_PADDR           ( MSS_FIC_3_APB_INITIATOR_PADDR ),
        .FIC_3_APB_M_PWRITE          ( MSS_FIC_3_APB_INITIATOR_PWRITE ),
        .FIC_3_APB_M_PENABLE         ( MSS_FIC_3_APB_INITIATOR_PENABLE ),
        .FIC_3_APB_M_PSTRB           (  ),
        .FIC_3_APB_M_PWDATA          ( MSS_FIC_3_APB_INITIATOR_PWDATA ),
        .MMUART_0_TXD_M2F            ( MMUART_0_TXD_M2F_net_0 ),
        .MMUART_0_TXD_OE_M2F         (  ),
        .MMUART_1_TXD_M2F            ( MMUART_1_TXD_M2F_net_0 ),
        .MMUART_1_TXD_OE_M2F         (  ),
        .I2C_0_SCL_OE_M2F            ( MSS_I2C_0_SCL_OE_M2F ),
        .I2C_0_SDA_OE_M2F            ( MSS_I2C_0_SDA_OE_M2F ),
        .GPIO_2_M2F_31               ( LVDS_T1X_net_0 ),
        .GPIO_2_M2F_30               ( LVDS_T0X_net_0 ),
        .GPIO_2_M2F_19               ( LED3_net_0 ),
        .GPIO_2_M2F_18               ( LED2_net_0 ),
        .GPIO_2_M2F_9                ( CAM_CLK_EN_net_0 ),
        .GPIO_2_M2F_8                ( CAM1_RST_net_0 ),
        .GPIO_2_M2F_4                ( MSS_GPIO_2_M2F_4 ),
        .GPIO_2_M2F_3                (  ),
        .GPIO_2_M2F_2                (  ),
        .GPIO_2_M2F_1                (  ),
        .MSS_INT_M2F                 (  ),
        .PLL_CPU_LOCK_M2F            (  ),
        .PLL_DDR_LOCK_M2F            (  ),
        .PLL_SGMII_LOCK_M2F          (  ),
        .MSS_RESET_N_M2F             ( MSS_MSS_RESET_N_M2F ),
        .CRYPTO_DLL_LOCK_M2F         (  ),
        .CRYPTO_BUSY_M2F             (  ),
        .MAC_0_MDC                   ( MAC_0_MDC_net_0 ),
        .GPIO_1_12_OUT               ( USB_ULPI_RESET_N_net_0 ),
        .GPIO_1_16_OUT               ( SDIO_SW_SEL0_net_0 ),
        .GPIO_1_20_OUT               ( SDIO_SW_SEL1_net_0 ),
        .GPIO_1_23_OUT               ( SDIO_SW_EN_N_net_0 ),
        .USB_STP                     ( USB_STP_net_0 ),
        .SD_CLK_EMMC_CLK             ( SD_CLK_EMMC_CLK_net_0 ),
        .SD_POW_EMMC_DATA4           ( SD_POW_EMMC_DATA4_net_0 ),
        .SD_VOLT_SEL_EMMC_DATA5      ( SD_VOLT_SEL_EMMC_DATA5_net_0 ),
        .SD_VOLT_EN_EMMC_DATA6       ( SD_VOLT_EN_EMMC_DATA6_net_0 ),
        .SD_VOLT_CMD_DIR_EMMC_DATA7  ( SD_VOLT_CMD_DIR_EMMC_DATA7_net_0 ),
        .SD_VOLT_DIR_0_EMMC_UNUSED   ( SD_VOLT_DIR_0_EMMC_UNUSED_net_0 ),
        .SD_VOLT_DIR_1_3_EMMC_UNUSED ( SD_VOLT_DIR_1_3_EMMC_UNUSED_net_0 ),
        .SGMII_TX1_P                 ( SGMII_TX1_P_net_0 ),
        .SGMII_TX1_N                 ( SGMII_TX1_N_net_0 ),
        .SGMII_TX0_P                 ( SGMII_TX0_P_net_0 ),
        .SGMII_TX0_N                 ( SGMII_TX0_N_net_0 ),
        .DM                          ( DM_net_0 ),
        .RESET_N                     ( RESET_N_net_0 ),
        .ODT                         ( ODT_net_0 ),
        .CKE                         ( CKE_net_0 ),
        .CS                          ( CS_net_0 ),
        .CK                          ( CK_net_0 ),
        .CK_N                        ( CK_N_net_0 ),
        .CA                          ( CA_net_0 ),
        // Inouts
        .MAC_0_MDIO                  ( MAC_0_MDIO ),
        .USB_DATA0                   ( USB_DATA0 ),
        .USB_DATA1                   ( USB_DATA1 ),
        .USB_DATA2                   ( USB_DATA2 ),
        .USB_DATA3                   ( USB_DATA3 ),
        .USB_DATA4                   ( USB_DATA4 ),
        .USB_DATA5                   ( USB_DATA5 ),
        .USB_DATA6                   ( USB_DATA6 ),
        .USB_DATA7                   ( USB_DATA7 ),
        .SD_CMD_EMMC_CMD             ( SD_CMD_EMMC_CMD ),
        .SD_DATA0_EMMC_DATA0         ( SD_DATA0_EMMC_DATA0 ),
        .SD_DATA1_EMMC_DATA1         ( SD_DATA1_EMMC_DATA1 ),
        .SD_DATA2_EMMC_DATA2         ( SD_DATA2_EMMC_DATA2 ),
        .SD_DATA3_EMMC_DATA3         ( SD_DATA3_EMMC_DATA3 ),
        .DQ                          ( DQ ),
        .DQS                         ( DQS ),
        .DQS_N                       ( DQS_N ) 
        );

//--------Video_Pipeline
Video_Pipeline Video_Pipeline_0(
        // Inputs
        .CAM1_RX_CLK_N   ( CAM1_RX_CLK_N ),
        .CAM1_RX_CLK_P   ( CAM1_RX_CLK_P ),
        .CLK_125MHz_i    ( CLOCKS_AND_RESETS_CLK_125MHz ),
        .CLK_50MHz_i     ( CLOCKS_AND_RESETS_CLK_50MHz ),
        .INIT_DONE       ( CLOCKS_AND_RESETS_DEVICE_INIT_DONE ),
        .LPDDR4_RDY_i    ( MSS_GPIO_2_M2F_4 ),
        .RESETN_125MHz_i ( VSC_8662_RESETN_net_0 ),
        .RESETN_50MHz_i  ( CLOCKS_AND_RESETS_RESETN_50MHz ),
        .arready         ( Video_Pipeline_0_BIF_1_ARREADY ),
        .awready         ( Video_Pipeline_0_BIF_1_AWREADY ),
        .bvalid          ( Video_Pipeline_0_BIF_1_BVALID ),
        .penable_i       ( FIC_CONVERTER_0_APBmslave_PENABLE ),
        .psel_i          ( FIC_CONVERTER_0_APBmslave_PSELx ),
        .pwrite_i        ( FIC_CONVERTER_0_APBmslave_PWRITE ),
        .rlast           ( Video_Pipeline_0_BIF_1_RLAST ),
        .rvalid          ( Video_Pipeline_0_BIF_1_RVALID ),
        .wready          ( Video_Pipeline_0_BIF_1_WREADY ),
        .CAM1_RXD_N      ( CAM1_RXD_N ),
        .CAM1_RXD        ( CAM1_RXD ),
        .bid             ( Video_Pipeline_0_BIF_1_BID ),
        .bresp           ( Video_Pipeline_0_BIF_1_BRESP ),
        .paddr_i         ( FIC_CONVERTER_0_APBmslave_PADDR ),
        .pwdata_i        ( FIC_CONVERTER_0_APBmslave_PWDATA ),
        .rdata           ( Video_Pipeline_0_BIF_1_RDATA ),
        .rid             ( Video_Pipeline_0_BIF_1_RID ),
        .rresp           ( Video_Pipeline_0_BIF_1_RRESP ),
        // Outputs
        .arvalid         ( Video_Pipeline_0_BIF_1_ARVALID ),
        .awvalid         ( Video_Pipeline_0_BIF_1_AWVALID ),
        .bready          ( Video_Pipeline_0_BIF_1_BREADY ),
        .frm_interrupt_o ( Video_Pipeline_0_frm_interrupt_o ),
        .pready_o        ( FIC_CONVERTER_0_APBmslave_PREADY ),
        .pslverr_o       ( FIC_CONVERTER_0_APBmslave_PSLVERR ),
        .rready          ( Video_Pipeline_0_BIF_1_RREADY ),
        .wlast           ( Video_Pipeline_0_BIF_1_WLAST ),
        .wvalid          ( Video_Pipeline_0_BIF_1_WVALID ),
        .araddr          ( Video_Pipeline_0_BIF_1_ARADDR ),
        .arburst         ( Video_Pipeline_0_BIF_1_ARBURST ),
        .arcache         ( Video_Pipeline_0_BIF_1_ARCACHE ),
        .arid            ( Video_Pipeline_0_BIF_1_ARID ),
        .arlen           ( Video_Pipeline_0_BIF_1_ARLEN ),
        .arlock          ( Video_Pipeline_0_BIF_1_ARLOCK ),
        .arprot          ( Video_Pipeline_0_BIF_1_ARPROT ),
        .arsize          ( Video_Pipeline_0_BIF_1_ARSIZE ),
        .awaddr          ( Video_Pipeline_0_BIF_1_AWADDR ),
        .awburst         ( Video_Pipeline_0_BIF_1_AWBURST ),
        .awcache         ( Video_Pipeline_0_BIF_1_AWCACHE ),
        .awid            ( Video_Pipeline_0_BIF_1_AWID ),
        .awlen           ( Video_Pipeline_0_BIF_1_AWLEN ),
        .awlock          ( Video_Pipeline_0_BIF_1_AWLOCK ),
        .awprot          ( Video_Pipeline_0_BIF_1_AWPROT ),
        .awsize          ( Video_Pipeline_0_BIF_1_AWSIZE ),
        .prdata_o        ( FIC_CONVERTER_0_APBmslave_PRDATA ),
        .wdata           ( Video_Pipeline_0_BIF_1_WDATA ),
        .wstrb           ( Video_Pipeline_0_BIF_1_WSTRB ) 
        );


endmodule
