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
    
    
