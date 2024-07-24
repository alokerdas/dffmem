module mem8x16 (
    input clk,
    input rst,
    input [11:0] addr,
    input [15:0] din,
    output reg [15:0] dout,
    input cs,
    input we
);

  wire [15:0] outbuf[0:7];
  wire [7:0] adrDcod, rowclk;

  assign adrDcod[0] = ~addr[0] & ~addr[1] & ~addr[2];
  assign adrDcod[1] = addr[0] & ~addr[1] & ~addr[2];
  assign adrDcod[2] = ~addr[0] & addr[1] & ~addr[2];
  assign adrDcod[3] = addr[0] & addr[1] & ~addr[2];
  assign adrDcod[4] = ~addr[0] & ~addr[1] & addr[2];
  assign adrDcod[5] = addr[0] & ~addr[1] & addr[2];
  assign adrDcod[6] = ~addr[0] & addr[1] & addr[2];
  assign adrDcod[7] = addr[0] & addr[1] & addr[2];

  assign rowclk = adrDcod & {8{we}} & {8{cs}} & {8{clk}};

  memrow row0 (.clkp(rowclk[0]), .rstp(rst), .D16(din), .Q16(outbuf[0]));
  memrow row1 (.clkp(rowclk[1]), .rstp(rst), .D16(din), .Q16(outbuf[1]));
  memrow row2 (.clkp(rowclk[2]), .rstp(rst), .D16(din), .Q16(outbuf[2]));
  memrow row3 (.clkp(rowclk[3]), .rstp(rst), .D16(din), .Q16(outbuf[3]));
  memrow row4 (.clkp(rowclk[4]), .rstp(rst), .D16(din), .Q16(outbuf[4]));
  memrow row5 (.clkp(rowclk[5]), .rstp(rst), .D16(din), .Q16(outbuf[5]));
  memrow row6 (.clkp(rowclk[6]), .rstp(rst), .D16(din), .Q16(outbuf[6]));
  memrow row7 (.clkp(rowclk[7]), .rstp(rst), .D16(din), .Q16(outbuf[7]));

  always @* begin
    case (addr)
      'd0: dout = outbuf[0];
      'd1: dout = outbuf[1];
      'd2: dout = outbuf[2];
      'd3: dout = outbuf[3];
      'd4: dout = outbuf[4];
      'd5: dout = outbuf[5];
      'd6: dout = outbuf[6];
      'd7: dout = outbuf[7];

      default: dout = 16'hxxxx;
    endcase
  end

endmodule

module memrow (
    input clkp,
    input rstp,
    input [15:0] D16,
    output reg [15:0] Q16
  );

  always @ (posedge clkp or posedge rstp) begin
    if (rstp) begin
      Q16 <= 16'h0000;
    end else begin
      Q16 <= D16;
    end
  end

endmodule
