set_component PF_IOD_GENERIC_RX_C0
create_clock -period 4.0 [ get_pins CLK_0/PADP ]
set_false_path -to [ get_pins {PF_LANECTRL_0/I_LANECTRL*/HS_IO_CLK_PAUSE} ]