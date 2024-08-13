open_project -project {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\VKPFSOC_TOP_fp\VKPFSOC_TOP.pro}
enable_device -name {MPFS250TS} -enable 1
set_programming_file -name {MPFS250TS} -file {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\VKPFSOC_TOP.ppd}
set_programming_action -action {PROGRAM} -name {MPFS250TS} 
run_selected_actions
save_project
close_project
