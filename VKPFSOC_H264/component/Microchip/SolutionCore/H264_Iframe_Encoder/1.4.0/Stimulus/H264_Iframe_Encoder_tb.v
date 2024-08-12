/*************************************************************************************************************************************
--
-- File Name    : H264_Iframe_Encoder_tb.v 
-- Description  : H264_Iframe_Encoder_tb 

-- COPYRIGHT 2021 BY MICROSEMI 
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS 
-- FROM MICROSEMI CORP.  IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM 
-- MICROSEMI FOR USE OF THIS FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND 
-- NO BACK-UP OF THE FILE SHOULD BE MADE. 
--
--*************************************************************************************************************************************/
`timescale 1ns/100ps
module H264_Iframe_Encoder_tb;

parameter SYSCLK_PERIOD     = 10;// 100MHZ
parameter g_DW              = 8;
parameter QUANT_QP          = 10;
parameter H_RES             = 224;
parameter V_RES             = 224;
parameter h_blanking        = 100;;
parameter v_blanking        = 45;
parameter N_FRAMES          = 2;

reg                         SYSCLK;
reg                         NSYSRESET;

wire [5  : 0]               Quant_QP;
reg  [15 : 0]               vert_resol;
reg  [15 : 0]               horiz_resol;

reg [g_DW-1:0]              Y_array[0:N_FRAMES*(H_RES*V_RES)-1];
reg [g_DW-1:0]              C_array[0:N_FRAMES*(H_RES*V_RES)-1];
reg  [23 :0]                addr_y;

reg                         data_valid;
reg [g_DW-1:0]              data_y;
reg [g_DW-1:0]              data_c;
wire                        data_valid_o;
wire [15 : 0]               data_o;

wire [15 : 0]               h_total;
wire [15 : 0]               v_total;
reg  [15 : 0]               h_counter;
reg  [15 : 0]               v_counter;
wire                        h_active;
wire                        v_active;
wire                        hv_active;
reg                         v_active_dly1;
wire                        v_active_re;
reg                         f_start;

reg                         frame_data_valid;
reg                         frame_valid;
reg                         frame_valid_dly1;
wire                        frame_valid_re;

reg                         frame_end;
reg                         frame_end_dly1;
wire                        frame_end_fe;
reg [10 : 0]                frame_end_fe_dly_arr;

reg [7 : 0]                 error;
reg [7 : 0]                 frame_counter;

reg [31:0]                  byte_counter;

reg [23 :0]                 refdata_addr;
reg [7 : 0]                 RefOut_array[0:2**17-1];

wire[7 : 0]                 diff;
wire[15 : 0]                data_ref;

integer                     File_1;
//////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////
initial
begin
    SYSCLK     = 1'b0;
    NSYSRESET  = 1'b0;
end

//////////////////////////////////////////////////////////////////////
// Reset Pulse
//////////////////////////////////////////////////////////////////////
initial
begin
    #(SYSCLK_PERIOD * 20 )
        NSYSRESET = 1'b1;
end

//////////////////////////////////////////////////////////////////////
// Clock Driver
//////////////////////////////////////////////////////////////////////
always @(SYSCLK)
    #(SYSCLK_PERIOD / 2.0) SYSCLK <= !SYSCLK;

/************************************************************************
	text input read
*************************************************************************/    
initial $readmemh("H264_sim_data_in_y.txt", Y_array);
initial $readmemh("H264_sim_data_in_c.txt", C_array);
initial $readmemh("H264_refOut.txt", RefOut_array);

/************************************************************************
	Assignments
*************************************************************************/
assign Quant_QP         =   QUANT_QP;
assign vert_resol       =   V_RES;
assign horiz_resol      =   H_RES; 

assign v_active_re     =   v_active & (~v_active_dly1);
/************************************************************************
    Process to generate
*************************************************************************/
always@(posedge SYSCLK, negedge NSYSRESET) begin 
    if(!NSYSRESET) begin 
        addr_y       <= 0;
        data_y       <= 0;
        data_c       <= 0;
        data_valid   <= 0;
    end
    else begin
        data_valid   <= frame_data_valid;
        if(frame_end) begin 
            data_y   <= 0;
            data_c   <= 0;
            //addr_y   <= 0; 
        end
        else if(frame_data_valid) begin
            data_y   <= Y_array[addr_y];
            data_c   <= C_array[addr_y];
            addr_y   <= addr_y + 1;
        end
        else begin 
            data_y   <= data_y;
            data_c   <= data_c;
            addr_y   <= addr_y;
        end
    end
end

/*=======================================================================
 Timing Generator		 
=======================================================================*/
/************************************************************************
 Asynchronous statemens : generating h_active, v_active and hv_active		 
*************************************************************************/
assign h_active         = (h_counter >= (h_blanking)) ? 1'b1 : 1'b0;
assign v_active         = (v_counter >= (v_blanking)) ? 1'b1 : 1'b0;
assign hv_active        = h_active & v_active;
assign v_total          = V_RES + v_blanking;
assign h_total          = H_RES + h_blanking;

assign  frame_end_fe    = (~frame_end) & (frame_end_dly1);
assign  frame_valid_re  = (frame_valid) & (~frame_valid_dly1);

/************************************************************************
Process to generates Horizontal counter				 
*************************************************************************/
always@(posedge SYSCLK, negedge NSYSRESET) begin 
    if(!NSYSRESET) begin 
        v_active_dly1  <= 0;
        f_start        <= 0;
    end
    else begin 
        v_active_dly1   <= v_active;
        if(v_active_re) begin 
            f_start     <= 1;
        end
    end
end
/************************************************************************
Process to generates Horizontal counter				 
*************************************************************************/
always@(posedge SYSCLK, negedge NSYSRESET) begin 
    if(!NSYSRESET) begin 
        h_counter <= 0;
    end
    else begin 
        if(h_counter == h_total-1) begin
            h_counter <= 0;
        end
        else begin 
            h_counter <= h_counter + 1;
        end
    end
end

/************************************************************************
Process to generates Vertical counter				 
*************************************************************************/
always@(posedge SYSCLK, negedge NSYSRESET) begin 
    if(!NSYSRESET) begin 
        v_counter <= 0;
    end
    else begin 
        if(h_counter == h_total-1) begin 
            if(v_counter == v_total-1) begin 
                v_counter <= 0;
            end
            else begin 
                v_counter <= v_counter + 1;
            end
        end
    end
end

/************************************************************************
Process to generates Veframe_data_valid, frame_valid and frame_end				 
*************************************************************************/
always@(posedge SYSCLK, negedge NSYSRESET) begin 
    if(!NSYSRESET) begin 
        frame_data_valid <= 0;
        frame_valid      <= 0;
        frame_end        <= 0;
    end
    else begin 
        if(v_counter >= v_blanking && v_counter <= v_total) frame_data_valid <= hv_active;
        else frame_data_valid <= 0;
        
        if(v_counter == 30) frame_valid <= 1;
        else frame_valid  <= 0;
        
        if(f_start ==1 && v_counter == 20) frame_end   <= 1;
        else frame_end  <= 0;
    end
end

always@(posedge SYSCLK, negedge NSYSRESET) begin 
    if(!NSYSRESET) begin 
        frame_end_dly1     	  <= 0;
        frame_end_fe_dly_arr  <= 0;
        frame_valid_dly1   	  <= 0;
    end
    else begin 
        frame_end_dly1       <= frame_end;
        frame_end_fe_dly_arr <= {frame_end_fe_dly_arr[9:0],frame_end_fe};
        frame_valid_dly1     <= frame_valid;;
    end
end

/************************************************************************
  Process to write the output into a file
*************************************************************************/  
  initial
    begin
      File_1 = $fopen("h264_sim_out.txt","w");
      byte_counter = 1; 
      forever @(posedge SYSCLK)
      begin
          if (data_valid_o)          
          begin
			$fwrite(File_1,"%x\n%x\n",data_o[15:8],data_o[7:0]);
            byte_counter = byte_counter + 2;
          end
			          		  
      end 	    
    end

//////////////////////////////////////////////////////////////////////
// Instantiate Unit Under Test:  H264_Iframe_Encoder
//////////////////////////////////////////////////////////////////////
H264_Iframe_Encoder_C0 H264_Iframe_Encoder_0 (
    // Inputs
    .PIX_CLK        ( SYSCLK          ),
    .RESET_N        ( NSYSRESET       ),
    .VRES_I         ( vert_resol      ),
    .HRES_I         ( horiz_resol     ),
    .QP_I           ( Quant_QP        ),
    .FRAME_START_I  ( frame_valid     ),
    .FRAME_END_I    ( frame_end       ),
    .DATA_VALID_I   ( data_valid      ),
    .DATA_Y_I       ( data_y          ),
    .DATA_C_I       ( data_c          ),
    // Outputs
    .DATA_VALID_O   ( data_valid_o    ),
    .DATA_O         ( data_o          )
    // Inouts
);



/************************************************************************
    Print simulation output
*************************************************************************/
assign data_ref = {RefOut_array[refdata_addr],RefOut_array[refdata_addr+1]};
assign diff = (data_valid_o == 1) ? data_o - data_ref : 0;

always@(posedge SYSCLK, negedge NSYSRESET) begin 
    if(!NSYSRESET) begin 
        refdata_addr        <= 0;
        error               <= 0;
    end
    else begin 
        if(frame_end_fe_dly_arr[10]) begin 
            error       <= 0;
        end
        else if(data_valid_o) begin 
            refdata_addr <= refdata_addr +2;
            if(diff == 0) begin 
                error   <= error;
            end
            else begin 
                error   <= error + 1;
            end
        end
    end
end


always@(posedge SYSCLK, negedge NSYSRESET) begin 
    if(!NSYSRESET) begin 
        error           <= 0;
        frame_counter   <= 0;
    end
    else begin 
        if(frame_valid_re) begin 
            $display("**********************************************************\n");
            $display("Frame Number :%d \n",frame_counter+1);
            $display("QP : %d  H_Res :%d  V_Res :%d\n",Quant_QP,horiz_resol,vert_resol);
        end
        else if(frame_end_fe_dly_arr[10]) begin 
            frame_counter   <= frame_counter + 1;

            
            if(error == 0) begin 
            $display("H264 I frame Encryption test passed                       \n");    
            $display("----------------------------------------------------------\n");    
            end
            else begin 
            $display("H264 I frame Encryption test failed                       \n");    
            $display("----------------------------------------------------------\n");      
            end
            
            
            
        end
        
        if(frame_counter == 2) begin 
            #100  $stop;
        end
        
    end
end


endmodule