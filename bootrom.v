module bootrom (
`ifdef USE_POWER_PINS
  inout vccd1,
  inout vssd1,
`endif
  input clk,
  input rst,
  input cs,
  input we,
  input [2:0] addr,
  output reg [15:0] dout
);

  reg [15:0] outbuf0;
  reg [15:0] outbuf1;
  reg [15:0] outbuf2;
  reg [15:0] outbuf3;
  reg [15:0] outbuf4;
  reg [15:0] outbuf5;
  reg [15:0] outbuf6;
  reg [15:0] outbuf7;
  reg [15:0] dout_internal;
  wire romclk;

  assign romclk = clk & 1'b0;
  always @ (posedge romclk or posedge rst) begin
    if (rst) begin
      outbuf0 <= 16'hF200;
    end else begin
      outbuf0 <= 0;
    end
  end
  always @ (posedge romclk or posedge rst) begin
    if (rst) begin
      outbuf1 <= 16'h4000;
    end else begin
      outbuf1 <= 0;
    end
  end
  always @ (posedge romclk or posedge rst) begin
    if (rst) begin
      outbuf2 <= 16'hF800;
    end else begin
      outbuf2 <= 0;
    end
  end
  always @ (posedge romclk or posedge rst) begin
    if (rst) begin
      outbuf3 <= 16'hF400;
    end else begin
      outbuf3 <= 0;
    end
  end
  always @ (posedge romclk or posedge rst) begin
    if (rst) begin
      outbuf4 <= 16'hB008;
    end else begin
      outbuf4 <= 0;
    end
  end
  always @ (posedge romclk or posedge rst) begin
    if (rst) begin
      outbuf5 <= 16'h4000;
    end else begin
      outbuf5 <= 0;
    end
  end
  always @ (posedge romclk or posedge rst) begin
    if (rst) begin
      outbuf6 <= 16'h4000;
    end else begin
      outbuf6 <= 0;
    end
  end
  always @ (posedge romclk or posedge rst) begin
    if (rst) begin
      outbuf7 <= 16'h0008;
    end else begin
      outbuf7 <= 0;
    end
  end

  always @* begin
    case (addr)
      'd0: dout_internal = outbuf0;
      'd1: dout_internal = outbuf1;
      'd2: dout_internal = outbuf2;
      'd3: dout_internal = outbuf3;
      'd4: dout_internal = outbuf4;
      'd5: dout_internal = outbuf5;
      'd6: dout_internal = outbuf6;
      'd7: dout_internal = outbuf7;
      default: dout_internal = 16'hzzzz;
    endcase
  end
  always_latch begin
    if (~we & cs) begin
      dout = dout_internal;
    end
  end

endmodule
