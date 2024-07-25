/*
 * tt_um_mem.v
 *
 * Memory made of DFF
 *
 * Author: Sylvain Munaut <tnt@246tNt.com>
 */

`default_nettype none

module tt_um_mem (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  reg rst_n_i, weforce;
  reg [11:0] adrforce;
  wire [15:0] datin, datut;

  assign uio_oe = 8'hF0; // Lower nibble all input, Upper all output
  assign datin = {ui_in, uio_in};
  assign {uo_out, uio_out} = datut;

  always @(posedge clk or negedge rst_n)
    if (~rst_n) rst_n_i <= 1'b0;
    else rst_n_i <= 1'b1;

  always @(*) begin
    if (~rst_n) begin
      adrforce = datin[11:0];
    end
  end

  always @(*) begin
    if (~rst_n) begin
      weforce = datin[12];
    end
  end

  mem8x16 mem0 (
    .clk(clk),
    .rst(~rst_n_i),
    .addr(adrforce),
    .din(datin),
    .dout(datut),
    .cs(1'b1),
    .we(weforce)
  );

  // avoid linter warning about unused pins:
  wire _unused_pins = ena;

endmodule  // tt_um_mem
