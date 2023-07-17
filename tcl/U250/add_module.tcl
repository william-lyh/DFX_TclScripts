#!/bin/sh
# add_module.tcl \

puts "Opening Project"
open_project /scratch/williamlyh/DrivedCounter_wDFX_tclCreated/DrivedCounter_wDFX_tclCreated.xpr
update_compile_order -fileset sources_1

puts "Setup new reconfigurable module and runs"
create_reconfig_module -name clock_counter_quarter -partition_def [get_partition_defs counter ]
import_files -norecurse /home/eecs/williamlyh/Documents/DFX_TclScripts/src/U250/clock_counter_quarter.v  -of_objects [get_reconfig_modules clock_counter_quarter]
create_pr_configuration -name quarter -partitions [list counter:clock_counter_quarter ]
create_run child_1_impl_1 -parent_run impl_1 -flow {Vivado Implementation 2021} -pr_config quarter

puts "launch impl run"
launch_runs child_1_impl_1 -jobs 16
puts "waiting for impl to finish"
wait_on_run child_1_impl_1

puts "launch bitstream run"
open_run child_1_impl_1
write_bitstream -file /home/eecs/williamlyh/Documents/DFX_TclScripts/bit/bit_quarter_partial -cell counter


puts "Finished"

start_gui
