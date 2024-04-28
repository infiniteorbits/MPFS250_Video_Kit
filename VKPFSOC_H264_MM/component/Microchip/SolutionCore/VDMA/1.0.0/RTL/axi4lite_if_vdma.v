// --*************************************************************************************************
// -- File Name                           : axi4lite_if_vdma.v
// -- Targeted device                     : Microsemi-SoC
// -- Author                              : India Solutions Team
// --
// -- COPYRIGHT 2021 BY MICROSEMI
// -- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
// -- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
// -- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
// --
// --*************************************************************************************************

//Address values of the registers
localparam ADDR_DECODER_WIDTH = 8;

//Read Only
localparam IP_VER = 32'h0;

//Read-Write
localparam CTRL_REG = 32'h4;

//Read-Write
localparam GLBL_INT_EN = 32'h8;

//Read-Only
localparam INTERRUPT_STATUS = 32'hc;

//Read-Write
localparam INTERRUPT_EN = 32'h10;

//Write-Only
localparam BUFF_ADDR_FIFO = 32'h1C;

//Read-Only
localparam FRAME_SIZE_FIFO = 32'h24;


module axi4lite_if_vdma  
  (

   // Clock and Reset interface----------------------------------------------------
   input	     aclk, // clock
   input	     aresetn, // This active-low reset
   input	     soft_aresetn, //Reset initated by processor
   //write address channel
   input wire	     awvalid, // AXI4-Lite write address valid. This signal indicates that valid write address and control information are available.
   output reg	     awready, // AXI4-Lite write address ready. This signal indicates that the target is ready to accept an address and associated control signals.
   input wire [31:0] awaddr, // AXI4-Lite write address.
   //write data channel
   input wire [31:0] wdata, // AXI4-Lite write data.
   input wire	     wvalid, // AXI4-Lite write valid.
   output reg	     wready, // AXI4-Lite Write ready.
   //write response channel
   output [1:0]	     bresp, // AXI4-Lite write response.
   output reg	     bvalid, // AXI4-Lite write response valid.
   input wire	     bready, // AXI4-Lite response ready.
   //read address channel
   input wire [31:0] araddr, // AXI4-Lite read address. The read address gives the address of the first transfer in a read burst transaction.  
   input wire	     arvalid, // AXI4-Lite read address valid. This signal indicates that the channel is signaling valid read address and control information. 
   output reg	     arready, // AXI4-Lite response ready. This signal indicates that the slave is ready to accept an address and associated control signals.
   //read data and response channel
   input wire	     rready, 
   output [31:0]     rdata, // AXI4-Lite read data.
   output [1:0]	     rresp, // AXI4-Lite read response.
   output reg	     rvalid, // AXI4-Lite read valid. This signal indicates that the channel is signaling the required read data.

   input	     frame_size_fifo_empty,
   input [31:0]	     frame_size_fifo,
   input [4:0]	     interrupt_status,

   output reg	     frame_size_fifo_ren,
   output reg	     buff_addr_fifo_wen,
   output reg [31:0] buff_addr_fifo_data,
   output reg [4:0]  interrupt_status_clr,
   output reg [4:0]  interrupt_en,
   output reg	     glbl_int_en,
   output	     fifo_rstn,
   output	     ip_rstn,
   output	     ip_en
   );
   
   wire		     mem_wr_valid;
   wire [31:0]	     mem_wr_addr;
   wire [31:0]	     mem_wr_data;
   wire		     mem_rd_req;   
   wire [31:0]	     mem_rd_data;
   wire		     mem_rd_data_valid;
   wire [31:0] 	     mem_rd_addr;   
   wire [2:0] 	     ctrl_reg;
   
   assign fifo_rstn = !ctrl_reg[2];   
   assign ip_rstn = !ctrl_reg[1];
   assign ip_en = ctrl_reg[0];
   
   axi4lite_adapter_vdma axi4lite_adapter_vdma_0 (.*);
   write_reg_vdma write_reg_vdma_0 (.*);
   read_reg_vdma read_reg_vdma_0 (.*);   

endmodule // axi4lite_if_vdma




// --*************************************************************************************************
// -- File Name                           : axi4lite_adapter_vdma.v
// -- Targeted device                     : Microsemi-SoC
// -- Author                              : India Solutions Team
// --
// -- COPYRIGHT 2021 BY MICROSEMI
// -- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
// -- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
// -- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
// --
// --*************************************************************************************************

module axi4lite_adapter_vdma  
  (
   // Clock and Reset interface----------------------------------------------------
   input wire	     aclk, // clock
   input wire	     aresetn, // This active-low reset
   input	     soft_aresetn,
   //write address channel
   input wire	     awvalid, // AXI4-Lite write address valid. This signal indicates that valid write address and control information are available.
   output reg	     awready, // AXI4-Lite write address ready. This signal indicates that the target is ready to accept an address and associated control signals.
   input wire [31:0] awaddr, // AXI4-Lite write address.
   //write data channel
   input wire [31:0] wdata, // AXI4-Lite write data.
   input wire	     wvalid, // AXI4-Lite write valid.
   output reg	     wready, // AXI4-Lite Write ready.
   //write response channel
   output [1:0]	     bresp, // AXI4-Lite write response.
   output reg	     bvalid, // AXI4-Lite write response valid.
   input wire	     bready, // AXI4-Lite response ready.
   //read address channel
   input wire [31:0] araddr, // AXI4-Lite read address. The read address gives the address of the first transfer in a read burst transaction.  
   input wire	     arvalid, // AXI4-Lite read address valid. This signal indicates that the channel is signaling valid read address and control information. 
   output reg	     arready, // AXI4-Lite response ready. This signal indicates that the slave is ready to accept an address and associated control signals.
   //read data and response channel
   input wire	     rready, 
   output [31:0]     rdata, // AXI4-Lite read data.
   output [1:0]	     rresp, // AXI4-Lite read response.
   output reg	     rvalid, // AXI4-Lite read valid. This signal indicates that the channel is signaling the required read data.
   //Memory interface
   output reg	     mem_wr_valid,
   output reg [31:0] mem_wr_addr,
   output reg [31:0] mem_wr_data,
   output reg	     mem_rd_req,
   output [31:0]     mem_rd_addr,
   input	     mem_rd_data_valid,
   input [31:0]	     mem_rd_data
   );      

   reg [31:0]	     awaddr_reg;
   reg [31:0]	     araddr_reg;            
   wire		     raddr_phs_cmp;   

   //------------------------------------------------------------------------------------
   // AXI4 Lite Write Address channel
   //------------------------------------------------------------------------------------   

   ////////////////////////////////////////////////
   // AWREADY generation
   ////////////////////////////////////////////////
   always@(posedge aclk  or negedge aresetn)
     begin
	if(!aresetn)
     	  awready  <= 1'b1;
	else if (bvalid && bready)
          awready  <= 1'b1;
	else if(awvalid && awready)
          awready  <= 1'b0;
     end
   

   ////////////////////////////////////////////////
   // Storing the valid AWADDR 
   ////////////////////////////////////////////////
   always@(posedge aclk or negedge aresetn)
     begin
	if(!aresetn)
          awaddr_reg  <= 'd0;
	else if(awvalid && awready)
          awaddr_reg  <= awaddr;
     end


   //------------------------------------------------------------------------------------
   // AXI4 Lite Write Data channel
   //------------------------------------------------------------------------------------   

   ////////////////////////////////////////////////
   // Generating WREADY
   ////////////////////////////////////////////////
   always@(posedge aclk or negedge aresetn)
     begin
	if(!aresetn)
          wready  <= 1'd0;
	else if (wvalid && wready)
          wready  <= 1'd0;
	else if(awvalid && awready)
          wready  <= 1'd1;
     end


   ////////////////////////////////////////////////
   // Writing the memory with valid data 
   ////////////////////////////////////////////////   
   assign mem_wr_addr = awaddr_reg;
   assign mem_wr_data = wdata;
   assign mem_wr_valid = (wvalid == 1'b1 && wready == 1'b1);


   //------------------------------------------------------------------------------------
   // AXI4 Lite Write Response channel
   //------------------------------------------------------------------------------------   

   ////////////////////////////////////////////////
   // Generating BVALID
   ////////////////////////////////////////////////   
   always@(posedge aclk or negedge aresetn)
     begin
	if(!aresetn)
          bvalid  <= 1'd0;
	else if(bvalid == 1'b1 && bready == 1'b1)
          bvalid  <= 1'd0;
	else if(wvalid == 1'b1 && wready == 1'b1 )
          bvalid  <= 1'b1;
     end

   assign bresp = 'd0; //Giving OK response for all strobe and protection conditions
   
   //------------------------------------------------------------------------------------
   // AXI4 Lite Read Address channel
   //------------------------------------------------------------------------------------   

   ////////////////////////////////////////////////
   // Generating ARREADY
   ////////////////////////////////////////////////      
   always@(posedge aclk or negedge aresetn)
     begin
	if(!aresetn)
          arready  <= 1'd1;
	else if(rvalid && rready)
          arready  <= 1'd1;
	else if(raddr_phs_cmp)
          arready  <= 1'b0;
     end

   assign raddr_phs_cmp = (arvalid && arready);

   ////////////////////////////////////////////////
   // Generating memory read request
   ////////////////////////////////////////////////         
   always@(posedge aclk or negedge aresetn)
     if(!aresetn)
       mem_rd_req <= 'h0;   
     else
       mem_rd_req <= arvalid && arready;
   

   
   ////////////////////////////////////////////////
   // Registering valid read address
   ////////////////////////////////////////////////         
   always@(posedge aclk or negedge aresetn)
     if(!aresetn)
       araddr_reg <= 'd0;
     else if(arvalid && arready)
       araddr_reg <= araddr; 

   assign mem_rd_addr = araddr_reg; 
   
   //------------------------------------------------------------------------------------
   // AXI4 Lite Read Data channel
   //------------------------------------------------------------------------------------   

   ////////////////////////////////////////////////
   // RVALID generation
   ////////////////////////////////////////////////         
   always@(posedge aclk or negedge aresetn)
     if(!aresetn)
       rvalid <= 'b0;   
     else if(rvalid && rready) //hold rvalid high till rready is asserted
       rvalid <= 'b0;
     else if (mem_rd_data_valid)
       rvalid <= 1'b1;
   
   assign rdata = mem_rd_data; //connect the the mem data directly to axi4 lite bus
   assign rresp = 2'h0; //return read OK response
   
endmodule // axi4lite_adapter_vdma



// --*************************************************************************************************
// -- File Name                           : write_reg_vdma.v
// -- Targeted device                     : Microsemi-SoC
// -- Author                              : India Solutions Team
// --
// -- COPYRIGHT 2021 BY MICROSEMI
// -- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
// -- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
// -- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
// --
// --*************************************************************************************************

module write_reg_vdma (

		      // Clock and Reset interface----------------------------------------------------
		      input		aclk, // clock
		      input		aresetn, // This active-low reset
		      input		soft_aresetn, //processor initiated reset
		      //Memory interface
		      input		mem_wr_valid,
		      input [31:0]	mem_wr_addr,
		      input [31:0]	mem_wr_data,

		      //Write Only registers
		      output reg [31:0]	buff_addr_fifo_data,
		      output reg	buff_addr_fifo_wen,

		      //Read Write registers
		      output [2:0]	ctrl_reg,
		      output reg	glbl_int_en,
		      output reg [4:0]	interrupt_en,

		      //Status register clear
		      output reg [4:0]	interrupt_status_clr
		      )/* synthesis syn_preserve = 1 */; 

   reg					r_ip_rstn;
   reg					r_fifo_rstn;
   reg [3:0]				r_ip_rstn_dly;
   reg [3:0]				r_fifo_rstn_dly;
   reg					r_ip_en;


   ////////////////////////////////////////////////
   // IP enable/disable bit
   ////////////////////////////////////////////////
   always@(posedge aclk or negedge aresetn)
     if (!aresetn)
       r_ip_en <= 1'b1;
     else if (mem_wr_valid && mem_wr_addr[ADDR_DECODER_WIDTH-1:0] == CTRL_REG)
       r_ip_en <= mem_wr_data[0];

   assign ctrl_reg[0] = r_ip_en;


   ////////////////////////////////////////////////
   // IP reset functionality
   ////////////////////////////////////////////////
   always@(posedge aclk or negedge aresetn)
     if (!aresetn)
       r_ip_rstn_dly <= 'h0;
     else begin
       	r_ip_rstn_dly[0] <= r_ip_rstn;
	r_ip_rstn_dly[3:1] <= r_ip_rstn_dly[2:0];
     end

   assign ctrl_reg[1] = |r_ip_rstn_dly;   
   
   ////////////////////////////////////////////////////////
   // Stretching the fifo reset signal to 4 clock cycles
   ///////////////////////////////////////////////////////
   always@(posedge aclk  or negedge soft_aresetn)
     if(!soft_aresetn) 
	r_fifo_rstn_dly <= 'h0;
     else
       begin
	  r_fifo_rstn_dly[0] <= r_fifo_rstn;
	  r_fifo_rstn_dly[3:1] <= r_fifo_rstn_dly[2:0];
       end // else: !if(!soft_aresetn)

   assign ctrl_reg[2] = |r_fifo_rstn_dly;
   
   
   ////////////////////////////////////////////////
   // Write registers
   ////////////////////////////////////////////////
   always@(posedge aclk  or negedge soft_aresetn)
     if(!soft_aresetn) begin
	buff_addr_fifo_data <= 'h0;
	buff_addr_fifo_wen <= 1'b0;
	r_ip_rstn <= 'b0;
	r_fifo_rstn <= 'b0;
	glbl_int_en <= 'h0;
	interrupt_en <= 'h0;
     end
     else if (mem_wr_valid) 
       case (mem_wr_addr[ADDR_DECODER_WIDTH-1:0])

	 BUFF_ADDR_FIFO:begin
	    buff_addr_fifo_data <= mem_wr_data;
	    buff_addr_fifo_wen <= 1'b1;	    
	 end

	 CTRL_REG: begin
	    r_ip_rstn <= mem_wr_data[1];
	    r_fifo_rstn <= mem_wr_data[2];
	    end

	 GLBL_INT_EN:
	   glbl_int_en <= mem_wr_data[0];

	 INTERRUPT_EN:
	   interrupt_en <= mem_wr_data[4:0];

	 default: begin
	    buff_addr_fifo_wen <= 1'b0;
	    r_ip_rstn <= 'b0;
	    r_fifo_rstn <= 'b0;
	 end
	 
       endcase // case (mem_wr_addr)

     else begin
	buff_addr_fifo_wen <= 1'b0;
	r_ip_rstn <= 'b0;
	r_fifo_rstn <= 'b0;
     end // else: !if(mem_wr_valid)

   
   ////////////////////////////////////////////////
   // Updating status register
   ////////////////////////////////////////////////
   always@(posedge aclk or negedge soft_aresetn)
     if (!soft_aresetn)
       interrupt_status_clr <= 'h0;
     else begin
	if (mem_wr_valid && mem_wr_addr[ADDR_DECODER_WIDTH-1:0] == INTERRUPT_STATUS)
	  interrupt_status_clr <= mem_wr_data[4:0];
	else
	  interrupt_status_clr <= 'h0;
     end


endmodule



// --*************************************************************************************************
// -- File Name                           : read_reg_vdma.v
// -- Targeted device                     : Microsemi-SoC
// -- Author                              : India Solutions Team
// --
// -- COPYRIGHT 2021 BY MICROSEMI
// -- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
// -- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
// -- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
// --
// --*************************************************************************************************

module read_reg_vdma (
		     // Clock and Reset interface----------------------------------------------------
		     input	       aclk, // clock
		     input	       soft_aresetn, //Reset initiated by processor
		     //Memory interface
		     input	       mem_rd_req,
		     input [31:0]      mem_rd_addr,
		     output reg [31:0] mem_rd_data,
		     output reg	       mem_rd_data_valid,

		     //Read Only registers
		     input [4:0]       interrupt_status,
		     input [31:0]      frame_size_fifo,
		     input	       frame_size_fifo_empty, 
		     //Read Write registers
		     input [2:0]       ctrl_reg,
		     input	       glbl_int_en,
		     input [4:0]       interrupt_en,
		     output reg	       frame_size_fifo_ren
		     )/* synthesis syn_noprune = 1 */;

   reg [31:0]		  r_frame_size;
   reg [1:0]		  r_mem_rd_req_dly;
   reg			  r_frame_start_dly;
   wire			  w_frame_start_re;
   
   ////////////////////////////////////////////////
   // Generating frame size fifo read enable
   ////////////////////////////////////////////////
   always@ (posedge aclk , negedge soft_aresetn) 
     if (!soft_aresetn) 
       frame_size_fifo_ren <= 'd0;
     else if (mem_rd_req && mem_rd_addr[ADDR_DECODER_WIDTH-1:0] == FRAME_SIZE_FIFO)
       if (!frame_size_fifo_empty)
	 frame_size_fifo_ren <= 1;
       else
	 frame_size_fifo_ren <= 0;	     
     else
       frame_size_fifo_ren <= 0;
  

   ////////////////////////////////////////////////
   // Storing the frame size in local register
   ////////////////////////////////////////////////
   always@ (posedge aclk , negedge soft_aresetn) 
     if (!soft_aresetn)
       r_frame_size <= 'h0;   
     else if(frame_size_fifo_ren)
       r_frame_size <= frame_size_fifo;

   
   ////////////////////////////////////////////////
   // Delaying the mem read request and generating data valid
   ////////////////////////////////////////////////
   always@ (posedge aclk , negedge soft_aresetn) 
     if (!soft_aresetn) begin
	r_mem_rd_req_dly <= 'h0;
	mem_rd_data_valid <= 'h0;
     end
     else begin
	r_mem_rd_req_dly <= {r_mem_rd_req_dly[0], mem_rd_req};
	mem_rd_data_valid <= r_mem_rd_req_dly[1];
     end
   
   
   ////////////////////////////////////////////////
   // Read registers based on input address
   ////////////////////////////////////////////////
   always@(posedge aclk, negedge soft_aresetn)
     if (!soft_aresetn)
       mem_rd_data <= 'h0;
     else if (r_mem_rd_req_dly[1])
       case (mem_rd_addr[ADDR_DECODER_WIDTH-1:0])
	 
	 CTRL_REG:
	   mem_rd_data <= ctrl_reg;

	 GLBL_INT_EN:
	   mem_rd_data <= glbl_int_en;	 

	 INTERRUPT_EN:
	   mem_rd_data <= interrupt_en;
	 
	 INTERRUPT_STATUS:
	   mem_rd_data <= interrupt_status;

	 IP_VER: begin
	    mem_rd_data[31:24] <= 'h0;	    
	    mem_rd_data[23:16] <= 'h1;
	    mem_rd_data[15:0] <= 'h0;
	 end
	 
	 FRAME_SIZE_FIFO:
	   mem_rd_data <= r_frame_size;

	 default: 
	   mem_rd_data <= 32'h0;

       endcase // case (mem_rd_addr)
   
endmodule
