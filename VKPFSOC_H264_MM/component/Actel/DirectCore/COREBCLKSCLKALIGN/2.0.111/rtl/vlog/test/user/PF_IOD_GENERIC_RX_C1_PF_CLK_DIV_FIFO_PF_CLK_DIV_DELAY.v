`timescale 1 ns/100 ps
// Version: v12.2 12.700.0.21


module PF_IOD_GENERIC_RX_C1_PF_CLK_DIV_FIFO_PF_CLK_DIV_DELAY(
       CLK_IN,
       CLK_OUT_HS_IO_CLK,
       CLK_DIV_OUT,
       DELAY_LINE_DIR,
       DELAY_LINE_MOVE,
       DELAY_LINE_LOAD,
       DELAY_LINE_OUT_OF_RANGE
    );
input  CLK_IN;
output CLK_OUT_HS_IO_CLK;
output CLK_DIV_OUT;
input  DELAY_LINE_DIR;
input  DELAY_LINE_MOVE;
input  DELAY_LINE_LOAD;
output DELAY_LINE_OUT_OF_RANGE;

    wire GND_net, VCC_net;
    
    ICB_CLKDIVDELAY #( .DELAY_LINE_SIMULATION_MODE("ENABLED"), .DIVIDER(3'b010)
        , .DELAY_LINE_EN(1'b1), .DELAY_LINE_VAL(8'b00000001), .DELAY_VAL_X2(1'b1)
        , .FB_SOURCE_SEL_0(1'b0), .FB_SOURCE_SEL_1(1'b1) )  I_CDD (
        .DELAY_LINE_OUT_OF_RANGE(DELAY_LINE_OUT_OF_RANGE), 
        .DELAY_LINE_DIR(DELAY_LINE_DIR), .DELAY_LINE_MOVE(
        DELAY_LINE_MOVE), .DELAY_LINE_LOAD(DELAY_LINE_LOAD), .RST_N(
        VCC_net), .BIT_SLIP(GND_net), .A(CLK_IN), .Y_DIV(CLK_DIV_OUT), 
        .Y(), .Y_FB(CLK_OUT_HS_IO_CLK), .Y_ND());
    VCC vcc_inst (.Y(VCC_net));
    GND gnd_inst (.Y(GND_net));
    
endmodule