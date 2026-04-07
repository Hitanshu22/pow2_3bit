# pow2_3bit – RTL to GDSII

This project demonstrates a complete **ASIC design flow** for a **3-bit to 2^X logic generator**, implemented using Verilog and taken through the **RTL to GDSII** flow using **Synopsys tools** such as Design Compiler, IC Compiler II, and PrimeTime.

---

## Project Overview

- **Design: -** 2^X Logic Generator  
- **Inputs: -** X[2:0]  
- **Outputs: -** Y[7:0]  
- **RTL Language: -** Verilog HDL  
- **Toolchain: -** Synopsys Design Compiler (DC), IC Compiler II (ICC2), PrimeTime  
- **Flow: -** RTL → Synthesis → Floorplan → Placement → Routing → GDSII + STA  

---

## Functional Description
```
verilog
case (X)
3'd0: Y = 1;
3'd1: Y = 2;
3'd2: Y = 4;
3'd3: Y = 8;
3'd4: Y = 16;
3'd5: Y = 32;
3'd6: Y = 64;
3'd7: Y = 128;
endcase
```

---

## Changes Of Path & Library Done in Project

### Changes in path of (dc_script.tcl): -
```
set DESIGN_NAME "pow2_3bit"
set RTL_DIR "../RTL/"
set CONSTRAINTS_FILE "../constraints/pow2_3bit.sdc"

read_verilog [list
$RTL_DIR/pow2_3bit.v
]

compile_ultra
```
---

### Gates Used (dc_script.tcl): -
```
#set_dont_use [get_lib_cells /FADD]
#set_dont_use [get_lib_cells /HADD]
#set_dont_use [get_lib_cells /AO]
#set_dont_use [get_lib_cells /OA]
#set_dont_use [get_lib_cells /NAND]
#set_dont_use [get_lib_cells /XOR]
set_dont_use [get_lib_cells /NOR]
#set_dont_use [get_lib_cells /XNOR]
#set_dont_use [get_lib_cells /MUX]
```
---

### Library changes in "common_setup.tcl": -
```
set target_library "../ref/lib/stdcell_rvt/saed32rvt_ss0p7vn40c.db"
set link_library "* ../ref/lib/stdcell_rvt/saed32rvt_ss0p7vn40c.db ../ref/lib/stdcell_rvt/saed32rvt_ff1p16v125c.db"
```
---

### Changes in CONSTRAINTS (pow2_3bit.sdc): -
```
create_clock -period 10 -name clk [get_ports clk]

set_clock_uncertainty 0.2 [get_clocks clk]
set_clock_transition 0.1 [get_clocks clk]

set_input_delay 2.0 -clock clk [all_inputs]
set_output_delay 2.0 -clock clk [all_outputs]
```
---

### Changes in path of (routing.tcl): -
```
write -format verilog -hierarchy
-output ./outputs/pow2_3bit_netlist.v

write_sdc ./outputs/pow2_3bit.sdc
```
---

### Changes in path of Prime Time (STA): -
```
set link_path "../ref/lib/stdcell_rvt/saed32rvt_ff1p16v125c.db"
read_verilog "../ICCII/outputs/pow2_3bit.routed.v"
read_sdc "../ICCII/outputs/pow2_3bit_final.sdc"
read_parasitics "../ICCII/outputs/pow2_3bit_func::nom.spef.p1_125.spef"
```

---

## 📊 Results

- **Total Area: -** 103.34 µm²  
- **Cell Area: -** 96.83 µm²  
- **Power Consumption: -** 3.492 µW  
- **Setup Slack: -** 6.55 ns  
- **Hold Slack: -** 0.74 ns  
- **Clock Frequency: -** ~100 MHz  

---

## 📂 Project Structure
```
pow2_3bit/
│── README.md
│
├── RTL/
│   ├── pow2_3bit.v
│   └── pow2_3bit_tb.v
│
├── constraints/
│   └── pow2_3bit.sdc
│
├── synthesis/
│   └── dc_script.tcl
│
├── physical_design/
│   ├── floorplan.tcl
│   ├── powerplan.tcl
│   ├── routing.tcl
│
├── results/
│   ├── schematics/
│   ├── timing_reports/
│   ├── area_power_reports/
│   └── layout_images/
│
└── docs/
    └── RTL_to_GDS_Report.pdf

```
---

## 🧠 Key Learnings

- RTL modelling using Verilog HDL  
- Logic synthesis using Design Compiler  
- Floorplanning and placement using ICC2  
- Routing and physical verification  
- Static Timing Analysis using PrimeTime  

---

## 👨‍💻 Author

**Hitanshu Parikh**
