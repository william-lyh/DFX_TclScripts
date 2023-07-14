#!/bin/sh
# run.tcl \

puts "Opening Project"
open_project C:/Users/willi/VivadoProjects/DrivedCounter_wDFX/DrivedCounter_wDFX.xpr
update_compile_order -fileset sources_1

puts "reset synth_1"
reset_run synth_1
puts "launch synth run"
launch_runs synth_1
puts "waiting for synth to finish"
wait_on_run synth_1

puts "reset implement run"
reset_run impl_1
puts "launch impl run"
launch_runs impl_1 child_0_impl_1 -jobs 16
puts "waiting for impl to finish"
wait_on_run child_0_impl_1

puts "launch bitstream run"
open_run impl_1
write_bitstream -file C:/Users/willi/Downloads/bit_test_full
write_bitstream -file C:/Users/willi/Downloads/bit_test_full_partial -cell counter
open_run child_0_impl_1
write_bitstream -file C:/Users/willi/Downloads/bit_test_half_partial -cell counter

close_project
