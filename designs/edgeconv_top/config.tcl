# Design
set ::env(DESIGN_NAME) "edgeconv_top"

# Verilog files
set ::env(VERILOG_FILES) "$::env(DESIGN_DIR)/src/edgeconv_top.v $::env(DESIGN_DIR)/src/edgeconv.v"

# Clock
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "25.0"

# Design config
set ::env(DESIGN_IS_CORE) 1
set ::env(FP_CORE_UTIL) 50
set ::env(FP_ASPECT_RATIO) 1.0
set ::env(PL_TARGET_DENSITY) 0.60
set ::env(SYNTH_STRATEGY) "AREA 2"
set ::env(CTS_TARGET_SKEW) 150
set ::env(DIODE_INSERTION_STRATEGY) 3

# Run stages
set ::env(RUN_CTS) 1
set ::env(RUN_FILL_INSERTION) 1
set ::env(RUN_MAGIC_DRC) 1
set ::env(RUN_LVS) 1
set ::env(RUN_ANTENNA_CHECK) 1
