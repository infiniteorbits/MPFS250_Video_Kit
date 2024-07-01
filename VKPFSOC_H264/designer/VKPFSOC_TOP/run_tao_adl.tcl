set_device -family {PolarFireSoC} -die {MPFS250TS} -speed {-1}
read_adl {C:\Users\katia\Documents\Work\SPI_ANN466_INSP\mpfs-videokit\designer\VKPFSOC_TOP\VKPFSOC_TOP.adl}
read_afl {C:\Users\katia\Documents\Work\SPI_ANN466_INSP\mpfs-videokit\designer\VKPFSOC_TOP\VKPFSOC_TOP.afl}
map_netlist
read_sdc {C:\Users\katia\Documents\Work\SPI_ANN466_INSP\mpfs-videokit\constraint\VKPFSOC_TOP_derived_constraints.sdc}
read_sdc {C:\Users\katia\Documents\Work\SPI_ANN466_INSP\mpfs-videokit\constraint\user.sdc}
check_constraints {C:\Users\katia\Documents\Work\SPI_ANN466_INSP\mpfs-videokit\constraint\placer_sdc_errors.log}
estimate_jitter -report {C:\Users\katia\Documents\Work\SPI_ANN466_INSP\mpfs-videokit\designer\VKPFSOC_TOP\place_and_route_jitter_report.txt}
write_sdc -mode layout {C:\Users\katia\Documents\Work\SPI_ANN466_INSP\mpfs-videokit\designer\VKPFSOC_TOP\place_route.sdc}
