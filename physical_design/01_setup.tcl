#==============================================================
# Synopsys IC Compiler II - Script 01: Setup & Environment
# File: 01_setup.tcl
#==============================================================

set DESIGN_NAME   "pow2_3bit"

# Input files (from DC output)
set NETLIST_FILE  "../DC/outputs/${DESIGN_NAME}_netlist.v"
set SDC_FILE      "../DC/outputs/${DESIGN_NAME}.sdc"

# PDK / library paths
set PDK_PATH      "../ref"
set LIB_DIR       "$PDK_PATH/lib/stdcell_rvt"
set TECH_DIR      "$PDK_PATH/tech"

# Output directories
set OUTPUT_DIR    "./outputs"
set REPORTS_DIR   "./reports"

# Create output directories
file mkdir $OUTPUT_DIR
file mkdir $REPORTS_DIR

puts "INFO: Setup complete for design: $DESIGN_NAME"
