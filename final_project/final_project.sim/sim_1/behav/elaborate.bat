@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto dc65d89264f549749ebd2bbe899d4bf5 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot audio_interface_tb_behav xil_defaultlib.audio_interface_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
