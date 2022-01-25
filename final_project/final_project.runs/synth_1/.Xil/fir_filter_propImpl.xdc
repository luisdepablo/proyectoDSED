set_property SRC_FILE_INFO {cfile:D:/bibliotecas/desktop/DSED/proyectoDSED/final_project/final_project.srcs/constrs_1/imports/Downloads/Nexys4DDR_Master.xdc rfile:../../../final_project.srcs/constrs_1/imports/Downloads/Nexys4DDR_Master.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:7 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk_100Mhz }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
set_property src_info {type:XDC file:1 line:8 export:INPUT save:INPUT read:READ} [current_design]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk_100Mhz}];
set_property src_info {type:XDC file:1 line:85 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { reset }]; #IO_L4N_T0_D05_14 Sch=btnu
set_property src_info {type:XDC file:1 line:206 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN J5    IOSTANDARD LVCMOS33 } [get_ports { micro_clk }]; #IO_25_35 Sch=m_clk
set_property src_info {type:XDC file:1 line:207 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports { micro_data }]; #IO_L24N_T3_35 Sch=m_data
set_property src_info {type:XDC file:1 line:208 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN F5    IOSTANDARD LVCMOS33 } [get_ports { micro_lr }]; #IO_0_35 Sch=m_lrsel
set_property src_info {type:XDC file:1 line:213 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN A11   IOSTANDARD LVCMOS33 } [get_ports { jack_pwm }]; #IO_L4N_T0_15 Sch=aud_pwm
set_property src_info {type:XDC file:1 line:214 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN D12   IOSTANDARD LVCMOS33 } [get_ports { jack_sd }]; #IO_L6P_T0_15 Sch=aud_sd
