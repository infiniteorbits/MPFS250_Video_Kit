set_defvar -name {SPEED}   -value {-1}
set_defvar -name {VOLTAGE} -value {1.0}
set_defvar -name {TEMPR}   -value {IND}
set_defvar -name {PART_RANGE}   -value {IND}
set_defvar -name {IO_DEFT_STD} -value {LVCMOS18}
set_defvar -name {PACOMP_PARPT_MAX_NET} -value {10}
set_defvar -name {PA4_GB_MAX_RCLKINT_INSERTION} -value {16}
set_defvar -name {PA4_GB_MIN_GB_FANOUT_TO_USE_RCLKINT} -value {1000}
set_defvar -name {PA4_GB_MAX_FANOUT_DATA_MOVE} -value {5000}
set_defvar -name {PA4_GB_HIGH_FANOUT_THRESHOLD} -value {5000}
set_defvar -name {PA4_GB_COUNT} -value {36}
set_defvar -name {RESTRICTPROBEPINS} -value {0}
set_defvar -name {RESTRICTSPIPINS} -value {0}
set_defvar -name {PDC_IMPORT_HARDERROR} -value {1}
set_defvar -name {PA4_IDDQ_FF_FIX} -value {1}
set_defvar -name {BLOCK_PLACEMENT_CONFLICTS} -value {ERROR}
set_defvar -name {BLOCK_ROUTING_CONFLICTS} -value {LOCK}
set_defvar -name {RTG4_MITIGATION_ON} -value {0}
set_defvar -name {USE_CONSTRAINT_FLOW} -value True
set_defvar -name {FHB_AUTO_INSTANTIATION} -value {0}
set_defvar -name {SYSTEM_CONTROLLER_SUSPEND_MODE} -value {0}

set_partition_info -name "/VKPFSOC_TOP" -timestamp "1723491161"
set_partition_info -name "/VKPFSOC_TOP/Video_Pipeline_0/IMX334_IF_TOP_0/CSI2_RXDecoder_0/mipicsi2rxdecoderPF_C0_0/genblk1\.mipicsi2rxdecoderPF_native/mipi_csi2_rxdecoder_0" -timestamp "1723491161"
set_partition_info -name "/VKPFSOC_TOP/Video_Pipeline_0/IMX334_IF_TOP_0/CSI2_RXDecoder_0/mipicsi2rxdecoderPF_C0_0/genblk1\.mipicsi2rxdecoderPF_native/embsync_detect_0" -timestamp "1723491161"
set_partition_info -name "/VKPFSOC_TOP/Video_Pipeline_0/IMX334_IF_TOP_0" -timestamp "1723491161"
set_partition_info -name "/VKPFSOC_TOP/Video_Pipeline_0/h264_top_0/H264_Iframe_Encoder_C0_0/H264_Iframe_Encoder_C0_0/h264_intra_0/Intra420_chroma_inst" -timestamp "1723491161"
set_partition_info -name "/VKPFSOC_TOP/Video_Pipeline_0/h264_top_0/H264_Iframe_Encoder_C0_0/H264_Iframe_Encoder_C0_0/h264_intra_0/Intra420_luma_inst" -timestamp "1723491161"
set_partition_info -name "/VKPFSOC_TOP/Video_Pipeline_0/h264_top_0/H264_Iframe_Encoder_C0_0/H264_Iframe_Encoder_C0_0/h264_intra_0" -timestamp "1723491161"
set_partition_info -name "/VKPFSOC_TOP/Video_Pipeline_0/h264_top_0/H264_Iframe_Encoder_C0_0/H264_Iframe_Encoder_C0_0/cavlc_cbp_y_0/CAVLC_Y_0" -timestamp "1723491161"
set_partition_info -name "/VKPFSOC_TOP/Video_Pipeline_0/h264_top_0/H264_Iframe_Encoder_C0_0/H264_Iframe_Encoder_C0_0/cavlc_cbp_c_0/CAVLC_C" -timestamp "1723491161"
set_partition_info -name "/VKPFSOC_TOP/Video_Pipeline_0/h264_top_0/H264_Iframe_Encoder_C0_0/H264_Iframe_Encoder_C0_0" -timestamp "1723491161"
set_partition_info -name "/VKPFSOC_TOP/Video_Pipeline_0/h264_top_0" -timestamp "1723491161"
set_compile_info \
    -category {"Device Selection"} \
    -name {"Family"} \
    -value {"PolarFireSoC"}
set_compile_info \
    -category {"Device Selection"} \
    -name {"Device"} \
    -value {"MPFS250TS"}
set_compile_info \
    -category {"Device Selection"} \
    -name {"Package"} \
    -value {"FCG1152"}
set_compile_info \
    -category {"Device Selection"} \
    -name {"Speed Grade"} \
    -value {"-1"}
set_compile_info \
    -category {"Device Selection"} \
    -name {"Core Voltage"} \
    -value {"1.0V"}
set_compile_info \
    -category {"Device Selection"} \
    -name {"Part Range"} \
    -value {"IND"}
set_compile_info \
    -category {"Device Selection"} \
    -name {"Default I/O technology"} \
    -value {"LVCMOS 1.8V"}
set_compile_info \
    -category {"Source Files"} \
    -name {"Topcell"} \
    -value {"VKPFSOC_TOP"}
set_compile_info \
    -category {"Source Files"} \
    -name {"Format"} \
    -value {"Verilog"}
set_compile_info \
    -category {"Source Files"} \
    -name {"Source"} \
    -value {"C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\synthesis\VKPFSOC_TOP.vm"}
set_compile_info \
    -category {"Options"} \
    -name {"Limit the number of high fanout nets to display to"} \
    -value {"10"}
compile \
    -desdir {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP} \
    -design VKPFSOC_TOP \
    -fam PolarFireSoC \
    -die PA5SOC250TS \
    -pkg fcg1152 \
    -merge_pdc 0
