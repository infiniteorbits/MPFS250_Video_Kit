set_component PF_CCC_C2_PF_CCC_C2_0_PF_CCC
# Microsemi Corp.
# Date: 2024-Apr-28 14:51:19
#

# Base clock for PLL #0
create_clock -period 16 [ get_pins { pll_inst_0/REF_CLK_0 } ]
create_generated_clock -multiply_by 68 -divide_by 25 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT0 } ]