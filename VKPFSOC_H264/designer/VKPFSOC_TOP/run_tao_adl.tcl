set_device -family {PolarFireSoC} -die {MPFS250TS} -speed {-1}
read_adl {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\VKPFSOC_TOP.adl}
read_afl {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\VKPFSOC_TOP.afl}
map_netlist
read_sdc {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\constraint\VKPFSOC_TOP_derived_constraints.sdc}
read_sdc {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\constraint\user.sdc}
check_constraints {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\constraint\placer_sdc_errors.log}
estimate_jitter -report {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\place_and_route_jitter_report.txt}
write_sdc -mode layout {C:\work\polarfire-soc-video-kit-design\VKPFSOC_H264\designer\VKPFSOC_TOP\place_route.sdc}
