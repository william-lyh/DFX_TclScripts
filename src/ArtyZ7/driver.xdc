set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports fpga_125mhz_clk]
create_clock -period 8.000 -name sys_clk_pin -waveform {0.000 4.000} -add [get_ports fpga_125mhz_clk]

set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports btn]

set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports {switches[0]}]
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33} [get_ports {switches[1]}]

set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports {leds[0]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {leds[1]}]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {leds[2]}]
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {leds[3]}]


create_pblock pblock_counter
add_cells_to_pblock [get_pblocks pblock_counter] [get_cells -quiet [list counter]]
resize_pblock [get_pblocks pblock_counter] -add {SLICE_X106Y75:SLICE_X113Y99}
