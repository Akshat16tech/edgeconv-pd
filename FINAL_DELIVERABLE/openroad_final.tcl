set design_name "edgeconv_top"
read_lef $::env(PDK_ROOT)/sky130hd/sky130hd.tlef
read_lef $::env(PDK_ROOT)/sky130hd/sky130hd_std_cell.lef
read_liberty $::env(PDK_ROOT)/sky130hd/sky130hd_tt.lib
read_verilog edgeconv_top_synth.v
link_design $design_name
create_clock -name clk -period 50.0 [get_ports clk]
initialize_floorplan -utilization 40 -aspect_ratio 1.0 -core_space {5 5 5 5}
place_pins -hor_layers {met3} -ver_layers {met2}
global_placement -density 50
detailed_placement
clock_tree_synthesis -root_buf sky130_fd_sc_hd__clkbuf_16 -buf_list {sky130_fd_sc_hd__clkbuf_2 sky130_fd_sc_hd__clkbuf_4 sky130_fd_sc_hd__clkbuf_8}
global_route -congestion_iterations 50
detailed_route
write_def ${design_name}_final.def
write_verilog ${design_name}_final.v
report_checks > timing.rpt
report_design_area > area.rpt
