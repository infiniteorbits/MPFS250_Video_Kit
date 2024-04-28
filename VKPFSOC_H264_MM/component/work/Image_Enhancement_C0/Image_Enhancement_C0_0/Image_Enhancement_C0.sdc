set_component Image_Enhancement_C0
set_false_path -from [ get_cells { */*/*/*image_enhancement_ip_en*}]
set_false_path -from [ get_cells { */*/*/*image_enhancement_ip_rst*}]
set_false_path -from [ get_cells { */*/*/*r_constant*}]
set_false_path -from [ get_cells { */*/*/*g_constant*}]
set_false_path -from [ get_cells { */*/*/*b_constant*}]
set_false_path -from [ get_cells { */*/*/*second_constant*}]
set_false_path -through [ get_pins { */*/*/*mem_rd_data*}]
