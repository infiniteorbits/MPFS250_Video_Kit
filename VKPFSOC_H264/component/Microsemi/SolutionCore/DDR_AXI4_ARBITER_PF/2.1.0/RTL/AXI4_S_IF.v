// AXI4_M_S_IF.v
module AXI4_S_IF
#(
	parameter AXI_DATA_WIDTH	    = 4,
	parameter AXI_ADDR_WIDTH	    = 32
  )
  (
  // Input Ports
  input								 CLOCK_I,
  input								 RESET_n_I,
  input [AXI_DATA_WIDTH-1 : 0]	     R_DATA_I,
  input                              R_DATA_VALID_I,
  input	[AXI_ADDR_WIDTH-1 : 0]	     ARADDR_I,
  input                              ARVALID_I,
  input [7:0]                        ARSIZE_I,
  input                              R_DONE_I,
  input                              R_ACK_I,  
  // Output Ports
  output        				     BUSER_O_r,  
  output                             ARREADY_O,
  output [AXI_DATA_WIDTH-1 : 0]	     RDATA_O,
  output                             RVALID_O,
  output                             RLAST_O,
  output [AXI_ADDR_WIDTH-1 : 0]	     R_START_ADDR_O,
  output                             R_REQ_O,
  output [7:0]                       R_BURST_SIZE_O 
  );
  
  reg   [AXI_ADDR_WIDTH-1 : 0]		 araddr_dly1;
  reg   							 arvalid_dly1;
  reg   [7:0]                        arsize_dly1;
  reg   							 data_valid_dly1;
  reg   [AXI_DATA_WIDTH-1 : 0]       data_dly1;
  wire   							 data_valid_fe;
  
  assign RDATA_O		=	data_dly1;
  //assign TSTRB_O    	= {(g_DATAWIDTH/8){1'b1}};
  //assign TKEEP_O    	=   {(g_DATAWIDTH/8){1'b1}};
  assign RVALID_O		=	data_valid_dly1;
  assign R_START_ADDR_O	=	araddr_dly1;
  assign R_REQ_O        =   arvalid_dly1;
  assign R_BURST_SIZE_O =   arsize_dly1;
  assign ARREADY_O      =   R_ACK_I;
  assign BUSER_O_r		=	R_DONE_I;
  assign RLAST_O        =   data_valid_fe;
  
  assign data_valid_fe = (data_valid_dly1 & (~R_DATA_VALID_I));
  
  always @(posedge CLOCK_I or negedge RESET_n_I)
    if(!RESET_n_I)
      begin
        araddr_dly1			<= {(AXI_ADDR_WIDTH){1'b0}};
		arvalid_dly1    	<= 0;
		arsize_dly1      	<= 8'b00000000;
		data_valid_dly1		<= 0;
		data_dly1			<= {(AXI_DATA_WIDTH){1'b0}};
	  end
	else
	  begin
	    araddr_dly1			<= ARADDR_I;
		arvalid_dly1	    <= ARVALID_I;
		arsize_dly1         <= ARSIZE_I;
		data_valid_dly1		<= R_DATA_VALID_I;
		data_dly1			<= R_DATA_I;
      end 
 endmodule