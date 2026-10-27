module phase_difference
(input  logic clk,
 input  logic ref_clk,
 input  logic mon_clk,
 output logic meas_clk,
 input  logic en_ref_clk,
 input  logic en_mon_clk,
 output logic en_meas_clk
);

	timeunit 1ns; timeprecision 1ns;
	
	// declare previous clock samples
	logic ref_prev;
	logic mon_prev;
 
	always_ff @(posedge clk) begin
	
	// only measure if both clocks are enabled
	en_meas_clk <= en_ref_clk && en_mon_clk;
		if (en_meas_clk == 1)
			begin
			if (!ref_prev && ref_clk) meas_clk <= 1;
			else if (!mon_prev && mon_clk) meas_clk <= 0;
			end
		else if (en_meas_clk == 0) meas_clk <= 0;

		// save previous inputs
		ref_prev <= ref_clk;
		mon_prev <= mon_clk;
	end
endmodule: phase_difference