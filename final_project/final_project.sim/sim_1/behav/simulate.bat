@echo off
set xv_path=C:\\Users\\Vivado\\2017.2\\bin
call %xv_path%/xsim blk_mem_gen_0_tb_behav -key {Behavioral:sim_1:Functional:blk_mem_gen_0_tb} -tclbatch blk_mem_gen_0_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
