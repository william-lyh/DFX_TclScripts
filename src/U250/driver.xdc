# LVDS Input SYSTEM CLOCKS (1.8V bank 64) General Purpose
#
set_property -dict {PACKAGE_PIN AV19 IOSTANDARD LVDS           } [get_ports USER_SI570_CLOCK_N]; # Bank 64 VCCO - VCC1V2 Net "USER_SI570_CLOCK_N"  - IO_L12N_T1U_N11_GC_64
set_property -dict {PACKAGE_PIN AU19 IOSTANDARD LVDS           } [get_ports USER_SI570_CLOCK_P]; # Bank 64 VCCO - VCC1V2 Net "USER_SI570_CLOCK_P"  - IO_L12P_T1U_N10_GC_64
create_clock -period 8.000 -waveform {0.000 4.000} [get_ports USER_SI570_CLOCK_N]
create_clock -period 8.000 -waveform {0.000 4.000} [get_ports USER_SI570_CLOCK_P]
#

create_pblock pblock_counter
add_cells_to_pblock [get_pblocks pblock_counter] [get_cells -quiet [list counter]]
resize_pblock [get_pblocks pblock_counter] -add {CLOCKREGION_X4Y13:CLOCKREGION_X6Y15}
