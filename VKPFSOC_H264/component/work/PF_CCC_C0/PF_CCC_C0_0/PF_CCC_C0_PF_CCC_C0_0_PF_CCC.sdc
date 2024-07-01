set_component PF_CCC_C0_PF_CCC_C0_0_PF_CCC
# Microsemi Corp.
# Date: 2024-May-22 10:31:39
#

# Base clock for PLL #0
create_clock -period 6.73401 [ get_pins { pll_inst_0/REF_CLK_0 } ]
create_generated_clock -multiply_by 841751 -divide_by 1000000 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT0 } ]
create_generated_clock -multiply_by 841751 -divide_by 2500000 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT1 } ]