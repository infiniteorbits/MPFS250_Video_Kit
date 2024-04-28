////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, Microchip Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL MICROCHIP CORPORATIONM BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// APACHE LICENSE
// Copyright (c) 2022, Microchip Corporation 
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps 
module vdma_tb;

   parameter DATA_WIDTH = 16;
   parameter AXI_CLK_WIDTH = 20 ; 
   parameter DDR_CLK_WIDTH = 4; 
   parameter VIDEO_SOURCE_CLK_WIDTH = 6; 
   parameter AXI_ADDR_WIDTH = 38;
   parameter AXI_DATA_WIDTH = 64;
   parameter AXI_ID_WIDTH = 4;
   parameter HRES = 320;
   parameter VRES = 240;      
   parameter NUM_OF_FRAMES = 1;

   logic     ACLK_I;
   logic     ARESETN_I;
   logic [31:0]	AXI4L_VDMA_araddr;
   logic	AXI4L_VDMA_arvalid;
   logic [31:0]	AXI4L_VDMA_awaddr;
   logic	AXI4L_VDMA_awvalid;
   logic	AXI4L_VDMA_bready;
   logic	AXI4L_VDMA_rready;
   logic [31:0]	AXI4L_VDMA_wdata;
   logic	AXI4L_VDMA_wvalid;
   logic [15:0]	DATA_I;
   logic	DATA_VALID_I;
   logic	DDR_CLK_I;
   logic	DDR_CLK_RSTN_I;
   logic	DDR_CTRL_READY_I;
   logic	FRAME_START_I;
   logic	VIDEO_CLK_I;
   logic	VIDEO_CLK_RSTN_I;
   logic	mAXI4_SLAVE_arready;
   logic	mAXI4_SLAVE_awready;
   logic [3:0]	mAXI4_SLAVE_bid;
   logic [1:0]	mAXI4_SLAVE_bresp;
   logic	mAXI4_SLAVE_bvalid;
   logic [63:0]	mAXI4_SLAVE_rdata;
   logic [3:0]	mAXI4_SLAVE_rid;
   logic	mAXI4_SLAVE_rlast;
   logic [1:0]	mAXI4_SLAVE_rresp;
   logic	mAXI4_SLAVE_rvalid;
   logic	mAXI4_SLAVE_wready;
   logic	AXI4L_VDMA_arready;
   logic	AXI4L_VDMA_awready;
   logic [1:0]	AXI4L_VDMA_bresp;
   logic	AXI4L_VDMA_bvalid;
   logic [31:0]	AXI4L_VDMA_rdata;
   logic [1:0]	AXI4L_VDMA_rresp;
   logic	AXI4L_VDMA_rvalid;
   logic	AXI4L_VDMA_wready;
   logic	INT_DMA_O;
   logic [37:0]	mAXI4_SLAVE_araddr;
   logic [1:0]	mAXI4_SLAVE_arburst;
   logic [3:0]	mAXI4_SLAVE_arcache;
   logic [3:0]	mAXI4_SLAVE_arid;
   logic [7:0]	mAXI4_SLAVE_arlen;
   logic [1:0]	mAXI4_SLAVE_arlock;
   logic [2:0]	mAXI4_SLAVE_arprot;
   logic [2:0]	mAXI4_SLAVE_arsize;
   logic	mAXI4_SLAVE_arvalid;
   logic [37:0]	mAXI4_SLAVE_awaddr;
   logic [1:0]	mAXI4_SLAVE_awburst;
   logic [3:0]	mAXI4_SLAVE_awcache;
   logic [3:0]	mAXI4_SLAVE_awid;
   logic [7:0]	mAXI4_SLAVE_awlen;
   logic [1:0]	mAXI4_SLAVE_awlock;
   logic [2:0]	mAXI4_SLAVE_awprot;
   logic [2:0]	mAXI4_SLAVE_awsize;
   logic	mAXI4_SLAVE_awvalid;
   logic	mAXI4_SLAVE_bready;
   logic	mAXI4_SLAVE_rready;
   logic [63:0]	mAXI4_SLAVE_wdata;
   logic	mAXI4_SLAVE_wlast;
   logic [7:0]	mAXI4_SLAVE_wstrb;
   logic	mAXI4_SLAVE_wvalid;
   logic [31:0]	buff_addr = 32'h00001000;
   logic [63:0]	frame_data;
   logic [63:0]	frame_buff_ref[*];
   logic [63:0]	sim_buff_mem;
   logic [63:0]	dut_buff_mem;
   integer	error_count;
   integer	data_valid_count;
   integer	addr;
   int		mem_count = HRES*VRES;
   
   VDMA VDMA (.*);
   axi4_ram #(.AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
	      .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
	      .AXI_ID_WIDTH(AXI_ID_WIDTH))
   axi4_ram
     (
      .sys_clk_i(DDR_CLK_I),
      .resetn_i(DDR_CLK_RSTN_I),
      .awaddr(mAXI4_SLAVE_awaddr),
      .awid(mAXI4_SLAVE_awid),
      .awlen(mAXI4_SLAVE_awlen),
      .awvalid(mAXI4_SLAVE_awvalid),
      .awready(mAXI4_SLAVE_awready),
      .wdata(mAXI4_SLAVE_wdata),
      .wvalid(mAXI4_SLAVE_wvalid),
      .wlast(mAXI4_SLAVE_wlast),
      .wready(mAXI4_SLAVE_wready),
      .bready(mAXI4_SLAVE_bready),
      .bid(mAXI4_SLAVE_bid),
      .bresp(mAXI4_SLAVE_bresp),
      .bvalid(mAXI4_SLAVE_bvalid),
      .araddr(mAXI4_SLAVE_araddr),
      .arid(mAXI4_SLAVE_arid),
      .arlen(mAXI4_SLAVE_arlen),
      .arvalid(mAXI4_SLAVE_arvalid),
      .arready(mAXI4_SLAVE_arready),
      .rready(mAXI4_SLAVE_rready),
      .rid(mAXI4_SLAVE_rid),
      .rdata(mAXI4_SLAVE_rdata),
      .rvalid(mAXI4_SLAVE_rvalid),
      .rlast(mAXI4_SLAVE_rlast),
      .rresp(mAXI4_SLAVE_rresp)
      );

   ////////////////////////////////////////////////////////////////      
   //Clock initialisation
   ////////////////////////////////////////////////////////////////         
   initial
     begin
	ACLK_I = 0;
	DDR_CLK_I = 0;
	VIDEO_CLK_I = 0;	
	fork
	   forever #(AXI_CLK_WIDTH/2) ACLK_I = ~ACLK_I;
	   forever #(DDR_CLK_WIDTH/2) DDR_CLK_I = ~DDR_CLK_I;
	   forever #(VIDEO_SOURCE_CLK_WIDTH/2) VIDEO_CLK_I = ~VIDEO_CLK_I;
	join	
     end		      

   
   ////////////////////////////////////////////////////////////////      
   //Reset initialisation
   ////////////////////////////////////////////////////////////////         
   initial
     begin
	ARESETN_I = 0;
	DDR_CLK_RSTN_I = 0;
	VIDEO_CLK_RSTN_I = 0;
	DDR_CTRL_READY_I = 0;
	fork
	   #(AXI_CLK_WIDTH*10 + 1)    ARESETN_I = 1;
	   #(DDR_CLK_WIDTH*10 + 1)    DDR_CLK_RSTN_I = 1;
	   #(VIDEO_SOURCE_CLK_WIDTH*10 + 1)    VIDEO_CLK_RSTN_I = 1;
	join
	DDR_CTRL_READY_I = 1;
     end		      


   ////////////////////////////////////////////////////////////////      
   //Start video data
   ////////////////////////////////////////////////////////////////         
   initial begin
      DATA_I = 16'h0;      
      DATA_VALID_I = 0;
      FRAME_START_I = 0;
      wait (VIDEO_CLK_RSTN_I);
      wait (ARESETN_I);
      #105;      
      wait (DDR_CLK_RSTN_I);
      addr = 0;
      #1000;      
      repeat(NUM_OF_FRAMES) begin
	 frame_start;	 
	 frame_write;
      end
      frame_start;
      #500;
      compare_mem;            
      $stop;
   end


   ////////////////////////////////////////////////////////////////      
   //Issuing the frame start signal
   ////////////////////////////////////////////////////////////////      
   task automatic frame_start;
      begin
	 #(10*VIDEO_SOURCE_CLK_WIDTH + 1);
	 @(negedge VIDEO_CLK_I);
	 #(20*VIDEO_SOURCE_CLK_WIDTH) FRAME_START_I = 1;
	 #VIDEO_SOURCE_CLK_WIDTH FRAME_START_I = 0;
	 #(100*VIDEO_SOURCE_CLK_WIDTH) ;
      end
   endtask // frame_start
   
   
   ////////////////////////////////////////////////////////////////   
   //Writing frame to memory
   ////////////////////////////////////////////////////////////////   
   task automatic frame_write;
      begin
	 repeat(VRES)
	   for (int i=0; i<(HRES+1); i++)
	     begin
		@(posedge VIDEO_CLK_I);
		if (i<HRES) begin
		   DATA_I[7:0] = DATA_I[7:0] + 2;
		   DATA_I[15:8] = DATA_I[7:0] + 1;
		   DATA_VALID_I = 1;
		end
		else 
		  DATA_VALID_I = 0;
	     end	      
	 #(199*VIDEO_SOURCE_CLK_WIDTH);
	 DATA_I = 16'h0;
      end
   endtask


   ////////////////////////////////////////////////////////////////   
   //Comparing the result of the memories
   ////////////////////////////////////////////////////////////////   
   task automatic compare_mem;
      begin
	 error_count = 0;
	 mem_count = (HRES*VRES/4);
	 
	 for (int i=0; i<mem_count; i++)  begin
	    sim_buff_mem = frame_buff_ref[i];
	    dut_buff_mem = axi4_ram.mem_module_0.mem[i];

	    if (sim_buff_mem != dut_buff_mem)
	      error_count = error_count + 1;	    
	 end

	 if (error_count == 0) begin
	    $display();	    
	    $display("///////////////////////////////////////");	    
	    $display("Simulation Test Case Passed");
	    $display("///////////////////////////////////////");
	    $display();	    	    
	 end
	 else begin
	    $display();		    
	    $display("///////////////////////////////////////");	    	    
	    $display("Simulation Test Case Failed");
	    $display("///////////////////////////////////////");
	    $display();		    
	 end
	 
      end
   endtask
   

   ////////////////////////////////////////////////////////////////
   //control register programming
   ////////////////////////////////////////////////////////////////   
   initial
     begin
	AXI4L_VDMA_wvalid = 0;
	AXI4L_VDMA_bready = 1;
	AXI4L_VDMA_araddr = 'hf;
	AXI4L_VDMA_arvalid = 0;
	AXI4L_VDMA_rready = 0;
	@(posedge ARESETN_I);
	@(negedge ACLK_I);	
	axi4l_write(8'h04, 32'h2); //Reset the IP core
	axi4l_write(8'h04, 32'h0); //Disable the IP core	
	axi4l_write(8'h08, 32'h1); //Global interrupt enable
	axi4l_write(8'h10, 32'h1f); //Enabling all interrupts
	repeat(NUM_OF_FRAMES)  begin
	   axi4l_write(8'h1C, buff_addr); //Writing buffer address
	   buff_addr[15:12] = buff_addr[15:12] + 1;	   
	end
	axi4l_write(8'h04, 32'h1); //Enable the IP core
     end


   /************************************************************************
    AXI4 Lite task to program the control registers   
    *************************************************************************/ 
   task automatic axi4l_write;
      input [7:0]  addr; //control register address
      input [31:0] data;      
      begin
	 AXI4L_VDMA_awvalid = 0;
	 AXI4L_VDMA_awaddr = addr;	 
	 AXI4L_VDMA_wvalid  = 0; 
	 AXI4L_VDMA_wdata   = data;
       	 @(posedge ACLK_I);
       	 AXI4L_VDMA_awvalid = 1;
       	 wait(AXI4L_VDMA_awready);
       	 @(posedge ACLK_I);
       	 AXI4L_VDMA_awvalid = 0;
	 @(posedge ACLK_I);
       	 AXI4L_VDMA_wvalid  = 1;
       	 @(posedge ACLK_I);    
       	 AXI4L_VDMA_wvalid = 0;
	 @(posedge ACLK_I);
	 @(negedge ACLK_I);
      end      
   endtask 


   ////////////////////////////////////////////////////////////////
   //Capturing the frame data when writing to DUT
   ////////////////////////////////////////////////////////////////   
   always @(posedge VIDEO_CLK_I, negedge VIDEO_CLK_RSTN_I)
     if (!VIDEO_CLK_RSTN_I) begin
	frame_data = 64'h0;
	data_valid_count = 'h0;
	addr = 0;	
     end
     else 
       if (DATA_VALID_I) begin

	  if (data_valid_count < 'd4)
	    data_valid_count = data_valid_count + 1;
	  else
	    data_valid_count = 1;

	  if (data_valid_count == 0 || data_valid_count == 'd1)
	    frame_data[15:0] = DATA_I;
	  else if (data_valid_count == 'd2)
	    frame_data[31:16] = DATA_I;
	  else if (data_valid_count == 'd3)
	    frame_data[47:32] = DATA_I;	  
	  else if (data_valid_count == 'd4)	  
	    frame_data[63:48] = DATA_I;

	  if (data_valid_count == 'd4) begin
	     frame_buff_ref[addr] = frame_data; //writing the data to mem	     
	     addr = addr + 1;
	  end

       end


endmodule // vdma_tb

