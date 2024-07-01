/*****************************************************************************************************************************
--
--    File Name    : Gamma_Correction_tb.v 

--    Description  : This module provides the test environment for Gamma correction IP.
					 Gamma factor is constant 0.454
						
					 For testing this IP, inputs should come from Bayer Interpolation IP and then outputs should be 
					 connected to RGBtoYCbCr IP.
					 
--                   The following file is required for the simulation :
					 Lighting_RGB.txt -->  It contains hex values which are in the following format: 
										   First 2 bytes width of the image, next 2 bytes height of the image.
										   Then follows B,G and R values.
										   For more details visit Microsemi Video Web Page. 

-- Targeted device : Microsemi-SoC                     
-- Author          : India Solutions Team

-- COPYRIGHT 2020 BY MICROSEMI 
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS 
-- FROM MICROSEMI CORP.  IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM 
-- MICROSEMI FOR USE OF THIS FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND 
-- NO BACK-UP OF THE FILE SHOULD BE MADE. 
-- 

--******************************************************************************************************************************/
`timescale 1ns/1ns
module gamma_correction_test;
  /************************************************************************
          Parameters 
  *************************************************************************/
  parameter HEIGHT = 400;
  parameter WIDTH = 640;
  parameter CLKPERIOD = 4;
  parameter WAIT = 0;
  parameter DATA_BIT_WIDTH = 24; //pixel width
  parameter IMAGE_FILE_NAME = "CFA_RGB_in.txt";  
  //Parameters from the DUT
  parameter g_RGB_DATA_BIT_WIDTH = 8;
  parameter g_YCbCr_DATA_BIT_WIDTH = 8;
  parameter g_DATAWIDTH = 8;
  parameter g_rgb_DATAWIDTH = 24;
  parameter g_X_RES_WIDTH = 11;
  localparam MAX_SIZE = (HEIGHT * WIDTH * (DATA_BIT_WIDTH /g_DATAWIDTH )) + 4;
  localparam MAX_SIZE_24 = (HEIGHT * WIDTH) + 1;
  /************************************************************************
          Inputs and Outputs to the DUT 
  *************************************************************************/
  reg Clock;
  reg Reset;
  reg dataValidIn_rgb;
  reg H_sync_in;
  reg V_sync_in;
  reg H_active_in;
  reg V_active_in;
  reg[g_rgb_DATAWIDTH - 1 : 0] data_in;
  wire[g_rgb_DATAWIDTH - 1 : 0] data_out;
  reg[g_DATAWIDTH - 1 : 0] image_8[MAX_SIZE - 1 : 0];
  reg[DATA_BIT_WIDTH - 1 : 0] image_24[MAX_SIZE_24 - 1 : 0];
  integer i,
          j_rgb,
	  File_1;
  reg[32 : 0] counter_h_rgb,
              counter_v_rgb,
              counter_h_in_rgb,
              counter_v_in_rgb;
  reg[g_DATAWIDTH - 1 : 0] Yin;
  wire dataValidOut_gamma;
  reg[31 : 0] counter_h_sobel,
              counter_v_sobel,
              counter_h_in_sobel,
              counter_v_in_sobel;
  reg[g_DATAWIDTH - 1 : 0] Y;
  reg[g_DATAWIDTH - 1 : 0] Cb;
  reg[g_DATAWIDTH - 1 : 0] Cr;
  integer k_y2r,
          l,
          m,
		  k_bayer;
  reg[31 : 0] counter_h_y2r,
              counter_v_y2r,
              counter_h_in_y2r,
              counter_v_in_y2r;
  initial
    begin
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      $display(">>>>>>>>            IMAGE DENOISE DETECTION IP SIMULATION STARTED                      <<<<<<<");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      Reset = 0;
      Clock = 0;
      H_sync_in = 0;
      V_sync_in = 0;
      H_active_in = 0;
      V_active_in = 0;
      dataValidIn_rgb = 0;
      j_rgb = 1;
      counter_v_in_rgb = 0;
      counter_h_in_rgb = 0;
      counter_v_rgb = 0;
      counter_h_rgb = 0;
      Yin = 0;
      counter_v_sobel = 0;
      counter_h_sobel = 0;
      counter_v_in_sobel = 0;
      counter_h_in_sobel = 0;
      Y = 0;
      Cb = 0;
      Cr = 0;
      k_y2r = 0;
	  k_bayer = 0;
      l = 0;
      m = 0;
      counter_v_y2r = 0;
      counter_h_y2r = 0;
      counter_v_in_y2r = 0;
      counter_h_in_y2r = 0;
    end
  /************************************************************************
          Generates Clock signal
  *************************************************************************/
  initial
    begin
      forever
        #(CLKPERIOD / 2)
        Clock = ~Clock;
    end
  /************************************************************************
          RESET : Generates a Reset pulse 
  *************************************************************************/
  initial
    begin
      Reset = 1;
      #4
      Reset = 0;
      #2
      Reset = 1;
    end
  /************************************************************************
          Read the input image 
  *************************************************************************/
  initial
    begin
      $readmemh(IMAGE_FILE_NAME, image_8);
      for (i = 0; i < MAX_SIZE_24; i = i + 1)
        begin
         //image_24[i] = ({ 16'b0, image_8[i * 3 + 3] } << 16) | ({ 16'b0, image_8[i * 3 + 2] } << 8) | (image_8[i * 3 + 1]);
         image_24[i] = ({ 16'b0, image_8[i * 3 + 3] } << 16) | ({ 16'b0, image_8[i * 3 + 2] } << 8) | (image_8[i * 3 + 1]);
        end
      $display("");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      $display(">>>>>>>>                            IMAGE LOADED                                    <<<<<<<");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    end
  /************************************************************************
  *********************RGB to YCbCr Conversion Starts**********************
  *************************************************************************/
  /************************************************************************
  Debug Signals: Output horizontal counter and output vertical counter
  *************************************************************************/
  initial
    begin
      forever
        @(posedge Clock)
        begin
          if (counter_h_rgb == (WIDTH))
            begin
              counter_h_rgb = 0;
              counter_v_rgb = counter_v_rgb + 1;
            end
          else
            if (dataValidOut_gamma)
              counter_h_rgb = counter_h_rgb + 1;
        end
    end
  /************************************************************************
  Debug Signals: Input horizontal counter and input vertical counter
  *************************************************************************/
  initial
    begin
      forever
        @(counter_h_in_rgb)
        begin
          if (counter_h_in_rgb == (WIDTH))
            begin
              counter_v_in_rgb = counter_v_in_rgb + 1;
            end
          else
            counter_v_in_rgb = counter_v_in_rgb;
        end
    end
  /**************************************************************************
  Task to give the input (image) line after line with some delay between them
  ***************************************************************************/
  task read_image_delay_after_each_line_rgb;
    begin
      if (counter_v_in_rgb == (HEIGHT))
        begin
          dataValidIn_rgb = 0;
		  //counter_v_in_rgb = 0;
		  counter_h_in_rgb = 0;
		  wait_for_next_line_rgb();
		  done_processing;
        end
      else
        begin
          if ((counter_h_in_rgb == (WIDTH)) && (Reset == 1))
            begin
              dataValidIn_rgb = 0;
              counter_h_in_rgb = 0;
              wait_for_next_line_rgb();
            end
          else
            begin
              if ((counter_h_in_rgb < (WIDTH)) && (Reset == 1))
                begin
                  dataValidIn_rgb = 1;
                  //data_in = (image_24[j_rgb][7 : 0] + image_24[j_rgb][15 : 8] + image_24[j_rgb][23 : 16])/3;
                  data_in = (image_24[j_rgb][23 : 0]);
                  j_rgb = j_rgb + 1;
                  counter_h_in_rgb = counter_h_in_rgb + 1;
                end
            end
        end
    end
  endtask
  /************************************************************************
  Task to define the amount of delay between two lines of input (image)
  *************************************************************************/
  task wait_for_next_line_rgb;
    begin
      repeat (WAIT)
        @(posedge Clock)
        ;
    end
  endtask

  /************************************************************************
  Task to check height of output image
  *************************************************************************/
task done_processing;
    begin
      if (counter_v_rgb == HEIGHT)
        begin
          final_one;
        end
    end
  endtask
  task final_one;
    begin
	  repeat (2)
        @(posedge Clock)
        ;
      $display("");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      $display(">>>>>>>>              SIMULATION COMPLETED                                          <<<<<<<");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      $finish;
    end
  endtask
  /************************************************************************
  Process to write the output RGB into a memory
  *************************************************************************/
  initial
    begin
	     File_1 = $fopen("CFA_RGB_out.txt","wb");
      forever
        @(posedge Clock)
        begin
          if (dataValidOut_gamma)
            begin
	      $fwrite(File_1,"%x\n",data_out[7:0]  );
	      $fwrite(File_1,"%x\n",data_out[15:8] );
	      $fwrite(File_1,"%x\n",data_out[23:16]);
		  k_bayer = k_bayer + 1;
            end
        end
	$fclose(File_1);
    end
 
  /************************************************************************
  *************Process to initiate the testbench***************************
  *************************************************************************/
  initial
    begin
      $display("");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      $display(">>>>>>>>                          PROCESSING OF IMAGE STARTED                       <<<<<<<");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      forever
        @(posedge Clock)
        begin
         
          read_image_delay_after_each_line_rgb;
        end
    end
  /************************************************************************
  Component instantiation
  *************************************************************************/

  Gamma_Correction_Native #(.G_DATA_WIDTH(g_DATAWIDTH)) Gamma_Correction_0(
																	.RESETN_I(Reset),
																	.SYS_CLK_I(Clock),
																	.DATA_VALID_I(dataValidIn_rgb),
																	.RED_I(data_in[7:0]  ),
																	.GREEN_I(data_in[15:8] ),
																	.BLUE_I(data_in[23:16]),
																	.DATA_VALID_O(dataValidOut_gamma),
																	.RED_O(data_out[7:0]  ),
																	.GREEN_O(data_out[15:8] ),
																	.BLUE_O(data_out[23:16])
																	);

endmodule
