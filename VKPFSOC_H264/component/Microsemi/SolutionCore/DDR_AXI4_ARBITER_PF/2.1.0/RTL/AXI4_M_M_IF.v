module AXI4_M_M_IF
#(
	parameter AXI_DATA_WIDTH	    = 4,
	parameter AXI_ADDR_WIDTH	    = 32
  )
  (
  // Input Ports
  input [AXI_DATA_WIDTH-1 : 0]	     WDATA_I,
  input                              WVALID_I,
  input	[AXI_ADDR_WIDTH-1 : 0]	     AWADDR_I,
  input                              AWVALID_I,
  input [7:0]                        AWSIZE_I,
  input                              W_DONE_I,
  input                              W_ACK_I,  
  // Output Ports
  output        				     BUSER_O,  
  output                             AWREADY_O,
  output [AXI_DATA_WIDTH-1 : 0]	     W_DATA_O,
  output                             W_DATA_VALID_O,
  output [AXI_ADDR_WIDTH-1: 0]	     W_START_ADDR_O,
  output                             W_REQ_O,
  output [7:0]                       W_BURST_SIZE_O 
  
  );
  
  assign W_DATA_O			=	WDATA_I;
  assign W_DATA_VALID_O     =   WVALID_I;
  assign W_START_ADDR_O     =   AWADDR_I;
  assign W_BURST_SIZE_O     =   AWSIZE_I;
  assign W_REQ_O            =   AWVALID_I;
  assign BUSER_O	        =	W_DONE_I;
  assign AWREADY_O	        =	W_ACK_I;
  
 endmodule