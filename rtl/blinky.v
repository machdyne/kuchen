module blinky
#(
)
(

	input CLK_48,

	output LED,

	output PMOD_A1,
	output PMOD_A2,
	output PMOD_A3,
	output PMOD_A4,
	output PMOD_A7,
	output PMOD_A8,
	output PMOD_A9,
	output PMOD_A10,

	output PMOD_B1,
	output PMOD_B2,
	output PMOD_B3,
	output PMOD_B4,
	output PMOD_B7,
	output PMOD_B8,
	output PMOD_B9,
	output PMOD_B10,

);

	wire clk;
	wire clk10khz;

	assign clk = CLK_48;

	reg [31:0] counter = 0;

	assign PMOD_A1 = counter[31];
	assign PMOD_A2 = counter[30];
	assign PMOD_A3 = counter[29];
	assign PMOD_A4 = counter[28];
	assign PMOD_A7 = counter[27];
	assign PMOD_A8 = counter[26];
	assign PMOD_A9 = counter[25];
	assign PMOD_A10 = counter[24];

	assign PMOD_B1 = counter[31];
	assign PMOD_B2 = counter[30];
	assign PMOD_B3 = counter[29];
	assign PMOD_B4 = counter[28];
	assign PMOD_B7 = counter[27];
	assign PMOD_B8 = counter[26];
	assign PMOD_B9 = counter[25];
	assign PMOD_B10 = counter[24];

   reg [14:0] clk10khz_ctr; // approx
   wire clk10khz = clk10khz_ctr[14];

   always @(posedge clk) begin
		counter = counter + 1;
      clk10khz_ctr <= clk10khz_ctr + 1;
   end

   reg [12:0] led_counter = 0;
   assign LED = ~led_counter[8];

   always @(posedge clk10khz) begin
      led_counter <= led_counter + 1;
   end

endmodule
