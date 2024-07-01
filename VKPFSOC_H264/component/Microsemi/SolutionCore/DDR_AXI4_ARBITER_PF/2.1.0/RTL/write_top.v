//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Nov  9 19:50:57 2020
// Version: v12.5 12.900.10.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// write_top
module write_top #(
parameter   AXI_ADDR_WIDTH              = 32,
parameter   AXI_DATA_WIDTH              = 512
)
(
    // Inputs
    ack_i,
    done_i,
    reset_i,
    sys_clk_i,
    w0_burst_size_i,
    w0_data_i,
    w0_data_valid_i,
    w0_req_i,
    w0_wstart_addr_i,
    w1_burst_size_i,
    w1_data_i,
    w1_data_valid_i,
    w1_req_i,
    w1_wstart_addr_i,
    w2_burst_size_i,
    w2_data_i,
    w2_data_valid_i,
    w2_req_i,
    w2_wstart_addr_i,
    w3_burst_size_i,
    w3_data_i,
    w3_data_valid_i,
    w3_req_i,
    w3_wstart_addr_i,
    w4_burst_size_i,
    w4_data_i,
    w4_data_valid_i,
    w4_req_i,
    w4_wstart_addr_i,
    w5_burst_size_i,
    w5_data_i,
    w5_data_valid_i,
    w5_req_i,
    w5_wstart_addr_i,
    w6_burst_size_i,
    w6_data_i,
    w6_data_valid_i,
    w6_req_i,
    w6_wstart_addr_i,
    w7_burst_size_i,
    w7_data_i,
    w7_data_valid_i,
    w7_req_i,
    w7_wstart_addr_i,
    // Outputs
    burst_size_o,
    data_o,
    data_valid_o,
    req_o,
    w0_ack_o,
    w0_done_o,
    w1_ack_o,
    w1_done_o,
    w2_ack_o,
    w2_done_o,
    w3_ack_o,
    w3_done_o,
    w4_ack_o,
    w4_done_o,
    w5_ack_o,
    w5_done_o,
    w6_ack_o,
    w6_done_o,
    w7_ack_o,
    w7_done_o,
    wstart_addr_o
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input          ack_i;
input          done_i;
input          reset_i;
input          sys_clk_i;
input  [7:0]   w0_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w0_data_i;
input          w0_data_valid_i;
input          w0_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w0_wstart_addr_i;
input  [7:0]   w1_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w1_data_i;
input          w1_data_valid_i;
input          w1_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w1_wstart_addr_i;
input  [7:0]   w2_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w2_data_i;
input          w2_data_valid_i;
input          w2_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w2_wstart_addr_i;
input  [7:0]   w3_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w3_data_i;
input          w3_data_valid_i;
input          w3_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w3_wstart_addr_i;
input  [7:0]   w4_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w4_data_i;
input          w4_data_valid_i;
input          w4_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w4_wstart_addr_i;
input  [7:0]   w5_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w5_data_i;
input          w5_data_valid_i;
input          w5_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w5_wstart_addr_i;
input  [7:0]   w6_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w6_data_i;
input          w6_data_valid_i;
input          w6_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w6_wstart_addr_i;
input  [7:0]   w7_burst_size_i;
input  [AXI_DATA_WIDTH-1:0] w7_data_i;
input          w7_data_valid_i;
input          w7_req_i;
input  [AXI_ADDR_WIDTH-1:0]  w7_wstart_addr_i;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [7:0]   burst_size_o;
output [AXI_DATA_WIDTH-1:0] data_o;
output         data_valid_o;
output         req_o;
output         w0_ack_o;
output         w0_done_o;
output         w1_ack_o;
output         w1_done_o;
output         w2_ack_o;
output         w2_done_o;
output         w3_ack_o;
output         w3_done_o;
output         w4_ack_o;
output         w4_done_o;
output         w5_ack_o;
output         w5_done_o;
output         w6_ack_o;
output         w6_done_o;
output         w7_ack_o;
output         w7_done_o;
output [AXI_ADDR_WIDTH-1:0]  wstart_addr_o;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire           ack_i;
wire   [7:0]   burst_size_o_1;
wire   [AXI_DATA_WIDTH-1:0] data_o_1;
wire           data_valid_o_net_0;
wire           done_i;
wire           req_o_net_0;
wire   [2:0]   request_scheduler_0_mux_sel_o_1;
wire           reset_i;
wire           sys_clk_i;
wire           w0_ack_o_net_0;
wire   [7:0]   w0_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w0_data_i;
wire           w0_data_valid_i;
wire           w0_done_o_net_0;
wire           w0_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w0_wstart_addr_i;
wire           w1_ack_o_net_0;
wire   [7:0]   w1_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w1_data_i;
wire           w1_data_valid_i;
wire           w1_done_o_net_0;
wire           w1_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w1_wstart_addr_i;
wire           w2_ack_o_net_0;
wire   [7:0]   w2_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w2_data_i;
wire           w2_data_valid_i;
wire           w2_done_o_net_0;
wire           w2_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w2_wstart_addr_i;
wire           w3_ack_o_net_0;
wire   [7:0]   w3_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w3_data_i;
wire           w3_data_valid_i;
wire           w3_done_o_net_0;
wire           w3_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w3_wstart_addr_i;
wire           w4_ack_o_net_0;
wire   [7:0]   w4_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w4_data_i;
wire           w4_data_valid_i;
wire           w4_done_o_net_0;
wire           w4_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w4_wstart_addr_i;
wire           w5_ack_o_net_0;
wire   [7:0]   w5_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w5_data_i;
wire           w5_data_valid_i;
wire           w5_done_o_net_0;
wire           w5_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w5_wstart_addr_i;
wire           w6_ack_o_net_0;
wire   [7:0]   w6_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w6_data_i;
wire           w6_data_valid_i;
wire           w6_done_o_net_0;
wire           w6_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w6_wstart_addr_i;
wire           w7_ack_o_net_0;
wire   [7:0]   w7_burst_size_i;
wire   [AXI_DATA_WIDTH-1:0] w7_data_i;
wire           w7_data_valid_i;
wire           w7_done_o_net_0;
wire           w7_req_i;
wire   [AXI_ADDR_WIDTH-1:0]  w7_wstart_addr_i;
wire   [AXI_ADDR_WIDTH-1:0]  wstart_addr_o_net_0;
wire           w0_ack_o_net_1;
wire           w3_done_o_net_1;
wire           w3_ack_o_net_1;
wire           w2_done_o_net_1;
wire           w2_ack_o_net_1;
wire           w1_done_o_net_1;
wire           w1_ack_o_net_1;
wire           w0_done_o_net_1;
wire           data_valid_o_net_1;
wire           req_o_net_1;
wire           w4_ack_o_net_1;
wire           w4_done_o_net_1;
wire           w7_done_o_net_1;
wire           w5_ack_o_net_1;
wire           w5_done_o_net_1;
wire           w6_ack_o_net_1;
wire           w6_done_o_net_1;
wire           w7_ack_o_net_1;
wire   [AXI_ADDR_WIDTH-1:0]  wstart_addr_o_net_1;
wire   [AXI_DATA_WIDTH-1:0] data_o_1_net_0;
wire   [7:0]   burst_size_o_1_net_0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign w0_ack_o_net_1       = w0_ack_o_net_0;
assign w0_ack_o             = w0_ack_o_net_1;
assign w3_done_o_net_1      = w3_done_o_net_0;
assign w3_done_o            = w3_done_o_net_1;
assign w3_ack_o_net_1       = w3_ack_o_net_0;
assign w3_ack_o             = w3_ack_o_net_1;
assign w2_done_o_net_1      = w2_done_o_net_0;
assign w2_done_o            = w2_done_o_net_1;
assign w2_ack_o_net_1       = w2_ack_o_net_0;
assign w2_ack_o             = w2_ack_o_net_1;
assign w1_done_o_net_1      = w1_done_o_net_0;
assign w1_done_o            = w1_done_o_net_1;
assign w1_ack_o_net_1       = w1_ack_o_net_0;
assign w1_ack_o             = w1_ack_o_net_1;
assign w0_done_o_net_1      = w0_done_o_net_0;
assign w0_done_o            = w0_done_o_net_1;
assign data_valid_o_net_1   = data_valid_o_net_0;
assign data_valid_o         = data_valid_o_net_1;
assign req_o_net_1          = req_o_net_0;
assign req_o                = req_o_net_1;
assign w4_ack_o_net_1       = w4_ack_o_net_0;
assign w4_ack_o             = w4_ack_o_net_1;
assign w4_done_o_net_1      = w4_done_o_net_0;
assign w4_done_o            = w4_done_o_net_1;
assign w7_done_o_net_1      = w7_done_o_net_0;
assign w7_done_o            = w7_done_o_net_1;
assign w5_ack_o_net_1       = w5_ack_o_net_0;
assign w5_ack_o             = w5_ack_o_net_1;
assign w5_done_o_net_1      = w5_done_o_net_0;
assign w5_done_o            = w5_done_o_net_1;
assign w6_ack_o_net_1       = w6_ack_o_net_0;
assign w6_ack_o             = w6_ack_o_net_1;
assign w6_done_o_net_1      = w6_done_o_net_0;
assign w6_done_o            = w6_done_o_net_1;
assign w7_ack_o_net_1       = w7_ack_o_net_0;
assign w7_ack_o             = w7_ack_o_net_1;
assign wstart_addr_o_net_1  = wstart_addr_o_net_0;
assign wstart_addr_o[AXI_ADDR_WIDTH-1:0]  = wstart_addr_o_net_1;
assign data_o_1_net_0       = data_o_1;
assign data_o[AXI_DATA_WIDTH-1:0]        = data_o_1_net_0;
assign burst_size_o_1_net_0 = burst_size_o_1;
assign burst_size_o[7:0]    = burst_size_o_1_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------request_scheduler
request_scheduler request_scheduler_0(
        // Inputs
        .reset_i   ( reset_i ),
        .sys_clk_i ( sys_clk_i ),
        .ack_i     ( ack_i ),
        .req0_i    ( w0_req_i ),
        .req1_i    ( w1_req_i ),
        .req2_i    ( w2_req_i ),
        .req3_i    ( w3_req_i ),
        .req4_i    ( w4_req_i ),
        .req5_i    ( w5_req_i ),
        .req6_i    ( w6_req_i ),
        .req7_i    ( w7_req_i ),
        .done_i    ( done_i ),
        // Outputs
        .req_o     ( req_o_net_0 ),
        .mux_sel_o ( request_scheduler_0_mux_sel_o_1 ) 
        );

//--------write_demux
write_demux write_demux_0(
        // Inputs
        .reset_i   ( reset_i ),
        .ack_i     ( ack_i ),
        .done_i    ( done_i ),
        .mux_sel_i ( request_scheduler_0_mux_sel_o_1 ),
        // Outputs
        .w0_ack_o  ( w0_ack_o_net_0 ),
        .w0_done_o ( w0_done_o_net_0 ),
        .w1_ack_o  ( w1_ack_o_net_0 ),
        .w1_done_o ( w1_done_o_net_0 ),
        .w2_ack_o  ( w2_ack_o_net_0 ),
        .w2_done_o ( w2_done_o_net_0 ),
        .w3_ack_o  ( w3_ack_o_net_0 ),
        .w3_done_o ( w3_done_o_net_0 ),
        .w4_ack_o  ( w4_ack_o_net_0 ),
        .w4_done_o ( w4_done_o_net_0 ),
        .w5_ack_o  ( w5_ack_o_net_0 ),
        .w5_done_o ( w5_done_o_net_0 ),
        .w6_ack_o  ( w6_ack_o_net_0 ),
        .w6_done_o ( w6_done_o_net_0 ),
        .w7_ack_o  ( w7_ack_o_net_0 ),
        .w7_done_o ( w7_done_o_net_0 ) 
        );

//--------write_mux
write_mux #( 
        .g_ADDR_WIDTH  ( AXI_ADDR_WIDTH ),
        .g_DATA_WIDTH  ( AXI_DATA_WIDTH ) )
    write_mux_0(
        // Inputs
        .reset_i          ( reset_i ),
        .sys_clk_i        ( sys_clk_i ),
        .w0_data_valid_i  ( w0_data_valid_i ),
        .w1_data_valid_i  ( w1_data_valid_i ),
        .w2_data_valid_i  ( w2_data_valid_i ),
        .w3_data_valid_i  ( w3_data_valid_i ),
        .w4_data_valid_i  ( w4_data_valid_i ),
        .w5_data_valid_i  ( w5_data_valid_i ),
        .w6_data_valid_i  ( w6_data_valid_i ),
        .w7_data_valid_i  ( w7_data_valid_i ),
        .mux_sel_i        ( request_scheduler_0_mux_sel_o_1 ),
        .w0_burst_size_i  ( w0_burst_size_i ),
        .w0_wstart_addr_i ( w0_wstart_addr_i ),
        .w0_data_i        ( w0_data_i ),
        .w1_burst_size_i  ( w1_burst_size_i ),
        .w1_wstart_addr_i ( w1_wstart_addr_i ),
        .w1_data_i        ( w1_data_i ),
        .w2_burst_size_i  ( w2_burst_size_i ),
        .w2_wstart_addr_i ( w2_wstart_addr_i ),
        .w2_data_i        ( w2_data_i ),
        .w3_burst_size_i  ( w3_burst_size_i ),
        .w3_wstart_addr_i ( w3_wstart_addr_i ),
        .w3_data_i        ( w3_data_i ),
        .w4_burst_size_i  ( w4_burst_size_i ),
        .w4_wstart_addr_i ( w4_wstart_addr_i ),
        .w4_data_i        ( w4_data_i ),
        .w5_burst_size_i  ( w5_burst_size_i ),
        .w5_wstart_addr_i ( w5_wstart_addr_i ),
        .w5_data_i        ( w5_data_i ),
        .w6_burst_size_i  ( w6_burst_size_i ),
        .w6_wstart_addr_i ( w6_wstart_addr_i ),
        .w6_data_i        ( w6_data_i ),
        .w7_burst_size_i  ( w7_burst_size_i ),
        .w7_wstart_addr_i ( w7_wstart_addr_i ),
        .w7_data_i        ( w7_data_i ),
        // Outputs
        .data_valid_o     ( data_valid_o_net_0 ),
        .burst_size_o     ( burst_size_o_1 ),
        .wstart_addr_o    ( wstart_addr_o_net_0 ),
        .data_o           ( data_o_1 ) 
        );


endmodule
