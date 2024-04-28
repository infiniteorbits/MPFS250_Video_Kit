
//simplified axi4 wrapper
module axi4_ram 
  #(
    parameter AXI_ADDR_WIDTH=64,
    parameter AXI_DATA_WIDTH=32, 
    parameter   AXI_ID_WIDTH= 4
)
   
(
input                      sys_clk_i,
input                      resetn_i,
//write address channel
input  [AXI_ADDR_WIDTH-1:0]  awaddr,
input  [AXI_ID_WIDTH-1:0]    awid,
input  [7:0]                 awlen,
input                        awvalid,
output                       awready,
//write data channel
input  [AXI_DATA_WIDTH-1:0]  wdata,
input                        wvalid,
input                        wlast,
output                       wready,
//write response channel
input                        bready,
output [AXI_ID_WIDTH-1:0]    bid,
output [1:0]                 bresp,
output reg                   bvalid,
//read address channel
input  [AXI_ADDR_WIDTH-1:0]  araddr,
input  [AXI_ID_WIDTH-1:0]    arid,
input  [7:0]                 arlen,
input                        arvalid,
output                       arready,
//read response channel
input                        rready,
output [AXI_ID_WIDTH-1:0]    rid,
output [AXI_DATA_WIDTH-1:0]  rdata,
output reg                   rvalid,
output reg                   rlast,
output [1:0]                 rresp
);

reg    [AXI_ADDR_WIDTH-1:0]  waddr;
reg    [AXI_ADDR_WIDTH-1:0]  raddr;
reg                          ren;

assign awready = 1;
assign wready  = 1;
assign bid     = awid;
assign bresp   = 0;
assign arready = 1;
assign rid     = arid;
assign rresp   = 0;



function [31:0] addr_log;
   input integer x;
   integer tmp, res;
   begin
      tmp = 1;
      res = 0;
      while(tmp < x) begin
         tmp = tmp * 2;
         res = res + 1;
      end
      addr_log = (res>0) ? res : 1;
   end
endfunction

parameter SLICE = addr_log(AXI_DATA_WIDTH/8) ;


//write address channel
always@(posedge sys_clk_i, negedge resetn_i)
  if (!resetn_i)
    waddr <= 0;
  else if (awvalid)
  waddr <= awaddr[AXI_ADDR_WIDTH-1:SLICE];
  else if (wvalid)
    waddr <= waddr + 1;
    
//write response channel
initial
begin
  bvalid = 0;
  forever@(posedge wlast)
  begin
    @(posedge sys_clk_i);
    bvalid = 1;
    @(posedge sys_clk_i);
    wait(bready);
    bvalid = 0;
  end
end  
  
//read address channel
always@(posedge sys_clk_i, negedge resetn_i)
  if (!resetn_i)
    raddr <= 0;
  else if (arvalid)
  raddr <= araddr[AXI_ADDR_WIDTH-1:SLICE];
  else if (ren)
    raddr <= raddr + 1;
    
//read response channel
always@(posedge sys_clk_i, negedge resetn_i)
begin
  if (!resetn_i)
    rvalid  <= 0;
  else
    rvalid  <= ren;  
end
initial
begin
  ren   = 0;
  rlast = 0;
  forever@(posedge arvalid)
  begin
    wait(rready);    
    repeat(arlen+1)
    begin
      @(posedge sys_clk_i);
      ren = 1;
    end
    @(posedge sys_clk_i);
    ren   = 0;
    rlast = 1;
    wait(rready); 
    @(posedge sys_clk_i);
    rlast = 0;
  end
end
  
//ram instantiation
mem_module
 #(
   .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
   .AXI_DATA_WIDTH(AXI_DATA_WIDTH)
  )
 mem_module_0
  (
   .CLK(sys_clk_i),
   .W_EN(wvalid),
   .W_ADDR (waddr),
   .W_DATA (wdata),
   .R_EN   (ren),
   .R_ADDR (raddr),
   .R_DATA (rdata)
  );
  
endmodule //axi4 wrapper

//memory model
module mem_module
  #(
    parameter AXI_ADDR_WIDTH=64,
    parameter AXI_DATA_WIDTH=64)
   (
    input CLK,    
    input W_EN,
    input [AXI_ADDR_WIDTH-1:0] W_ADDR,
    input [AXI_DATA_WIDTH-1:0] W_DATA,
    input R_EN,
    input [AXI_ADDR_WIDTH-1:0] R_ADDR,
    output reg [AXI_DATA_WIDTH-1:0] R_DATA
    );
    
   logic [AXI_DATA_WIDTH-1:0] mem[*];
   
   always @(posedge CLK)
     if (W_EN)
       mem[W_ADDR] = W_DATA;

   always @(posedge CLK)
     if (R_EN)
       R_DATA <= mem[R_ADDR];
   
endmodule // mem_module

