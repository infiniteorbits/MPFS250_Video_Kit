open_project -project {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\VKPFSOC_TOP_fp\VKPFSOC_TOP.pro}\
         -connect_programmers {FALSE}
load_programming_data \
    -name {MPFS250TS} \
    -fpga {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\VKPFSOC_TOP.map} \
    -header {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\VKPFSOC_TOP.hdr} \
    -snvm {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\VKPFSOC_TOP_snvm.efc} \
    -spm {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\VKPFSOC_TOP.spm} \
    -dca {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\VKPFSOC_TOP.dca}
export_single_ppd \
    -name {MPFS250TS} \
    -file {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\export/tempExport\videokit_lvds.ppd}

save_project
close_project
