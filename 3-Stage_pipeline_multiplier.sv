module multiplier_pipeline(input clk ,rst, 
                  input[7:0]A,B,C,D,
                  output reg[15:0]result);
  reg[15:0]pp1,pp2,pp3,pp4;
  reg[15:0]sum1;
  reg[15:0]sum2;
     // Stage-1 
  always@(posedge clk or posedge rst)begin
    if(rst) begin
           pp1 <=0;
           pp2<=0;
           pp3 <=0;
      pp4<=0; end       
       else begin
         pp1 <= (A[3:0] * B[3:0]);
         pp2 <= (A[7:4] * B[3:0]);
         pp3 <= (A[3:0] * B[7:4]);
         pp4 <= (A[7:4] * B[7:4]);
       end 
       end  
      // Stage First-level addition
    always @(posedge clk or posedge rst)begin
      if(rst)begin
          sum1 <=0;
        sum2 <=0;  end
  else begin //Jitne bits ka chunk banaya, utne hi bits shift karne padte hain.
          sum1 <= pp1 + (pp2 <<4);
          sum2 <= pp3 + (pp4 <<4);
        end  
    end      
   // Stage-3 Final addition 
always @(posedge clk or posedge rst)begin
  if(rst)begin
       result <=0;
  end
     else begin
       result <= sum1 + (sum2 << 4);
     end 
     end
  endmodule
          
