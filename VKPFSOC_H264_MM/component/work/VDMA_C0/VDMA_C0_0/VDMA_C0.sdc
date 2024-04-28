set_component VDMA_C0
set_false_path -from [ get_cells { */*/*/*/*ctrl_reg*}]
set_false_path -from [ get_cells { */*/*/*/*glbl_int_en*}]
set_false_path -from [ get_cells { */*/*/*/*interrupt_status_clr*}]
set_false_path -from [ get_cells { */*/*/*/*interrupt_en*}]
set_false_path -from [ get_cells { */*/*/*/*buff_addr_fifo*}]
set_false_path -through [ get_pins { */*/*/*/*mem_rd_data*}]
