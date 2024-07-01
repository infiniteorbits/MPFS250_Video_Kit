--=================================================================================================
-- File Name                           : Image_Scaler.vhd
-- Description						   : Supporting both Native mode and AXI4 Stream mode
-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
-- COPYRIGHT 2022 BY MICROCHIP
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROCHIP
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROCHIP FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--=================================================================================================
--=================================================================================================
-- Libraries
--=================================================================================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;   
--=================================================================================================
-- Image_Scaler entity declaration
--=================================================================================================                                                                                                                          
ENTITY Image_Scaler IS                                                                                                       
  GENERIC(
-- Generic List
    -- Specifies the data width
    G_DATA_WIDTH 		: INTEGER RANGE 8 TO 16 := 8;
	
	-- Specified size of FIFOs for storing one row of input and output image
	G_INPUT_FIFO_AWIDTH  : INTEGER RANGE 1 To 13 := 13;
	G_OUTPUT_FIFO_AWIDTH : INTEGER RANGE 1 To 13 := 13;
	
    G_CONFIG            : INTEGER := 0;  --  0= Native and 1= AXI4-Lite
    G_FORMAT		    : INTEGER := 0   --  0= Native and 1= AXI4 Stream	
    );
  PORT (
-- Port List
    -- System reset
    RESETN_I 							: IN STD_LOGIC;

    -- System clock
    SYS_CLK_I 							: IN STD_LOGIC;
	
	-- IP clock ~200MHz
	IP_CLK_I						    : IN STD_LOGIC;

    -- Specifies the input data is valid or not
    DATA_VALID_I 						: IN STD_LOGIC;  
	
	-- Data input to SLAVE
    TDATA_I                       		: IN STD_LOGIC_VECTOR(3*G_DATA_WIDTH-1 DOWNTO 0);
    
	-- Specifies the valid control signal to SLAVE
    TVALID_I                       		: IN STD_LOGIC;
	
	TUSER_I                       		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	TREADY_O                       		: OUT STD_LOGIC;
	
    -- data input	  
    DATA_R_I       						: IN STD_LOGIC_VECTOR (G_DATA_WIDTH - 1 DOWNTO 0);
	DATA_G_I       						: IN STD_LOGIC_VECTOR (G_DATA_WIDTH - 1 DOWNTO 0);
	DATA_B_I       						: IN STD_LOGIC_VECTOR (G_DATA_WIDTH - 1 DOWNTO 0);
	
	HORZ_RES_IN_I 		                : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
	VERT_RES_IN_I     	                : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
	HORZ_RES_OUT_I	                    : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
	VERT_RES_OUT_I                      : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
	
	-- Scale factors
	SCALE_FACTOR_HORZ_I                 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	SCALE_FACTOR_VERT_I     	        : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	-- AXI4 reset
    AXI_RESETN_I                         : IN  STD_LOGIC;
    -- axi clk
    AXI_CLK_I                            : IN  STD_LOGIC;
    
	-- axi write adrs channel
	AXI_AWVALID_I                        : IN   STD_LOGIC;
	
	AXI_AWREADY_O                        : OUT  STD_LOGIC;
	
	AXI_AWADDR_I                         : IN   STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	AXI_AWPROT_I                         : IN   STD_LOGIC_VECTOR(2 DOWNTO 0);
	
	AXI_AWBURST_I                        : IN   STD_LOGIC_VECTOR(1 DOWNTO 0);	
	-- axi write data channel
	AXI_WDATA_I                          : IN   STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	AXI_WVALID_I                         : IN   STD_LOGIC;
	
	AXI_WREADY_O                         : OUT  STD_LOGIC;
	
	AXI_WSTRB_I                          : IN   STD_LOGIC_VECTOR(3 DOWNTO 0);	
    -- axi write response channel
    AXI_BVALID_O                         : OUT  STD_LOGIC;
	
    AXI_BREADY_I                         : IN   STD_LOGIC;
	
    AXI_BRESP_O                          : OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);	
	-- axi read adrs channel
	AXI_ARVALID_I                        : IN  STD_LOGIC;
	
	AXI_ARREADY_O                        : OUT STD_LOGIC;
	
	AXI_ARADDR_I                         : IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	AXI_ARPROT_I                         : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
	
    AXI_ARBURST_I                        : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);	
	-- axi read data channel
    AXI_RDATA_O                          : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	AXI_RVALID_O                         : OUT  STD_LOGIC;
	
	AXI_RREADY_I                         : IN   STD_LOGIC;
	
	AXI_RRESP_O                          : OUT   STD_LOGIC_VECTOR(1 DOWNTO 0);    
	-- axi full signals
    AXI_AWID_I                           : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
	
	AXI_AWLEN_I                          : IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);
	
	AXI_AWSIZE_I                         : IN  STD_LOGIC_VECTOR( 2 DOWNTO 0);
	
	AXI_AWLOCK_I                         : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
	
	AXI_AWCACHE_I                        : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
	
	AXI_AWUSER_I                         : IN  STD_LOGIC;
	
	AXI_AWQOS_I                          : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
	
	AXI_AWREGION_I                       : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
	
    AXI_WLAST_I                          : IN  STD_LOGIC;
	
    AXI_WUSER_I                          : IN  STD_LOGIC;
	
    AXI_BUSER_O                          : OUT STD_LOGIC;
	
    AXI_ARUSER_I                         : IN  STD_LOGIC;
	
    AXI_RUSER_O                          : OUT STD_LOGIC;
	
	AXI_RID_O                            : OUT STD_LOGIC_VECTOR( 1 DOWNTO 0);
	
	AXI_RLAST_O                          : OUT STD_LOGIC;
	
    AXI_BID_O                            : OUT STD_LOGIC_VECTOR( 1 DOWNTO 0);
	
    AXI_ARID_I                           : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
	
    AXI_ARLEN_I                          : IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);
	
    AXI_ARSIZE_I                         : IN  STD_LOGIC_VECTOR( 2 DOWNTO 0);
	
    AXI_ARLOCK_I                         : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
	
    AXI_ARCACHE_I                        : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
	
    AXI_ARQOS_I                          : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
	
    AXI_ARREGION_I                       : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
	
	-- Specifies the valid RGB data
	DATA_VALID_O 						: OUT STD_LOGIC;

    -- Filtered Output 
    DATA_R_O 							: OUT STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
	DATA_G_O 							: OUT STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
	DATA_B_O 							: OUT STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
	
	-- Data output from MASTER
    TDATA_O                       		: OUT STD_LOGIC_VECTOR(3*G_DATA_WIDTH-1 DOWNTO 0);
	
	TSTRB_O                       		: OUT STD_LOGIC_VECTOR(G_DATA_WIDTH/8-1 DOWNTO 0);
	
	TKEEP_O                       		: OUT STD_LOGIC_VECTOR(G_DATA_WIDTH/8-1 DOWNTO 0);
	
	TUSER_O                       		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	TLAST_O                       		: OUT STD_LOGIC;
    
	-- Specifies the valid control signal from MASTER
    TVALID_O                       		: OUT STD_LOGIC
	
    );
END Image_Scaler;
--=================================================================================================
-- Image_Scaler architecture body
--=================================================================================================
ARCHITECTURE rtl OF Image_Scaler IS
--=================================================================================================
-- Component declarations
--=================================================================================================
COMPONENT IMAGE_SCALER_Native 
	GENERIC(
		G_DATA_WIDTH 		 : INTEGER RANGE 8 TO 16 := 8;
		G_INPUT_FIFO_AWIDTH  : INTEGER RANGE 1 To 16 := 11;
		G_OUTPUT_FIFO_AWIDTH : INTEGER RANGE 1 To 16 := 10
		);
		PORT (                                                                                                        
			SYS_CLK_I         				: IN STD_LOGIC;
			RESETN_I        				: IN STD_LOGIC;
			IP_CLK_I						: IN STD_LOGIC;
			DATA_VALID_I   					: IN STD_LOGIC;
			DATA_R_I                       	: IN STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
			DATA_G_I                       	: IN STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
			DATA_B_I                       	: IN STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0); 
			HORZ_RES_IN_I 		            : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
			VERT_RES_IN_I     	            : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
			HORZ_RES_OUT_I	                : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
			VERT_RES_OUT_I                  : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
			SCALE_FACTOR_HORZ_I             : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			SCALE_FACTOR_VERT_I     	    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			DATA_R_O                        : OUT STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
			DATA_G_O                        : OUT STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
			DATA_B_O                        : OUT STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
			DATA_VALID_O 					: OUT STD_LOGIC
		);
		END COMPONENT;
		
COMPONENT AXI4S_INITIATOR_SCALER 
	GENERIC(
		G_DATA_WIDTH         : INTEGER RANGE 8 To 96 := 8                                                                         
		);
		PORT ( 
            RESETN_I    				: IN STD_LOGIC;
            SYS_CLK_I 					: IN STD_LOGIC;        
			DATA_I         				: IN STD_LOGIC_VECTOR(3*G_DATA_WIDTH-1 DOWNTO 0);
			DATA_VALID_I   				: IN STD_LOGIC;
            EOF_I                       : IN STD_LOGIC;			
			TDATA_O                     : OUT STD_LOGIC_VECTOR(3*G_DATA_WIDTH-1 DOWNTO 0);
            TUSER_O                     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            TSTRB_O                     : OUT STD_LOGIC_VECTOR(G_DATA_WIDTH/8-1 DOWNTO 0);
            TKEEP_O                     : OUT STD_LOGIC_VECTOR(G_DATA_WIDTH/8-1 DOWNTO 0);	
            TLAST_O                     : OUT STD_LOGIC;		
			TVALID_O                    : OUT STD_LOGIC
		);
		END COMPONENT;
			
COMPONENT AXI4S_TARGET_SCALER
	GENERIC(
		G_DATA_WIDTH         : INTEGER RANGE 8 To 96 := 8                                                                         
		);
		PORT (                                                                                                        
			TDATA_I                       		: IN STD_LOGIC_VECTOR(3*G_DATA_WIDTH-1 DOWNTO 0);
			TVALID_I                       		: IN STD_LOGIC;
            TUSER_I                             : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            TREADY_O                            : OUT STD_LOGIC;
            EOF_O                               : OUT STD_LOGIC;			
			DATA_O                           	: OUT STD_LOGIC_VECTOR(3*G_DATA_WIDTH-1 DOWNTO 0);   
			DATA_VALID_O                       	: OUT STD_LOGIC
		);
		END COMPONENT;
	
COMPONENT AXI4Lite_IF_Scaler
		PORT (
			AXI_RESETN_I                         : IN  STD_LOGIC;
			AXI_CLK_I                            : IN  STD_LOGIC;
			AXI_AWVALID_I                        : IN  STD_LOGIC;
			AXI_AWREADY_O                        : OUT STD_LOGIC;
			AXI_AWADDR_I                         : IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
			AXI_AWPROT_I                         : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
			AXI_AWBURST_I                        : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);	
			AXI_WDATA_I                          : IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
			AXI_WVALID_I                         : IN  STD_LOGIC;
			AXI_WREADY_O                         : OUT STD_LOGIC;
			AXI_WSTRB_I                          : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);	
			AXI_BVALID_O                         : OUT STD_LOGIC;
			AXI_BREADY_I                         : IN  STD_LOGIC;
			AXI_BRESP_O                          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);	
			AXI_ARVALID_I                        : IN  STD_LOGIC;
			AXI_ARREADY_O                        : OUT STD_LOGIC;
			AXI_ARADDR_I                         : IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
			AXI_ARPROT_I                         : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
			AXI_ARBURST_I                        : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);	
			AXI_RDATA_O                          : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			AXI_RVALID_O                         : OUT STD_LOGIC;
			AXI_RREADY_I                         : IN  STD_LOGIC;
			AXI_RRESP_O                          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); 
			AXI_AWID_I                           : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
			AXI_AWLEN_I                          : IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);
			AXI_AWSIZE_I                         : IN  STD_LOGIC_VECTOR( 2 DOWNTO 0);
			AXI_AWLOCK_I                         : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
			AXI_AWCACHE_I                        : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
			AXI_AWUSER_I                         : IN  STD_LOGIC;
			AXI_AWQOS_I                          : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
			AXI_AWREGION_I                       : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
			AXI_WLAST_I                          : IN  STD_LOGIC;
			AXI_WUSER_I                          : IN  STD_LOGIC;
			AXI_BUSER_O                          : OUT STD_LOGIC;
			AXI_ARUSER_I                         : IN  STD_LOGIC;
			AXI_RUSER_O                          : OUT STD_LOGIC;
			AXI_RID_O                            : OUT STD_LOGIC_VECTOR( 1 DOWNTO 0);
			AXI_RLAST_O                          : OUT STD_LOGIC;
			AXI_BID_O                            : OUT STD_LOGIC_VECTOR( 1 DOWNTO 0);
			AXI_ARID_I                           : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
			AXI_ARLEN_I                          : IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);
			AXI_ARSIZE_I                         : IN  STD_LOGIC_VECTOR( 2 DOWNTO 0);
			AXI_ARLOCK_I                         : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
			AXI_ARCACHE_I                        : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
			AXI_ARQOS_I                          : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
			AXI_ARREGION_I                       : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
			HORZ_RES_IN_O                        : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
			VERT_RES_IN_O                        : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
			HORZ_RES_OUT_O                       : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
			VERT_RES_OUT_O                       : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
			SCALE_FACTOR_HORZ_O                  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			SCALE_FACTOR_VERT_O                  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			--SCALAR_RESET_O                   	 : OUT STD_LOGIC
			);
	END COMPONENT;
--=================================================================================================
-- Synthesis Attributes
--=================================================================================================
--NA--
--=================================================================================================
-- Constant declarations
--=================================================================================================
--NA--
--=================================================================================================
-- Signal declarations
--=================================================================================================
SIGNAL s_dvalid_tar	         : STD_LOGIC;
SIGNAL s_dvalid_init         : STD_LOGIC;
SIGNAL s_eof                 : STD_LOGIC;
SIGNAL s_data_o			     : STD_LOGIC_VECTOR (3*G_DATA_WIDTH - 1 DOWNTO 0);
SIGNAL s_data_init			 : STD_LOGIC_VECTOR (3*G_DATA_WIDTH - 1 DOWNTO 0);
SIGNAL s_horz_res_in         : STD_LOGIC_VECTOR (12 DOWNTO 0);
SIGNAL s_vert_res_in         : STD_LOGIC_VECTOR (12 DOWNTO 0);
SIGNAL s_horz_res_out        : STD_LOGIC_VECTOR (12 DOWNTO 0);
SIGNAL s_vert_res_out        : STD_LOGIC_VECTOR (12 DOWNTO 0);
SIGNAL s_scale_factor_horz   : STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL s_scale_factor_vert   : STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL s_red				 : STD_LOGIC_VECTOR (G_DATA_WIDTH - 1 DOWNTO 0);
SIGNAL s_green				 : STD_LOGIC_VECTOR (G_DATA_WIDTH - 1 DOWNTO 0);
SIGNAL s_blue				 : STD_LOGIC_VECTOR (G_DATA_WIDTH - 1 DOWNTO 0);
 
SIGNAL s_red_axi			 : STD_LOGIC_VECTOR (G_DATA_WIDTH-1 DOWNTO 0);
SIGNAL s_green_axi			 : STD_LOGIC_VECTOR (G_DATA_WIDTH-1 DOWNTO 0);
SIGNAL s_blue_axi			 : STD_LOGIC_VECTOR (G_DATA_WIDTH-1 DOWNTO 0);

BEGIN

s_red   		<= s_data_o ((3*G_DATA_WIDTH - 1) DOWNTO (3*G_DATA_WIDTH - 1)- (G_DATA_WIDTH-1));
s_green 		<= s_data_o (((3*G_DATA_WIDTH - 1) - G_DATA_WIDTH) DOWNTO  G_DATA_WIDTH);
s_blue	    	<= s_data_o (G_DATA_WIDTH - 1 DOWNTO 0);

s_data_init     <= s_red_axi & s_green_axi & s_blue_axi;
--=================================================================================================
-- Top level output port assignments
--=================================================================================================
--NA--
--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--NA--	
--=================================================================================================
-- Component Instantiations
--=================================================================================================
Image_Scaler_Native_FORMAT : IF G_FORMAT = 0 AND G_CONFIG = 0 GENERATE
IMAGE_SCALER_Native_INST: IMAGE_SCALER_Native
GENERIC MAP(
	G_DATA_WIDTH 			=> G_DATA_WIDTH,
	G_INPUT_FIFO_AWIDTH		=> G_INPUT_FIFO_AWIDTH,
	G_OUTPUT_FIFO_AWIDTH	=> G_OUTPUT_FIFO_AWIDTH
)
PORT MAP(
	SYS_CLK_I				=> 		SYS_CLK_I,
	RESETN_I				=>		RESETN_I,
	DATA_VALID_I			=> 		DATA_VALID_I,
	IP_CLK_I				=>		IP_CLK_I,
	DATA_R_I           		=>		DATA_R_I,           
	DATA_G_I                =>      DATA_G_I,           
	DATA_B_I                =>      DATA_B_I,           
	HORZ_RES_IN_I 		    =>      HORZ_RES_IN_I, 		
	VERT_RES_IN_I     	    =>      VERT_RES_IN_I,     	
	HORZ_RES_OUT_I	        =>      HORZ_RES_OUT_I,	   
	VERT_RES_OUT_I          =>      VERT_RES_OUT_I,     
	SCALE_FACTOR_HORZ_I     =>      SCALE_FACTOR_HORZ_I,
	SCALE_FACTOR_VERT_I     =>      SCALE_FACTOR_VERT_I,
	DATA_R_O                =>      DATA_R_O,           
	DATA_G_O                =>      DATA_G_O,           
	DATA_B_O                =>      DATA_B_O,
	DATA_VALID_O			=>		DATA_VALID_O
);
END GENERATE;

Image_Scaler_Native_AXI4L_FORMAT : IF G_FORMAT = 0 AND G_CONFIG = 1 GENERATE
IMAGE_SCALER_Native_AXI4L_INST: IMAGE_SCALER_Native
GENERIC MAP(
	G_DATA_WIDTH 			=> G_DATA_WIDTH,
	G_INPUT_FIFO_AWIDTH		=> G_INPUT_FIFO_AWIDTH,
	G_OUTPUT_FIFO_AWIDTH	=> G_OUTPUT_FIFO_AWIDTH
)
PORT MAP(
	SYS_CLK_I				=> 		SYS_CLK_I,
	RESETN_I				=>		RESETN_I,
	DATA_VALID_I			=> 		DATA_VALID_I,
	IP_CLK_I				=>		IP_CLK_I,
	DATA_R_I           		=>		DATA_R_I,           
	DATA_G_I                =>      DATA_G_I,           
	DATA_B_I                =>      DATA_B_I,           
	HORZ_RES_IN_I 		    =>      s_horz_res_in, 		
	VERT_RES_IN_I     	    =>      s_vert_res_in,     	
	HORZ_RES_OUT_I	        =>      s_horz_res_out,	   
	VERT_RES_OUT_I          =>      s_vert_res_out,     
	SCALE_FACTOR_HORZ_I     =>      s_scale_factor_horz,
	SCALE_FACTOR_VERT_I     =>      s_scale_factor_vert,
	DATA_R_O                =>      DATA_R_O,           
	DATA_G_O                =>      DATA_G_O,           
	DATA_B_O                =>      DATA_B_O,
	DATA_VALID_O			=>		DATA_VALID_O
);
END GENERATE;

Image_Scaler_AXI4S_Native_FORMAT : IF G_FORMAT = 1 AND G_CONFIG = 0 GENERATE
IMAGE_SCALER_AXI4S_Native_INST: IMAGE_SCALER_Native
GENERIC MAP(
	G_DATA_WIDTH 			=> G_DATA_WIDTH,
	G_INPUT_FIFO_AWIDTH		=> G_INPUT_FIFO_AWIDTH,
	G_OUTPUT_FIFO_AWIDTH	=> G_OUTPUT_FIFO_AWIDTH
)
PORT MAP(
	SYS_CLK_I				=> 		SYS_CLK_I,
	RESETN_I				=>		RESETN_I,
	DATA_VALID_I			=> 		s_dvalid_tar,
	IP_CLK_I				=>		IP_CLK_I,
	DATA_R_I           		=>		s_red,           
	DATA_G_I                =>      s_green,           
	DATA_B_I                =>      s_blue,           
	HORZ_RES_IN_I 		    =>      HORZ_RES_IN_I, 		
	VERT_RES_IN_I     	    =>      VERT_RES_IN_I,     	
	HORZ_RES_OUT_I	        =>      HORZ_RES_OUT_I,	   
	VERT_RES_OUT_I          =>      VERT_RES_OUT_I,     
	SCALE_FACTOR_HORZ_I     =>      SCALE_FACTOR_HORZ_I,
	SCALE_FACTOR_VERT_I     =>      SCALE_FACTOR_VERT_I,
	DATA_R_O                =>      s_red_axi,           
	DATA_G_O                =>      s_green_axi,           
	DATA_B_O                =>      s_blue_axi,
	DATA_VALID_O			=>		s_dvalid_init
);
END GENERATE;

Image_Scaler_AXI4S_AXI4L_FORMAT : IF G_FORMAT = 1 AND G_CONFIG = 1 GENERATE
IMAGE_SCALER_AXI4S_AXI4L_INST: IMAGE_SCALER_Native
GENERIC MAP(
	G_DATA_WIDTH 			=> G_DATA_WIDTH,
	G_INPUT_FIFO_AWIDTH		=> G_INPUT_FIFO_AWIDTH,
	G_OUTPUT_FIFO_AWIDTH	=> G_OUTPUT_FIFO_AWIDTH
)
PORT MAP(
	SYS_CLK_I				=> 		SYS_CLK_I,
	RESETN_I				=>		RESETN_I,
	DATA_VALID_I			=> 		s_dvalid_tar,
	IP_CLK_I				=>		IP_CLK_I,
	DATA_R_I           		=>		s_red,           
	DATA_G_I                =>      s_green,           
	DATA_B_I                =>      s_blue,           
	HORZ_RES_IN_I 		    =>      s_horz_res_in, 		
	VERT_RES_IN_I     	    =>      s_vert_res_in,     	
	HORZ_RES_OUT_I	        =>      s_horz_res_out,	   
	VERT_RES_OUT_I          =>      s_vert_res_out,     
	SCALE_FACTOR_HORZ_I     =>      s_scale_factor_horz,
	SCALE_FACTOR_VERT_I     =>      s_scale_factor_vert,
	DATA_R_O                =>      s_red_axi,           
	DATA_G_O                =>      s_green_axi,           
	DATA_B_O                =>      s_blue_axi,
	DATA_VALID_O			=>		s_dvalid_init
);
END GENERATE;

Scaler_tar_FORMAT : IF G_FORMAT = 1 GENERATE
IMAGE_SCALER_AXI4S_TAR_INST: AXI4S_TARGET_SCALER
GENERIC MAP(
	G_DATA_WIDTH   => G_DATA_WIDTH
)
PORT MAP(
	TVALID_I			=> 		TVALID_I,
	TDATA_I				=> 		TDATA_I,
	TUSER_I             =>      TUSER_I,
	TREADY_O            =>      TREADY_O,
	EOF_O               =>      s_eof,
	DATA_VALID_O		=>      s_dvalid_tar,
	DATA_O 				=>		s_data_o
);
END GENERATE;

Image_Scaler_axi4lite_FORMAT : IF G_CONFIG = 1 GENERATE
Image_Scaler_AXI_LITE_INST: AXI4Lite_IF_Scaler
PORT MAP(
	AXI_RESETN_I  	   => AXI_RESETN_I,  
	AXI_CLK_I          => AXI_CLK_I,     
	AXI_AWVALID_I      => AXI_AWVALID_I, 
	AXI_AWREADY_O      => AXI_AWREADY_O,
	AXI_AWADDR_I       => AXI_AWADDR_I,  
	AXI_AWPROT_I       => AXI_AWPROT_I,  
	AXI_AWBURST_I      => AXI_AWBURST_I, 
	AXI_WDATA_I        => AXI_WDATA_I,   
	AXI_WVALID_I       => AXI_WVALID_I,  
	AXI_WREADY_O       => AXI_WREADY_O,  
	AXI_WSTRB_I        => AXI_WSTRB_I,   
	AXI_BVALID_O       => AXI_BVALID_O,  
	AXI_BREADY_I       => AXI_BREADY_I,  
	AXI_BRESP_O        => AXI_BRESP_O,   
	AXI_ARVALID_I      => AXI_ARVALID_I, 
	AXI_ARREADY_O      => AXI_ARREADY_O, 
	AXI_ARADDR_I       => AXI_ARADDR_I,  
	AXI_ARPROT_I       => AXI_ARPROT_I,  
	AXI_ARBURST_I      => AXI_ARBURST_I, 
	AXI_RDATA_O        => AXI_RDATA_O,   
	AXI_RVALID_O       => AXI_RVALID_O,  
	AXI_RREADY_I       => AXI_RREADY_I,  
	AXI_RRESP_O        => AXI_RRESP_O,   
	AXI_AWID_I         => AXI_AWID_I,    
	AXI_AWLEN_I        => AXI_AWLEN_I,   
	AXI_AWSIZE_I       => AXI_AWSIZE_I,  
	AXI_AWLOCK_I       => AXI_AWLOCK_I,  
	AXI_AWCACHE_I      => AXI_AWCACHE_I, 
	AXI_AWUSER_I       => AXI_AWUSER_I,  
	AXI_AWQOS_I        => AXI_AWQOS_I,   
	AXI_AWREGION_I     => AXI_AWREGION_I,
	AXI_WLAST_I        => AXI_WLAST_I,   
	AXI_WUSER_I        => AXI_WUSER_I,   
	AXI_BUSER_O        => AXI_BUSER_O,   
	AXI_ARUSER_I       => AXI_ARUSER_I,  
	AXI_RUSER_O        => AXI_RUSER_O,   
	AXI_RID_O          => AXI_RID_O,     
	AXI_RLAST_O        => AXI_RLAST_O,   
	AXI_BID_O          => AXI_BID_O,     
	AXI_ARID_I         => AXI_ARID_I,    
	AXI_ARLEN_I        => AXI_ARLEN_I,   
	AXI_ARSIZE_I       => AXI_ARSIZE_I,  
	AXI_ARLOCK_I       => AXI_ARLOCK_I,  
	AXI_ARCACHE_I      => AXI_ARCACHE_I, 
	AXI_ARQOS_I        => AXI_ARQOS_I,   
	AXI_ARREGION_I     => AXI_ARREGION_I,
	HORZ_RES_IN_O      => s_horz_res_in,     
	VERT_RES_IN_O      => s_vert_res_in,
	HORZ_RES_OUT_O     => s_horz_res_out,
	VERT_RES_OUT_O     => s_vert_res_out,
	SCALE_FACTOR_HORZ_O=> s_scale_factor_horz,
	SCALE_FACTOR_VERT_O=> s_scale_factor_vert
	);
END GENERATE;
    
ScalSCALE_FACTOR_VERT_Oer_init_FORMAT : IF G_FORMAT = 1 GENERATE
IMAGE_SCALER_AXI4_INIT_INST: AXI4S_INITIATOR_SCALER
GENERIC MAP(
	G_DATA_WIDTH   => G_DATA_WIDTH
)
PORT MAP(
    SYS_CLK_I                                                                       =>  SYS_CLK_I,
	RESETN_I																		=>  RESETN_I,
	DATA_VALID_I																	=> 	s_dvalid_init,
	DATA_I                                                                  		=>	s_data_init,
	EOF_I                                                                           =>  s_eof,
	TUSER_O                                                                         =>  TUSER_O,
	TLAST_O                                                                         =>  TLAST_O,
	TSTRB_O                                                                         =>  TSTRB_O,
	TKEEP_O                                                                         =>  TKEEP_O,
	TVALID_O																		=>  TVALID_O,
	TDATA_O																			=>	TDATA_O
);
END GENERATE;
END rtl;
-- ********************************************************************/ 
-- Microchip Corporation Proprietary and Confidential 
-- Copyright 2022 Microchip Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE MICROCHIP LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
-- Revision Information:	2.2
-- Date:				    7/13/2020 
-- Description:  Bilinear Image & Video Scaler
-- Limitations:
-- 		4K resolution is 3840x2160 or 4096x2160
-- 		Image width  (input and output) [8,4096]  2^12 (12-bit pixel index)
-- 		Image height (input and output) [8,4096]  2^12 (12-bit pixel index)
-- 		Scale factor (x and y)          [1/64,64] 2^6 * 2^10 (10-bit shift for down scale factors)
-- 		Pixel values are fixed at 8, 10, 12, 14 or 16-bit (only 8-bit is tested)
--		Output Image Dimensions must be a multiple of 4
-- 		PolarFire Math Block supports up to 17x17 unsigned multiplier
-- Recommendations:
-- 		Bilinear scaling works best when scale factors are between [0.5,2.0]
-- 		Crop original image to the output width:height before scaling
-- Notation:
-- 		XYZ13LS indicates a variable holding 13-bit left shifted value of XYZ
-- Update History:
--		09/19 - Initial release includes BILINEAR_INTERP				
-- 		10/02 - Planned support for variable pixel bit width [8 10 12 16], min & max saturation of output
-- 		10/14 - Passing RGB image, implementing feedback control signal between SCALE_FACTOR_GEN, BILINEAR_INTERP 
--		10/15 - Separated calculations that are common to all color pixels in to SCALE_FACTOR_GEN
--		10/17 - Downscaling 640x480 to 320x240 RTL simulation passes
--      10/30 - Updated design to receive and process R, G & B pixels concurrently
--		11/22 - Updated design to store and transmit entire row of output image
--		03/02 - Support wider scaling range [1/64,64]
--      03/02 - Switch to using input ports in place of generics for image res, scale factors
--		03/05 - Resize resolution input ports to 16 bits
--		03/11 - Revert 03/05 change - input ports are back to 13 bits
--      03/19 - Input and Output FIFO size available as top level generics
--		03/20 - Reduce Input RAM usage with shift register
--		03/21 - X3_ENGINE can compute up to 3 output pixels belonging to the same row
--		04/11 - Parameterized design using if loop, generate
--      04/27 - Integrated VIDEO_FIFO_INTF to generate 4 pixels of data for store & forward VIDEO_FIFO
--		05/11 - 3 Instances of X3_ENGINE to support parallel computation of up to 3 rows
--		05/19 - Upscaler 2X RTL Simulation passes
--		06/23 - Reduced bit precision of scale factor to reduce DSP count
--		07/31 - Switch to time multiplexing architecture
-- SVN Revision Information:
-- SVN $Revision: $
-- SVN $Date: $
-- Resolved SARs
-- SAR      Date     Who   Description
-- *********************************************************************/ 

--=================================================================================================
-- Libraries
--=================================================================================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
--=================================================================================================
-- IMAGE_SCALER_Native entity declaration
--=================================================================================================
ENTITY IMAGE_SCALER_Native IS
GENERIC(
-- Generic List
	-- Specifies the data width !! Only 8-bit support is tested !!
	G_DATA_WIDTH         : INTEGER RANGE 8 To 16 := 8;
	
	-- Specified size of FIFOs for storing one row of input and output image
	G_INPUT_FIFO_AWIDTH  : INTEGER RANGE 1 To 16 := 11;
	G_OUTPUT_FIFO_AWIDTH : INTEGER RANGE 1 To 16 := 10
);
PORT (
-- Port List
    -- System reset
    RESETN_I                           : IN STD_LOGIC;
    
    -- System / Pixel clock
    SYS_CLK_I                          : IN STD_LOGIC;
	
	-- IP clock ~200MHz
	IP_CLK_I						   : IN STD_LOGIC;
   
    -- Specifies the input data is valid or not
    DATA_VALID_I                       : IN STD_LOGIC;
    
    -- Data input
    DATA_R_I                       	   : IN STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
    DATA_G_I                       	   : IN STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
    DATA_B_I                       	   : IN STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
	
    HORZ_RES_IN_I 		               : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
	VERT_RES_IN_I     	               : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
	HORZ_RES_OUT_I	                   : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
	VERT_RES_OUT_I                     : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    
    -- Scale factors
	SCALE_FACTOR_HORZ_I                : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	SCALE_FACTOR_VERT_I     	       : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    
	-- Specifies the valid control signal for scaled data
    DATA_VALID_O                       : OUT STD_LOGIC;
	
	-- Scaled data output
    DATA_R_O                           : OUT STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
    DATA_G_O                           : OUT STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0);
    DATA_B_O                           : OUT STD_LOGIC_VECTOR(G_DATA_WIDTH-1 DOWNTO 0)
);
END IMAGE_SCALER_Native; 
`protect begin_protected
`protect version=1
`protect author="author-a", author_info="author-a-details"
`protect encrypt_agent="encryptP1735.pl", encrypt_agent_info="Synplify encryption scripts"

`protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=256)
`protect key_block
kHWR+9PM5PtnOdyfYfS50q8wTczqEBVuL7FwpgheqAP/lXMDFgxXRGFPOljUNjSD07LPohdKirpi
06KlW8oIfe/ruPp9YhdOMo14C/Jv83mNB6aou4dHBdbw09vaJYM9DR8O0W7eqYXjwPGHtFFrsnuo
sjfWxdGD+IQ6ktVY7/LQ1TAFOkAAlVkiNet0F6T/Ta8rKSE3dky4jLYdmeBfyPe4V+oSPPnvQj+s
eXAVVH85jXM/5TCr+Tvh9fKN5o2KsvRAdAo52xhvtiuaC1+2jPW58ZayyOG6i3aHq96zx+D/DgO8
n2mmoRWWfOdt3eatz6sDs5ws02qfFjzCRH3pBQ==

`protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=128)
`protect key_block
DUuQrZO9lMkkyzGMSexHZE07yIY+/vt0ikaqzzc1ruzx9qvUrg+6jyIXQpyvHLOnptKeBiIHTe9V
JdJfzE1Qp1rJnOW4baa4ablG04RcgrRZ7bE451vqEoQq3d71LSLiKBJs8kPnMeh0Tyu4CGwfNtVe
ZFra4pZ3Fu7YLth+HCA=

`protect key_keyowner="Microsemi Corporation", key_keyname="MSC-IP-KEY-RSA", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=960)
`protect key_block
gqpWLYkZCVXeEV+vZLYPkQrAhzHrmDlyQ01+v/nYQLOCuHflplKxLnLV2D+yMQS6sqBGN1h95B/O
b7HaK+IxiwObjB882r+623j+tJLyUBAiH/L/ZPJAOkFPHacId6lJ+yhCzbZaah2kU78Xm1ApLftn
kOuPuuZrmA92p6ak3z2bT2lqJePZMIYJpEHUw4hCrXgPfEX1qfLiBJdFTcrzFJZsI7bCv1r5PxuL
IazqJlfua+uE8BpiycwpQQ2j0/8Qvnr3xE/Ko3Kd7Xd2AXZd9i+tLxZZaQ6WraAnlHtJ+vN41QYn
4lIVXfBwACJwjtxKmk1NsQzv69fE9qWE0Le5kj4J2VMx/LXS6Ma7XPSpLpZG3NGl50DYu7NuF7Wv
wuxFrst9AX3YtdGU1c9A1BegleqBtL6+vXeDcaWEBC/aFbb7NNTQ7B8AGgz6Bi0B1OdWLgGIVdy9
PUoVMReS0m7/y9FHN8mGrLzP5TUnsZ5ulNph0U1AuIH0rfY1wQgBo9RoXt/uBcdald76dXgCJlCJ
iKHqmjVR2Sy+tDpjNjMUfO7smlKszvtP3Q35fqODmm1Vhfszqf541VNDURUuJrKKhHx9+x5mLiMu
3aPjdazdcSL6KK1tALNDqBPKR7sMd2GIE2aAdeXABv8Npf1wp22n2IqJpN0E24xf5B9XaE6HKc1z
aenrm9PJcL4Xr64z01tHUGG3iUv2WReUVm935X0KbjUg4gjsIuEIfkv8meDdc0mP5mX54+fBfNJ6
fTCuA7MYx9FD4Csbblq359RfgAcC9KklhNMN5l0UZAalIq0WHucd5pWXSDcTgz20UXvG6dapZX0p
j5VKh8cDDuyn8d2nog4hzvPBVxxjs625WchjFRqzhHhMb6OqwvGTXdhhrFgrx+aa2uOCneVBY3su
TZXYRKI3V6PcyqBsGWNYfB05N+J2Hvh9ADyUwCYsTyZtu96aRoFr+21WpChWcmUDjhddSasnBLD/
BL7v0vmiObSk2urwUR7q5HGGEITiAn+jH1M9gohJed6T+l0dw9s9/E9yzhqQhuP9hCWAP29AHQW5
srO3uP1u5KrEPDHdukypPjy3URG2ecF1FDMYy4X5AEK2ssS8iBz46mDO8CK9sdp6uBhCQXmXiqkx
WYBssUWxmBO98QTDR9OMbaqjgrsA8l7rekBEaU7+MFQkFOVu2xF0jXHwk7F0UpTGC1LpSG9FpTxX
VQJOUL1BsYLpqPCt3Rmf3Ikq3/TKd2h0zoIaNJXC7EpUE71ylBT1YjyZGOzidYod

`protect data_keyowner="ip-vendor-a", data_keyname="fpga-ip", data_method="aes128-cbc"
`protect encoding=(enctype="base64", line_length=76, bytes=78672)
`protect data_block
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
YJ4a5AefZ31mCGpA

`protect end_protected

-- ********************************************************************/ 
-- Microchip Corporation Proprietary and Confidential 
-- Copyright 2022 Microchip Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE MICROCHIP LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
-- Revision Information:	1.0
-- Date:				    01/22/2022 
-- Description:  AXI4 Streaming Template for synchronous operation
-- This template assume entire system and AXI4 Streaming Bus use the same clock
-- Cross-clock domain handling or back pressure features are NOT supported
--	** AXI4 Streaming Interface **
--	ACLK		All signals are synchronous to this clock
--	ARESETN		Asynchronous active low reset
--	TDATA		Frame data is transmitted on this bus
--	TVALID		Indicates that the source is ready to send data
--	TREADY		Indicates that the sink is ready to accept data
--	TLAST		Indicates End-of-Frame
--	TID 		Needed for switch
--	TDEST 		Needed for switch
-- 	TUSER		Reserved for SOF etc
--
-- 	** AXI4 Lite Interface (Configuration) **
--	** Not Defined ** 
--	
--	Questions / Open Action Items:
--	AXI4 Lite interface needs to be defined for control signals
--
-- Limitations:
--  TID, TDEST, TKEEP, TSTRB not supported 		
--
-- Recommendations:
-- 		
-- Update History:
--		12/07 - Interface defined
--		12/10 - Initial version
--		01/04 - Update for sync interface
--      01/22 - Update for TUSER support				
-- SVN Revision Information:
-- SVN $Revision: $
-- SVN $Date: $
-- Resolved SARs
-- SAR      Date     Who   Description
-- *********************************************************************/ 
--=================================================================================================
-- Libraries
--=================================================================================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
--=================================================================================================
-- AXI4S_MSTR entity declaration
--=================================================================================================
-- Takes native video interface data and converts to AXI4S
ENTITY AXI4S_INITIATOR_SCALER IS
GENERIC(
-- Generic List
	-- Specifies the R, G, B pixel data width
	G_DATA_WIDTH         : INTEGER RANGE 8 To 96 := 8
);
PORT (
-- Port List
    -- System reset
    RESETN_I 							: IN STD_LOGIC;

    -- System clock
    SYS_CLK_I 							: IN STD_LOGIC;  
	-- R, G, B Data Input
    DATA_I                           	: IN STD_LOGIC_VECTOR(3*G_DATA_WIDTH-1 DOWNTO 0);
   
    -- Specifies the input data is valid or not
    DATA_VALID_I                       	: IN STD_LOGIC;
	
	EOF_I                               : IN STD_LOGIC;
	
	TUSER_O                             : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	TSTRB_O                       		: OUT STD_LOGIC_VECTOR(G_DATA_WIDTH/8-1 DOWNTO 0);
	
	TKEEP_O                       		: OUT STD_LOGIC_VECTOR(G_DATA_WIDTH/8-1 DOWNTO 0);
    
    -- Data input
    TDATA_O                       		: OUT STD_LOGIC_VECTOR(3*G_DATA_WIDTH-1 DOWNTO 0);
	
	TLAST_O                       		: OUT STD_LOGIC;
    
	-- Specifies the valid control signal
    TVALID_O                       		: OUT STD_LOGIC
    
);
END AXI4S_INITIATOR_SCALER;
--=================================================================================================
-- Architecture body
--=================================================================================================
ARCHITECTURE AXI4S_INITIATOR_SCALER OF AXI4S_INITIATOR_SCALER IS
--=================================================================================================
-- Component declarations
--=================================================================================================
--NA--
--=================================================================================================
-- Signal declarations
--=================================================================================================
SIGNAL 	s_tvalid_fe             : STD_LOGIC;
SIGNAL 	s_data_valid_dly1       : STD_LOGIC;
SIGNAL 	s_eof_dly1              : STD_LOGIC;
SIGNAL  s_data_dly1             : STD_LOGIC_VECTOR(3*G_DATA_WIDTH-1 DOWNTO 0);	
BEGIN
--=================================================================================================
-- Top level port assignments
--=================================================================================================
TDATA_O				<= s_data_dly1;
TVALID_O			<= s_data_valid_dly1;
TLAST_O             <= s_tvalid_fe;
TUSER_O(0)          <= s_eof_dly1;
TUSER_O(3 DOWNTO 1) <= (OTHERS => '0');
TSTRB_O             <= (OTHERS => '1');
TKEEP_O             <= (OTHERS => '1');
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
s_tvalid_fe         <= s_data_valid_dly1 AND NOT(DATA_VALID_I);
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : SIGNAL_DELAY
-- Description: Process to delay signal and find rising edge
--------------------------------------------------------------------------
SIGNAL_DELAY :
PROCESS(SYS_CLK_I, RESETN_I)
 BEGIN
   IF (RESETN_I = '0') THEN
      s_eof_dly1         <= '0';
      s_data_valid_dly1  <= '0';
      s_data_dly1        <= (OTHERS => '0');
   ELSIF rising_edge(SYS_CLK_I) THEN
      s_data_dly1        <= DATA_I;
      s_data_valid_dly1  <= DATA_VALID_I;
      s_eof_dly1         <= EOF_I;
   END IF;
 END PROCESS;
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
END AXI4S_INITIATOR_SCALER;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
--=================================================================================================
-- AXI4S_SLAVE entity declaration
--=================================================================================================
-- Takes AXI4S and converts to native video interface data
ENTITY AXI4S_TARGET_SCALER IS
GENERIC(
-- Generic List
	-- Specifies the R, G, B pixel data width
	G_DATA_WIDTH         : INTEGER RANGE 8 To 96 := 8
);
PORT (
-- Port List 
    -- Data input
    TDATA_I                       		: IN STD_LOGIC_VECTOR(3*G_DATA_WIDTH-1 DOWNTO 0);
    
	-- Specifies the valid control signal
    TVALID_I                       		: IN STD_LOGIC;
	
	TUSER_I                             : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	TREADY_O                            : OUT STD_LOGIC;
	
	EOF_O                               : OUT STD_LOGIC;
    
	-- R, G, B Data Output
	DATA_O                           	: OUT STD_LOGIC_VECTOR(3*G_DATA_WIDTH-1 DOWNTO 0);
   
    -- Specifies the output data is valid or not
    DATA_VALID_O                       	: OUT STD_LOGIC    
	
);
END AXI4S_TARGET_SCALER;
--=================================================================================================
-- Architecture body
--=================================================================================================
ARCHITECTURE AXI4S_TARGET_SCALER OF AXI4S_TARGET_SCALER IS
--=================================================================================================
-- Component declarations
--=================================================================================================
--NA--
--=================================================================================================
-- Signal declarations
--=================================================================================================
--NA--	
BEGIN
--=================================================================================================
-- Top level port assignments
--=================================================================================================
DATA_O				<= TDATA_I;
DATA_VALID_O		<= TVALID_I;
EOF_O				<= TUSER_I(0);
TREADY_O			<= '1';
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
END AXI4S_TARGET_SCALER;

--=================================================================================================
-- File Name                           : AXI4Lite_IF_Scaler.vhd
-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
-- COPYRIGHT 2022 BY MICROCHIP
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROCHIP
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROCHIP FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--=================================================================================================
--=================================================================================================
-- Libraries
--=================================================================================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--=================================================================================================
-- AXI4Lite_IF_Scaler entity declaration
--=================================================================================================
ENTITY AXI4Lite_IF_Scaler IS
PORT (
-- Port list
    -- AXI4 reset
    AXI_RESETN_I                         : IN  STD_LOGIC;
    -- axi clk
    AXI_CLK_I                            : IN  STD_LOGIC;
    
	-- axi write adrs channel
	AXI_AWVALID_I                        : IN   STD_LOGIC;
	
	AXI_AWREADY_O                        : OUT  STD_LOGIC;
	
	AXI_AWADDR_I                         : IN   STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	AXI_AWPROT_I                         : IN   STD_LOGIC_VECTOR(2 DOWNTO 0);
	
	AXI_AWBURST_I                        : IN   STD_LOGIC_VECTOR(1 DOWNTO 0);	
	-- axi write data channel
	AXI_WDATA_I                          : IN   STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	AXI_WVALID_I                         : IN   STD_LOGIC;
	
	AXI_WREADY_O                         : OUT  STD_LOGIC;
	
	AXI_WSTRB_I                          : IN   STD_LOGIC_VECTOR(3 DOWNTO 0);	
    -- axi write response channel
    AXI_BVALID_O                         : OUT  STD_LOGIC;
	
    AXI_BREADY_I                         : IN   STD_LOGIC;
	
    AXI_BRESP_O                          : OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);	
	-- axi read adrs channel
	AXI_ARVALID_I                        : IN  STD_LOGIC;
	
	AXI_ARREADY_O                        : OUT STD_LOGIC;
	
	AXI_ARADDR_I                         : IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	AXI_ARPROT_I                         : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
	
    AXI_ARBURST_I                        : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);	
	-- axi read data channel
    AXI_RDATA_O                          : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	AXI_RVALID_O                         : OUT  STD_LOGIC;
	
	AXI_RREADY_I                         : IN   STD_LOGIC;
	
	AXI_RRESP_O                          : OUT   STD_LOGIC_VECTOR(1 DOWNTO 0);    
	-- axi full signals
    AXI_AWID_I                           : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
	
	AXI_AWLEN_I                          : IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);
	
	AXI_AWSIZE_I                         : IN  STD_LOGIC_VECTOR( 2 DOWNTO 0);
	
	AXI_AWLOCK_I                         : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
	
	AXI_AWCACHE_I                        : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
	
	AXI_AWUSER_I                         : IN  STD_LOGIC;
	
	AXI_AWQOS_I                          : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
	
	AXI_AWREGION_I                       : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
	
    AXI_WLAST_I                          : IN  STD_LOGIC;
	
    AXI_WUSER_I                          : IN  STD_LOGIC;
	
    AXI_BUSER_O                          : OUT STD_LOGIC;
	
    AXI_ARUSER_I                         : IN  STD_LOGIC;
	
    AXI_RUSER_O                          : OUT STD_LOGIC;
	
	AXI_RID_O                            : OUT STD_LOGIC_VECTOR( 1 DOWNTO 0);
	
	AXI_RLAST_O                          : OUT STD_LOGIC;
	
    AXI_BID_O                            : OUT STD_LOGIC_VECTOR( 1 DOWNTO 0);
	
    AXI_ARID_I                           : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
	
    AXI_ARLEN_I                          : IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);
	
    AXI_ARSIZE_I                         : IN  STD_LOGIC_VECTOR( 2 DOWNTO 0);
	
    AXI_ARLOCK_I                         : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
	
    AXI_ARCACHE_I                        : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
	
    AXI_ARQOS_I                          : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
	
    AXI_ARREGION_I                       : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
	
    HORZ_RES_IN_O                        : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
	                                                             
	VERT_RES_IN_O                        : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
	                                                             
	HORZ_RES_OUT_O                       : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
	                                                             
	VERT_RES_OUT_O                       : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
	
	SCALE_FACTOR_HORZ_O                  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	SCALE_FACTOR_VERT_O                  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	
	--SCALAR_RESET_O                   	 : OUT STD_LOGIC
	
);
END AXI4Lite_IF_Scaler;
--=================================================================================================
-- AXI4Lite_IF_Scaler architecture body
--=================================================================================================
ARCHITECTURE AXI4Lite_IF_Scaler OF AXI4Lite_IF_Scaler IS
--=================================================================================================
-- Component declarations
--=================================================================================================
COMPONENT AXI4LITE_SUB_BLK_Scaler IS
PORT (
    RESETN_I                         : IN  STD_LOGIC;
    CLK_I                            : IN  STD_LOGIC;
    AWVALID_I                        : IN  STD_LOGIC;
    AWREADY_O                        : OUT STD_LOGIC;
    AWADDR_I                         : IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
    AWPROT_I                         : IN  STD_LOGIC_VECTOR(2 DOWNTO 0 );
	AWBURST_I                        : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
	AWSIZE_I                         : IN  STD_LOGIC_VECTOR( 2 DOWNTO 0);
	AWID_I                           : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
	AWLEN_I                          : IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);
    WDATA_I                          : IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
    WVALID_I                         : IN  STD_LOGIC;
    WREADY_O                         : OUT STD_LOGIC;
    WSTRB_I                          : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
    BVALID_O                         : OUT STD_LOGIC;
    BREADY_I                         : IN  STD_LOGIC;
    BRESP_O                          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	BID_O                            : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	AWREGION_I                       : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
    ARVALID_I                        : IN  STD_LOGIC;
    ARREADY_O                        : OUT STD_LOGIC;
    ARADDR_I                         : IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
    ARPROT_I                         : IN  STD_LOGIC_VECTOR(2 DOWNTO 0 );
	ARBURST_I                        : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
    ARLOCK_I                         : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
    ARCACHE_I                        : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
    ARQOS_I                          : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
	ARSIZE_I                         : IN  STD_LOGIC_VECTOR( 2 DOWNTO 0);
	ARLEN_I                          : IN  STD_LOGIC_VECTOR( 7 DOWNTO 0);
	ARID_I                           : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
    RDATA_O                          : OUT  STD_LOGIC_VECTOR (31 DOWNTO 0);
    RVALID_O                         : OUT  STD_LOGIC;
    RREADY_I                         : IN   STD_LOGIC;
    RRESP_O                          : OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
	RID_O                            : OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
	RLAST_O                          : OUT  STD_LOGIC;
	BUSER_O                          : OUT  STD_LOGIC;
	RUSER_O                          : OUT  STD_LOGIC;
	ARUSER_I                         : IN   STD_LOGIC;
	ARREGION_I                       : IN   STD_LOGIC_VECTOR( 3 DOWNTO 0);
	AWUSER_I                         : IN   STD_LOGIC;
	AWQOS_I                          : IN   STD_LOGIC_VECTOR( 3 DOWNTO 0);
	AWLOCK_I                         : IN   STD_LOGIC_VECTOR( 1 DOWNTO 0);
	AWCACHE_I                        : IN   STD_LOGIC_VECTOR( 3 DOWNTO 0);
    WUSER_I                          : IN   STD_LOGIC;
	WLAST_I                          : IN   STD_LOGIC;
    USER_DATA_VALID_O                : OUT  STD_LOGIC;
    USER_AWADDR_O                    : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
    USER_WDATA_O                     : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
    USER_ARADDR_O                    : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);    
    USER_RDATA_I                     : IN   STD_LOGIC_VECTOR(31 DOWNTO 0)    
);
END COMPONENT;

COMPONENT AXI4LITE_USR_BLK_Scaler IS
PORT (
    RESETN_I                         : IN  STD_LOGIC;
    CLK_I                            : IN  STD_LOGIC;
    USER_DATA_VALID_I                : IN  STD_LOGIC;
    USER_AWADDR_I                    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
    USER_WDATA_I                     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);    
    USER_ARADDR_I                    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);    
    USER_RDATA_O                     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    --FRAME_TCOUNT_O                   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	  HORZ_RES_IN_O                    : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
    VERT_RES_IN_O                    : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
    HORZ_RES_OUT_O                   : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
    VERT_RES_OUT_O                   : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
    SCALE_FACTOR_HORZ_O              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    SCALE_FACTOR_VERT_O              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	--SCALAR_RESET_O                   : OUT STD_LOGIC
);
END COMPONENT;
--=================================================================================================
-- Synthesis Attributes
--=================================================================================================
--NA--
--=================================================================================================
-- Signal declarations
--=================================================================================================
--ADC Register Addresses
SIGNAL s_frame_end_fe                  : STD_LOGIC;
SIGNAL s_frame_end_dly1                : STD_LOGIC;
SIGNAL s_frame_end_dly2                : STD_LOGIC;
-- user logic ports
SIGNAL s_user_data_valid               : STD_LOGIC;
SIGNAL s_user_awaddr                   : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL s_user_wdata                    : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL s_user_araddr                   : STD_LOGIC_VECTOR(31 DOWNTO 0);    
SIGNAL s_user_rdata                    : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
--=================================================================================================
-- Top level output port assignments
--=================================================================================================
--NA--
--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--NA--             
--=================================================================================================
-- Component Instantiations
--=================================================================================================
AXI4LITE_SUB_BLK_Scaler_INST: AXI4LITE_SUB_BLK_Scaler
PORT MAP(
    RESETN_I                         =>    AXI_RESETN_I,                  
    CLK_I                            =>    AXI_CLK_I,    
    AWVALID_I                        =>    AXI_AWVALID_I,
    AWREADY_O                        =>    AXI_AWREADY_O,
    AWADDR_I                         =>    AXI_AWADDR_I,
    AWPROT_I                         =>    AXI_AWPROT_I,
	AWBURST_I                        =>    AXI_AWBURST_I,
	AWSIZE_I                         =>    AXI_AWSIZE_I,                
    WDATA_I                          =>    AXI_WDATA_I,
    WVALID_I                         =>    AXI_WVALID_I,
    WREADY_O                         =>    AXI_WREADY_O,
    WSTRB_I                          =>    AXI_WSTRB_I,            
    BVALID_O                         =>    AXI_BVALID_O,
    BREADY_I                         =>    AXI_BREADY_I,
    BRESP_O                          =>    AXI_BRESP_O,              
    RDATA_O                          =>    AXI_RDATA_O,
    RVALID_O                         =>    AXI_RVALID_O,
    RREADY_I                         =>    AXI_RREADY_I,
    RRESP_O                          =>    AXI_RRESP_O,
    AWREGION_I                       =>    AXI_AWREGION_I,	
    ARVALID_I                        =>    AXI_ARVALID_I,
    ARREADY_O                        =>    AXI_ARREADY_O,
    ARADDR_I                         =>    AXI_ARADDR_I,
    ARPROT_I                         =>    AXI_ARPROT_I,
	ARBURST_I                        =>    AXI_ARBURST_I,
	ARREGION_I                       =>    AXI_ARREGION_I,
	ARLOCK_I                         =>    AXI_ARLOCK_I,  
	ARCACHE_I                        =>    AXI_ARCACHE_I,
    ARQOS_I                          =>    AXI_ARQOS_I,
    ARSIZE_I                         =>    AXI_ARSIZE_I,
    ARLEN_I                          =>    AXI_ARLEN_I,
	ARID_I                           =>    AXI_ARID_I,
    AWUSER_I                         =>    AXI_AWUSER_I,
    AWQOS_I                          =>    AXI_AWQOS_I,
    AWLOCK_I                         =>    AXI_AWLOCK_I,  
    AWCACHE_I                        =>    AXI_AWCACHE_I,	
    WUSER_I                          =>    AXI_WUSER_I,
    WLAST_I                          =>    AXI_WLAST_I,
    AWID_I                           =>    AXI_AWID_I, 
    AWLEN_I                          =>    AXI_AWLEN_I,
    RLAST_O                          =>    AXI_RLAST_O,
    BUSER_O                          =>    AXI_BUSER_O,  
    RUSER_O                          =>    AXI_RUSER_O,  
	ARUSER_I                         =>    AXI_ARUSER_I,                 
    USER_DATA_VALID_O                =>    s_user_data_valid,
    USER_AWADDR_O                    =>    s_user_awaddr,
    USER_WDATA_O                     =>    s_user_wdata,     
    USER_ARADDR_O                    =>    s_user_araddr,
    USER_RDATA_I                     =>    s_user_rdata    
);

AXI4LITE_USR_BLK_Scaler_INST: AXI4LITE_USR_BLK_Scaler
PORT MAP(
    RESETN_I                           =>    AXI_RESETN_I,                                    
    CLK_I                              =>    AXI_CLK_I,       
    USER_DATA_VALID_I                  =>    s_user_data_valid,          
    USER_AWADDR_I                      =>    s_user_awaddr,               
    USER_WDATA_I                       =>    s_user_wdata,                  
    USER_ARADDR_I                      =>    s_user_araddr,                   
    USER_RDATA_O                       =>    s_user_rdata,    
    HORZ_RES_IN_O                      =>    HORZ_RES_IN_O,
    VERT_RES_IN_O                      =>    VERT_RES_IN_O,
    HORZ_RES_OUT_O                     =>    HORZ_RES_OUT_O,
    VERT_RES_OUT_O                     =>    VERT_RES_OUT_O,
    SCALE_FACTOR_HORZ_O                =>    SCALE_FACTOR_HORZ_O,
    SCALE_FACTOR_VERT_O                =>    SCALE_FACTOR_VERT_O
	--SCALAR_RESET_O					   =>	 SCALAR_RESET_O
   
);
END ARCHITECTURE AXI4Lite_IF_Scaler;  
  
--=================================================================================================
-- File Name                           : AXI4LITE_SUB_BLK_Scaler.vhd
-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2022 BY MICROCHIP
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROCHIP
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROCHIP FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--
--=================================================================================================
--=================================================================================================
-- Libraries
--=================================================================================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--=================================================================================================
-- AXI4LITE_SUB_BLK_Scaler entity declaration
--=================================================================================================
ENTITY AXI4LITE_SUB_BLK_Scaler IS
PORT (
-- Port list
    -- AXI4 reset
    RESETN_I                         : IN   STD_LOGIC;
    -- axi clk                                  
    CLK_I                            : IN   STD_LOGIC;                                                
	-- axi write adrs channel-awvalid           
	AWVALID_I                        : IN   STD_LOGIC;
	-- axi write adrs channel-awready           
	AWREADY_O                        : OUT  STD_LOGIC;
	-- axi write adrs channel-awaddr            
	AWADDR_I                         : IN   STD_LOGIC_VECTOR (31 DOWNTO 0);
	-- axi write adrs channel-awprot            
	AWPROT_I                         : IN   STD_LOGIC_VECTOR(2 DOWNTO 0);
	-- axi write adrs channel-burst type        
	AWBURST_I                        : IN   STD_LOGIC_VECTOR(1 DOWNTO 0);	
	-- axi write data channel-write data        
	WDATA_I                          : IN   STD_LOGIC_VECTOR (31 DOWNTO 0);
	-- axi write data channel-wvalid            
	WVALID_I                         : IN   STD_LOGIC;
	-- axi write data channel-wready            
	WREADY_O                         : OUT  STD_LOGIC;
	-- axi write adrs channel strobe            
	WSTRB_I                          : IN   STD_LOGIC_VECTOR(3 DOWNTO 0);	
    -- axi write response channel valid         
    BVALID_O                         : OUT  STD_LOGIC;
	-- axi write response channel-ready         
    BREADY_I                         : IN   STD_LOGIC;
	-- axi write response                       
    BRESP_O                          : OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);	
	-- axi read adrs channel arvalid            
	ARVALID_I                        : IN   STD_LOGIC;
	-- axi read adrs channel arready            
	ARREADY_O                        : OUT  STD_LOGIC;
	-- axi read adrs channel addr               
	ARADDR_I                         : IN   STD_LOGIC_VECTOR (31 DOWNTO 0);
	-- axi read adrs channel arprot             
	ARPROT_I                         : IN   STD_LOGIC_VECTOR(2 DOWNTO 0);
	-- axi read adrs channel arburst            
    ARBURST_I                        : IN   STD_LOGIC_VECTOR(1 DOWNTO 0);	
	-- axi read data channel data               
    RDATA_O                          : OUT  STD_LOGIC_VECTOR (31 DOWNTO 0);
	-- axi read data channel valid              
	RVALID_O                         : OUT  STD_LOGIC;
	-- axi read data channel ready              
	RREADY_I                         : IN   STD_LOGIC;
	-- axi read data channel response           
	RRESP_O                          : OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);    
	-- axi address write ID                     
    AWID_I                           : IN   STD_LOGIC_VECTOR(1 DOWNTO 0);
	-- axi burst length                         
	AWLEN_I                          : IN   STD_LOGIC_VECTOR(7 DOWNTO 0);
	-- axi burst size                           
	AWSIZE_I                         : IN   STD_LOGIC_VECTOR(2 DOWNTO 0);
	-- axi lock                                 
	AWLOCK_I                         : IN   STD_LOGIC_VECTOR(1 DOWNTO 0);
	-- axi cache                                
	AWCACHE_I                        : IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
	-- axi awuser                               
	AWUSER_I                         : IN   STD_LOGIC;
	-- axi qos                                  
	AWQOS_I                          : IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
	-- axi region                               
	AWREGION_I                       : IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
	-- axi last                                 
    WLAST_I                          : IN   STD_LOGIC;
	-- axi wuser                                
    WUSER_I                          : IN   STD_LOGIC;
	-- axi buser                                
    BUSER_O                          : OUT  STD_LOGIC;
	-- axi aruser                               
    ARUSER_I                         : IN   STD_LOGIC;
	-- axi ruser                                
    RUSER_O                          : OUT  STD_LOGIC;
	-- axi RID                                  
	RID_O                            : OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
	-- axi read last                            
	RLAST_O                          : OUT  STD_LOGIC;
	-- axi BID                                  
    BID_O                            : OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
	-- axi RID                                  
    ARID_I                           : IN   STD_LOGIC_VECTOR(1 DOWNTO 0);
	-- axi read length                          
    ARLEN_I                          : IN   STD_LOGIC_VECTOR(7 DOWNTO 0);
	-- axi read size                            
    ARSIZE_I                         : IN   STD_LOGIC_VECTOR(2 DOWNTO 0);
	-- axi read lock                            
    ARLOCK_I                         : IN   STD_LOGIC_VECTOR(1 DOWNTO 0);
	-- axi read cache                           
    ARCACHE_I                        : IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
	-- axi read qos                             
    ARQOS_I                          : IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
	-- axi read region                          
    ARREGION_I                       : IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
	-- user logic ports -  data valid
	USER_DATA_VALID_O                : OUT  STD_LOGIC;
	-- user logic ports - write address
	USER_AWADDR_O                    : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
	-- user logic ports -  write data
	USER_WDATA_O                     : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
	-- user logic ports - read address
	USER_ARADDR_O                    : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- user logic ports - read data	
	USER_RDATA_I                     : IN   STD_LOGIC_VECTOR(31 DOWNTO 0)
    
);
END AXI4LITE_SUB_BLK_Scaler;
--=================================================================================================
-- AXI4LITE_SUB_BLK_Scaler architecture body
--=================================================================================================
ARCHITECTURE AXI4LITE_SUB_BLK_Scaler OF AXI4LITE_SUB_BLK_Scaler IS
--=================================================================================================
-- Component declarations
--=================================================================================================
--NA--
--=================================================================================================
-- Synthesis Attributes
--=================================================================================================
--NA--
--=================================================================================================
-- Signal declarations
--=================================================================================================
type   state     is (a,b,c,d);
SIGNAL s_state   : state;
SIGNAL s_wready  : STD_LOGIC;
SIGNAL s_awready : STD_LOGIC;
SIGNAL s_arready : STD_LOGIC;
SIGNAL s_bvalid  : STD_LOGIC;
SIGNAL s_rvalid  : STD_LOGIC;

BEGIN
--=================================================================================================
-- Top level output port assignments
--=================================================================================================
WREADY_O          <= s_wready;
AWREADY_O         <= s_awready;
ARREADY_O         <= s_arready;
RDATA_O           <= USER_RDATA_I;
RVALID_O          <= s_rvalid;
RRESP_O           <= "00";
BVALID_O          <= s_bvalid;
BUSER_O           <= '0';
RUSER_O           <= '0';
RID_O             <= "00";
RLAST_O           <= (s_rvalid AND RREADY_I);
BID_O             <= AWID_I;
--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : P_WRITE_DATA
-- Description: DECODE THE AXI DATA AND GENERATE USER DATA
--------------------------------------------------------------------------
P_WRITE_DATA:
    PROCESS (RESETN_I,CLK_I)
    BEGIN
	    IF RESETN_I = '0' THEN
		    USER_AWADDR_O <= (others => '0');
			USER_DATA_VALID_O <= '0';
			s_awready       <= '0';
			s_wready        <= '0';
            s_state         <= a;
			s_bvalid        <= '0';            			
			
        ELSIF ( RISING_EDGE ( CLK_I ) ) THEN
		    case s_state is
			    when a =>
		            IF ( AWVALID_I = '1' AND WVALID_I = '1' ) THEN
			            USER_AWADDR_O     <= AWADDR_I;
			        	USER_DATA_VALID_O <= '1';
			        	USER_WDATA_O      <= WDATA_I;
			        	s_state           <= d;
						s_awready         <= '1';
						s_wready          <= '1';
						s_bvalid          <= '1';						
			        ELSIF ( AWVALID_I = '1' ) THEN
			            s_awready         <= '1';
						s_wready          <= '0';
						USER_AWADDR_O     <= AWADDR_I;
						s_state           <= b;
						USER_DATA_VALID_O <= '0';
			        ELSIF ( WVALID_I = '1' ) THEN
			            s_awready     <= '0';
						s_wready      <= '1';
						USER_WDATA_O  <= WDATA_I;
					    s_state       <= c;
						USER_DATA_VALID_O <= '0';
			        END IF;
			    when b =>
			        IF ( WVALID_I = '1' ) THEN
			            USER_WDATA_O      <= WDATA_I;
						USER_DATA_VALID_O <= '1';
						s_state           <= d;
						s_wready          <= '1';
						s_bvalid          <= '1';
			        END IF;
					    s_awready         <= '0';
			    when c =>
			        IF ( AWVALID_I = '1' ) THEN
			            USER_AWADDR_O     <= AWADDR_I;
						USER_DATA_VALID_O <= '1';
						s_state           <= d;
						s_bvalid          <= '1';
			        END IF;
					    s_wready      <= '0';
				when d =>
				        USER_DATA_VALID_O <= '0';   	
			        	s_awready         <= '0';
						s_wready          <= '0';
						if ( BREADY_I = '1') then
						    s_state           <= a;
							s_bvalid          <= '0';
						end if;
				when others => null;
			end case;		       
		END IF;
	END PROCESS;
--------------------------------------------------------------------------
-- Name       : P_READ_DATA
-- Description: DECODE THE AXI DATA AND GENERATE USER DATA
--------------------------------------------------------------------------	
P_READ_DATA:
    PROCESS (RESETN_I,CLK_I)
    BEGIN
	    IF RESETN_I = '0' THEN
			s_rvalid        <= '0';			
        ELSIF ( RISING_EDGE ( CLK_I ) ) THEN					
		    IF ( ARVALID_I = '1' AND s_arready = '1' ) THEN
			    USER_ARADDR_O <= ARADDR_I;
            END IF;			
		    IF ( ARVALID_I = '1' AND s_arready = '1' AND s_rvalid = '0' ) THEN			  
				s_rvalid      <= '1';
			ELSIF ( RREADY_I = '1' AND s_rvalid = '1' ) THEN			
			    s_rvalid      <= '0';
			END IF; 		
		END IF;
	END PROCESS;
--------------------------------------------------------------------------
-- Name       : P_RESPONSE
-- Description: OUTPUT ON RESPONSE CAHNNEL
--------------------------------------------------------------------------
P_RESPONSE:
    PROCESS (RESETN_I,CLK_I)
    BEGIN
	    IF RESETN_I = '0' THEN
	    	BRESP_O   <= "11";
	    	s_arready <= '0';
	    ELSIF ( RISING_EDGE ( CLK_I ) ) THEN
                BRESP_O   <= "00";
	    	    s_arready <= '1';
	    END IF;
	END PROCESS;         
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
END ARCHITECTURE AXI4LITE_SUB_BLK_Scaler;

--=================================================================================================
-- File Name                           : AXI4LITE_USR_BLK_Scaler.vhd
-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
-- COPYRIGHT 2022 BY MICROCHIP
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROCHIP
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROCHIP FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--=================================================================================================
--=================================================================================================
-- Libraries
--=================================================================================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--=================================================================================================
-- AXI4LITE_USR_BLK_Scaler entity declaration
--=================================================================================================
ENTITY AXI4LITE_USR_BLK_Scaler IS
PORT (
-- Port list
    -- AXI4 reset
    RESETN_I                         : IN  STD_LOGIC;
    -- AXI4 clock	
    CLK_I                            : IN  STD_LOGIC;	
	-- user logic ports -  data valid
	USER_DATA_VALID_I                : IN  STD_LOGIC;
	-- user logic ports - write address
	USER_AWADDR_I                    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
	-- user logic ports -  write data
	USER_WDATA_I                     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
	-- user logic ports - read address
	USER_ARADDR_I                    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- user logic ports - read data	
	USER_RDATA_O                     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    	                                   
    HORZ_RES_IN_O                    : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
	                                                         
    VERT_RES_IN_O                    : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
                                                             
	HORZ_RES_OUT_O                   : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
                                                             
	VERT_RES_OUT_O                   : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
    
	SCALE_FACTOR_HORZ_O              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    
	SCALE_FACTOR_VERT_O              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) 

	--SCALAR_RESET_O                   : OUT STD_LOGIC
);
END AXI4LITE_USR_BLK_Scaler;
--=================================================================================================
-- AXI4LITE_USR_BLK_Scaler architecture body
--=================================================================================================
ARCHITECTURE AXI4LITE_USR_BLK_Scaler OF AXI4LITE_USR_BLK_Scaler IS
--=================================================================================================
-- Component declarations
--=================================================================================================
--NA--
--=================================================================================================
-- Synthesis Attributes
--=================================================================================================
--NA--
--=================================================================================================
-- Signal declarations
--=================================================================================================
CONSTANT HORZ_RES_IN_ADDR              : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"080";
CONSTANT VERT_RES_IN_ADDR              : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"084";
CONSTANT HORZ_RES_OUT_ADDR         	   : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"088";
CONSTANT VERT_RES_OUT_ADDR             : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"08C";
CONSTANT SCALE_FACTOR_HORZ_ADDR        : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"090";
CONSTANT SCALE_FACTOR_VERT_ADDR        : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"094";
CONSTANT C_USER_ADDR_0                 : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"040";
CONSTANT C_USER_ADDR_1                 : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"044";
SIGNAL   s_frame_end_fe                : STD_LOGIC;
SIGNAL   s_frame_end_dly1              : STD_LOGIC;
SIGNAL   s_frame_end_dly2              : STD_LOGIC;
SIGNAL   s_user_data_0                 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   s_user_data_1                 : STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL   s_scaler_hres_in              : STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL   s_scaler_vres_in              : STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL   s_scaler_hres_out             : STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL   s_scaler_vres_out             : STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL   s_scaler_hscale               : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL   s_scaler_vscale               : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
--=================================================================================================
-- Top level output port assignments
--=================================================================================================
--NA--
--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
s_frame_end_fe <= ( (not (s_frame_end_dly1)) and s_frame_end_dly2);

--------------------------------------------------------------------------
-- Name       : READ_DECODE_PROC
-- Description: Process implements the AXI4 read operation
--------------------------------------------------------------------------
WRITE_DECODE_PROC:
    PROCESS (RESETN_I, CLK_I)
    BEGIN
        IF(RESETN_I = '0')THEN
			s_user_data_0   <= x"01234567";
			s_user_data_1   <= x"89abcdef";
			
        ELSIF (CLK_I'EVENT AND CLK_I = '1') THEN
		    IF ( USER_DATA_VALID_I = '1' ) THEN
                CASE USER_AWADDR_I(11 DOWNTO 0)  IS
--------------------
-- HORZ_RES_IN_ADDR
--------------------
                    WHEN HORZ_RES_IN_ADDR =>
                        S_SCALER_HRES_IN <= USER_WDATA_I(12 DOWNTO 0);
						
--------------------
-- VERT_RES_IN_ADDR
--------------------
                    WHEN VERT_RES_IN_ADDR =>
                        S_SCALER_VRES_IN <= USER_WDATA_I(12 DOWNTO 0);
						
--------------------
-- HORZ_RES_OUT_ADDR
--------------------
                    WHEN HORZ_RES_OUT_ADDR =>
                        S_SCALER_HRES_OUT <= USER_WDATA_I(12 DOWNTO 0);
						
--------------------
-- VERT_RES_OUT_ADDR
--------------------
                    WHEN VERT_RES_OUT_ADDR =>
                        S_SCALER_VRES_OUT <= USER_WDATA_I(12 DOWNTO 0);	

--------------------
-- SCALE_FACTOR_HORZ_ADDR
--------------------
                    WHEN SCALE_FACTOR_HORZ_ADDR =>
                        S_SCALER_HSCALE <= USER_WDATA_I(15 DOWNTO 0);
						
--------------------
-- SCALE_FACTOR_VERT_ADDR
--------------------
                    WHEN SCALE_FACTOR_VERT_ADDR =>
                        S_SCALER_VSCALE <= USER_WDATA_I(15 DOWNTO 0);	
--------------------
-- USER READ WRITE REGISTERS
--------------------
				    WHEN C_USER_ADDR_0 =>
                        s_user_data_0 <= USER_WDATA_I(31 DOWNTO 0);
						
				    WHEN C_USER_ADDR_1 =>
                        s_user_data_1 <= USER_WDATA_I(31 DOWNTO 0);
--------------------
-- OTHERS
--------------------
                    WHEN OTHERS =>
                        NULL;
                END CASE;
            END IF;
        END IF;
    END PROCESS;
	
--------------------------------------------------------------------------
-- Name       : scalar data assignment process
-- Description: Process implements the data write operation for scaler
--------------------------------------------------------------------------    
    proc : PROCESS (RESETN_I, CLK_I)
    BEGIN
         IF (RESETN_I = '0') THEN
              s_frame_end_dly1 <='0';
              s_frame_end_dly2 <='0';
              HORZ_RES_IN_O       <= "0" & x"780";
              VERT_RES_IN_O       <= "0" & x"438";
              HORZ_RES_OUT_O      <= "0" & x"3C0";
              VERT_RES_OUT_O      <= "0" & x"21C";
              SCALE_FACTOR_HORZ_O <= x"07FF";
              SCALE_FACTOR_VERT_O <= x"07FE";
              --SCALAR_RESET_O      <= '1';
          ELSIF (CLK_I'EVENT AND CLK_I = '1') THEN              
              IF (s_frame_end_fe ='1') THEN
                HORZ_RES_IN_O       <= s_scaler_hres_in;
                VERT_RES_IN_O       <= s_scaler_vres_in;
                HORZ_RES_OUT_O      <= s_scaler_hres_out;
                VERT_RES_OUT_O      <= s_scaler_vres_out;
                SCALE_FACTOR_HORZ_O <= s_scaler_hscale;
                SCALE_FACTOR_VERT_O <= s_scaler_vscale;
                --SCALAR_RESET_O      <= '0';
              --ELSE
                --SCALAR_RESET_O      <= '1';
              END IF;   
          END IF;
      END PROCESS; 
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : READ_DECODE_PROC
-- Description: Process implements the AXI4 write operation
--------------------------------------------------------------------------
READ_DECODE_PROC:
    PROCESS (USER_ARADDR_I)
    BEGIN
        CASE  USER_ARADDR_I(11 DOWNTO 0)  IS				
--------------------
-- USER READ WRITE REGISTERS
--------------------
		    WHEN C_USER_ADDR_0 =>
                USER_RDATA_O <= s_user_data_0;
				
		    WHEN C_USER_ADDR_1 =>
                USER_RDATA_O <= s_user_data_1;
--------------------
-- OTHERS
--------------------
            WHEN OTHERS =>
            USER_RDATA_O <= (OTHERS=>'0');
        END CASE;
    END PROCESS;
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
END ARCHITECTURE AXI4LITE_USR_BLK_Scaler;
