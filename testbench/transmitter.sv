`timescale 1ns / 1ps

module tb;
    parameter CLK_FREQ  = 100_000_000;
    parameter BAUD_RATE = 9600;
    localparam CLK_PERIOD = 10;
    
    reg clk;
    reg reset;
    reg [7:0] data;
    reg transmit;
    wire txd;
    wire busy;

    transmitter #(
        .clk_freq(CLK_FREQ),
        .baud_rate(BAUD_RATE)
    ) uut (
        .clk(clk),
        .reset(reset),
        .data(data),
        .transmit(transmit),
        .txd(txd),
        .busy(busy)
    );

    initial clk = 0;
    always #(CLK_PERIOD/2) clk = ~clk;

    initial begin
        $display("Starting UART Transmitter Testbench...");
        $monitor("Time=%0t | txd=%b | busy=%b", $time, txd, busy);
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        reset = 0;
        transmit = 0;
        data = 8'h00;

        apply_reset();
        send_byte(8'h22);
        
        send_byte(8'hA5);

        #1000;
        $display("Testbench complete.");
        $finish;
    end

    task apply_reset;
        begin
            @(negedge clk);
            reset = 1;
            repeat(5) @(posedge clk);
            reset = 0;
            repeat(2) @(posedge clk);
            $display("--- Reset Applied ---");
        end
    endtask

    task send_byte(input [7:0] d_in);
       $display("--- Sending Data: 0x%h ---", d_in);  
      begin
            wait(!busy); 
            @(posedge clk);
            data = d_in;
            transmit = 1;
            @(posedge clk);
            transmit = 0;
           
            
            wait(busy);
            wait(!busy);
        end
    endtask

endmodule
