#==============================================================
# Synopsys IC Compiler II - Script 03: Floorplan
# File: 03_floorplan.tcl
#==============================================================

source scripts/01_setup.tcl

#--------------------------------------------------------------
# 3a.Floorplan
#--------------------------------------------------------------

#scenario:
initialize_floorplan -core_utilization 0.6 -coincident_boundary true -core_offset {2 2} -shape U -orientation E

# Input pins (clk, rst, x[2:0])
set_individual_pin_constraints \
    -ports [get_ports {clk rst x[*]}] \
    -sides {1 2} \
    -pin_spacing_distance 2

# Output pins (y[7:0])
set_individual_pin_constraints \
    -ports [get_ports {y[*]}] \
    -sides {3 4} \
    -pin_spacing_distance 2

place_pins -self

create_placement -floorplan -effort medium


check_pin_placement \
    > $REPORTS_DIR/check_pin_placement.rpt

# save the block and lib
save_block -as POW2_3BIT
save_lib

puts "INFO: Floorplan complete."
