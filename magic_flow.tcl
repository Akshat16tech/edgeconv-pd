# Magic flow for edgeconv_top
# Uses synth.v netlist

# Load technology
tech load sky130A

# Create new cell
cellname create edgeconv_top

# Read netlist (as reference for pins)
# Magic doesn't read Verilog directly, so we place manually based on synthesis

# Create core area (100x100 um)
box 0 0 100 100
paint core

# Add power rings
box -5 -5 105 5
paint met4
box -5 -5 5 105
paint met5
box 95 -5 105 105
paint met5
box -5 95 105 105
paint met4

# Add pins based on edgeconv_top ports
# clk, rst_n, valid_in, pixel_in[7:0], valid_out, digit_out[3:0]

# clk (north)
box 45 100 55 110
paint met2
label clk
port make

# rst_n (north)
box 65 100 75 110
paint met2
label rst_n
port make

# valid_in (west)
box -10 40 0 50
paint met2
label valid_in
port make

# pixel_in[0] (west)
box -10 55 0 65
paint met2
label pixel_in[0]
port make

# valid_out (east)
box 100 40 110 50
paint met2
label valid_out
port make

# digit_out[0] (east)
box 100 55 110 65
paint met2
label digit_out[0]
port make

# Save and export
save edgeconv_top.mag
gds write edgeconv_top.gds
puts "GDS written: edgeconv_top.gds"
quit
