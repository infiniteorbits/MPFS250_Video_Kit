/*****************************************************************************************************************************
--
--    File Name    : Image_Scaler_tb.v 

--    Description  : This module provides the test environment for Image & Video Scaler IP.	
					 For testing this IP, inputs should come from Bayer IP and then outputs should be 
					 connected to DDR Write HDMI RX module.
					 
--                   The following file is required for the simulation :
					 RGB_in.txt -->  It contains hex values which are in the following format: 
									 First 2 bytes width of the image, next 2 bytes height of the image.
									 Then follows B,G and R values.
									 For more details visit Microsemi Video Web Page. 

-- Targeted device : Microchip-SoC                     
-- Author          : India Solutions Team
-- SVN Revision Information:
-- SVN $Revision: TBD
-- SVN $Date: TBD
-- COPYRIGHT 2022 BY MICROCHIP
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS 
-- FROM MICROCHIP CORP.  IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM 
-- MICROCHIP FOR USE OF THIS FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND 
-- NO BACK-UP OF THE FILE SHOULD BE MADE. 
-- 

--******************************************************************************************************************************/
`timescale 1ns/1ps
module image_scaler_test;

  /* 
  
  NOTE 1: SCALE FACTOR CALCULATIONS
  
  Formula:
  SCALE_FACTOR_HORZ_I = floor((HORZ_RES_IN_I-1)*1024/HORZ_RES_OUT_I);
  SCALE_FACTOR_HORZ_I = floor((VERT_RES_IN_I-1)*1024/VERT_RES_OUT_I);
    
  Example:
  SCALE_FACTOR_HORZ_I = floor((959*1024/1280) = 767 	// MUST ROUND DOWN
  SCALE_FACTOR_VERT_I = floor((539*1024/720)  = 766 
   
  NOTE 2: IMAGE SCALER INSTANTIATION - FIFO SETTINGS (USING CONFIGURATOR GUI)
  
  G_INPUT_FIFO_AWIDTH, G_OUTPUT_FIFO_AWIDTH must be selected to hold one complete input and output image rows respectively
  2^(G_INPUT_FIFO_AWIDTH) must be sufficient to store one entire row of input image. 
  2^(G_OUTPUT_FIFO_AWIDTH) must be sufficient to store one entire row of output image.
  Update HORZ_RES_IN_I, HORZ_RES_OUT_I, VERT_RES_IN_I, VERT_RES_OUT_I, SCALE_FACTOR_HORZ_I, SCALE_FACTOR_VERT_I based on desired configuration
  
  */

  /************************************************************************
          Parameters 
  *************************************************************************/
  parameter HORZ_RES_IN = 960;			// input image
  parameter VERT_RES_IN = 540;		
  parameter HORZ_RES_OUT = 1280;	        // output image
  parameter VERT_RES_OUT = 720;
  parameter [15:0] SCALE_FACTOR_HORZ_I = 767; 	// must round down - see NOTE 1 for formula
  parameter [15:0] SCALE_FACTOR_VERT_I = 766;   // must round down - see NOTE 1 for formula
  parameter SYSCLKPERIOD = 25; 					// must match pixel clock frequency of input image
  parameter IPCLKPERIOD = 5.56; 				// desired freq of operation for Scaler IP [Default: 180MHz]
  parameter BLANK_PER = VERT_RES_IN/5;			// blanking period between consecutive rows - defaults to 20% of row length
  parameter INPUT_IMG_FILE_NAME  = "Input_Image_960_540.txt";  // input image pixels
  parameter OUTPUT_IMG_FILE_NAME = "Scaled_Up_1_3X_1280_720.txt";	// name of file to store scaled output image
  
  //Parameters from the DUT
  parameter g_DATAWIDTH = 8;			// fixed at 8-bit width
  parameter DATA_BIT_WIDTH = 24; 		// pixel width R+G+B
  localparam MAX_SIZE = (HORZ_RES_IN * VERT_RES_IN * (DATA_BIT_WIDTH / g_DATAWIDTH));
  localparam MAX_SIZE_24 = (HORZ_RES_IN * VERT_RES_IN);
  
  /************************************************************************
          Inputs and Outputs to the DUT 
  *************************************************************************/
  reg Clock, IPClock;
  reg Reset;
  reg dataValidIn_rgb;
  reg[g_DATAWIDTH - 1 : 0] data_in_R;
  reg[g_DATAWIDTH - 1 : 0] data_in_G;
  reg[g_DATAWIDTH - 1 : 0] data_in_B;
  wire[g_DATAWIDTH - 1 : 0] data_out_R;
  wire[g_DATAWIDTH - 1 : 0] data_out_G;
  wire[g_DATAWIDTH - 1 : 0] data_out_B;
  reg[g_DATAWIDTH - 1 : 0] image_8[MAX_SIZE - 1 : 0];
  reg[DATA_BIT_WIDTH - 1 : 0] imageR[MAX_SIZE_24 - 1 : 0];
  reg[DATA_BIT_WIDTH - 1 : 0] imageG[MAX_SIZE_24 - 1 : 0];
  reg[DATA_BIT_WIDTH - 1 : 0] imageB[MAX_SIZE_24 - 1 : 0];
  integer i,
          j_rgb,
		  File_1;
  reg[32 : 0] counter_h_rgb,
              counter_v_rgb,
              counter_h_in_rgb,
              counter_v_in_rgb;
  wire dataValidOut_scaler;
  reg[31 : 0] counter_num_frames;

  initial
    begin
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      $display(">>>>>>>>            IMAGE SCALAR IP SIMULATION STARTED                      <<<<<<<");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      Reset = 0;
      Clock = 0;
	  IPClock = 0;
      dataValidIn_rgb = 0;
      j_rgb = 0;
      counter_v_in_rgb = 0;
      counter_h_in_rgb = 0;
      counter_v_rgb = 0;
      counter_h_rgb = 0;
	  counter_num_frames = 0;
    end
  /************************************************************************
          Generates Clock signal
  *************************************************************************/
  initial
    begin
      forever
        #(SYSCLKPERIOD / 2)
        Clock = ~Clock;
    end
  initial
    begin
      forever
        #(IPCLKPERIOD / 2)
        IPClock = ~IPClock;
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
      $readmemh(INPUT_IMG_FILE_NAME, image_8);
      for (i = 0; i < MAX_SIZE_24; i = i + 1)
        begin
          //image_24[i] = ({ 16'b0, image_8[i * 3 + 3] } << 16) | ({ 16'b0, image_8[i * 3 + 2] } << 8) | (image_8[i * 3 + 1]);
          imageR[i] = image_8[i * 3];
          imageG[i] = image_8[i * 3 + 1];
          imageB[i] = image_8[i * 3 + 2];
        end
      $display("");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      $display(">>>>>>>>                            IMAGE LOADED                                    <<<<<<<");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

    end

  /************************************************************************
  Debug Signals: Output horizontal counter and output vertical counter
  *************************************************************************/
   initial
    begin
      forever
        @(posedge IPClock)
        begin
          if (counter_h_rgb == (HORZ_RES_OUT))
            begin
              counter_h_rgb = 0;
              counter_v_rgb = counter_v_rgb + 1;
            end
          else
            if (dataValidOut_scaler)
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
          if (counter_h_in_rgb == (HORZ_RES_IN))
            begin
              counter_v_in_rgb = counter_v_in_rgb + 1;
            end
          else
            counter_v_in_rgb = counter_v_in_rgb;
        end
    end
  /**************************************************************************
  Task to give the input (image) row after row with some delay between them
  ***************************************************************************/
  task read_image_delay_after_each_line_rgb;
    begin
      if (counter_v_in_rgb == (VERT_RES_IN))
        begin
          dataValidIn_rgb = 0;
		  counter_num_frames = counter_num_frames + 1;
		  //counter_v_in_rgb = 0; // enables continuous frames - comment the line to enable single frame
		  //j_rgb = 0;
		  counter_h_in_rgb = 0;
		  wait_for_next_line_rgb();
		  done_processing;
        end
      else
        begin
          if ((counter_h_in_rgb == (HORZ_RES_IN)) && (Reset == 1))
            begin
              dataValidIn_rgb = 0;
              counter_h_in_rgb = 0;
              wait_for_next_line_rgb();
            end
          else
            begin
              if ((counter_h_in_rgb < (HORZ_RES_IN)) && (Reset == 1))
                begin
                  dataValidIn_rgb = 1;
                  /* if(counter_h_in_rgb <(HORZ_RES_IN/2))
                   begin
                    data_in_G <= 0;
                    data_in_R <= 0;
                    data_in_B <= 0;
                   end
                  else 
                   begin
                    data_in_R <= 8'hff;
                    data_in_G <= 8'hff;
                    data_in_B <= 8'hff;
                   end  */
                
				  data_in_R = imageR[j_rgb];
                  data_in_G = imageG[j_rgb];
                  data_in_B = imageB[j_rgb];
                  
                  j_rgb = j_rgb + 1;
                  counter_h_in_rgb = counter_h_in_rgb + 1;
                end
            end
        end
    end
  endtask
  /************************************************************************
  Task to define the amount of delay between two rows of input (image)
  *************************************************************************/
  task wait_for_next_line_rgb;
    begin
      repeat (BLANK_PER)
        @(posedge Clock)
        ;
    end
  endtask

  /************************************************************************
  Task to check if output image is completely received
  *************************************************************************/
task done_processing;
    begin
      if (counter_v_rgb == VERT_RES_OUT)
	  //if (counter_num_frames == 3) // processed 3 frames using same image
        begin
          final_one;
        end
    end
  endtask
  task final_one;
    begin
	  repeat (2)
        @(posedge IPClock)
        ;
      $display("");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      $display(">>>>>>>>              SIMULATION COMPLETED                                          <<<<<<<");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      $finish;
    end
  endtask
  /************************************************************************
  Process to write the output scaled image into a file
  *************************************************************************/
  initial
    begin
	     File_1 = $fopen(OUTPUT_IMG_FILE_NAME,"wb");
      forever
        @(posedge IPClock)
        begin
          if (dataValidOut_scaler)
            begin
	      $fwrite(File_1,"%x\n",data_out_R);
	      $fwrite(File_1,"%x\n",data_out_G);
	      $fwrite(File_1,"%x\n",data_out_B);
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
  IMAGE_SCALER_Native  #(.G_DATA_WIDTH(g_DATAWIDTH), .G_INPUT_FIFO_AWIDTH(10), .G_OUTPUT_FIFO_AWIDTH(11))  Image_Scaler_0(.RESETN_I(Reset), 
                                                                                 .SYS_CLK_I(Clock),	
																				 .IP_CLK_I(IPClock),
                                                                                 .HORZ_RES_IN_I(HORZ_RES_IN[12:0]),				
                                                                                 .VERT_RES_IN_I(VERT_RES_IN[12:0]),		
                                                                                 .HORZ_RES_OUT_I(HORZ_RES_OUT[12:0]), 		
                                                                                 .VERT_RES_OUT_I(VERT_RES_OUT[12:0]),			
                                                                                 .SCALE_FACTOR_HORZ_I(SCALE_FACTOR_HORZ_I), 	
                                                                                 .SCALE_FACTOR_VERT_I(SCALE_FACTOR_VERT_I),
                                                                                 .DATA_VALID_I(dataValidIn_rgb),
																				 .DATA_R_I(data_in_R),
                                                                                 .DATA_G_I(data_in_G),
                                                                                 .DATA_B_I(data_in_B),
                                                                                 .DATA_VALID_O(dataValidOut_scaler),
																				 .DATA_R_O(data_out_R),
                                                                                 .DATA_G_O(data_out_G),
                                                                                 .DATA_B_O(data_out_B)
																				);

endmodule
