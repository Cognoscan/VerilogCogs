module iirLowPassSinglePole_tb ();

reg clk = 1'b0;
reg rst = 1'b1;
reg signed [15:0] in = 'd0;
wire signed [15:0] out;

integer i;

always #1 clk = ~clk;
initial #5 rst = 1'b0;

initial begin
    for (i=0; i<2**16; i=i+1) begin
        @(posedge clk) in = $rtoi($sin(($itor(i)/2**8)**2 / (2*3.14159))*(2**15-1));
    end
    $stop;
end

iirLowPassSinglePole
#(
    .GAIN(8),
    .WIDTH(16)
) uut (
    .clk(clk),
    .rst(rst),
    .en(1'b1),
    .in(in),
    .out(out)
);

endmodule
