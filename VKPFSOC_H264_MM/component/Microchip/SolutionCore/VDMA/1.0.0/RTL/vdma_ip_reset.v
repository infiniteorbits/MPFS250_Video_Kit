//=================================================================================================
//-- File Name                           : vdma_ip_reset.v
//-- Targeted device                     : Microsemi-SoC
//-- Author                              : India Solutions Team
//--
//-- COPYRIGHT 2021 BY MICROSEMI
//-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
//-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
//-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
//--
//=================================================================================================

module vdma_ip_reset
  (

   input      video_source_clk_rstn_i,
   input      video_source_clk_i,
   input      ddr_clk_rstn_i,
   input      ddr_clk_i,
   input      aclk_i,
   input      aclk_rstn_i,
   input      fifo_rstn_i,
   input      vdma_ip_rstn_i,

   output reg aclk_rstn_o,
   output reg ddr_clk_rstn_o,
   output     fifo_rstn_o,
   output reg video_source_clk_rstn_o
   );

   wire       w_aclk_rstn;
   wire       w_video_source_clk_rstn;
   wire       w_ddr_clk_rstn;
   

   assign w_aclk_rstn = vdma_ip_rstn_i & aclk_rstn_i;
   assign w_video_source_clk_rstn = vdma_ip_rstn_i & video_source_clk_rstn_i;
   assign w_ddr_clk_rstn = vdma_ip_rstn_i & ddr_clk_rstn_i;
   assign fifo_rstn_o = vdma_ip_rstn_i & fifo_rstn_i;
   
   //--------synchronizer_circuit_2stage_vdma
   synchronizer_circuit_2stage_vdma synchronizer_circuit_2stage_aclk
     (
      // Inputs
      .rstn_i     ( aclk_rstn_i ),
      .sys_clk_i  ( aclk_i ),
      .data_in_i  ( w_aclk_rstn ),
      // Outputs
      .sync_out_o ( aclk_rstn_o ) 
      );

   //--------synchronizer_circuit_2stage_vdma
   synchronizer_circuit_2stage_vdma synchronizer_circuit_2stage_ddr_clk
     (
      // Inputs
      .rstn_i     ( ddr_clk_rstn_i ),
      .sys_clk_i  ( ddr_clk_i ),
      .data_in_i  ( w_ddr_clk_rstn ),
      // Outputs
      .sync_out_o ( ddr_clk_rstn_o ) 
      );

   //--------synchronizer_circuit_2stage_vdma
   synchronizer_circuit_2stage_vdma synchronizer_circuit_2stage_video_clk
     (
      // Inputs
      .rstn_i     ( video_source_clk_rstn_i ),
      .sys_clk_i  ( video_source_clk_i ),
      .data_in_i  ( w_video_source_clk_rstn ),
      // Outputs
      .sync_out_o ( video_source_clk_rstn_o ) 
      );


endmodule
