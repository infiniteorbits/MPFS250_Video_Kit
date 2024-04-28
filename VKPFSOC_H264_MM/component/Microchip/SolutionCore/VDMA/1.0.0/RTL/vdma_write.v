//=================================================================================================
//-- File Name                           : vdma_write.v
//-- Targeted device                     : Microsemi-SoC
//-- Author                              : India Solutions Team
//--
//-- COPYRIGHT 2021 BY MICROSEMI
//-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
//-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
//-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
//--
//=================================================================================================

module vdma_write #(parameter g_IP_DW = 16,
		    parameter g_OP_DW = 64)
   (
    input 		 video_source_clk_rstn_i,
    input 		 video_source_clk_i,
    input 		 ddr_clk_rstn_i,
    input 		 ddr_clk_i,
    input 		 aclk_i,
    input 		 aclk_rstn_i,
    input 		 fifo_rstn_i,
    input 		 vdma_ip_en_i,
    input 		 frame_start_i,
    input 		 frame_size_fifo_rd_i,
    input 		 write_done_i,
    input 		 write_ackn_i,
    input 		 buff_addr_fifo_wr_i,
    input [31:0] 	 buff_addr_fifo_data_i,
    input 		 data_valid_i,
    input [g_IP_DW-1:0]  data_i,
   
    output 		 frame_size_fifo_empty_o,
    output 		 frame_size_fifo_full_o,
    output 		 buff_addr_fifo_empty_o,
    output 		 buff_addr_fifo_full_o,
    output 		 write_req_o,
    output [7:0] 	 write_length_o,
    output [31:0] 	 frame_size_o,
    output 		 int_dma_o,
    output 		 data_valid_o,
    output [g_OP_DW-1:0] data_o,
    output [37:0] 	 write_start_addr_o
    );

   wire 		 w_buff_addr_fifo_rd;
   wire 		 w_buff_addr_fifo_data_valid;
   wire [31:0] 		 w_buff_addr_fifo_data;
   wire 		 w_buff_addr_fifo_empty;
   wire 		 w_frame_size_fifo_wr;
   wire [31:0] 		 w_frame_size_fifo_data;
   wire 		 w_mem_wr_done;
   wire 		 w_data_valid;
   wire [31:0] 		 w_ddr_wr_addr;
   wire 		 w_ddr_wr_addr_valid;
   wire 		 w_frame_start;
   wire [37:0] 		 w_write_start_addr;
   wire 		 w_int_dma;

   assign write_start_addr_o = w_write_start_addr;
   assign int_dma_o = w_int_dma;
   

   async_fifo_vdma #(.g_VIDEO_FIFO_AWIDTH(5),
		.g_DDR_AXI_DWIDTH(32)
		)
   buff_addr_fifo (
		   .rstn_i(fifo_rstn_i),
		   .wclk_i(aclk_i),
		   .wrstn_i(aclk_rstn_i),
		   .wen_i(buff_addr_fifo_wr_i),
		   .wdata_i(buff_addr_fifo_data_i),		     
		   .rclk_i(video_source_clk_i),
		   .rrstn_i(video_source_clk_rstn_i),
		   .ren_i(w_buff_addr_fifo_rd),
		   .rdata_rdy_o(w_buff_addr_fifo_data_valid),
		   .wafull_o      (  ),
		   .raempty_o     (  ),
		   .rhempty_o     (  ),
		   .wdata_count_o (  ),		   
		   .rdata_count_o(),		   
		   .rdata_o(w_buff_addr_fifo_data),
		   .wfull_o(buff_addr_fifo_full_o),
		   .rempty_o(w_buff_addr_fifo_empty)
		   );


   async_fifo_vdma #(.g_VIDEO_FIFO_AWIDTH(5),
		.g_DDR_AXI_DWIDTH(32)
		)
   frame_size_fifo (
		    .rstn_i(fifo_rstn_i),
		    .wclk_i(ddr_clk_i),
		    .wrstn_i(ddr_clk_rstn_i),
		    .wen_i(w_frame_size_fifo_wr),
		    .rclk_i(aclk_i),
		    .rrstn_i(aclk_rstn_i),
		    .ren_i(frame_size_fifo_rd_i),
		    .wdata_i(w_frame_size_fifo_data),
		    .rdata_rdy_o(),
		    .wafull_o      (  ),
		    .raempty_o     (  ),
		    .rhempty_o     (  ),
		    .wdata_count_o (  ),		   
		    .rdata_count_o(),		   	    
		    .rdata_o(frame_size_o),
		    .wfull_o(frame_size_fifo_full_o),
		    .rempty_o(frame_size_fifo_empty_o)
		    );
   
   
   synchronizer_circuit_2stage_vdma
     synchronizer_circuit_2stage_vdma (
				  .rstn_i(video_source_clk_rstn_i),
				  .sys_clk_i(video_source_clk_i),
				  .data_in_i(w_int_dma),
				  .sync_out_o(w_mem_wr_done)
				  );

   vdma_controller
     vdma_controller (
		     .video_source_clk_rstn_i(video_source_clk_rstn_i),
		     .video_source_clk_i(video_source_clk_i),
		     .buff_addr_fifo_empty_i(w_buff_addr_fifo_empty),
		     .buff_addr_fifo_data_i(w_buff_addr_fifo_data),
		     .buff_addr_fifo_data_valid_i(w_buff_addr_fifo_data_valid),
		     .frame_start_i(frame_start_i),
		     .mem_wr_done_i(w_mem_wr_done),
		     .data_valid_i(data_valid_i),
		     .vdma_ip_en_i(vdma_ip_en_i),

		     .buff_addr_fifo_rd_o(w_buff_addr_fifo_rd),
		     .buff_addr_fifo_empty_o(buff_addr_fifo_empty_o),
		     .frame_start_o(w_frame_start),
		     .data_valid_o(w_data_valid),
		     .ddr_wr_addr_o(w_ddr_wr_addr),
             .ddr_wr_addr_valid_o(w_ddr_wr_addr_valid)
		     );
   

   ddr_write_vdma #(.g_IP_DW(g_IP_DW),
		    .g_OP_DW(g_OP_DW))
   ddr_write_vdma
     (
      .video_source_clk_rstn_i(video_source_clk_rstn_i),
      .video_source_clk_i(video_source_clk_i),
      .ddr_clk_rstn_i(ddr_clk_rstn_i),
      .ddr_clk_i(ddr_clk_i),
      .fifo_rstn_i(fifo_rstn_i),
      .frame_start_i(w_frame_start),
      .frame_ddr_addr_valid_i(w_ddr_wr_addr_valid),
      .frame_ddr_addr_i(w_ddr_wr_addr),
      .data_valid_i(w_data_valid),
      .data_i(data_i),
      .write_ackn_i(write_ackn_i),
      .write_done_i(write_done_i),

      .frame_size_fifo_wr_o(w_frame_size_fifo_wr),
      .frame_size_fifo_data_o(w_frame_size_fifo_data),
      .data_valid_o(data_valid_o),
      .data_o(data_o),
      .write_req_o(write_req_o),
      .write_length_o(write_length_o),
      .write_start_addr_o(w_write_start_addr),
      .int_dma_o(w_int_dma)
      );
   

   
endmodule // vdma_write
