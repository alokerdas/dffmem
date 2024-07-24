`default_nettype none
`timescale 1ns / 1ps

module testbench;

  reg ck, rs, rw;
  reg [15:0] datin;
  wire [7:0] cntrloe;
  wire [15:0] datut;

  initial begin
    $display($time,"                 di do");
    $monitor($time," THE ANSWER IS = %h %h", datin, datut);

    ck = 1'b0; rs = 1'b1; datin = 0;
    #5 rs = 1'b0;
    #30 rs = 1'b1;
    #50 mem0.adrforce = 3'h3; mem0.weforce = 0;
    #50 datin = 16'h1253;
    #20 mem0.weforce = 1;
    #100 $finish;
  end 

`ifdef DUMP_VCD
  initial begin
    $dumpfile("mem.vcd");
    $dumpvars(0, testbench);
  end 
`endif

  always
    #10 ck = ~ck;

  tt_um_mem mem0 (
`ifdef USE_POWER_PINS
      .VPWR(1'b1),
      .VGND(1'b0),
`endif
    .ui_in(datin[7:0]),    // Dedicated inputs
    .uo_out(datut[7:0]),   // Dedicated outputs
    .uio_in(datin[15:8]),   // IOs: Input path
    .uio_out(datut[15:8]),  // IOs: Output path
    .uio_oe(cntrloe),   // IOs: Enable path (active high: 0=input, 1=output)
    .ena(1'b1),      // always 1 when the design is powered, so you can ignore it
    .clk(ck),      // clock
    .rst_n(rs)     // reset_n - low to reset
);
endmodule
