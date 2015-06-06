// Simple sinusoidal oscillator. Period depends on SHIFT and MULT
module oscillator #(
    parameter WIDTH = 8,
    parameter SHIFT = 6,
    parameter MULT = 1, // Should usually be one unless only using in simulation
    parameter START = 2**(WIDTH-1) * 0.9
) (
    input clk,
    input rst,
    output reg signed [WIDTH-1:0] cos,
    output reg signed [WIDTH-1:0] sin
);

always @(posedge clk) begin 
    if (rst) begin
        cos <= START;
        sin <= 'd0;
    end else begin
        cos <= cos - ((sin + (cos*MULT >>> SHIFT))*MULT >>> SHIFT);
        sin <= sin + (cos*MULT >>> SHIFT);
    end
end

endmodule
