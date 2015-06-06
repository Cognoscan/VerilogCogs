# VerilogCogs
Verilog Modules for DSP functions and other common tasks to make FPGA development easier and more fun.

The intent is to make an accessible library of common functions for writing 
Verilog code. Filters, signal transforms, I/O modules, and more are all fair 
game.

## Usage
You can either drop these in your project directly, or, for the Mojo IDE, you 
can make them available to all projects as components.

To add these as components to Mojo IDE:

1. Merge the contents of lib.xml with your Mojo IDE install's 
	 library/components/lib.xml file.
2. Copy all Verilog files into the library/components folder.

## Manifest of included Modules

- servo.v - A servo output module for driving hobby servos.
- oscillator.v - A compact sinusoidal oscillator for making fixed-frequency sine 
  waves.
- sdDac.v - A 1st order sigma-delta modulator. Like a PWM output, but more 
  accurate to the original signal.
- sigmaDelta2ndOrder.v - A 2nd order sigma-delta modulator. Similar to a 1st 
  order, but has better noise shaping.
- sinc3Filter.v - A sinc^3 filter. Use it to filter and decimate an input from a 
  2nd Order analog sigma-delta modulator.
- iirLowPassSinglePole.v - An always stable, efficient low-pass filter. Only 
  allows certain cut-off frequencies.

## Planned Modules

- Symmetric FIR filter
- Sine Wave Lookup table
- Triangle & sawtooth wave generators
- Explanation of how to make the analog portion of the sigma-delta modulators.
- Arctan function using the CORDIC algorithm

