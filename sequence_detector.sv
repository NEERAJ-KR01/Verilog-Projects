module sequence_detector #(parameter W=4, parameter [W-1:0]SEQ=4'b1011)
           (input clk , rst ,input logic din , output reg detect);
           
          reg[W-1:0]shift_reg; 
               always_ff@(posedge clk or posedge rst)begin
     if(rst)begin
             shift_reg <= 0;
             detect = 1'b0;  end
            else  begin  shift_reg <= {shift_reg[W-2:0], din};
               if ({shift_reg[2:0],din}  == SEQ) //1011 == 1011
                       detect <= 1'b1;    // similar to counter
                    else detect <= 1'b0; 
           end
           end
           endmodule
