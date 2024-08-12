new_project \
         -name {VKPFSOC_TOP} \
         -location {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\VKPFSOC_TOP_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {MPFS250TS} \
         -name {MPFS250TS}
enable_device \
         -name {MPFS250TS} \
         -enable {TRUE}
save_project
close_project
