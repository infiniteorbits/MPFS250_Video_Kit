//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Aug 12 21:24:06 2024
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of PF_OSC_C0 to TCL
# Family: PolarFireSoC
# Part Number: MPFS250TS-1FCG1152I
# Create and Configure the core component PF_OSC_C0
create_and_configure_core -core_vlnv {Actel:SgCore:PF_OSC:1.0.102} -component_name {PF_OSC_C0} -params {\
"RCOSC_2MHZ_CLK_DIV_EN:true"  \
"RCOSC_2MHZ_GL_EN:false"  \
"RCOSC_2MHZ_NGMUX_EN:false"  \
"RCOSC_160MHZ_CLK_DIV_EN:false"  \
"RCOSC_160MHZ_GL_EN:false"  \
"RCOSC_160MHZ_NGMUX_EN:false"   }
# Exporting Component Description of PF_OSC_C0 to TCL done
*/

// PF_OSC_C0
module PF_OSC_C0(
    // Outputs
    RCOSC_2MHZ_CLK_DIV
);

//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output RCOSC_2MHZ_CLK_DIV;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   RCOSC_2MHZ_CLK_DIV_net_0;
wire   RCOSC_2MHZ_CLK_DIV_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign RCOSC_2MHZ_CLK_DIV_net_1 = RCOSC_2MHZ_CLK_DIV_net_0;
assign RCOSC_2MHZ_CLK_DIV       = RCOSC_2MHZ_CLK_DIV_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------PF_OSC_C0_PF_OSC_C0_0_PF_OSC   -   Actel:SgCore:PF_OSC:1.0.102
PF_OSC_C0_PF_OSC_C0_0_PF_OSC PF_OSC_C0_0(
        // Outputs
        .RCOSC_2MHZ_CLK_DIV ( RCOSC_2MHZ_CLK_DIV_net_0 ) 
        );


endmodule
