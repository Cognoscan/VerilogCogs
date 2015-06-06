module servo
#(
    parameter WIDTH = 16, ///< Width of position word. Should be 2-16 bits
    parameter NUM = 1     ///< Number of servos to drive
) (
    input clk50Mhz,                   ///< Built around a 50 MHz clock
    input rst,                        ///< Reset, active high
    input [(WIDTH*NUM)-1:0] posArray, ///< Flattened position array
    output reg [NUM-1:0] pwm          ///< PWM for hobby servos
);

wire [WIDTH-1:0] posArrayInternal[NUM-1:0];

reg [19:0] counter;

integer i;
genvar j;

// Create internal array of positions
generate
begin
    for (j=0; j<NUM; j=j+1) begin
        assign posArrayInternal[j] = posArray[(WIDTH*(j+1)-1):(WIDTH*j)];
    end
end
endgenerate

// PWM based on single timer
always @(posedge clk50Mhz) begin
    if (rst) begin
        counter <= 'd0;
        pwm <= 'b0;
    end else begin
        counter <= counter + 1;
        for (i=0; i<NUM; i=i+1) begin
            // 42232 centers PWM on 1.5ms when pos is half of full possible value
            // Shift if necessary so that the pos word always creates PWM between 1-2 ms
            if (((posArrayInternal[i] << (16-WIDTH)) + 42232) > counter)
                pwm[i] <= 1'b1;
            else
                pwm[i] <= 1'b0;
        end
    end
end

endmodule
