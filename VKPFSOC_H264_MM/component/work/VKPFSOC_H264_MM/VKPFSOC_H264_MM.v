//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Apr 28 16:01:25 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// VKPFSOC_H264_MM
module VKPFSOC_H264_MM(
    // Inputs
    CAM1_RXD,
    CAM1_RXD_N,
    CAM1_RX_CLK_N,
    CAM1_RX_CLK_P,
    CAN_0_RXBUS,
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
    CAN_0_TXBUS,
    CK,
    CKE,
    CK_N,
    CS,
    DM,
    LED2,
    LED3,
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
input         CAN_0_RXBUS;
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
output        CAN_0_TXBUS;
output        CK;
output        CKE;
output        CK_N;
output        CS;
output [3:0]  DM;
output        LED2;
output        LED3;
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
wire          CAN_0_RXBUS;
wire          CAN_0_TXBUS_net_0;
wire          CK_net_0;
wire          CK_N_net_0;
wire          CKE_net_0;
wire          CLOCKS_AND_RESETS_CLK_125MHz;
wire          CLOCKS_AND_RESETS_DEVICE_INIT_DONE;
wire          CLOCKS_AND_RESETS_FABRIC_POR_N;
wire          CLOCKS_AND_RESETS_I2C_BCLK;
wire          CS_net_0;
wire   [3:0]  DM_net_0;
wire   [31:0] DQ;
wire   [3:0]  DQS;
wire   [3:0]  DQS_N;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_H264_ARBURST;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_H264_ARCACHE;
wire   [8:0]  FIC_CONVERTER_0_AXI4L_H264_ARID;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_H264_ARLEN;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_H264_ARLOCK;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_H264_ARPROT;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_H264_ARQOS;
wire          FIC_CONVERTER_0_AXI4L_H264_ARREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_H264_ARREGION;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_H264_ARSIZE;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_H264_ARUSER;
wire          FIC_CONVERTER_0_AXI4L_H264_ARVALID;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_H264_AWBURST;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_H264_AWCACHE;
wire   [8:0]  FIC_CONVERTER_0_AXI4L_H264_AWID;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_H264_AWLEN;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_H264_AWLOCK;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_H264_AWPROT;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_H264_AWQOS;
wire          FIC_CONVERTER_0_AXI4L_H264_AWREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_H264_AWREGION;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_H264_AWSIZE;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_H264_AWUSER;
wire          FIC_CONVERTER_0_AXI4L_H264_AWVALID;
wire          FIC_CONVERTER_0_AXI4L_H264_BREADY;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_H264_BRESP;
wire          FIC_CONVERTER_0_AXI4L_H264_BVALID;
wire   [31:0] FIC_CONVERTER_0_AXI4L_H264_RDATA;
wire          FIC_CONVERTER_0_AXI4L_H264_RREADY;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_H264_RRESP;
wire          FIC_CONVERTER_0_AXI4L_H264_RVALID;
wire   [31:0] FIC_CONVERTER_0_AXI4L_H264_WDATA;
wire          FIC_CONVERTER_0_AXI4L_H264_WLAST;
wire          FIC_CONVERTER_0_AXI4L_H264_WREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_H264_WSTRB;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_H264_WUSER;
wire          FIC_CONVERTER_0_AXI4L_H264_WVALID;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_IE_ARBURST;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_IE_ARCACHE;
wire   [8:0]  FIC_CONVERTER_0_AXI4L_IE_ARID;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_IE_ARLEN;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_IE_ARLOCK;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_IE_ARPROT;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_IE_ARQOS;
wire          FIC_CONVERTER_0_AXI4L_IE_ARREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_IE_ARREGION;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_IE_ARSIZE;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_IE_ARUSER;
wire          FIC_CONVERTER_0_AXI4L_IE_ARVALID;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_IE_AWBURST;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_IE_AWCACHE;
wire   [8:0]  FIC_CONVERTER_0_AXI4L_IE_AWID;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_IE_AWLEN;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_IE_AWLOCK;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_IE_AWPROT;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_IE_AWQOS;
wire          FIC_CONVERTER_0_AXI4L_IE_AWREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_IE_AWREGION;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_IE_AWSIZE;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_IE_AWUSER;
wire          FIC_CONVERTER_0_AXI4L_IE_AWVALID;
wire          FIC_CONVERTER_0_AXI4L_IE_BREADY;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_IE_BRESP;
wire          FIC_CONVERTER_0_AXI4L_IE_BVALID;
wire   [31:0] FIC_CONVERTER_0_AXI4L_IE_RDATA;
wire          FIC_CONVERTER_0_AXI4L_IE_RREADY;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_IE_RRESP;
wire          FIC_CONVERTER_0_AXI4L_IE_RVALID;
wire   [31:0] FIC_CONVERTER_0_AXI4L_IE_WDATA;
wire          FIC_CONVERTER_0_AXI4L_IE_WLAST;
wire          FIC_CONVERTER_0_AXI4L_IE_WREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_IE_WSTRB;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_IE_WUSER;
wire          FIC_CONVERTER_0_AXI4L_IE_WVALID;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_MIPI_ARBURST;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_MIPI_ARCACHE;
wire   [8:0]  FIC_CONVERTER_0_AXI4L_MIPI_ARID;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_MIPI_ARLEN;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_MIPI_ARLOCK;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_MIPI_ARPROT;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_MIPI_ARQOS;
wire          FIC_CONVERTER_0_AXI4L_MIPI_ARREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_MIPI_ARREGION;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_MIPI_ARSIZE;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_MIPI_ARUSER;
wire          FIC_CONVERTER_0_AXI4L_MIPI_ARVALID;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_MIPI_AWBURST;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_MIPI_AWCACHE;
wire   [8:0]  FIC_CONVERTER_0_AXI4L_MIPI_AWID;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_MIPI_AWLEN;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_MIPI_AWLOCK;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_MIPI_AWPROT;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_MIPI_AWQOS;
wire          FIC_CONVERTER_0_AXI4L_MIPI_AWREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_MIPI_AWREGION;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_MIPI_AWSIZE;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_MIPI_AWUSER;
wire          FIC_CONVERTER_0_AXI4L_MIPI_AWVALID;
wire          FIC_CONVERTER_0_AXI4L_MIPI_BREADY;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_MIPI_BRESP;
wire          FIC_CONVERTER_0_AXI4L_MIPI_BVALID;
wire   [31:0] FIC_CONVERTER_0_AXI4L_MIPI_RDATA;
wire          FIC_CONVERTER_0_AXI4L_MIPI_RREADY;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_MIPI_RRESP;
wire          FIC_CONVERTER_0_AXI4L_MIPI_RVALID;
wire   [31:0] FIC_CONVERTER_0_AXI4L_MIPI_WDATA;
wire          FIC_CONVERTER_0_AXI4L_MIPI_WLAST;
wire          FIC_CONVERTER_0_AXI4L_MIPI_WREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_MIPI_WSTRB;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_MIPI_WUSER;
wire          FIC_CONVERTER_0_AXI4L_MIPI_WVALID;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_OSD_ARBURST;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_OSD_ARCACHE;
wire   [8:0]  FIC_CONVERTER_0_AXI4L_OSD_ARID;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_OSD_ARLEN;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_OSD_ARLOCK;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_OSD_ARPROT;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_OSD_ARQOS;
wire          FIC_CONVERTER_0_AXI4L_OSD_ARREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_OSD_ARREGION;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_OSD_ARSIZE;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_OSD_ARUSER;
wire          FIC_CONVERTER_0_AXI4L_OSD_ARVALID;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_OSD_AWBURST;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_OSD_AWCACHE;
wire   [8:0]  FIC_CONVERTER_0_AXI4L_OSD_AWID;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_OSD_AWLEN;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_OSD_AWLOCK;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_OSD_AWPROT;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_OSD_AWQOS;
wire          FIC_CONVERTER_0_AXI4L_OSD_AWREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_OSD_AWREGION;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_OSD_AWSIZE;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_OSD_AWUSER;
wire          FIC_CONVERTER_0_AXI4L_OSD_AWVALID;
wire          FIC_CONVERTER_0_AXI4L_OSD_BREADY;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_OSD_BRESP;
wire          FIC_CONVERTER_0_AXI4L_OSD_BVALID;
wire          FIC_CONVERTER_0_AXI4L_OSD_RREADY;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_OSD_RRESP;
wire          FIC_CONVERTER_0_AXI4L_OSD_RVALID;
wire          FIC_CONVERTER_0_AXI4L_OSD_WLAST;
wire          FIC_CONVERTER_0_AXI4L_OSD_WREADY;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_OSD_WSTRB;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_OSD_WUSER;
wire          FIC_CONVERTER_0_AXI4L_OSD_WVALID;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_SCALER_ARBURST;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_SCALER_ARCACHE;
wire   [8:0]  FIC_CONVERTER_0_AXI4L_SCALER_ARID;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_SCALER_ARLEN;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_SCALER_ARLOCK;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_SCALER_ARPROT;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_SCALER_ARQOS;
wire          FIC_CONVERTER_0_AXI4L_SCALER_ARREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_SCALER_ARREGION;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_SCALER_ARSIZE;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_SCALER_ARUSER;
wire          FIC_CONVERTER_0_AXI4L_SCALER_ARVALID;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_SCALER_AWBURST;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_SCALER_AWCACHE;
wire   [8:0]  FIC_CONVERTER_0_AXI4L_SCALER_AWID;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_SCALER_AWLEN;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_SCALER_AWLOCK;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_SCALER_AWPROT;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_SCALER_AWQOS;
wire          FIC_CONVERTER_0_AXI4L_SCALER_AWREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_SCALER_AWREGION;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_SCALER_AWSIZE;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_SCALER_AWUSER;
wire          FIC_CONVERTER_0_AXI4L_SCALER_AWVALID;
wire          FIC_CONVERTER_0_AXI4L_SCALER_BREADY;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_SCALER_BRESP;
wire          FIC_CONVERTER_0_AXI4L_SCALER_BVALID;
wire          FIC_CONVERTER_0_AXI4L_SCALER_RREADY;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_SCALER_RRESP;
wire          FIC_CONVERTER_0_AXI4L_SCALER_RVALID;
wire          FIC_CONVERTER_0_AXI4L_SCALER_WLAST;
wire          FIC_CONVERTER_0_AXI4L_SCALER_WREADY;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_SCALER_WSTRB;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_SCALER_WUSER;
wire          FIC_CONVERTER_0_AXI4L_SCALER_WVALID;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_VDMA_ARBURST;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_VDMA_ARCACHE;
wire   [8:0]  FIC_CONVERTER_0_AXI4L_VDMA_ARID;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_VDMA_ARLEN;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_VDMA_ARLOCK;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_VDMA_ARPROT;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_VDMA_ARQOS;
wire          FIC_CONVERTER_0_AXI4L_VDMA_ARREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_VDMA_ARREGION;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_VDMA_ARSIZE;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_VDMA_ARUSER;
wire          FIC_CONVERTER_0_AXI4L_VDMA_ARVALID;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_VDMA_AWBURST;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_VDMA_AWCACHE;
wire   [8:0]  FIC_CONVERTER_0_AXI4L_VDMA_AWID;
wire   [7:0]  FIC_CONVERTER_0_AXI4L_VDMA_AWLEN;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_VDMA_AWLOCK;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_VDMA_AWPROT;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_VDMA_AWQOS;
wire          FIC_CONVERTER_0_AXI4L_VDMA_AWREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_VDMA_AWREGION;
wire   [2:0]  FIC_CONVERTER_0_AXI4L_VDMA_AWSIZE;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_VDMA_AWUSER;
wire          FIC_CONVERTER_0_AXI4L_VDMA_AWVALID;
wire          FIC_CONVERTER_0_AXI4L_VDMA_BREADY;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_VDMA_BRESP;
wire          FIC_CONVERTER_0_AXI4L_VDMA_BVALID;
wire   [31:0] FIC_CONVERTER_0_AXI4L_VDMA_RDATA;
wire          FIC_CONVERTER_0_AXI4L_VDMA_RREADY;
wire   [1:0]  FIC_CONVERTER_0_AXI4L_VDMA_RRESP;
wire          FIC_CONVERTER_0_AXI4L_VDMA_RVALID;
wire   [31:0] FIC_CONVERTER_0_AXI4L_VDMA_WDATA;
wire          FIC_CONVERTER_0_AXI4L_VDMA_WLAST;
wire          FIC_CONVERTER_0_AXI4L_VDMA_WREADY;
wire   [3:0]  FIC_CONVERTER_0_AXI4L_VDMA_WSTRB;
wire   [0:0]  FIC_CONVERTER_0_AXI4L_VDMA_WUSER;
wire          FIC_CONVERTER_0_AXI4L_VDMA_WVALID;
wire          LED2_net_0;
wire          LED3_net_0;
wire          MAC_0_MDC_net_0;
wire          MAC_0_MDIO;
wire          MMUART_0_RXD_F2M;
wire          MMUART_0_TXD_M2F_net_0;
wire          MMUART_1_RXD_F2M;
wire          MMUART_1_TXD_M2F_net_0;
wire   [37:0] MSS_FIC_0_AXI4_INITIATOR_ARADDR;
wire   [1:0]  MSS_FIC_0_AXI4_INITIATOR_ARBURST;
wire   [3:0]  MSS_FIC_0_AXI4_INITIATOR_ARCACHE;
wire   [7:0]  MSS_FIC_0_AXI4_INITIATOR_ARID;
wire   [7:0]  MSS_FIC_0_AXI4_INITIATOR_ARLEN;
wire   [2:0]  MSS_FIC_0_AXI4_INITIATOR_ARPROT;
wire   [3:0]  MSS_FIC_0_AXI4_INITIATOR_ARQOS;
wire          MSS_FIC_0_AXI4_INITIATOR_ARREADY;
wire   [2:0]  MSS_FIC_0_AXI4_INITIATOR_ARSIZE;
wire          MSS_FIC_0_AXI4_INITIATOR_ARVALID;
wire   [37:0] MSS_FIC_0_AXI4_INITIATOR_AWADDR;
wire   [1:0]  MSS_FIC_0_AXI4_INITIATOR_AWBURST;
wire   [3:0]  MSS_FIC_0_AXI4_INITIATOR_AWCACHE;
wire   [7:0]  MSS_FIC_0_AXI4_INITIATOR_AWID;
wire   [7:0]  MSS_FIC_0_AXI4_INITIATOR_AWLEN;
wire   [2:0]  MSS_FIC_0_AXI4_INITIATOR_AWPROT;
wire   [3:0]  MSS_FIC_0_AXI4_INITIATOR_AWQOS;
wire          MSS_FIC_0_AXI4_INITIATOR_AWREADY;
wire   [2:0]  MSS_FIC_0_AXI4_INITIATOR_AWSIZE;
wire          MSS_FIC_0_AXI4_INITIATOR_AWVALID;
wire   [7:0]  MSS_FIC_0_AXI4_INITIATOR_BID;
wire          MSS_FIC_0_AXI4_INITIATOR_BREADY;
wire   [1:0]  MSS_FIC_0_AXI4_INITIATOR_BRESP;
wire   [0:0]  MSS_FIC_0_AXI4_INITIATOR_BUSER;
wire          MSS_FIC_0_AXI4_INITIATOR_BVALID;
wire   [63:0] MSS_FIC_0_AXI4_INITIATOR_RDATA;
wire   [7:0]  MSS_FIC_0_AXI4_INITIATOR_RID;
wire          MSS_FIC_0_AXI4_INITIATOR_RLAST;
wire          MSS_FIC_0_AXI4_INITIATOR_RREADY;
wire   [1:0]  MSS_FIC_0_AXI4_INITIATOR_RRESP;
wire   [0:0]  MSS_FIC_0_AXI4_INITIATOR_RUSER;
wire          MSS_FIC_0_AXI4_INITIATOR_RVALID;
wire   [63:0] MSS_FIC_0_AXI4_INITIATOR_WDATA;
wire          MSS_FIC_0_AXI4_INITIATOR_WLAST;
wire          MSS_FIC_0_AXI4_INITIATOR_WREADY;
wire   [7:0]  MSS_FIC_0_AXI4_INITIATOR_WSTRB;
wire          MSS_FIC_0_AXI4_INITIATOR_WVALID;
wire          MSS_FIC_1_DLL_LOCK_M2F;
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
wire          Video_Pipeline_0_INT_DMA_O;
wire   [37:0] Video_Pipeline_0_mAXI4_SLAVE_ARADDR;
wire   [1:0]  Video_Pipeline_0_mAXI4_SLAVE_ARBURST;
wire   [3:0]  Video_Pipeline_0_mAXI4_SLAVE_ARCACHE;
wire   [3:0]  Video_Pipeline_0_mAXI4_SLAVE_ARID;
wire   [7:0]  Video_Pipeline_0_mAXI4_SLAVE_ARLEN;
wire   [2:0]  Video_Pipeline_0_mAXI4_SLAVE_ARPROT;
wire          Video_Pipeline_0_mAXI4_SLAVE_ARREADY;
wire   [2:0]  Video_Pipeline_0_mAXI4_SLAVE_ARSIZE;
wire          Video_Pipeline_0_mAXI4_SLAVE_ARVALID;
wire   [37:0] Video_Pipeline_0_mAXI4_SLAVE_AWADDR;
wire   [1:0]  Video_Pipeline_0_mAXI4_SLAVE_AWBURST;
wire   [3:0]  Video_Pipeline_0_mAXI4_SLAVE_AWCACHE;
wire   [3:0]  Video_Pipeline_0_mAXI4_SLAVE_AWID;
wire   [7:0]  Video_Pipeline_0_mAXI4_SLAVE_AWLEN;
wire   [2:0]  Video_Pipeline_0_mAXI4_SLAVE_AWPROT;
wire          Video_Pipeline_0_mAXI4_SLAVE_AWREADY;
wire   [2:0]  Video_Pipeline_0_mAXI4_SLAVE_AWSIZE;
wire          Video_Pipeline_0_mAXI4_SLAVE_AWVALID;
wire   [3:0]  Video_Pipeline_0_mAXI4_SLAVE_BID;
wire          Video_Pipeline_0_mAXI4_SLAVE_BREADY;
wire   [1:0]  Video_Pipeline_0_mAXI4_SLAVE_BRESP;
wire          Video_Pipeline_0_mAXI4_SLAVE_BVALID;
wire   [63:0] Video_Pipeline_0_mAXI4_SLAVE_RDATA;
wire   [3:0]  Video_Pipeline_0_mAXI4_SLAVE_RID;
wire          Video_Pipeline_0_mAXI4_SLAVE_RLAST;
wire          Video_Pipeline_0_mAXI4_SLAVE_RREADY;
wire   [1:0]  Video_Pipeline_0_mAXI4_SLAVE_RRESP;
wire          Video_Pipeline_0_mAXI4_SLAVE_RVALID;
wire   [63:0] Video_Pipeline_0_mAXI4_SLAVE_WDATA;
wire          Video_Pipeline_0_mAXI4_SLAVE_WLAST;
wire          Video_Pipeline_0_mAXI4_SLAVE_WREADY;
wire   [7:0]  Video_Pipeline_0_mAXI4_SLAVE_WSTRB;
wire          Video_Pipeline_0_mAXI4_SLAVE_WVALID;
wire          Video_Pipeline_0_MIPI_INTERRUPT_O;
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
wire          CAN_0_TXBUS_net_1;
wire   [5:0]  CA_net_1;
wire   [3:0]  DM_net_1;
wire   [63:0] MSS_INT_F2M_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire          VCC_net;
wire   [63:3] MSS_INT_F2M_const_net_0;
wire   [8:0]  AXI4L_VDMA_SLAVE0_BID_const_net_0;
wire   [8:0]  AXI4L_VDMA_SLAVE0_RID_const_net_0;
wire   [8:0]  AXI4L_MIPI_SLAVE1_BID_const_net_0;
wire   [8:0]  AXI4L_MIPI_SLAVE1_RID_const_net_0;
wire   [8:0]  AXI4L_H264_SLAVE2_BID_const_net_0;
wire   [8:0]  AXI4L_H264_SLAVE2_RID_const_net_0;
wire   [8:0]  AXI4L_IE_SLAVE3_BID_const_net_0;
wire   [8:0]  AXI4L_IE_SLAVE3_RID_const_net_0;
wire   [8:0]  AXI4L_SCALER_SLAVE4_BID_const_net_0;
wire   [8:0]  AXI4L_SCALER_SLAVE4_RID_const_net_0;
wire   [8:0]  AXI4L_OSD_SLAVE5_BID_const_net_0;
wire   [8:0]  AXI4L_OSD_SLAVE5_RID_const_net_0;
wire   [3:0]  AXI4L_MASTER0_AWREGION_const_net_0;
wire   [3:0]  AXI4L_MASTER0_ARREGION_const_net_0;
wire   [3:0]  FIC_1_AXI4_S_AWQOS_const_net_0;
wire   [3:0]  FIC_1_AXI4_S_ARQOS_const_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [37:0] FIC_CONVERTER_0_AXI4L_H264_ARADDR;
wire   [31:0] FIC_CONVERTER_0_AXI4L_H264_ARADDR_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_H264_ARADDR_0_31to0;
wire   [37:0] FIC_CONVERTER_0_AXI4L_H264_AWADDR;
wire   [31:0] FIC_CONVERTER_0_AXI4L_H264_AWADDR_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_H264_AWADDR_0_31to0;
wire   [37:0] FIC_CONVERTER_0_AXI4L_IE_ARADDR;
wire   [31:0] FIC_CONVERTER_0_AXI4L_IE_ARADDR_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_IE_ARADDR_0_31to0;
wire   [37:0] FIC_CONVERTER_0_AXI4L_IE_AWADDR;
wire   [31:0] FIC_CONVERTER_0_AXI4L_IE_AWADDR_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_IE_AWADDR_0_31to0;
wire   [37:0] FIC_CONVERTER_0_AXI4L_MIPI_ARADDR;
wire   [31:0] FIC_CONVERTER_0_AXI4L_MIPI_ARADDR_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_MIPI_ARADDR_0_31to0;
wire   [37:0] FIC_CONVERTER_0_AXI4L_MIPI_AWADDR;
wire   [31:0] FIC_CONVERTER_0_AXI4L_MIPI_AWADDR_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_MIPI_AWADDR_0_31to0;
wire   [37:0] FIC_CONVERTER_0_AXI4L_OSD_ARADDR;
wire   [31:0] FIC_CONVERTER_0_AXI4L_OSD_ARADDR_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_OSD_ARADDR_0_31to0;
wire   [37:0] FIC_CONVERTER_0_AXI4L_OSD_AWADDR;
wire   [31:0] FIC_CONVERTER_0_AXI4L_OSD_AWADDR_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_OSD_AWADDR_0_31to0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_OSD_RDATA;
wire   [63:0] FIC_CONVERTER_0_AXI4L_OSD_RDATA_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_OSD_RDATA_0_31to0;
wire   [63:32]FIC_CONVERTER_0_AXI4L_OSD_RDATA_0_63to32;
wire   [63:0] FIC_CONVERTER_0_AXI4L_OSD_WDATA;
wire   [31:0] FIC_CONVERTER_0_AXI4L_OSD_WDATA_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_OSD_WDATA_0_31to0;
wire   [37:0] FIC_CONVERTER_0_AXI4L_SCALER_ARADDR;
wire   [31:0] FIC_CONVERTER_0_AXI4L_SCALER_ARADDR_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_SCALER_ARADDR_0_31to0;
wire   [37:0] FIC_CONVERTER_0_AXI4L_SCALER_AWADDR;
wire   [31:0] FIC_CONVERTER_0_AXI4L_SCALER_AWADDR_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_SCALER_AWADDR_0_31to0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_SCALER_RDATA;
wire   [63:0] FIC_CONVERTER_0_AXI4L_SCALER_RDATA_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_SCALER_RDATA_0_31to0;
wire   [63:32]FIC_CONVERTER_0_AXI4L_SCALER_RDATA_0_63to32;
wire   [63:0] FIC_CONVERTER_0_AXI4L_SCALER_WDATA;
wire   [31:0] FIC_CONVERTER_0_AXI4L_SCALER_WDATA_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_SCALER_WDATA_0_31to0;
wire   [37:0] FIC_CONVERTER_0_AXI4L_VDMA_ARADDR;
wire   [31:0] FIC_CONVERTER_0_AXI4L_VDMA_ARADDR_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_VDMA_ARADDR_0_31to0;
wire   [37:0] FIC_CONVERTER_0_AXI4L_VDMA_AWADDR;
wire   [31:0] FIC_CONVERTER_0_AXI4L_VDMA_AWADDR_0;
wire   [31:0] FIC_CONVERTER_0_AXI4L_VDMA_AWADDR_0_31to0;
wire          MSS_FIC_0_AXI4_INITIATOR_ARLOCK;
wire   [1:0]  MSS_FIC_0_AXI4_INITIATOR_ARLOCK_0;
wire   [0:0]  MSS_FIC_0_AXI4_INITIATOR_ARLOCK_0_0to0;
wire   [1:1]  MSS_FIC_0_AXI4_INITIATOR_ARLOCK_0_1to1;
wire          MSS_FIC_0_AXI4_INITIATOR_AWLOCK;
wire   [1:0]  MSS_FIC_0_AXI4_INITIATOR_AWLOCK_0;
wire   [0:0]  MSS_FIC_0_AXI4_INITIATOR_AWLOCK_0_0to0;
wire   [1:1]  MSS_FIC_0_AXI4_INITIATOR_AWLOCK_0_1to1;
wire   [1:0]  Video_Pipeline_0_mAXI4_SLAVE_ARLOCK;
wire          Video_Pipeline_0_mAXI4_SLAVE_ARLOCK_0;
wire   [0:0]  Video_Pipeline_0_mAXI4_SLAVE_ARLOCK_0_0to0;
wire   [1:0]  Video_Pipeline_0_mAXI4_SLAVE_AWLOCK;
wire          Video_Pipeline_0_mAXI4_SLAVE_AWLOCK_0;
wire   [0:0]  Video_Pipeline_0_mAXI4_SLAVE_AWLOCK_0_0to0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net                             = 1'b0;
assign VCC_net                             = 1'b1;
assign MSS_INT_F2M_const_net_0             = 61'h0000000000000000;
assign AXI4L_VDMA_SLAVE0_BID_const_net_0   = 9'h000;
assign AXI4L_VDMA_SLAVE0_RID_const_net_0   = 9'h000;
assign AXI4L_MIPI_SLAVE1_BID_const_net_0   = 9'h000;
assign AXI4L_MIPI_SLAVE1_RID_const_net_0   = 9'h000;
assign AXI4L_H264_SLAVE2_BID_const_net_0   = 9'h000;
assign AXI4L_H264_SLAVE2_RID_const_net_0   = 9'h000;
assign AXI4L_IE_SLAVE3_BID_const_net_0     = 9'h000;
assign AXI4L_IE_SLAVE3_RID_const_net_0     = 9'h000;
assign AXI4L_SCALER_SLAVE4_BID_const_net_0 = 9'h000;
assign AXI4L_SCALER_SLAVE4_RID_const_net_0 = 9'h000;
assign AXI4L_OSD_SLAVE5_BID_const_net_0    = 9'h000;
assign AXI4L_OSD_SLAVE5_RID_const_net_0    = 9'h000;
assign AXI4L_MASTER0_AWREGION_const_net_0  = 4'h0;
assign AXI4L_MASTER0_ARREGION_const_net_0  = 4'h0;
assign FIC_1_AXI4_S_AWQOS_const_net_0      = 4'h0;
assign FIC_1_AXI4_S_ARQOS_const_net_0      = 4'h0;
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
assign CAN_0_TXBUS_net_1                 = CAN_0_TXBUS_net_0;
assign CAN_0_TXBUS                       = CAN_0_TXBUS_net_1;
assign CA_net_1                          = CA_net_0;
assign CA[5:0]                           = CA_net_1;
assign DM_net_1                          = DM_net_0;
assign DM[3:0]                           = DM_net_1;
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign MSS_INT_F2M_net_0 = { 61'h0000000000000000 , 1'b0 , Video_Pipeline_0_MIPI_INTERRUPT_O , Video_Pipeline_0_INT_DMA_O };
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign FIC_CONVERTER_0_AXI4L_H264_ARADDR_0 = { FIC_CONVERTER_0_AXI4L_H264_ARADDR_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_H264_ARADDR_0_31to0 = FIC_CONVERTER_0_AXI4L_H264_ARADDR[31:0];

assign FIC_CONVERTER_0_AXI4L_H264_AWADDR_0 = { FIC_CONVERTER_0_AXI4L_H264_AWADDR_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_H264_AWADDR_0_31to0 = FIC_CONVERTER_0_AXI4L_H264_AWADDR[31:0];

assign FIC_CONVERTER_0_AXI4L_IE_ARADDR_0 = { FIC_CONVERTER_0_AXI4L_IE_ARADDR_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_IE_ARADDR_0_31to0 = FIC_CONVERTER_0_AXI4L_IE_ARADDR[31:0];

assign FIC_CONVERTER_0_AXI4L_IE_AWADDR_0 = { FIC_CONVERTER_0_AXI4L_IE_AWADDR_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_IE_AWADDR_0_31to0 = FIC_CONVERTER_0_AXI4L_IE_AWADDR[31:0];

assign FIC_CONVERTER_0_AXI4L_MIPI_ARADDR_0 = { FIC_CONVERTER_0_AXI4L_MIPI_ARADDR_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_MIPI_ARADDR_0_31to0 = FIC_CONVERTER_0_AXI4L_MIPI_ARADDR[31:0];

assign FIC_CONVERTER_0_AXI4L_MIPI_AWADDR_0 = { FIC_CONVERTER_0_AXI4L_MIPI_AWADDR_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_MIPI_AWADDR_0_31to0 = FIC_CONVERTER_0_AXI4L_MIPI_AWADDR[31:0];

assign FIC_CONVERTER_0_AXI4L_OSD_ARADDR_0 = { FIC_CONVERTER_0_AXI4L_OSD_ARADDR_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_OSD_ARADDR_0_31to0 = FIC_CONVERTER_0_AXI4L_OSD_ARADDR[31:0];

assign FIC_CONVERTER_0_AXI4L_OSD_AWADDR_0 = { FIC_CONVERTER_0_AXI4L_OSD_AWADDR_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_OSD_AWADDR_0_31to0 = FIC_CONVERTER_0_AXI4L_OSD_AWADDR[31:0];

assign FIC_CONVERTER_0_AXI4L_OSD_RDATA_0 = { FIC_CONVERTER_0_AXI4L_OSD_RDATA_0_63to32, FIC_CONVERTER_0_AXI4L_OSD_RDATA_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_OSD_RDATA_0_31to0 = FIC_CONVERTER_0_AXI4L_OSD_RDATA[31:0];
assign FIC_CONVERTER_0_AXI4L_OSD_RDATA_0_63to32 = 32'h0;

assign FIC_CONVERTER_0_AXI4L_OSD_WDATA_0 = { FIC_CONVERTER_0_AXI4L_OSD_WDATA_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_OSD_WDATA_0_31to0 = FIC_CONVERTER_0_AXI4L_OSD_WDATA[31:0];

assign FIC_CONVERTER_0_AXI4L_SCALER_ARADDR_0 = { FIC_CONVERTER_0_AXI4L_SCALER_ARADDR_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_SCALER_ARADDR_0_31to0 = FIC_CONVERTER_0_AXI4L_SCALER_ARADDR[31:0];

assign FIC_CONVERTER_0_AXI4L_SCALER_AWADDR_0 = { FIC_CONVERTER_0_AXI4L_SCALER_AWADDR_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_SCALER_AWADDR_0_31to0 = FIC_CONVERTER_0_AXI4L_SCALER_AWADDR[31:0];

assign FIC_CONVERTER_0_AXI4L_SCALER_RDATA_0 = { FIC_CONVERTER_0_AXI4L_SCALER_RDATA_0_63to32, FIC_CONVERTER_0_AXI4L_SCALER_RDATA_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_SCALER_RDATA_0_31to0 = FIC_CONVERTER_0_AXI4L_SCALER_RDATA[31:0];
assign FIC_CONVERTER_0_AXI4L_SCALER_RDATA_0_63to32 = 32'h0;

assign FIC_CONVERTER_0_AXI4L_SCALER_WDATA_0 = { FIC_CONVERTER_0_AXI4L_SCALER_WDATA_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_SCALER_WDATA_0_31to0 = FIC_CONVERTER_0_AXI4L_SCALER_WDATA[31:0];

assign FIC_CONVERTER_0_AXI4L_VDMA_ARADDR_0 = { FIC_CONVERTER_0_AXI4L_VDMA_ARADDR_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_VDMA_ARADDR_0_31to0 = FIC_CONVERTER_0_AXI4L_VDMA_ARADDR[31:0];

assign FIC_CONVERTER_0_AXI4L_VDMA_AWADDR_0 = { FIC_CONVERTER_0_AXI4L_VDMA_AWADDR_0_31to0 };
assign FIC_CONVERTER_0_AXI4L_VDMA_AWADDR_0_31to0 = FIC_CONVERTER_0_AXI4L_VDMA_AWADDR[31:0];

assign MSS_FIC_0_AXI4_INITIATOR_ARLOCK_0 = { MSS_FIC_0_AXI4_INITIATOR_ARLOCK_0_1to1, MSS_FIC_0_AXI4_INITIATOR_ARLOCK_0_0to0 };
assign MSS_FIC_0_AXI4_INITIATOR_ARLOCK_0_0to0 = MSS_FIC_0_AXI4_INITIATOR_ARLOCK;
assign MSS_FIC_0_AXI4_INITIATOR_ARLOCK_0_1to1 = 1'b0;

assign MSS_FIC_0_AXI4_INITIATOR_AWLOCK_0 = { MSS_FIC_0_AXI4_INITIATOR_AWLOCK_0_1to1, MSS_FIC_0_AXI4_INITIATOR_AWLOCK_0_0to0 };
assign MSS_FIC_0_AXI4_INITIATOR_AWLOCK_0_0to0 = MSS_FIC_0_AXI4_INITIATOR_AWLOCK;
assign MSS_FIC_0_AXI4_INITIATOR_AWLOCK_0_1to1 = 1'b0;

assign Video_Pipeline_0_mAXI4_SLAVE_ARLOCK_0 = { Video_Pipeline_0_mAXI4_SLAVE_ARLOCK_0_0to0 };
assign Video_Pipeline_0_mAXI4_SLAVE_ARLOCK_0_0to0 = Video_Pipeline_0_mAXI4_SLAVE_ARLOCK[0:0];

assign Video_Pipeline_0_mAXI4_SLAVE_AWLOCK_0 = { Video_Pipeline_0_mAXI4_SLAVE_AWLOCK_0_0to0 };
assign Video_Pipeline_0_mAXI4_SLAVE_AWLOCK_0_0to0 = Video_Pipeline_0_mAXI4_SLAVE_AWLOCK[0:0];

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
        .DEVICE_INIT_DONE ( CLOCKS_AND_RESETS_DEVICE_INIT_DONE ),
        .FABRIC_POR_N     ( CLOCKS_AND_RESETS_FABRIC_POR_N ),
        .I2C_BCLK         ( CLOCKS_AND_RESETS_I2C_BCLK ),
        .RESETN_125MHz    ( VSC_8662_RESETN_net_0 ) 
        );

//--------FIC_CONVERTER
FIC_CONVERTER FIC_CONVERTER_0(
        // Inputs
        .ACLK                         ( CLOCKS_AND_RESETS_CLK_125MHz ),
        .ARESETN                      ( VSC_8662_RESETN_net_0 ),
        .AXI4L_H264_SLAVE2_ARREADY    ( FIC_CONVERTER_0_AXI4L_H264_ARREADY ),
        .AXI4L_H264_SLAVE2_AWREADY    ( FIC_CONVERTER_0_AXI4L_H264_AWREADY ),
        .AXI4L_H264_SLAVE2_BVALID     ( FIC_CONVERTER_0_AXI4L_H264_BVALID ),
        .AXI4L_H264_SLAVE2_RLAST      ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_H264_SLAVE2_RVALID     ( FIC_CONVERTER_0_AXI4L_H264_RVALID ),
        .AXI4L_H264_SLAVE2_WREADY     ( FIC_CONVERTER_0_AXI4L_H264_WREADY ),
        .AXI4L_IE_SLAVE3_ARREADY      ( FIC_CONVERTER_0_AXI4L_IE_ARREADY ),
        .AXI4L_IE_SLAVE3_AWREADY      ( FIC_CONVERTER_0_AXI4L_IE_AWREADY ),
        .AXI4L_IE_SLAVE3_BVALID       ( FIC_CONVERTER_0_AXI4L_IE_BVALID ),
        .AXI4L_IE_SLAVE3_RLAST        ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_IE_SLAVE3_RVALID       ( FIC_CONVERTER_0_AXI4L_IE_RVALID ),
        .AXI4L_IE_SLAVE3_WREADY       ( FIC_CONVERTER_0_AXI4L_IE_WREADY ),
        .AXI4L_MASTER0_ARVALID        ( MSS_FIC_0_AXI4_INITIATOR_ARVALID ),
        .AXI4L_MASTER0_AWVALID        ( MSS_FIC_0_AXI4_INITIATOR_AWVALID ),
        .AXI4L_MASTER0_BREADY         ( MSS_FIC_0_AXI4_INITIATOR_BREADY ),
        .AXI4L_MASTER0_RREADY         ( MSS_FIC_0_AXI4_INITIATOR_RREADY ),
        .AXI4L_MASTER0_WLAST          ( MSS_FIC_0_AXI4_INITIATOR_WLAST ),
        .AXI4L_MASTER0_WVALID         ( MSS_FIC_0_AXI4_INITIATOR_WVALID ),
        .AXI4L_MIPI_SLAVE1_ARREADY    ( FIC_CONVERTER_0_AXI4L_MIPI_ARREADY ),
        .AXI4L_MIPI_SLAVE1_AWREADY    ( FIC_CONVERTER_0_AXI4L_MIPI_AWREADY ),
        .AXI4L_MIPI_SLAVE1_BVALID     ( FIC_CONVERTER_0_AXI4L_MIPI_BVALID ),
        .AXI4L_MIPI_SLAVE1_RLAST      ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_MIPI_SLAVE1_RVALID     ( FIC_CONVERTER_0_AXI4L_MIPI_RVALID ),
        .AXI4L_MIPI_SLAVE1_WREADY     ( FIC_CONVERTER_0_AXI4L_MIPI_WREADY ),
        .AXI4L_OSD_SLAVE5_ARREADY     ( FIC_CONVERTER_0_AXI4L_OSD_ARREADY ),
        .AXI4L_OSD_SLAVE5_AWREADY     ( FIC_CONVERTER_0_AXI4L_OSD_AWREADY ),
        .AXI4L_OSD_SLAVE5_BVALID      ( FIC_CONVERTER_0_AXI4L_OSD_BVALID ),
        .AXI4L_OSD_SLAVE5_RLAST       ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_OSD_SLAVE5_RVALID      ( FIC_CONVERTER_0_AXI4L_OSD_RVALID ),
        .AXI4L_OSD_SLAVE5_WREADY      ( FIC_CONVERTER_0_AXI4L_OSD_WREADY ),
        .AXI4L_SCALER_SLAVE4_ARREADY  ( FIC_CONVERTER_0_AXI4L_SCALER_ARREADY ),
        .AXI4L_SCALER_SLAVE4_AWREADY  ( FIC_CONVERTER_0_AXI4L_SCALER_AWREADY ),
        .AXI4L_SCALER_SLAVE4_BVALID   ( FIC_CONVERTER_0_AXI4L_SCALER_BVALID ),
        .AXI4L_SCALER_SLAVE4_RLAST    ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_SCALER_SLAVE4_RVALID   ( FIC_CONVERTER_0_AXI4L_SCALER_RVALID ),
        .AXI4L_SCALER_SLAVE4_WREADY   ( FIC_CONVERTER_0_AXI4L_SCALER_WREADY ),
        .AXI4L_VDMA_SLAVE0_ARREADY    ( FIC_CONVERTER_0_AXI4L_VDMA_ARREADY ),
        .AXI4L_VDMA_SLAVE0_AWREADY    ( FIC_CONVERTER_0_AXI4L_VDMA_AWREADY ),
        .AXI4L_VDMA_SLAVE0_BVALID     ( FIC_CONVERTER_0_AXI4L_VDMA_BVALID ),
        .AXI4L_VDMA_SLAVE0_RLAST      ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_VDMA_SLAVE0_RVALID     ( FIC_CONVERTER_0_AXI4L_VDMA_RVALID ),
        .AXI4L_VDMA_SLAVE0_WREADY     ( FIC_CONVERTER_0_AXI4L_VDMA_WREADY ),
        .AXI4L_H264_SLAVE2_BID        ( AXI4L_H264_SLAVE2_BID_const_net_0 ), // tied to 9'h000 from definition
        .AXI4L_H264_SLAVE2_BRESP      ( FIC_CONVERTER_0_AXI4L_H264_BRESP ),
        .AXI4L_H264_SLAVE2_BUSER      ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_H264_SLAVE2_RDATA      ( FIC_CONVERTER_0_AXI4L_H264_RDATA ),
        .AXI4L_H264_SLAVE2_RID        ( AXI4L_H264_SLAVE2_RID_const_net_0 ), // tied to 9'h000 from definition
        .AXI4L_H264_SLAVE2_RRESP      ( FIC_CONVERTER_0_AXI4L_H264_RRESP ),
        .AXI4L_H264_SLAVE2_RUSER      ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_IE_SLAVE3_BID          ( AXI4L_IE_SLAVE3_BID_const_net_0 ), // tied to 9'h000 from definition
        .AXI4L_IE_SLAVE3_BRESP        ( FIC_CONVERTER_0_AXI4L_IE_BRESP ),
        .AXI4L_IE_SLAVE3_BUSER        ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_IE_SLAVE3_RDATA        ( FIC_CONVERTER_0_AXI4L_IE_RDATA ),
        .AXI4L_IE_SLAVE3_RID          ( AXI4L_IE_SLAVE3_RID_const_net_0 ), // tied to 9'h000 from definition
        .AXI4L_IE_SLAVE3_RRESP        ( FIC_CONVERTER_0_AXI4L_IE_RRESP ),
        .AXI4L_IE_SLAVE3_RUSER        ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_MASTER0_ARADDR         ( MSS_FIC_0_AXI4_INITIATOR_ARADDR ),
        .AXI4L_MASTER0_ARBURST        ( MSS_FIC_0_AXI4_INITIATOR_ARBURST ),
        .AXI4L_MASTER0_ARCACHE        ( MSS_FIC_0_AXI4_INITIATOR_ARCACHE ),
        .AXI4L_MASTER0_ARID           ( MSS_FIC_0_AXI4_INITIATOR_ARID ),
        .AXI4L_MASTER0_ARLEN          ( MSS_FIC_0_AXI4_INITIATOR_ARLEN ),
        .AXI4L_MASTER0_ARLOCK         ( MSS_FIC_0_AXI4_INITIATOR_ARLOCK_0 ),
        .AXI4L_MASTER0_ARPROT         ( MSS_FIC_0_AXI4_INITIATOR_ARPROT ),
        .AXI4L_MASTER0_ARQOS          ( MSS_FIC_0_AXI4_INITIATOR_ARQOS ),
        .AXI4L_MASTER0_ARREGION       ( AXI4L_MASTER0_ARREGION_const_net_0 ), // tied to 4'h0 from definition
        .AXI4L_MASTER0_ARSIZE         ( MSS_FIC_0_AXI4_INITIATOR_ARSIZE ),
        .AXI4L_MASTER0_ARUSER         ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_MASTER0_AWADDR         ( MSS_FIC_0_AXI4_INITIATOR_AWADDR ),
        .AXI4L_MASTER0_AWBURST        ( MSS_FIC_0_AXI4_INITIATOR_AWBURST ),
        .AXI4L_MASTER0_AWCACHE        ( MSS_FIC_0_AXI4_INITIATOR_AWCACHE ),
        .AXI4L_MASTER0_AWID           ( MSS_FIC_0_AXI4_INITIATOR_AWID ),
        .AXI4L_MASTER0_AWLEN          ( MSS_FIC_0_AXI4_INITIATOR_AWLEN ),
        .AXI4L_MASTER0_AWLOCK         ( MSS_FIC_0_AXI4_INITIATOR_AWLOCK_0 ),
        .AXI4L_MASTER0_AWPROT         ( MSS_FIC_0_AXI4_INITIATOR_AWPROT ),
        .AXI4L_MASTER0_AWQOS          ( MSS_FIC_0_AXI4_INITIATOR_AWQOS ),
        .AXI4L_MASTER0_AWREGION       ( AXI4L_MASTER0_AWREGION_const_net_0 ), // tied to 4'h0 from definition
        .AXI4L_MASTER0_AWSIZE         ( MSS_FIC_0_AXI4_INITIATOR_AWSIZE ),
        .AXI4L_MASTER0_AWUSER         ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_MASTER0_WDATA          ( MSS_FIC_0_AXI4_INITIATOR_WDATA ),
        .AXI4L_MASTER0_WSTRB          ( MSS_FIC_0_AXI4_INITIATOR_WSTRB ),
        .AXI4L_MASTER0_WUSER          ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_MIPI_SLAVE1_BID        ( AXI4L_MIPI_SLAVE1_BID_const_net_0 ), // tied to 9'h000 from definition
        .AXI4L_MIPI_SLAVE1_BRESP      ( FIC_CONVERTER_0_AXI4L_MIPI_BRESP ),
        .AXI4L_MIPI_SLAVE1_BUSER      ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_MIPI_SLAVE1_RDATA      ( FIC_CONVERTER_0_AXI4L_MIPI_RDATA ),
        .AXI4L_MIPI_SLAVE1_RID        ( AXI4L_MIPI_SLAVE1_RID_const_net_0 ), // tied to 9'h000 from definition
        .AXI4L_MIPI_SLAVE1_RRESP      ( FIC_CONVERTER_0_AXI4L_MIPI_RRESP ),
        .AXI4L_MIPI_SLAVE1_RUSER      ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_OSD_SLAVE5_BID         ( AXI4L_OSD_SLAVE5_BID_const_net_0 ), // tied to 9'h000 from definition
        .AXI4L_OSD_SLAVE5_BRESP       ( FIC_CONVERTER_0_AXI4L_OSD_BRESP ),
        .AXI4L_OSD_SLAVE5_BUSER       ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_OSD_SLAVE5_RDATA       ( FIC_CONVERTER_0_AXI4L_OSD_RDATA_0 ),
        .AXI4L_OSD_SLAVE5_RID         ( AXI4L_OSD_SLAVE5_RID_const_net_0 ), // tied to 9'h000 from definition
        .AXI4L_OSD_SLAVE5_RRESP       ( FIC_CONVERTER_0_AXI4L_OSD_RRESP ),
        .AXI4L_OSD_SLAVE5_RUSER       ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_SCALER_SLAVE4_BID      ( AXI4L_SCALER_SLAVE4_BID_const_net_0 ), // tied to 9'h000 from definition
        .AXI4L_SCALER_SLAVE4_BRESP    ( FIC_CONVERTER_0_AXI4L_SCALER_BRESP ),
        .AXI4L_SCALER_SLAVE4_BUSER    ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_SCALER_SLAVE4_RDATA    ( FIC_CONVERTER_0_AXI4L_SCALER_RDATA_0 ),
        .AXI4L_SCALER_SLAVE4_RID      ( AXI4L_SCALER_SLAVE4_RID_const_net_0 ), // tied to 9'h000 from definition
        .AXI4L_SCALER_SLAVE4_RRESP    ( FIC_CONVERTER_0_AXI4L_SCALER_RRESP ),
        .AXI4L_SCALER_SLAVE4_RUSER    ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_VDMA_SLAVE0_BID        ( AXI4L_VDMA_SLAVE0_BID_const_net_0 ), // tied to 9'h000 from definition
        .AXI4L_VDMA_SLAVE0_BRESP      ( FIC_CONVERTER_0_AXI4L_VDMA_BRESP ),
        .AXI4L_VDMA_SLAVE0_BUSER      ( GND_net ), // tied to 1'b0 from definition
        .AXI4L_VDMA_SLAVE0_RDATA      ( FIC_CONVERTER_0_AXI4L_VDMA_RDATA ),
        .AXI4L_VDMA_SLAVE0_RID        ( AXI4L_VDMA_SLAVE0_RID_const_net_0 ), // tied to 9'h000 from definition
        .AXI4L_VDMA_SLAVE0_RRESP      ( FIC_CONVERTER_0_AXI4L_VDMA_RRESP ),
        .AXI4L_VDMA_SLAVE0_RUSER      ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .AXI4L_H264_SLAVE2_ARVALID    ( FIC_CONVERTER_0_AXI4L_H264_ARVALID ),
        .AXI4L_H264_SLAVE2_AWVALID    ( FIC_CONVERTER_0_AXI4L_H264_AWVALID ),
        .AXI4L_H264_SLAVE2_BREADY     ( FIC_CONVERTER_0_AXI4L_H264_BREADY ),
        .AXI4L_H264_SLAVE2_RREADY     ( FIC_CONVERTER_0_AXI4L_H264_RREADY ),
        .AXI4L_H264_SLAVE2_WLAST      ( FIC_CONVERTER_0_AXI4L_H264_WLAST ),
        .AXI4L_H264_SLAVE2_WVALID     ( FIC_CONVERTER_0_AXI4L_H264_WVALID ),
        .AXI4L_IE_SLAVE3_ARVALID      ( FIC_CONVERTER_0_AXI4L_IE_ARVALID ),
        .AXI4L_IE_SLAVE3_AWVALID      ( FIC_CONVERTER_0_AXI4L_IE_AWVALID ),
        .AXI4L_IE_SLAVE3_BREADY       ( FIC_CONVERTER_0_AXI4L_IE_BREADY ),
        .AXI4L_IE_SLAVE3_RREADY       ( FIC_CONVERTER_0_AXI4L_IE_RREADY ),
        .AXI4L_IE_SLAVE3_WLAST        ( FIC_CONVERTER_0_AXI4L_IE_WLAST ),
        .AXI4L_IE_SLAVE3_WVALID       ( FIC_CONVERTER_0_AXI4L_IE_WVALID ),
        .AXI4L_MASTER0_ARREADY        ( MSS_FIC_0_AXI4_INITIATOR_ARREADY ),
        .AXI4L_MASTER0_AWREADY        ( MSS_FIC_0_AXI4_INITIATOR_AWREADY ),
        .AXI4L_MASTER0_BVALID         ( MSS_FIC_0_AXI4_INITIATOR_BVALID ),
        .AXI4L_MASTER0_RLAST          ( MSS_FIC_0_AXI4_INITIATOR_RLAST ),
        .AXI4L_MASTER0_RVALID         ( MSS_FIC_0_AXI4_INITIATOR_RVALID ),
        .AXI4L_MASTER0_WREADY         ( MSS_FIC_0_AXI4_INITIATOR_WREADY ),
        .AXI4L_MIPI_SLAVE1_ARVALID    ( FIC_CONVERTER_0_AXI4L_MIPI_ARVALID ),
        .AXI4L_MIPI_SLAVE1_AWVALID    ( FIC_CONVERTER_0_AXI4L_MIPI_AWVALID ),
        .AXI4L_MIPI_SLAVE1_BREADY     ( FIC_CONVERTER_0_AXI4L_MIPI_BREADY ),
        .AXI4L_MIPI_SLAVE1_RREADY     ( FIC_CONVERTER_0_AXI4L_MIPI_RREADY ),
        .AXI4L_MIPI_SLAVE1_WLAST      ( FIC_CONVERTER_0_AXI4L_MIPI_WLAST ),
        .AXI4L_MIPI_SLAVE1_WVALID     ( FIC_CONVERTER_0_AXI4L_MIPI_WVALID ),
        .AXI4L_OSD_SLAVE5_ARVALID     ( FIC_CONVERTER_0_AXI4L_OSD_ARVALID ),
        .AXI4L_OSD_SLAVE5_AWVALID     ( FIC_CONVERTER_0_AXI4L_OSD_AWVALID ),
        .AXI4L_OSD_SLAVE5_BREADY      ( FIC_CONVERTER_0_AXI4L_OSD_BREADY ),
        .AXI4L_OSD_SLAVE5_RREADY      ( FIC_CONVERTER_0_AXI4L_OSD_RREADY ),
        .AXI4L_OSD_SLAVE5_WLAST       ( FIC_CONVERTER_0_AXI4L_OSD_WLAST ),
        .AXI4L_OSD_SLAVE5_WVALID      ( FIC_CONVERTER_0_AXI4L_OSD_WVALID ),
        .AXI4L_SCALER_SLAVE4_ARVALID  ( FIC_CONVERTER_0_AXI4L_SCALER_ARVALID ),
        .AXI4L_SCALER_SLAVE4_AWVALID  ( FIC_CONVERTER_0_AXI4L_SCALER_AWVALID ),
        .AXI4L_SCALER_SLAVE4_BREADY   ( FIC_CONVERTER_0_AXI4L_SCALER_BREADY ),
        .AXI4L_SCALER_SLAVE4_RREADY   ( FIC_CONVERTER_0_AXI4L_SCALER_RREADY ),
        .AXI4L_SCALER_SLAVE4_WLAST    ( FIC_CONVERTER_0_AXI4L_SCALER_WLAST ),
        .AXI4L_SCALER_SLAVE4_WVALID   ( FIC_CONVERTER_0_AXI4L_SCALER_WVALID ),
        .AXI4L_VDMA_SLAVE0_ARVALID    ( FIC_CONVERTER_0_AXI4L_VDMA_ARVALID ),
        .AXI4L_VDMA_SLAVE0_AWVALID    ( FIC_CONVERTER_0_AXI4L_VDMA_AWVALID ),
        .AXI4L_VDMA_SLAVE0_BREADY     ( FIC_CONVERTER_0_AXI4L_VDMA_BREADY ),
        .AXI4L_VDMA_SLAVE0_RREADY     ( FIC_CONVERTER_0_AXI4L_VDMA_RREADY ),
        .AXI4L_VDMA_SLAVE0_WLAST      ( FIC_CONVERTER_0_AXI4L_VDMA_WLAST ),
        .AXI4L_VDMA_SLAVE0_WVALID     ( FIC_CONVERTER_0_AXI4L_VDMA_WVALID ),
        .AXI4L_H264_SLAVE2_ARADDR     ( FIC_CONVERTER_0_AXI4L_H264_ARADDR ),
        .AXI4L_H264_SLAVE2_ARBURST    ( FIC_CONVERTER_0_AXI4L_H264_ARBURST ),
        .AXI4L_H264_SLAVE2_ARCACHE    ( FIC_CONVERTER_0_AXI4L_H264_ARCACHE ),
        .AXI4L_H264_SLAVE2_ARID       ( FIC_CONVERTER_0_AXI4L_H264_ARID ),
        .AXI4L_H264_SLAVE2_ARLEN      ( FIC_CONVERTER_0_AXI4L_H264_ARLEN ),
        .AXI4L_H264_SLAVE2_ARLOCK     ( FIC_CONVERTER_0_AXI4L_H264_ARLOCK ),
        .AXI4L_H264_SLAVE2_ARPROT     ( FIC_CONVERTER_0_AXI4L_H264_ARPROT ),
        .AXI4L_H264_SLAVE2_ARQOS      ( FIC_CONVERTER_0_AXI4L_H264_ARQOS ),
        .AXI4L_H264_SLAVE2_ARREGION   ( FIC_CONVERTER_0_AXI4L_H264_ARREGION ),
        .AXI4L_H264_SLAVE2_ARSIZE     ( FIC_CONVERTER_0_AXI4L_H264_ARSIZE ),
        .AXI4L_H264_SLAVE2_ARUSER     ( FIC_CONVERTER_0_AXI4L_H264_ARUSER ),
        .AXI4L_H264_SLAVE2_AWADDR     ( FIC_CONVERTER_0_AXI4L_H264_AWADDR ),
        .AXI4L_H264_SLAVE2_AWBURST    ( FIC_CONVERTER_0_AXI4L_H264_AWBURST ),
        .AXI4L_H264_SLAVE2_AWCACHE    ( FIC_CONVERTER_0_AXI4L_H264_AWCACHE ),
        .AXI4L_H264_SLAVE2_AWID       ( FIC_CONVERTER_0_AXI4L_H264_AWID ),
        .AXI4L_H264_SLAVE2_AWLEN      ( FIC_CONVERTER_0_AXI4L_H264_AWLEN ),
        .AXI4L_H264_SLAVE2_AWLOCK     ( FIC_CONVERTER_0_AXI4L_H264_AWLOCK ),
        .AXI4L_H264_SLAVE2_AWPROT     ( FIC_CONVERTER_0_AXI4L_H264_AWPROT ),
        .AXI4L_H264_SLAVE2_AWQOS      ( FIC_CONVERTER_0_AXI4L_H264_AWQOS ),
        .AXI4L_H264_SLAVE2_AWREGION   ( FIC_CONVERTER_0_AXI4L_H264_AWREGION ),
        .AXI4L_H264_SLAVE2_AWSIZE     ( FIC_CONVERTER_0_AXI4L_H264_AWSIZE ),
        .AXI4L_H264_SLAVE2_AWUSER     ( FIC_CONVERTER_0_AXI4L_H264_AWUSER ),
        .AXI4L_H264_SLAVE2_WDATA      ( FIC_CONVERTER_0_AXI4L_H264_WDATA ),
        .AXI4L_H264_SLAVE2_WSTRB      ( FIC_CONVERTER_0_AXI4L_H264_WSTRB ),
        .AXI4L_H264_SLAVE2_WUSER      ( FIC_CONVERTER_0_AXI4L_H264_WUSER ),
        .AXI4L_IE_SLAVE3_ARADDR       ( FIC_CONVERTER_0_AXI4L_IE_ARADDR ),
        .AXI4L_IE_SLAVE3_ARBURST      ( FIC_CONVERTER_0_AXI4L_IE_ARBURST ),
        .AXI4L_IE_SLAVE3_ARCACHE      ( FIC_CONVERTER_0_AXI4L_IE_ARCACHE ),
        .AXI4L_IE_SLAVE3_ARID         ( FIC_CONVERTER_0_AXI4L_IE_ARID ),
        .AXI4L_IE_SLAVE3_ARLEN        ( FIC_CONVERTER_0_AXI4L_IE_ARLEN ),
        .AXI4L_IE_SLAVE3_ARLOCK       ( FIC_CONVERTER_0_AXI4L_IE_ARLOCK ),
        .AXI4L_IE_SLAVE3_ARPROT       ( FIC_CONVERTER_0_AXI4L_IE_ARPROT ),
        .AXI4L_IE_SLAVE3_ARQOS        ( FIC_CONVERTER_0_AXI4L_IE_ARQOS ),
        .AXI4L_IE_SLAVE3_ARREGION     ( FIC_CONVERTER_0_AXI4L_IE_ARREGION ),
        .AXI4L_IE_SLAVE3_ARSIZE       ( FIC_CONVERTER_0_AXI4L_IE_ARSIZE ),
        .AXI4L_IE_SLAVE3_ARUSER       ( FIC_CONVERTER_0_AXI4L_IE_ARUSER ),
        .AXI4L_IE_SLAVE3_AWADDR       ( FIC_CONVERTER_0_AXI4L_IE_AWADDR ),
        .AXI4L_IE_SLAVE3_AWBURST      ( FIC_CONVERTER_0_AXI4L_IE_AWBURST ),
        .AXI4L_IE_SLAVE3_AWCACHE      ( FIC_CONVERTER_0_AXI4L_IE_AWCACHE ),
        .AXI4L_IE_SLAVE3_AWID         ( FIC_CONVERTER_0_AXI4L_IE_AWID ),
        .AXI4L_IE_SLAVE3_AWLEN        ( FIC_CONVERTER_0_AXI4L_IE_AWLEN ),
        .AXI4L_IE_SLAVE3_AWLOCK       ( FIC_CONVERTER_0_AXI4L_IE_AWLOCK ),
        .AXI4L_IE_SLAVE3_AWPROT       ( FIC_CONVERTER_0_AXI4L_IE_AWPROT ),
        .AXI4L_IE_SLAVE3_AWQOS        ( FIC_CONVERTER_0_AXI4L_IE_AWQOS ),
        .AXI4L_IE_SLAVE3_AWREGION     ( FIC_CONVERTER_0_AXI4L_IE_AWREGION ),
        .AXI4L_IE_SLAVE3_AWSIZE       ( FIC_CONVERTER_0_AXI4L_IE_AWSIZE ),
        .AXI4L_IE_SLAVE3_AWUSER       ( FIC_CONVERTER_0_AXI4L_IE_AWUSER ),
        .AXI4L_IE_SLAVE3_WDATA        ( FIC_CONVERTER_0_AXI4L_IE_WDATA ),
        .AXI4L_IE_SLAVE3_WSTRB        ( FIC_CONVERTER_0_AXI4L_IE_WSTRB ),
        .AXI4L_IE_SLAVE3_WUSER        ( FIC_CONVERTER_0_AXI4L_IE_WUSER ),
        .AXI4L_MASTER0_BID            ( MSS_FIC_0_AXI4_INITIATOR_BID ),
        .AXI4L_MASTER0_BRESP          ( MSS_FIC_0_AXI4_INITIATOR_BRESP ),
        .AXI4L_MASTER0_BUSER          ( MSS_FIC_0_AXI4_INITIATOR_BUSER ),
        .AXI4L_MASTER0_RDATA          ( MSS_FIC_0_AXI4_INITIATOR_RDATA ),
        .AXI4L_MASTER0_RID            ( MSS_FIC_0_AXI4_INITIATOR_RID ),
        .AXI4L_MASTER0_RRESP          ( MSS_FIC_0_AXI4_INITIATOR_RRESP ),
        .AXI4L_MASTER0_RUSER          ( MSS_FIC_0_AXI4_INITIATOR_RUSER ),
        .AXI4L_MIPI_SLAVE1_ARADDR     ( FIC_CONVERTER_0_AXI4L_MIPI_ARADDR ),
        .AXI4L_MIPI_SLAVE1_ARBURST    ( FIC_CONVERTER_0_AXI4L_MIPI_ARBURST ),
        .AXI4L_MIPI_SLAVE1_ARCACHE    ( FIC_CONVERTER_0_AXI4L_MIPI_ARCACHE ),
        .AXI4L_MIPI_SLAVE1_ARID       ( FIC_CONVERTER_0_AXI4L_MIPI_ARID ),
        .AXI4L_MIPI_SLAVE1_ARLEN      ( FIC_CONVERTER_0_AXI4L_MIPI_ARLEN ),
        .AXI4L_MIPI_SLAVE1_ARLOCK     ( FIC_CONVERTER_0_AXI4L_MIPI_ARLOCK ),
        .AXI4L_MIPI_SLAVE1_ARPROT     ( FIC_CONVERTER_0_AXI4L_MIPI_ARPROT ),
        .AXI4L_MIPI_SLAVE1_ARQOS      ( FIC_CONVERTER_0_AXI4L_MIPI_ARQOS ),
        .AXI4L_MIPI_SLAVE1_ARREGION   ( FIC_CONVERTER_0_AXI4L_MIPI_ARREGION ),
        .AXI4L_MIPI_SLAVE1_ARSIZE     ( FIC_CONVERTER_0_AXI4L_MIPI_ARSIZE ),
        .AXI4L_MIPI_SLAVE1_ARUSER     ( FIC_CONVERTER_0_AXI4L_MIPI_ARUSER ),
        .AXI4L_MIPI_SLAVE1_AWADDR     ( FIC_CONVERTER_0_AXI4L_MIPI_AWADDR ),
        .AXI4L_MIPI_SLAVE1_AWBURST    ( FIC_CONVERTER_0_AXI4L_MIPI_AWBURST ),
        .AXI4L_MIPI_SLAVE1_AWCACHE    ( FIC_CONVERTER_0_AXI4L_MIPI_AWCACHE ),
        .AXI4L_MIPI_SLAVE1_AWID       ( FIC_CONVERTER_0_AXI4L_MIPI_AWID ),
        .AXI4L_MIPI_SLAVE1_AWLEN      ( FIC_CONVERTER_0_AXI4L_MIPI_AWLEN ),
        .AXI4L_MIPI_SLAVE1_AWLOCK     ( FIC_CONVERTER_0_AXI4L_MIPI_AWLOCK ),
        .AXI4L_MIPI_SLAVE1_AWPROT     ( FIC_CONVERTER_0_AXI4L_MIPI_AWPROT ),
        .AXI4L_MIPI_SLAVE1_AWQOS      ( FIC_CONVERTER_0_AXI4L_MIPI_AWQOS ),
        .AXI4L_MIPI_SLAVE1_AWREGION   ( FIC_CONVERTER_0_AXI4L_MIPI_AWREGION ),
        .AXI4L_MIPI_SLAVE1_AWSIZE     ( FIC_CONVERTER_0_AXI4L_MIPI_AWSIZE ),
        .AXI4L_MIPI_SLAVE1_AWUSER     ( FIC_CONVERTER_0_AXI4L_MIPI_AWUSER ),
        .AXI4L_MIPI_SLAVE1_WDATA      ( FIC_CONVERTER_0_AXI4L_MIPI_WDATA ),
        .AXI4L_MIPI_SLAVE1_WSTRB      ( FIC_CONVERTER_0_AXI4L_MIPI_WSTRB ),
        .AXI4L_MIPI_SLAVE1_WUSER      ( FIC_CONVERTER_0_AXI4L_MIPI_WUSER ),
        .AXI4L_OSD_SLAVE5_ARADDR      ( FIC_CONVERTER_0_AXI4L_OSD_ARADDR ),
        .AXI4L_OSD_SLAVE5_ARBURST     ( FIC_CONVERTER_0_AXI4L_OSD_ARBURST ),
        .AXI4L_OSD_SLAVE5_ARCACHE     ( FIC_CONVERTER_0_AXI4L_OSD_ARCACHE ),
        .AXI4L_OSD_SLAVE5_ARID        ( FIC_CONVERTER_0_AXI4L_OSD_ARID ),
        .AXI4L_OSD_SLAVE5_ARLEN       ( FIC_CONVERTER_0_AXI4L_OSD_ARLEN ),
        .AXI4L_OSD_SLAVE5_ARLOCK      ( FIC_CONVERTER_0_AXI4L_OSD_ARLOCK ),
        .AXI4L_OSD_SLAVE5_ARPROT      ( FIC_CONVERTER_0_AXI4L_OSD_ARPROT ),
        .AXI4L_OSD_SLAVE5_ARQOS       ( FIC_CONVERTER_0_AXI4L_OSD_ARQOS ),
        .AXI4L_OSD_SLAVE5_ARREGION    ( FIC_CONVERTER_0_AXI4L_OSD_ARREGION ),
        .AXI4L_OSD_SLAVE5_ARSIZE      ( FIC_CONVERTER_0_AXI4L_OSD_ARSIZE ),
        .AXI4L_OSD_SLAVE5_ARUSER      ( FIC_CONVERTER_0_AXI4L_OSD_ARUSER ),
        .AXI4L_OSD_SLAVE5_AWADDR      ( FIC_CONVERTER_0_AXI4L_OSD_AWADDR ),
        .AXI4L_OSD_SLAVE5_AWBURST     ( FIC_CONVERTER_0_AXI4L_OSD_AWBURST ),
        .AXI4L_OSD_SLAVE5_AWCACHE     ( FIC_CONVERTER_0_AXI4L_OSD_AWCACHE ),
        .AXI4L_OSD_SLAVE5_AWID        ( FIC_CONVERTER_0_AXI4L_OSD_AWID ),
        .AXI4L_OSD_SLAVE5_AWLEN       ( FIC_CONVERTER_0_AXI4L_OSD_AWLEN ),
        .AXI4L_OSD_SLAVE5_AWLOCK      ( FIC_CONVERTER_0_AXI4L_OSD_AWLOCK ),
        .AXI4L_OSD_SLAVE5_AWPROT      ( FIC_CONVERTER_0_AXI4L_OSD_AWPROT ),
        .AXI4L_OSD_SLAVE5_AWQOS       ( FIC_CONVERTER_0_AXI4L_OSD_AWQOS ),
        .AXI4L_OSD_SLAVE5_AWREGION    ( FIC_CONVERTER_0_AXI4L_OSD_AWREGION ),
        .AXI4L_OSD_SLAVE5_AWSIZE      ( FIC_CONVERTER_0_AXI4L_OSD_AWSIZE ),
        .AXI4L_OSD_SLAVE5_AWUSER      ( FIC_CONVERTER_0_AXI4L_OSD_AWUSER ),
        .AXI4L_OSD_SLAVE5_WDATA       ( FIC_CONVERTER_0_AXI4L_OSD_WDATA ),
        .AXI4L_OSD_SLAVE5_WSTRB       ( FIC_CONVERTER_0_AXI4L_OSD_WSTRB ),
        .AXI4L_OSD_SLAVE5_WUSER       ( FIC_CONVERTER_0_AXI4L_OSD_WUSER ),
        .AXI4L_SCALER_SLAVE4_ARADDR   ( FIC_CONVERTER_0_AXI4L_SCALER_ARADDR ),
        .AXI4L_SCALER_SLAVE4_ARBURST  ( FIC_CONVERTER_0_AXI4L_SCALER_ARBURST ),
        .AXI4L_SCALER_SLAVE4_ARCACHE  ( FIC_CONVERTER_0_AXI4L_SCALER_ARCACHE ),
        .AXI4L_SCALER_SLAVE4_ARID     ( FIC_CONVERTER_0_AXI4L_SCALER_ARID ),
        .AXI4L_SCALER_SLAVE4_ARLEN    ( FIC_CONVERTER_0_AXI4L_SCALER_ARLEN ),
        .AXI4L_SCALER_SLAVE4_ARLOCK   ( FIC_CONVERTER_0_AXI4L_SCALER_ARLOCK ),
        .AXI4L_SCALER_SLAVE4_ARPROT   ( FIC_CONVERTER_0_AXI4L_SCALER_ARPROT ),
        .AXI4L_SCALER_SLAVE4_ARQOS    ( FIC_CONVERTER_0_AXI4L_SCALER_ARQOS ),
        .AXI4L_SCALER_SLAVE4_ARREGION ( FIC_CONVERTER_0_AXI4L_SCALER_ARREGION ),
        .AXI4L_SCALER_SLAVE4_ARSIZE   ( FIC_CONVERTER_0_AXI4L_SCALER_ARSIZE ),
        .AXI4L_SCALER_SLAVE4_ARUSER   ( FIC_CONVERTER_0_AXI4L_SCALER_ARUSER ),
        .AXI4L_SCALER_SLAVE4_AWADDR   ( FIC_CONVERTER_0_AXI4L_SCALER_AWADDR ),
        .AXI4L_SCALER_SLAVE4_AWBURST  ( FIC_CONVERTER_0_AXI4L_SCALER_AWBURST ),
        .AXI4L_SCALER_SLAVE4_AWCACHE  ( FIC_CONVERTER_0_AXI4L_SCALER_AWCACHE ),
        .AXI4L_SCALER_SLAVE4_AWID     ( FIC_CONVERTER_0_AXI4L_SCALER_AWID ),
        .AXI4L_SCALER_SLAVE4_AWLEN    ( FIC_CONVERTER_0_AXI4L_SCALER_AWLEN ),
        .AXI4L_SCALER_SLAVE4_AWLOCK   ( FIC_CONVERTER_0_AXI4L_SCALER_AWLOCK ),
        .AXI4L_SCALER_SLAVE4_AWPROT   ( FIC_CONVERTER_0_AXI4L_SCALER_AWPROT ),
        .AXI4L_SCALER_SLAVE4_AWQOS    ( FIC_CONVERTER_0_AXI4L_SCALER_AWQOS ),
        .AXI4L_SCALER_SLAVE4_AWREGION ( FIC_CONVERTER_0_AXI4L_SCALER_AWREGION ),
        .AXI4L_SCALER_SLAVE4_AWSIZE   ( FIC_CONVERTER_0_AXI4L_SCALER_AWSIZE ),
        .AXI4L_SCALER_SLAVE4_AWUSER   ( FIC_CONVERTER_0_AXI4L_SCALER_AWUSER ),
        .AXI4L_SCALER_SLAVE4_WDATA    ( FIC_CONVERTER_0_AXI4L_SCALER_WDATA ),
        .AXI4L_SCALER_SLAVE4_WSTRB    ( FIC_CONVERTER_0_AXI4L_SCALER_WSTRB ),
        .AXI4L_SCALER_SLAVE4_WUSER    ( FIC_CONVERTER_0_AXI4L_SCALER_WUSER ),
        .AXI4L_VDMA_SLAVE0_ARADDR     ( FIC_CONVERTER_0_AXI4L_VDMA_ARADDR ),
        .AXI4L_VDMA_SLAVE0_ARBURST    ( FIC_CONVERTER_0_AXI4L_VDMA_ARBURST ),
        .AXI4L_VDMA_SLAVE0_ARCACHE    ( FIC_CONVERTER_0_AXI4L_VDMA_ARCACHE ),
        .AXI4L_VDMA_SLAVE0_ARID       ( FIC_CONVERTER_0_AXI4L_VDMA_ARID ),
        .AXI4L_VDMA_SLAVE0_ARLEN      ( FIC_CONVERTER_0_AXI4L_VDMA_ARLEN ),
        .AXI4L_VDMA_SLAVE0_ARLOCK     ( FIC_CONVERTER_0_AXI4L_VDMA_ARLOCK ),
        .AXI4L_VDMA_SLAVE0_ARPROT     ( FIC_CONVERTER_0_AXI4L_VDMA_ARPROT ),
        .AXI4L_VDMA_SLAVE0_ARQOS      ( FIC_CONVERTER_0_AXI4L_VDMA_ARQOS ),
        .AXI4L_VDMA_SLAVE0_ARREGION   ( FIC_CONVERTER_0_AXI4L_VDMA_ARREGION ),
        .AXI4L_VDMA_SLAVE0_ARSIZE     ( FIC_CONVERTER_0_AXI4L_VDMA_ARSIZE ),
        .AXI4L_VDMA_SLAVE0_ARUSER     ( FIC_CONVERTER_0_AXI4L_VDMA_ARUSER ),
        .AXI4L_VDMA_SLAVE0_AWADDR     ( FIC_CONVERTER_0_AXI4L_VDMA_AWADDR ),
        .AXI4L_VDMA_SLAVE0_AWBURST    ( FIC_CONVERTER_0_AXI4L_VDMA_AWBURST ),
        .AXI4L_VDMA_SLAVE0_AWCACHE    ( FIC_CONVERTER_0_AXI4L_VDMA_AWCACHE ),
        .AXI4L_VDMA_SLAVE0_AWID       ( FIC_CONVERTER_0_AXI4L_VDMA_AWID ),
        .AXI4L_VDMA_SLAVE0_AWLEN      ( FIC_CONVERTER_0_AXI4L_VDMA_AWLEN ),
        .AXI4L_VDMA_SLAVE0_AWLOCK     ( FIC_CONVERTER_0_AXI4L_VDMA_AWLOCK ),
        .AXI4L_VDMA_SLAVE0_AWPROT     ( FIC_CONVERTER_0_AXI4L_VDMA_AWPROT ),
        .AXI4L_VDMA_SLAVE0_AWQOS      ( FIC_CONVERTER_0_AXI4L_VDMA_AWQOS ),
        .AXI4L_VDMA_SLAVE0_AWREGION   ( FIC_CONVERTER_0_AXI4L_VDMA_AWREGION ),
        .AXI4L_VDMA_SLAVE0_AWSIZE     ( FIC_CONVERTER_0_AXI4L_VDMA_AWSIZE ),
        .AXI4L_VDMA_SLAVE0_AWUSER     ( FIC_CONVERTER_0_AXI4L_VDMA_AWUSER ),
        .AXI4L_VDMA_SLAVE0_WDATA      ( FIC_CONVERTER_0_AXI4L_VDMA_WDATA ),
        .AXI4L_VDMA_SLAVE0_WSTRB      ( FIC_CONVERTER_0_AXI4L_VDMA_WSTRB ),
        .AXI4L_VDMA_SLAVE0_WUSER      ( FIC_CONVERTER_0_AXI4L_VDMA_WUSER ) 
        );

//--------MSS_VIDEO_KIT_H264_MM
MSS_VIDEO_KIT_H264_MM MSS(
        // Inputs
        .FIC_0_ACLK                  ( CLOCKS_AND_RESETS_CLK_125MHz ),
        .FIC_0_AXI4_M_AWREADY        ( MSS_FIC_0_AXI4_INITIATOR_AWREADY ),
        .FIC_0_AXI4_M_WREADY         ( MSS_FIC_0_AXI4_INITIATOR_WREADY ),
        .FIC_0_AXI4_M_BVALID         ( MSS_FIC_0_AXI4_INITIATOR_BVALID ),
        .FIC_0_AXI4_M_ARREADY        ( MSS_FIC_0_AXI4_INITIATOR_ARREADY ),
        .FIC_0_AXI4_M_RLAST          ( MSS_FIC_0_AXI4_INITIATOR_RLAST ),
        .FIC_0_AXI4_M_RVALID         ( MSS_FIC_0_AXI4_INITIATOR_RVALID ),
        .FIC_1_ACLK                  ( CLOCKS_AND_RESETS_CLK_125MHz ),
        .FIC_1_AXI4_S_AWLOCK         ( Video_Pipeline_0_mAXI4_SLAVE_AWLOCK_0 ),
        .FIC_1_AXI4_S_AWVALID        ( Video_Pipeline_0_mAXI4_SLAVE_AWVALID ),
        .FIC_1_AXI4_S_WLAST          ( Video_Pipeline_0_mAXI4_SLAVE_WLAST ),
        .FIC_1_AXI4_S_WVALID         ( Video_Pipeline_0_mAXI4_SLAVE_WVALID ),
        .FIC_1_AXI4_S_BREADY         ( Video_Pipeline_0_mAXI4_SLAVE_BREADY ),
        .FIC_1_AXI4_S_ARLOCK         ( Video_Pipeline_0_mAXI4_SLAVE_ARLOCK_0 ),
        .FIC_1_AXI4_S_ARVALID        ( Video_Pipeline_0_mAXI4_SLAVE_ARVALID ),
        .FIC_1_AXI4_S_RREADY         ( Video_Pipeline_0_mAXI4_SLAVE_RREADY ),
        .MMUART_0_RXD_F2M            ( MMUART_0_RXD_F2M ),
        .MMUART_1_RXD_F2M            ( MMUART_1_RXD_F2M ),
        .I2C_0_SCL_F2M               ( BIBUF_1_Y ),
        .I2C_0_SDA_F2M               ( BIBUF_2_Y ),
        .I2C_0_BCLK_F2M              ( CLOCKS_AND_RESETS_I2C_BCLK ),
        .GPIO_2_F2M_25               ( VCC_net ),
        .MSS_RESET_N_F2M             ( CLOCKS_AND_RESETS_FABRIC_POR_N ),
        .CAN_0_RXBUS                 ( CAN_0_RXBUS ),
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
        .FIC_0_AXI4_M_BID            ( MSS_FIC_0_AXI4_INITIATOR_BID ),
        .FIC_0_AXI4_M_BRESP          ( MSS_FIC_0_AXI4_INITIATOR_BRESP ),
        .FIC_0_AXI4_M_RID            ( MSS_FIC_0_AXI4_INITIATOR_RID ),
        .FIC_0_AXI4_M_RDATA          ( MSS_FIC_0_AXI4_INITIATOR_RDATA ),
        .FIC_0_AXI4_M_RRESP          ( MSS_FIC_0_AXI4_INITIATOR_RRESP ),
        .FIC_1_AXI4_S_AWID           ( Video_Pipeline_0_mAXI4_SLAVE_AWID ),
        .FIC_1_AXI4_S_AWADDR         ( Video_Pipeline_0_mAXI4_SLAVE_AWADDR ),
        .FIC_1_AXI4_S_AWLEN          ( Video_Pipeline_0_mAXI4_SLAVE_AWLEN ),
        .FIC_1_AXI4_S_AWSIZE         ( Video_Pipeline_0_mAXI4_SLAVE_AWSIZE ),
        .FIC_1_AXI4_S_AWBURST        ( Video_Pipeline_0_mAXI4_SLAVE_AWBURST ),
        .FIC_1_AXI4_S_AWCACHE        ( Video_Pipeline_0_mAXI4_SLAVE_AWCACHE ),
        .FIC_1_AXI4_S_AWQOS          ( FIC_1_AXI4_S_AWQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_S_AWPROT         ( Video_Pipeline_0_mAXI4_SLAVE_AWPROT ),
        .FIC_1_AXI4_S_WDATA          ( Video_Pipeline_0_mAXI4_SLAVE_WDATA ),
        .FIC_1_AXI4_S_WSTRB          ( Video_Pipeline_0_mAXI4_SLAVE_WSTRB ),
        .FIC_1_AXI4_S_ARID           ( Video_Pipeline_0_mAXI4_SLAVE_ARID ),
        .FIC_1_AXI4_S_ARADDR         ( Video_Pipeline_0_mAXI4_SLAVE_ARADDR ),
        .FIC_1_AXI4_S_ARLEN          ( Video_Pipeline_0_mAXI4_SLAVE_ARLEN ),
        .FIC_1_AXI4_S_ARSIZE         ( Video_Pipeline_0_mAXI4_SLAVE_ARSIZE ),
        .FIC_1_AXI4_S_ARBURST        ( Video_Pipeline_0_mAXI4_SLAVE_ARBURST ),
        .FIC_1_AXI4_S_ARQOS          ( FIC_1_AXI4_S_ARQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_S_ARCACHE        ( Video_Pipeline_0_mAXI4_SLAVE_ARCACHE ),
        .FIC_1_AXI4_S_ARPROT         ( Video_Pipeline_0_mAXI4_SLAVE_ARPROT ),
        .MSS_INT_F2M                 ( MSS_INT_F2M_net_0 ),
        // Outputs
        .FIC_0_DLL_LOCK_M2F          (  ),
        .FIC_1_DLL_LOCK_M2F          ( MSS_FIC_1_DLL_LOCK_M2F ),
        .FIC_0_AXI4_M_AWLOCK         ( MSS_FIC_0_AXI4_INITIATOR_AWLOCK ),
        .FIC_0_AXI4_M_AWVALID        ( MSS_FIC_0_AXI4_INITIATOR_AWVALID ),
        .FIC_0_AXI4_M_WLAST          ( MSS_FIC_0_AXI4_INITIATOR_WLAST ),
        .FIC_0_AXI4_M_WVALID         ( MSS_FIC_0_AXI4_INITIATOR_WVALID ),
        .FIC_0_AXI4_M_BREADY         ( MSS_FIC_0_AXI4_INITIATOR_BREADY ),
        .FIC_0_AXI4_M_ARLOCK         ( MSS_FIC_0_AXI4_INITIATOR_ARLOCK ),
        .FIC_0_AXI4_M_ARVALID        ( MSS_FIC_0_AXI4_INITIATOR_ARVALID ),
        .FIC_0_AXI4_M_RREADY         ( MSS_FIC_0_AXI4_INITIATOR_RREADY ),
        .FIC_1_AXI4_S_AWREADY        ( Video_Pipeline_0_mAXI4_SLAVE_AWREADY ),
        .FIC_1_AXI4_S_WREADY         ( Video_Pipeline_0_mAXI4_SLAVE_WREADY ),
        .FIC_1_AXI4_S_BVALID         ( Video_Pipeline_0_mAXI4_SLAVE_BVALID ),
        .FIC_1_AXI4_S_ARREADY        ( Video_Pipeline_0_mAXI4_SLAVE_ARREADY ),
        .FIC_1_AXI4_S_RLAST          ( Video_Pipeline_0_mAXI4_SLAVE_RLAST ),
        .FIC_1_AXI4_S_RVALID         ( Video_Pipeline_0_mAXI4_SLAVE_RVALID ),
        .MMUART_0_TXD_M2F            ( MMUART_0_TXD_M2F_net_0 ),
        .MMUART_0_TXD_OE_M2F         (  ),
        .MMUART_1_TXD_M2F            ( MMUART_1_TXD_M2F_net_0 ),
        .MMUART_1_TXD_OE_M2F         (  ),
        .I2C_0_SCL_OE_M2F            ( MSS_I2C_0_SCL_OE_M2F ),
        .I2C_0_SDA_OE_M2F            ( MSS_I2C_0_SDA_OE_M2F ),
        .GPIO_2_M2F_19               ( LED3_net_0 ),
        .GPIO_2_M2F_18               ( LED2_net_0 ),
        .GPIO_2_M2F_9                ( CAM_CLK_EN_net_0 ),
        .GPIO_2_M2F_8                ( CAM1_RST_net_0 ),
        .GPIO_2_M2F_4                ( MSS_GPIO_2_M2F_4 ),
        .GPIO_2_M2F_3                (  ),
        .GPIO_2_M2F_2                (  ),
        .GPIO_2_M2F_1                (  ),
        .PLL_CPU_LOCK_M2F            (  ),
        .PLL_DDR_LOCK_M2F            (  ),
        .PLL_SGMII_LOCK_M2F          (  ),
        .MSS_RESET_N_M2F             ( MSS_MSS_RESET_N_M2F ),
        .CRYPTO_DLL_LOCK_M2F         (  ),
        .CRYPTO_BUSY_M2F             (  ),
        .CAN_0_TXBUS                 ( CAN_0_TXBUS_net_0 ),
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
        .RESET_N                     ( RESET_N_net_0 ),
        .ODT                         ( ODT_net_0 ),
        .CKE                         ( CKE_net_0 ),
        .CS                          ( CS_net_0 ),
        .CK                          ( CK_net_0 ),
        .CK_N                        ( CK_N_net_0 ),
        .FIC_0_AXI4_M_AWID           ( MSS_FIC_0_AXI4_INITIATOR_AWID ),
        .FIC_0_AXI4_M_AWADDR         ( MSS_FIC_0_AXI4_INITIATOR_AWADDR ),
        .FIC_0_AXI4_M_AWLEN          ( MSS_FIC_0_AXI4_INITIATOR_AWLEN ),
        .FIC_0_AXI4_M_AWSIZE         ( MSS_FIC_0_AXI4_INITIATOR_AWSIZE ),
        .FIC_0_AXI4_M_AWBURST        ( MSS_FIC_0_AXI4_INITIATOR_AWBURST ),
        .FIC_0_AXI4_M_AWQOS          ( MSS_FIC_0_AXI4_INITIATOR_AWQOS ),
        .FIC_0_AXI4_M_AWCACHE        ( MSS_FIC_0_AXI4_INITIATOR_AWCACHE ),
        .FIC_0_AXI4_M_AWPROT         ( MSS_FIC_0_AXI4_INITIATOR_AWPROT ),
        .FIC_0_AXI4_M_WDATA          ( MSS_FIC_0_AXI4_INITIATOR_WDATA ),
        .FIC_0_AXI4_M_WSTRB          ( MSS_FIC_0_AXI4_INITIATOR_WSTRB ),
        .FIC_0_AXI4_M_ARID           ( MSS_FIC_0_AXI4_INITIATOR_ARID ),
        .FIC_0_AXI4_M_ARADDR         ( MSS_FIC_0_AXI4_INITIATOR_ARADDR ),
        .FIC_0_AXI4_M_ARLEN          ( MSS_FIC_0_AXI4_INITIATOR_ARLEN ),
        .FIC_0_AXI4_M_ARSIZE         ( MSS_FIC_0_AXI4_INITIATOR_ARSIZE ),
        .FIC_0_AXI4_M_ARBURST        ( MSS_FIC_0_AXI4_INITIATOR_ARBURST ),
        .FIC_0_AXI4_M_ARQOS          ( MSS_FIC_0_AXI4_INITIATOR_ARQOS ),
        .FIC_0_AXI4_M_ARCACHE        ( MSS_FIC_0_AXI4_INITIATOR_ARCACHE ),
        .FIC_0_AXI4_M_ARPROT         ( MSS_FIC_0_AXI4_INITIATOR_ARPROT ),
        .FIC_1_AXI4_S_BID            ( Video_Pipeline_0_mAXI4_SLAVE_BID ),
        .FIC_1_AXI4_S_BRESP          ( Video_Pipeline_0_mAXI4_SLAVE_BRESP ),
        .FIC_1_AXI4_S_RID            ( Video_Pipeline_0_mAXI4_SLAVE_RID ),
        .FIC_1_AXI4_S_RDATA          ( Video_Pipeline_0_mAXI4_SLAVE_RDATA ),
        .FIC_1_AXI4_S_RRESP          ( Video_Pipeline_0_mAXI4_SLAVE_RRESP ),
        .MSS_INT_M2F                 (  ),
        .DM                          ( DM_net_0 ),
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
        .ACLK_I               ( CLOCKS_AND_RESETS_CLK_125MHz ),
        .ARESETN_I            ( VSC_8662_RESETN_net_0 ),
        .AXI4L_H264_arvalid   ( FIC_CONVERTER_0_AXI4L_H264_ARVALID ),
        .AXI4L_H264_awvalid   ( FIC_CONVERTER_0_AXI4L_H264_AWVALID ),
        .AXI4L_H264_bready    ( FIC_CONVERTER_0_AXI4L_H264_BREADY ),
        .AXI4L_H264_rready    ( FIC_CONVERTER_0_AXI4L_H264_RREADY ),
        .AXI4L_H264_wvalid    ( FIC_CONVERTER_0_AXI4L_H264_WVALID ),
        .AXI4L_IE_arvalid     ( FIC_CONVERTER_0_AXI4L_IE_ARVALID ),
        .AXI4L_IE_awvalid     ( FIC_CONVERTER_0_AXI4L_IE_AWVALID ),
        .AXI4L_IE_bready      ( FIC_CONVERTER_0_AXI4L_IE_BREADY ),
        .AXI4L_IE_rready      ( FIC_CONVERTER_0_AXI4L_IE_RREADY ),
        .AXI4L_IE_wvalid      ( FIC_CONVERTER_0_AXI4L_IE_WVALID ),
        .AXI4L_MIPI_arvalid   ( FIC_CONVERTER_0_AXI4L_MIPI_ARVALID ),
        .AXI4L_MIPI_awvalid   ( FIC_CONVERTER_0_AXI4L_MIPI_AWVALID ),
        .AXI4L_MIPI_bready    ( FIC_CONVERTER_0_AXI4L_MIPI_BREADY ),
        .AXI4L_MIPI_rready    ( FIC_CONVERTER_0_AXI4L_MIPI_RREADY ),
        .AXI4L_MIPI_wvalid    ( FIC_CONVERTER_0_AXI4L_MIPI_WVALID ),
        .AXI4L_OSD_arvalid    ( FIC_CONVERTER_0_AXI4L_OSD_ARVALID ),
        .AXI4L_OSD_awvalid    ( FIC_CONVERTER_0_AXI4L_OSD_AWVALID ),
        .AXI4L_OSD_bready     ( FIC_CONVERTER_0_AXI4L_OSD_BREADY ),
        .AXI4L_OSD_rready     ( FIC_CONVERTER_0_AXI4L_OSD_RREADY ),
        .AXI4L_OSD_wvalid     ( FIC_CONVERTER_0_AXI4L_OSD_WVALID ),
        .AXI4L_SCALER_arvalid ( FIC_CONVERTER_0_AXI4L_SCALER_ARVALID ),
        .AXI4L_SCALER_awvalid ( FIC_CONVERTER_0_AXI4L_SCALER_AWVALID ),
        .AXI4L_SCALER_bready  ( FIC_CONVERTER_0_AXI4L_SCALER_BREADY ),
        .AXI4L_SCALER_rready  ( FIC_CONVERTER_0_AXI4L_SCALER_RREADY ),
        .AXI4L_SCALER_wvalid  ( FIC_CONVERTER_0_AXI4L_SCALER_WVALID ),
        .AXI4L_VDMA_arvalid   ( FIC_CONVERTER_0_AXI4L_VDMA_ARVALID ),
        .AXI4L_VDMA_awvalid   ( FIC_CONVERTER_0_AXI4L_VDMA_AWVALID ),
        .AXI4L_VDMA_bready    ( FIC_CONVERTER_0_AXI4L_VDMA_BREADY ),
        .AXI4L_VDMA_rready    ( FIC_CONVERTER_0_AXI4L_VDMA_RREADY ),
        .AXI4L_VDMA_wvalid    ( FIC_CONVERTER_0_AXI4L_VDMA_WVALID ),
        .CAM1_RX_CLK_N        ( CAM1_RX_CLK_N ),
        .CAM1_RX_CLK_P        ( CAM1_RX_CLK_P ),
        .CLK_125MHz_i         ( CLOCKS_AND_RESETS_CLK_125MHz ),
        .INIT_DONE            ( CLOCKS_AND_RESETS_DEVICE_INIT_DONE ),
        .LPDDR4_RDY_i         ( MSS_GPIO_2_M2F_4 ),
        .RESETN_125MHz_i      ( VSC_8662_RESETN_net_0 ),
        .mAXI4_SLAVE_arready  ( Video_Pipeline_0_mAXI4_SLAVE_ARREADY ),
        .mAXI4_SLAVE_awready  ( Video_Pipeline_0_mAXI4_SLAVE_AWREADY ),
        .mAXI4_SLAVE_bvalid   ( Video_Pipeline_0_mAXI4_SLAVE_BVALID ),
        .mAXI4_SLAVE_rlast    ( Video_Pipeline_0_mAXI4_SLAVE_RLAST ),
        .mAXI4_SLAVE_rvalid   ( Video_Pipeline_0_mAXI4_SLAVE_RVALID ),
        .mAXI4_SLAVE_wready   ( Video_Pipeline_0_mAXI4_SLAVE_WREADY ),
        .AXI4L_H264_araddr    ( FIC_CONVERTER_0_AXI4L_H264_ARADDR_0 ),
        .AXI4L_H264_awaddr    ( FIC_CONVERTER_0_AXI4L_H264_AWADDR_0 ),
        .AXI4L_H264_wdata     ( FIC_CONVERTER_0_AXI4L_H264_WDATA ),
        .AXI4L_IE_araddr      ( FIC_CONVERTER_0_AXI4L_IE_ARADDR_0 ),
        .AXI4L_IE_awaddr      ( FIC_CONVERTER_0_AXI4L_IE_AWADDR_0 ),
        .AXI4L_IE_wdata       ( FIC_CONVERTER_0_AXI4L_IE_WDATA ),
        .AXI4L_MIPI_araddr    ( FIC_CONVERTER_0_AXI4L_MIPI_ARADDR_0 ),
        .AXI4L_MIPI_awaddr    ( FIC_CONVERTER_0_AXI4L_MIPI_AWADDR_0 ),
        .AXI4L_MIPI_wdata     ( FIC_CONVERTER_0_AXI4L_MIPI_WDATA ),
        .AXI4L_OSD_araddr     ( FIC_CONVERTER_0_AXI4L_OSD_ARADDR_0 ),
        .AXI4L_OSD_awaddr     ( FIC_CONVERTER_0_AXI4L_OSD_AWADDR_0 ),
        .AXI4L_OSD_wdata      ( FIC_CONVERTER_0_AXI4L_OSD_WDATA_0 ),
        .AXI4L_SCALER_araddr  ( FIC_CONVERTER_0_AXI4L_SCALER_ARADDR_0 ),
        .AXI4L_SCALER_awaddr  ( FIC_CONVERTER_0_AXI4L_SCALER_AWADDR_0 ),
        .AXI4L_SCALER_wdata   ( FIC_CONVERTER_0_AXI4L_SCALER_WDATA_0 ),
        .AXI4L_VDMA_araddr    ( FIC_CONVERTER_0_AXI4L_VDMA_ARADDR_0 ),
        .AXI4L_VDMA_awaddr    ( FIC_CONVERTER_0_AXI4L_VDMA_AWADDR_0 ),
        .AXI4L_VDMA_wdata     ( FIC_CONVERTER_0_AXI4L_VDMA_WDATA ),
        .CAM1_RXD_N           ( CAM1_RXD_N ),
        .CAM1_RXD             ( CAM1_RXD ),
        .mAXI4_SLAVE_bid      ( Video_Pipeline_0_mAXI4_SLAVE_BID ),
        .mAXI4_SLAVE_bresp    ( Video_Pipeline_0_mAXI4_SLAVE_BRESP ),
        .mAXI4_SLAVE_rdata    ( Video_Pipeline_0_mAXI4_SLAVE_RDATA ),
        .mAXI4_SLAVE_rid      ( Video_Pipeline_0_mAXI4_SLAVE_RID ),
        .mAXI4_SLAVE_rresp    ( Video_Pipeline_0_mAXI4_SLAVE_RRESP ),
        // Outputs
        .AXI4L_H264_arready   ( FIC_CONVERTER_0_AXI4L_H264_ARREADY ),
        .AXI4L_H264_awready   ( FIC_CONVERTER_0_AXI4L_H264_AWREADY ),
        .AXI4L_H264_bvalid    ( FIC_CONVERTER_0_AXI4L_H264_BVALID ),
        .AXI4L_H264_rvalid    ( FIC_CONVERTER_0_AXI4L_H264_RVALID ),
        .AXI4L_H264_wready    ( FIC_CONVERTER_0_AXI4L_H264_WREADY ),
        .AXI4L_IE_arready     ( FIC_CONVERTER_0_AXI4L_IE_ARREADY ),
        .AXI4L_IE_awready     ( FIC_CONVERTER_0_AXI4L_IE_AWREADY ),
        .AXI4L_IE_bvalid      ( FIC_CONVERTER_0_AXI4L_IE_BVALID ),
        .AXI4L_IE_rvalid      ( FIC_CONVERTER_0_AXI4L_IE_RVALID ),
        .AXI4L_IE_wready      ( FIC_CONVERTER_0_AXI4L_IE_WREADY ),
        .AXI4L_MIPI_arready   ( FIC_CONVERTER_0_AXI4L_MIPI_ARREADY ),
        .AXI4L_MIPI_awready   ( FIC_CONVERTER_0_AXI4L_MIPI_AWREADY ),
        .AXI4L_MIPI_bvalid    ( FIC_CONVERTER_0_AXI4L_MIPI_BVALID ),
        .AXI4L_MIPI_rvalid    ( FIC_CONVERTER_0_AXI4L_MIPI_RVALID ),
        .AXI4L_MIPI_wready    ( FIC_CONVERTER_0_AXI4L_MIPI_WREADY ),
        .AXI4L_OSD_arready    ( FIC_CONVERTER_0_AXI4L_OSD_ARREADY ),
        .AXI4L_OSD_awready    ( FIC_CONVERTER_0_AXI4L_OSD_AWREADY ),
        .AXI4L_OSD_bvalid     ( FIC_CONVERTER_0_AXI4L_OSD_BVALID ),
        .AXI4L_OSD_rvalid     ( FIC_CONVERTER_0_AXI4L_OSD_RVALID ),
        .AXI4L_OSD_wready     ( FIC_CONVERTER_0_AXI4L_OSD_WREADY ),
        .AXI4L_SCALER_arready ( FIC_CONVERTER_0_AXI4L_SCALER_ARREADY ),
        .AXI4L_SCALER_awready ( FIC_CONVERTER_0_AXI4L_SCALER_AWREADY ),
        .AXI4L_SCALER_bvalid  ( FIC_CONVERTER_0_AXI4L_SCALER_BVALID ),
        .AXI4L_SCALER_rvalid  ( FIC_CONVERTER_0_AXI4L_SCALER_RVALID ),
        .AXI4L_SCALER_wready  ( FIC_CONVERTER_0_AXI4L_SCALER_WREADY ),
        .AXI4L_VDMA_arready   ( FIC_CONVERTER_0_AXI4L_VDMA_ARREADY ),
        .AXI4L_VDMA_awready   ( FIC_CONVERTER_0_AXI4L_VDMA_AWREADY ),
        .AXI4L_VDMA_bvalid    ( FIC_CONVERTER_0_AXI4L_VDMA_BVALID ),
        .AXI4L_VDMA_rvalid    ( FIC_CONVERTER_0_AXI4L_VDMA_RVALID ),
        .AXI4L_VDMA_wready    ( FIC_CONVERTER_0_AXI4L_VDMA_WREADY ),
        .INT_DMA_O            ( Video_Pipeline_0_INT_DMA_O ),
        .MIPI_INTERRUPT_O     ( Video_Pipeline_0_MIPI_INTERRUPT_O ),
        .mAXI4_SLAVE_arvalid  ( Video_Pipeline_0_mAXI4_SLAVE_ARVALID ),
        .mAXI4_SLAVE_awvalid  ( Video_Pipeline_0_mAXI4_SLAVE_AWVALID ),
        .mAXI4_SLAVE_bready   ( Video_Pipeline_0_mAXI4_SLAVE_BREADY ),
        .mAXI4_SLAVE_rready   ( Video_Pipeline_0_mAXI4_SLAVE_RREADY ),
        .mAXI4_SLAVE_wlast    ( Video_Pipeline_0_mAXI4_SLAVE_WLAST ),
        .mAXI4_SLAVE_wvalid   ( Video_Pipeline_0_mAXI4_SLAVE_WVALID ),
        .AXI4L_H264_bresp     ( FIC_CONVERTER_0_AXI4L_H264_BRESP ),
        .AXI4L_H264_rdata     ( FIC_CONVERTER_0_AXI4L_H264_RDATA ),
        .AXI4L_H264_rresp     ( FIC_CONVERTER_0_AXI4L_H264_RRESP ),
        .AXI4L_IE_bresp       ( FIC_CONVERTER_0_AXI4L_IE_BRESP ),
        .AXI4L_IE_rdata       ( FIC_CONVERTER_0_AXI4L_IE_RDATA ),
        .AXI4L_IE_rresp       ( FIC_CONVERTER_0_AXI4L_IE_RRESP ),
        .AXI4L_MIPI_bresp     ( FIC_CONVERTER_0_AXI4L_MIPI_BRESP ),
        .AXI4L_MIPI_rdata     ( FIC_CONVERTER_0_AXI4L_MIPI_RDATA ),
        .AXI4L_MIPI_rresp     ( FIC_CONVERTER_0_AXI4L_MIPI_RRESP ),
        .AXI4L_OSD_bresp      ( FIC_CONVERTER_0_AXI4L_OSD_BRESP ),
        .AXI4L_OSD_rdata      ( FIC_CONVERTER_0_AXI4L_OSD_RDATA ),
        .AXI4L_OSD_rresp      ( FIC_CONVERTER_0_AXI4L_OSD_RRESP ),
        .AXI4L_SCALER_bresp   ( FIC_CONVERTER_0_AXI4L_SCALER_BRESP ),
        .AXI4L_SCALER_rdata   ( FIC_CONVERTER_0_AXI4L_SCALER_RDATA ),
        .AXI4L_SCALER_rresp   ( FIC_CONVERTER_0_AXI4L_SCALER_RRESP ),
        .AXI4L_VDMA_bresp     ( FIC_CONVERTER_0_AXI4L_VDMA_BRESP ),
        .AXI4L_VDMA_rdata     ( FIC_CONVERTER_0_AXI4L_VDMA_RDATA ),
        .AXI4L_VDMA_rresp     ( FIC_CONVERTER_0_AXI4L_VDMA_RRESP ),
        .mAXI4_SLAVE_araddr   ( Video_Pipeline_0_mAXI4_SLAVE_ARADDR ),
        .mAXI4_SLAVE_arburst  ( Video_Pipeline_0_mAXI4_SLAVE_ARBURST ),
        .mAXI4_SLAVE_arcache  ( Video_Pipeline_0_mAXI4_SLAVE_ARCACHE ),
        .mAXI4_SLAVE_arid     ( Video_Pipeline_0_mAXI4_SLAVE_ARID ),
        .mAXI4_SLAVE_arlen    ( Video_Pipeline_0_mAXI4_SLAVE_ARLEN ),
        .mAXI4_SLAVE_arlock   ( Video_Pipeline_0_mAXI4_SLAVE_ARLOCK ),
        .mAXI4_SLAVE_arprot   ( Video_Pipeline_0_mAXI4_SLAVE_ARPROT ),
        .mAXI4_SLAVE_arsize   ( Video_Pipeline_0_mAXI4_SLAVE_ARSIZE ),
        .mAXI4_SLAVE_awaddr   ( Video_Pipeline_0_mAXI4_SLAVE_AWADDR ),
        .mAXI4_SLAVE_awburst  ( Video_Pipeline_0_mAXI4_SLAVE_AWBURST ),
        .mAXI4_SLAVE_awcache  ( Video_Pipeline_0_mAXI4_SLAVE_AWCACHE ),
        .mAXI4_SLAVE_awid     ( Video_Pipeline_0_mAXI4_SLAVE_AWID ),
        .mAXI4_SLAVE_awlen    ( Video_Pipeline_0_mAXI4_SLAVE_AWLEN ),
        .mAXI4_SLAVE_awlock   ( Video_Pipeline_0_mAXI4_SLAVE_AWLOCK ),
        .mAXI4_SLAVE_awprot   ( Video_Pipeline_0_mAXI4_SLAVE_AWPROT ),
        .mAXI4_SLAVE_awsize   ( Video_Pipeline_0_mAXI4_SLAVE_AWSIZE ),
        .mAXI4_SLAVE_wdata    ( Video_Pipeline_0_mAXI4_SLAVE_WDATA ),
        .mAXI4_SLAVE_wstrb    ( Video_Pipeline_0_mAXI4_SLAVE_WSTRB ) 
        );


endmodule
