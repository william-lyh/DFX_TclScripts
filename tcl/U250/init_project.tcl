#!/bin/sh
# create_config.tcl \

puts "Create project"
create_project DrivedCounter_wDFX_tclCreated /scratch/williamlyh/DrivedCounter_wDFX_tclCreated -part xcu250-figd2104-2L-e
set_property board_part xilinx.com:au250:part0:1.3 [current_project]

puts "Import sourse files"
add_files -norecurse {/home/eecs/williamlyh/Documents/DFX_TclScripts/src/top.v /home/eecs/williamlyh/Documents/DFX_TclScripts/src/driver.v /home/eecs/williamlyh/Documents/DFX_TclScripts/src/clock_counter.v }
import_files -force -norecurse
import_files -fileset constrs_1 -force -norecurse /home/eecs/williamlyh/Documents/DFX_TclScripts/src/driver.xdc
update_compile_order -fileset sources_1

puts "Enable Dynamic Function Exchange"
set_property PR_FLOW 1 [current_project] 

puts "Initialize partitions"
create_partition_def -name counter -module clock_counter
set obj [get_partition_defs counter]
set_property -name "name" -value "counter" -objects $obj
set_property -name "use_blackbox_stub" -value "1" -objects $obj
set_property -name "module_name" -value "clock_counter" -objects $obj
create_reconfig_module -name clock_counter -partition_def [get_partition_defs counter ]  -define_from clock_counter

puts "Setup reconfigurable modules and runs"
create_reconfig_module -name clock_counter_half -partition_def [get_partition_defs counter ] 
import_files -norecurse /home/eecs/williamlyh/Documents/DFX_TclScripts/src/clock_counter_half.v  -of_objects [get_reconfig_modules clock_counter_half]
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
write_bitstream -file /home/eecs/williamlyh/Documents/DFX_TclScripts/bit/bit_full
open_run child_0_impl_1
write_bitstream -file /home/eecs/williamlyh/Documents/DFX_TclScripts/bit/bit_half_partial -cell counter

puts "Finished"

start_gui
