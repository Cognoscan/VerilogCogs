module servo_tb ();

reg clk50Mhz = 1'b0;
reg rst = 1'b1;
reg [15:0] pos = 'd0;
wire [0:0] pwm;

always #10 clk50Mhz = ~clk50Mhz;
initial begin
    @(posedge clk50Mhz);
    @(posedge clk50Mhz);
    rst = 1'b0;
end

servo #(
    .WIDTH(16),
    .NUM(1)
) uut (
    .clk50Mhz(clk50Mhz),
    .rst(rst),
    .posArray(pos),
    .pwm(pwm)
);

endmodule
