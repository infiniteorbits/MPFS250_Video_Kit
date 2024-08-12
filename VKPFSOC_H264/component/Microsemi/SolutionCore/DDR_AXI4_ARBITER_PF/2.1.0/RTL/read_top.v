//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Nov  9 19:50:42 2020
// Version: v12.5 12.900.10.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// read_top
module read_top #(
parameter   AXI_ADDR_WIDTH              = 32
)
(
    // Inputs
    ack_i,
    data_valid_i,
    done_i,
    r0_burst_size_i,
    r0_rstart_addr_i,
    r1_burst_size_i,
    r1_rstart_addr_i,
    r2_burst_size_i,
    r2_rstart_addr_i,
    r3_burst_size_i,
    r3_rstart_addr_i,
    r4_burst_size_i,
    r4_rstart_addr_i,
    r5_burst_size_i,
    r5_rstart_addr_i,
    r6_burst_size_i,
    r6_rstart_addr_i,
    r7_burst_size_i,
    r7_rstart_addr_i,
    req0_i,
    req1_i,
    req2_i,
    req3_i,
    req4_i,
    req5_i,
    req6_i,
    req7_i,
    reset_i,
    sys_clk_i,
    // Outputs
    burst_size_o,
    r0_ack_o,
    r0_data_valid_o,
    r0_done_o,
    r1_ack_o,
    r1_data_valid_o,
    r1_done_o,
    r2_ack_o,
    r2_data_valid_o,
    r2_done_o,
    r3_ack_o,
    r3_data_valid_o,
    r3_done_o,
    r4_ack_o,
    r4_data_valid_o,
    r4_done_o,
    r5_ack_o,
    r5_data_valid_o,
    r5_done_o,
    r6_ack_o,
    r6_data_valid_o,
    r6_done_o,
    r7_ack_o,
    r7_data_valid_o,
    r7_done_o,
    req_o,
    rstart_addr_o
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         ack_i;
input         data_valid_i;
input         done_i;
input  [7:0]  r0_burst_size_i;
input  [AXI_ADDR_WIDTH-1:0] r0_rstart_addr_i;
input  [7:0]  r1_burst_size_i;
input  [AXI_ADDR_WIDTH-1:0] r1_rstart_addr_i;
input  [7:0]  r2_burst_size_i;
input  [AXI_ADDR_WIDTH-1:0] r2_rstart_addr_i;
input  [7:0]  r3_burst_size_i;
input  [AXI_ADDR_WIDTH-1:0] r3_rstart_addr_i;
input  [7:0]  r4_burst_size_i;
input  [AXI_ADDR_WIDTH-1:0] r4_rstart_addr_i;
input  [7:0]  r5_burst_size_i;
input  [AXI_ADDR_WIDTH-1:0] r5_rstart_addr_i;
input  [7:0]  r6_burst_size_i;
input  [AXI_ADDR_WIDTH-1:0] r6_rstart_addr_i;
input  [7:0]  r7_burst_size_i;
input  [AXI_ADDR_WIDTH-1:0] r7_rstart_addr_i;
input         req0_i;
input         req1_i;
input         req2_i;
input         req3_i;
input         req4_i;
input         req5_i;
input         req6_i;
input         req7_i;
input         reset_i;
input         sys_clk_i;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [7:0]  burst_size_o;
output        r0_ack_o;
output        r0_data_valid_o;
output        r0_done_o;
output        r1_ack_o;
output        r1_data_valid_o;
output        r1_done_o;
output        r2_ack_o;
output        r2_data_valid_o;
output        r2_done_o;
output        r3_ack_o;
output        r3_data_valid_o;
output        r3_done_o;
output        r4_ack_o;
output        r4_data_valid_o;
output        r4_done_o;
output        r5_ack_o;
output        r5_data_valid_o;
output        r5_done_o;
output        r6_ack_o;
output        r6_data_valid_o;
output        r6_done_o;
output        r7_ack_o;
output        r7_data_valid_o;
output        r7_done_o;
output        req_o;
output [AXI_ADDR_WIDTH-1:0] rstart_addr_o;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          ack_i;
wire   [7:0]  burst_size_o_1;
wire          data_valid_i;
wire          done_i;
wire          r0_ack_o_net_0;
wire   [7:0]  r0_burst_size_i;
wire          r0_data_valid_o_net_0;
wire          r0_done_o_net_0;
wire   [AXI_ADDR_WIDTH-1:0] r0_rstart_addr_i;
wire          r1_ack_o_net_0;
wire   [7:0]  r1_burst_size_i;
wire          r1_data_valid_o_net_0;
wire          r1_done_o_net_0;
wire   [AXI_ADDR_WIDTH-1:0] r1_rstart_addr_i;
wire          r2_ack_o_net_0;
wire   [7:0]  r2_burst_size_i;
wire          r2_data_valid_o_net_0;
wire          r2_done_o_net_0;
wire   [AXI_ADDR_WIDTH-1:0] r2_rstart_addr_i;
wire          r3_ack_o_net_0;
wire   [7:0]  r3_burst_size_i;
wire          r3_data_valid_o_net_0;
wire          r3_done_o_net_0;
wire   [AXI_ADDR_WIDTH-1:0] r3_rstart_addr_i;
wire          r4_ack_o_net_0;
wire   [7:0]  r4_burst_size_i;
wire          r4_data_valid_o_net_0;
wire          r4_done_o_net_0;
wire   [AXI_ADDR_WIDTH-1:0] r4_rstart_addr_i;
wire          r5_ack_o_net_0;
wire   [7:0]  r5_burst_size_i;
wire          r5_data_valid_o_net_0;
wire          r5_done_o_net_0;
wire   [AXI_ADDR_WIDTH-1:0] r5_rstart_addr_i;
wire          r6_ack_o_net_0;
wire   [7:0]  r6_burst_size_i;
wire          r6_data_valid_o_net_0;
wire          r6_done_o_net_0;
wire   [AXI_ADDR_WIDTH-1:0] r6_rstart_addr_i;
wire          r7_ack_o_net_0;
wire   [7:0]  r7_burst_size_i;
wire          r7_data_valid_o_net_0;
wire          r7_done_o_net_0;
wire   [AXI_ADDR_WIDTH-1:0] r7_rstart_addr_i;
wire          req0_i;
wire          req1_i;
wire          req2_i;
wire          req3_i;
wire          req4_i;
wire          req5_i;
wire          req6_i;
wire          req7_i;
wire          req_o_net_0;
wire   [2:0]  request_scheduler_0_mux_sel_o_1;
wire          reset_i;
wire   [AXI_ADDR_WIDTH-1:0] rstart_addr_o_net_0;
wire          sys_clk_i;
wire          r3_data_valid_o_net_1;
wire          r0_ack_o_net_1;
wire          r0_done_o_net_1;
wire          r0_data_valid_o_net_1;
wire          r1_ack_o_net_1;
wire          r1_done_o_net_1;
wire          r1_data_valid_o_net_1;
wire          r2_ack_o_net_1;
wire          r2_done_o_net_1;
wire          r2_data_valid_o_net_1;
wire          r3_ack_o_net_1;
wire          r3_done_o_net_1;
wire          req_o_net_1;
wire          r5_data_valid_o_net_1;
wire          r4_done_o_net_1;
wire          r4_data_valid_o_net_1;
wire          r4_ack_o_net_1;
wire          r5_ack_o_net_1;
wire          r5_done_o_net_1;
wire          r7_data_valid_o_net_1;
wire          r6_data_valid_o_net_1;
wire          r6_ack_o_net_1;
wire          r7_ack_o_net_1;
wire          r7_done_o_net_1;
wire          r6_done_o_net_1;
wire   [AXI_ADDR_WIDTH-1:0] rstart_addr_o_net_1;
wire   [7:0]  burst_size_o_1_net_0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign r3_data_valid_o_net_1 = r3_data_valid_o_net_0;
assign r3_data_valid_o       = r3_data_valid_o_net_1;
assign r0_ack_o_net_1        = r0_ack_o_net_0;
assign r0_ack_o              = r0_ack_o_net_1;
assign r0_done_o_net_1       = r0_done_o_net_0;
assign r0_done_o             = r0_done_o_net_1;
assign r0_data_valid_o_net_1 = r0_data_valid_o_net_0;
assign r0_data_valid_o       = r0_data_valid_o_net_1;
assign r1_ack_o_net_1        = r1_ack_o_net_0;
assign r1_ack_o              = r1_ack_o_net_1;
assign r1_done_o_net_1       = r1_done_o_net_0;
assign r1_done_o             = r1_done_o_net_1;
assign r1_data_valid_o_net_1 = r1_data_valid_o_net_0;
assign r1_data_valid_o       = r1_data_valid_o_net_1;
assign r2_ack_o_net_1        = r2_ack_o_net_0;
assign r2_ack_o              = r2_ack_o_net_1;
assign r2_done_o_net_1       = r2_done_o_net_0;
assign r2_done_o             = r2_done_o_net_1;
assign r2_data_valid_o_net_1 = r2_data_valid_o_net_0;
assign r2_data_valid_o       = r2_data_valid_o_net_1;
assign r3_ack_o_net_1        = r3_ack_o_net_0;
assign r3_ack_o              = r3_ack_o_net_1;
assign r3_done_o_net_1       = r3_done_o_net_0;
assign r3_done_o             = r3_done_o_net_1;
assign req_o_net_1           = req_o_net_0;
assign req_o                 = req_o_net_1;
assign r5_data_valid_o_net_1 = r5_data_valid_o_net_0;
assign r5_data_valid_o       = r5_data_valid_o_net_1;
assign r4_done_o_net_1       = r4_done_o_net_0;
assign r4_done_o             = r4_done_o_net_1;
assign r4_data_valid_o_net_1 = r4_data_valid_o_net_0;
assign r4_data_valid_o       = r4_data_valid_o_net_1;
assign r4_ack_o_net_1        = r4_ack_o_net_0;
assign r4_ack_o              = r4_ack_o_net_1;
assign r5_ack_o_net_1        = r5_ack_o_net_0;
assign r5_ack_o              = r5_ack_o_net_1;
assign r5_done_o_net_1       = r5_done_o_net_0;
assign r5_done_o             = r5_done_o_net_1;
assign r7_data_valid_o_net_1 = r7_data_valid_o_net_0;
assign r7_data_valid_o       = r7_data_valid_o_net_1;
assign r6_data_valid_o_net_1 = r6_data_valid_o_net_0;
assign r6_data_valid_o       = r6_data_valid_o_net_1;
assign r6_ack_o_net_1        = r6_ack_o_net_0;
assign r6_ack_o              = r6_ack_o_net_1;
assign r7_ack_o_net_1        = r7_ack_o_net_0;
assign r7_ack_o              = r7_ack_o_net_1;
assign r7_done_o_net_1       = r7_done_o_net_0;
assign r7_done_o             = r7_done_o_net_1;
assign r6_done_o_net_1       = r6_done_o_net_0;
assign r6_done_o             = r6_done_o_net_1;
assign rstart_addr_o_net_1   = rstart_addr_o_net_0;
assign rstart_addr_o[AXI_ADDR_WIDTH-1:0]   = rstart_addr_o_net_1;
assign burst_size_o_1_net_0  = burst_size_o_1;
assign burst_size_o[7:0]     = burst_size_o_1_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------read_demux
read_demux read_demux_1(
        // Inputs
        .reset_i         ( reset_i ),
        .ack_i           ( ack_i ),
        .done_i          ( done_i ),
        .data_valid_i    ( data_valid_i ),
        .mux_sel_i       ( request_scheduler_0_mux_sel_o_1 ),
        // Outputs
        .r0_ack_o        ( r0_ack_o_net_0 ),
        .r0_done_o       ( r0_done_o_net_0 ),
        .r0_data_valid_o ( r0_data_valid_o_net_0 ),
        .r1_ack_o        ( r1_ack_o_net_0 ),
        .r1_done_o       ( r1_done_o_net_0 ),
        .r1_data_valid_o ( r1_data_valid_o_net_0 ),
        .r2_ack_o        ( r2_ack_o_net_0 ),
        .r2_done_o       ( r2_done_o_net_0 ),
        .r2_data_valid_o ( r2_data_valid_o_net_0 ),
        .r3_ack_o        ( r3_ack_o_net_0 ),
        .r3_done_o       ( r3_done_o_net_0 ),
        .r3_data_valid_o ( r3_data_valid_o_net_0 ),
        .r4_ack_o        ( r4_ack_o_net_0 ),
        .r4_done_o       ( r4_done_o_net_0 ),
        .r4_data_valid_o ( r4_data_valid_o_net_0 ),
        .r5_ack_o        ( r5_ack_o_net_0 ),
        .r5_done_o       ( r5_done_o_net_0 ),
        .r5_data_valid_o ( r5_data_valid_o_net_0 ),
        .r6_ack_o        ( r6_ack_o_net_0 ),
        .r6_done_o       ( r6_done_o_net_0 ),
        .r6_data_valid_o ( r6_data_valid_o_net_0 ),
        .r7_ack_o        ( r7_ack_o_net_0 ),
        .r7_done_o       ( r7_done_o_net_0 ),
        .r7_data_valid_o ( r7_data_valid_o_net_0 ) 
        );

//--------read_mux
read_mux #( 
        .g_ADDR_WIDTH  ( AXI_ADDR_WIDTH ) )
    read_mux_0(
        // Inputs
        .mux_sel_i        ( request_scheduler_0_mux_sel_o_1 ),
        .r0_burst_size_i  ( r0_burst_size_i ),
        .r0_rstart_addr_i ( r0_rstart_addr_i ),
        .r1_burst_size_i  ( r1_burst_size_i ),
        .r1_rstart_addr_i ( r1_rstart_addr_i ),
        .r2_burst_size_i  ( r2_burst_size_i ),
        .r2_rstart_addr_i ( r2_rstart_addr_i ),
        .r3_burst_size_i  ( r3_burst_size_i ),
        .r3_rstart_addr_i ( r3_rstart_addr_i ),
        .r4_burst_size_i  ( r4_burst_size_i ),
        .r4_rstart_addr_i ( r4_rstart_addr_i ),
        .r5_burst_size_i  ( r5_burst_size_i ),
        .r5_rstart_addr_i ( r5_rstart_addr_i ),
        .r6_burst_size_i  ( r6_burst_size_i ),
        .r6_rstart_addr_i ( r6_rstart_addr_i ),
        .r7_burst_size_i  ( r7_burst_size_i ),
        .r7_rstart_addr_i ( r7_rstart_addr_i ),
        // Outputs
        .burst_size_o     ( burst_size_o_1 ),
        .rstart_addr_o    ( rstart_addr_o_net_0 ) 
        );

//--------request_scheduler
request_scheduler request_scheduler_0(
        // Inputs
        .reset_i   ( reset_i ),
        .sys_clk_i ( sys_clk_i ),
        .ack_i     ( ack_i ),
        .req0_i    ( req0_i ),
        .req1_i    ( req1_i ),
        .req2_i    ( req2_i ),
        .req3_i    ( req3_i ),
        .req4_i    ( req4_i ),
        .req5_i    ( req5_i ),
        .req6_i    ( req6_i ),
        .req7_i    ( req7_i ),
        .done_i    ( done_i ),
        // Outputs
        .req_o     ( req_o_net_0 ),
        .mux_sel_o ( request_scheduler_0_mux_sel_o_1 ) 
        );


endmodule
