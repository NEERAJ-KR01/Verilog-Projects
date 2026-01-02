`timescale 1ns / 1ps
module generic_mux #(parameter in=4 , parameter data= 8 )(
input [(in*data)-1:0]flattened_input,
input [$clog2(in)-1:0]sel, output [data-1:0]out);
assign out= flattened_input[(sel*data)+:data]; //Magic Line
 endmodule 

module tb;
parameter N=4; parameter W=8;
reg[(N*W)-1:0]inputs;
reg[($clog2(N)*W)-1:0]sel;
wire[W-1:0]out;
generic_mux dut(.flattened_input(inputs),.sel(sel),.out(out));
initial begin
$monitor("Time:%0t | Sel:%d | output:%h",$time,sel,out);
inputs={8'hDD,8'hCC,8'hBB,8'hAA};
 sel=0; #10;
  sel=1; #10;
 sel=2; #10;
 sel=3; #10;
 $stop;
end
endmodule
