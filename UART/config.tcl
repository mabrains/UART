# User config
set ::env(DESIGN_NAME) uart
#set ::env(STD_CELL_LIBRARY) sky130_fd_sc_hs
# Change if needed
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/*.v]
set ::env(FP_CORE_UTIL) 47
# Fill this
set ::env(CLOCK_PERIOD) "6.66"
set ::env(CLOCK_PORT) "clk"

set filename $::env(DESIGN_DIR)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}

