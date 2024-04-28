set_component H264_Iframe_Encoder_C0
set_false_path -from [ get_cells { */*/*/*ctrl_reg*}]
set_false_path -from [ get_cells { */*/*/*q_factor*}]
set_false_path -from [ get_cells { */*/*/*h_res*}]
set_false_path -from [ get_cells { */*/*/*v_res*}]
set_false_path -through [ get_pins { */*/*/*mem_rd_data*}]
