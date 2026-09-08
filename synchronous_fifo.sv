module synchronous_fifo(input clk , rst, 
                        input wr_en,rd_en, 
                        input[7:0]din, 
                        output reg[7:0]dout ,
                        output full,
                        output empty);
   
        reg[7:0]mem[0:3];
		reg[2:0]wr_ptr;
		reg[2:0]rd_ptr;
  assign empty = (wr_ptr == rd_ptr);
  assign full = (wr_ptr[2] != rd_ptr[2] && wr_ptr[1:0] == rd_ptr[1:0]);

always @(posedge clk or posedge rst)begin
  if(rst) begin wr_ptr <=0;
      			rd_ptr <=0;
      			dout <=0;    end
  // WRITE
  else if(wr_en && !full)begin
    mem[wr_ptr[1:0]] <= din;
    wr_ptr <= wr_ptr +1; end
  // READ
  else if(rd_en && !empty)begin
    dout <= mem[rd_ptr[1:0]];
     rd_ptr <= rd_ptr +1; 
  end
end
endmodule
module tb;
 reg clk, rst, wr_en,rd_en;
 reg [7:0]din;
 wire [7:0]dout;
wire full,empty;

sync_fifo dut(.*); //system verilog shortcut
always #5 clk=~clk;
initial begin
clk=0; rst=1; din=0; rd_en=0; wr_en=0;
#15 rst =0;
$monitor("Time=%0t | rst=%b | wr=%b rd=%b din=%h dout=%h | full=%b empty=%b", 
 $time, rst, wr_en, rd_en, din, dout, full, empty); 
   // WRITE till full depth-4
  @(negedge clk) wr_en=1; din =8'hAA;
  @(negedge clk) wr_en=1; din =8'hbb;
  @(negedge clk) wr_en=1; din=8'hCC;
  @(negedge clk) wr_en=1; din=8'hDD;
// OVERRIDE more than 4
  @(negedge clk) wr_en=1; din=8'hEE;
  @(negedge clk) wr_en=0;
  // READ till empty
  @(negedge  clk) rd_en=1; 
  @(negedge clk);
 @(negedge clk);
 @(negedge clk);
 #20 $finish;
 end        
 endmodule   
    
    
