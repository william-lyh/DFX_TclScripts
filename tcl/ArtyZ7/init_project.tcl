#!/bin/sh
# create_config.tcl \

puts "Create project"
create_project DrivedCounter_wDFX_tclCreated C:/Users/willi/VivadoProjects/DrivedCounter_wDFX_tclCreated -part xc7z020clg400-1
set_property board_part_repo_paths {C:/Users/willi/AppData/Roaming/Xilinx/Vivado/2023.1.1/xhub/board_store/xilinx_board_store/XilinxBoardStore/Vivado/2023.1.1/boards/Digilent/arty-z7-20/1.1} [current_project]
set_property board_part digilentinc.com:arty-z7-20:part0:1.1 [current_project]

puts "Import sourse files"
add_files -norecurse {C:/Users/willi/iCloudDrive/Desktop/Berkeley/SLICE/DFX_tcl/src/top.v C:/Users/willi/iCloudDrive/Desktop/Berkeley/SLICE/DFX_tcl/src/driver.v C:/Users/willi/iCloudDrive/Desktop/Berkeley/SLICE/DFX_tcl/src/clock_counter.v }
import_files -force -norecurse
import_files -fileset constrs_1 -force -norecurse C:/Users/willi/iCloudDrive/Desktop/Berkeley/SLICE/DFX_tcl/src/driver.xdc
update_compile_order -fileset sources_1

puts "Enable Dynamic Function Exchange"
set_property PR_FLOW 1 [current_project] 

puts "Initialize partitions"
create_partition_def -name counter -module clock_counter
set obj [get_partition_defs counter]
set_property -name "name" -value "counter" -objects $obj
set_property -name "use_blackbox_stub" -value "1" -objects $obj
set_property -name "module_name" -value "clock_counter" -objects $obj

puts "Setup reconfigurable modules and runs"
create_reconfig_module -name clock_counter -partition_def $obj -define_from clock_counter
create_reconfig_module -name clock_counter_half -partition_def $obj 
import_files -norecurse C:/Users/willi/iCloudDrive/Desktop/Berkeley/SLICE/DFX_tcl/src/clock_counter_half.v  -of_objects [get_reconfig_modules clock_counter_half]
create_pr_configuration -name full -partitions [list counter:clock_counter ]
create_pr_configuration -name half -partitions [list counter:clock_counter_half ]
set_property PR_CONFIGURATION full [get_runs impl_1]
create_run child_0_impl_1 -parent_run impl_1 -flow {Vivado Implementation 2023} -pr_config half

puts "launch synth run"
launch_runs synth_1 -jobs 16
puts "waiting for synth to finish"
wait_on_run synth_1

puts "launch impl run"
open_run synth_1 -name synth_1 -pr_config [current_pr_configuration]
launch_runs impl_1 child_0_impl_1 -jobs 16
puts "waiting for impl to finish"
wait_on_run child_0_impl_1

puts "generate bitstream"
open_run impl_1
write_bitstream -file C:/Users/willi/iCloudDrive/Desktop/Berkeley/SLICE/DFX_tcl/bit/bit_full
open_run child_0_impl_1
write_bitstream -file C:/Users/willi/iCloudDrive/Desktop/Berkeley/SLICE/DFX_tcl/bit/bit_half_partial -cell counter

puts "Finished"

start_gui
