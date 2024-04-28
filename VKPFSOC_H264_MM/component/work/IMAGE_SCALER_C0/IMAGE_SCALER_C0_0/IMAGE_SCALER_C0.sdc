set_component IMAGE_SCALER_C0
set_false_path -from [ get_cells { */*/*/*ctrl_reg*}]
set_false_path -from [ get_cells { */*/*/*input_hres*}]
set_false_path -from [ get_cells { */*/*/*input_vres*}]
set_false_path -from [ get_cells { */*/*/*output_hres*}]
set_false_path -from [ get_cells { */*/*/*output_vres*}]
set_false_path -from [ get_cells { */*/*/*scale_factor_hres*}]
set_false_path -from [ get_cells { */*/*/*scale_factor_vres*}]
set_false_path -through [ get_pins { */*/*/*mem_rd_data*}]
