// Implements a sinc^3 filter on a single-bit input. Useful for sigma-delta 
// modulator outputs. Transfer function is:
//
//          (1-z^-OSR)^3
// H(z) = ----------------
//           (1-z^-1)^3
//
// This is very efficient for Xilinx FPGAs. Also near optimal for any device 
// where long single-bit delay lines can be cheaply implemented. For any other 
// device, it is almost certainly better to implement the 3 accumulators first, 
// decimate, then implement the differentiator stages.
module sinc3Filter
#(
    parameter OSR = 16 // Output width is 3*ceil(log2(OSR))+1
)
(
    input clk,
    input en, ///< Enable (use to clock at slower rate)
    input in,
    output reg signed [3*$clog2(OSR):0] out
);

// Parameters
///////////////////////////////////////////////////////////////////////////

localparam ACC_UP = $clog2(OSR)-1;

// Signal Declarations
///////////////////////////////////////////////////////////////////////////

wire signed [3:0] diff;

reg [(3*OSR)-1:0] shift;
reg signed [(3+1*ACC_UP):0] acc1 = 'd0;
reg signed [(3+2*ACC_UP):0] acc2 = 'd0;

integer i;

// Main Code
///////////////////////////////////////////////////////////////////////////

// Initialize delay line such that average of all bits in line is 0. Not doing 
// this will result in a non-zero DC offset.
initial begin
    shift[0] = 1'b1;
    for (i=1; i<(3*OSR); i=i+1) shift[i] = ~shift[i-1];
    out = 'd0;
end

// diff = (1-z^-OSR) ^ 3
// accumulators implement 1/(1-z^-1)^3
assign diff = in - 3*shift[OSR-1] + 3*shift[2*OSR-1] - shift[3*OSR-1];
always @(posedge clk) begin
    if (en) begin
        shift <= {shift[3*OSR-2:0], in};
        acc1  <= acc1 + diff;
        acc2  <= acc2 + acc1;
        out   <= out  + acc2;
    end
end

endmodule
