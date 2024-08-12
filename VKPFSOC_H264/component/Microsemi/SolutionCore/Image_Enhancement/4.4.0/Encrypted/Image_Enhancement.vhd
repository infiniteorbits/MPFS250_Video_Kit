--=================================================================================================
-- File Name                           : Image_Enhancement.vhd
-- Description						   : Supporting both Native mode and AXI4 Stream mode

-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2023 BY MICROSEMI
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;   
--=================================================================================================
-- Image_Enhancement entity declaration
--=================================================================================================                                                                                                                          
ENTITY Image_Enhancement IS                                                                                                       
  GENERIC(
-- Generic List
    -- Specifies the data width
    G_PIXEL_WIDTH 		: INTEGER RANGE 8 TO 16 := 8;
	
	G_PIXELS			: INTEGER := 1;  --  1= one pixel and 4= 4pixels (4k) 
	
	G_CONFIG			: INTEGER := 0;  --  0= Native and 1= AXI4-Lite

    G_FORMAT		    : INTEGER := 0   --  0= Native and 1= Image_Enhancement with AXI	
    );
  PORT (
-- Port List
    -- System reset
    RESETN_I 							: IN STD_LOGIC;

    -- System clock
    SYS_CLK_I 							: IN STD_LOGIC;

    -- Specifies the input data is valid or not
    DATA_VALID_I 						: IN STD_LOGIC; 

	--Enable input
	ENABLE_I							: IN STD_LOGIC;
	
	-- Data input to SLAVE
    TDATA_I                       		: IN STD_LOGIC_VECTOR(3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
    
	-- Specifies the valid control signal to SLAVE
    TVALID_I                       		: IN STD_LOGIC;
	
	TREADY_O                       		: OUT STD_LOGIC;
	
	TUSER_I								: IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
	
    -- data input	  
    --DATA_I       						: IN STD_LOGIC_VECTOR (3*G_PIXELS*G_PIXEL_WIDTH - 1 DOWNTO 0); 
	
	R_I									: IN STD_LOGIC_VECTOR (G_PIXELS*G_PIXEL_WIDTH - 1 DOWNTO 0);
	
	G_I									: IN STD_LOGIC_VECTOR (G_PIXELS*G_PIXEL_WIDTH - 1 DOWNTO 0);
	
	B_I									: IN STD_LOGIC_VECTOR (G_PIXELS*G_PIXEL_WIDTH - 1 DOWNTO 0);
	
	
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
	
	--R-constant input
	R_CONST_I							: IN STD_LOGIC_VECTOR(9 DOWNTO 0);

	--G-constant input
	G_CONST_I							: IN STD_LOGIC_VECTOR(9 DOWNTO 0);

	--B-constant input
	B_CONST_I							: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	--Second constant input
	COMMON_CONST_I						: IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    	
	-- Specifies the valid RGB data
	DATA_VALID_O 						: OUT STD_LOGIC;

    -- Filtered Output 
    DATA_O 								: OUT STD_LOGIC_VECTOR(3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0); 
	
	R_O                         		: OUT STD_LOGIC_VECTOR(G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
	
	G_O                        	   		: OUT STD_LOGIC_VECTOR(G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
	
	B_O                          		: OUT STD_LOGIC_VECTOR(G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
	
	-- Data output from MASTER1
    TDATA_O                       		: OUT STD_LOGIC_VECTOR(3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
	
	TLAST_O								: OUT STD_LOGIC;
	
	TUSER_O								: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    
	-- Specifies the valid control signal from MASTER1
    TVALID_O                       		: OUT STD_LOGIC;
	
	TSTRB_O                             : OUT STD_LOGIC_VECTOR(G_PIXEL_WIDTH/8 - 1 DOWNTO 0);
	
	TKEEP_O                             : OUT STD_LOGIC_VECTOR(G_PIXEL_WIDTH/8 - 1 DOWNTO 0)
	
    );
END Image_Enhancement;
--=================================================================================================
-- Image_Enhancement architecture body
--=================================================================================================
ARCHITECTURE rtl OF Image_Enhancement IS
--=================================================================================================
-- Component declarations
--=================================================================================================
COMPONENT Image_Enhancement_Native 
	GENERIC(
		G_PIXEL_WIDTH 		: INTEGER RANGE 8 TO 16 := 8
		);
		PORT (                                                                                                        
			SYS_CLK_I         : IN STD_LOGIC;
			RESETN_I          : IN STD_LOGIC;
			DATA_VALID_I   	  : IN STD_LOGIC;
			ENABLE_I		  : IN STD_LOGIC;
			DATA_I       	  : IN STD_LOGIC_VECTOR ((3*G_PIXEL_WIDTH - 1) DOWNTO 0);  
			R_CONST_I		  : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			G_CONST_I		  : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			B_CONST_I		  : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			COMMON_CONST_I	  : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
			DATA_O			  : OUT STD_LOGIC_VECTOR ((3*G_PIXEL_WIDTH - 1) DOWNTO 0);
			DATA_VALID_O 	  : OUT STD_LOGIC
		);
		END COMPONENT;
		
COMPONENT Image_Enhancement_4k 
	GENERIC(
		G_PIXEL_WIDTH 		: INTEGER RANGE 8 TO 16 := 8;
		G_PIXELS			: INTEGER := 4
		);
		PORT (                                                                                                        
			SYS_CLK_I         : IN STD_LOGIC;
			RESETN_I          : IN STD_LOGIC;
			DATA_VALID_I   	  : IN STD_LOGIC;
			ENABLE_I		  : IN STD_LOGIC;
			DATA_I       	  : IN STD_LOGIC_VECTOR ((3*G_PIXELS*G_PIXEL_WIDTH - 1) DOWNTO 0);  
			R_CONST_I		  : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			G_CONST_I		  : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			B_CONST_I		  : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			COMMON_CONST_I	  : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
			DATA_O			  : OUT STD_LOGIC_VECTOR ((3*G_PIXELS*G_PIXEL_WIDTH - 1) DOWNTO 0);
			DATA_VALID_O 	  : OUT STD_LOGIC
		);
		END COMPONENT;
		
COMPONENT AXI4S_INITIATOR_IE 
	GENERIC(
		G_PIXEL_WIDTH         : INTEGER RANGE 8 To 96 := 8;
		G_PIXELS			  : INTEGER := 1
		);
		PORT ( 
            RESETN_I    	  : IN STD_LOGIC;	
            SYS_CLK_I 		  : IN STD_LOGIC;			
			DATA_I         	  : IN STD_LOGIC_VECTOR(3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
			DATA_VALID_I   	  : IN STD_LOGIC;
            EOF_I			  : IN STD_LOGIC;			
			TDATA_O           : OUT STD_LOGIC_VECTOR(3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0); 
			TSTRB_O           : OUT STD_LOGIC_VECTOR(G_PIXEL_WIDTH/8 - 1 DOWNTO 0);
			TKEEP_O           : OUT STD_LOGIC_VECTOR(G_PIXEL_WIDTH/8 - 1 DOWNTO 0);
			TLAST_O           : OUT STD_LOGIC;
	        TUSER_O			  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			TVALID_O          : OUT STD_LOGIC
		);
		END COMPONENT;
			
COMPONENT AXI4S_TARGET_IE 
	GENERIC(
		G_PIXEL_WIDTH         : INTEGER RANGE 8 To 96 := 8;
		G_PIXELS			  : INTEGER := 1
		);
		PORT (                                                                                                        
			TDATA_I            : IN STD_LOGIC_VECTOR(3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
			TUSER_I            : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			TREADY_O		   : OUT STD_LOGIC;
			TVALID_I           : IN STD_LOGIC;
            EOF_O			   : OUT STD_LOGIC;			
			DATA_O             : OUT STD_LOGIC_VECTOR(3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);   
			DATA_VALID_O       : OUT STD_LOGIC
		);
		END COMPONENT;
		
COMPONENT AXI4Lite_IF_IE
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
			rconst_o                             : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			gconst_o                             : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			bconst_o                             : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			second_const_o                       : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
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
SIGNAL s_eof		        : STD_LOGIC;
SIGNAL s_dvalid_slv	        : STD_LOGIC;
SIGNAL s_dvalid_mstr        : STD_LOGIC;
SIGNAL s_data_in			: STD_LOGIC_VECTOR (3*G_PIXELS*G_PIXEL_WIDTH - 1 DOWNTO 0);
SIGNAL s_data_i_4k			: STD_LOGIC_VECTOR (3*G_PIXELS*G_PIXEL_WIDTH - 1 DOWNTO 0);
SIGNAL s_data_axi			: STD_LOGIC_VECTOR (3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
SIGNAL s_data_4k_axi		: STD_LOGIC_VECTOR (3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
SIGNAL s_r_constant_axi4L	: STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL s_g_constant_axi4L	: STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL s_b_constant_axi4L	: STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL s_c_constant_axi4L	: STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL s_data_i 			: STD_LOGIC_VECTOR (3*G_PIXELS*G_PIXEL_WIDTH - 1 DOWNTO 0);
SIGNAL s_data_o 			: STD_LOGIC_VECTOR (3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0); 

BEGIN
--=================================================================================================
-- Top level output port assignments
--=================================================================================================
	R_O  <= s_data_o((3*G_PIXELS*G_PIXEL_WIDTH - 1) DOWNTO (2*G_PIXELS*G_PIXEL_WIDTH));
	G_O  <= s_data_o((2*G_PIXELS*G_PIXEL_WIDTH - 1) DOWNTO (G_PIXELS*G_PIXEL_WIDTH));
	B_O  <= s_data_o((G_PIXELS*G_PIXEL_WIDTH - 1) DOWNTO 0);
--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
 s_data_i <= R_I & G_I & B_I;
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--NA--	
--=================================================================================================
-- Component Instantiations
--=================================================================================================
IE_1p_AXI4S_AXI4L_FORMAT : IF G_PIXELS = 1 AND G_FORMAT = 1 AND G_CONFIG = 1 GENERATE
Image_Enhancement_AXI4S_AXI4L_INST: Image_Enhancement_Native
GENERIC MAP(
	G_PIXEL_WIDTH => G_PIXEL_WIDTH
)
PORT MAP(
	SYS_CLK_I		=> 		SYS_CLK_I,
	RESETN_I		=>		RESETN_I,
	DATA_VALID_I	=> 		s_dvalid_slv,
	ENABLE_I		=>		ENABLE_I,
	DATA_I   		=>		s_data_in,
	R_CONST_I		=>		s_r_constant_axi4L,
	G_CONST_I		=>		s_g_constant_axi4L,
	B_CONST_I		=>		s_b_constant_axi4L,
	COMMON_CONST_I	=>		s_c_constant_axi4L,
	DATA_O			=>		s_data_axi,
	DATA_VALID_O	=>		s_dvalid_mstr
);
END GENERATE;

IE_1p_AXI4S_Native_FORMAT : IF G_PIXELS = 1 AND G_FORMAT = 1 AND G_CONFIG = 0 GENERATE
Image_Enhancement_AXI4S_Native_INST: Image_Enhancement_Native
GENERIC MAP(
	G_PIXEL_WIDTH => G_PIXEL_WIDTH
)
PORT MAP(
	SYS_CLK_I		=> 		SYS_CLK_I,
	RESETN_I		=>		RESETN_I,
	DATA_VALID_I	=> 		s_dvalid_slv,
	ENABLE_I		=>		ENABLE_I,
	DATA_I   		=>		s_data_in,
	R_CONST_I		=>		R_CONST_I,
	G_CONST_I		=>		G_CONST_I,
	B_CONST_I		=>		B_CONST_I,
	COMMON_CONST_I	=>		COMMON_CONST_I,
	DATA_O			=>		s_data_axi,
	DATA_VALID_O	=>		s_dvalid_mstr
);
END GENERATE;

IE_1p_AXI4L_Native_FORMAT : IF G_PIXELS = 1 AND G_FORMAT = 0 AND G_CONFIG = 1 GENERATE
Image_Enhancement_AXI4L_Native_INST: Image_Enhancement_Native
GENERIC MAP(
	G_PIXEL_WIDTH => G_PIXEL_WIDTH
)
PORT MAP(
	SYS_CLK_I		=> 		SYS_CLK_I,
	RESETN_I		=>		RESETN_I,
	DATA_VALID_I	=> 		DATA_VALID_I,
	ENABLE_I		=>		ENABLE_I,
	DATA_I   		=>		s_data_i,
	R_CONST_I		=>		s_r_constant_axi4L,
	G_CONST_I		=>		s_g_constant_axi4L,
	B_CONST_I		=>		s_b_constant_axi4L,
	COMMON_CONST_I	=>		s_c_constant_axi4L,
	DATA_O			=>		s_data_o,
	DATA_VALID_O	=>		DATA_VALID_O
);
END GENERATE;

IE_1p_Native_FORMAT : IF G_PIXELS = 1 AND G_FORMAT = 0 AND G_CONFIG = 0 GENERATE
Image_Enhancement_Native_INST: Image_Enhancement_Native
GENERIC MAP(
	G_PIXEL_WIDTH => G_PIXEL_WIDTH
)
PORT MAP(
	SYS_CLK_I		=> 		SYS_CLK_I,
	RESETN_I		=>		RESETN_I,
	DATA_VALID_I	=> 		DATA_VALID_I,
	ENABLE_I		=>		ENABLE_I,
	DATA_I   		=>		s_data_i,
	R_CONST_I		=>		R_CONST_I,
	G_CONST_I		=>		G_CONST_I,
	B_CONST_I		=>		B_CONST_I,
	COMMON_CONST_I	=>		COMMON_CONST_I,
	DATA_O			=>		s_data_o,
	DATA_VALID_O	=>		DATA_VALID_O
);
END GENERATE;

IE_4k_AXI4S_AXI4L_FORMAT : IF G_PIXELS = 4 AND G_FORMAT = 1 AND G_CONFIG = 1 GENERATE
Image_Enhancement_4p_AXI4S_AXI4L_INST: Image_Enhancement_4k
GENERIC MAP(
	G_PIXEL_WIDTH => G_PIXEL_WIDTH,
	G_PIXELS	  => G_PIXELS
)
PORT MAP(
	SYS_CLK_I		=> 		SYS_CLK_I,
	RESETN_I		=>		RESETN_I,
	DATA_VALID_I	=> 		s_dvalid_slv,
	ENABLE_I		=>		ENABLE_I,
	DATA_I   		=>		s_data_i_4k,
	R_CONST_I		=>		s_r_constant_axi4L,
	G_CONST_I		=>		s_g_constant_axi4L,
	B_CONST_I		=>		s_b_constant_axi4L,
	COMMON_CONST_I	=>		s_c_constant_axi4L,
	DATA_O			=>		s_data_4k_axi,
	DATA_VALID_O	=>		s_dvalid_mstr
);
END GENERATE;

IE_4k_AXI4S_Native_FORMAT : IF G_PIXELS = 4 AND G_FORMAT = 1 AND G_CONFIG = 0 GENERATE
Image_Enhancement_4p_AXI4S_Native_INST: Image_Enhancement_4k
GENERIC MAP(
	G_PIXEL_WIDTH => G_PIXEL_WIDTH,
	G_PIXELS	  => G_PIXELS
)
PORT MAP(
	SYS_CLK_I		=> 		SYS_CLK_I,
	RESETN_I		=>		RESETN_I,
	DATA_VALID_I	=> 		s_dvalid_slv,
	ENABLE_I		=>		ENABLE_I,
	DATA_I   		=>		s_data_i_4k,
	R_CONST_I		=>		R_CONST_I,
	G_CONST_I		=>		G_CONST_I,
	B_CONST_I		=>		B_CONST_I,
	COMMON_CONST_I	=>		COMMON_CONST_I,
	DATA_O			=>		s_data_4k_axi,
	DATA_VALID_O	=>		s_dvalid_mstr
);
END GENERATE;

IE_4k_Native_AXI4L_FORMAT : IF G_PIXELS = 4 AND G_FORMAT = 0 AND G_CONFIG = 1 GENERATE
Image_Enhancement_4p_Native_AXI4L_INST: Image_Enhancement_4k
GENERIC MAP(
	G_PIXEL_WIDTH => G_PIXEL_WIDTH,
	G_PIXELS	  => G_PIXELS
)
PORT MAP(
	SYS_CLK_I		=> 		SYS_CLK_I,
	RESETN_I		=>		RESETN_I,
	DATA_VALID_I	=> 		DATA_VALID_I,
	ENABLE_I		=>		ENABLE_I,
	DATA_I   		=>		s_data_i,
	R_CONST_I		=>		s_r_constant_axi4L,
	G_CONST_I		=>		s_g_constant_axi4L,
	B_CONST_I		=>		s_b_constant_axi4L,
	COMMON_CONST_I	=>		s_c_constant_axi4L,
	DATA_O			=>		s_data_o,
	DATA_VALID_O	=>		DATA_VALID_O
);
END GENERATE;

IE_4k_Native_FORMAT : IF G_PIXELS = 4 AND G_FORMAT = 0 AND G_CONFIG = 0 GENERATE
Image_Enhancement_4p_Native_INST: Image_Enhancement_4k
GENERIC MAP(
	G_PIXEL_WIDTH => G_PIXEL_WIDTH,
	G_PIXELS	  => G_PIXELS
)
PORT MAP(
	SYS_CLK_I		=> 		SYS_CLK_I,
	RESETN_I		=>		RESETN_I,
	DATA_VALID_I	=> 		DATA_VALID_I,
	ENABLE_I		=>		ENABLE_I,
	DATA_I   		=>		s_data_i,
	R_CONST_I		=>		R_CONST_I,
	G_CONST_I		=>		G_CONST_I,
	B_CONST_I		=>		B_CONST_I,
	COMMON_CONST_I	=>		COMMON_CONST_I,
	DATA_O			=>		s_data_o,
	DATA_VALID_O	=>		DATA_VALID_O
);
END GENERATE;

IE_axi4lite_FORMAT : IF G_CONFIG = 1 GENERATE
Image_Enhancement_AXI_LITE_INST: AXI4Lite_IF_IE
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
	rconst_o           => s_r_constant_axi4L,
	gconst_o           => s_g_constant_axi4L,
	bconst_o           => s_b_constant_axi4L,
	second_const_o     => s_c_constant_axi4L
);
END GENERATE;

IE_tar_FORMAT : IF G_FORMAT = 1 AND G_PIXELS = 1 GENERATE
Image_Enhancement_AXI4S_TAR_INST: AXI4S_TARGET_IE
GENERIC MAP(
	G_PIXEL_WIDTH   => G_PIXEL_WIDTH,
	G_PIXELS		=> G_PIXELS
)
PORT MAP(
	TVALID_I			=> 		TVALID_I,
	TDATA_I				=> 		TDATA_I,
	TUSER_I				=>      TUSER_I,
	TREADY_O            =>      TREADY_O,
	EOF_O				=>      s_eof,
	DATA_VALID_O		=>      s_dvalid_slv,
	DATA_O 				=>		s_data_in
);
END GENERATE;

IE_tar_4k_FORMAT : IF G_FORMAT = 1 AND G_PIXELS = 4 GENERATE
Image_Enhancement_AXI4S_TAR_4k_INST: AXI4S_TARGET_IE
GENERIC MAP(
	G_PIXEL_WIDTH   => G_PIXEL_WIDTH,
	G_PIXELS		=> G_PIXELS
)
PORT MAP(
	TVALID_I			=> 		TVALID_I,
	TDATA_I				=> 		TDATA_I,
	TUSER_I				=>      TUSER_I,
	TREADY_O            =>      TREADY_O,
	EOF_O				=>      s_eof,
	DATA_VALID_O		=>      s_dvalid_slv,
	DATA_O 				=>		s_data_i_4k
);
END GENERATE;

IE_init_FORMAT : IF G_FORMAT = 1 AND G_PIXELS=1 GENERATE
Image_Enhancement_AXI4S_INIT_INST: AXI4S_INITIATOR_IE
GENERIC MAP(
	G_PIXEL_WIDTH   => G_PIXEL_WIDTH,
	G_PIXELS		=> G_PIXELS
)
PORT MAP(
    SYS_CLK_I			=>      SYS_CLK_I,
	RESETN_I			=>      RESETN_I,
	EOF_I				=>      s_eof,
	DATA_VALID_I		=> 		s_dvalid_mstr,
	DATA_I				=>		s_data_axi,
	TUSER_O				=>      TUSER_O,
	TLAST_O				=>      TLAST_O,
	TSTRB_O				=>		TSTRB_O,
	TKEEP_O				=>		TKEEP_O,
	TVALID_O			=>      TVALID_O,
	TDATA_O				=>		TDATA_O
);
END GENERATE;

IE_init_4k_FORMAT : IF G_FORMAT = 1 AND G_PIXELS=4 GENERATE
Image_Enhancement_AXI4S_INIT_4k_INST: AXI4S_INITIATOR_IE
GENERIC MAP(
	G_PIXEL_WIDTH   => G_PIXEL_WIDTH,
	G_PIXELS		=> G_PIXELS
)
PORT MAP(
    SYS_CLK_I			=>      SYS_CLK_I,
	RESETN_I			=>      RESETN_I,
	EOF_I				=>      s_eof,
	DATA_VALID_I		=> 		s_dvalid_mstr,
	DATA_I				=>		s_data_4k_axi,
	TUSER_O				=>      TUSER_O,
	TLAST_O				=>      TLAST_O,
	TSTRB_O				=>		TSTRB_O,
	TKEEP_O				=>		TKEEP_O,
	TVALID_O			=>      TVALID_O,
	TDATA_O				=>		TDATA_O
);
END GENERATE;
END rtl;
--=================================================================================================
-- File Name                           : Image_Enhancement_Native.vhd

-- Description                         : This module implements brightness, contrast and colour balance.

-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2023 BY MICROCHIP
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
USE IEEE.STD_LOGIC_SIGNED.ALL;

--=================================================================================================
-- Image_Enhancement_Native entity declaration
--=================================================================================================
ENTITY Image_Enhancement_Native IS
GENERIC(
-- Generic List
	-- Specifies the bit width of each pixel
    G_PIXEL_WIDTH               : INTEGER := 8
);
PORT(
-- Port list
    -- System reset
    RESETN_I                            	: IN STD_LOGIC;
    
    -- System clock
    SYS_CLK_I                          	: IN STD_LOGIC;
    
	--Data valid	
	DATA_VALID_I							: IN STD_LOGIC;
	
	--Enable input
	ENABLE_I							: IN STD_LOGIC;
	
    -- Channel 1 data
    DATA_I                          	: IN STD_LOGIC_VECTOR(3*G_PIXEL_WIDTH-1 DOWNTO 0);
	
	--R-constant input
	R_CONST_I							: IN STD_LOGIC_VECTOR(9 DOWNTO 0);

	--G-constant input
	G_CONST_I							: IN STD_LOGIC_VECTOR(9 DOWNTO 0);

	--B-constant input
	B_CONST_I							: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	--Second constant input
	COMMON_CONST_I						: IN STD_LOGIC_VECTOR(19 DOWNTO 0);
	
	--Output valid
	DATA_VALID_O						: OUT STD_LOGIC;	
		
	-- Alpha blended output
	DATA_O								: OUT STD_LOGIC_VECTOR(3*G_PIXEL_WIDTH-1 DOWNTO 0)
   
);
END Image_Enhancement_Native;
`protect begin_protected
`protect version=1
`protect author="author-a", author_info="author-a-details"
`protect encrypt_agent="encryptP1735.pl", encrypt_agent_info="Synplify encryption scripts"

`protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=256)
`protect key_block
YeOgdd6tfxaxrpXeJhp38OLcbVC1MTtXoAw7hT1W9ZS1rU0ZBEOrnzkYN9sR23zHytz5B7M8lRrL
+hGNl1g8zt/1Qx7UQqUpn1/hzLJWs1SBaRy8p1uh0NZFFDuqUBmjGzJbuI9J2EzjQXaowWKX2V42
EMPqOkVC4oboPHctx/VApWn2nPQJ12VGi0LHi3ZhcjMu+I+ieHW11Lr7BVqbSbKZvKiGg2LoGpjO
li5F+KOmi1DWolTeHzw3r0QLK7EXxc78UVaygeTsSlQ9n1aXk7RKp5Om9GbxHfM3U1UJ6TBQdUCb
XnNGp5DPK64eEIK01qFN85g+1OZhjIkAZ+nqIw==

`protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=128)
`protect key_block
Ga2RaoHEAdaulz3NGbPphD4sqcfEh/E6WbEDaX4KQlNGOfGHy9OoTrZzLeZLFj63Hk5KP6C7vaDL
/r9f61PAJ4Ez09E4hYgjsPA6LEy36+Q5muYYQ+hN4af4ktuUArYD2QGewXLq+qIxqEZOUkiYvg93
XeDZoa8CfliYv4hCF4U=

`protect key_keyowner="Microchip Corporation", key_keyname="MSC-IP-KEY-RSA", key_method="rsa"
`protect encoding=(enctype="base64", line_length=76, bytes=960)
`protect key_block
B53bFCl7WdpMLSwM8XDyfyu88K4DgNplaw3fEOrMsTzd91BRKATBInpk9D/OjFxVIoeQLP1xKPSa
eLE58pOoHTJtVsV0dpqkH86NHY20KFrUDV/ogS9fuGMH/ZapY3ozcvDcvIxuYqgrcQln8Pi8q7iW
8l2IMmuadzh47sUnTTS8Yyvl+f1kCWHdthfwqGUAgAdJ2Ch+I7Tn/0ymWL5EOJWy6plZmT1tElF+
H84RHRRLxJBll8LJlerYTwlmD0R666+GVG/XwbX6JUkJfXgWI6FxlR/woM4vItHuivE8R+FZh77P
A0+JFOiJo+Pr2oyaac9+WMr8mOcJwdSBENUbL94OPy5Lv/7K0FPMx5EWk/3bXmBCd5nngcijfUW1
WiGwUwxBUhfKpParXpfBLlN6k/J+UEiVegOf3CMIGD9eogRFK0WpN4DrV/5idP6VE7N0d5BXba+D
9pfFrjN34msyYpnZIUumR2Ord6ypk9PNna9J9O2cQF61VUpy4s5KGi9vKjmGQ3jU9DGvSOtSH4LI
UihCXgrFNTgP7ynV4PwLsMjSXvkeJWa/HamoCxQjxSWLcdNNCI8mNmOwcrhBCCN+XGqTSDLGJH9t
3pxW2xdwlqVWnHHlIpT9uXmj+dB9iqm78QDaaSkpHcLc4ZiF80NbJEQZ05NNtyE3OrjTdOpqn1LW
G9lrP5wwBkuyQyE/CxcCl9AVPZvBfn1iPRfB1a61rTFAn9NQ1KXVCp1S7KamkyfqVPTp+fqHQfR6
njzCC+10l6vihrBCpvQ20g3yfU74w/VMDDF87kwyOwegHeFWYOIuGRbpUg6u4qqwYbS+l7HSWl0F
TRi1uvF4gpbepz2otRq88h2gJ0unMr/6BFydkAb2oIa5YeZFc50oSgHbZLD1yBakiy4W1gBLlalR
onvMgUZoKwjIcAthlhOrOkApunrdmGxmVJ15CjNaAiPxpFv0dGSGGUsOvpZJdA8fWUeYQB1YP7Sq
DY8KKOrbaRn+bFpp3HR6bt5OL6o70fICgGX+n8cPS3730910vSss17vmm26hAslLuRrIrL0md+H8
T3wgGmIIwGOq2+Ekc8a4seKnVh0bomdw2dBcWtt28V3zEJJ6eODTuJfdFhZY1gAXdgf9e/byjOrC
l1KfxzYcEGQEJYS3JuQRXwnpsH96w9JnfCCDf145lGUgHiomLUiWQwCeRTMM9PuoTM1frhojtYZe
kUH0dEYsuBF/ZVsRimYs1WBY4VFhJYXEERHDqdYsEIOOd4kme6A8dabStv3MJgzO

`protect data_keyowner="ip-vendor-a", data_keyname="fpga-ip", data_method="aes128-cbc"
`protect encoding=(enctype="base64", line_length=76, bytes=16640)
`protect data_block
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

`protect end_protected

--=================================================================================================
-- File Name                           : AXI4Lite_IF_IE.vhd

-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2023 BY MICROCHIP
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
-- AXI4Lite_IF_IE entity declaration
--=================================================================================================
ENTITY AXI4Lite_IF_IE IS
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
	
    rconst_o                             : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    gconst_o                             : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    bconst_o                             : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    second_const_o                       : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
);
END AXI4Lite_IF_IE;
--=================================================================================================
-- AXI4Lite_IF_IE architecture body
--=================================================================================================
ARCHITECTURE AXI4Lite_IF_IE OF AXI4Lite_IF_IE IS
--=================================================================================================
-- Component declarations
--=================================================================================================
COMPONENT AXI4LITE_SUB_BLK_IE IS
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

COMPONENT AXI4LITE_USR_BLK_IE IS
PORT (
    RESETN_I                         : IN  STD_LOGIC;
    CLK_I                            : IN  STD_LOGIC;
    USER_DATA_VALID_I                : IN  STD_LOGIC;
    USER_AWADDR_I                    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
    USER_WDATA_I                     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);    
    USER_ARADDR_I                    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);    
    USER_RDATA_O                     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    RCONST_O                         : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    GCONST_O                         : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    BCONST_O                         : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    SECOND_CONST_O                   : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)    
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
AXI4LITE_SUB_BLK_INST: AXI4LITE_SUB_BLK_IE
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

AXI4LITE_USR_BLK_INST: AXI4LITE_USR_BLK_IE
PORT MAP(
    RESETN_I                           =>    AXI_RESETN_I,                                    
    CLK_I                              =>    AXI_CLK_I,       
    USER_DATA_VALID_I                  =>    s_user_data_valid,          
    USER_AWADDR_I                      =>    s_user_awaddr,               
    USER_WDATA_I                       =>    s_user_wdata,                  
    USER_ARADDR_I                      =>    s_user_araddr,                   
    USER_RDATA_O                       =>    s_user_rdata,
    RCONST_O                           =>    RCONST_O,                   
    GCONST_O                           =>    GCONST_O,                   
    BCONST_O                           =>    BCONST_O,                   
    SECOND_CONST_O                     =>    SECOND_CONST_O   
   
);
END ARCHITECTURE AXI4Lite_IF_IE; 
--=================================================================================================
-- File Name                           : AXI4LITE_SUB_BLK_IE.vhd

-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2023 BY MICROCHIP
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
-- AXI4LITE_SUB_BLK_IE entity declaration
--=================================================================================================
ENTITY AXI4LITE_SUB_BLK_IE IS
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
END AXI4LITE_SUB_BLK_IE;
--=================================================================================================
-- AXI4LITE_SUB_BLK_IE architecture body
--=================================================================================================
ARCHITECTURE AXI4LITE_SUB_BLK_IE OF AXI4LITE_SUB_BLK_IE IS
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
RLAST_O           <= '0';
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
			IF ( AWBURST_I = "01" and AWVALID_I = '1')THEN
                BRESP_O   <= "00";
			ELSE
				BRESP_O   <= "10";
			END IF;
	    	    s_arready <= '1';
	    END IF;
	END PROCESS;         
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
END ARCHITECTURE AXI4LITE_SUB_BLK_IE;
--=================================================================================================
-- File Name                           : AXI4LITE_USR_BLK_IE.vhd

-- Targeted device                     : Microchip-SoC
-- Author                              : India Solutions Team
--
-- COPYRIGHT 2023 BY MICROCHIP
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
-- AXI4LITE_USR_BLK_IE entity declaration
--=================================================================================================
ENTITY AXI4LITE_USR_BLK_IE IS
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
      
    RCONST_O                         : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    --	                                   
    GCONST_O                         : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    --	                                   
    BCONST_O                         : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    --	                                   
    SECOND_CONST_O                   : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
    
);
END AXI4LITE_USR_BLK_IE;
--=================================================================================================
-- AXI4LITE_USR_BLK_IE architecture body
--=================================================================================================
ARCHITECTURE AXI4LITE_USR_BLK_IE OF AXI4LITE_USR_BLK_IE IS
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
CONSTANT C_RCONST_REG_ADDR             : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"004";
CONSTANT C_GCONST_REG_ADDR             : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"008";
CONSTANT C_BCONST_REG_ADDR             : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"00C";
CONSTANT C_SECOND_CONST_ADDR           : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"010";
CONSTANT C_USER_ADDR_0                 : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"040";
CONSTANT C_USER_ADDR_1                 : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"044";
SIGNAL   s_user_data_0                 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   s_user_data_1                 : STD_LOGIC_VECTOR(31 DOWNTO 0);
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
BEGIN
--------------------------------------------------------------------------
-- Name       : READ_DECODE_PROC
-- Description: Process implements the AXI4 read operation
--------------------------------------------------------------------------
WRITE_DECODE_PROC:
    PROCESS (RESETN_I, CLK_I)
    BEGIN
        IF(RESETN_I = '0')THEN
            RCONST_O        <= "00"&x"7F";
            GCONST_O        <= "00"&x"7F";
            BCONST_O        <= "00"&x"7F";
			s_user_data_0   <= x"01234567";
			s_user_data_1   <= x"89abcdef";
            SECOND_CONST_O  <= (OTHERS => '0');
			
        ELSIF (CLK_I'EVENT AND CLK_I = '1') THEN
		    IF ( USER_DATA_VALID_I = '1' ) THEN
                CASE USER_AWADDR_I(11 DOWNTO 0)  IS
--------------------
-- C_RCONST_REG_ADDR
--------------------
                    WHEN C_RCONST_REG_ADDR =>
                        RCONST_O <= USER_WDATA_I(9 DOWNTO 0);
--------------------
-- C_GCONST_REG_ADDR
--------------------
                    WHEN C_GCONST_REG_ADDR =>
                        GCONST_O <= USER_WDATA_I(9 DOWNTO 0);
--------------------
-- C_BCONST_REG_ADDR
--------------------
                    WHEN C_BCONST_REG_ADDR =>
                        BCONST_O <= USER_WDATA_I(9 DOWNTO 0);

--------------------
-- C_SECOND_CONST_ADDR
--------------------
                    WHEN C_SECOND_CONST_ADDR =>
                        SECOND_CONST_O <= USER_WDATA_I(19 DOWNTO 0);
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
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : READ_DECODE_PROC
-- Description: Process implements the AXI4 write operation
--------------------------------------------------------------------------
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
END ARCHITECTURE AXI4LITE_USR_BLK_IE;
-- ********************************************************************/ 
-- Microchip Corporation Proprietary and Confidential 
-- Copyright 2020 Microchip Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE MICROCHIP LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
-- Revision Information:	1.0
-- Date:				    01/22/2020
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
ENTITY AXI4S_INITIATOR_IE IS
GENERIC(
-- Generic List
	-- Specifies the R, G, B pixel data width
	G_PIXEL_WIDTH         : INTEGER RANGE 8 To 96 := 8;
	
	G_PIXELS			  : INTEGER := 1
);
PORT (
-- Port List   
    RESETN_I 							: IN STD_LOGIC;
	
	SYS_CLK_I 							: IN STD_LOGIC;
	-- R, G, B Data Input
    DATA_I                           	: IN STD_LOGIC_VECTOR(3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
	
	EOF_I								: IN STD_LOGIC;
   
    -- Specifies the input data is valid or not
    DATA_VALID_I                       	: IN STD_LOGIC;
	
	TUSER_O								: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	TLAST_O								: OUT STD_LOGIC;
    
    -- Data input
    TDATA_O                       		: OUT STD_LOGIC_VECTOR(3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
	
	TSTRB_O                             : OUT STD_LOGIC_VECTOR(G_PIXEL_WIDTH/8 - 1 DOWNTO 0);
	
    TKEEP_O                             : OUT STD_LOGIC_VECTOR(G_PIXEL_WIDTH/8 - 1 DOWNTO 0);
	-- Specifies the valid control signal
    TVALID_O                       		: OUT STD_LOGIC
    
);
END AXI4S_INITIATOR_IE;
--=================================================================================================
-- Architecture body
--=================================================================================================
ARCHITECTURE AXI4S_INITIATOR_IE OF AXI4S_INITIATOR_IE IS
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
SIGNAL  s_data_dly1             : STD_LOGIC_VECTOR(3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
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
END AXI4S_INITIATOR_IE;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
--=================================================================================================
-- AXI4S_SLAVE entity declaration
--=================================================================================================
-- Takes AXI4S and converts to native video interface data
ENTITY AXI4S_TARGET_IE IS
GENERIC(
-- Generic List
	-- Specifies the R, G, B pixel data width
	G_PIXEL_WIDTH         : INTEGER RANGE 8 To 96 := 8;
	
	G_PIXELS			  : INTEGER := 1
);
PORT (
-- Port List 
    -- Data input
    TDATA_I                       		: IN STD_LOGIC_VECTOR(3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
    
	-- Specifies the valid control signal
    TVALID_I                       		: IN STD_LOGIC;
	
	TUSER_I								: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	TREADY_O                            : OUT STD_LOGIC;
	
	EOF_O								: OUT STD_LOGIC;
    
	-- R, G, B Data Output
	DATA_O                           	: OUT STD_LOGIC_VECTOR(3*G_PIXELS*G_PIXEL_WIDTH-1 DOWNTO 0);
   
    -- Specifies the output data is valid or not
    DATA_VALID_O                       	: OUT STD_LOGIC    
	
);
END AXI4S_TARGET_IE;
--=================================================================================================
-- Architecture body
--=================================================================================================
ARCHITECTURE AXI4S_TARGET_IE OF AXI4S_TARGET_IE IS
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
DATA_O 				<= TDATA_I;
DATA_VALID_O		<= TVALID_I;
EOF_O				<= TUSER_I(0);
TREADY_O			<= '1';
--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA--
END AXI4S_TARGET_IE;
