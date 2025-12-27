`timescale 1ns/1ps
module tb;
  reg clk;
  reg rst;
  reg rxd;
  wire [7:0] rxddata;
  wire rdone;
  
  receiver uut(
    .clk(clk),
    .rst(rst),
    .rxd(rxd),
    .rxddata(rxddata), 
    .rdone(rdone)
  );

  reg [7:0]char_in; 
  integer i;
  integer file;
  
  initial clk = 0;
  always #5 clk = ~clk;
  
  initial begin
    rxd = 1; 
    reset(); 
  
    
    file = $fopen("mem.txt", "rb"); 
    if (file == 0) begin
        $display("Error: Could not open file");
        $finish;
    end
    
  
    while (!$feof(file)) begin
      $fscanf(file, "%b", char_in); 
    end 
        #10;
      
        rxd = 0;               
        #104160;
        
        for (i = 0; i < 8; i = i + 1) begin
          rxd = char_in[i];    
          #104160;
        end
        
        rxd = 1;               
        #104160             
      
    $fclose(file);
    $display("Finished sending binary file:%0h.",rxddata);
    $finish;
  end

  task reset;
    begin
      rst = 1;
      repeat(2) @(posedge clk);
      rst = 0;
    end
  endtask

endmodule

