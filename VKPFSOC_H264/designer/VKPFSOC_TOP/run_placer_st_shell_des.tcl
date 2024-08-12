set_device \
    -family  PolarFireSoC \
    -die     PA5SOC250TS \
    -package fcg1152 \
    -speed   -1 \
    -tempr   {IND} \
    -voltr   {IND}
set_def {VOLTAGE} {1.0}
set_def {VCCI_1.2_VOLTR} {IND}
set_def {VCCI_1.5_VOLTR} {IND}
set_def {VCCI_1.8_VOLTR} {IND}
set_def {VCCI_2.5_VOLTR} {IND}
set_def {VCCI_3.3_VOLTR} {IND}
set_def {RTG4_MITIGATION_ON} {0}
set_def USE_CONSTRAINTS_FLOW 1
set_def NETLIST_TYPE EDIF
set_name VKPFSOC_TOP
set_workdir {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP}
set_log     {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\VKPFSOC_TOP_sdc.log}
set_design_state pre_layout
