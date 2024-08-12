/*****************************************************************************************************************************
--
--    File Name    : Bayer_Conversion_tb.v 

--    Description  : This module provides the test environment for Bayer Conversion IP
--                   
					 The following file is required for the simulation :
					 CFA_in.txt --> An image has to be converted to Bayer format which contains hex values.
								    For more details visit Microsemi Video Web Page
					 

-- Targeted device : Microsemi-SoC                     
-- Author          : India Solutions Team

-- SVN Revision Information:
-- SVN $Revision: TBD
-- SVN $Date: TBD
--
--
--
-- COPYRIGHT 2016 BY MICROSEMI 
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS 
-- FROM MICROSEMI CORP.  IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM 
-- MICROSEMI FOR USE OF THIS FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND 
-- NO BACK-UP OF THE FILE SHOULD BE MADE. 
-- 

--******************************************************************************************************************************/
module bayer_test;
  /************************************************************************
          Parameters 
  *************************************************************************/
  parameter CLKPERIOD = 10;
  parameter WAIT = 4;
  parameter IMAGE_FILE_NAME = "CFA_in.txt";  
 //Parameters from the DUT
  parameter g_DISPLAY_RESOLUTION = 640;
  parameter g_VERT_DISPLAY_RESOLUTION = 512;
  parameter g_DATAWIDTH = 8;
  parameter g_pixels = 1;
  localparam MAX_SIZE_8 = (g_VERT_DISPLAY_RESOLUTION * g_DISPLAY_RESOLUTION);
  localparam MAX_SIZE_32 = (g_VERT_DISPLAY_RESOLUTION * g_DISPLAY_RESOLUTION * 3);
  /************************************************************************
          Inputs and Outputs to the DUT 
  *************************************************************************/
  reg Clock;
  reg Reset;
  reg eof;
  wire eof_o;
  reg[2:0] indicator;
  reg[g_pixels * g_DATAWIDTH - 1 : 0] Data_In_i;
  reg dataValidIn;
  reg [1:0]bayer_format;
  wire[(g_pixels * g_DATAWIDTH) - 1 : 0] red_out;
  wire[(g_pixels * g_DATAWIDTH) - 1 : 0] green_out;
  wire[(g_pixels * g_DATAWIDTH) - 1 : 0] blue_out;
  wire rgbValidOut;
  reg[(g_pixels * g_DATAWIDTH) - 1 : 0] image_8[(MAX_SIZE_8 + 4) - 1 : 0];
  reg[3 : 0] count_done;
  reg[31 : 0] counter_h_out,
              counter_v_out,
              counter_h_in,
              counter_v_in;
  reg[2 : 0] counter_3;
  integer i,
          j,
		  k,
          k_bayer,
          m,
          l,
	  File_1;
  initial
    begin
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      $display(">>>>>>>>            BAYER CONVERSION IP SIMULATION STARTED                          <<<<<<<");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      dataValidIn = 0;
	  bayer_format = 2'd0;
      Clock = 0;
      m = 4;
      k_bayer = 0;
      l = 0;
      j = 4;
	  k = 4;
      i = 0;
	  indicator = 0;
      counter_h_in = 0;
      counter_v_in = 0;
	  eof = 1'b0;
      count_done = 0;
      counter_h_out = 0;
      counter_v_out = 0;
      counter_3 = 0;
    end
  /************************************************************************
          CLOCK_GEN : Generates 
  *************************************************************************/
  initial
    begin
      forever
        #(CLKPERIOD / 2)
        Clock = ~Clock;
    end
  /************************************************************************
          RESET : Generates a reset pulse 
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
      $display("");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      $display(">>>>>>>>                     IMAGE LOADED                                           <<<<<<<");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    end
  /************************************************************************
  Debug Signals: Output horizontal counter and output vertical counter
  *************************************************************************/
  initial
    begin
      forever
        @(posedge Clock)
        begin
          if (counter_h_out == (g_DISPLAY_RESOLUTION))
            begin
              counter_h_out = 0;
              counter_v_out = counter_v_out + 1;
            end
          else
            if (rgbValidOut)
              counter_h_out = counter_h_out + 1;
        end
    end
  /************************************************************************
  Debug Signals: Input horizontal counter and input vertical counter
  *************************************************************************/
  initial
    begin
      forever
        @(counter_h_in)
        begin
          if (counter_h_in == (g_DISPLAY_RESOLUTION))
            begin
              counter_v_in = counter_v_in + 1;
            end
          else
            counter_v_in = counter_v_in;
        end
    end
  /**************************************************************************
  Task to give the input (image) line after line with some delay between them
  ***************************************************************************/
  task read_image_delay_after_each_line;
    begin
      if (counter_v_in == (g_VERT_DISPLAY_RESOLUTION + 1))
        begin
          dataValidIn = 0;
		  eof = 1'b1;	
          counter_v_in = 0;
		  counter_h_in = 0;
		  
		  wait_for_next_line();
		  indicator = 1;		  
        end
      else
        begin
		
		  if ((counter_h_in == (g_DISPLAY_RESOLUTION)) && (Reset == 1))
			begin
			  dataValidIn = 0;
			  counter_h_in = 0;
			  wait_for_next_line();
			  eof = 0;
			end
		  else
			begin
			  if ((counter_h_in < (g_DISPLAY_RESOLUTION)) && (Reset == 1))
				begin
				  dataValidIn = 1;
				  Data_In_i = image_8[j];
					j = j + 1;
				  counter_h_in = counter_h_in + 1;
				end
			end
        end
    end
  endtask
  
    task read_image_delay_after_each_line1;
    begin
      if (counter_v_in == (g_VERT_DISPLAY_RESOLUTION+1))
        begin
		  dataValidIn = 0;
		  eof = 1'b1;	
          counter_v_in = 0;
		  counter_h_in = 0;
		  
		  wait_for_next_line();
		  indicator = 2;
		  
        end
      else
        begin
		
		  if ((counter_h_in == (g_DISPLAY_RESOLUTION)) && (Reset == 1))
			begin
			  dataValidIn = 0;
			  counter_h_in = 0;
			  wait_for_next_line();
			  eof = 0;
			end
		  else
			begin
			  if ((counter_h_in < (g_DISPLAY_RESOLUTION)) && (Reset == 1))
				begin
				  dataValidIn = 1;
				  Data_In_i = image_8[k];
					k = k + 1;
				  counter_h_in = counter_h_in + 1;
				end
			end
        end
    end
  endtask
  task read_image_delay_after_each_line2;
    begin
      if (counter_v_in == (g_VERT_DISPLAY_RESOLUTION+1))
        begin
          dataValidIn = 0;
          counter_v_in = counter_v_in;	
		  done_processing;
		  
        end
      else
        begin
		eof = 0;
		  if ((counter_h_in == (g_DISPLAY_RESOLUTION)) && (Reset == 1))
			begin
			  dataValidIn = 0;
			  counter_h_in = 0;
			  wait_for_next_line();
			  
			end
		  else
			begin
			  if ((counter_h_in < (g_DISPLAY_RESOLUTION)) && (Reset == 1))
				begin
				  dataValidIn = 1;
				  Data_In_i = image_8[m];
					m = m + 1;
				  counter_h_in = counter_h_in + 1;
				end
			end
        end
    end
  endtask
  /************************************************************************
  Task to define the amount of delay between two lines of input (image)
  *************************************************************************/
  task wait_for_next_line;
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
      if (counter_v_out == g_VERT_DISPLAY_RESOLUTION)
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
      $display(">>>>>>>>        \t\t\tSIMULATION COMPLETED\t    \t\t\t\t\t\t      <<<<<<<");
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
          if (rgbValidOut)
            begin
	      $fwrite(File_1,"%x\n",blue_out);
	      $fwrite(File_1,"%x\n",green_out);
	      $fwrite(File_1,"%x\n",red_out);
              k_bayer = k_bayer + 1;
            end
        end
	$fclose(File_1);
    end

  /************************************************************************
  Process to initiate the testbench
  *************************************************************************/
  initial
    begin
      $display("");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      $display(">>>>>>>>                    PROCESSING OF IMAGE STARTED                             <<<<<<<");
      $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
	end
    always
        @(posedge Clock)
        begin
			if(indicator == 0)
			begin
			  read_image_delay_after_each_line;
			end
			else
			begin
				if(indicator == 1)
				begin
					read_image_delay_after_each_line1;
				end
				else
				begin
					read_image_delay_after_each_line2;
				end
			end
		end
    	
  /************************************************************************
  Component instantiation
  *************************************************************************/
  Bayer_Native #(.G_DATA_WIDTH(g_DATAWIDTH), .G_RAM_SIZE(2048),.G_PIXELS(g_pixels)) bayer_0(.RESETN_I(Reset),
																						   .SYS_CLK_I(Clock),
																						   .DATA_VALID_I(dataValidIn),
																						   .EOF_I(eof),
																						   .DATA_I(Data_In_i),
																						   .BAYER_FORMAT(bayer_format),
																						   .RGB_VALID_O(rgbValidOut),
																						   .R_O(red_out),
																						   .G_O(green_out),
																						   .B_O(blue_out),
																						   .EOF_O(eof_o));
endmodule
