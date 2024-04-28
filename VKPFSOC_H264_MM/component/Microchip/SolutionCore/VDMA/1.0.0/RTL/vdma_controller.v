//=================================================================================================
//-- File Name                           : vdma_controller.v
//-- Targeted device                     : Microsemi-SoC
//-- Author                              : India Solutions Team
//--
//-- COPYRIGHT 2019 BY MICROSEMI
//-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
//-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
//-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
//--
//=================================================================================================

module vdma_controller (
		       // inputs 
		       input		 video_source_clk_rstn_i,
		       input		 video_source_clk_i, 
		       input		 buff_addr_fifo_empty_i,
		       input [31:0]	 buff_addr_fifo_data_i,
		       input		 buff_addr_fifo_data_valid_i,
		       input		 frame_start_i,
		       input		 mem_wr_done_i,
		       input		 data_valid_i,
		       input		 vdma_ip_en_i,

		       output reg	 buff_addr_fifo_rd_o,
		       output		 buff_addr_fifo_empty_o,
		       output		 frame_start_o,
		       output reg	 data_valid_o,
		       output reg [31:0] ddr_wr_addr_o,
               output reg        ddr_wr_addr_valid_o
		       );


   //----------------------------------------------------------------   
   //Parameter declarations
   //----------------------------------------------------------------   
   parameter WAIT_FOR_BUFF_ADDR_FIFO_DATA = 'd0;
   parameter WAIT_FOR_FRAME_START = 'd1;
   parameter WRITING = 'd2;
   parameter CHECK_BUFF_ADDR_FIFO_EMPTY = 'd3;
   
   //----------------------------------------------------------------   
   // Wire and Reg declarations
   //----------------------------------------------------------------   
   reg [1:0] 				 r_state; //state machine variable
   reg 					 mem_wr_done_dly;
   reg  				 frame_start_dly;
   reg 					 r_ddr_wr_en;
   reg [3:0]             r_buff_addr_fifo_data_valid;

   assign frame_start_o = (frame_start_i & r_ddr_wr_en);   
   assign data_valid_o = data_valid_i & r_ddr_wr_en;
   assign buff_addr_fifo_empty_o = !vdma_ip_en_i || buff_addr_fifo_empty_i;
   
   //----------------------------------------------------------------   
   // Registering the signals to find rising edge
   //----------------------------------------------------------------   
   always@ (posedge video_source_clk_i , negedge video_source_clk_rstn_i )
     if (!video_source_clk_rstn_i) begin
       	mem_wr_done_dly <= 'h0;
	frame_start_dly <= 'h0;
     end
     else begin
	mem_wr_done_dly <= mem_wr_done_i;
	frame_start_dly <= frame_start_i;   
     end
     
   //----------------------------------------------------------------   
   // Registering the signals to find rising edge
   //----------------------------------------------------------------   
   always@ (posedge video_source_clk_i , negedge video_source_clk_rstn_i )
     if (!video_source_clk_rstn_i) begin
        r_buff_addr_fifo_data_valid <= 'h0;
       	ddr_wr_addr_valid_o <= 'h0;
     end
     else begin
        r_buff_addr_fifo_data_valid <= {r_buff_addr_fifo_data_valid[2:0],buff_addr_fifo_data_valid_i};
	ddr_wr_addr_valid_o <= (|r_buff_addr_fifo_data_valid);
     end
   
   //----------------------------------------------------------------   
   // FSM            : dma_state_machine
   // Description    : This state machine generates the control signal to 
   // enable the frame data written into the ddr memory
   //----------------------------------------------------------------
   always@ (posedge video_source_clk_i , negedge video_source_clk_rstn_i )
     if (!video_source_clk_rstn_i) begin
	r_state <= WAIT_FOR_BUFF_ADDR_FIFO_DATA;
	buff_addr_fifo_rd_o <= 0;
	ddr_wr_addr_o <= 'h0;	
	r_ddr_wr_en <= 0;
     end
     else 
	case (r_state)
	  
	  WAIT_FOR_BUFF_ADDR_FIFO_DATA:
	    begin
	       buff_addr_fifo_rd_o <= 0;
	       r_ddr_wr_en <= 0;	       
	       if (!buff_addr_fifo_empty_i) begin
		  r_state <= WAIT_FOR_FRAME_START;
		  buff_addr_fifo_rd_o <= 1;
	       end
	       
	    end
	  
	  WAIT_FOR_FRAME_START:
	    begin
	       buff_addr_fifo_rd_o <= 0;
	       if (buff_addr_fifo_data_valid_i)
		 ddr_wr_addr_o <= buff_addr_fifo_data_i;	
	       
	       if (frame_start_i & !frame_start_dly)
		 r_state <= WRITING;
	    end
	  

	  WRITING:
	    begin
	       buff_addr_fifo_rd_o <= 0;       
	       r_ddr_wr_en <= 1;

	       if (buff_addr_fifo_data_valid_i)
		 ddr_wr_addr_o <= buff_addr_fifo_data_i;	

	       if (mem_wr_done_i & !mem_wr_done_dly)	       
		 r_state <= CHECK_BUFF_ADDR_FIFO_EMPTY;
	    end

	  
	  CHECK_BUFF_ADDR_FIFO_EMPTY:
	    begin
	       r_ddr_wr_en <= 0;	       
	       if (!buff_addr_fifo_empty_i) begin
		  buff_addr_fifo_rd_o <= 1;       		  
		 r_state <= WRITING;
		  end
	       else
		 r_state <= WAIT_FOR_BUFF_ADDR_FIFO_DATA;

	    end	  
	  
	  default:
	       r_state <= WAIT_FOR_BUFF_ADDR_FIFO_DATA;

	endcase // case (r_state)

endmodule // vdma_controller


