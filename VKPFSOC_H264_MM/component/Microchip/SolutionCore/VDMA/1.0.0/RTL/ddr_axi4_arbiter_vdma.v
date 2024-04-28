`timescale 1ns / 100ps

module ddr_axi4_arbiter_vdma #(

parameter   AXI_ID_WIDTH                = 4,
parameter   AXI_ADDR_WIDTH              = 32,
parameter   AXI_DATA_WIDTH              = 512,
parameter	NO_OF_READ_CHANNELS			= 8,
parameter	NO_OF_WRITE_CHANNELS		= 8,
parameter	AXI4_SELECTION				= 2,
parameter   FORMAT                      = 0      // 0 = Native and 1= Bus Interface
)
(
input          arready,
input          awready,
input  [AXI_ID_WIDTH-1:0]   bid,
input  [1:0]   bresp,
input          bvalid,
input          ddr_ctrl_ready_i,
input  [7:0]   r0_burst_size_i,
input          r0_req_i,
input  [AXI_ADDR_WIDTH-1:0]  r0_rstart_addr_i,
input  [7:0]   r1_burst_size_i,
input          r1_req_i,
input  [AXI_ADDR_WIDTH-1:0]  r1_rstart_addr_i,
input  [7:0]   r2_burst_size_i,
input          r2_req_i,
input  [AXI_ADDR_WIDTH-1:0]  r2_rstart_addr_i,
input  [7:0]   r3_burst_size_i,
input          r3_req_i,
input  [AXI_ADDR_WIDTH-1:0]  r3_rstart_addr_i,
input  [7:0]   r4_burst_size_i,
input          r4_req_i,
input  [AXI_ADDR_WIDTH-1:0]  r4_rstart_addr_i,
input  [7:0]   r5_burst_size_i,
input          r5_req_i,
input  [AXI_ADDR_WIDTH-1:0]  r5_rstart_addr_i,
input  [7:0]   r6_burst_size_i,
input          r6_req_i,
input  [AXI_ADDR_WIDTH-1:0]  r6_rstart_addr_i,
input  [7:0]   r7_burst_size_i,
input          r7_req_i,
input  [AXI_ADDR_WIDTH-1:0]  r7_rstart_addr_i,
input  [AXI_DATA_WIDTH-1:0] rdata,
input          reset_i,
input  [AXI_ID_WIDTH-1:0]   rid,
input          rlast,
input  [1:0]   rresp,
input          rvalid,
input          sys_clk_i,
input  [7:0]   w0_burst_size_i,
input  [AXI_DATA_WIDTH-1:0] w0_data_i,
input          w0_data_valid_i,
input          w0_req_i,
input  [AXI_ADDR_WIDTH-1:0]  w0_wstart_addr_i,
input  [7:0]   w1_burst_size_i,
input  [AXI_DATA_WIDTH-1:0] w1_data_i,
input          w1_data_valid_i,
input          w1_req_i,
input  [AXI_ADDR_WIDTH-1:0]  w1_wstart_addr_i,
input  [7:0]   w2_burst_size_i,
input  [AXI_DATA_WIDTH-1:0] w2_data_i,
input          w2_data_valid_i,
input          w2_req_i,
input  [AXI_ADDR_WIDTH-1:0]  w2_wstart_addr_i,
input  [7:0]   w3_burst_size_i,
input  [AXI_DATA_WIDTH-1:0] w3_data_i,
input          w3_data_valid_i,
input          w3_req_i,
input  [AXI_ADDR_WIDTH-1:0]  w3_wstart_addr_i,
input  [7:0]   w4_burst_size_i,
input  [AXI_DATA_WIDTH-1:0] w4_data_i,
input          w4_data_valid_i,
input          w4_req_i,
input  [AXI_ADDR_WIDTH-1:0]  w4_wstart_addr_i,
input  [7:0]   w5_burst_size_i,
input  [AXI_DATA_WIDTH-1:0] w5_data_i,
input          w5_data_valid_i,
input          w5_req_i,
input  [AXI_ADDR_WIDTH-1:0]  w5_wstart_addr_i,
input  [7:0]   w6_burst_size_i,
input  [AXI_DATA_WIDTH-1:0] w6_data_i,
input          w6_data_valid_i,
input          w6_req_i,
input  [AXI_ADDR_WIDTH-1:0]  w6_wstart_addr_i,
input  [7:0]   w7_burst_size_i,
input  [AXI_DATA_WIDTH-1:0] w7_data_i,
input          w7_data_valid_i,
input          w7_req_i,
input  [AXI_ADDR_WIDTH-1:0]  w7_wstart_addr_i,
input          wready,
input  [AXI_DATA_WIDTH-1:0]  WDATA_I_0,
input          WVALID_I_0,
input  [AXI_ADDR_WIDTH-1:0]  AWADDR_I_0,
input          AWVALID_I_0,
input  [7:0]   AWSIZE_I_0,
input  [AXI_DATA_WIDTH-1:0]  WDATA_I_1,
input          WVALID_I_1,
input  [AXI_ADDR_WIDTH-1:0]  AWADDR_I_1,
input          AWVALID_I_1,
input  [7:0]   AWSIZE_I_1,
input  [AXI_DATA_WIDTH-1:0]  WDATA_I_2,
input          WVALID_I_2,
input  [AXI_ADDR_WIDTH-1:0]  AWADDR_I_2,
input          AWVALID_I_2,
input  [7:0]   AWSIZE_I_2,
input  [AXI_DATA_WIDTH-1:0]  WDATA_I_3,
input          WVALID_I_3,
input  [AXI_ADDR_WIDTH-1:0]  AWADDR_I_3,
input          AWVALID_I_3,
input  [7:0]   AWSIZE_I_3,
input  [AXI_DATA_WIDTH-1:0]  WDATA_I_4,
input          WVALID_I_4,
input  [AXI_ADDR_WIDTH-1:0]  AWADDR_I_4,
input          AWVALID_I_4,
input  [7:0]   AWSIZE_I_4,
input  [AXI_DATA_WIDTH-1:0]  WDATA_I_5,
input          WVALID_I_5,
input  [AXI_ADDR_WIDTH-1:0]  AWADDR_I_5,
input          AWVALID_I_5,
input  [7:0]   AWSIZE_I_5,
input  [AXI_DATA_WIDTH-1:0]  WDATA_I_6,
input          WVALID_I_6,
input  [AXI_ADDR_WIDTH-1:0]  AWADDR_I_6,
input          AWVALID_I_6,
input  [7:0]   AWSIZE_I_6,
input  [AXI_DATA_WIDTH-1:0]  WDATA_I_7,
input          WVALID_I_7,
input  [AXI_ADDR_WIDTH-1:0]  AWADDR_I_7,
input          AWVALID_I_7,
input  [7:0]   AWSIZE_I_7,
input  [AXI_ADDR_WIDTH-1:0]  ARADDR_I_0,
input          ARVALID_I_0,
input  [7:0]   ARSIZE_I_0,
input  [AXI_ADDR_WIDTH-1:0]  ARADDR_I_1,
input          ARVALID_I_1,
input  [7:0]   ARSIZE_I_1,
input  [AXI_ADDR_WIDTH-1:0]  ARADDR_I_2,
input          ARVALID_I_2,
input  [7:0]   ARSIZE_I_2,
input  [AXI_ADDR_WIDTH-1:0]  ARADDR_I_3,
input          ARVALID_I_3,
input  [7:0]   ARSIZE_I_3,
input  [AXI_ADDR_WIDTH-1:0]  ARADDR_I_4,
input          ARVALID_I_4,
input  [7:0]   ARSIZE_I_4,
input  [AXI_ADDR_WIDTH-1:0]  ARADDR_I_5,
input          ARVALID_I_5,
input  [7:0]   ARSIZE_I_5,
input  [AXI_ADDR_WIDTH-1:0]  ARADDR_I_6,
input          ARVALID_I_6,
input  [7:0]   ARSIZE_I_6,
input  [AXI_ADDR_WIDTH-1:0]  ARADDR_I_7,
input          ARVALID_I_7,
input  [7:0]   ARSIZE_I_7,
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output         BUSER_O_0,  
output         AWREADY_O_0,
output         BUSER_O_1,  
output         AWREADY_O_1,
output         BUSER_O_2,  
output         AWREADY_O_2,
output         BUSER_O_3,  
output         AWREADY_O_3,
output         BUSER_O_4,  
output         AWREADY_O_4,
output         BUSER_O_5,  
output         AWREADY_O_5,
output         BUSER_O_6,  
output         AWREADY_O_6,
output         BUSER_O_7,  
output         AWREADY_O_7,
output         BUSER_O_r0,  
output         ARREADY_O_0,
output [AXI_DATA_WIDTH-1 : 0]  RDATA_O_0,
output         RVALID_O_0,
output         RLAST_O_0,
output         BUSER_O_r1,  
output         ARREADY_O_1,
output [AXI_DATA_WIDTH-1 : 0]  RDATA_O_1,
output         RVALID_O_1,
output         RLAST_O_1,
output         BUSER_O_r2,  
output         ARREADY_O_2,
output [AXI_DATA_WIDTH-1 : 0]  RDATA_O_2,
output         RVALID_O_2,
output         RLAST_O_2,
output         BUSER_O_r3,  
output         ARREADY_O_3,
output [AXI_DATA_WIDTH-1 : 0]  RDATA_O_3,
output         RVALID_O_3,
output         RLAST_O_3,
output         BUSER_O_r4,  
output         ARREADY_O_4,
output [AXI_DATA_WIDTH-1 : 0]  RDATA_O_4,
output         RVALID_O_4,
output         RLAST_O_4,
output         BUSER_O_r5,  
output         ARREADY_O_5,
output [AXI_DATA_WIDTH-1 : 0]  RDATA_O_5,
output         RVALID_O_5,
output         RLAST_O_5,
output         BUSER_O_r6,  
output         ARREADY_O_6,
output [AXI_DATA_WIDTH-1 : 0]  RDATA_O_6,
output         RVALID_O_6,
output         RLAST_O_6,
output         BUSER_O_r7,  
output         ARREADY_O_7,
output [AXI_DATA_WIDTH-1 : 0]  RDATA_O_7,
output         RVALID_O_7,
output         RLAST_O_7,
output [AXI_ADDR_WIDTH-1:0]  araddr,
output [1:0]   arburst,
output [3:0]   arcache,
output [AXI_ID_WIDTH-1:0]   arid,
output [7:0]   arlen,
output [1:0]   arlock,
output [2:0]   arprot,
output [2:0]   arsize,
output         arvalid,
output [AXI_ADDR_WIDTH-1:0]  awaddr,
output [1:0]   awburst,
output [3:0]   awcache,
output [AXI_ID_WIDTH-1:0]   awid,
output [7:0]   awlen,
output [1:0]   awlock,
output [2:0]   awprot,
output [2:0]   awsize,
output         awvalid,
output         bready,
output         r0_ack_o,
output         r0_data_valid_o,
output         r0_done_o,
output         r1_ack_o,
output         r1_data_valid_o,
output         r1_done_o,
output         r2_ack_o,
output         r2_data_valid_o,
output         r2_done_o,
output         r3_ack_o,
output         r3_data_valid_o,
output         r3_done_o,
output         r4_ack_o,
output         r4_data_valid_o,
output         r4_done_o,
output         r5_ack_o,
output         r5_data_valid_o,
output         r5_done_o,
output         r6_ack_o,
output         r6_data_valid_o,
output         r6_done_o,
output         r7_ack_o,
output         r7_data_valid_o,
output         r7_done_o,
output [AXI_DATA_WIDTH-1:0] rdata_o,
output         rready,
output         w0_ack_o,
output         w0_done_o,
output         w1_ack_o,
output         w1_done_o,
output         w2_ack_o,
output         w2_done_o,
output         w3_ack_o,
output         w3_done_o,
output         w4_ack_o,
output         w4_done_o,
output         w5_ack_o,
output         w5_done_o,
output         w6_ack_o,
output         w6_done_o,
output         w7_ack_o,
output         w7_done_o,
output [AXI_DATA_WIDTH-1:0] wdata,
output         wlast,
output [(AXI_DATA_WIDTH/8)-1:0]  wstrb,
output         wvalid
);


wire   [AXI_ADDR_WIDTH-1:0]  M_AXI_4_ARADDR;
wire   [1:0]   M_AXI_4_ARBURST;
wire   [3:0]   M_AXI_4_ARCACHE;
wire   [AXI_ID_WIDTH-1:0]   M_AXI_4_ARID;
wire   [7:0]   M_AXI_4_ARLEN;
wire   [1:0]   M_AXI_4_ARLOCK;
wire   [2:0]   M_AXI_4_ARPROT;
wire   [2:0]   M_AXI_4_ARSIZE;
wire           M_AXI_4_ARVALID;
wire   [AXI_ADDR_WIDTH-1:0]  M_AXI_4_AWADDR;
wire   [1:0]   M_AXI_4_AWBURST;
wire   [3:0]   M_AXI_4_AWCACHE;
wire   [AXI_ID_WIDTH-1:0]   M_AXI_4_AWID;
wire   [7:0]   M_AXI_4_AWLEN;
wire   [1:0]   M_AXI_4_AWLOCK;
wire   [2:0]   M_AXI_4_AWPROT;
wire   [2:0]   M_AXI_4_AWSIZE;
wire           M_AXI_4_AWVALID;
wire           M_AXI_4_BREADY;
wire           M_AXI_4_RREADY;
wire   [AXI_DATA_WIDTH-1:0] M_AXI_4_WDATA;
wire           M_AXI_4_WLAST;
wire   [(AXI_DATA_WIDTH/8)-1:0]  M_AXI_4_WSTRB;
wire           M_AXI_4_WVALID;
wire  [7:0]  r0_burst_size_axi;
wire         r0_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] r0_rstart_addr_axi;
wire  [7:0]  w0_burst_size_axi;
wire  [AXI_DATA_WIDTH-1:0]       w0_data_axi;
wire         w0_data_valid_axi;
wire         w0_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] w0_wstart_addr_axi; 
wire  [AXI_DATA_WIDTH-1:0]	     rdata_axi;
wire		 r0_ack_axi;
wire         r0_data_valid_axi;
wire         r0_done_axi;
wire		 w0_ack_axi;
wire         w0_done_axi;
wire  [7:0]  r1_burst_size_axi;
wire         r1_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] r1_rstart_addr_axi;
wire  [7:0]  w1_burst_size_axi;
wire  [AXI_DATA_WIDTH-1:0]       w1_data_axi;
wire         w1_data_valid_axi;
wire         w1_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] w1_wstart_addr_axi; 
wire		 r1_ack_axi;
wire         r1_data_valid_axi;
wire         r1_done_axi;
wire		 w1_ack_axi;
wire         w1_done_axi;
wire  [7:0]  r2_burst_size_axi;
wire         r2_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] r2_rstart_addr_axi;
wire  [7:0]  w2_burst_size_axi;
wire  [AXI_DATA_WIDTH-1:0]       w2_data_axi;
wire         w2_data_valid_axi;
wire         w2_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] w2_wstart_addr_axi ;
wire		 r2_ack_axi;
wire         r2_data_valid_axi;
wire         r2_done_axi;
wire		 w2_ack_axi;
wire         w2_done_axi;
wire  [7:0]  r3_burst_size_axi;
wire         r3_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] r3_rstart_addr_axi;
wire  [7:0]  w3_burst_size_axi;
wire  [AXI_DATA_WIDTH-1:0]       w3_data_axi;
wire         w3_data_valid_axi;
wire         w3_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] w3_wstart_addr_axi;
wire		 r3_ack_axi;
wire         r3_data_valid_axi;
wire         r3_done_axi;
wire		 w3_ack_axi;
wire         w3_done_axi;
wire  [7:0]  r4_burst_size_axi;
wire         r4_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] r4_rstart_addr_axi;
wire  [7:0]  w4_burst_size_axi;
wire  [AXI_DATA_WIDTH-1:0]       w4_data_axi;
wire         w4_data_valid_axi;
wire         w4_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] w4_wstart_addr_axi; 
wire		 r4_ack_axi;
wire         r4_data_valid_axi;
wire         r4_done_axi;
wire		 w4_ack_axi;
wire         w4_done_axi;
wire  [7:0]  r5_burst_size_axi;
wire         r5_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] r5_rstart_addr_axi;
wire  [7:0]  w5_burst_size_axi;
wire  [AXI_DATA_WIDTH-1:0]       w5_data_axi;
wire         w5_data_valid_axi;
wire         w5_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] w5_wstart_addr_axi; 
wire		 r5_ack_axi;
wire         r5_data_valid_axi;
wire         r5_done_axi;
wire		 w5_ack_axi;
wire         w5_done_axi;
wire  [7:0]  r6_burst_size_axi;
wire         r6_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] r6_rstart_addr_axi;
wire  [7:0]  w6_burst_size_axi;
wire  [AXI_DATA_WIDTH-1:0]       w6_data_axi;
wire         w6_data_valid_axi;
wire         w6_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] w6_wstart_addr_axi; 
wire		 r6_ack_axi;
wire         r6_data_valid_axi;
wire         r6_done_axi;
wire		 w6_ack_axi;
wire         w6_done_axi;
wire  [7:0]  r7_burst_size_axi;
wire         r7_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] r7_rstart_addr_axi;
wire  [7:0]  w7_burst_size_axi;
wire  [AXI_DATA_WIDTH-1:0]       w7_data_axi;
wire         w7_data_valid_axi;
wire         w7_req_axi;
wire  [AXI_ADDR_WIDTH-1:0] w7_wstart_addr_axi; 
wire		 r7_ack_axi;
wire         r7_data_valid_axi;
wire         r7_done_axi;
wire		 w7_ack_axi;
wire         w7_done_axi;

generate if (FORMAT == 0)
    ddr_axi4_arbiter_native_vdma #(
	     .AXI_ID_WIDTH              ( AXI_ID_WIDTH        	),
		 .AXI_ADDR_WIDTH			( AXI_ADDR_WIDTH		),
         .AXI_DATA_WIDTH            ( AXI_DATA_WIDTH      	),
         .NO_OF_READ_CHANNELS	    ( NO_OF_READ_CHANNELS 	),
         .NO_OF_WRITE_CHANNELS      ( NO_OF_WRITE_CHANNELS 	),
		 .AXI4_SELECTION		    ( AXI4_SELECTION		)
		 )ddr_axi4_arbiter_native_vdma_0
		 (
		 .reset_i          (reset_i),
	     .sys_clk_i        (sys_clk_i),
		 .ddr_ctrl_ready   (ddr_ctrl_ready_i),
		 .awready          (awready),
         .wready           (wready),
         .bid              (bid),
         .bresp            (bresp),
         .bvalid           (bvalid),
         .arready          (arready),
         .rid              (rid),
         .rdata            (rdata),
         .rresp            (rresp),
         .rlast            (rlast),
         .rvalid           (rvalid),
		 .r0_burst_size_i   (r0_burst_size_i),
		 .r0_req_i          (r0_req_i),
		 .r0_rstart_addr_i  (r0_rstart_addr_i),
		 .r1_burst_size_i   (r1_burst_size_i),
		 .r1_req_i          (r1_req_i),
		 .r1_rstart_addr_i  (r1_rstart_addr_i),
		 .r2_burst_size_i   (r2_burst_size_i),
		 .r2_req_i          (r2_req_i),
		 .r2_rstart_addr_i  (r2_rstart_addr_i),
		 .r3_burst_size_i   (r3_burst_size_i),
		 .r3_req_i          (r3_req_i),
		 .r3_rstart_addr_i  (r3_rstart_addr_i),
		 .r4_burst_size_i   (r4_burst_size_i),
		 .r4_req_i          (r4_req_i),
		 .r4_rstart_addr_i  (r4_rstart_addr_i),
		 .r5_burst_size_i   (r5_burst_size_i),
		 .r5_req_i          (r5_req_i),
		 .r5_rstart_addr_i  (r5_rstart_addr_i),
		 .r6_burst_size_i   (r6_burst_size_i),
		 .r6_req_i          (r6_req_i),
		 .r6_rstart_addr_i  (r6_rstart_addr_i),
		 .r7_burst_size_i   (r7_burst_size_i),
		 .r7_req_i          (r7_req_i),
		 .r7_rstart_addr_i  (r7_rstart_addr_i),
		 .w0_burst_size_i   (w0_burst_size_i),
		 .w0_data_i         (w0_data_i),
		 .w0_data_valid_i   (w0_data_valid_i),
		 .w0_req_i          (w0_req_i),
		 .w0_wstart_addr_i  (w0_wstart_addr_i),
		 .w1_burst_size_i   (w1_burst_size_i),
		 .w1_data_i         (w1_data_i),
		 .w1_data_valid_i   (w1_data_valid_i),
		 .w1_req_i          (w1_req_i),
		 .w1_wstart_addr_i  (w1_wstart_addr_i),
		 .w2_burst_size_i   (w2_burst_size_i),
		 .w2_data_i         (w2_data_i),
		 .w2_data_valid_i   (w2_data_valid_i),
		 .w2_req_i          (w2_req_i),
		 .w2_wstart_addr_i  (w2_wstart_addr_i),
		 .w3_burst_size_i   (w3_burst_size_i),
		 .w3_data_i         (w3_data_i),
		 .w3_data_valid_i   (w3_data_valid_i),
		 .w3_req_i          (w3_req_i),
		 .w3_wstart_addr_i  (w3_wstart_addr_i),
		 .w4_burst_size_i   (w4_burst_size_i),
		 .w4_data_i         (w4_data_i),
		 .w4_data_valid_i   (w4_data_valid_i),
		 .w4_req_i          (w4_req_i),
		 .w4_wstart_addr_i  (w4_wstart_addr_i),
		 .w5_burst_size_i   (w5_burst_size_i),
		 .w5_data_i         (w5_data_i),
		 .w5_data_valid_i   (w5_data_valid_i),
		 .w5_req_i          (w5_req_i),
		 .w5_wstart_addr_i  (w5_wstart_addr_i),
		 .w6_burst_size_i   (w6_burst_size_i),
		 .w6_data_i         (w6_data_i),
		 .w6_data_valid_i   (w6_data_valid_i),
		 .w6_req_i          (w6_req_i),
		 .w6_wstart_addr_i  (w6_wstart_addr_i),
		 .w7_burst_size_i   (w7_burst_size_i),
		 .w7_data_i         (w7_data_i),
		 .w7_data_valid_i   (w7_data_valid_i),
		 .w7_req_i          (w7_req_i),
		 .w7_wstart_addr_i  (w7_wstart_addr_i),
		 .awid             (awid   ),
         .awaddr           (awaddr ),
         .awlen            (awlen  ),
         .awsize           (awsize ),
         .awburst          (awburst),
         .awlock           (awlock ),
         .awcache          (awcache),
         .awprot           (awprot ),
         .awvalid          (awvalid),
         .wdata            (wdata  ),
         .wstrb            (wstrb  ),
         .wlast            (wlast  ),
         .wvalid           (wvalid ),
         .bready           (bready ),
         .arid             (arid   ),
         .araddr           (araddr ),
         .arlen            (arlen  ),
         .arsize           (arsize ),
         .arburst          (arburst),
         .arlock           (arlock ),
         .arcache          (arcache),
         .arprot           (arprot ),
         .arvalid          (arvalid),
         .rready           (rready ),
		 .r0_ack_o          (r0_ack_o),
		 .r0_data_valid_o   (r0_data_valid_o),
		 .r0_done_o         (r0_done_o),
		 .r1_ack_o          (r1_ack_o),
		 .r1_data_valid_o   (r1_data_valid_o),
		 .r1_done_o         (r1_done_o),
		 .r2_ack_o          (r2_ack_o),
		 .r2_data_valid_o   (r2_data_valid_o),
		 .r2_done_o         (r2_done_o),
		 .r3_ack_o          (r3_ack_o),
		 .r3_data_valid_o   (r3_data_valid_o),
		 .r3_done_o         (r3_done_o),
		 .r4_ack_o          (r4_ack_o),
		 .r4_data_valid_o   (r4_data_valid_o),
		 .r4_done_o         (r4_done_o),
		 .r5_ack_o          (r5_ack_o),
		 .r5_data_valid_o   (r5_data_valid_o),
		 .r5_done_o         (r5_done_o),
		 .r6_ack_o          (r6_ack_o),
		 .r6_data_valid_o   (r6_data_valid_o),
		 .r6_done_o         (r6_done_o),
		 .r7_ack_o          (r7_ack_o),
		 .r7_data_valid_o   (r7_data_valid_o),
		 .r7_done_o         (r7_done_o),
         .rdata_o           (rdata_o),
		 .w0_ack_o          (w0_ack_o),
		 .w0_done_o         (w0_done_o),
		 .w1_ack_o          (w1_ack_o),
		 .w1_done_o         (w1_done_o),
		 .w2_ack_o          (w2_ack_o),
		 .w2_done_o         (w2_done_o),
		 .w3_ack_o          (w3_ack_o),
		 .w3_done_o         (w3_done_o),
		 .w4_ack_o          (w4_ack_o),
		 .w4_done_o         (w4_done_o),
		 .w5_ack_o          (w5_ack_o),
		 .w5_done_o         (w5_done_o),
		 .w6_ack_o          (w6_ack_o),
		 .w6_done_o         (w6_done_o),
		 .w7_ack_o          (w7_ack_o),
		 .w7_done_o         (w7_done_o)
		 );
	endgenerate
	
	generate if (FORMAT == 1)
    ddr_axi4_arbiter_native_vdma #(
	     .AXI_ID_WIDTH              ( AXI_ID_WIDTH        	),
		 .AXI_ADDR_WIDTH			( AXI_ADDR_WIDTH		),
         .AXI_DATA_WIDTH            ( AXI_DATA_WIDTH      	),
         .NO_OF_READ_CHANNELS	    ( NO_OF_READ_CHANNELS 	),
         .NO_OF_WRITE_CHANNELS      ( NO_OF_WRITE_CHANNELS 	),
		 .AXI4_SELECTION		    ( AXI4_SELECTION		)
		 )ddr_axi4_arbiter_native_vdma_axi
		 (
		 .reset_i          (reset_i),
	     .sys_clk_i        (sys_clk_i),
		 .ddr_ctrl_ready   (ddr_ctrl_ready_i),
		 .awready          (awready),
         .wready           (wready),
         .bid              (bid),
         .bresp            (bresp),
         .bvalid           (bvalid),
         .arready          (arready),
         .rid              (rid),
         .rdata            (rdata),
         .rresp            (rresp),
         .rlast            (rlast),
         .rvalid           (rvalid),
		 .r0_burst_size_i   (r0_burst_size_axi),
		 .r0_req_i          (r0_req_axi),
		 .r0_rstart_addr_i  (r0_rstart_addr_axi),
		 .r1_burst_size_i   (r1_burst_size_axi),
		 .r1_req_i          (r1_req_axi),
		 .r1_rstart_addr_i  (r1_rstart_addr_axi),
		 .r2_burst_size_i   (r2_burst_size_axi),
		 .r2_req_i          (r2_req_axi),
		 .r2_rstart_addr_i  (r2_rstart_addr_axi),
		 .r3_burst_size_i   (r3_burst_size_axi),
		 .r3_req_i          (r3_req_axi),
		 .r3_rstart_addr_i  (r3_rstart_addr_axi),
		 .r4_burst_size_i   (r4_burst_size_axi),
		 .r4_req_i          (r4_req_axi),
		 .r4_rstart_addr_i  (r4_rstart_addr_axi),
		 .r5_burst_size_i   (r5_burst_size_axi),
		 .r5_req_i          (r5_req_axi),
		 .r5_rstart_addr_i  (r5_rstart_addr_axi),
		 .r6_burst_size_i   (r6_burst_size_axi),
		 .r6_req_i          (r6_req_axi),
		 .r6_rstart_addr_i  (r6_rstart_addr_axi),
		 .r7_burst_size_i   (r7_burst_size_axi),
		 .r7_req_i          (r7_req_axi),
		 .r7_rstart_addr_i  (r7_rstart_addr_axi),
		 .w0_burst_size_i   (w0_burst_size_axi),
		 .w0_data_i         (w0_data_axi),
		 .w0_data_valid_i   (w0_data_valid_axi),
		 .w0_req_i          (w0_req_axi),
		 .w0_wstart_addr_i  (w0_wstart_addr_axi),
		 .w1_burst_size_i   (w1_burst_size_axi),
		 .w1_data_i         (w1_data_axi),
		 .w1_data_valid_i   (w1_data_valid_axi),
		 .w1_req_i          (w1_req_axi),
		 .w1_wstart_addr_i  (w1_wstart_addr_axi),
		 .w2_burst_size_i   (w2_burst_size_axi),
		 .w2_data_i         (w2_data_axi),
		 .w2_data_valid_i   (w2_data_valid_axi),
		 .w2_req_i          (w2_req_axi),
		 .w2_wstart_addr_i  (w2_wstart_addr_axi),
		 .w3_burst_size_i   (w3_burst_size_axi),
		 .w3_data_i         (w3_data_axi),
		 .w3_data_valid_i   (w3_data_valid_axi),
		 .w3_req_i          (w3_req_axi),
		 .w3_wstart_addr_i  (w3_wstart_addr_axi),
		 .w4_burst_size_i   (w4_burst_size_axi),
		 .w4_data_i         (w4_data_axi),
		 .w4_data_valid_i   (w4_data_valid_axi),
		 .w4_req_i          (w4_req_axi),
		 .w4_wstart_addr_i  (w4_wstart_addr_axi),
		 .w5_burst_size_i   (w5_burst_size_axi),
		 .w5_data_i         (w5_data_axi),
		 .w5_data_valid_i   (w5_data_valid_axi),
		 .w5_req_i          (w5_req_axi),
		 .w5_wstart_addr_i  (w5_wstart_addr_axi),
		 .w6_burst_size_i   (w6_burst_size_axi),
		 .w6_data_i         (w6_data_axi),
		 .w6_data_valid_i   (w6_data_valid_axi),
		 .w6_req_i          (w6_req_axi),
		 .w6_wstart_addr_i  (w6_wstart_addr_axi),
		 .w7_burst_size_i   (w7_burst_size_axi),
		 .w7_data_i         (w7_data_axi),
		 .w7_data_valid_i   (w7_data_valid_axi),
		 .w7_req_i          (w7_req_axi),
		 .w7_wstart_addr_i  (w7_wstart_addr_axi),
		 .awid             (awid   ),
         .awaddr           (awaddr ),
         .awlen            (awlen  ),
         .awsize           (awsize ),
         .awburst          (awburst),
         .awlock           (awlock ),
         .awcache          (awcache),
         .awprot           (awprot ),
         .awvalid          (awvalid),
         .wdata            (wdata  ),
         .wstrb            (wstrb  ),
         .wlast            (wlast  ),
         .wvalid           (wvalid ),
         .bready           (bready ),
         .arid             (arid   ),
         .araddr           (araddr ),
         .arlen            (arlen  ),
         .arsize           (arsize ),
         .arburst          (arburst),
         .arlock           (arlock ),
         .arcache          (arcache),
         .arprot           (arprot ),
         .arvalid          (arvalid),
         .rready           (rready ),
		 .r0_ack_o          (r0_ack_axi),
		 .r0_data_valid_o   (r0_data_valid_axi),
		 .r0_done_o         (r0_done_axi),
		 .r1_ack_o          (r1_ack_axi),
		 .r1_data_valid_o   (r1_data_valid_axi),
		 .r1_done_o         (r1_done_axi),
		 .r2_ack_o          (r2_ack_axi),
		 .r2_data_valid_o   (r2_data_valid_axi),
		 .r2_done_o         (r2_done_axi),
		 .r3_ack_o          (r3_ack_axi),
		 .r3_data_valid_o   (r3_data_valid_axi),
		 .r3_done_o         (r3_done_axi),
		 .r4_ack_o          (r4_ack_axi),
		 .r4_data_valid_o   (r4_data_valid_axi),
		 .r4_done_o         (r4_done_axi),
		 .r5_ack_o          (r5_ack_axi),
		 .r5_data_valid_o   (r5_data_valid_axi),
		 .r5_done_o         (r5_done_axi),
		 .r6_ack_o          (r6_ack_axi),
		 .r6_data_valid_o   (r6_data_valid_axi),
		 .r6_done_o         (r6_done_axi),
		 .r7_ack_o          (r7_ack_axi),
		 .r7_data_valid_o   (r7_data_valid_axi),
		 .r7_done_o         (r7_done_axi),
         .rdata_o           (rdata_axi),
		 .w0_ack_o          (w0_ack_axi),
		 .w0_done_o         (w0_done_axi),
		 .w1_ack_o          (w1_ack_axi),
		 .w1_done_o         (w1_done_axi),
		 .w2_ack_o          (w2_ack_axi),
		 .w2_done_o         (w2_done_axi),
		 .w3_ack_o          (w3_ack_axi),
		 .w3_done_o         (w3_done_axi),
		 .w4_ack_o          (w4_ack_axi),
		 .w4_done_o         (w4_done_axi),
		 .w5_ack_o          (w5_ack_axi),
		 .w5_done_o         (w5_done_axi),
		 .w6_ack_o          (w6_ack_axi),
		 .w6_done_o         (w6_done_axi),
		 .w7_ack_o          (w7_ack_axi),
		 .w7_done_o         (w7_done_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_WRITE_CHANNELS >= 1)
	   AXI4_M_M_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_M_M_IF_0
		 (
		 .WDATA_I       (WDATA_I_0),
         .WVALID_I      (WVALID_I_0),
         .AWADDR_I      (AWADDR_I_0),
         .AWVALID_I     (AWVALID_I_0),
         .AWSIZE_I      (AWSIZE_I_0),
         .W_DONE_I      (w0_done_axi),
         .W_ACK_I       (w0_ack_axi  ),
         .BUSER_O       (BUSER_O_0 ),
         .AWREADY_O     (AWREADY_O_0),
         .W_DATA_O      (w0_data_axi),
         .W_DATA_VALID_O(w0_data_valid_axi),
         .W_START_ADDR_O(w0_wstart_addr_axi),
         .W_REQ_O       (w0_req_axi),
         .W_BURST_SIZE_O(w0_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_WRITE_CHANNELS >= 2)
	   AXI4_M_M_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_M_M_IF_1
		 (
		 .WDATA_I       (WDATA_I_1),
         .WVALID_I      (WVALID_I_1),
         .AWADDR_I      (AWADDR_I_1),
         .AWVALID_I     (AWVALID_I_1),
         .AWSIZE_I      (AWSIZE_I_1),
         .W_DONE_I      (w1_done_axi),
         .W_ACK_I       (w1_ack_axi),
         .BUSER_O       (BUSER_O_1),
         .AWREADY_O     (AWREADY_O_1),
         .W_DATA_O      (w1_data_axi),
         .W_DATA_VALID_O(w1_data_valid_axi),
         .W_START_ADDR_O(w1_wstart_addr_axi),
         .W_REQ_O       (w1_req_axi),
         .W_BURST_SIZE_O(w1_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_WRITE_CHANNELS >= 3)
	   AXI4_M_M_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_M_M_IF_2
		 (
		 .WDATA_I       (WDATA_I_2),
         .WVALID_I      (WVALID_I_2),
         .AWADDR_I      (AWADDR_I_2),
         .AWVALID_I     (AWVALID_I_2),
         .AWSIZE_I      (AWSIZE_I_2),
         .W_DONE_I      (w2_done_axi),
         .W_ACK_I       (w2_ack_axi),
         .BUSER_O       (BUSER_O_2),
         .AWREADY_O     (AWREADY_O_2),
         .W_DATA_O      (w2_data_axi),
         .W_DATA_VALID_O(w2_data_valid_axi),
         .W_START_ADDR_O(w2_wstart_addr_axi),
         .W_REQ_O       (w2_req_axi),
         .W_BURST_SIZE_O(w2_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_WRITE_CHANNELS >= 4)
	   AXI4_M_M_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_M_M_IF_3
		 (
		 .WDATA_I       (WDATA_I_3),
         .WVALID_I      (WVALID_I_3),
         .AWADDR_I      (AWADDR_I_3),
         .AWVALID_I     (AWVALID_I_3),
         .AWSIZE_I      (AWSIZE_I_3),
         .W_DONE_I      (w3_done_axi),
         .W_ACK_I       (w3_ack_axi),
         .BUSER_O       (BUSER_O_3),
         .AWREADY_O     (AWREADY_O_3),
         .W_DATA_O      (w3_data_axi),
         .W_DATA_VALID_O(w3_data_valid_axi),
         .W_START_ADDR_O(w3_wstart_addr_axi),
         .W_REQ_O       (w3_req_axi),
         .W_BURST_SIZE_O(w3_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_WRITE_CHANNELS >= 5)
	   AXI4_M_M_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_M_M_IF_4
		 (
		 .WDATA_I       (WDATA_I_4),
         .WVALID_I      (WVALID_I_4),
         .AWADDR_I      (AWADDR_I_4),
         .AWVALID_I     (AWVALID_I_4),
         .AWSIZE_I      (AWSIZE_I_4),
         .W_DONE_I      (w4_done_axi),
         .W_ACK_I       (w4_ack_axi),
         .BUSER_O       (BUSER_O_4),
         .AWREADY_O     (AWREADY_O_4),
         .W_DATA_O      (w4_data_axi),
         .W_DATA_VALID_O(w4_data_valid_axi),
         .W_START_ADDR_O(w4_wstart_addr_axi),
         .W_REQ_O       (w4_req_axi),
         .W_BURST_SIZE_O(w4_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_WRITE_CHANNELS >= 6)
	   AXI4_M_M_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_M_M_IF_5
		 (
		 .WDATA_I       (WDATA_I_5),
         .WVALID_I      (WVALID_I_5),
         .AWADDR_I      (AWADDR_I_5),
         .AWVALID_I     (AWVALID_I_5),
         .AWSIZE_I      (AWSIZE_I_5),
         .W_DONE_I      (w5_done_axi),
         .W_ACK_I       (w5_ack_axi),
         .BUSER_O       (BUSER_O_5),
         .AWREADY_O     (AWREADY_O_5),
         .W_DATA_O      (w5_data_axi),
         .W_DATA_VALID_O(w5_data_valid_axi),
         .W_START_ADDR_O(w5_wstart_addr_axi),
         .W_REQ_O       (w5_req_axi),
         .W_BURST_SIZE_O(w5_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_WRITE_CHANNELS >= 7)
	   AXI4_M_M_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_M_M_IF_6
		 (
		 .WDATA_I       (WDATA_I_6),
         .WVALID_I      (WVALID_I_6),
         .AWADDR_I      (AWADDR_I_6),
         .AWVALID_I     (AWVALID_I_6),
         .AWSIZE_I      (AWSIZE_I_6),
         .W_DONE_I      (w6_done_axi),
         .W_ACK_I       (w6_ack_axi),
         .BUSER_O       (BUSER_O_6),
         .AWREADY_O     (AWREADY_O_6),
         .W_DATA_O      (w6_data_axi),
         .W_DATA_VALID_O(w6_data_valid_axi),
         .W_START_ADDR_O(w6_wstart_addr_axi),
         .W_REQ_O       (w6_req_axi),
         .W_BURST_SIZE_O(w6_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_WRITE_CHANNELS == 8)
	   AXI4_M_M_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_M_M_IF_7
		 (
		 .WDATA_I       (WDATA_I_7),
         .WVALID_I      (WVALID_I_7),
         .AWADDR_I      (AWADDR_I_7),
         .AWVALID_I     (AWVALID_I_7),
         .AWSIZE_I      (AWSIZE_I_7),
         .W_DONE_I      (w7_done_axi),
         .W_ACK_I       (w7_ack_axi),
         .BUSER_O       (BUSER_O_7),
         .AWREADY_O     (AWREADY_O_7),
         .W_DATA_O      (w7_data_axi),
         .W_DATA_VALID_O(w7_data_valid_axi),
         .W_START_ADDR_O(w7_wstart_addr_axi),
         .W_REQ_O       (w7_req_axi),
         .W_BURST_SIZE_O(w7_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_READ_CHANNELS >= 1)
	   AXI4_S_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_S_IF_0
		 (
		 .CLOCK_I       (sys_clk_i),
         .RESET_n_I     (reset_i),
         .R_DATA_I      (rdata_axi),
         .R_DATA_VALID_I(r0_data_valid_axi),
         .ARADDR_I      (ARADDR_I_0),
         .ARVALID_I     (ARVALID_I_0),
         .ARSIZE_I      (ARSIZE_I_0),
         .R_DONE_I      (r0_done_axi),
         .R_ACK_I       (r0_ack_axi),
         .BUSER_O_r     (BUSER_O_r0),
         .ARREADY_O     (ARREADY_O_0),
         .RDATA_O       (RDATA_O_0),
         .RVALID_O      (RVALID_O_0),
         .RLAST_O       (RLAST_O_0),
         .R_START_ADDR_O(r0_rstart_addr_axi),
         .R_REQ_O       (r0_req_axi),
         .R_BURST_SIZE_O(r0_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_READ_CHANNELS >= 2)
	   AXI4_S_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_S_IF_1
		 (
		 .CLOCK_I       (sys_clk_i),
         .RESET_n_I     (reset_i),
         .R_DATA_I      (rdata_axi),
         .R_DATA_VALID_I(r1_data_valid_axi),
         .ARADDR_I      (ARADDR_I_1),
         .ARVALID_I     (ARVALID_I_1),
         .ARSIZE_I      (ARSIZE_I_1),
         .R_DONE_I      (r1_done_axi),
         .R_ACK_I       (r1_ack_axi),
         .BUSER_O_r     (BUSER_O_r1),
         .ARREADY_O     (ARREADY_O_1),
         .RDATA_O       (RDATA_O_1),
         .RVALID_O      (RVALID_O_1),
         .RLAST_O       (RLAST_O_1),
         .R_START_ADDR_O(r1_rstart_addr_axi),
         .R_REQ_O       (r1_req_axi),
         .R_BURST_SIZE_O(r1_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_READ_CHANNELS >= 3)
	   AXI4_S_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_S_IF_2
		 (
		 .CLOCK_I       (sys_clk_i),
         .RESET_n_I     (reset_i),
         .R_DATA_I      (rdata_axi),
         .R_DATA_VALID_I(r2_data_valid_axi),
         .ARADDR_I      (ARADDR_I_2),
         .ARVALID_I     (ARVALID_I_2),
         .ARSIZE_I      (ARSIZE_I_2),
         .R_DONE_I      (r2_done_axi),
         .R_ACK_I       (r2_ack_axi),
         .BUSER_O_r     (BUSER_O_r2),
         .ARREADY_O     (ARREADY_O_2),
         .RDATA_O       (RDATA_O_2),
         .RVALID_O      (RVALID_O_2),
         .RLAST_O       (RLAST_O_2),
         .R_START_ADDR_O(r2_rstart_addr_axi),
         .R_REQ_O       (r2_req_axi),
         .R_BURST_SIZE_O(r2_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_READ_CHANNELS >= 4)
	   AXI4_S_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_S_IF_3
		 (
		 .CLOCK_I       (sys_clk_i),
         .RESET_n_I     (reset_i),
         .R_DATA_I      (rdata_axi),
         .R_DATA_VALID_I(r3_data_valid_axi),
         .ARADDR_I      (ARADDR_I_3),
         .ARVALID_I     (ARVALID_I_3),
         .ARSIZE_I      (ARSIZE_I_3),
         .R_DONE_I      (r3_done_axi),
         .R_ACK_I       (r3_ack_axi),
         .BUSER_O_r     (BUSER_O_r3),
         .ARREADY_O     (ARREADY_O_3),
         .RDATA_O       (RDATA_O_3),
         .RVALID_O      (RVALID_O_3),
         .RLAST_O       (RLAST_O_3),
         .R_START_ADDR_O(r3_rstart_addr_axi),
         .R_REQ_O       (r3_req_axi),
         .R_BURST_SIZE_O(r3_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_READ_CHANNELS >= 5)
	   AXI4_S_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_S_IF_4
		 (
		 .CLOCK_I       (sys_clk_i),
         .RESET_n_I     (reset_i),
         .R_DATA_I      (rdata_axi),
         .R_DATA_VALID_I(r4_data_valid_axi),
         .ARADDR_I      (ARADDR_I_4),
         .ARVALID_I     (ARVALID_I_4),
         .ARSIZE_I      (ARSIZE_I_4),
         .R_DONE_I      (r4_done_axi),
         .R_ACK_I       (r4_ack_axi),
         .BUSER_O_r     (BUSER_O_r4),
         .ARREADY_O     (ARREADY_O_4),
         .RDATA_O       (RDATA_O_4),
         .RVALID_O      (RVALID_O_4),
         .RLAST_O       (RLAST_O_4),
         .R_START_ADDR_O(r4_rstart_addr_axi),
         .R_REQ_O       (r4_req_axi),
         .R_BURST_SIZE_O(r4_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_READ_CHANNELS >= 6)
	   AXI4_S_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_S_IF_5
		 (
		 .CLOCK_I       (sys_clk_i),
         .RESET_n_I     (reset_i),
         .R_DATA_I      (rdata_axi),
         .R_DATA_VALID_I(r5_data_valid_axi),
         .ARADDR_I      (ARADDR_I_5),
         .ARVALID_I     (ARVALID_I_5),
         .ARSIZE_I      (ARSIZE_I_5),
         .R_DONE_I      (r5_done_axi),
         .R_ACK_I       (r5_ack_axi),
         .BUSER_O_r     (BUSER_O_r5),
         .ARREADY_O     (ARREADY_O_5),
         .RDATA_O       (RDATA_O_5),
         .RVALID_O      (RVALID_O_5),
         .RLAST_O       (RLAST_O_5),
         .R_START_ADDR_O(r5_rstart_addr_axi),
         .R_REQ_O       (r5_req_axi),
         .R_BURST_SIZE_O(r5_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_READ_CHANNELS >= 7)
	   AXI4_S_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_S_IF_6
		 (
		 .CLOCK_I       (sys_clk_i),
         .RESET_n_I     (reset_i),
         .R_DATA_I      (rdata_axi),
         .R_DATA_VALID_I(r6_data_valid_axi),
         .ARADDR_I      (ARADDR_I_6),
         .ARVALID_I     (ARVALID_I_6),
         .ARSIZE_I      (ARSIZE_I_6),
         .R_DONE_I      (r6_done_axi),
         .R_ACK_I       (r6_ack_axi),
         .BUSER_O_r     (BUSER_O_r6),
         .ARREADY_O     (ARREADY_O_6),
         .RDATA_O       (RDATA_O_6),
         .RVALID_O      (RVALID_O_6),
         .RLAST_O       (RLAST_O_6),
         .R_START_ADDR_O(r6_rstart_addr_axi),
         .R_REQ_O       (r6_req_axi),
         .R_BURST_SIZE_O(r6_burst_size_axi)
		 );
	endgenerate
	
	generate if (FORMAT == 1 && NO_OF_READ_CHANNELS == 8)
	   AXI4_S_IF #(
	     .AXI_DATA_WIDTH       (AXI_DATA_WIDTH      ),
		 .AXI_ADDR_WIDTH	   (AXI_ADDR_WIDTH		)
		 ) AXI4_S_IF_7
		 (
		 .CLOCK_I       (sys_clk_i),
         .RESET_n_I     (reset_i),
         .R_DATA_I      (rdata_axi),
         .R_DATA_VALID_I(r7_data_valid_axi),
         .ARADDR_I      (ARADDR_I_7),
         .ARVALID_I     (ARVALID_I_7),
         .ARSIZE_I      (ARSIZE_I_7),
         .R_DONE_I      (r7_done_axi),
         .R_ACK_I       (r7_ack_axi),
         .BUSER_O_r     (BUSER_O_r7),
         .ARREADY_O     (ARREADY_O_7),
         .RDATA_O       (RDATA_O_7),
         .RVALID_O      (RVALID_O_7),
         .RLAST_O       (RLAST_O_7),
         .R_START_ADDR_O(r7_rstart_addr_axi),
         .R_REQ_O       (r7_req_axi),
         .R_BURST_SIZE_O(r7_burst_size_axi)
		 );
	endgenerate
	endmodule
