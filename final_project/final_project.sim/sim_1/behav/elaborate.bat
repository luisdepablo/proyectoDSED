@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto dc65d89264f549749ebd2bbe899d4bf5 -m64 --debug typical --relax --mt 2 -L blk_mem_gen_v8_3_6 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot fir_filter_tb3_behav xil_defaultlib.fir_filter_tb3 xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
