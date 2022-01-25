# 
# Synthesis run script generated by Vivado
# 

set_param project.vivado.isBlockSynthRun true
set_msg_config -msgmgr_mode ooc_run
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
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.runs/clk_wiz_0_synth_1 -new_name clk_wiz_0 -ip [get_ips clk_wiz_0]]

if { $cached_ip eq {} } {

synth_design -top clk_wiz_0 -part xc7a100tcsg324-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
catch {
 write_checkpoint -force -noxdef -rename_prefix clk_wiz_0_ clk_wiz_0.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ clk_wiz_0_stub.v
 lappend ipCachedFiles clk_wiz_0_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ clk_wiz_0_stub.vhdl
 lappend ipCachedFiles clk_wiz_0_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ clk_wiz_0_sim_netlist.v
 lappend ipCachedFiles clk_wiz_0_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ clk_wiz_0_sim_netlist.vhdl
 lappend ipCachedFiles clk_wiz_0_sim_netlist.vhdl

 config_ip_cache -add -dcp clk_wiz_0.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips clk_wiz_0]
}

rename_ref -prefix_all clk_wiz_0_

write_checkpoint -force -noxdef clk_wiz_0.dcp

catch { report_utilization -file clk_wiz_0_utilization_synth.rpt -pb clk_wiz_0_utilization_synth.pb }

if { [catch {
  file copy -force D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.runs/clk_wiz_0_synth_1/clk_wiz_0.dcp D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.runs/clk_wiz_0_synth_1/clk_wiz_0.dcp D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.runs/clk_wiz_0_synth_1/clk_wiz_0_stub.v D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.runs/clk_wiz_0_synth_1/clk_wiz_0_stub.vhdl D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.runs/clk_wiz_0_synth_1/clk_wiz_0_sim_netlist.v D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.runs/clk_wiz_0_synth_1/clk_wiz_0_sim_netlist.vhdl D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.ip_user_files/ip/clk_wiz_0]} {
  catch { 
    file copy -force D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.ip_user_files/ip/clk_wiz_0
  }
}

if {[file isdir D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.ip_user_files/ip/clk_wiz_0]} {
  catch { 
    file copy -force D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.vhdl D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.ip_user_files/ip/clk_wiz_0
  }
}
