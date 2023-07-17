create_clock -period 8.00 -name s_axi_aclk -add [get_ports fpga_125mhz_clk]

create_pblock pblock_counter
add_cells_to_pblock [get_pblocks pblock_counter] [get_cells -quiet [list counter]]
resize_pblock [get_pblocks pblock_counter] -add {CLOCKREGION_X5Y15:CLOCKREGION_X5Y15}
