# OpenROAD P&R script for edgeconv_top
# Ready for execution with sky130hd PDK

set design_name "edgeconv_top"
set verilog_files "edgeconv_top_synth.v"
set clk_port "clk"
set clk_period 50.0

# PDK paths (adjust as needed)
set platform_dir $::env(PDK_ROOT)/sky130hd
set tech_lef "$platform_dir/sky130hd.tlef"
set stdcell_lef "$platform_dir/sky130hd_std_cell.lef"
set liberty_file "$platform_dir/sky130hd_tt.lib"

puts "Design: $design_name"
puts "Clock: $clk_port @ ${clk_period}ns"

# Load tech
read_lef $tech_lef
read_lef $stdcell_lef
read_liberty $liberty_file

# Read netlist
read_verilog $verilog_files
link_design $design_name

# Constraints
create_clock -name $clk_port -period $clk_period [get_ports $clk_port]
set_input_delay -clock $clk_port 10.0 [all_inputs -no_clocks]
set_output_delay -clock $clk_port 10.0 [all_outputs]

# Floorplan
initialize_floorplan -utilization 40 -aspect_ratio 1.0 -core_space {5 5 5 5}
place_pins -hor_layers {met3} -ver_layers {met2}

# Power
create_power_nets -net VDD
create_ground_nets -net VSS
connect_global_net VDD -type pg_pin -pin VPWR -inst *
connect_global_net VSS -type pg_pin -pin VGND -inst *

# Placement
global_placement -density 50
detailed_placement

# CTS
clock_tree_synthesis -root_buf sky130_fd_sc_hd__clkbuf_16 \
    -buf_list {sky130_fd_sc_hd__clkbuf_2 sky130_fd_sc_hd__clkbuf_4 sky130_fd_sc_hd__clkbuf_8}
repair_clock_nets
detailed_placement

# Routing
global_route -congestion_iterations 50
detailed_route

# Reports
report_checks -path_delay max > setup.rpt
report_power > power.rpt
report_design_area > area.rpt

# Outputs
write_def ${design_name}_final.def
write_verilog ${design_name}_final.v
write_sdf ${design_name}_final.sdf

puts "Complete: ${design_name}_final.def, .v, .sdf"
