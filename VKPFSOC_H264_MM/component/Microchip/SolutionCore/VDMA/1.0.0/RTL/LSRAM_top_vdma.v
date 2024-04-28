//--=================================================================================================
//-- File Name                           : LSRAM_top_vdma.v
//-- Targeted device                     : Microsemi-SoC
//-- Author                              : India Solutions Team
//--
//-- COPYRIGHT 2019 BY MICROSEMI
//-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
//-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
//-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
//--
//--=================================================================================================
`timescale 1 ns/100 ps
module LSRAM_top_vdma(
       W_DATA,
       R_DATA,
       W_ADDR,
       R_ADDR,
       W_EN,
       R_EN,
       CLK
    );
   // --------------------------------------------------------------------------
   // PARAMETER Declaration
   // --------------------------------------------------------------------------	
parameter                RWIDTH        = 32;  // Read  port Data Width
parameter                WWIDTH        = 32;  // Write port Data Width
parameter                RDEPTH        = 128; // Read  port Data Depth
parameter                WDEPTH        = 128; // Write port Data Depth
//RWIDTH must be same as WWIDTH, RDEPTH must be same as WDEPTH
   // --------------------------------------------------------------------------
   // I/O Declaration
   // --------------------------------------------------------------------------
input  [RWIDTH-1:0] W_DATA;
output [WWIDTH-1:0] R_DATA;
input  [WDEPTH-1:0] W_ADDR;
input  [RDEPTH-1:0] R_ADDR;
input  W_EN;
input  R_EN;
input  CLK;

   // --------------------------------------------------------------------------
   // Internal signals
   // --------------------------------------------------------------------------
localparam RAM_DEPTH = 2**RDEPTH;
reg [RWIDTH-1 :0] pf_ram[RAM_DEPTH-1 :0];
reg [RWIDTH-1 :0] ram_data_reg;
assign R_DATA = ram_data_reg;
 
always@(posedge CLK)
begin
    if(W_EN)
        pf_ram[W_ADDR]<= W_DATA;     
    if(R_EN)
        ram_data_reg <= pf_ram[R_ADDR];   
end

endmodule



