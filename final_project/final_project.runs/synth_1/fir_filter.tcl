# 
# Synthesis run script generated by Vivado
# 

create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.cache/wt [current_project]
set_property parent.project_path D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo d:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/new/package_dsed.vhd
  D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/new/pwm.vhd
  D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/new/en_4_cycles.vhd
  D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/imports/new/FSMD_microphone.vhd
  D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/new/audio_interface.vhd
  D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/new/controlador.vhd
  D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/new/fir_filter.vhd
  D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/new/mult.vhd
  D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/new/sum.vhd
}
read_ip -quiet D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci
set_property used_in_implementation false [get_files -all d:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]
set_property used_in_implementation false [get_files -all d:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]
set_property is_locked true [get_files D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/constrs_1/imports/Downloads/Nexys4DDR_Master.xdc
set_property used_in_implementation false [get_files D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/constrs_1/imports/Downloads/Nexys4DDR_Master.xdc]


synth_design -top fir_filter -part xc7a100tcsg324-1


write_checkpoint -force -noxdef fir_filter.dcp

catch { report_utilization -file fir_filter_utilization_synth.rpt -pb fir_filter_utilization_synth.pb }