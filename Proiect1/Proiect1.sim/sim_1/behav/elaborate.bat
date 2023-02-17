@echo off
set xv_path=D:\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto cdc8255e1c5b4c0fb322a4e8f7ca4624 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Multiplication_tb_behav xil_defaultlib.Multiplication_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
