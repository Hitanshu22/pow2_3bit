# Clock definition
 create_clock -period 10 -name "clk" [get_ports clk]
 set_clock_uncertainty 0.2 [get_clocks clk]
 set_clock_transition  0.1 [get_clocks clk]

# Input/Output delays
 set_input_delay  2.0 -clock clk [all_inputs]
 set_output_delay 2.0 -clock clk [all_outputs]

# False paths
# set_false_path -from [get_ports rst_n]
