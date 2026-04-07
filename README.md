# 🔧 8-bit Subtractor – RTL to GDSII

This project demonstrates a complete **ASIC design flow** for a basic **8-bit subtractor**, implemented using Verilog and taken through the **RTL to GDSII** flow using **Synopsys tools** such as Design Compiler, IC Compiler II, and PrimeTime.

---

## 📌 Project Overview

- **Design: -** Unsigned 8-bit subtractor (`A - B`)
- **Inputs: -** A[7:0], B[7:0]
- **Outputs: -** Diff[7:0], Borrow
- **RTL Language: -** Verilog HDL
- **Toolchain: -** Synopsys Design Compiler (DC), IC Compiler II (ICC2), PrimeTime
- **Flow: -** RTL → Synthesis → Floorplan → Placement → Routing → GDSII + STA

---

## 🧠 Functional Description

```
verilog
assign {borrow, diff} = A - B;
```
---

## Changes Of Path & Library Done in Project

### Changes in path of (run_dc.tcl): -
```
set RTL_SOURCE_FILES ./../rtl/8_bit_subtractor.v
set DESIGN_NAME subtractor_8bit
read_sdc ./../CONSTRAINTS/8_bit_sub.sdc
compile_ultra
```

### Gates Used (run_dc.tcl): -
```
#set_dont_use [get_lib_cells */FADD*]
#set_dont_use [get_lib_cells */HADD*]
#set_dont_use [get_lib_cells */NAND*]
#set_dont_use [get_lib_cells */XNOR*]
#set_dont_use [get_lib_cells */MUX*]
set_dont_use [get_lib_cells */AO*]
set_dont_use [get_lib_cells */OA*]
set_dont_use [get_lib_cells */XOR*]
set_dont_use [get_lib_cells */NOR*]
```

### Library changes in "common_setup.tcl": -
```
set TARGET_LIBRARY_FILES "$PDK_PATH/lib/stdcell_rvt/saed32rvt_ss0p7vn40c.db" ;
Changes in CONSTRAINTS: - (8_bit_sub.sdc): -
create_clock -period 6.8 -name Clock -waveform {0 0.55} [get_ports Clock]
set_input_delay -max 1.5 -clock Clock [all_inputs]
set_output_delay -max 0.8 -clock Clock [all_outputs]
set_input_transition 0.5 [all_inputs]
set_clock_uncertainty -setup 1.6 [get_clocks Clock]
set_clock_uncertainty -hold 0.100 [get_clocks Clock]
set_max_transition 0.25 [current_design]
set_max_transition -clock_path 0.15 [get_clocks Clock]
```

### Changes in path of (routing.tcl): -
```
write_verilog ./results/8_bit_s.routed.v
write_sdc -output ./results/8_bit_sub.sdc
write_parasitics -format spef -output ./results/8_sub_${scenario1}.spef
```

### Changes in path of Prime Time (run_pt_p2.tcl): -
```
# Set the technology libraries
set link_path "./../ref/lib/stdcell_rvt/saed32rvt_ss0p7vn40c.db"
set target_library "./../ref/lib/stdcell_rvt/saed32rvt_ss0p7vn40c.db"
# Read routed netlist from ICC2
read_verilog "./../ICCII/results/8_bit_s.routed.v"
# Read design constraints
read_sdc "./../CONSTRAINTS/8_bit_sub.sdc"
# Read parasitic data from ICC2
read_parasitics "./../ICCII/results/8_sub_func::nom.spef.p2_125.spef"
```
