// Logic gates design
module gates (input wire [4:0] a,b, output wire [4:0] y);

    assign y[0] = a[0]   & b[0];
    assign y[1] = a[1]   | b[1];
    assign y[2] =        ~a[2];
    assign y[3] = ~(a[3] & b[3]);
    assign y[4] = ~(a[4] | b[4]);

endmodule : gates


// testbench
module tb_gates;

    reg  [4:0] a, b;
    wire [4:0] y;
    integer i;

    gates dut_inst(a,b,y);

    initial begin
	a = 5'b0;
        b = 5'b0;
      
        for (i = 0; i < 5; i = i + 1) begin
            #5 a = $random;
               b = $random;
    	    $display("a[%0d] = %0d\nb[%0d] = %0d\n---------\ny[%0d] = %0d\n",i,a[i],i, b[i],i, y[i]);
        end
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,gates);

	#30 $finish;
    end

endmodule
