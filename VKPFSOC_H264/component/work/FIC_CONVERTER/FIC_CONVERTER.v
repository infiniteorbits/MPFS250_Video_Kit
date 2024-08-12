//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Aug 12 21:24:30 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FIC_CONVERTER
module FIC_CONVERTER(
    // Inputs
    FIC3_APB3_master_PADDR,
    FIC3_APB3_master_PENABLE,
    FIC3_APB3_master_PSEL,
    FIC3_APB3_master_PWDATA,
    FIC3_APB3_master_PWRITE,
    PRDATAS1,
    PREADYS1,
    PSLVERRS1,
    // Outputs
    FIC3_APB3_master_PRDATA,
    FIC3_APB3_master_PREADY,
    FIC3_APB3_master_PSLVERR,
    PADDRS,
    PENABLES,
    PSELS1,
    PWDATAS,
    PWRITES
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] FIC3_APB3_master_PADDR;
input         FIC3_APB3_master_PENABLE;
input         FIC3_APB3_master_PSEL;
input  [31:0] FIC3_APB3_master_PWDATA;
input         FIC3_APB3_master_PWRITE;
input  [31:0] PRDATAS1;
input         PREADYS1;
input         PSLVERRS1;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] FIC3_APB3_master_PRDATA;
output        FIC3_APB3_master_PREADY;
output        FIC3_APB3_master_PSLVERR;
output [31:0] PADDRS;
output        PENABLES;
output        PSELS1;
output [31:0] PWDATAS;
output        PWRITES;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] APBmslave_PADDR;
wire          APBmslave_PENABLE;
wire   [31:0] PRDATAS1;
wire          PREADYS1;
wire          APBmslave_PSELx;
wire          PSLVERRS1;
wire   [31:0] APBmslave_PWDATA;
wire          APBmslave_PWRITE;
wire   [31:0] FIC3_APB3_master_PADDR;
wire          FIC3_APB3_master_PENABLE;
wire   [31:0] FIC3_APB3_master_PRDATA_net_0;
wire          FIC3_APB3_master_PREADY_net_0;
wire          FIC3_APB3_master_PSEL;
wire          FIC3_APB3_master_PSLVERR_net_0;
wire   [31:0] FIC3_APB3_master_PWDATA;
wire          FIC3_APB3_master_PWRITE;
wire          FIC3_APB3_master_PREADY_net_1;
wire          FIC3_APB3_master_PSLVERR_net_1;
wire          APBmslave_PENABLE_net_0;
wire          APBmslave_PSELx_net_0;
wire          APBmslave_PWRITE_net_0;
wire   [31:0] FIC3_APB3_master_PRDATA_net_1;
wire   [31:0] APBmslave_PADDR_net_0;
wire   [31:0] APBmslave_PWDATA_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          VCC_net;
wire          GND_net;
wire   [31:0] PRDATAS0_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net              = 1'b1;
assign GND_net              = 1'b0;
assign PRDATAS0_const_net_0 = 32'h00000000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign FIC3_APB3_master_PREADY_net_1  = FIC3_APB3_master_PREADY_net_0;
assign FIC3_APB3_master_PREADY        = FIC3_APB3_master_PREADY_net_1;
assign FIC3_APB3_master_PSLVERR_net_1 = FIC3_APB3_master_PSLVERR_net_0;
assign FIC3_APB3_master_PSLVERR       = FIC3_APB3_master_PSLVERR_net_1;
assign APBmslave_PENABLE_net_0        = APBmslave_PENABLE;
assign PENABLES                       = APBmslave_PENABLE_net_0;
assign APBmslave_PSELx_net_0          = APBmslave_PSELx;
assign PSELS1                         = APBmslave_PSELx_net_0;
assign APBmslave_PWRITE_net_0         = APBmslave_PWRITE;
assign PWRITES                        = APBmslave_PWRITE_net_0;
assign FIC3_APB3_master_PRDATA_net_1  = FIC3_APB3_master_PRDATA_net_0;
assign FIC3_APB3_master_PRDATA[31:0]  = FIC3_APB3_master_PRDATA_net_1;
assign APBmslave_PADDR_net_0          = APBmslave_PADDR;
assign PADDRS[31:0]                   = APBmslave_PADDR_net_0;
assign APBmslave_PWDATA_net_0         = APBmslave_PWDATA;
assign PWDATAS[31:0]                  = APBmslave_PWDATA_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CoreAPB3_C0
CoreAPB3_C0 CoreAPB3_C0_0(
        // Inputs
        .PADDR     ( FIC3_APB3_master_PADDR ),
        .PSEL      ( FIC3_APB3_master_PSEL ),
        .PENABLE   ( FIC3_APB3_master_PENABLE ),
        .PWRITE    ( FIC3_APB3_master_PWRITE ),
        .PWDATA    ( FIC3_APB3_master_PWDATA ),
        .PRDATAS0  ( PRDATAS0_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS0  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS0 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS1  ( PRDATAS1 ),
        .PREADYS1  ( PREADYS1 ),
        .PSLVERRS1 ( PSLVERRS1 ),
        // Outputs
        .PRDATA    ( FIC3_APB3_master_PRDATA_net_0 ),
        .PREADY    ( FIC3_APB3_master_PREADY_net_0 ),
        .PSLVERR   ( FIC3_APB3_master_PSLVERR_net_0 ),
        .PADDRS    ( APBmslave_PADDR ),
        .PSELS0    (  ),
        .PENABLES  ( APBmslave_PENABLE ),
        .PWRITES   ( APBmslave_PWRITE ),
        .PWDATAS   ( APBmslave_PWDATA ),
        .PSELS1    ( APBmslave_PSELx ) 
        );


endmodule
