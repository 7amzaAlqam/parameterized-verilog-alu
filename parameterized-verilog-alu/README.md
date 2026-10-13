# Parameterized Verilog ALU

A parameterized **Arithmetic Logic Unit (ALU)** implemented in **Verilog HDL** using both **structural/modular** and **behavioral** RTL styles. The design supports eight arithmetic, shift-based, and bitwise operations selected by a 3-bit control input. It was originally developed in Intel Quartus and has been cleaned and reorganized as a portfolio-quality RTL project.

## Supported Operations

| `op_sel` | Operation |
|---|---|
| `000` | `(X + Y) / 2` |
| `001` | `2 × (X + Y)` |
| `010` | `(X / 2) + Y` |
| `011` | `X - (Y / 2)` |
| `100` | `X NAND Y` |
| `101` | `NOT X` |
| `110` | `X NOR Y` |
| `111` | `X XOR Y` |

## Implementations

### Structural RTL
`rtl/alu_structural.v` builds the datapath from reusable modules: an add/subtract unit, bidirectional shifter, 8-to-1 multiplexer, and dedicated NAND/NOR/NOT/XOR blocks. This version demonstrates hierarchy, module reuse, datapath composition, and control-based result selection.

### Behavioral RTL
`rtl/alu_behavioral.v` describes the same eight operations using a combinational `case` statement. Keeping both versions makes it easy to compare two common RTL description styles.

## Repository Structure

```text
parameterized-verilog-alu/
├── README.md
├── .gitignore
├── rtl/
│   ├── alu_structural.v
│   ├── alu_behavioral.v
│   ├── add_sub_unit.v
│   ├── bidirectional_shifter.v
│   ├── mux8to1.v
│   ├── nand_unit.v
│   ├── nor_unit.v
│   ├── not_unit.v
│   └── xor_unit.v
├── tb/
│   └── alu_compare_tb.v
├── simulation/
│   ├── alu_structural_original_waveform.vwf
│   └── alu_behavioral_original_waveform.vwf
├── quartus/
│   ├── structural/
│   └── behavioral/
└── docs/
    └── original_design_report.docx
```

## Verification

`tb/alu_compare_tb.v` is a self-checking comparison testbench. It applies all eight operation selections to both implementations and reports a mismatch if their outputs differ for the chosen operands. The original Quartus waveform files are retained in `simulation/` as legacy project artifacts.

Example with Icarus Verilog (if installed):

```bash
iverilog -o alu_tb tb/alu_compare_tb.v rtl/*.v
vvp alu_tb
```

## Intel Quartus

The repository contains cleaned Quartus project files for both implementations. They preserve the original FPGA target: **Cyclone II EP2C20F484C7**.

Open either:

- `quartus/structural/alu_structural.qpf`
- `quartus/behavioral/alu_behavioral.qpf`

Generated Quartus databases, programming files, and reports are intentionally excluded from version control through `.gitignore`.

## Cleanup and Corrections

The portfolio version keeps the original project intent and operation set while improving the RTL quality. Student-ID-based names were replaced with descriptive names; combinational blocks use complete sensitivity (`always @(*)`); NAND/NOR/NOT/XOR are implemented as bitwise vector operations; structural signal widths/connections were repaired; and arithmetic paths were widened to reduce accidental truncation.

## Skills Demonstrated

- Verilog HDL and RTL design
- Digital logic and ALU architecture
- Parameterized hardware modules
- Structural and behavioral modeling
- Arithmetic datapaths and bitwise logic
- Multiplexers and shift operations
- Functional verification with a testbench
- Intel Quartus project organization
- FPGA synthesis-oriented workflow

## Possible Next Steps

- Port the RTL to SystemVerilog
- Add constrained-random or exhaustive verification
- Add assertions and lint checks
- Add ALU status flags (zero, carry, overflow, negative)
- Compare synthesis area/timing between structural and behavioral versions

## Author

**Hamzah Iyad Alqam**  
Computer Engineering Graduate, Birzeit University
