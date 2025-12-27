
module tb;
  reg clk;
    reg reset;
    reg [7:0] data;
    reg transmit;
    wire txd;
    wire busy;
   
 transmitter  #(
   .clk_freq(100000000),
   .baud_rate(9600)
 ) uut(
   .clk(clk),
   .reset(reset),
   .data(data),
   .transmit(transmit),
   .txd(txd),
   .busy(busy)
);
  
  initial begin 
    clk<=0;
    $monitor("time=%0t,txd=%0h,busy=%0d",$time,uut.txd,busy);
  end
  
  always #5 clk<=~clk;
  
  integer file;
  
  initial begin 
    rst();
    #10
    send();
    wait(busy);
    wait(!busy);
    
   #500
    $finish;
  
  end
  task rst;
    begin 
    reset<=1;
      @(posedge clk)
    reset<=0;
    end
  endtask
  
  task send;
    begin 
      data=8'h32;
      transmit<=1;
      @(posedge clk)
      transmit<=0;
    
    end
  endtask
  
  
endmodule
