module sdDac_tb ();

reg clk = 1'b0;
reg rst = 1'b1;
reg [15:0] in = 0;
wire dac;

always #1 clk = ~clk;
initial #4 rst = 1'b0;

always @(posedge clk) in <= in + 1;

sdDac #(
    .WIDTH(16)
) uut (
    .clk(clk),
    .rst(rst),
    .in(in),
    .dac(dac)
);

endmodule
