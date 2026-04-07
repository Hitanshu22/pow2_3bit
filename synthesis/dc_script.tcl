#==============================================================
# Synopsys Design Compiler
#==============================================================

#--------------------------------------------------------------
# 1. SETUP & ENVIRONMENT
#--------------------------------------------------------------

set DESIGN_NAME      "pow2_3bit"
set RTL_DIR          "../RTL/"
set CONSTRAINTS_FILE "../constraints/${DESIGN_NAME}.sdc"
set LIBRARY_DIR      "../ref/lib/stdcell_rvt/"
set OUTPUT_DIR       "./outputs"
set REPORTS_DIR      "./reports"

# Target library (technology .db files)
set target_library   "$LIBRARY_DIR/saed32rvt_ss0p7vn40c.db"
set link_library     "* $LIBRARY_DIR/saed32rvt_ss0p7vn40c.db $LIBRARY_DIR/saed32rvt_ff1p16v125c.db"

# Create output directories
file mkdir $OUTPUT_DIR
file mkdir $REPORTS_DIR

#--------------------------------------------------------------
# 2. READ RTL SOURCE FILES
#--------------------------------------------------------------

# Option A: Read Verilog
read_verilog [list \
    $RTL_DIR/${DESIGN_NAME}_rtl.v \
]

# Option B: Read SystemVerilog
# read_file -format sverilog [list \
#     $RTL_DIR/top_module.sv \
#     $RTL_DIR/submodule_a.sv \
# ]

# Option C: Read VHDL
# read_vhdl [list \
#     $RTL_DIR/top_module.vhd \
# ]

# Set the top-level design
current_design $DESIGN_NAME

#--------------------------------------------------------------
# 3. LINK THE DESIGN
#--------------------------------------------------------------

link

#--------------------------------------------------------------
# 4. SET DON'T USE CELLS
#--------------------------------------------------------------

#set_dont_use [get_lib_cells */FADD*]
#set_dont_use [get_lib_cells */HADD*]
#set_dont_use [get_lib_cells */AO*]
#set_dont_use [get_lib_cells */OA*]
#set_dont_use [get_lib_cells */NAND*]
#set_dont_use [get_lib_cells */XOR*]
set_dont_use [get_lib_cells */NOR*]
#set_dont_use [get_lib_cells */XNOR*]
#set_dont_use [get_lib_cells */MUX*]

#--------------------------------------------------------------
# 5. APPLY CONSTRAINTS (SDC)
#--------------------------------------------------------------

source $CONSTRAINTS_FILE

#--------------------------------------------------------------
# 6. COMPILE (SYNTHESIS)
#--------------------------------------------------------------

# Standard compile
# compile -map_effort medium -area_effort medium

# Ultra compile
  compile_ultra 

# Incremental compile for further optimization (optional)
# compile_ultra -incremental

# Fix hold violations
#set_fix_hold [all_clocks]
#compile_ultra -incremental -only_hold_time

#--------------------------------------------------------------
# 7. POST-COMPILE OPTIMIZATIONS
#--------------------------------------------------------------

# Remove unconnected ports/nets
remove_unconnected_ports [get_cells -hierarchical *]

#--------------------------------------------------------------
# 8. REPORTS
#--------------------------------------------------------------

# Timing reports
report_timing -path full -delay max -max_paths 10 \
    > $REPORTS_DIR/timing_setup.rpt

report_timing -path full -delay min -max_paths 10 \
    > $REPORTS_DIR/timing_hold.rpt

# Area report
report_area -hierarchy \
    > $REPORTS_DIR/area.rpt

# Power report
report_power -hierarchy \
    > $REPORTS_DIR/power.rpt

# Design rule checks
report_constraint -all_violators \
    > $REPORTS_DIR/constraints.rpt

report_cell \
    > $REPORTS_DIR/cells.rpt

report_net \
    > $REPORTS_DIR/nets.rpt

# QoR summary
report_qor \
    > $REPORTS_DIR/qor.rpt

#--------------------------------------------------------------
# 9. WRITE OUTPUTS
#--------------------------------------------------------------

# Remove multi-port nets and constant logic assign statements from netlist
#set_fix_multiple_port_nets -all -buffer_constants

# Write gate-level netlist (Verilog)
write -format verilog -hierarchy \
    -output $OUTPUT_DIR/${DESIGN_NAME}_netlist.v

# Write SDC constraints
write_sdc $OUTPUT_DIR/${DESIGN_NAME}.sdc

#--------------------------------------------------------------
# 10. DONE
#--------------------------------------------------------------

echo "=========================================="
echo " Synthesis COMPLETE: $DESIGN_NAME"
echo "=========================================="

