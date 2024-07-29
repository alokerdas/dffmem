module mem16x16 (
    input clk,
    input rst,
    input [11:0] addr,
    input [15:0] din,
    output reg [15:0] dout,
    input cs,
    input we
);

  wire [15:0] outbuf[0:15];
  wire [15:0] adrDcod, rowclk;

  assign adrDcod[0] = ~addr[0] & ~addr[1] & ~addr[2] & ~addr[3];
  assign adrDcod[1] = addr[0] & ~addr[1] & ~addr[2] & ~addr[3];
  assign adrDcod[2] = ~addr[0] & addr[1] & ~addr[2] & ~addr[3];
  assign adrDcod[3] = addr[0] & addr[1] & ~addr[2] & ~addr[3];
  assign adrDcod[4] = ~addr[0] & ~addr[1] & addr[2] & ~addr[3];
  assign adrDcod[5] = addr[0] & ~addr[1] & addr[2] & ~addr[3];
  assign adrDcod[6] = ~addr[0] & addr[1] & addr[2] & ~addr[3];
  assign adrDcod[7] = addr[0] & addr[1] & addr[2] & ~addr[3];

  assign adrDcod[8] = ~addr[0] & ~addr[1] & ~addr[2] & addr[3];
  assign adrDcod[9] = addr[0] & ~addr[1] & ~addr[2] & addr[3];
  assign adrDcod[10] = ~addr[0] & addr[1] & ~addr[2] & addr[3];
  assign adrDcod[11] = addr[0] & addr[1] & ~addr[2] & addr[3];
  assign adrDcod[12] = ~addr[0] & ~addr[1] & addr[2] & addr[3];
  assign adrDcod[13] = addr[0] & ~addr[1] & addr[2] & addr[3];
  assign adrDcod[14] = ~addr[0] & addr[1] & addr[2] & addr[3];
  assign adrDcod[15] = addr[0] & addr[1] & addr[2] & addr[3];

  assign rowclk = adrDcod & {16{we}} & {16{cs}} & {16{clk}};

  memrow row0 (.clkp(rowclk[0]), .rstp(rst), .D16(din), .Q16(outbuf[0]));
  memrow row1 (.clkp(rowclk[1]), .rstp(rst), .D16(din), .Q16(outbuf[1]));
  memrow row2 (.clkp(rowclk[2]), .rstp(rst), .D16(din), .Q16(outbuf[2]));
  memrow row3 (.clkp(rowclk[3]), .rstp(rst), .D16(din), .Q16(outbuf[3]));
  memrow row4 (.clkp(rowclk[4]), .rstp(rst), .D16(din), .Q16(outbuf[4]));
  memrow row5 (.clkp(rowclk[5]), .rstp(rst), .D16(din), .Q16(outbuf[5]));
  memrow row6 (.clkp(rowclk[6]), .rstp(rst), .D16(din), .Q16(outbuf[6]));
  memrow row7 (.clkp(rowclk[7]), .rstp(rst), .D16(din), .Q16(outbuf[7]));

  memrow row8 (.clkp(rowclk[8]), .rstp(rst), .D16(din), .Q16(outbuf[8]));
  memrow row9 (.clkp(rowclk[9]), .rstp(rst), .D16(din), .Q16(outbuf[9]));
  memrow row10 (.clkp(rowclk[10]), .rstp(rst), .D16(din), .Q16(outbuf[10]));
  memrow row11 (.clkp(rowclk[11]), .rstp(rst), .D16(din), .Q16(outbuf[11]));
  memrow row12 (.clkp(rowclk[12]), .rstp(rst), .D16(din), .Q16(outbuf[12]));
  memrow row13 (.clkp(rowclk[13]), .rstp(rst), .D16(din), .Q16(outbuf[13]));
  memrow row14 (.clkp(rowclk[14]), .rstp(rst), .D16(din), .Q16(outbuf[14]));
  memrow row15 (.clkp(rowclk[15]), .rstp(rst), .D16(din), .Q16(outbuf[15]));

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

      'd8: dout = outbuf[8];
      'd9: dout = outbuf[9];
      'd10: dout = outbuf[10];
      'd11: dout = outbuf[11];
      'd12: dout = outbuf[12];
      'd13: dout = outbuf[13];
      'd14: dout = outbuf[14];
      'd15: dout = outbuf[15];

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
