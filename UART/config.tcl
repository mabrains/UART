# User config
set script_dir [file dirname [file normalize [info script]]]

set ::env(VERILOG_FILES) "\
	$script_dir/../../caravel/verilog/rtl/defines.v \
	$script_dir/../../verilog/rtl/UART/transmitter_top_module.v "

set ::env(DESIGN_NAME) "transmitter_top_module"


# Fill this
set ::env(CLOCK_PERIOD) "10"
set ::env(CLOCK_PORT) "clk"
#set ::env(CLOCK_NET) "clk"
#set ::env(FP_CORE_UTIL) 0.1
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 900 600"
set ::env(PL_TARGET_DENSITY) 0.05
set ::env(DESIGN_IS_CORE) 0
set ::env(FP_PDN_CORE_RING) 0
set ::env(VDD_NETS) vccd1
set ::env(GND_NETS) Vssd1

set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

## The purpose of this is to prohibit the use of metal 5 in the power grid of the macros and use it exclusively for the core and top level
#set ::env(GLB_RT_MAXLAYER) 5 

set filename $::env(DESIGN_DIR)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}

