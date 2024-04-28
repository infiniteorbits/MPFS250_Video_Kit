//=================================================================================================
//-- File Name                           : ddr_write_vdma.v
//-- Targeted device                     : Microsemi-SoC
//-- Author                              : India Solutions Team
//--
//-- COPYRIGHT 2021 BY MICROSEMI
//-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
//-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
//-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
//--
//=================================================================================================

module ddr_write_vdma #(
			parameter g_IP_DW = 16,
			parameter g_OP_DW = 64
			)
   (
    input 		 video_source_clk_rstn_i,
    input 		 video_source_clk_i,
    input 		 ddr_clk_rstn_i,
    input 		 ddr_clk_i,
    input 		 fifo_rstn_i,
    input 		 write_ackn_i,
    input 		 write_done_i,
    input 		 frame_start_i,
    input 		 frame_ddr_addr_valid_i,
    input [31:0] 	 frame_ddr_addr_i,
    input 		 data_valid_i,
    input [g_IP_DW-1:0]  data_i,

    output reg 		 frame_size_fifo_wr_o,
    output reg [31:0] 	 frame_size_fifo_data_o,
    output 		 data_valid_o,
    output [g_OP_DW-1:0] data_o,
    output 		 write_req_o,
    output [7:0] 	 write_length_o,
    output reg [37:0] 	 write_start_addr_o,
    output 		 int_dma_o
    );

   wire 		 w_frame_end;
   wire 		 w_frame_end_sync;   
   wire 		 w_data_valid;
   wire [g_OP_DW-1:0] 	 w_data;
   wire [11:0] 		 w_rdata_count;
   wire 		 w_fifo_rd;
   
   data_packer_vdma #(.g_IP_DW(g_IP_DW),
		 .g_OP_DW(g_OP_DW))
   data_packer_vdma_0   (
		    .video_source_clk_rstn_i(video_source_clk_rstn_i),
		    .video_source_clk_i(video_source_clk_i),
		    .data_valid_i(data_valid_i),
		    .frame_start_i(frame_start_i),
		    .data_i(data_i),
		    .frame_end_o(w_frame_end),
		    .data_valid_o(w_data_valid),
		    .data_o(w_data)
		    );

   synchronizer_circuit_2stage_vdma
     synchronizer_circuit_2stage_vdma_0 (
				    .rstn_i(ddr_clk_rstn_i),
				    .sys_clk_i(ddr_clk_i),
				    .data_in_i(w_frame_end),
				    .sync_out_o(w_frame_end_sync)
				    );
   
   async_fifo_vdma #(.g_DDR_AXI_DWIDTH(g_OP_DW),
		.g_VIDEO_FIFO_AWIDTH (12))
   async_fifo_vdma_0 (
		 .rstn_i(fifo_rstn_i),
		 .wclk_i(video_source_clk_i),
		 .wrstn_i(video_source_clk_rstn_i),
		 .wen_i(w_data_valid),
		 .rclk_i(ddr_clk_i),
		 .rrstn_i(video_source_clk_rstn_i),
		 .ren_i(w_fifo_rd),
		 .wdata_i(w_data),
		 .wfull_o       (  ),
		 .wafull_o      (  ),
		 .rempty_o      (  ),
		 .raempty_o     (  ),
		 .rhempty_o     (  ),
		 .wdata_count_o (  ),		   
		 .rdata_rdy_o(data_valid_o),
		 .rdata_o(data_o),
		 .rdata_count_o(w_rdata_count)
		 );


   ddr_write_controller_vdma
     ddr_write_controller_vdma_0 (
			     .ddr_clk_rstn_i(ddr_clk_rstn_i),
			     .ddr_clk_i(ddr_clk_i),
			     .fifo_count_i(w_rdata_count),
			     .eof_i(w_frame_end_sync),
			     .write_ackn_i(write_ackn_i),
			     .write_done_i(write_done_i),
			     .frame_ddr_addr_valid_i(frame_ddr_addr_valid_i),
			     .frame_ddr_addr_i(frame_ddr_addr_i),
			     .read_fifo_o(w_fifo_rd),
			     .int_dma(int_dma_o),
			     .frame_size_fifo_wr(frame_size_fifo_wr_o),
			     .frame_size_fifo_data(frame_size_fifo_data_o),
			     .write_req_o(write_req_o),
			     .write_length_o(write_length_o),
			     .write_start_addr_o(write_start_addr_o)     
			     );
   
   

endmodule // ddr_write_vdma

