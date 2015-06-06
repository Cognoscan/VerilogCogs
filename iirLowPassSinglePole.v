module iirLowPassSinglePole
#(
    parameter GAIN = 4,
    parameter WIDTH = 16
) (
    input clk,
    input rst,
    input en,
    input signed [WIDTH-1:0] in,
    output wire signed [WIDTH-1:0] out
);

reg signed [WIDTH+GAIN-1:0] accumulator;

always @(posedge clk) begin
    if (rst) begin
        accumulator <= 'd0;
    end else if (en) begin
        accumulator <= accumulator + in - out;
    end
end

assign out = accumulator[WIDTH+GAIN-1:GAIN];

endmodule
