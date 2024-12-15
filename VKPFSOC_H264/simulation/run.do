quietly set ACTELLIBNAME PolarFireSoC
quietly set PROJECT_DIR "C:/Users/romaissa/Documents/work/polarfire_soc_video_kit/polarfire-soc-video-kit-design/VKPFSOC_H264"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap polarfire "C:/Microchip/Libero_SoC_v2024.1/Designer/lib/modelsimpro/precompiled/vlog/polarfire"
vmap PolarFire "C:/Microchip/Libero_SoC_v2024.1/Designer/lib/modelsimpro/precompiled/vlog/polarfire"
if {[file exists COREAPB3_LIB/_info]} {
   echo "INFO: Simulation library COREAPB3_LIB already exists"
} else {
   file delete -force COREAPB3_LIB 
   vlib COREAPB3_LIB
}
vmap COREAPB3_LIB "COREAPB3_LIB"
if {[file exists CORERXIODBITALIGN_LIB/_info]} {
   echo "INFO: Simulation library CORERXIODBITALIGN_LIB already exists"
} else {
   file delete -force CORERXIODBITALIGN_LIB 
   vlib CORERXIODBITALIGN_LIB
}
vmap CORERXIODBITALIGN_LIB "CORERXIODBITALIGN_LIB"

vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/SOF.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/stimulus/SOF_tb.vhd"

vsim -L polarfire -L presynth -L COREAPB3_LIB -L CORERXIODBITALIGN_LIB  -t 1ps -pli C:/Microchip/Libero_SoC_v2024.1/Designer/lib/modelsimpro/pli/pf_crypto_win_me_pli.dll presynth.SOF_Detector_tb
add wave /SOF_Detector_tb/*
run 1000ns
